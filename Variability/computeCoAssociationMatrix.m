%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%desc:
%
%
%18.12.08 dda
%25.12.08 changed it to produce a dissimilarity matrix or distance matrix.
%1 means far apart, 0 means close
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function co_assoc = computeCoAssociationMatrix(ec, n )


N = size(ec,2);
co_assoc = zeros (n,n);

for ecount = 1 : N
  for pi = 1 : n
    for pj = 1 : n
      if ec(pi,ecount) == ec(pj,ecount)
        co_assoc(pi,pj) = co_assoc(pi,pj) + (1/N);
      end;
    end;
  end;
end;
for pi = 1 : n
  for pj = 1 : n
    if pi == pj
      co_assoc(pi,pj) = 0;
    else
      if ( abs( 1 - co_assoc(pi, pj) ) < 0.0000001)
        co_assoc(pi,pj) = 0;
      else
        co_assoc(pi,pj) = 1 - co_assoc(pi,pj);
      end;
    end;
  end;
end;








