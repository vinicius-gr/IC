%createEnsemble.m
%this function takes as input a Dataset (D), the number of desired 
%clusters (K) and the percentage of variability desired and returns an 
%ensemble of at most M partitions
%
%DDA 12.05.2017
function E = createEnsemble( D, K, M, alpha )

%number of objects
N = size( D, 1 );

%compute the upper bound and the mid range
UB = 2*log2(K);
mu = UB/2;

F_mod = 32; %number of available clustering functions
already_used = zeros(1,F_mod); %list of clustering functions already used

%create the initial partition
%add kmeans as default. Since we know nothing about the dataset any
%clustering function is as good as any
E(:,1) = clusterID( D, K, 1 );
M = 1;
already_used(1,1) = true;

%iterate over all possible clustering functions available
while ( sum( already_used) < F_mod )
    %pick another clustering function at random
    [L, id] = nextAvailable( D, K, already_used );
    already_used(id) = true;
    
    %compute the variability of the candidate partition and the ones
    %already in the ensemble
    VarXY = zeros( size( E, 2 ),1 );
    for i = 1 : size( E, 2 )
        VarXY(i,1) = VI_distance( L, E(:,i) );
    end;%for i
    %find the partition which has the minimum variation to the candidate
    [s, id] = min( VarXY );
    
    %if it falls within the range of interest add the candidate partition
    %to the ensemble
    if( ( s >= ( UB * alpha ) ) && ( s <= ( UB/2 ) ) )
        M = M+1;
        E(:, M) = L; 
    end;%fi
    
end;%while
    
    
    