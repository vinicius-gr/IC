%evaluatePartitions.m
%This function takes an Ensemble of partitions as input and outputs its
%evaluation regarding the accuracy and variation of information.
%Additionally it also outputs the mean, std, min e max attained values
%DDA 12.05.2017
function [R, Racc, Rvi] = evaluatePartitions( E, K, GT )

[N M] = size( E );

for i = 1 : M
    acc = (1 - errorRate( E(:,i), GT, K ))*100;
    vi  = VI_distance( E(:,i), GT);
    R(i,1) = acc;
    R(i,2) = vi;
end;%for i

Racc(1,1) = mean( R(:,1) );
Racc(1,2) =  std( R(:,1) );
Racc(1,3) =  min( R(:,1) );
Racc(1,4) =  max( R(:,1) );

Rvi(1,1) = mean( R(:,2) );
Rvi(1,2) =  std( R(:,2) );
Rvi(1,3) =  min( R(:,2) );
Rvi(1,4) =  max( R(:,2) );
