%The workspace delineates an experiment aiming to show that to generate an
%ensemble with no variability yields no gain of information for the
%ensemble clustering framework
%
%DDA 05.05.2017
%

clear all
%global variables

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
E      = []; %ensemble of partitions

for j = 1 : numDs 
    dsName = ds{j}
    
    %load the specificed dataset 
    load([dsPath dsName]);
    %it loads
    %GT - a Nx1 matrix representing the ground truth
    %K  - the true number of clusters
    %P  - a NxA matrix in which A is the number of the attributes
    N = size(P,1); %number of objects in P

    
    %generate an ensemble of NxM partitions in which all partitions are equal
    clear E;
    er_kmeans = 0;
    for i = 1 : M
        %generate a single partition of P
        L = [];
        L = kmeans( P, K, 'start', 'uniform', 'emptyaction', 'singleton'  );

        E(:,i) = L;
        
        er_kmeans = er_kmeans + errorRate( L, GT, K ) * 100;
    end;%i

    er_kmeans = er_kmeans / M;

    CM = computeCoAssociationMatrix( E, N );
    P2 = squareform( CM,'tovector' );
    
    %Compute the average link over the co-association matrix
    %%EAC_AL
    LAL = linkage( P2,'average' );
    T_AL = cluster( LAL,'maxclust', K );
    er_EAC_AL = errorRate( T_AL, GT, K ) * 100;
    vi_EAC_AL = VI_distance(T_AL, GT);
    
    %Compute the average link over the co-association matrix
    %%EAC_SL
    LSL = linkage( P2,'average' );
    T_SL = cluster( LSL,'maxclust', K );
    er_EAC_SL = errorRate( T_SL, GT, K ) * 100;
    vi_EAC_SL = VI_distance(T_SL,GT);
    
    %%BoK
    LBoK = BoK( E );
    er_BOK = errorRate( LBoK, GT, K ) * 100;
    vi_BOK = VI_distance(LBoK, GT);
    
    %%BOEM
    LBOEM = BOEM( E );
    er_BOEM = errorRate( LBOEM, GT, K ) * 100;
    vi_BOEM = VI_distance(LBOEM, GT);
    
    result(j,1) = er_kmeans; 
    result(j,2) = er_BOK;
    result(j,3) = er_BOEM;
    result(j,4) = er_EAC_SL;
    result(j,5) = er_EAC_AL;
    result(j,6) = vi_BOK;
    result(j,7) = vi_BOEM;
    result(j,8) = vi_EAC_SL;
    result(j,9) = vi_EAC_AL;
end;%j
