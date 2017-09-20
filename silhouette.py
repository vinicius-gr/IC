# -*- coding: utf-8 -*-
"""
Created on Tue Sep  5 15:09:49 2017

@author: Vinicius
"""

'''
Varia de -1 a 1.
Valores negativos indicam que o ponto esta no cluster errado
e deve se encaixar melhor em outro cluster.
Valores proximos a 0 indica sobreposicao de clusters.
'''

import numpy as np
from sklearn.utils import check_X_y
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics.pairwise import pairwise_distances


def check_number_of_labels(nro_labels, nro_samples):
    if not 1 < nro_labels < nro_samples:
        raise ValueError("Number of labels is %d. Valid values are 2 "
                         "to nro_samples - 1 (inclusive)" % nro_labels)

def silhouette_index(dados, labels):
    return np.mean(silhouette_samples(dados, labels, metric='euclidean'))

def silhouette_samples(dados, labels, metric='euclidean'):
    dados, labels = check_X_y(dados, labels, accept_sparse=['csc', 'csr'])
    le = LabelEncoder()
    labels = le.fit_transform(labels)
    check_number_of_labels(len(le.classes_), dados.shape[0])

    distancias = pairwise_distances(dados, metric='euclidean')
    labels_unicas = le.classes_
    nro_pontos_por_label = np.bincount(labels, minlength=len(labels_unicas))

    # Par a cada ponto, armazena em distancias_internas[i] a distancia 
    # media do cluster ao qual pertence 
    distancias_internas = np.zeros(distancias.shape[0], dtype=distancias.dtype)

    # Par a cada ponto, armazena em distancias_externas[i] a distancia 
    # media do segundo cluster mais proximo
    distancias_externas = np.inf + distancias_internas

    for label_atual in range(len(labels_unicas)):

        # Encontra a distancia inter para todos os pontos pertencentes ao
        # mesmo agrupamento
        mask = labels == label_atual
        distancias_atuais = distancias[mask]

        # Deixa o ponto atual
        nro_pontos_label_atual = nro_pontos_por_label[label_atual] - 1
        if nro_pontos_label_atual != 0:
            distancias_internas[mask] = np.sum(
                distancias_atuais[:, mask], axis=1) / nro_pontos_label_atual
        
        # Agora itera sobre todos os outros clusters, encontrando
        # a distancia media que esteja mais proxima de cada ponto.
        for prox_label in range(len(labels_unicas)):
            if prox_label != label_atual:
                prox_mask = labels == prox_label
                prox_distancias = np.mean(
                    distancias_atuais[:, prox_mask], axis=1)
                distancias_externas[mask] = np.minimum(
                    distancias_externas[mask], prox_distancias)

    amostras_silhuetas = distancias_externas - distancias_internas
    amostras_silhuetas /= np.maximum(distancias_internas, distancias_externas)
    # Retorna 0 caso o cluster tenha tamanho 1.
    amostras_silhuetas[nro_pontos_por_label.take(labels) == 1] = 0
    return amostras_silhuetas
                
            
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    