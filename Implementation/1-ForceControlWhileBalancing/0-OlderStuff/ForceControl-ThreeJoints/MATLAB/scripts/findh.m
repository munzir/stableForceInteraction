function h = findh(energy, JJ)

a = [4 4; 4 5; 4 6; 5 5; 5 6; 6 6; 6 2; 4 3; 5 1; 1 1];

syms abracadabra real
h=abracadabra*zeros(1,size(a,1));

for i=1:size(a,1)
    [CCC, TTT] = coeffs(energy, JJ(a(i, 1), a(i, 2)));
    for k=1:size(TTT)
        if(TTT(k)==JJ(a(i, 1), a(i, 2)))
            h(i) = CCC(k);
        end
    end
end