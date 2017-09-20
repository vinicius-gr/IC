%WS_Experiment_iris
%dataset #15
%
%various experiments with the iris dataset
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
%Generate a complete Ensemble using all clustering functions available in F
for i = 1 : 32
    E(:,i) = clusterID(P, K, i);
end;%for i

%--------------------------------------------------------------------------
%Compute the errorRate and VI for every partition
for i = 1 : 32
    results(1,i) = errorRate( E(:,i), GT, K ) * 100;
    results(2,i) = VI_distance( E(:,i), GT );
    
end;%for i

%--------------------------------------------------------------------------
%incrementally compute the ER and VI of BOK, BOEM ,EAC_SL e EAC_AL for all
%sizes of ensembles 2 -> 32
for i = 2 : 32
    %_____________________________________________________
    %     |     Error Rate        |     VI                |
    %|size| BoK | BOEM| SL  |  AL | BoK | BOEM| SL  |  AL |
    %| 2  |     |     |     |     |     |     |     |     |    
    %| 3  |     |     |     |     |     |     |     |     |    
    %| 4  |     |     |     |     |     |     |     |     |    
    %| ...|     |     |     |     |     |     |     |     |  
    %|____|_____|_____|_____|_____|_____|_____|_____|_____|
    Cm = [];
    P2 = [];
    CM = computeCoAssociationMatrix( E(:,1:i), N );
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
    LBoK = BoK( E(:,1:i) );
    er_BOK = errorRate( LBoK, GT, K ) * 100;
    vi_BOK = VI_distance(LBoK, GT);
    
    %%BOEM
    LBOEM = BOEM( E(:,1:i) );
    er_BOEM = errorRate( LBOEM, GT, K ) * 100;
    vi_BOEM = VI_distance(LBOEM, GT);
    
    
    resultsEnsemble(i,1) = i;
    resultsEnsemble(i,2) = er_BOK;
    resultsEnsemble(i,3) = er_BOEM;
    resultsEnsemble(i,4) = er_EAC_SL;
    resultsEnsemble(i,5) = er_EAC_AL;
    
    resultsEnsemble(i,6) = vi_BOK;
    resultsEnsemble(i,7) = vi_BOEM;
    resultsEnsemble(i,8) = vi_EAC_SL;
    resultsEnsemble(i,9) = vi_EAC_AL;
    
end;%for i

    
    