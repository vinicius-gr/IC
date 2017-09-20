%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%Daniel Duarte Abdala
%05.08.07 - creation
%06.08.07 - indexes adjustments 
%
%Desc: Compute the cardinality of each segments in a givem segmented image
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function mat = cardinalityMatrix(S)

[l c] = size( S );
if l > c
  S = S';
end;

lastIndex = max(max(S));
mat = zeros(lastIndex,1);
for i = 1 : size(S,2)
  mat(S(i)) = mat(S(i)) + 1;   
end;

