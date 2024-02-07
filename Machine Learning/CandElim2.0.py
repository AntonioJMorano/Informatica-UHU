# -*- coding: utf-8 -*-

positivo = 1
negativo = 0
vacio = "Empty"
todo = "?"

# Definicion datasets

dataset = [("Sunny","Warm","Normal","Strong","Warm","Same",positivo),
           ("Sunny","Warm","High","Strong","Warm","Same",positivo),
           ("Rainy","Cold","High","Strong","Warm","Change",negativo),
           ("Sunny","Warm","High","Strong","Cool","Change",positivo)]

nAttributes = len(dataset[0])-1
#Generic hyphoteses
G = [(todo)] * nAttributes
#Specific hyphoteses
S = [(vacio)] * nAttributes

temp = []   

#We search for the 1st positive example and use it as most specific case 
if (dataset[0][-1] == 1):
    for i in range(0,nAttributes):
        S[i] = dataset[0][i]        
            
       
    
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
        
   
        
        