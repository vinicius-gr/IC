function gamma = randomPartition(N, K)
%this function takes as input N as the number of objects in the dataset and
%K the number of subgroups and outputs a labeled [1..K] partition of the
%dataset. It does not consider the dataset per se, only its dimensions
%
%DDA 09.05.2017

%generate a random collumn vector of N objects with labels ranging from 1
%to K
gamma = randi(K,1,N)';

