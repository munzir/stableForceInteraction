%function [A,dA,C,Q,q,dq,EL,E1] = dynamicsWIP()

syms x psii phi dx dpsi dphi real
syms m1 MX1 MY1 MZ1 XX1 XY1 XZ1 YY1 YZ1 ZZ1 real
syms g L R mw real
syms YYw YZw ZZw real

q=[x; psii; phi]; dq=[dx; dpsi; dphi];
%% Kinematics
% frame 0 
V0 = [dx 0 0]';
w0 = [0 dpsi 0]';
gVec = [0 -g 0]';

% frame 1: Body
x1 = [cos(phi) sin(phi) 0]';
y1 = [-sin(phi) cos(phi) 0]';
z1 = [0 0 1]';
P1 = [0 0 0]';

e1 = [0 0 1]';
dq1 = dphi;

A1in0 = [x1 y1 z1];
T1in0 = [A1in0 P1; 0 0 0 1];
A0in1 = A1in0';

w1 = A0in1*w0 + e1*dphi;
V1 = A0in1*(V0 + cross(w0, P1));

JG1 = [XX1 XY1 XZ1; XY1 YY1 YZ1; XZ1 YZ1 ZZ1];
MS1 = [MX1 MY1 MZ1]';

w1_in0 = [0; dpsi; dphi]; V1_in0 = [dx; 0; 0]; 
MS1_in0 = [MX1*cos(phi)-MY1*sin(phi); MX1*sin(phi)+MY1*cos(phi); MZ1];
E1_in0 = 0.5*(w1_in0'*JG1*w1_in0 + m1*V1_in0'*V1_in0 + 2*MS1_in0'*cross(V1_in0, w1_in0));

E1 = 0.5*(w1'*JG1*w1 + m1*V1'*V1 + 2*MS1'*cross(V1, w1));
U1 = -[gVec' 0]*T1in0*[MS1;m1];

%frame L: Left wheel
JGw = [0 0 0; 0 YYw YZw; 0 YZw ZZw];
MSw = [0; 0; 0];

wL = [0; dpsi; -(1/R)*dx+(L/R)*dpsi];
VL = [dx - dpsi*L; 0; 0];
EL = 0.5*(wL'*JGw*wL + mw*VL'*VL + 2*MSw'*cross(VL, wL));

%frame R: Right wheel
wR = [0; dpsi; -(1/R)*dx-(L/R)*dpsi];
VR = [dx + dpsi*L; 0; 0];
ER = 0.5*(wR'*JGw*wR + mw*VR'*VR + 2*MSw'*cross(VL, wL));

%% A matrix
A = sym(zeros(3, 3));

% row/col 1
E = E1+EL+ER;
c = coeffs(E, dx);
A(1, 1) = 2*c(end);
E2 = c(end-1);
c2 = coeffs(E2, dpsi);
A(1, 2) = c2(end); A(2, 1) = c2(end);
c2 = coeffs(E2, dphi);
A(1, 3) = c2(end); A(3,1) = c2(end);

% row/col 2
c = coeffs(E, dpsi);
A(2, 2) = 2*c(end);
E2 = c(end-1);
c2 = coeffs(E2, dphi);
A(2, 3) = c2(end); A(3, 2) = c2(end);

% row/col 3
c = coeffs(E, dphi);
A(3, 3) = 2*c(end);


%% C matrix

dA = sym(zeros(3, 3, 3));
for i=1:3; for j=1:3; dA(i, j, 1) = diff(A(i, j), x); end; end
for i=1:3; for j=1:3; dA(i, j, 2) = diff(A(i, j), psii); end; end
for i=1:3; for j=1:3; dA(i, j, 3) = diff(A(i, j), phi); end; end

c = sym(zeros(3, 3, 3));
C = sym(zeros(3, 3));
for i=1:3; 
    for j=1:3; 
        for k=1:3;
            c(i, j, k) = 0.5*(dA(i, j, k) + dA(i, k, j) - dA(j, k, i));
            C(i, j) = C(i, j) + c(i, j, k)*dq(k);
        end;
    end; 
end;

%% Q matrix
Q = sym(zeros(3, 1));

Q(1) = diff(U1, x);
Q(2) = diff(U1, psii);
Q(3) = diff(U1, phi);
