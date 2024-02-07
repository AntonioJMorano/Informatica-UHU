# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 01:59:20 2023

@author: anton
"""
import random as rnd
import numpy as np
import math
import matplotlib.pyplot as plt
#10,50,100
rnd.seed(100)
#Parametros 
pobIni = 30
probMutacion = 0.05
maxIters = 5000
tamElite = 5
tamTorneo = 15
# CHC
maxItersCHC = 2500
# Multimodal
clearing_dist = 25
kappa = 2
nGeneracionesClearing = 50

capacidad = 300 
#DATOS ALEATORIZADOS
# aCompra= [7,7,50,25,11,26,48,45,10,14,42,14,42,22,40,34,21,31,29,34,11,37,8,50]
# aVenta= [1,3,21,1,10,7,44,35,4,1,23,12,30,7,30,4,9,10,6,9,8,27,7,10]
# radiacion = [274,345,605,810,252,56,964,98,77,816,68,261,841,897,75,489,833,96,117,956,970,255,74,926]
# pVenta = np.multiply(aVenta, 0.01) # Pasar de kW/cts a kW/eur
# pCompra = np.multiply(aCompra , 0.01)
#DATOS REALES

aCompra = [26, 26, 25, 24, 23, 24, 25, 27, 30, 29, 34, 32, 31, 31, 25, 24, 25,26, 34, 36, 39, 40, 38, 29]
aVenta = [24, 23, 22, 23, 22, 22, 20, 20, 20, 19, 19, 20, 19, 20, 22, 23, 22,23, 26, 28, 34, 35, 34, 24]
pVenta = np.multiply(aVenta, 0.01) # Pasar de kW/cts a kW/eur
pCompra = np.multiply(aCompra , 0.01)
radiacion = [0, 0, 0, 0, 0, 0, 0, 0, 100, 313, 500, 661, 786, 419, 865, 230,
              239, 715, 634, 468, 285, 96, 0, 0]

generacion = np.multiply(radiacion, 0.2 * 1000 * 0.001) # 20% por 1000 m2 pasados a kW

# FUNCIÓN DE EVALUACIÓN
def fEvaluacion(sActual):
    beneficio = 0 
    bateria = 0
    venta = 0
    compra = 0
    for i in range(0, len(sActual)):
        if sActual[i] > 0:  # Venta de energía sobre la disponible al añadir la generación
            energia = generacion[i] + bateria 
            venta = energia * sActual[i] / 100 
            bateria = energia - venta # Carga de la batería
            if bateria > capacidad: # Si hay más batería que espacio
                diferencia = bateria - capacidad
                venta += diferencia # Se vende el exceso también
                bateria = capacidad
            beneficio += pVenta[i] * venta # Se calcula el beneficio
        elif sActual[i] < 0:  # Compra de energía sobre el espacio disponible al añadir la generación
            energia = bateria + generacion[i] # Energia total
            if energia > capacidad: 
                bateria = capacidad # Se actualiza la batería
                venta = energia - capacidad # Se vende el sobrante
                beneficio += pVenta[i] * venta 
            else:
                espacio = capacidad - energia 
                compra = espacio * -1 * sActual[i] / 100 
                bateria = capacidad - espacio + compra 
                beneficio -= pCompra[i] * compra 
        else:  
            energia = generacion[i] + bateria 
            if energia > capacidad: 
                venta = energia - capacidad 
                bateria = capacidad 
                beneficio += pVenta[i] * venta 
            else:
                bateria = energia 
    venta = bateria 
    beneficio += pVenta[23] * venta
    return beneficio

"""Algoritmo genetico generacional"""
#Crea una poblacion aleatoria
def creaPoblacion(tamPoblacion):
  poblacion = np.random.randint(-100,100,(tamPoblacion,24) ,dtype=int)
  return poblacion

def evaluaPoblacion(poblacion):
    beneficios = np.zeros(len(poblacion))
    for i in range (len(poblacion)):
        beneficios[i] = fEvaluacion(poblacion[i])
    return beneficios

def genVecino(sActual, pos, g):
    sVecina = sActual.copy()
    valorPos = sVecina[pos] + g
    if valorPos <= -100:  # No puede pasar de 100 ni de -100
        sVecina[pos] = -100
    elif valorPos >= 100: 
        sVecina[pos] = 100
    else:
        sVecina[pos] = valorPos
    return sVecina

def mutacionIndividuo(individuo):  
    mutado = individuo.copy()
    if np.random.random() <= probMutacion:
        # Obtenemos los valores aleatorios
        pos = np.random.randint(0, 24)
        g = np.random.randint(1,10)        
        if np.random.uniform() < 0.5:           
            mutado = genVecino(mutado,pos,g)           
        else:
            mutado = genVecino(mutado,pos,-g)    
           
    return mutado

#Cruce de dos individuos
def cruce2puntos(padre1,padre2):
   pos1 = np.random.randint(0, len(padre1) - 1)
   pos2 = np.random.randint(0, len(padre2) - 1)
   
   if pos1 > pos2:
       pos1,pos2 = pos2,pos1
       
   hijo1 = np.concatenate((padre1[:pos1], padre2[pos1:pos2], padre1[pos2:]))
   hijo2 = np.concatenate((padre2[:pos1], padre1[pos1:pos2], padre2[pos2:]))
 
   return hijo1, hijo2

def seleccionElite(poblacion,costesPob, numSeleccionados):
  Ordenados = np.argsort(costesPob)
  seleccionados = poblacion[Ordenados[0:numSeleccionados]]

  return seleccionados

def torneo(poblacion,costesPoblacion,tamTorneo):
    indices = np.random.choice(len(poblacion), size=tamTorneo, replace=False)
    ganador = indices[np.argmax(costesPoblacion[indices])]
    return poblacion[ganador]

def GeneticoGeneracional():   
    iters = 0
    nEvals = 0
    # Inicializar y ver estructura P(t)
    poblacion = creaPoblacion(pobIni)   
    costes = evaluaPoblacion(poblacion)        
    indMejor = poblacion[np.argmax(costes)]
    costeMejor = np.max(costes)   
    costePeor = np.min(costes)
    #Para graficar la evolucion de los fitness maximos y minimos de cada poblacion
    registroPeor = [costePeor]
    registroMejor = [costeMejor]
    media = [sum(costes)/len(costes)]
    
    while iters < maxIters:
         iters += 1
         #Elite de la poblacion
         elite = seleccionElite(poblacion,costes, tamElite)
         nEvals += len(poblacion)     

         nuevaPob = poblacion
         nuevaPob[0:tamElite] = elite     

         for i in range(int(np.floor(len(poblacion)/2) - tamElite)):
             j = i + tamElite
             
             p1 = torneo(poblacion,costes,tamTorneo)           
             p2 = torneo(poblacion,costes,tamTorneo)             

             h1,h2 = cruce2puntos(p1, p2)             
             nuevaPob[j] = h1
             nuevaPob[int(np.floor(len(poblacion)/2) + j)] = h2           
         
         mutados = np.apply_along_axis(mutacionIndividuo, 1, nuevaPob.copy())
         poblacion = mutados
         costes = evaluaPoblacion(poblacion)           
         nEvals += len(poblacion)        
         
         #Actualizamos mejor y peor individuo, si mejora iters = 0
         if costes[np.argmax(costes)] > costeMejor:  
             indMejor = poblacion[np.argmax(costes)].copy()
             costeMejor= costes[np.argmax(costes)].copy()             
             iters = 0   
        
         registroMejor.append(costeMejor)
         registroPeor.append( costes[np.argmin(costes)].copy() )
         media.append(sum(costes)/len(costes))        
             
    return costeMejor, indMejor, nEvals , registroMejor,registroPeor , media

"""Algoritmo Genetico CHC"""

def dEuclidea(x, y):
    d = math.sqrt(sum((x[i] - y[i])**2 for i in range(len(x))))
    return d

def cruceParentCentered(padre1, padre2):
    hijo1 = np.zeros_like(padre1)
    hijo2 = np.zeros_like(padre2)
    # Calculamos la media de los genes de los dos padres.
    media = (padre1 + padre2) / 2
    # Generamos los genes de los hijos utilizando la media de los padres.
    for i in range(len(padre1)):
        if np.random.rand() < 0.5:
            hijo1[i] = media[i] - abs(padre1[i] - padre2[i]) / 2
            hijo2[i] = media[i] + abs(padre1[i] - padre2[i]) / 2
        else:
            hijo1[i] = media[i] + abs(padre1[i] - padre2[i]) / 2
            hijo2[i] = media[i] - abs(padre1[i] - padre2[i]) / 2
        # Ajustamos los valores de los hijos si superan los límites permitidos.
        hijo1[i] = max(min(hijo1[i], 100), -100)
        hijo2[i] = max(min(hijo2[i], 100), -100)
    return hijo1, hijo2


def combinarMejores(padres, hijos):
    costesP = evaluaPoblacion(padres)
    costesH = evaluaPoblacion(hijos)
    while np.any(costesH > costesP):
       padresOrdenados = np.argsort(costesP)
       hijosOrdenados = np.argsort(costesH)[::-1]
       for i in range(len(hijosOrdenados)):
           if costesH[hijosOrdenados[i]] > costesP[padresOrdenados[i]]:
               padres[padresOrdenados[i]] = hijos[hijosOrdenados[i]]
               costesP[padresOrdenados[i]] = costesH[hijosOrdenados[i]]
    return padres
 
def GeneticoCHC():
    d = 24 // 4 # L/4    
    iters = 0
    nEvals = 0
    nReinicios = 0
    # Inicializar y ver estructura P(t)
    poblacion = creaPoblacion(pobIni)   
    costes = evaluaPoblacion(poblacion)        
    indMejor = poblacion[np.argmax(costes)]
    costeMejor = np.max(costes)   
    costePeor = np.min(costes)
    #Para graficar la evolucion de los fitness maximos y minimos de cada poblacion
    registroPeor = [costePeor]
    registroMejor = [costeMejor]
    media = [sum(costes)/len(costes)]
    #Guardamos el mejor de la poblacion actual para los reinicios
    indMejorPob = indMejor.copy()    
    
    
    while iters < maxItersCHC:
        iters += 1
        pAux = poblacion.copy()
        np.random.shuffle(pAux)
       
        # Cruzar solo si cumplen distancia
        cruzados = np.empty_like(poblacion)
        for i in range(0, len(pAux), 2):
            if(dEuclidea(pAux[i], pAux[i+1]) > 15):
                h1,h2 = cruceParentCentered(pAux[i], pAux[i+1])
                cruzados[i] = h1
                cruzados[i+1] = h2
            else:
                cruzados[i] = pAux[i]
                cruzados[i+1] = pAux[i+1]
                
        poblacion = combinarMejores(pAux, cruzados)
        costes = evaluaPoblacion(poblacion)
        nEvals += len(poblacion)        
        
        if costes[np.argmax(costes)] > costeMejor:  
            indMejor = poblacion[np.argmax(costes)].copy()
            costeMejor= fEvaluacion(indMejor)
            iters = 0

        #Guardamos el mejor individuo de la generación
        indMejorPob = indMejor      

        if np.array_equal(poblacion, cruzados):
            d -= 1
        # Si d < 0 aplicamos mecanismo de rearranque
        if d < 0:
            #Mecanismo de rearranque
            d = 24/4
            poblacion = creaPoblacion(pobIni)
            poblacion[0] = indMejorPob.copy()
            nReinicios += 1
            
        registroMejor.append(costeMejor)
        registroPeor.append(costes[np.argmin(costes)])
        media.append(sum(costes)/len(costes))
           
                       
    return costeMejor, indMejor, nEvals , nReinicios, registroMejor, registroPeor,media


"""Algoritmo genetico MultiModal"""

def clearing(pob, kappa, dist):
    tamPob = len(pob)
    costes = evaluaPoblacion(pob)
    orden = np.argsort(costes)[::-1]
    for i in range(tamPob):
        if costes[orden[i]] > 0:
            numGanadores = 1
            for j in range(i + 1, tamPob):
                if costes[orden[j]] > 0 and dEuclidea(pob[orden[i]], pob[orden[j]]) < dist:
                    if numGanadores < kappa:
                        numGanadores += 1
                    else:
                        costes[orden[j]] = 0
    nuevaPob = []
    for i in orden:
        if costes[i] != 0:
            nuevaPob.append(pob[i])    
    return nuevaPob

def GeneticoGMultiModal():
    iters = 0
    nEvals = 0
    # Inicializar y ver estructura P(t)
    poblacion = creaPoblacion(pobIni)   
    costes = evaluaPoblacion(poblacion)        
    indMejor = poblacion[np.argmax(costes)]
    costeMejor = np.max(costes)   
    costePeor = np.min(costes)
    #Para graficar la evolucion de los fitness maximos y minimos de cada poblacion
    registroPeor = [costePeor]
    registroMejor = [costeMejor]
    media = [sum(costes)/len(costes)]
    p=0
    while iters < maxIters:
        iters += 1
        #Elite de la poblacion
        elite = seleccionElite(poblacion,costes, tamElite)
        nEvals += len(poblacion)     
               
        if p >= nGeneracionesClearing:
            p=0
            poblacion=clearing(poblacion, kappa, clearing_dist)
            costes = evaluaPoblacion(poblacion)
            nEvals += len(costes)      
            print("tras clearing->",len(poblacion))
            
            pC =poblacion
            costesC = costes
            for i in range (0,len(poblacion)):
                print('individuo ', i , ' : ' , pC[i])
                print('beneficio individuo ',costesC[i])
                print('-----------------------------------------')
                
        poblacion[0:5] = elite
        
        for i in range(int(np.floor(len(poblacion)/2) - tamElite)):
             j = i + tamElite
             if len(poblacion) < pobIni : 
                 p1= torneo(poblacion,costes,int((len(poblacion)/2)))      
                 p2= torneo(poblacion,costes,int((len(poblacion)/2)))             

             else:
                 p1 = torneo(poblacion,costes,tamTorneo)   
                 p2 = torneo(poblacion,costes,tamTorneo)             

             # while(fEvaluacion(p1) == costePeor) or fEvaluacion(p2) == costePeor:
             #     p1 = torneo(poblacion,costes,tamTorneo)             
             #     p2 = torneo(poblacion,costes,tamTorneo)                 
             h1,h2 = cruce2puntos(p1, p2)             
             poblacion[j] = h1
             poblacion[int(np.floor(len(poblacion)/2) + j)] = h2        
             
        mutados = np.apply_along_axis(mutacionIndividuo, 1, poblacion.copy())
        poblacion = mutados
        costes = evaluaPoblacion(poblacion)           
        nEvals += len(poblacion)  
                
        #Actualizamos mejor y peor individuo, si mejora iters = 0
        if costes[np.argmax(costes)] > costeMejor:  
             indMejor = poblacion[np.argmax(costes)].copy()
             costeMejor= costes[np.argmax(costes)].copy()
             iters = 0
             p+=1
             
        registroMejor.append(costeMejor)
        registroPeor.append(costes[np.argmin(costes)].copy())
        media.append(sum(costes)/len(costes))
                  
    
    return costeMejor, indMejor, nEvals,len(poblacion),len(costes), costes , registroMejor,registroPeor,media 

""" LLAMADAS A ALGORITMOS + GRAFICAS CONVERGENCIA """

mM,_,nM,_,_,costesClearing,y,y2,_ = GeneticoGMultiModal()
print("costes M",mM)
print("evals M",nM)
plt.plot(y,label='Mejor individuo MultiModal')
plt.plot(y2,label='Peor individuo MultiModal')
plt.xlabel('N Iteraciones')
plt.ylabel('Beneficio')
plt.legend()
plt.show()

# fig,ax = plt.subplots()
# ax.plot(costesClearing,'ro')
# ax.plot(costesClearing)
# plt.xlabel('Posicion Individuo En Poblacion')
# plt.ylabel('Beneficios')

# plt.show()

# mG,_,nG,y,y2,m = GeneticoGeneracional()
# print("costes G",mG)
# print("evals G",nG)
# plt.plot(y,label='Mejor individuo Basico')
# plt.plot(y2,label='Peor individuo Basico')
# plt.plot(m,label='Media fitness poblacion')
# plt.xlabel('N Iteraciones')
# plt.ylabel('Beneficio')
# plt.legend()
# plt.show()

# mC,_,nC,_,yCHC,y2CHC,m= GeneticoCHC()
# # print("costes C",mC)
# # print("evals C",nC)
# plt.plot(yCHC,label='Mejor individuo CHC')
# plt.plot(y2CHC,label='Peor individuo CHC')
# plt.xlabel('N Iteraciones')
# plt.ylabel('Beneficio')
# plt.legend()
# plt.show()
 
