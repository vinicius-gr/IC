%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bestSoFar = BoK( EM )

[N, M] = size ( EM );

best = 0;
SoD = Inf;
%iterates over all partitions
for cP1 = 1 : M
  sod_r = computeSoD( cP1, EM );
  if sod_r < SoD
    SoD = sod_r;
    best = cP1;
  end;
end;

if best ~= 0
  bestSoFar = EM(:,best);
else
   bestSoFar = 0; 
end;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sod_r = computeSoD( cP1, EM )

[N, M] = size ( EM );

SoD = zeros( M, 1 );
for i = 1 : M
  if cP1 ~= i
    dist = sdd( EM(:,cP1), EM(:,i) );
    SoD(i,1) = dist;
  end;

end;
sod_r = sum(SoD) / (M - 1) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%symmetric difference distance
function d = sdd( C1, C2 )

N = size ( C1, 1 );
K1 = max( C1 );
K2 = max( C2 );

cm = confusionMat( C1, C2, K1, K2 );
cmp1 = cardinalityMatrix( C1 );
cmp2 = cardinalityMatrix( C2 );
[N00, N01, N10, N11] = calcNxx( cm, C1, C2 , K1, K2, cmp1, cmp2 );


%d = N10 + N01;

d = 2 * ( N01 + N10 );


