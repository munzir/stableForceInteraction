% Author: Munzir Zafar
% Date: 01-06-2013
% Brief: Calculating an anlytical expression for the kinetic energy
% of an imaginary 3DOF robot in order to derive an expression for its 
% dynamics using Lagrange's formulation
tic

syms q1 q2 q3 dq1 dq2 dq3 L1 L2 L3 real
syms m1 MX1 MY1 MZ1 XX1 XY1 XZ1 YY1 YZ1 ZZ1 real
syms m2 MX2 MY2 MZ2 XX2 XY2 XZ2 YY2 YZ2 ZZ2 real 
syms m3 MX3 MY3 MZ3 XX3 XY3 XZ3 YY3 YZ3 ZZ3 real

MS1 = [MX1; MY1; MZ1];
MS2 = [MX2; MY2; MZ2];
MS3 = [MX3; MY3; MZ3];

J1 = [XX1 XY1 XZ1; XY1 YY1 YZ1; XZ1 YZ1 ZZ1];
J2 = [XX2 XY2 XZ2; XY2 YY2 YZ2; XZ2 YZ2 ZZ2];
J3 = [XX3 XY3 XZ3; XY3 YY3 YZ3; XZ3 YZ3 ZZ3];


Tf_1from0 = [[ cos(q1); sin(q1); 0] [-sin(q1); cos(q1); 0] [0; 0; 1] [0; 0; -L1]; 0 0 0 1];
Tf_2from1 = [[ 1; 0; 0] [0; cos(q2); sin(q2)] [0; -sin(q2); cos(q2)] [0; 0; 0]; 0 0 0 1];
Tf_3from2 = [[ 1; 0; 0] [0; cos(q3); sin(q3)] [0; -sin(q3); cos(q3)] [0; L2*sin(q3); -L2*cos(q3)]; 0 0 0 1];

w0 = [0; 0; 0]; 
w1 = [0; 0; -dq1] + Tf_1from0(1:3,1:3)*w0;
w2 = [-dq2; 0; 0] + Tf_2from1(1:3,1:3)*w1;
w3 = [-dq3; 0; 0] + Tf_3from2(1:3,1:3)*w2;

V0 = [0; 0; 0];
V1 = Tf_1from0(1:3,1:3)*(V0 + cross(w0, -Tf_1from0(1:3,1:3)'*Tf_1from0(1:3,4)));
V2 = Tf_2from1(1:3,1:3)*(V1 + cross(w1, -Tf_2from1(1:3,1:3)'*Tf_2from1(1:3,4)));
V3 = Tf_3from2(1:3,1:3)*(V2 + cross(w2, -Tf_3from2(1:3,1:3)'*Tf_3from2(1:3,4)));

E1 = (w1'*J1*w1 + m1*(V1'*V1) + 2*MS1'*cross(V1, w1))/2;
E2 = (w2'*J2*w2 + m2*(V2'*V2) + 2*MS2'*cross(V2, w2))/2;
E3 = (w3'*J3*w3 + m3*(V3'*V3) + 2*MS3'*cross(V3, w3))/2;

E = E1 + E2 + E3;

E = expand(E);

C1=coeffs(E,dq1); A(1,1) = C1(end); e1=C1(end-1); 
C2=coeffs(E,dq2); A(2,2) = C2(end); e2=C2(end-1); 
C3=coeffs(E,dq3); A(3,3) = C3(end); e3=C3(end-1); 

C12 = coeffs(e1, dq2); A(1,2) = C12(end);
C13 = coeffs(e1, dq3); A(1,3) = C13(end);

C23 = coeffs(e2, dq3); A(2,3) = C23(end);

A=A+A';

dq = [dq1; dq2; dq3];

EE = expand((dq'*A*dq)/2);

isequaln(E,EE)

save KE

toc