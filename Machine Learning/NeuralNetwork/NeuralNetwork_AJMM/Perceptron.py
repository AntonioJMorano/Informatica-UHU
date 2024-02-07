# -*- coding: utf-8 -*-
"""
Created on Fri Oct 28 21:05:05 2022

@author: anton
"""
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import random as r


def threshold (weigths , x ):
    z = weigths * x
    if z.sum() > 0:
        return 1
    else:
        return 0


dataset = pd.read_csv("C:/Users/anton/Desktop/CURSO/PracticasActuales/ML/NeuralNetwork/NeuralNetwork_AJMM/separables.csv",sep = ';')
learningRate = 0.01

datosa = np.array([[0,0,0],[0,1,0],[1,0,0],[1,1,1]])
datosAND = pd.DataFrame(datosa , columns = ['x1' , 'x2' , 'y'])

datoso = np.array([[0,0,0],[0,1,1],[1,0,1],[1,1,1]])
datosOR = pd.DataFrame(datoso , columns = ['x1' , 'x2' , 'y'])

datosn = np.array([[0,1],[1,0]])
datosNOT = pd.DataFrame(datosn , columns = ['x' , 'y'])


#PUERTAS LOGICAS


x = np.array(datosAND.iloc[:,[0,1]])
y = np.array(datosAND.iloc[:,2])
w = np.random.uniform(-1,1 , size = 2)


for iteracion in range (10):    
    errort=0
    for i in range (0,len(x)):
        output = threshold(w, x[i])
        error = y[i]- output    
        errort += error**2
        w[0] += learningRate + x[i][0] * error
        w[1] += learningRate + x[i][1] *error
    print(errort)

threshold(w, [0,0])



  
            
"""
#Creating the arrays (x = [X1;X2] , y = Y)
x = np.array(dataset.iloc[:,[0,1]])
y = np.array(dataset.iloc[:,2])
w = np.array([r.uniform(-1,1) ,r.uniform(-1,1) ,r.uniform(-1,1) ])
print(w)
   
#Perceptron's algorythm
for i in range (0,len(x)):
    output = sum(x[i]) + sum(w)
    for j in range (0,len(w)):  
        w[j] =  w[j] + (learningRate * (y[j] - output) * sum(x[i]))                 
  
print(w)
"""


plt.scatter(x[y==0].T[0], x[y==0].T[1])  
plt.scatter(x[y==1].T[1] , x[y==1].T[1] , color = "black")  
plt.show()

