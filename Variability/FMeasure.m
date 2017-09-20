%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%DDA 17.02.2010
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fm = FMeasure( C1, C2 )

N = size ( C1, 1 );
K1 = max( C1 );
K2 = max( C2 );

cm = confusionMat( C1, C2, K1, K2 );
cmp1 = cardinalityMatrix( C1 );
cmp2 = cardinalityMatrix( C2 );
[N00, N01, N10, N11] = calcNxx( cm, C1, C2 , K1, K2, cmp1, cmp2 );

P = N11 / N10;
R = N11 / N01;
if R == Inf 
  R = 0;
end;

fm = 2 * ( ( P * R ) / ( P + R ) );
