%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CP = EAC_CL( EM, K )

[N, M] = size ( EM );

CM = computeCoAssociationMatrix( EM, N );
P2 = squareform( CM,'tovector' );

%Compute the average link over the co-association matrix
LR= linkage( P2,'complete' );
CP = cluster( LR,'maxclust', K );

