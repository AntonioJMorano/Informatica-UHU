# -*- coding: utf-8 -*-
"""
Created on Tue Feb 28 21:34:33 2023

@author: anton
"""

import random as rnd
import numpy as np
import math
#50
rnd.seed(100)

# DATOS

capacidad = 300 

aCompra = [26, 26, 25, 24, 23, 24, 25, 27, 30, 29, 34, 32, 31, 31, 25, 24, 25,
           26, 34, 36, 39, 40, 38, 29]
aVenta = [24, 23, 22, 23, 22, 22, 20, 20, 20, 19, 19, 20, 19, 20, 22, 23, 22,
          23, 26, 28, 34, 35, 34, 24]
pVenta = np.multiply(aVenta, 0.01) # Pasar de kW/cts a kW/eur
pCompra = np.multiply(aCompra , 0.01)
radiacion = [0, 0, 0, 0, 0, 0, 0, 0, 100, 313, 500, 661, 786, 419, 865, 230,
             239, 715, 634, 468, 285, 96, 0, 0]
"""
aCompra= [7,7,50,25,11,26,48,45,10,14,42,14,42,22,40,34,21,31,29,34,11,37,8,50]
aVenta= [1,3,21,1,10,7,44,35,4,1,23,12,30,7,30,4,9,10,6,9,8,27,7,10]
radiacion = [274,345,605,810,252,56,964,98,77,816,68,261,841,897,75,489,833,96,117,956,970,255,74,926]
pVenta = np.multiply(aVenta, 0.01) # Pasar de kW/cts a kW/eur
pCompra = np.multiply(aCompra , 0.01)
"""
generacion = np.multiply(radiacion, 0.2 * 1000 * 0.001) # 20% por 1000 m2 pasados a kW


# GENERACIÓN DE LA SOLUCIÓN INICIAL ALEATORIA
def genSolucion() :
    sAleatoria = [rnd.randint(-100, 100) for _ in range(0, len(radiacion))]
    return sAleatoria

# FUNCIÓN DE EVALUACIÓN
#No se puedo comprar y vender a la vez,por eso, en caso de que se vaya a comprar mas de lo
#que cabe en la bateria , directamente no se compra y sigue a la siguiente 
#posicion del array
def fEvaluacion(sActual):
    beneficio = 0
    bateria = 0
    for i in range(0, len(sActual)):
        #Comprobamos antes que nada que no haya desbordes de energia perdida
        energia = generacion[i] + bateria
        if energia > capacidad:
            venta = capacidad - energia
            beneficio += pVenta[i] * venta * -1
            bateria = capacidad
        else:
            bateria = energia                 
        if sActual[i] > 0: # Venta de energía
            venta = energia * sActual[i] / 100
            beneficio += pVenta[i] * venta
            bateria = energia - venta
        elif sActual[i] < 0: # Compra de energía
            espacio = capacidad - bateria
            compra = espacio * -1 * sActual[i] / 100                        
            if espacio < compra: #Si vamos a comprar mas de lo que nos cabe, cancelamos la compra
                compra = 0               
            else:#Si cabe compramos y añadimos esa energia a la bateria
                bateria += compra   
            beneficio -=  pCompra[i] * compra
    
    #Al terminar, si queda bateria la vendemos al precio de la ultima hora               
    beneficio += pVenta[-1] * bateria
    return beneficio


# OPERADOR DE MOVIMIENTO
g = 5  # Granularidad 1,5,20
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

#BUSQUEDAS LOCALES    
def BL_VecinoPrimerMejor(sIni):
    sMejor = sIni  #La primera que leemos es la mejor por el momento
    bMejor = fEvaluacion(sMejor)    
    llamadasCoste = 1 
    enc = False
    while enc == False and llamadasCoste < 3000: 
        for i in range (len(sMejor)):            
            sAux = genVecino(sMejor,i,g)
            bAux = fEvaluacion(sAux)
            llamadasCoste+=1
            if bAux > bMejor:
                sMejor = sAux
                enc = True   
              
    return fEvaluacion(sMejor) , sMejor , llamadasCoste 


def BL_VecinoMejor(sIni): # Busca la mejor solución del entorno
    sActual = sIni # Generación solución inicial
    bActual = fEvaluacion(sActual)
    llamadasCoste = 1 #la de arriba
    vecesMejora =0
    while True:
        sMejor = sActual # La actual será la mejor si no se encuentran mejores
        bMejor = bActual
        for i in range(len(sActual)): # Buscamos el mejor vecino del entorno
            for j in range(2): #+ y -
                if j == 0: # +g
                    sVecina = genVecino(sActual,i,g)
                    bVecina = fEvaluacion(sVecina)
                    llamadasCoste+=1
                    if bVecina > bMejor: #Si el vecino supera al mejor d
                        sMejor = sVecina
                        bMejor = bVecina
                else: # -g
                    sVecina = genVecino(sActual,i,-g)
                    bVecina = fEvaluacion(sVecina)
                    llamadasCoste+=1
                    if bVecina > bMejor: 
                        sMejor = sVecina
                        bMejor = bVecina                        
        # Si el mejor vecino del bucle mejora al actual se sustituye y se vuelve a iterar.      
        if bMejor > bActual:
            vecesMejora+=1
            sActual = sMejor
            bActual = bMejor
        else: # Si no mejora, salimos del algoritmo.
            break

    return fEvaluacion(sActual) , sActual , llamadasCoste+1 , vecesMejora

#Array que contiene los 5 niveles de velocidad variable
gVariable = [1,5,10,15,25] 
def VND(sIni):
    sActual = sIni
    bActual = fEvaluacion(sActual)
    llamadasCoste = 1     
    k=0
    while k < len(gVariable):
        sMejor = sActual #La actual será la mejor si no se encuentran mejores
        bMejor = bActual
        for i in range(len(sActual)): # Obtención del mejor vecino del entorno
            for j in range(2): 
                if j == 0: # +g
                    sVecina = genVecino(sActual,i,gVariable[k])
                    bVecina = fEvaluacion(sVecina)
                    llamadasCoste+=1
                    if bVecina > bMejor: 
                        sMejor = sVecina
                        bMejor = bVecina
                else: # -g
                    sVecina = genVecino(sActual,i,-g)
                    bVecina = fEvaluacion(sVecina)
                    llamadasCoste+=1
                    if bVecina > bMejor: 
                        sMejor = sVecina
                        bMejor = bVecina                        
        # Si la mejor de las vecinas mejora a la actual se sustituye y se vuelve a iterar      
        if bMejor > bActual:
            sActual = sMejor
            bActual = bMejor
            k=0 #Si hay una mejor reiniciamos el valor de k 
        else: #Si no, aumentamos k en 1 y variamos el nivel de granularidad de la siguiente iteracion
            k = k +1

    return fEvaluacion(sActual) , sActual , llamadasCoste+1 
   
#GREEDY
def solGreedy(): #Solo se llama a la funcion de coste una vez ya que genera un array y se le aplica la funcion
    maxPrecio = np.argmax(pVenta)
    sGreedy = [0 for _ in range(0, len(radiacion))]
    sGreedy[maxPrecio:len(radiacion)] = [100 for _ in range(maxPrecio, len(radiacion))]
    beneficio = fEvaluacion(sGreedy)
    return beneficio ,sGreedy , 1

#BUSQUEDA ALEATORIA
def busquedaAleatoria(): #Se llama a la funcion de costes 100 veces , una para cada iteracion.
    bMejor = 0 
    for i in range(0, 100):
        sActual = genSolucion()
        bActual = fEvaluacion(sActual)
        if (bActual > bMejor): #Si la sol aleatoria de esta iteracion tiene mas beneficio
            sMejor = sActual
            bMejor = bActual
    return bMejor, sMejor , 100

#ENFRIAMIENTO SIMULADO
def Cauchy(t0,k):
    Tnueva = t0 / (1 + k)
    return Tnueva

prob = 0.15
mu = 0.25
def CalculoT0 ():   
    bGreedy , _ , _ = solGreedy() #Coste devuelto por el greedy
    T0 = mu / -(np.log(prob)) * bGreedy
    return T0
kMax = 100 #numero max de iteraciones
lt= 10 #L(T) vecinos por iteracion
def EnfriamientoSimulado(sIni,Tf):
    llamadasCoste = 0    
    sActual = sIni
    sMejor = sActual
    tIni= CalculoT0()
    
    temp = tIni    
    for k in range(kMax):
        solAceptada=0
        solNoAceptada=0        
        for i in range (0,lt): 
             if(rnd.random() > 0.5):    #+-g de forma aleatoria y vecino con pos aleatoria             
                 sCand= genVecino(sActual,rnd.randint(0, 23),g)   
             else:
                 sCand= genVecino(sActual,rnd.randint(0, 23),-g)                   
             difCoste = fEvaluacion(sCand) - fEvaluacion(sActual)             
             llamadasCoste+=2             
             if (difCoste < 0) or (rnd.uniform(0,1) < np.exp(-difCoste/temp)):
                 solAceptada+=1
                 sActual = sCand
                 bActual = fEvaluacion(sCand)
             if bActual > fEvaluacion(sMejor):
                 sMejor = sActual #Guardamos la mejor solucion por si nos vamos a una peor no seguir por alli
                 llamadasCoste+=2      
             else:
                solNoAceptada+=1
        temp = Cauchy(tIni,k) #enfriamos tras generar 10 vecinos        
    #Porcentaje de soluciones no aceptadadas
    porcentajeRechazo = (solNoAceptada/(solAceptada+solNoAceptada)* 100)              
    return fEvaluacion(sMejor) , sMejor ,llamadasCoste+1 , porcentajeRechazo

#BUSQUEDA TABU
#Funcion que crea la matriz de frecuencias, horas * valores posibles
def iniMatrizFr(): 
    rango = len(range(-100, 100 + g, g))
    horas = len(radiacion)
    matrizFr = np.ones((horas, rango)) 
    return matrizFr

#Funcion que devuelve la matriz de frecuencias actualizada
def incMatrizFr(matrizFr, sol):
    matrizFrNueva = matrizFr.copy() 
    for h, v in enumerate(sol): # Por cada par de hora,valora vamos a calcular el indice 
        indiceV = int(10 + v / g) 
        matrizFrNueva[h][indiceV] += 1 #Incrementamos la casilla del par hora,indiceValor que acabamos de calcular
    return matrizFrNueva

def genMatrizProb(matrizFr):
    valores = len(matrizFr[0, :])
    horas = [i for i in range(len(radiacion))]
    nhoras = len(horas)
    mInv = np.zeros((nhoras, valores)) 
    for h in horas: # Recorremos de todas las horas y todos los valores por hora
        for v in range(valores): 
            frec = matrizFr[h][v] #Obtenemos frecuencia 
            if frec == 0: # prob max en 0
                prob = float('inf')
            else: # Si no,prob sera la inversa de la frecuencia
                prob = 1 / frec
            mInv[h][v] = prob # Completamos la matriz de inversas
    sumInv = [] # Normalizamos,para lo que calculamos el sumatorio de las inversas por hora
    for h in horas: 
        sumInv.append(sum(mInv[h]))
    
    matrizProb = np.zeros((nhoras, valores)) 
    for h in horas: # Recorrido de todas las horas y todos los valores por hora
        for v in range(valores): #Por cada valor calculamos la casilla y actualizamos la matriz
            norm = mInv[h][v] / sumInv[h] 
            matrizProb[h][v] = norm 
        
    return matrizProb
    

def genSolucionGreedy(matrizProb): 
    horas = len(radiacion)
    sGreedy = [0 for _ in range(horas)]
    for h in range(horas): 
        num = rnd.random() 
        suma = 0 
        for v in range(len(sGreedy)): 
            suma += matrizProb[h][v] #Incrementamos las suma si el random es menor incluimos v en h del greedy
            if num < suma: 
                sGreedy[h] = v 
                break # Se pasa a la siguiente hora
    return sGreedy

def busquedaTabu(sIni, maxIteraciones, tamTabu, nVecinos):
    sActual = sIni
    bActual = fEvaluacion(sActual)
    llamadasCoste=1
    sMejor = sActual
    bMejor = bActual    
    matrizFr = iniMatrizFr() # Inicializar matriz de frecuencias
    lTabu = [] # Inicializar lista tabú    
    for i in range(maxIteraciones): # Ejecutamos las iteraciones
        hora = np.nan
        valor = np.nan
        for j in range(nVecinos):        
            #Vecino aleatorio, tanto en pos como en +-g
            pos = rnd.randint(0, 23)
            valor = sActual[pos]
            if(rnd.random() > 0.5):    #+-g de forma aleatoria y vecino con pos aleatoria             
                sVecina= genVecino(sActual,pos,g)   
                bVecina = fEvaluacion(sVecina)
                llamadasCoste += 1
            else:
                sVecina= genVecino(sActual,pos,-g)    
                bVecina = fEvaluacion(sVecina)
                llamadasCoste += 1             
            # Si sVecina no está en la lista tabú y supera a la mejor
            if ((pos, sVecina[pos]) not in lTabu) and (bVecina > bMejor):
                sMejor = sVecina 
                bMejor = bVecina                    
        sActual = sMejor
        bActual = bMejor        
        #Añadimos el par hora-valor a la lista tabú
        lTabu.append((hora, valor)) 
        if len(lTabu) > tamTabu: #Lista tabú pasa su tamaño máximo
            lTabu.pop(0) # Eliminamos el mas antiguo        
        #Actualizamos matrizFr
        matrizFr = incMatrizFr(matrizFr, sActual)    
        if i % (maxIteraciones // 4) == 0:
            # Reestablecer lt 
            lTabu = []
            if rnd.random() > 0.5: #Aumentar o disminuir 50%
                tamTabu += tamTabu / 2 
            else:
                tamTabu -= tamTabu / 2                 
            # Implementacion estrategia reinicialización    
            eReinicio = rnd.random()
            if eReinicio < 0.25: # Solución aleatoria
                sActual = genSolucion()
                bActual = fEvaluacion(sActual)
                llamadasCoste += 1
            elif 0.25 < eReinicio <= 0.75: # Solución Greedy
                matrizProb = genMatrizProb(matrizFr)
                sActual = genSolucionGreedy(matrizProb)
                bActual = fEvaluacion(sActual)
                llamadasCoste += 1
            else: # Mejor solución
                sActual = sMejor
                bActual = bMejor                    
    return bMejor ,sMejor, llamadasCoste
            
#-----------------------------------PRUEBAS--------------------------------------


aux = genSolucion()
print("Solucion inicial generada a pasar a los algoritmos-> ",aux)
print("--------------------------------------------------")

print("Solucion PRIMER vecino : ", BL_VecinoPrimerMejor(aux))
print("--------------------------------------------------")

print("Solucion MEJOR vecino : ", BL_VecinoMejor(aux))
print("--------------------------------------------------")

print("Solucion VND " , VND(aux))
print("--------------------------------------------------")

print ("Solucion Busqueda Aleatoria " , busquedaAleatoria())
print("--------------------------------------------------")

print ("Solucion Greedy " ,solGreedy())
print("--------------------------------------------------")

print ("Solucion Enfriamiento simulado " , EnfriamientoSimulado(aux,0.1))
print("--------------------------------------------------")

print("Solucion Busqueda Tabu ", busquedaTabu(aux,100,4,2))
("--------------------------------------------------")





