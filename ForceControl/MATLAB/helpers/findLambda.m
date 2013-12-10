function lambda = findLambda(JJ_, JJ)

a = [4 4; 4 5; 4 6; 5 5; 5 6; 6 6; 6 2; 4 3; 5 1; 1 1];

syms abracadabra real
lambda=abracadabra*zeros(size(a,1));

for i=1:size(a,1)
    for j=1:size(a,1)
        [CCC, TTT] = coeffs(JJ_(a(i, 1), a(i, 2)), JJ(a(j, 1), a(j, 2)));
        for k=1:size(TTT)
            if(TTT(k)==JJ(a(j, 1), a(j, 2)))
                lambda(i,j) = CCC(k);
            end
        end
    end
end