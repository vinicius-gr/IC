%WS_Experiment_iris2
%
%
%DDA 11.05.2017

clear all

%path where all available datasets are
dsPath = 'C:\Users\Daniel\Dropbox\src\Variability\datasets\';

M      = 10; %number of partitions in the ensemble
Fmod   = 32; %number of clustering functions available

E      = []; %ensemble of partitions
dsName = 'iris.mat';
disp(['processing ...(' dsName ')']);
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

%compute the upper bound and the mid range
UB = 2*log2(K);
mu = UB/2;

%--------------------------------------------------------------------------
%Generate an Ensemble with kmeans, hierarchical_SL, hierarchical_AL,
%Spectral and DBSCAN

indexes = [1 6 2 26 31];
for i = 1 : 5
    E(:,i) = clusterID(P, K, indexes(i));
end;%for i

%Compute the errorRate and VI for every partition
for i = 1 : 5
    results(1,i) = (1 - errorRate( E(:,i), GT, K ))*100;
    results(2,i) = VI_distance( E(:,i), GT );
    
end;%for i

%compute the pairwise variability
PW_VI = [];
for i = 1 : 5
    for j = 1 : 5
        PW_VI(i,j) = VI_distance( E(:,i), E(:,j) );
    end;%for j
end;%for i

Cm = [];
P2 = [];
CM = computeCoAssociationMatrix( E, N );
P2 = squareform( CM,'tovector' );

%Compute the average link over the co-association matrix
%%EAC_AL
LAL = linkage( P2,'average' );
T_AL = cluster( LAL,'maxclust', K );
er_EAC_AL = (1 - errorRate( T_AL, GT, K ))*100;
vi_EAC_AL = VI_distance(T_AL, GT);

%Compute the average link over the co-association matrix
%%EAC_SL
LSL = linkage( P2,'average' );
T_SL = cluster( LSL,'maxclust', K );
er_EAC_SL = (1 - errorRate( T_SL, GT, K ))*100;
vi_EAC_SL = VI_distance(T_SL,GT);

%%BoK
LBoK = BoK_VI( E );
er_BOK = (1 - errorRate( LBoK, GT, K ))*100;
vi_BOK = VI_distance(LBoK, GT);

%%BOEM
LBOEM = BOEM_VI( E );
er_BOEM = (1 - errorRate( LBOEM, GT, K ))*100;
vi_BOEM = VI_distance(LBOEM, GT);

%%Majority Vote
LMaj = majorityVote( E );
er_Maj = (1 - errorRate( LMaj, GT, K ))*100;
vi_Maj = VI_distance(LMaj, GT);

resultsEnsemble(1,1)  = i;
resultsEnsemble(1,2)  = er_BOK;
resultsEnsemble(1,3)  = er_BOEM;
resultsEnsemble(1,4)  = er_EAC_SL;
resultsEnsemble(1,5)  = er_EAC_AL;
resultsEnsemble(1,6)  = er_Maj;

resultsEnsemble(1,7)  = vi_BOK;
resultsEnsemble(1,8)  = vi_BOEM;
resultsEnsemble(1,9)  = vi_EAC_SL;
resultsEnsemble(1,10) = vi_EAC_AL;
resultsEnsemble(1,11) = vi_Maj;
results
resultsEnsemble
