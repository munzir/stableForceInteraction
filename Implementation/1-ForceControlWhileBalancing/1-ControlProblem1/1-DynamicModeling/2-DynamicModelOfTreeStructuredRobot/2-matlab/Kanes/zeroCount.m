% Counting zeros in A/C matrices and also looking for mismatches between
% lagrange and kanes regarding zeros

lA=0; kA=0; lC=0; kC=0; misA=[]; misC=[]; 

for i=1:17; 
    for j=1:17; 
        disp(['i=', num2str(i), ', j=', num2str(j)]);
        lAzero = 0; kAzero = 0; lCzero=0; kCzero = 0;
        if(isequaln(A(i,j),0)) 
            lA=lA+1; 
            lAzero = 1;
        end; 
        if(isequaln(AA(i,j),0)) 
            kA=lA+1; 
            kAzero = 1;
        end; 
        if(isequaln(C(i,j),0))
            lC=lC+1; 
            lCzero = 1;
        end; 
        if(isequaln(CC(i,j),0)) 
            kC=kC+1; 
            kCzero = 1;
        end;
        if(kAzero ~= lAzero)
            misA=[misA; i, j];
        end
        if(kCzero ~= lCzero)
            misC=[misC; i, j];
        end
    end; 
end