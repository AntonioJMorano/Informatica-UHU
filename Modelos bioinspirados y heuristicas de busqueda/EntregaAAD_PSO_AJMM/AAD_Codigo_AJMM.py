# -*- coding: utf-8 -*-
"""
Created on Mon Apr 10 02:55:33 2023

@author: anton
"""
import random as rnd
import numpy as np
import math

#10,11,15,20,50
rnd.seed(50) 

#Parametros con valor estatico dados en la practica
w = 0.729
phis = 1.49445 
nParticulas = 10
vecindadPSOLocal = 2

#Rosenbrock y Rastrigin
def fitnessRosenbrock(pos):
  x = pos[0]
  y = pos[1]

  valor = ((1-x)**2) + 100*((y-(x**2))**2)
  return valor

def fitnessRastrigin(pos):
  x = pos[0]
  y = pos[1]

  valor = 20 + x**2 + y**2  - 10*(math.cos(2*math.pi*x) + math.cos(2*math.pi*y))
  return valor

def fitnessOpc(pos, opc):
  if(opc==0):
    return fitnessRosenbrock(pos)
  if(opc==1):
    return fitnessRastrigin(pos) 

#Funciones PSO
#Estrategia de inicializacion aleatoria, generamos las particulas con pos y v aleatorias
def generaParticula(minX,maxX,minY,maxY,minV,maxV):
    
  xPos = rnd.uniform(minX,maxX)
  yPos = rnd.uniform(minY,maxY)
  xV = rnd.uniform(minV,maxV)
  yV = rnd.uniform(minV,maxV)
    
  return (xPos,yPos) , (xV,yV)

def actualizarVelocidad(v,gBest,pBest,pos): 

  r1 = rnd.uniform(0,1)*phis
  r2 = rnd.uniform(0,1)*phis
  
  inercia = (v[0]*w, v[1]*w)
  cognitivo = (r1*(pBest[0]-pos[0]), r1*(pBest[1]-pos[1]))
  social = (r2*(gBest[0]-pos[0]), r2*(gBest[1]-pos[1]))

  formulaV = (inercia[0]+cognitivo[0]+social[0], inercia[1]+cognitivo[1]+social[1])
  
  return formulaV

#La particula rebota en el limite con velocidad opuesta a la que choca
def comprobarPos(pos,v, minX, maxX, minY, maxY):
  x = pos[0]
  y = pos[1]
  vComprobada = np.copy(v)
  if(x < minX):
    x = minX
    vComprobada[0] = -vComprobada[0]
  if(x > maxX):
    x = maxX
    vComprobada[0] = -vComprobada[0]
  if(y < minY):
    y = minY
    vComprobada[1] = -vComprobada[0]
  if(y > maxY):
    y = maxY
    vComprobada[1] = -vComprobada[0]
  posNueva = (x,y)  
  return posNueva,vComprobada

def actualizarPosicion(pos, v, minX, maxX, minY, maxY):
  nuevaPos = (pos[0] + v[0] , pos[1]+v[1])
  posDevolver,vComprobada = comprobarPos(nuevaPos,v, minX, maxX, minY, maxY)

  return posDevolver, vComprobada

def generaVecinos(pos, nVecinos, variacion, minX,maxX,minY,maxY):
  vecinos = []

  for i in range(nVecinos):
    varX = rnd.uniform(-variacion,variacion)
    varY = rnd.uniform(-variacion,variacion)

    posVecino = (pos[0]+varX,pos[1]+varY)
    vecino, _ = comprobarPos(posVecino,(0,0),minX,maxX,minY,maxY)
    vecinos.append(vecino)    
  return vecinos

#PSOLocal 
def PSOLocal(opc,nParticulas,nIters,vecindad,minX,maxX,minY,maxY,minV,maxV):
  #Inicializacion variables    
  mejoresCostesParticulas = [float("inf") for _ in range(nParticulas)]
  mejoresPosParticulas = [None for _ in range(nParticulas)]
  mejorCosteGlobal = float("inf")
  mejorPosGlobal = None
  posParticulas = []
  vParticulas = []
  evals = 0
  #Inicializar particulas 
  for _ in range(nParticulas):
    pos , v = generaParticula(minX,maxX,minY,maxY,minV,maxV)
    posParticulas.append(pos)
    vParticulas.append(v) 
  for _ in range(nIters):#Condicion de parada = maxIters
    #Actualizar mejorCosteParticulas 
    for i in range(nParticulas):
      evals += 1
      costeXi = fitnessOpc(posParticulas[i],opc)      
      if(costeXi < mejoresCostesParticulas[i]):#Actualizar el mejor coste 
        mejoresPosParticulas[i] = posParticulas[i]
        mejoresCostesParticulas[i] = costeXi
        if(costeXi < mejorCosteGlobal): #Actualizar la mejor pos global 
          mejorPosGlobal = posParticulas[i]
          mejorCosteGlobal = costeXi
          if(mejorCosteGlobal == 0): #Ha llegado al minimo por lo que salimos
            return mejorCosteGlobal,mejorPosGlobal,evals       
    for i in range(nParticulas):
      #Actualizar la mejor pos global en Xi.
      lBestPos = None
      lBestCoste = float("inf")
      for j in range(i-vecindad,i+vecindad+1):
        k= j % nParticulas
        if(mejoresCostesParticulas[k] < lBestCoste):
          lBestPos = mejoresPosParticulas[k]
          lBestCoste = mejoresCostesParticulas[k]          
      #Actualizr particulas
      nuevaV = actualizarVelocidad(vParticulas[i],lBestPos,mejoresPosParticulas[i],posParticulas[i])
      nuevaPos,vComprobada = actualizarPosicion(posParticulas[i],nuevaV,minX,maxX,minY,maxY)
      posParticulas[i] = nuevaPos
      vParticulas[i] = vComprobada 
  for i in range(nParticulas):
    costeXi = fitnessOpc(posParticulas[i],opc)
    if(costeXi < mejorCosteGlobal):  #Si alguna particula tiene mejor coste que el global
      mejorCosteGlobal = costeXi
      mejorPosGlobal = posParticulas[i]
  return mejorCosteGlobal, mejorPosGlobal, evals

#PSOGlobal 
def PSOGlobal(opc,nParticulas,nIters,minX,maxX,minY,maxY,minV,maxV):
  #Inicializacion de variables
  mejoresCostesParticulas = [float("inf") for _ in range(nParticulas)]
  mejoresPosParticulas = [None for _ in range(nParticulas)]
  mejorCosteGlobal = float("inf")
  mejorPosGlobal = None 
  posParticulas = []
  vParticulas = []
  evals = 0
  #Inicializar particulas 
  for _ in range(nParticulas):
    pos , v = generaParticula(minX,maxX,minY,maxY,minV,maxV)
    vParticulas.append(v)
    posParticulas.append(pos)     
  for _ in range(nIters):#Condicion de parada = maxIters
    #Actualizar mejorCosteParticulas 
    for i in range(nParticulas):
      evals += 1
      costeXi = fitnessOpc(posParticulas[i],opc)
      if(costeXi < mejoresCostesParticulas[i]):#Actualizar el mejor coste 
          mejoresCostesParticulas[i] = costeXi   
          mejoresPosParticulas[i] = posParticulas[i]             
      if(costeXi < mejorCosteGlobal):#Actualizar la mejor pos global 
        mejorCosteGlobal = costeXi
        mejorPosGlobal = posParticulas[i]        
        if(mejorCosteGlobal == 0):#Ha llegado al minimo por lo que salimos
          return mejorCosteGlobal,mejorPosGlobal,evals
    #Actualizamos particulas
    for i in range(nParticulas):
      nuevaV = actualizarVelocidad(vParticulas[i],mejorPosGlobal,mejoresPosParticulas[i],posParticulas[i])
      nuevaPos,vComprobada = actualizarPosicion(posParticulas[i],nuevaV,minX,maxX,minY,maxY)
      posParticulas[i] = nuevaPos
      vParticulas[i] = vComprobada  
  for i in range(nParticulas):
    costeXi = fitnessOpc(posParticulas[i],opc)
    if(costeXi < mejorCosteGlobal): #Si alguna particula tiene mejor coste que el global
      mejorCosteGlobal = costeXi
      mejorPosGlobal = posParticulas[i]
  return mejorCosteGlobal, mejorPosGlobal,evals


#Busqueda Local mejor vecino
def BusquedaLocal(opc,nVecinos,variacion,minX,maxX,minY,maxY):
  iters = 0
  #Solucion inicial 
  
  posActual = (1,1) #Empezamos a buscar en (1,1)
  #Generar la posicion inicial de busqueda aleatoria
  """
  posActual, _ = generaParticula(minX, maxX, minY, maxY, minV, maxV)

  """
  while True:
    #Generamos vecinos 
    vecinos = generaVecinos(posActual,nVecinos,variacion,minX,maxX,minY,maxY)
    costeActual = fitnessOpc(posActual,opc)
    iters+=1
    mejorCosteVecino = float("inf")
    mejorVecinoPosicion = None
    for i in range(nVecinos):
      iters+=1
      costeVecino = fitnessOpc(vecinos[i],opc)
      if(costeVecino < mejorCosteVecino):
        mejorVecinoPosicion = vecinos[i]
        mejorCosteVecino = costeVecino    
    if(mejorCosteVecino < costeActual):
      costeActual = mejorCosteVecino
      posActual = mejorVecinoPosicion
    else:
      break      
  return costeActual,posActual,iters

#Limites espacios busqueda de cada funcion
#Rosenbrock
minX_f0 = -2
maxX_f0 = 2
minY_f0 = -0.5
maxY_f0 = 3
#Rastrigin
minX_f1 = -5.12
maxX_f1 = 5.12
minY_f1 = -5.12
maxY_f1 = 5.12
#Para Busqueda local
minX_BL = -10
maxX_BL = 10
minY_BL = -10
maxY_BL = 10

minV = -3
maxV = 3

maxIters = 10000

#SALIDA Rosenbrock
print("\t\tFuncion Rosenbrock:")
mCostePL,mPosPL, nEvalsPL = PSOLocal(0,nParticulas,maxIters,vecindadPSOLocal,minX_f0,maxX_f0,minY_f0,maxY_f0,minV,maxV)
print("PSO LOCAL")
print("Mejor Coste encontrado = ",mCostePL)
print("Mejor Posicion = ",mPosPL)
print("Resultados obtenidos en ",nEvalsPL," evaluaciones")
print("\n")

mCostePG , mPosPG , nEvalsPG = PSOGlobal(0,nParticulas,maxIters,minX_f0,maxX_f0,minY_f0,maxY_f0,minV,maxV)
print("PSO GLOBAL")
print("Mejor Coste encontrado = ",mCostePG)
print("Mejor Posicion = ",mPosPG)
print("Resultados obtenidos en ",nEvalsPG," evaluaciones")
print("\n")

mCosteBL , mPosBL , nEvalsBL = BusquedaLocal(0,10,0.1,minX_BL,maxX_BL,minY_BL,maxY_BL)
print("BL- Mejor Vecino")
print("Mejor Coste encontrado = ",mCosteBL)
print("Mejor Posicion = ",mPosBL)
print("Resultados obtenidos en ",nEvalsBL," evaluaciones")
print("----------------------------------")


#SALIDA RASTRIGIN
print("\t\tFuncion RASTRIGIN:")
mCostePL2,mPosPL2, nEvalsPL2 = PSOLocal(1,nParticulas,maxIters,vecindadPSOLocal,minX_f1,maxX_f1,minY_f1,maxY_f1,minV,maxV)
print("PSO LOCAL")
print("Mejor Coste encontrado = ",mCostePL2)
print("Mejor Posicion = ",mPosPL2)
print("Resultados obtenidos en ",nEvalsPL2," evaluaciones")
print("\n")

mCostePG2 , mPosPG2 , nEvalsPG2 = PSOGlobal(1,nParticulas,maxIters,minX_f0,maxX_f0,minY_f0,maxY_f0,minV,maxV)
print("PSO GLOBAL")
print("Mejor Coste encontrado = ",mCostePG2)
print("Mejor Posicion = ",mPosPG2)
print("Resultados obtenidos en ",nEvalsPG2," evaluaciones")
print("\n")

mCosteBL2 , mPosBL2 , nEvalsBL2 = BusquedaLocal(1,10,0.1,minX_BL,maxX_BL,minY_BL,maxY_BL)
print("BL- Mejor Vecino")
print("Mejor Coste encontrado = ",mCosteBL2)
print("Mejor Posicion = ",mPosBL2)
print("Resultados obtenidos en ",nEvalsBL2," evaluaciones")
print("----------------------------------")


