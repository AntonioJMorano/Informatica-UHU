# -*- coding: utf-8 -*-
"""
Created on Wed May 16 00:26:46 2023

@author: anton
"""

import random 
import math
import numpy as np
import matplotlib.pyplot as plt
import time

rutaC130 = "./DatosTSP/ch130.tsp"
rutaA280 = "./DatosTSP/a280.tsp"

#10,15,50,100,200
random.seed(10)

def leer_datos_tsp(nombre_archivo):
    coordenadas = []
    with open(nombre_archivo, 'r') as archivo:
        for _ in range(6):
            next(archivo)
        linea = archivo.readline().strip()
        while linea != 'EOF':
            valores = linea.split()
            x = float(valores[1])
            y = float(valores[2])
            coordenadas.append((x, y))
            linea = archivo.readline().strip()
    return coordenadas
CoordC130 = leer_datos_tsp(rutaC130)
CoordA280 = leer_datos_tsp(rutaA280)

def DistanciaE(coord1, coord2):
    x1, y1 = coord1
    x2, y2 = coord2
    distancia = np.sqrt((x2 - x1)**2 + (y2 - y1)**2)
    return round(distancia)
  
def MatrizCostes(coordenadas):
    nCiudades = len(coordenadas)
    matriz_costes = np.zeros((nCiudades, nCiudades))
    
    for i in range(nCiudades):
        for j in range(nCiudades):
            if(i!=j):
                distancia = DistanciaE(coordenadas[i], coordenadas[j])
                matriz_costes[i][j] = distancia   
            else:
                matriz_costes[i][j] = 0.0
    return matriz_costes

mCostesC130 = MatrizCostes(CoordC130)
mCostesA280 = MatrizCostes(CoordA280)

def costeCamino(mCostes, camino):
    costeTotal = 0
    nCiudades = len(camino)
    
    for i in range(nCiudades):
        ciudadAct = camino[i]
        ciudadSig = camino[(i + 1) % nCiudades]  # Se utiliza el operador módulo para cerrar el ciclo del camino
        
        coste = mCostes[ciudadAct][ciudadSig]
        costeTotal += coste
    
    return costeTotal
def solGreedy(coordenadas):
    nCiudades = len(coordenadas)
    visitados = [False] * nCiudades
    camino = []    
    ciudadAct = 0
    camino.append(ciudadAct)
    visitados[ciudadAct] = True
    
    # Convertir las coordenadas en arrays de NumPy
    coordenadas = np.array(coordenadas)
    
    # Construir el camino greedy
    while len(camino) < nCiudades:
        dMin = float('inf')
        ciudadSig = -1
        
        # Encontrar la ciudad no visitada más cercana a la ciudad actual
        for i in range(nCiudades):
            if not visitados[i]:
                d = np.linalg.norm(coordenadas[ciudadAct] - coordenadas[i])
                if d < dMin:
                    dMin = d
                    ciudadSig = i
        
        # Marcar la ciudad como visitada y agregarla al camino
        visitados[ciudadSig] = True
        camino.append(ciudadSig)
        ciudadAct = ciudadSig
    
    return camino

def plotCamino(coordenadas, camino, Alg, problema):
    x = [coordenadas[i][0] for i in camino]
    y = [coordenadas[i][1] for i in camino]
    
    # Agregar la primera ciudad al final del camino para cerrar el ciclo
    x.append(x[0])
    y.append(y[0])
    
    # Graficar el camino
    plt.plot(x, y, marker='o', linestyle='-')
    plt.xlabel('Coordenada X')
    plt.ylabel('Coordenada Y')
    titulo = "Camino TSP " + Alg + " : " + problema
    plt.title(titulo)
    plt.grid(True)
    plt.show()

def plotEvolCoste(mejoresCostes, Alg, problema):
    plt.plot(mejoresCostes)
    plt.xlabel('N Iteraciones')
    plt.ylabel('Coste Camino')
    titulo = "Costes Mejores caminos " + Alg + " : " + problema
    plt.title(titulo)
    plt.show()
    
# caminoGreedy = solGreedy(CoordC130)
# print(costeCamino(mCostesC130,caminoGreedy))
# plotCamino(CoordC130,caminoGreedy)
   
"""Hormigas"""
def tspSH(matrizDistancias, nHormigas, tMax, alpha, beta, rho, Q, problema):
    nCiudades = matrizDistancias.shape[0]
    nEvals=0
    if problema == 0:
        caminoGreedy = solGreedy(CoordC130)
        L = costeCamino(mCostesC130,caminoGreedy)  
    else:
        caminoGreedy = solGreedy(CoordA280)
        L = costeCamino(mCostesA280,caminoGreedy)         
         
    nEvals = 0
    feromonas = np.ones((nCiudades, nCiudades)) * (1 / (nCiudades * L ))
    # feromonas = np.ones((nCiudades, nCiudades)) #Exp sobre evolucion mejor coste
    solMejor = None
    costeMejor = np.inf
    tIni = time.time()    
    mejorCoste = []
    
    while (time.time() - tIni) < tMax:
        soluciones = []
        costes = []
        
        for _ in range(nHormigas):
            solucion = SimulaCamino(matrizDistancias, feromonas, alpha, beta)
            coste = costeCamino(matrizDistancias, solucion)
            nEvals +=1
            
            if coste < costeMejor:
                solMejor = solucion
                costeMejor = coste                
            
            mejorCoste.append(costeMejor)
            soluciones.append(solucion)
            costes.append(coste)
        
        ActualizarFeromonas(feromonas, soluciones, costes, rho, Q)
    
    return solMejor, costeMejor ,nEvals , mejorCoste

def ProbabilidadesCiudades(matrizDistancias, feromonas, solucion_actual, por_visitar, alpha, beta):
    ciudad_actual = solucion_actual[-1]
    probabilidades = []
    

    for ciudad in por_visitar:
        feromona = feromonas[ciudad_actual, ciudad]
        distancia = matrizDistancias[ciudad_actual, ciudad]
        
        if distancia == 0:
            probabilidad = 0.0 
        else:
            probabilidad = (feromona ** alpha) * ((1.0 / distancia) ** beta)
        
        probabilidades.append(probabilidad)
    
    suma_probabilidades = sum(probabilidades)
    
    if suma_probabilidades == 0:
        probabilidades_normalizadas = [1.0 / len(probabilidades)] * len(probabilidades)  # Asignar una probabilidad uniforme si la suma es cero
    else:
        probabilidades_normalizadas = [p / suma_probabilidades for p in probabilidades]
            
    return probabilidades_normalizadas


def SimulaCamino(matrizDistancias, feromonas, alpha, beta):
    nCiudades = matrizDistancias.shape[0]
    porVisitar = set(range(nCiudades))
    solucion_actual = [random.choice(list(porVisitar))]  # Convertimos el conjunto a una lista para poder hacer una selección aleatoria
    
    while porVisitar:
        probabilidad_transicion = ProbabilidadesCiudades(matrizDistancias, feromonas, solucion_actual, porVisitar, alpha, beta)
        siguiente_ciudad = random.choices(list(porVisitar), weights=probabilidad_transicion)[0]  # Seleccionamos la siguiente ciudad aleatoriamente
        
        solucion_actual.append(siguiente_ciudad)
        porVisitar.remove(siguiente_ciudad)
    
    return solucion_actual

def ActualizarFeromonas(feromonas, soluciones, costes, rho, Q):
    feromonas *= (1 - rho)  # Evaporación global de feromonas
    
    for solucion, coste in zip(soluciones, costes):
        for i in range(len(solucion) - 1):
            ciudad_actual = solucion[i]
            ciudadSig = solucion[i + 1]
            feromonas[ciudad_actual, ciudadSig] += Q / coste
            feromonas[ciudadSig, ciudad_actual] += Q / coste
            
            
# print(tspSH(MatrizCostes(CoordC130), 30, 100, 1, 2, 0.1, 1))

"""Hormigas Elitistas"""
def tspSH_elitista(matrizDistancias, nHormigas, tMax, alpha, beta, rho, Q, nElite,problema):
    nCiudades = matrizDistancias.shape[0]
    if problema == 0:
        caminoGreedy = solGreedy(CoordC130)
        L = costeCamino(mCostesC130,caminoGreedy)  
    else:
        caminoGreedy = solGreedy(CoordA280)
        L = costeCamino(mCostesA280,caminoGreedy)  
        
    feromonas = np.ones((nCiudades, nCiudades)) * (1 / (nCiudades * L ))
    # feromonas = np.ones((nCiudades, nCiudades))  #Exp sobre evolucion mejor coste
    solMejor = None
    costeMejor = np.inf
    tIni = time.time()
    nEvals = 0
    mejoresCostes = []
    
    while (time.time() - tIni) < tMax:
        soluciones = []
        costos = []
        
        for _ in range(nHormigas):
            solucion = SimulaCamino(matrizDistancias, feromonas, alpha, beta)
            costo = costeCamino(matrizDistancias, solucion)
            nEvals+=1
            
            if costo < costeMejor:
                solMejor = solucion
                costeMejor = costo
            
            mejoresCostes.append(costeMejor)
            soluciones.append(solucion)
            costos.append(costo)
           
        # ActualizarFeromonas(feromonas, soluciones, costos, rho, Q)
        elitismo = soluciones
        elitismo[0:nElite] = SolucionesElite(soluciones, costos, nElite)
        ActualizarFeromonas(feromonas, elitismo, costos, rho, Q)
    
    return solMejor, costeMejor, nEvals , mejoresCostes

def SolucionesElite(soluciones, costos, nElite):
    orden = np.argsort(costos)
    elitismo = [soluciones[i] for i in orden[:nElite]]
    return elitismo

print("RESULTADOS Ch130: ")
print("---------------------------------------------------")
print("GREEDY")
caminoG = solGreedy(CoordC130)
costeG = costeCamino(mCostesC130, caminoG)
print("Mejor coste encontrado-> ", costeG)
print("N evaluaciones efectuadas-> ", 1)
plotCamino(CoordC130,caminoG,'GREEDY','ch130')

print("HORMIGAS ELITE")
camino1, coste1 , nEvals1 , graficar1 = tspSH_elitista(mCostesC130, 30, 180, 1, 2, 0.1, 1, 15,0)
print("Mejor coste encontrado-> ", coste1)
print("N evaluaciones efectuadas-> ",nEvals1)
plotCamino(CoordC130, camino1, 'SHE' , 'Ch130')
plotEvolCoste(graficar1, 'SHE' , 'Ch130')

print("HORMIGAS SIN ELITE")
camino2, coste2 , nEvals2 , graficar2 = tspSH(mCostesC130, 30, 180, 1, 2, 0.1, 1,0)
print("Mejor coste encontrado-> ", coste2)
print("N evaluaciones efectuadas-> ",nEvals2)
plotCamino(CoordC130, camino2, 'SH' , 'Ch130')
plotEvolCoste(graficar2,'SH' , 'Ch130')

print("---------------------------------------------------")

print("RESULTADOS A280: ")
print("---------------------------------------------------")
print("GREEDY")
caminoG2 = solGreedy(CoordA280)
costeG2 = costeCamino(MatrizCostes(CoordA280), caminoG2)
print("Mejor coste encontrado-> ", costeG2)
print("N evaluaciones efectuadas-> ", 1)
plotCamino(CoordA280,caminoG2,'GREEDY','A280')

print("HORMIGAS ELITE")
camino1a, coste1a , nEvals1a ,graficar1a = tspSH_elitista(mCostesA280, 30, 480, 1, 2, 0.1, 1, 15,1)
print("Mejor coste encontrado-> ", coste1a)
print("N evaluaciones efectuadas-> ",nEvals1a)
plotCamino(CoordA280, camino1a,'SHE' , 'A280')
plotEvolCoste(graficar1a,'SHE' , 'A280')

print("HORMIGAS SIN ELITE")
camino2a, coste2a , nEvals2a , graficar2a= tspSH(mCostesA280, 30, 480, 1, 2, 0.1, 1,1)
print("Mejor coste encontrado-> ", coste2a)
print("N evaluaciones efectuadas-> ",nEvals2a)
plotCamino(CoordA280, camino2a,'SH' , 'A280')
plotEvolCoste(graficar2a,'SH' , 'A280')
print("---------------------------------------------------")






