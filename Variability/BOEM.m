%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function L = BOEM( EM )

[N, M] = size ( EM );
maxk = ceil(max( max( EM ) )/5);
if maxk > 50
  maxk = 50;
end;
pi_star = BoK( EM );

SoD =  computeSoD( pi_star, EM );
display(['maxk= ', num2str(maxk), ' N = ', num2str(N)]);
%iterates over all partitions
for cP1 = 1 : N
  bestK = pi_star( cP1,1 ); %original label
  
  for cLabel = 1 : maxk
    pi_star(cP1, 1) = cLabel;%test a possible new label for the curr. patt.
    sod_r = computeSoD( pi_star, EM );
    if sod_r < SoD
      bestK = cLabel;
      SoD = sod_r;
      
      break
    end;
  end;
  %disp([num2str(cP1), ' -- ', num2str(SoD)]);
  pi_star(cP1, 1) = bestK;
end;
L = pi_star;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sod_r = computeSoD( CC, EM )

[N, M] = size ( EM );

SoD = zeros( M, 1 );
for i = 1 : M
    dist = sdd( CC, EM(:,i) );
    SoD(i,1) = dist;
end;
sod_r = sum(SoD) / M  ;

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


