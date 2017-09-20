%BoK_VI.m
%Implement the BoK consensus function using VI as distance measure
% E - ensemble NxM (N objects and M partitions)
% L - partition with minimum sum of distances
%DDA 11.05.2017

function L = BoK_VI( E )

%size of the dataset and number of partitions
[N, M] = size( E );

%compute the upper bound
%UB = log2(N);

%it could never be bigger than this value
%best = UB * M + 1;

%sum of distances
SoD = [];

CM = zeros( M ); 

%compute the matrix MxM of pairwise variation of information
for i = 1 : M - 1
    for j = i+1 : M
        d = VI_distance( E(:,i), E(:,j) );
        CM(i,j) = d;
        CM(j,i) = d; %because the matrix is symmetric
    end;
end;

%compute the sum of the collumns
for i = 1 : M
    SoD(i) = sum( CM(:,i) );
end;

[v i] = min( SoD );

L = E(:,i);
