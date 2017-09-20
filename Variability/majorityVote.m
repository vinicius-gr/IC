%majorityVote.m
%implements the majority vote in the context of ensemble clustering
%
%DDA 11.05.2017

function L = majorityVote( Eo )

E = Eo;

%size of the dataset and number of partitions
[N, M] = size( E );

K = max( max( E ) ); %number of subsets is equal to the highest label

%fix one partition and match the labels of all others
fixedP = E(:,1);

for i = 2 : M
    %variable initialization
    W = zeros( K ); 

    for l = 1 : K %iterate over all lines
        for c = 1 : K %iterate over all collumns 
            inter_res = modNotIntersect( fixedP, E(:,i), l, c );
            W(l,c) = inter_res;  
        end;%c
    end;%l

    [Matching,Cost] = Hungarian( W );
    
    %vetorize the mapping
    for j = 1 : K
        [v id(j)] = max(Matching(:,j) );
    end;%j
    
    %remap the partition
    for j = 1 : N
        E(j,i) = id(E(j,i));
    end;%j
end;%for i


L   = zeros( size( E, 1 ),1 );
occ = zeros(size( E, 1 ),K );
for i = 1 : N
    for j = 1 : M
        occ(i,E(i,1)) = occ(i,E(i,1)) + 1;
    end;%for j
    [v L(i)] = max(occ(i,:) );
end;%for i



