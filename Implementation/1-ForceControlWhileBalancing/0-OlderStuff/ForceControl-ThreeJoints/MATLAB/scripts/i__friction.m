% Adding friction

load rotorInertiaAdded

syms Fc1 Fv1 Fc2 Fv2 Fc3 Fv3 real
syms ddq1 ddq2 ddq3 real
ddq = [ddq1; ddq2; ddq3];

Fc = [Fc1 Fc2 Fc3]';
Fv = [Fv1 Fv2 Fv3]';
Gamma_f = diag(dq)*Fv + diag(sign(dq))*Fc;
GGamma = AA*ddq + C*dq + Q + Gamma_f;

KK1(12) = Fc1; KK1(13) = Fv1; KK2(12) = Fc2; KK2(13) = Fv2; 
KK3(12) = Fc3; KK3(13) = Fv3;

KKR1(12) = Fc1; KKR1(13) = Fv1; KKR2(12) = Fc2; KKR2(13) = Fv2; 
KKR3(12) = Fc3; KKR3(13) = Fv3; 

KK = [KK1; KK2; KK3];
KKR = [KKR1; KKR2; KKR3];

syms abracadabra real
DD=abracadabra*zeros(3,size(KK,1));

for i=1:size(KK,1)
    for j=1:3
        [CCC, TTT] = coeffs(GGamma(j), KK(i));
        for k=1:size(TTT)
            if(TTT(k)==KK(i))
                DD(j,i) = CCC(k);
            end
        end
    end
end

GGamma1 = DD*KK;
GGamma2 = DD*KKR;

del = simplify(GGamma1-GGamma2)