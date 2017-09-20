function E = highVIrandomEnsemble(N, K, M, p)
%this function takes as input N as the number of objects, K as the number
%of subgroups and M as the number of partitions in the ensemble and outputs
%E as an ensemble of M partitions each with K subgroups in which it seeks
%to produce random partitions with are pairwise as close to VI = 2log2K as
%possible. The variable p [0,1] indicates how close we want the variability
%of the partitions to be to the Upper Bound.
%
%DDA 09.05.2017

%initially an empty ensemble
E = [];

%compute the strict VI Upper Bound for N,K
UB = 2 * log2( K );

%initial random partition, anyone is good since there is nothing yet to
%compare with
E(:,1) = randomPartition( N, K );

%iterativelly create the ensemble which fills the criteria
for i = 2 : M
    
    %havent found yet a partition who fills the criteria
    foundOne = false;
    while (foundOne == false)
        %new candidate partition
        candidate = randomPartition( N, K );
        
        foundOne = true; %we hope this partition fills the criteria
        %test if it fills to all previously added partitions in E
        for j = 1 : ( i - 1 )
            vi_i_c = VI_distance( E(:,j), candidate );
            if( vi_i_c < ( UB - ( UB*p ) ) )%it fails to fill
                foundOne = false;
            end;%fi
        end;%for
    end;%while
    E(:,i) = candidate;   
    
end;

