function viXY = VI(X,Y)
%this function computes the variation of information of two random
%variables X and Y
%
%DDA 09.05.2017


if size( X, 1 )~= size( Y, 1 )
    error('ERROR: Random variables with different sizes');
else
    N = size( X, 1 );
end;%if

%number of subsets in X
K_X = size( unique( X ), 1 );
%size of the subsets in X
[nelemX,Xcenters]=hist(X,unique(X));

%number of subsets in Y
K_Y = size( unique( Y ), 1 );
%size of the subsets in X
[nelemY,Ycenters]=hist(Y,unique(Y));

for i = 1 : K_X
