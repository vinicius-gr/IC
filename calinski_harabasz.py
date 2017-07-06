# -*- coding: utf-8 -*-
"""
Created on Sun Jun 18 23:47:24 2017

@author: Vinicius
"""

# O indice Calinski and Harabasz foi publicado em 1972 é
# baseado nos valores obtidos a partir das somas ssw e
# ssb.

from ssw_ssb import ssw, ssb

def calinski (labels, dataset, nC, centroids):
    
    numerator = ssb(dataset, labels, centroids)
    numerator = numerator/(nC-1)
    
    denominator = ssw(dataset, labels, centroids, nC)
    denominator = denominator/(len(dataset)-nC)
    
    return (numerator/denominator)
    