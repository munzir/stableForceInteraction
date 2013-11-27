syms q1 dq1 ddq1 m1 MX1 MY1 MZ1 XX1 XY1 XZ1 YY1 YZ1 ZZ1 Ia1 Fc1 Fv1 real

MS1 = [MX1 MY1 MZ1]';
J1 = [XX1 XY1 XZ1; XY1 YY1 YZ1; XZ1 YZ1 ZZ1];
Tf_1from0 = [[ 1; 0; 0] [0;  cos(q1); sin(q1)] [ 0; -sin(q1); cos(q1)] [0; 0; 0]; 0 0 0 1];
w1 = [-dq1 0 0]';
V1 = [0 0 0]';
E1 = (w1'*J1*w1 + m1*(V1'*V1) + 2*MS1'*cross(V1, w1))/2;
[CCC, TTT] = coeffs(E1,dq1); 
for i=1:length(TTT); if(TTT(i)==dq1^2); A = CCC(i); end; end
A=A+A';

g = [0 0 -9.8]';
Tf_0from1 = simplify(inv(Tf_1from0));
U1 = -[g' 0]*Tf_0from1*[MS1; m1];
Q = diff(U1, q1);

C = 0;

A = A + Ia1;

Gamma = A*ddq1 + C*dq1 + Q*q1 + Fv1*dq1 + Fc1*sign(dq1);
K = [MY1; MZ1; XX1; Ia1; Fc1; Fv1];
D = m1*zeros(1,length(K));
for i=1:length(K)
    [CCC, TTT] = coeffs(Gamma, K(i));
    for k=1:length(TTT)
        if(TTT(k)==K(i))
            D(i) = CCC(k);
        end
    end
end
KR = K;
KR(3) = KR(3) + K(4);
KR(4) = 0;

DD = m1*zeros(1,length(K));
KKR = m1*zeros(length(K),1);
j = 0;
for i = 1:length(K)
    if(~isequaln(KR(i),0))
        j=j+1;
        DD(j) = D(i);
        KKR(j) = KR(i);
    end
end
DD = DD(1:j);
KKR = KKR(1:j);

simplify(Gamma - DD*KKR)

clear CCC TTT ans i j k
save model