% Author: Munzir Zafar
% Date: 11-15-2013
% Brief: Calculating an anlytical expression for the kinetic energy
% of the schunk in order to derive an expression for ts dynamics using
% Lagrange's formulation
tic

syms q1 q2 q3 q4 q5 q6 q7 dq1 dq2 dq3 dq4 dq5 dq6 dq7 L1 L3 L5 L7 real
syms m1 MX1 MY1 MZ1 XX1 XY1 XZ1 YY1 YZ1 ZZ1 real
syms m2 MX2 MY2 MZ2 XX2 XY2 XZ2 YY2 YZ2 ZZ2 real 
syms m3 MX3 MY3 MZ3 XX3 XY3 XZ3 YY3 YZ3 ZZ3 real
syms m4 MX4 MY4 MZ4 XX4 XY4 XZ4 YY4 YZ4 ZZ4 real
syms m5 MX5 MY5 MZ5 XX5 XY5 XZ5 YY5 YZ5 ZZ5 real
syms m6 MX6 MY6 MZ6 XX6 XY6 XZ6 YY6 YZ6 ZZ6 real
syms m7 MX7 MY7 MZ7 XX7 XY7 XZ7 YY7 YZ7 ZZ7 real

MS1 = [MX1; MY1; MZ1];
MS2 = [MX2; MY2; MZ2];
MS3 = [MX3; MY3; MZ3];
MS4 = [MX4; MY4; MZ4];
MS5 = [MX5; MY5; MZ5];
MS6 = [MX6; MY6; MZ6];
MS7 = [MX7; MY7; MZ7];

J1 = [XX1 XY1 XZ1; XY1 YY1 YZ1; XZ1 YZ1 ZZ1];
J2 = [XX2 XY2 XZ2; XY2 YY2 YZ2; XZ2 YZ2 ZZ2];
J3 = [XX3 XY3 XZ3; XY3 YY3 YZ3; XZ3 YZ3 ZZ3];
J4 = [XX4 XY4 XZ4; XY4 YY4 YZ4; XZ4 YZ4 ZZ4];
J5 = [XX5 XY5 XZ5; XY5 YY5 YZ5; XZ5 YZ5 ZZ5];
J6 = [XX6 XY6 XZ6; XY6 YY6 YZ6; XZ6 YZ6 ZZ6];
J7 = [XX7 XY7 XZ7; XY7 YY7 YZ7; XZ7 YZ7 ZZ7];


Tf_1from0 = [[ cos(q1); 0; -sin(q1)] [0;  1; 0] [ sin(q1); 0; cos(q1)] [0; -L1; 0]; 0 0 0 1];
Tf_2from1 = [[-1; 0; 0] [0; -cos(q2); -sin(q2)] [0; -sin(q2); cos(q2)] [0;   0; 0]; 0 0 0 1];
Tf_3from2 = [[-cos(q3); 0;  sin(q3)] [0; -1; 0] [ sin(q3); 0; cos(q3)] [0; -L3; 0]; 0 0 0 1];
Tf_4from3 = [[-1; 0; 0] [0; -cos(q4); -sin(q4)] [0; -sin(q4); cos(q4)] [0;   0; 0]; 0 0 0 1];
Tf_5from4 = [[-cos(q5); 0;  sin(q5)] [0; -1; 0] [ sin(q5); 0; cos(q5)] [0; -L5; 0]; 0 0 0 1];
Tf_6from5 = [[-1; 0; 0] [0; -cos(q6); -sin(q6)] [0; -sin(q6); cos(q6)] [0;   0; 0]; 0 0 0 1];
Tf_7from6 = [[-cos(q7); -sin(q7); 0] [0; 0; -1] [sin(q7); -cos(q7); 0] [0; 0; -L7]; 0 0 0 1];

w0 = [0; 0; 0]; 
w1 = [0; -dq1; 0] + Tf_1from0(1:3,1:3)*w0;
w2 = [-dq2; 0; 0] + Tf_2from1(1:3,1:3)*w1;
w3 = [0; -dq3; 0] + Tf_3from2(1:3,1:3)*w2;
w4 = [-dq4; 0; 0] + Tf_4from3(1:3,1:3)*w3;
w5 = [0; -dq5; 0] + Tf_5from4(1:3,1:3)*w4;
w6 = [-dq6; 0; 0] + Tf_6from5(1:3,1:3)*w5;
w7 = [0; 0; -dq7] + Tf_7from6(1:3,1:3)*w6;

V0 = [0; 0; 0];
V1 = Tf_1from0(1:3,1:3)*(V0 + cross(w0, -Tf_1from0(1:3,1:3)'*Tf_1from0(1:3,4)));
V2 = Tf_2from1(1:3,1:3)*(V0 + cross(w0, -Tf_2from1(1:3,1:3)'*Tf_2from1(1:3,4)));
V3 = Tf_3from2(1:3,1:3)*(V0 + cross(w0, -Tf_3from2(1:3,1:3)'*Tf_3from2(1:3,4)));
V4 = Tf_4from3(1:3,1:3)*(V0 + cross(w0, -Tf_4from3(1:3,1:3)'*Tf_4from3(1:3,4)));
V5 = Tf_5from4(1:3,1:3)*(V0 + cross(w0, -Tf_5from4(1:3,1:3)'*Tf_5from4(1:3,4)));
V6 = Tf_6from5(1:3,1:3)*(V0 + cross(w0, -Tf_6from5(1:3,1:3)'*Tf_6from5(1:3,4)));
V7 = Tf_7from6(1:3,1:3)*(V0 + cross(w0, -Tf_7from6(1:3,1:3)'*Tf_7from6(1:3,4)));

E1 = (w1'*J1*w1 + m1*(V1'*V1) + 2*MS1'*cross(V1, w1))/2;
E2 = (w2'*J2*w2 + m2*(V2'*V2) + 2*MS2'*cross(V2, w2))/2;
E3 = (w3'*J3*w3 + m3*(V3'*V3) + 2*MS3'*cross(V3, w3))/2;
E4 = (w4'*J4*w4 + m4*(V4'*V4) + 2*MS4'*cross(V4, w4))/2;
E5 = (w5'*J5*w5 + m5*(V5'*V5) + 2*MS5'*cross(V5, w5))/2;
E6 = (w6'*J6*w6 + m6*(V6'*V6) + 2*MS6'*cross(V6, w6))/2;
E7 = (w7'*J7*w7 + m7*(V7'*V7) + 2*MS7'*cross(V7, w7))/2;

E = E1 + E2 + E3 + E4 + E5 + E6 + E7;

E = expand(E);

C1=coeffs(E,dq1); A(1,1) = C1(end); e1=C1(end-1); 
C2=coeffs(E,dq2); A(2,2) = C2(end); e2=C2(end-1); 
C3=coeffs(E,dq3); A(3,3) = C3(end); e3=C3(end-1); 
C4=coeffs(E,dq4); A(4,4) = C4(end); e4=C4(end-1); 
C5=coeffs(E,dq5); A(5,5) = C5(end); e5=C5(end-1); 
C6=coeffs(E,dq6); A(6,6) = C6(end); e6=C6(end-1); 
C7=coeffs(E,dq7); A(7,7) = C7(end); e7=C7(end-1); 

C12 = coeffs(e1, dq2); A(1,2) = C12(end);
C13 = coeffs(e1, dq3); A(1,3) = C13(end);
C14 = coeffs(e1, dq4); A(1,4) = C14(end);
C15 = coeffs(e1, dq5); A(1,5) = C15(end);
C16 = coeffs(e1, dq6); A(1,6) = C16(end);
C17 = coeffs(e1, dq7); A(1,7) = C17(end);

C23 = coeffs(e2, dq3); A(2,3) = C23(end);
C24 = coeffs(e2, dq4); A(2,4) = C24(end);
C25 = coeffs(e2, dq5); A(2,5) = C25(end);
C26 = coeffs(e2, dq6); A(2,6) = C26(end);
C27 = coeffs(e2, dq7); A(2,7) = C27(end);

C34 = coeffs(e3, dq4); A(3,4) = C34(end);
C35 = coeffs(e3, dq5); A(3,5) = C35(end);
C36 = coeffs(e3, dq6); A(3,6) = C36(end);
C37 = coeffs(e3, dq7); A(3,7) = C37(end);
C45 = coeffs(e4, dq5); A(4,5) = C45(end);
C46 = coeffs(e4, dq6); A(4,6) = C46(end);
C47 = coeffs(e4, dq7); A(4,7) = C47(end);

C56 = coeffs(e5, dq6); A(5,6) = C56(end);
C57 = coeffs(e5, dq7); A(5,7) = C57(end);

C67 = coeffs(e6, dq7); A(6,7) = C67(end);

A=A+A';

dq = [dq1; dq2; dq3; dq4; dq5; dq6; dq7];

EE = expand((dq'*A*dq)/2);

isequaln(E,EE)

toc