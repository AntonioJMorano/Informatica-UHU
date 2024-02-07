# -*- coding: utf-8 -*-
"""
Created on Wed Nov  9 16:13:16 2022

@author: anton
"""

import pandas as pd
import numpy as np
VACIO = "VACIO"
TODOS = '?'

def satisfacer (hipotesis , x):
    for i in range (0,len(hipotesis)):
        if (h == VACIO):            
           return False
        if(h == TODOS):            
            return True        
        if(h != x):            
            return False
        
def generalizar (h , x):
    if(h == VACIO):
        h = x    
    if(h == TODOS ):
        h = TODOS
    else:
        h = TODOS      
    
dataset = [['Sunny', 'Warm', 'Normal', 'Strong', 'Warm', 'Same', 1],
           ['Sunny', 'Warm', 'High', 'Strong', 'Warm', 'Same', 1],
           ['Rainy', 'Cold', 'High', 'Strong', 'Warm', 'Change', 0],
           ['Sunny', 'Warm', 'High', 'Strong', 'Cool', 'Change', 1]]
  
h= [VACIO]*(len(dataset[0])-1)       
print(h)
print(dataset[1][-1]) 


for i in range (0,len(dataset)):
    if(dataset[i][-1] == 1):
        for j in range (0,len(dataset[i])):
            if(satisfacer(h[j],dataset[i][j]) == False):
                h[j] = generalizar(h[j],dataset[i][j])
                
    
    

        



    

    
        
 
 
 



    
    
    
    
    
    
    
    
    
    
    
    
    