%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Nxx INDEXES 
%
%Daniel D. Abdala
%
%06.08.07 - transposition from a workspace to a method
%
%desc: this function compute, four indexes, namely, N11, N00, N01, N10
%
%
%Given two clusterings C1 and C2 of a set O ob Objects, we consider all
%pairs of objects (oi,oj), i ~= j from OxO. A pair (oi,oj) falls into one
%of the four categories:
%
%(i)    In the same cluster under both C1 and C2 (the total number of such
%       pair is represented by N11); 
%(ii)   In different clusters under both C1 and C2 (N00)
%(iii)  in the same cluster under C1 but not C2 (N10)
%(iv)   in the same cluster under C2 but not C1 (N01)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [N00, N01, N10, N11] = calcNxx(confMatrix, MS, GT, ... 
                                        numSegsMS, numSegsGT, ...
                                        cardMS, cardGT)


%get the image sizes. They must be equal to both images
width     = size(GT,1);
height    = size(GT,2);
k = numSegsMS;
l = numSegsGT;

%variable initialization 
n         = width * height; %cardinality of O;
N11       = 0;
N00       = 0;
N01       = 0;
N10       = 0;
sumMije2  = 0;
nie2      = 0;
nje2      = 0;

for i = 1 : k
  for j = 1 : l
    mije2 = confMatrix(i,j)^2;
    sumMije2 = sumMije2 + mije2;
    %N11 = N11 + (mije2) - n;
    N11 = N11 + (mije2);
  end;
end;

for i = 1 : k
  nie2 = nie2 + (cardMS(i)^2);
end;
for j = 1 : l
  nje2 = nje2 + (cardGT(j)^2);
end;

N11 = 0.5 * (N11 - n);
N10 = 0.5 * (nie2 - sumMije2); 
N01 = 0.5 * (nje2 - sumMije2); 




%N00 = 0.5 * ( (n^2) - nie2 - nje2 + sumMije2);
N00 = n*n;
N00 = 0.5 * (N00 - nie2 - nje2 + sumMije2);
%obs, the above equation is not working properly 
