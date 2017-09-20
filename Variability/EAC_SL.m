%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CP = EAC_SL( EM, K )

[N, M] = size ( EM );

CM = computeCoAssociationMatrix( EM, N );
P2 = squareform( CM,'tovector' );

%Compute the average link over the co-association matrix
LR= linkage( P2,'single' );
CP = cluster( LR,'maxclust', K );

