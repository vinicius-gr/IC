%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%DDA 17.02.2010
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mirk =Mirkin_distance( C1, C2 )

N = size ( C1, 1 );
K1 = max( C1 );
K2 = max( C2 );


cm = confusionMat( C1, C2, K1, K2 );
cmp1 = cardinalityMatrix( C1 );
cmp2 = cardinalityMatrix( C2 );
[N00, N01, N10, N11] = calcNxx( cm, C1, C2 , K1, K2, cmp1, cmp2 );

%rand = ( ( N11 + N00 ) / ( ( N *( N - 1 ) ) /2 ) );


mirk = 2 * ( N01 + N10 );

%test
%2 * ( N01 + N10 ) == N * ( N - 1 ) * [1 - rand ];