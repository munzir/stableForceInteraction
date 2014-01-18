load groupedParams

K = [K1; K2; K3];
KR = [KR1; KR2; KR3];

% Let's find D
syms ddq1 ddq2 ddq3 real
ddq = [ddq1; ddq2; ddq3];

Gamma = A*ddq + C*dq + Q;

syms abracadabra real
D=abracadabra*zeros(3,size(K,1));

for i=1:size(K,1)
    for j=1:3
        [CCC, TTT] = coeffs(Gamma(j), K(i));
        for k=1:size(TTT)
            if(TTT(k)==K(i))
                D(j,i) = CCC(k);
            end
        end
    end
end

Gamma1 = D*K;
Gamma2 = D*KR;

del = simplify(Gamma1-Gamma2)