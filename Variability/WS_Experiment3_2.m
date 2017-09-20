%This workspace experiments with the idea of ensemble generation which
%presents representative variability and plots the optimization progress
%stepwise as long the optimization process goes on. It considers two
%situations for the initial ensemble, either it starts with maximum random
%variability or with no variability at all

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
Fmod   = 32; %number of clustering functions available

%for j = 4 %: numDs
j = 2
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
    
    %generate an initial ensemble (random high variability)
    E_0 = highVIrandomEnsemble(N, K, M, 0.2);
    
    %generate an initial ensemble (very low initial variability)
    E_1 = [];
    for i = 1 : M
        %generate a single partition of P
        L = [];
        L = kmeans( P, K, 'start', 'uniform', 'emptyaction', 'singleton'  );

        E_1(:,i) = L;
    end;%i
    
    
    %optmize the ensemble
    [E_star, E_T, it] = generateEnsemble( E_0, P, K, 0.2 );
    
    [E_star2, E_T2, it2] = generateEnsemble( E_1, P, K, 0.2 );
    
    %Evaluate the cummulative variability for each stage of the ensemble
    %optimization (high variability)
    for stage = 1 : size(E_T,3)
        C_vi = 0;
        count = 0;
        for i = 1 : (M - 1)
            for j = i+1 : M
                C_vi = C_vi + VI_distance(E_T(:,i,stage),E_T(:,j,stage));
                count = count + 1;
            end;%for j 
        end;%for i
        %stageX
        results(stage,1) = stage;
        results(stage,2) = C_vi;
        results(stage,3) = C_vi / ((M*(M-1))/2);
        
        
    end;%for stage
    
    %Evaluate the cummulative variability for each stage of the ensemble
    %optimization (low variability)
    for stage = 1 : size(E_T2,3)
        C_vi = 0;
        count = 0;
        for i = 1 : (M - 1)
            for j = i+1 : M
                C_vi = C_vi + VI_distance(E_T2(:,i,stage),E_T2(:,j,stage));
                count = count + 1;
            end;%for j 
        end;%for i
        %stageX
        results2(stage,1) = stage;
        results2(stage,2) = C_vi;
        results2(stage,3) = C_vi / ((M*(M-1))/2);
        
        
    end;%for stage

    
    [pathstr,name,ext] = fileparts(dsName);
    %plot the results
    figure
    hold on
    p1 = plot(results(:,1), results(:,3),'-o')
    p4 = plot(results2(:,1), results2(:,3),'-o')
    set(p4,'Color','magenta','LineWidth',1)
    title(['optimization of ensemble variability (' name ' dataset)']);
    xlabel('iterations');
    ylabel('mean variability');
    
    p2 = plot([0 max(size(E_T,3),size(E_T2,3))], [mu mu]);
    set(p2,'Color','green','LineWidth',2)
    p3 = plot([0 max(size(E_T,3),size(E_T2,3))], [UB UB]);
    set(p3,'Color','red','LineWidth',2)
    text(20,UB+0.1, 'Upper Bound');
    xlim([0 max(size(E_T,3),size(E_T2,3))+1])
    ylim([0 UB+1])
%end;%for