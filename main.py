from  kmeans import X, data, centroides, kmeans, y_kmeans
from ssw_ssb import ssw, ssb
from calinski import calinski
from BH import ball_hall
from xu import xu_score

print("SSW: \n",ssw(X,data,centroides,len(data)))
print("SSW: \n",ssb(X,data,centroides))
print("Calinski: \n", calinski(X,data,centroides, len(data)))
print("Ball and Hall: \n", ball_hall(X,data,centroides, len(data)))
print("Xu index \n", xu_score(X,data,centroides, len(data)))