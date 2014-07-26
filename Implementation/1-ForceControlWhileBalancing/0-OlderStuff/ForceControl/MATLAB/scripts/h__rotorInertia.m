% Adding rotor inertia

load groupedParams
load N

syms Ia1 Ia2 Ia3 Ia4 Ia5 Ia6 Ia7 real

AA = A;
AA(1,1) = AA(1,1) + Ia1;
AA(2,2) = AA(2,2) + Ia2;
AA(3,3) = AA(3,3) + Ia3;
AA(4,4) = AA(4,4) + Ia4;
AA(5,5) = AA(5,5) + Ia5;
AA(6,6) = AA(6,6) + Ia6;
AA(7,7) = AA(7,7) + Ia7;

hh1 = h1; hh2 = h2; hh3 = h3; hh4 = h4; hh5 = h5; hh6 = h6; hh7 = h7;
hh1(11) = 0.5*dq1^2;
hh2(11) = 0.5*dq2^2;
hh3(11) = 0.5*dq3^2;
hh4(11) = 0.5*dq4^2;
hh5(11) = 0.5*dq5^2;
hh6(11) = 0.5*dq6^2;
hh7(11) = 0.5*dq7^2;

KK1 = K1; KK2 = K2; KK3 = K3; KK4 = K4; KK5 = K5; KK6 = K6; KK7 = K7;
KK1(11) = Ia1;
KK2(11) = Ia2;
KK3(11) = Ia3;
KK4(11) = Ia4;
KK5(11) = Ia5;
KK6(11) = Ia6;
KK7(11) = Ia7;

% Since h1(11) = h1(4) ---> we can group such that: KK1(4) = KK1(4) + KK1(11)
% Since h2(11) = h2(1) ---> we can group such that: KK2(1) = KK2(1) + KK2(11)
KKR1 = [KR1; KK1(11)]; KKR2 = [KR2; KK2(11)]; KKR3 = [KR3; KK3(11)]; 
KKR4 = [KR4; KK4(11)]; KKR5 = [KR5; KK5(11)]; KKR6 = [KR6; KK6(11)]; 
KKR7 = [KR7; KK7(11)]; 
KKR1(4) = KKR1(4) + KKR1(11); KKR1(11) = 0;
KKR2(1) = KKR2(1) + KKR2(11); KKR2(11) = 0;



