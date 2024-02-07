# -*- coding: utf-8 -*-
"""
Created on Fri Dec  9 01:28:00 2022

@author: anton
"""
import numpy as np
import pylab as plt


"""
#Define the enviroment 
e_rows = 11
e_columns = 11

q_values = np.zeros((e_rows,e_columns , 4))

#Define actions 
actions = ['up','right','down','left']

#Define rewards
rewards = np.full((e_rows,e_columns ),-100)
rewards [0,5] = 100.

aisles = {}
aisles[1] = [i for i in range (1,10)]
aisles[2] = [1,7,9]
aisles[3] = [i for i in range (1,8)]
aisles[3].append(9)
aisles[4] = [3,7]
aisles[5] = [i for i in range (11)]
aisles[6] = [5]
aisles[7] = [i for i in range (1,10)]
aisles[8] = [3,7]
aisles[9] = [i for i in range (11)]

for row_index in range (1,10):
    for col_index in aisles [row_index]:
        rewards[row_index , col_index] = -1.

#Mostrar la matriz de recompensas

for row in rewards:
    print(row)
"""

#Define the enviroment 
e_rows = 15
e_columns = 15

q_values = np.zeros((e_rows,e_columns , 4))
scores = []

#Define actions 
actions = ['up','right','down','left']

#Define full rewards matrix
rewards = np.full((e_rows,e_columns ),-100)

#Specify the final goal 
rewards [0,12] = 100.

#Specify values for the possible paths
aisles = {}
aisles[1] = [12]
aisles[2] = [i for i in range (1,14)]
aisles[3] = [2,5,8]
aisles[4] = [2,5,8]
aisles[5] = [2,5,8]
aisles[6] = [i for i in range (1,14)]
aisles[7] = [4,8]
aisles[8] = [i for i in range (1,14)]
aisles[9] = [3,7]
aisles[10] = [i for i in range (1,14)]
aisles[11] = [4,8]
aisles[12] = [i for i in range (1,14)]
aisles[13] = [3,7]

for row_index in range (1,14):
    for col_index in aisles [row_index]:
        rewards[row_index , col_index] = -1
        

#Funciones auxiliares
def terminal_state (c_row_index , c_col_index):
    if rewards [c_row_index , c_col_index] == -1:
        return False
    else:
        return True    
    
def get_starting_loc ():
    c_row_index = np.random.randint(e_rows)
    c_col_index = np.random.randint(e_columns)
    
    while terminal_state(c_row_index , c_col_index):
        c_row_index = np.random.randint(e_rows)
        c_col_index = np.random.randint(e_columns)
    return c_row_index , c_col_index

def get_next_act (c_row_index,c_col_index,epsilon):
    if np.random.random() < epsilon:
        return np.argmax(q_values[c_row_index,c_col_index])
    else:
        return np.random.randint(4)
    
def get_next_loc (c_row_index , c_col_index , action_index):
    new_row_index = c_row_index
    new_col_index = c_col_index
    if actions [action_index] == 'up' and c_row_index > 0:
        new_row_index -=1
    elif actions [action_index] == 'right' and c_col_index < e_columns - 1:
        new_col_index +=1
    elif actions [action_index] == 'down' and c_row_index < e_rows - 1:
        new_row_index +=1
    elif actions [action_index] == 'left' and c_col_index > 0:
        new_col_index -=1
    return new_row_index , new_col_index

def get_shortest_path (start_row_index , start_col_index):
    if terminal_state (start_row_index , start_col_index):
        print ("The state you gave as initial is a terminal state")
        return []
    else:
        c_row_index , c_col_index = start_row_index , start_col_index
        shortest_path = []
        shortest_path.append([c_row_index , c_col_index])
        while not terminal_state (c_row_index , c_col_index):
            action_index = get_next_act(c_row_index, c_col_index, 1)
            c_row_index , c_col_index = get_next_loc(c_row_index , c_col_index ,action_index)
            shortest_path.append([c_row_index , c_col_index])
        return shortest_path
  
    
def showG (lnueva,nEp):     
    y = lnueva
    x = range (0,nEp)
    plt.plot(x,y)
    plt.show()
    
#ALgoritmo Q-Learning
epsilon = 0.9
discount_f = 0.9
learning_rate = 0.9
nEp = 2000
lnueva = []

for episode in range (nEp):
    row_index , col_index = get_starting_loc()
    totalreward=0
    
    while not terminal_state(row_index , col_index):
        action_index = get_next_act(row_index, col_index, epsilon)
        
        old_row_index,old_col_index = row_index,col_index
        row_index , col_index = get_next_loc(row_index , col_index , action_index)
        
        reward = rewards[row_index , col_index]
        totalreward += reward 
        old_q_value = q_values[old_row_index , old_col_index,action_index]
        temp_diff = reward + (discount_f * np.max(q_values[row_index , col_index])) - old_q_value
        
        new_q_value = old_q_value +(learning_rate * temp_diff)
        q_values[old_row_index , old_col_index , action_index] = new_q_value
               
        act_score = q_values.reshape(e_rows*e_columns , 4)
        scores.append(act_score)
        
    lnueva.append(totalreward)

    
print ("Trainig completed")


print(get_shortest_path(12,1))





