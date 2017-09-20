%WS_Experiment_DifferentEnsembles.m
%
%
% DDA 12.05.2017

clear all

%path where all available datasets are
dsPath = 'C:\Users\Daniel\Dropbox\src\Variability\datasets\';

% ds = {'arrhythmia.mat' 'australian.mat' 'balance.mat' 'breast.mat' ...
%     'constraceptive.mat' 'dermatology.mat' 'diabetes.mat' 'ecoli.mat' ...
%     'german.mat' 'glass.mat' 'haberman.mat' 'hayes.mat' 'heart.mat' ...
%     'ionosphere.mat' 'iris.mat' 'liver.mat' 'lung.mat'  ...
%     'mammo.mat' 'libras.mat' 'optic.mat' 'pageblocks.mat' ...
%     'parkinsons.mat' 'post_op.mat' 'protein.mat' 'satellite.mat' ...
%     'segmentation.mat' 'sonar.mat' 'soybean.mat' 'spect.mat' ...
%     'spectf.mat' 'control.mat' 'taeval.mat' 'tic-tac-toe.mat' ...
%     'transfusion.mat' 'vehicle.mat' 'vowel.mat' 'wine.mat' ...
%     'yeast.mat' };

ds = {'halfrings.mat' 'twoRings.mat' 'celipsoid.mat' 'scattered.mat' '2D2k.mat' '8D5k.mat'};

numDs = size(ds,2);
M      = 10; %number of partitions in the ensemble
Fmod   = 32; %number of clustering functions available

for j = 1 : numDs + 1
    %j = 15
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
    
    UB = 2*log2(K);
    mu = UB/2;
    
    %--------------------------------------------------------------------------
    %(#1) Generate a bias (low variability) ensemble
    E_low = [];
    for i = 1 : M
        %generate a single partition of P
        L = [];
        L = kmeans( P, K, 'start', 'uniform', 'emptyaction', 'singleton'  );
        
        E_low(:,i) = L;
    end;%for i
    
    %--------------------------------------------------------------------------
    %(#2) Generate a random partition (high variability)ensemble
    E_high = highVIrandomEnsemble(N, K, M, 0.2);
    
    %--------------------------------------------------------------------------
    %(#3) Generate an ensemble in which the clustering functions are picked at
    %random
    E_random = [];
    already_used = zeros( 1, Fmod );
    for i = 1 : M
        [E_random(:,i), id] = nextAvailable( P, K, already_used );
        already_used(id) = true;
    end;%for i
    
    %--------------------------------------------------------------------------
    %(#4) Generate an optimized ensemble
    E_optimized = createEnsemble( P, K, M, 0.2 );
    
    %--------------------------------------------------------------------------
    %compute the results of the ensembles
    [ R1acc, R1vi ] = evaluateEnsemble( E_low,       K, GT );
    [ R2acc, R2vi ] = evaluateEnsemble( E_high,      K, GT );
    [ R3acc, R3vi ] = evaluateEnsemble( E_random,    K, GT );
    [ R4acc, R4vi ] = evaluateEnsemble( E_optimized, K, GT );
    
    [ R1E, RP1acc, RP1vi ] = evaluatePartitions(E_low,       K, GT );
    [ R2E, RP2acc, RP2vi ] = evaluatePartitions(E_high,      K, GT );
    [ R3E, RP3acc, RP3vi ] = evaluatePartitions(E_random,    K, GT );
    [ R4E, RP4acc, RP4vi ] = evaluatePartitions(E_optimized, K, GT );
    
    Racc(j,:) = [R1acc R2acc R3acc R4acc];
    Rvi(j,:)  = [R1vi  R2vi  R3vi  R4vi];
    
    RPacc(j,:) = [RP1acc RP2acc RP3acc RP4acc];
    RPvi(j,:)  = [RP1vi  RP2vi  RP3vi  RP4vi];
    
end;%for j
