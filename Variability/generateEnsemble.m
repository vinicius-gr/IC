function [E_star E_T it] = generateEnsemble( E_0, D, K, alpha )
%this function takes as input an initial ensemble of partitions E_0 and
%optmize it regarding its internal variability.
%
%DDA 11.05.2017

E     = E_0;            %makes ensemble equal to initial ensemble
M     = size( E, 2 );   %size of the ensemble
N     = size( D, 1 );   %number of objects in the dataset
UB    = 2*log2( K );    %VI Upper Bound
mu    = UB / 2;         %mean interval
delta = alpha * UB;     %interval of interest

F_mod = 32; %number of available clustering functions
already_used = zeros(1,F_mod); %list of clustering functions already used

%save the ensemble at time 0
E_T(:,:,1) = E;
it(1) = 0;
t = 2; %next change in the ensemble

while ( sum( already_used) < F_mod )%( ( allPartitionWithinRange( E ) == false ) || ...
        
    %find the partition candidate to substitution
    least = fartherstPartition( E );
    
    %select a new clustering algorithm and generate a partition using the 
    %last selected clustering algorithm
    [L, id] = nextAvailable( D, K, already_used );
    already_used(id) = true;
    
    %verify if the newly created partition has variation of information to
    %all other partitions in the ensemble within the range [mu-sd, mu+sd]
    is_good = true;
    for i = 1 : M
        if( i ~= least ) %it is not the least partition
            vi = VI_distance( L, E(:,i) );
            if (~( vi <= mu + delta ) && ( vi >= mu - delta ) )
                is_good = false;
                break;
            end;%fi
        end;%if
    end;%for
    %replace the least adequate partition with the newly created one
    if (is_good)
        E( :, least ) = L;
        E_T(:,:,t) = E;
        it(t) = sum( already_used);
        t = t + 1; %next change in the ensemble

    end;%fi    
end;%while

E_star = E;



