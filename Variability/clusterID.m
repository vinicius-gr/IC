function L = clusterID( D, K, id )
%This function partition the dataset 
%
% DDA 11.05.2017

%number of objects and attributes
N = size(D,1);
A = size(D,2);

%number of existing clustering algorithms

candidate = id;

switch candidate
        case 1            
            %L = kmeans( D, K );
            L = kmeans( D, K, 'start', 'uniform', 'emptyaction', 'singleton'  );
            
        case 2
            z=linkage(D,'average');
            L=cluster(z,K,K);
            
        case 3
            z=linkage(D,'centroid');
            L=cluster(z,K,K);
            
        case 4
            z=linkage(D,'complete');
            L=cluster(z,K,K);
            
        case 5
            z=linkage(D,'median');
            L=cluster(z,K,K);
            
        case 6
            z=linkage(D,'single');
            L=cluster(z,K,K);
            
        case 7
            z=linkage(D,'ward');
            L=cluster(z,K,K);
            
        case 8
            z=linkage(D,'weighted');
            L=cluster(z,K,K);
            
        case 9
            z=linkage(D,'average','minkowski');
            L=cluster(z,K,K);
            
        case 10
            z=linkage(D,'centroid','minkowski');
            L=cluster(z,K,K);
            
        case 11
            z=linkage(D,'complete','minkowski');
            L=cluster(z,K,K);
            
        case 12
            z=linkage(D,'median','minkowski');
            L=cluster(z,K,K);
            
        case 13
            z=linkage(D,'single','minkowski');
            L=cluster(z,K,K);
            
        case 14
            z=linkage(D,'ward','minkowski');
            L=cluster(z,K,K);
            
        case 15
            z=linkage(D,'weighted','minkowski');
            L=cluster(z,K,K);
            
        case 16
            z=linkage(D,'average','jaccard');
            L=cluster(z,K,K);
            
        case 17
            z=linkage(D,'centroid','jaccard');
            L=cluster(z,K,K);
            
        case 18
            z=linkage(D,'complete','jaccard');
            L=cluster(z,K,K);
            
        case 19
            z=linkage(D,'median','jaccard');
            L=cluster(z,K,K);
            
        case 20
            z=linkage(D,'single','jaccard');
            L=cluster(z,K,K);
            
        case 21
            z=linkage(D,'ward','jaccard');
            L=cluster(z,K,K);
            
        case 22
            z=linkage(D,'weighted','jaccard');
            L=cluster(z,K,K);
            
       case 23
            eps = 0.5 - 1/N(1);
            minpt= N(1)/K;
            L=DBSCAN(D,eps,minpt)+1;            
            
        case 24
            eps = 0.5 - 1/N(1);
            minpt= N(1)/K;
            minpt = minpt/4;
            L=DBSCAN(D,eps,minpt)+1;            
            
        case 25
            eps = 0.5 - 1/N(1);
            minpt= N(1)/K;
            minpt = minpt/2;
            L=DBSCAN(D,eps,minpt)+1;            
            
        case 26
            eps = 0.25 - 1/N(1);
            minpt= N(1)/K;
            minpt = minpt/2;
            L=DBSCAN(D,eps,minpt)+1;            
            
        case 27
            eps = 0.25 - 1/N(1);
            minpt= N(1)/K;
            L=DBSCAN(D,eps,minpt)+1;            
            
        case 28
            eps = 0.25 - 1/N(1);
            minpt= N(1)/K;
            minpt = minpt/4;
            L=DBSCAN(D,eps,minpt)+1;            
            
        case 29
            sigma = 5;
            [L, evalues, evectors] = spcl(D,K,sigma, 'kmean', [2 2]);            
            
        case 30
            sigma = 9;
            [L, evalues, evectors] = spcl(D,K,sigma, 'kmean', [2 2]);            
            
       case 31
            sigma = 2;
            [L, evalues, evectors] = spcl(D,K,sigma, 'kmean', [2 2]);            
            
        case 32
            sigma = 2;
            [L, evalues, evectors] = spcl(D,K,sigma, 'kmean', [2 2]);            
            
        otherwise
            L = [];
           
end;%switch


