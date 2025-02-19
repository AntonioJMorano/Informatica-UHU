# -*- coding: utf-8 -*-
"""
Created on Thu Dec 22 15:40:40 2022

@author: anton
"""

# -*- coding: utf-8 -*-

import csv
import sys
 
si = 1 #Celula sana
no = 0 #Celula cancerigena

#Rayado = R y Blanco = B

DataSet = [(1,0,2,"R",si),(0,2,0,"R",si),(0,2,1,"R",si),(0,2,2,"R",si),
           (1,0,1,"B",no),(1,1,1,"R",no),(2,2,1,"R",no)]

ColumnsData = ["Antenas","Colas","Nucleos","Cuerpo","clase"]

dicc2 = {'examples':DataSet , 'columns' : ColumnsData}
 

"""
DataSet = [("B","B","N",si),("B","B","B",si),("B","B","A",si),("N","N","B",si),
           ("B","A","B",no),("A","B","B",no),("N","N","N",si)]

ColumnsData = ["i1","i2","i3","clase"]

dicc = {'examples': DataSet , 'columns' : ColumnsData }

def readCsv():
    result = {}
    result["examples"] = []
    with open('input.csv') as csvFile:
        reader = csv.reader(csvFile, delimiter=',')
        columns = True
        for row in reader:
            if columns:
                result["columns"] = row
                columns = False
            else:
                result["examples"].append(row)
    return result
"""

def defineLef():
    return (1, 2)  # (min cobert, max premises)


def getComplexInEntry(val):
    return list(val)


def checkLef(l, lef, positives, seed):
    minCobert = lef[0]
    maxPremis = lef[1]
    
    # We check that it has the max premises
    if len(l) > 0 and len(getComplexInEntry(l[0])) >= maxPremis:
        print("Lef function doesnt allows more than " + str(maxPremis) +
              " premises, so any specialization is discarted")
        return False
    
    # We check it has the min positives
    cobert = 0
    for positive in positives:
        complexList = getComplexInEntry(l[0])
        isCobering = True
        for c in complexList:
            if cobert >= minCobert:
                break
            if positive[int(c)] != list(seed.values())[int(c)]:
                isCobering = False
                break
            if isCobering:
                cobert += 1

    if cobert < minCobert:
        print("It doesnt cover the min positives to keep specializing")
        return False

    return True


def applyLef(star, lef, positives, seed, columns):
    maxP = sys.maxsize
    minC = 0
    res = ""
    for e in star:
        cober = 0
        premises = len(getComplexInEntry(e))
        for positive in positives:
            complexList = getComplexInEntry(e)
            isCobering = True
            for c in complexList:
                if positive[int(c)] != list(seed.values())[int(c)]:
                    isCobering = False
                    break
            if isCobering:
                cober += 1
        sys.stdout.write("C"+str(e)+" ")
        for lefR in getComplexInEntry(e):
            sys.stdout.write(str(columns[int(lefR)])+"="+str(seed.get(
                columns[int(lefR)]))+" ")

        print("--> cobert="+str(cober)+" premises="+str(premises))
        if cober >= lef[0] and premises <= lef[1]:
            if cober > minC and premises <= maxP:
                minC = cober
                maxP = premises
                res = e
    print("We choose " + " C"+str(res) + " " +
          str(columns[int(res)])+"="+str(seed.get(columns[int(res)])))
    return res
"""
def getPositives(values):
    return [example for example in values['examples'] if example[len(example)-1] == 'si']


def getNegatives(values):
    return [example for example in values['examples'] if example[len(example)-1] == 'no']

"""
def getPositives(data):
    aux = []
    for i in range (0,len(DataSet)):
        if (DataSet[i][-1] == 1):
            aux.append(DataSet[i])
    return aux


def getNegatives(values):
    aux = []
    for i in range (0,len(DataSet)):
        if (DataSet[i][-1] == 0):
            aux.append(DataSet[i])
    return aux


def getLPrime(columns, search, negatives):
    columnIndex = columns.index(search[0])
    isInLPrime = False
    for negative in negatives:
        if negative[columnIndex] == search[1]:
            isInLPrime = True
            print("C"+str(columnIndex)+"=("+str(search[0])+"="+str(search[1]) +
                  ") -> It covers negatives examples. We have to specialize")
            break
    if not isInLPrime:
        print("C"+str(columnIndex)+"=("+str(search[0])+"="+str(search[1]) +
              ") -> Is ok, it goes to Star")
    return isInLPrime


def getLAndStar(seed, negatives, values):
    l = []
    star = []
    for entry in seed.items():
        if entry[0] != 'clase':
            if getLPrime(values["columns"], entry, negatives):
                l.append(str(values["columns"].index(entry[0])))
            else:
                star.append(str(values["columns"].index(entry[0])))
    return (star, l)


def especializeL(seed, negatives, star, l):
    passeds = dict()
    lPrime = []
    e = []
    for lEntry in l:
        for index, seedEntry in enumerate(seed.items()):
            if index == len(seed.items()) - 1:
                break

            if int(lEntry) in passeds.get(str(index), []):
                print("C"+str(lEntry)+str(index) +
                      ' Already studied backwards')
            elif str(lEntry) == str(index):
                print("C"+str(lEntry)+str(index) +
                      " Same example , discarted")
            elif str(index) in star:
                print("C"+str(lEntry)+str(index) +
                      " Element already in star , discarted")
            else:
                isInLPrime = False
                for negative in negatives:
                    if negative[int(lEntry)] == list(seed.values())[int(lEntry)] and negative[index] == seedEntry[1]:
                        print(
                            "C"+str(lEntry)+str(index)+" It covers negatives examples. We have to specialize")
                        lPrime.append(str(lEntry)+str(index))
                        isInLPrime = True
                if not isInLPrime:
                    print("C"+str(lEntry)+str(index)+" Is ok, it goes to Star")
                    e.append(str(lEntry)+str(index))
            passeds[lEntry] = passeds.get(lEntry, [])+[index]
    return (e, lPrime)


def aq(values, lef):
    print("E = C: every hyphotesis is yes")
    print("L = [()]")
    print("We separate positives and negatives")
    r = []
    rs = dict()
    e = []
    positives = getPositives(values)
    negatives = getNegatives(values)
    print("Positives: " + str(positives))
    print("Negatives: " + str(negatives))
    print("We process the positive examples:")

    matchesIndex = []
    while positives:
        if len(rs) > 0:
            for index, positive in enumerate(positives):
                for rsCondIndex in range(len(rs.keys())):
                    rsKey = list(rs.keys())[rsCondIndex]
                    rsValues = rs[rsKey]
                    shouldMatch = len(rsValues)
                    match = 0
                    for rsValue in rsValues:
                        if positives[index][int(rsKey)] == rsValue:
                            match += 1
                    if shouldMatch == match:
                        matchesIndex.append(index)
        if len(r) > 0:
            sys.stdout.write(
                "Delete the examples of the positive list that cover R=")
            for result in rs.items():
                for res in result[1]:
                    sys.stdout.write("("+values["columns"]
                                     [int(result[0])]+"="+str(res)+") ")
            print("")
        nPositives = [i for j, i in enumerate(
            positives) if j not in set(matchesIndex)]
        positives = nPositives[:]

        if len(positives) > 0:

            positive = positives[0]
            seed = dict(zip(values["columns"], positive))
            seed.pop("clase")
            print("S: " + str(seed))

            res = getLAndStar(seed, negatives, values)
            lPrime = res[1]
            e = res[0]

            print("E="+str(e))
            print("L'="+str(lPrime))
            print("L=L'")
            print('')

            print("We check if we can specialize applying LEF")
            while len(lPrime) != 0 and checkLef(lPrime, lef, positives, seed) is True:
                espe = especializeL(seed, negatives, e, lPrime)
                lPrime = espe[1]
                e = e + espe[0]
                print("E="+str(e))
                print("L'="+str(lPrime))
                print("L=L'")
                print("LEF function to the complex on the star to choose which will pass to the recobert")             
                lefResult = applyLef(
                    e, lef, positives, seed, values["columns"])
                r.append(lefResult)
                for lefR in getComplexInEntry(lefResult):
                    rs[lefR] = rs.get(lefR, []) + \
                        [list(seed.values())[int(lefR)]]
            sys.stdout.write("R=")
            for result in rs.items():
                for res in result[1]:
                    sys.stdout.write("("+values["columns"]
                                     [int(result[0])]+"="+str(res)+") ")
            print("")
    print("Solution: ")
    for result in rs.items():
        for res in result[1]:
            sys.stdout.write(values["columns"]
                             [int(result[0])]+"="+str(res)+" ")
    print("")


values = dicc2
lef = defineLef()
aq(values, lef)