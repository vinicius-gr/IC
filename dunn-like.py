# -*- coding: utf-8 -*-
"""
Spyder Editor

Este é um arquivo de script temporário.
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import math as mt

dataset = pd.read_csv('dados.csv')
dados = dataset.iloc[:, [0,1,2,3]].values

#Aplicando k-means
from sklearn.cluster import KMeans
kmeans = KMeans(n_clusters = 3, init = 'k-means++', max_iter = 300, n_init = 10, random_state = 0)
y_kmeans = kmeans.fit_predict(dados)













#Indice Dunn-like

#Este indice foi proposto por Dunn em 1974 e sua logica consiste em identificar cluster compactos e bem separados.
#É definido da seguinte forma:
#    (1) deve-se calcular a minima distancia entre dois pontos de diferentes clusters.
#    (2) em seguida, deve-se calcular maxima distancia entre dois pontos dentre todos os cluters.
#    (3) deve-se divir o resultado de (1) por (2).
#    (4) busca-se o minimo valor de (3).
#
#Neste indice, todos os cluster sao comparados entre si.

#Separando cada cluster em uma lista, e inserindo-os em uma quarta lista, pra calcular as distancias euclidianas entre os pontos
v1=[]
v2=[]
v3=[]

indice = 0
for x in y_kmeans:
    if x == 0:
        v1.append(indice)
    elif x == 1:
        v2.append(indice)
    else:
        v3.append(indice)
    indice+=1
    
data=[]
data.append(v1)
data.append(v2)
data.append(v3)

    
#A função d calcula a distancia euclidiana entre 2 pontos
def d (x, y):
    aux = 0
    
    for i in range(0,4):
        aux += mt.pow(((dados[x,i]) - (dados[y,i])),2)
        print(mt.sqrt(aux))
    return mt.sqrt(aux)

#Buscando a minima distancia entre 2 pontos de 2 clusters diferentes
def dMin (c1, c2):
    min = d(c1[0], c2[0])
    
    for x in c1:
        for y in c2:
            aux = d(c1[x],c2[y])
            if aux < min:
                min = aux 
                
    return min

#Buscando a maxima distancia entre 2 pontos de 1 mesmo cluster
def diam (c):
    max = d(c[0],c[1])
    
    for x in c:
        for y in c:
            aux = d(c[x],c[y])
            if aux > max:
                max = aux 
    
    return max
    
#Buscando a maxima distancia entre 2 pontos dentre todos os clusters
def maxDiam (data,nC):
    max = diam(data[1])
    
    for x in range(1,nC):
        aux = diam(data[x])
        if aux > max:
            aux = max
            
    return max
            
         
def Dunn1 (data, init, nC):
    min = dMin(data[init], data[init+1])/maxDiam(data, nC)     #inicializando o minimo
    
    for j in range(init+1, nC):                             #variando j de i+1 ate 2
        aux = dMin(data[init], data[j])/maxDiam(data, nC)
        if aux < min:
            aux = min
        
    return min


def Dunn2 (data, nC):
    min = Dunn1(data, 0, nC)        #inicializando o minimo
    
    for i in range(0,nC):           #começando com i em 0 ate 2
        aux = Dunn1(data, i, nC)    
        if aux < min:
            aux = min
            
    return min


resultado = Dunn2(data, 2)