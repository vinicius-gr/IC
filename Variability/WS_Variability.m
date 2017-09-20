%--------------------------------------------------------------------------
%  -----  WS_Variability.m
%
%DESC: exemplos de algumas métricas e medidas de variabilidade
%
%
%   DDA   10/04/2016
%--------------------------------------------------------------------------

%clean up the environment and the command window
clc;
clear all;

%load sample partitions for evaluation purposes
L1 = load( '.\samplePs\L_EAC_SLiris1.mat' );
L1 = L1.L_SL;

L2 = load( '.\samplePs\L_SoPDiris1.mat' );
L2 = L2.L_SoPD;

L3 = load( '.\samplePs\L_BestOfK_iris1.mat' );
L3 = L3.L_BoK;

L4 = load( '.\samplePs\L_CSPAiris1.mat' );
L4 = L4.L_cspa;

%-------------------------------------------------

er = errorRate       ( L2, L4, 3 ) * 100;
fm = FMeasure        ( L2, L4 );
vi = VI_distance     ( L2, L2  );
mi = Mirkin_distance ( L2, L4  );
do = Dongen_distance ( L2, L4  );
rd = Rand_distance   ( L2, L2  );
    



