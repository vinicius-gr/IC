%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%Daniel Duarte Abdala
%18.12.08
%
%
%Desc:
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function module = modintersect(C1,C2,ind1,ind2)
[l c] = size( C1 );
if l > c
  C1 = C1';
  C2 = C2';
end;

module = 0;
for row = 1 : size(C1,2)
  %for col = 1 : size(C1,2)
    %if ((C1(row,col) == ind1) && (C2(row,col) == ind2))
    if ((C1(1,row) == ind1) && (C2(1,row) == ind2))
      module = module + 1;
    end;%if
  %end;%col
end;%row
