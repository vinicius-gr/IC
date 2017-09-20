%BOEM_VI.m
%Implement the BOEM consensus function using VI as distance measure
% E - ensemble NxM (N objects and M partitions)
% L - partition with minimum sum of distances
%DDA 11.05.2017

function L = BOEM_VI( E )

%size of the dataset and number of partitions
[N, M] = size( E );

K = max( max( E ) ); %number of subsets is equal to the highest label

%initial candidate consensus partition
P_0 = BoK( E );
%original SoD between P_0 and the Ensemble. We want to optmize this value
SoD =  computeSoD( P_0, E );

%compute the upper bound
UB = log2(N);

%iterate over all objects trying new labels
for i = 1 : N %iterate over all objects
    found = false; %havent found a better label yet
    current = P_0(i,1); %current object been optimized
    for lab = 1 : K
        
        %if ( lab ~= current )
            %try a different label
            P_0(i,1) = lab;
            %compute SoD between P_0' and the entire Ensemble
            testSoD = computeSoD( P_0, E );
            
            if( testSoD < SoD ) %this means the new label is a better fit
                SoD = testSoD;  %new better SoD
                found = true; %found a better label
                break;
                
            end;%fi
            
        %end;%fi
    end;%for lab    
    if ( ~found )
        P_0(i,1) = current;
    end;%fi
end;%for i
L = P_0;
%--------------------------------------------------------------------------
%compute the sum of distances of Ltest to all partitions in the ensemble
function sod = computeSoD( Ltest, E )

M = size( E, 2 );

sod = 0;
for i = 1 : M
    sod = sod + VI_distance( Ltest, E(:,i) );
end;%for i

