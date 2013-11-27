% Adding friction

load rotorInertiaAdded

syms Fc1 Fv1 Fc2 Fv2 Fc3 Fv3 Fc4 Fv4 Fc5 Fv5 Fc6 Fv6 Fc7 Fv7 real
syms ddq1 ddq2 ddq3 ddq4 ddq5 ddq6 ddq7 real
ddq = [ddq1; ddq2; ddq3; ddq4; ddq5; ddq6; ddq7];

Fc = [Fc1 Fc2 Fc3 Fc4 Fc5 Fc6 Fc7]';
Fv = [Fv1 Fv2 Fv3 Fv4 Fv5 Fv6 Fv7]';
Gamma_f = diag(dq)*Fv + diag(sign(dq))*Fc;
GGamma = AA*ddq + C*dq + Q + Gamma_f;

KK1(12) = Fc1; KK1(13) = Fv1; KK2(12) = Fc2; KK2(13) = Fv2; 
KK3(12) = Fc3; KK3(13) = Fv3; KK4(12) = Fc4; KK4(13) = Fv4; 
KK5(12) = Fc5; KK5(13) = Fv5; KK6(12) = Fc6; KK6(13) = Fv6; 
KK7(12) = Fc7; KK7(13) = Fv7; 

KKR1(12) = Fc1; KKR1(13) = Fv1; KKR2(12) = Fc2; KKR2(13) = Fv2; 
KKR3(12) = Fc3; KKR3(13) = Fv3; KKR4(12) = Fc4; KKR4(13) = Fv4; 
KKR5(12) = Fc5; KKR5(13) = Fv5; KKR6(12) = Fc6; KKR6(13) = Fv6; 
KKR7(12) = Fc7; KKR7(13) = Fv7; 

KK = [KK1; KK2; KK3; KK4; KK5; KK6; KK7];
KKR = [KKR1; KKR2; KKR3; KKR4; KKR5; KKR6; KKR7];

syms abracadabra real
DD=abracadabra*zeros(7,size(KK,1));

for i=1:size(KK,1)
    for j=1:7
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