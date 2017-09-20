%evaluateEnsemble.m
%this function computes various consensus functions for the provided
%ensemble and returns both its Accuracy and Variation of information
%
%DDA 12.05.2017
function [Racc, Rvi] = evaluateEnsemble( E, K, GT )

[N M] = size( E );

Cm = [];
P2 = [];
CM = computeCoAssociationMatrix( E, N );
P2 = squareform( CM,'tovector' );

%Compute the average link over the co-association matrix
%%EAC_AL
LAL = linkage( P2,'average' );
T_AL = cluster( LAL,'maxclust', K );
er_EAC_AL = (1 - errorRate( T_AL, GT, K ))*100;
vi_EAC_AL = VI_distance(T_AL, GT);

%Compute the average link over the co-association matrix
%%EAC_SL
LSL = linkage( P2,'average' );
T_SL = cluster( LSL,'maxclust', K );
er_EAC_SL = (1 - errorRate( T_SL, GT, K ))*100;
vi_EAC_SL = VI_distance(T_SL,GT);

%%BoK
LBoK = BoK_VI( E );
er_BOK = (1 - errorRate( LBoK, GT, K ))*100;
vi_BOK = VI_distance(LBoK, GT);

%%BOEM
LBOEM = BOEM_VI( E );
er_BOEM = (1 - errorRate( LBOEM, GT, K ))*100;
vi_BOEM = VI_distance(LBOEM, GT);

%%Majority Vote
LMaj = majorityVote( E );
er_Maj = (1 - errorRate( LMaj, GT, K ))*100;
vi_Maj = VI_distance(LMaj, GT);

Racc(1,1)  = er_BOK;
Racc(1,2)  = er_BOEM;
Racc(1,3)  = er_EAC_SL;
Racc(1,4)  = er_EAC_AL;
Racc(1,5)  = er_Maj;

Rvi(1,1)  = vi_BOK;
Rvi(1,2)  = vi_BOEM;
Rvi(1,3)  = vi_EAC_SL;
Rvi(1,4)  = vi_EAC_AL;
Rvi(1,5)  = vi_Maj;

