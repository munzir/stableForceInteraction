% Adding rotor inertia

syms Ia1 Ia2 Ia3 Ia4 Ia5 Ia6 Ia7 real

AA = A;
AA(1,1) = AA(1,1) + Ia1;
AA(2,2) = AA(2,2) + Ia2;
AA(3,3) = AA(3,3) + Ia3;

hh1 = h1; hh2 = h2; hh3 = h3; 
hh1(11) = 0.5*dq1^2;
hh2(11) = 0.5*dq2^2;
hh3(11) = 0.5*dq3^2;

KK1 = K1; KK2 = K2; KK3 = K3;
KK1(11) = Ia1;
KK2(11) = Ia2;
KK3(11) = Ia3;

% Since h1(11) = h1(6) ---> we can group such that: KK1(6) = KK1(6) + KK1(11)
% Since h2(11) = h2(1) ---> we can group such that: KK2(1) = KK2(1) + KK2(11)
KKR1 = [KR1; KK1(11)]; KKR2 = [KR2; KK2(11)]; KKR3 = [KR3; KK3(11)]; 
KKR1(6) = KKR1(6) + KKR1(11); KKR1(11) = 0;
KKR2(1) = KKR2(1) + KKR2(11); KKR2(11) = 0;




