function gamma_index = fartherstPartition( E )
%this function return the index of the partition in E which attains the
%largest delta from the mean interval defined by [LB,UB]_VI. This value
%means it is the closest among the partitions in E from the Upper Bound or
%the Lower Bound.

%maximum number of subsets in the partitions of the ensemble
K = max( unique( E ) );

%number of partitions in the ensemble
M = size(E,2);

%define the interval in which the VI values will habitate
LB = 0;
UB = 2 * log2( K );
mu = (UB - LB) / 2;

%initially no partition selected
gamma_index = 0; 

%cummulative value |mu - VI(E(:,i),E(:,j))|
largest_term = 0; 
for i = 1 : M
    term = 0;
    for j = 1 : M
        if (i ~= j)
            term = term + abs( mu - VI_distance( E(:,i), E(:,j) ) );
        end;%fi
    end;%j
    if ( term > largest_term )
        largest_term = term;
        gamma_index = i;
    end;%fi
end%i


