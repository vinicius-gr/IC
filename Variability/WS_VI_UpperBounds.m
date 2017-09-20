%This workspace computes the VI general and strict upper bounds
%the VI general upperbound is VI(X;Y)<= log n
%the VI strict upperbound is VI(X;Y) <= 2 log K
%
%DDA 05.05.2017
%

clear all
%global variables

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
E      = []; %ensemble of partitions

UBs = [];
for j = 1 : numDs 
    dsName = ds{j}
    
    load([dsPath dsName]);
    %it loads
    %GT - a Nx1 matrix representing the ground truth
    %K  - the true number of clusters
    %P  - a NxA matrix in which A is the number of the attributes
    N = size(P,1); %number of objects in P

    UBs(j, 1) = log2(N);
    UBs(j, 2) = 2*log2(K);
    
    clear GT;
    clear K;
    clear P;
end;%j
    
    
    
    