%correct.m
%compute the percentage of correctly classified patterns
%
%
%DDA 12.05.2017
function p = correct( P, GT )

K = max([max(P) max(GT)]); 
%variable initialization
W = zeros( K ); 

N = size( P, 1 );
%produce the matrix of weights
for l = 1 : K %iterate over all lines
  for c = 1 : K %iterate over all collumns 
    inter_res = modNotIntersect( P, GT, l, c );
    W(l,c) = inter_res;  
  end;%c
end;%l


[Matching,Cost] = Hungarian( W );

%vetorize the mapping
for j = 1 : K
    [v id(j)] = max(Matching(:,j) );
end;%j

count = 0;
%remap the partition
for j = 1 : N
    P(j,1) = id(P(j,1));
    
    if(P(j,1)==GT(j,1))
        count = count + 1;
    end;%fi
end;%j

p = (count /N)*100;

