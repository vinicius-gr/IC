%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          CONFUSION MATRIX
%
%Daniel D. Abdala
%
%06.08.07 - transposition from a workspace to a method
%
%desc: this function compute, given two segmented images, the average
%correspondence between each segment. It basically show the intersection
%between all the segments
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function confMatrix = confusionMat(MS,GT, numSegsMS, numSegsGT)
%Code to compute the confusion matrix

k = numSegsMS;
l = numSegsGT;

if k > l
  l = k;
else
  k = l;
end;

confMatrix = zeros(k,l);
for i=1 : k
  for j=1 : l
    confMatrix(i,j) = modintersect(MS,GT,i,j);
  end; % for j
end;% for i



