# -*- coding: utf-8 -*-
"""
Created on Thu Nov 17 00:22:29 2022

@author: anton
"""
positivo = 1
negativo = 0
vacio = "Empty"
todo = "?"

# Definicion datasets

dataset = [("Sunny","Warm","Normal","Strong","Warm","Same",positivo),
           ("Sunny","Warm","High","Strong","Warm","Same",positivo),
           ("Rainy","Cold","High","Strong","Warm","Change",negativo),
           ("Sunny","Warm","High","Strong","Cool","Change",positivo)]
"""
dataset = [("Big","Red","Circle",negativo),
           ("Small","Red","Triangle",negativo),
           ("Small","Red","Circle",positivo),
           ("Big","Blue","Circle",negativo),
           ("Small","Blue","Circle",positivo)]
"""
nAttributes = len(dataset[0])-1
#Generic hyphoteses
G = [(todo)] * nAttributes
#Specific hyphoteses
S = [(vacio)] * nAttributes

temp = []   

#We search for the 1st positive example and use it as most specific case 
aux=0
posit = False
while not posit and (aux < len(dataset)):
    if (dataset[aux][-1] == 1):
        for i in range(0,nAttributes):
            S[i] = dataset[aux][i]
            posit = True
            
        #dataset.pop(aux)
    aux+=1
    
#Every element on dataset
for i in range (0,len(dataset)):
   
    #Positive cases
    if(dataset[i][-1] == 1):
        #Looking every attribute 
        for j in range (0,nAttributes):
            if(S[j] != dataset[i][j]):
                S[j] = todo               
        for j in range (0,nAttributes):
            for k in range(0, len(temp)):
                if (temp [k][j] != S[j] and temp[k][j] != todo):
                    del temp[k]
    #Negative cases
    else:
        if (dataset[i][-1] == 0):
            for j in range (0,nAttributes):
                if (dataset[i][j] != S[j] and S[j]!= todo):
                    G[j] = S[j]
                    temp.append(G)
                    G = [todo] * nAttributes     

                       
    #It prints everystep
    print("Tras la iteracion numero" , i , "la S queda tal que:")            
    print (S)
    print("\n")
        
    print("Tras la iteracion numero" , i , "la G queda tal que:")     
    if(len(temp) == 0):
        print (G)
        print("-------------------------------------------------\n")
    else:
        print (temp)
        print("-------------------------------------------------\n")
        
   
        
        
        
"""
def generalizar(h1,x):
    if h1 == todo:
        return todo
    if h1 == x:
        return h1
    if h1 != x:
        return todo
    else:
        return x

def satisfacer(h1,x):
    if h1==vacio:
        return False
    elif h1 == todo:
        return True
    else:
        if h1 == x:
            return True
        else:
            return False

def comprobar_general(h1,h2):
    gen1 = 0
    gen2 = 0
    for i in range (0,len(h1)):
        if (h1[i] == todo):
            gen1+=1            
    for i in range (0,len(h1)):
        if (h2[i] == todo):
            gen2+=1            
    if(gen1 < gen2):
        return h2        
    else:
        return h1
        
 """   