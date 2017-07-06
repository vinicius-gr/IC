import pandas as pd
from sklearn.cluster import KMeans

#lendo dataset
dataset = pd.read_csv('dados.csv')
#removendo a ultima coluna dos dados
X = dataset.iloc[:,[0,1,2,3]].values
#aplicando k-means
kmeans = KMeans(n_clusters=3, init='k-means++', max_iter=300,n_init=10,random_state=0)
y_kmeans = kmeans.fit_predict(X)
#armazenando os centroides separadamente
centroides = kmeans.cluster_centers_
#Separando os 3 clusters em 3 listas, e inserindo-os em uma quarta lista, pra calcular as distancias euclidianas entre os pontos
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