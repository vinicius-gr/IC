%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%DDA 17.02.2010
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rand =Rand_distance( C1, C2 )

N = size ( C1, 1 );
K = max( C1 );

cm = confusionMat( C1, C2, K, K );
cmp1 = cardinalityMatrix( C1 );
cmp2 = cardinalityMatrix( C2 );
[N00, N01, N10, N11] = calcNxx( cm, C1, C2 , K, K, cmp1, cmp2 );

rand = ( ( N11 + N00 ) / ( ( N *( N - 1 ) ) /2 ) );
