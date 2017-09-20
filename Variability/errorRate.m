%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%errorRate
%
%DDA 05.12.09
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ER = errorRate(L, C, K)

%variable initialization
W = zeros( K ); 

N = size( L, 1 );
%produce the matrix of weights
for l = 1 : K %iterate over all lines
  for c = 1 : K %iterate over all collumns 
    inter_res = modNotIntersect( C, L, l, c );
    W(l,c) = inter_res;  
  end;%c
end;%l


[Matching,Cost] = Hungarian( W );

ER = Cost / N;
