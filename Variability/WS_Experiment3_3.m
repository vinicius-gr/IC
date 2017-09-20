%this workspace implements an experiment in which an initial ensemble is
%generated two ways, maximum variability or no variability. Both ensembles
%are optmized to ensure ensemble variability representativity and then BoK
%BOEM, EAC_SL and EAC_AL are computed for all steps of the optimization
%process. Results are given in both VI and errorRate
%
%
%DDA 11.05.2017

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
j = 15
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

    %Compute the consensus functions for each stage of the optimization
    %procedure (high variability)
    for stage = 1 : size(E_T,3)

        CM = computeCoAssociationMatrix( E_T(:,:,stage), N );
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
        LBoK = BoK( E_T(:,:,stage) );
        er_BOK = errorRate( LBoK, GT, K ) * 100;
        vi_BOK = VI_distance(LBoK, GT);
    
        %%BOEM
        LBOEM = BOEM( E_T(:,:,stage) );
        er_BOEM = errorRate( LBOEM, GT, K ) * 100;
        vi_BOEM = VI_distance(LBOEM, GT);
    
        resultE(stage,1) = er_BOK;
        resultE(stage,2) = er_BOEM;
        resultE(stage,3) = er_EAC_SL;
        resultE(stage,4) = er_EAC_AL;
        resultE(stage,5) = vi_BOK;
        resultE(stage,6) = vi_BOEM;
        resultE(stage,7) = vi_EAC_SL;
        resultE(stage,8) = vi_EAC_AL;
    end;%stage
    
    %Compute the consensus functions for each stage of the optimization
    %procedure (low variability)
    for stage = 1 : size(E_T2,3)

        CM = computeCoAssociationMatrix( E_T2(:,:,stage), N );
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
        LBoK = BoK( E_T2(:,:,stage) );
        er_BOK = errorRate( LBoK, GT, K ) * 100;
        vi_BOK = VI_distance(LBoK, GT);
    
        %%BOEM
        LBOEM = BOEM( E_T2(:,:,stage) );
        er_BOEM = errorRate( LBOEM, GT, K ) * 100;
        vi_BOEM = VI_distance(LBOEM, GT);
    
        resultE2(stage,1) = er_BOK;
        resultE2(stage,2) = er_BOEM;
        resultE2(stage,3) = er_EAC_SL;
        resultE2(stage,4) = er_EAC_AL;
        resultE2(stage,5) = vi_BOK;
        resultE2(stage,6) = vi_BOEM;
        resultE2(stage,7) = vi_EAC_SL;
        resultE2(stage,8) = vi_EAC_AL;
    end;%stage
    
    
    
     [pathstr,name,ext] = fileparts(dsName);
     disp(['finished-' name ]);
%     figure
%     hold on
%     
%     title(['ensemble results for the valious steps of the (' name ' dataset)']);
%     xlabel('iterations');
%     ylabel('error rate');
%     xlim([0 max(size(E_T,3),size(E_T2,3))+1])
%     ylim([0 100])
%     
%     p1 = plot(resultE(:,1),'-+')
%     set(p1,'Color','magenta','LineWidth',2)
%     text(28,4,'-+ BoK');
%     
%     p2 = plot(resultE(:,2),'-o')
%     set(p2,'Color','cyan','LineWidth',2)
%     text(28,8,'-o BOEM');
%     
%     p3 = plot(resultE(:,3),'-*')
%     set(p3,'Color','black','LineWidth',2)
%     text(28,12,'-* EAC_{SL}');
%     
%     p4 = plot(resultE(:,4),'-x')
%     set(p4,'Color','blue','LineWidth',2)
%     text(28,16,'-x EAC_{AL}');
%     
%     
%     %----------------------------------------------------------------------
%     figure
%     hold on
%     
%     title(['ensemble results for the valious steps of the (' name ' dataset)']);
%     xlabel('iterations');
%     ylabel('variation of information');
%     xlim([0 max(size(E_T,3),size(E_T2,3))+1])
%     ylim([0 UB+1])
%     
%     p5 = plot(resultE(:,5),'-+')
%     set(p5,'Color','magenta','LineWidth',2)
%     %text(28,4,'-+ BoK');
%     
%     p6 = plot(resultE(:,6),'-o')
%     set(p6,'Color','cyan','LineWidth',2)
%     %text(28,8,'-o BOEM');
%     
%     p7 = plot(resultE(:,7),'-*')
%     set(p7,'Color','black','LineWidth',2)
%     %text(28,12,'-* EAC_{SL}');
%     
%     p8 = plot(resultE(:,8),'-x')
%     set(p8,'Color','blue','LineWidth',2)
%     %text(28,16,'-x EAC_{AL}');
%     
%     text(15,2,'E_0 high variability')
%     
%     
%     p9 = plot([0 max(size(E_T,3),size(E_T2,3))], [mu mu]);
%     set(p9,'Color','green','LineWidth',2)
%     p10 = plot([0 max(size(E_T,3),size(E_T2,3))], [UB UB]);
%     set(p10,'Color','red','LineWidth',2)
%     text(20,UB+0.2, 'Upper Bound');
%     
%     p11 = plot(resultE2(:,5),'-+')
%     set(p11,'Color','magenta','LineWidth',2)
%     %text(28,4,'-+ BoK');
%     
%     p12 = plot(resultE2(:,6),'-o')
%     set(p12,'Color','cyan','LineWidth',2)
%     %text(28,8,'-o BOEM');
%     
%     p13 = plot(resultE2(:,7),'-*')
%     set(p13,'Color','black','LineWidth',2)
%     %text(28,12,'-* EAC_{SL}');
%     
%     p14 = plot(resultE2(:,8),'-x')
%     set(p14,'Color','blue','LineWidth',2)
%     %text(28,16,'-x EAC_{AL}');
%     
%     text(15,2,'E_0 low variability')
    
    
    
    
%end;%for



