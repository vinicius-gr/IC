%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%DDA 17.02.2010
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dong =Dongen_distance( C1, C2 )
[l c] = size( C1 );
if l > c
  C1 = C1';
  C2 = C2';
end;


N = size ( C1, 2 );
K = max( C1 );

cm = confusionMat( C1, C2, K, K );

aC1C2 = 0;
for count = 1 : K
    aC1C2 = aC1C2 + max( cm(count, :) );
    
end;

aC2C1 = 0;
for count = 1 : K
    aC2C1 = aC2C1 + max( cm(:, count) );
  
end;

dong = ( 2 * N ) - aC1C2 -aC2C1;
dong = dong / N;


%  lastIndex = max( C1 );
%  aC1C2 = 0;
%  for cont2 = 1 : lastIndex
%    [tmp, indMaxMS] = maxIntersectMod( C1, C2, cont2 );
%    aC1C2 = aC1C2 + tmp;
%  end;
%  
%  %aC2C1
%  lastIndex = max( C2 );
%  aC2C1 = 0;
%  for cont2 = 1 : lastIndex
%    [tmp, indMaxMS] = maxIntersectMod( C2, C1, cont2 );
%    aC2C1 = aC2C1 + tmp;
%  end;
%  
%  n = size (C1, 1);
%  
%  Dongen = 2*n - aC1C2 - aC2C1;
%  dong = Dongen / n;