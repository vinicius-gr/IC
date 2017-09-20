function E = randomEnsemble(N, K, M)
%this function takes as input N as the number of objects, K as the number
%of subgroups and M as the number of partitions in the ensemble and outputs
%E as an ensemble of M partitions each with K subgroups
%
%DDA 09.05.2017

E = [];
for i = 1 : M
    E(:,i) = randomPartition( N, K );
end;

