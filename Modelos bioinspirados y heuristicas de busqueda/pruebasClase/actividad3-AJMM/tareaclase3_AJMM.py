# -*- coding: utf-8 -*-
"""
Created on Wed May 10 16:04:03 2023

@author: anton
"""
import numpy as np

#Datos del problema
capacidad_mochila = 50
objetos = np.array([[10, 60], [20, 100], [30, 120], [40, 150]])

# Representación de los individuos
def representacion():
    return np.random.randint(0, 2, size=len(objetos))

# Función de fitness
def fitness(individuo):
    # volumen y el beneficio de los objetos del individuo
    volumen = np.sum(objetos[:, 0] * individuo)
    beneficio = np.sum(objetos[:, 1] * individuo)
    # Si volumen excede, fitness nulo
    if volumen > capacidad_mochila:
        return 0
    
    return beneficio

# Operador de cruce
def cruce(p1, p2):
    # Elegimos un punto de cruce al azar
    punto_cruce = np.random.randint(len(p1))
    # Cruzamos, generando los hijos
    hijo1 = np.concatenate((p1[:punto_cruce], p2[punto_cruce:]))
    hijo2 = np.concatenate((p2[:punto_cruce], p1[punto_cruce:]))
    # Comprobamos validez individuos
    hijo1 = corregir_individuo(hijo1)
    hijo2 = corregir_individuo(hijo2)
    return hijo1, hijo2

# Operador de mutación
def mutacion(individuo):
    # mutamos gen al azar
    gen_mutado = np.random.randint(len(individuo))
    # Mutamos el gen, cambiando su valor a 0 o 1 al azar
    individuo[gen_mutado] = np.random.randint(0, 2)
    individuo = corregir_individuo(individuo)
    return individuo

#garantiza que el volumen de un individuo no exceda la capacidad de la mochila
def corregir_individuo(individuo):
    while np.sum(objetos[:, 0] * individuo) > capacidad_mochila:
        #Si excede, quitamos el objeto mas pesado
        objeto_max_volumen = np.argmax(objetos[:, 0] * individuo)
        individuo[objeto_max_volumen] = 0
    return individuo

"""EJEMPLO EJECUCION"""
# Definimos los padres de prueba
padre1 = representacion()
padre2 = representacion()

# Elegimos un punto de cruce
h1,h2 = cruce(padre1,padre2)

# Mostramos los padres y los hijos
print("Resultado del operador de cruce:")
print('Padre 1:', padre1)
print('Padre 2:', padre2)
print('Hijo 1:', h1)
print('Hijo 2:', h2)

individuo = representacion()
print("Resultado del operador de mutacion")
print('Antes de mutar -> ' , individuo)
print('Despues de mutar -> ', mutacion(individuo))

individuo2 = representacion()
print("Resultados de la funcion fitness")
print("Solucion a evaluar: ",individuo2)
print("fitness equivalente a la solucion: ", fitness(individuo2))





