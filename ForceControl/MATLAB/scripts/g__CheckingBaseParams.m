load groupedParams

K = [K1; K2; K3; K4; K5; K6; K7];
KR = [KR1; KR2; KR3; KR4; KR5; KR6; KR7];

% Let's find D
syms ddq1 ddq2 ddq3 ddq4 ddq5 ddq6 ddq7 real
ddq = [ddq1; ddq2; ddq3; ddq4; ddq5; ddq6; ddq7];

Gamma = A*ddq + C*dq + Q;

syms abracadabra real
D=abracadabra*zeros(7,size(K,1));

for i=1:size(K,1)
    for j=1:7
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