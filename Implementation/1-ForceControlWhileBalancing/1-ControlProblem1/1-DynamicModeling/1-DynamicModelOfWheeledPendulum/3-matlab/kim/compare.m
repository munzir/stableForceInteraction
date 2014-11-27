%function [A,dA,C,Q,q,dq,EL,E1] = dynamicsWIP()
clear all
syms x psii phi g L R d dx dpsi dphi ddx ddpsi ddphi real
syms m_S m_C I_1 I_2 I_3 Iw_1 Iw_2 Iw_3 real
JG1 = [I_1+m_S*d^2 0 0; 0 I_2 0; 0 0 I_3+m_S*d^2];
MX1 = 0; MY1 = m_S*d; MZ1 = 0;
MS1 = [MX1 MY1 MZ1]';
m1 = m_S;
JGw = [0 0 0; 0 Iw_2 0; 0 0 Iw_3];
MSw = [0; 0; 0];
mw = m_C;

% syms x psii phi dx dpsi dphi real
% syms m1 MX1 MY1 MZ1 XX1 XY1 XZ1 YY1 YZ1 ZZ1 real
% syms g L R mw real
% syms YYw YZw ZZw real
% JG1 = [XX1 XY1 XZ1; XY1 YY1 YZ1; XZ1 YZ1 ZZ1];
% MS1 = [MX1 MY1 MZ1]';
% JGw = [0 0 0; 0 YYw YZw; 0 YZw ZZw];
% MSw = [0; 0; 0];

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

w1_in0 = [0; dpsi; dphi]; V1_in0 = [dx; 0; 0]; 
MS1_in0 = [MX1*cos(phi)-MY1*sin(phi); MX1*sin(phi)+MY1*cos(phi); MZ1];
E1_in0 = 0.5*(w1_in0'*JG1*w1_in0 + m1*V1_in0'*V1_in0 + 2*MS1_in0'*cross(V1_in0, w1_in0));

E1 = 0.5*(w1'*JG1*w1 + m1*V1'*V1 + 2*MS1'*cross(V1, w1));
U1 = -[gVec' 0]*T1in0*[MS1;m1];

%frame L: Left wheel
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
A(1, 1) = 2*getcoeff(E, dx, 2);
A(1, 2) = getcoeff(getcoeff(E, dx, 1), dpsi, 1) + m_S; 
A(2, 1) = A(1, 2);
A(1, 3) = getcoeff(getcoeff(E, dx, 1), dphi, 1);
A(3, 1) = A(1, 3);

% row/col 2
A(2, 2) = 2*getcoeff(E, dpsi, 2);
A(2, 3) = getcoeff(getcoeff(E, dpsi, 1), dphi, 1);
A(3, 2) = A(2, 3);

% row/col 3
A(3, 3) = 2*getcoeff(E, dphi, 2);
A=simplify(A);

%% C matrix

dA = sym(zeros(3, 3, 3));
for i=1:3; for j=1:3; dA(i, j, 1) = diff(A(i, j), 'x'); end; end
for i=1:3; for j=1:3; dA(i, j, 2) = diff(A(i, j), 'psii'); end; end
for i=1:3; for j=1:3; dA(i, j, 3) = diff(A(i, j), 'phi'); end; end

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
C=simplify(C);

%% Q matrix
Q = sym(zeros(3, 1));

Q(1) = diff(U1, 'x');
Q(2) = diff(U1, 'psii');
Q(3) = diff(U1, 'phi');




u_1 = dx; u_2 = dpsi; u_3 = dphi;
du_1 = ddx; du_2 = ddpsi; du_3 = ddphi;

w_S  = [0; u_2; u_3];
w_C1 = [0; u_2; -(1/R)*u_1+(L/R)*u_2];
w_C2 = [0; u_2; -(1/R)*u_1-(L/R)*u_2];

v_S  = [u_1-u_3*d*cos(phi); -u_3*d*sin(phi); u_2*d*sin(phi)];
v_C1 = [u_1-u_2*L; 0; 0];
v_C2 = [u_1+u_2*L; 0; 0];

alpha_S  = [0; du_2; du_3];
alpha_C1 = [-(1/R)*u_1*u_2+(L/R)*u_2^2; du_2; -(1/R)*du_1+(L/R)*du_2];     
alpha_C2 = [-(1/R)*u_1*u_2-(L/R)*u_2^2; du_2; -(1/R)*du_1-(L/R)*du_2];

a_S = [du_1-du_3*d*cos(phi)+(u_2^2+u_3^2)*d*sin(phi); ...
    -du_3*d*sin(phi)-u_3^2*d*cos(phi); ...
    du_2*d*sin(phi)+u_2*u_3*d*cos(phi)];
a_C1 = [du_1-L*du_2; 0;  L*u_2^2];
a_C2 = [du_1+L*du_2; 0; -L*u_2^2];

I_S = [I_1 0 0; 0 I_2 0; 0 0 I_3];
I_C1 = [Iw_1 0 0; 0 Iw_2 0; 0 0 Iw_3];
I_C2 = I_C1;

T_S = -I_S*alpha_S-cross(w_S, I_S*w_S);
T_C1 = -I_C1*alpha_C1-cross(w_C1, I_C1*w_C1);
T_C2 = -I_C2*alpha_C2-cross(w_C2, I_C2*w_C2);

R_S = -m_S*a_S;
R_C1 = -m_C*a_C1;
R_C2 = -m_C*a_C2;


F_1 = diff(w_S,  'u_1')'*T_S  + diff(v_S,  'u_1')'*R_S ...
    + diff(w_C1, 'u_1')'*T_C1 + diff(v_C1, 'u_1')'*R_C1 ...
    + diff(w_C2, 'u_1')'*T_C2 + diff(v_C2, 'u_1')'*R_C2;
F_2 = diff(w_S,  'u_2')'*T_S  + diff(v_S,  'u_2')'*R_S ...
    + diff(w_C1, 'u_2')'*T_C1 + diff(v_C1, 'u_2')'*R_C1 ...
    + diff(w_C2, 'u_2')'*T_C2 + diff(v_C2, 'u_2')'*R_C2;
F_3 = diff(w_S,  'u_3')'*T_S  + diff(v_S,  'u_3')'*R_S ...
    + diff(w_C1, 'u_3')'*T_C1 + diff(v_C1, 'u_3')'*R_C1 ...
    + diff(w_C2, 'u_3')'*T_C2 + diff(v_C2, 'u_3')'*R_C2;

difference = A*[ddx; ddpsi; ddphi]+C*[dx; dpsi; dphi]+[F_1; F_2; F_3];
difference = simplify(difference);