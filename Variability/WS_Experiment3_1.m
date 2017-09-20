%This workspace simply generates clustering results for all datasets
%available

%
% DDA 10.05.2017
clear all

%path where all available datasets are
dsPath = 'C:\Users\Daniel\Dropbox\src\Variability\datasets\';

ds = {'arrhythmia.mat' 'australian.mat' 'balance.mat' 'breast.mat' ...
    'constraceptive.mat' 'dermatology.mat' 'diabetes.mat' 'ecoli.mat' ...
    'german.mat' 'glass.mat' 'haberman.mat' 'hayes.mat' 'heart.mat' ...
    'ionosphere.mat' 'iris.mat' 'liver.mat' 'lung.mat' 'magic.mat' ...
    'mammo.mat' 'libras.mat' 'optic.mat' 'pageblocks.mat' ...
    'parkinsons.mat' 'post_op.mat' 'protein.mat' 'satellite.mat' ...
    'segmentation.mat' 'sonar.mat' 'soybean.mat' 'spect.mat' ...
    'spectf.mat' 'control.mat' 'taeval.mat' 'tic-tac-toe.mat' ...
    'transfusion.mat' 'vehicle.mat' 'vowel.mat' 'wine.mat' ...
    'yeast.mat' };
numDs = size(ds,2);
M      = 10; %number of partitions in the ensemble


for j = 19 : numDs
    E      = []; %ensemble of partitions
    dsName = ds{j};
    disp(dsName);
    K  = 0;
    GT = [];
    P  = [];
    %load the specificed dataset
    load([dsPath dsName]);
    %it loads
    %GT - a Nx1 matrix representing the ground truth
    %K  - the true number of clusters
    %P  - a NxA matrix in which A is the number of the attributes
    N = size(P,1); %number of objects in P
    
    %Generate some clustering results for tests
    
    L1 = kmeans( P, K, 'start', 'uniform', 'emptyaction', 'singleton' );
    results(j,1) = VI_distance( L1, GT );
    
    z = linkage( P,'single' );
    L2 = cluster(z,K,K);
    results(j,2) = VI_distance( L2, GT );
    
    z = linkage( P,'average' );
    L3 = cluster(z,K,K);
    results(j,3) = VI_distance( L3, GT );
    
    sigma = 2;
    [L4, evalues, evectors] = spcl(P, K, sigma, 'kmean', [2 2]);
    results(j,4) = VI_distance( L4, GT );
    
    sigma = 5;
    [L5, evalues, evectors] = spcl(P, K, sigma, 'kmean', [2 2]);
    results(j,5) = VI_distance( L5, GT );
    
    sigma = 8;
    [L6, evalues, evectors] = spcl(P, K, sigma, 'kmean', [2 2]);
    results(j,6) = VI_distance( L6, GT );
    
    sigma = 11;
    [L7, evalues, evectors] = spcl(P, K, sigma, 'kmean', [2 2]);
    results(j,7) = VI_distance( L7, GT );
    
    
    epsilon = 0.5;
    MinPts = (N/K)*0.25; %minimum of 25% of the points in a cluster divided by the number of clusters
    L8 = DBSCAN(P,epsilon,MinPts) + 1; %because DBSCAN starts at label 0 and all other algorithms in Label 1
    max(L8)
    results(j,8) = VI_distance( L8, GT );
    
    epsilon = 0.25;
    MinPts = (N/K)*0.25; %minimum of 25% of the points in a cluster divided by the number of clusters
    L9 = DBSCAN(P,epsilon,MinPts) + 1; %because DBSCAN starts at label 0 and all other algorithms in Label 1
    max(L9)
    results(j,9) = VI_distance( L9, GT );
    
end;%for