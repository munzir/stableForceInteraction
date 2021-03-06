%function [A,dA,C,Q,q,dq,EL,E1] = dynamicsWIP()
% clear all
% syms x psii phi g L R d dx dpsi dphi ddx ddpsi ddphi real
% syms m_S m_C I_1 I_2 I_3 Iw_1 Iw_2 Iw_3 real
% JG1 = [I_1+m_S*d^2 0 0; 0 I_2 0; 0 0 I_3+m_S*d^2];
% MX1 = 0; MY1 = m_S*d; MZ1 = 0;
% MS1 = [MX1 MY1 MZ1]';
% m1 = m_S;
% JGw = [0 0 0; 0 Iw_2 0; 0 0 Iw_3];
% MSw = [0; 0; 0];
% mw = m_C;

% syms x psii phi dx dpsi dphi real
% syms m1 MX1 MY1 MZ1 XX1 XY1 XZ1 YY1 YZ1 ZZ1 real
% syms g L R mw real
% syms YYw YZw ZZw real
% JG1 = [XX1 XY1 XZ1; XY1 YY1 YZ1; XZ1 YZ1 ZZ1];
% MS1 = [MX1 MY1 MZ1]';
% JGw = [0 0 0; 0 YYw YZw; 0 YZw ZZw];
% MSw = [0; 0; 0];

clear all
syms x0 y0 theta_l theta_r phi g L R d dx0 dy0 dtheta_l dtheta_r dphi ddx0 ddy0 ddtheta_l ddtheta_r ddphi ddx ddpsi real
syms tau_l tau_r lambda1 lambda2 real
syms m_S m_C I_1 I_2 I_3 Iw_1 Iw_2 Iw_3 real
JG1 = [I_1+m_S*d^2 0 0; 0 I_2 0; 0 0 I_3+m_S*d^2];
MX1 = 0; MY1 = m_S*d; MZ1 = 0;
MS1 = [MX1 MY1 MZ1]';
m1 = m_S;
JGw = [0 0 0; 0 Iw_2 0; 0 0 Iw_3];
MSw = [0; 0; 0];
mw = m_C;
psii = R*(theta_l-theta_r)/L;
dx = dx0*cos(psii)+dy0*sin(psii);
dpsi = R*(dtheta_l-dtheta_r)/L;


q=[x0; y0; theta_r; theta_l; phi];
dq=[dx0; dy0; dtheta_l; dtheta_r; dphi];
ddq=[ddx0; ddy0; ddtheta_l; ddtheta_r; ddphi];


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
E = E1+EL+ER;
A = sym(zeros(5, 5));

for i=1:5
    A(i, i) = 2*getcoeff(E, dq(i), 2);
    for j=i+1:5
        A(i, j) = getcoeff(getcoeff(E, dq(i), 1), dq(j), 1);
        A(j, i) = A(i, j);
    end
end

A = simplify(A);
%% C matrix

dA = sym(zeros(5, 5, 5));
for i=1:5; for j=1:5; for k=1:5; dA(i, j, k) = diff(A(i, j), q(k)); end; end; end

c = sym(zeros(5, 5, 5));
C = sym(zeros(5, 5));
for i=1:5; 
    for j=1:5; 
        for k=1:5;
            c(i, j, k) = 0.5*(dA(i, j, k) + dA(i, k, j) - dA(j, k, i));
            C(i, j) = C(i, j) + c(i, j, k)*dq(k);
        end;
    end; 
end;
C=simplify(C);

%% Q matrix
Q = sym(zeros(5, 1));

for i=1:5
    Q(i) = diff(U1, q(i));
end

%% Generalized forces
F = [0; 0; tau_l; tau_r; -(tau_l+tau_r)/2];

%% Lagrange multipliers
G = [sin(psii) cos(psii); -cos(psii) sin(psii); 0 -R/2; 0 -R/2; 0 0];

%% Eliminating Lagrange Multipliers
H=A*ddq+C*dq+Q-F-G*[lambda1 lambda2]';

syms PSII dPSI ddPSI dX ddX real
K=[H(1)*cos(psii)+H(2)*sin(psii)+(H(3)+H(4))/R;L*(H(3)-H(4))/(2*R);H(5)];
K_half = simplify(subs(K,[theta_l,dtheta_l,ddtheta_l], ...
    [L*PSII/R+theta_r, L*dPSI/R+dtheta_r, L*ddPSI/R+ddtheta_r]));
K1 = simplify(subs(K_half,[dx0,dy0,ddx0,ddy0], ...
    [dX*cos(PSII), dX*sin(PSII), ddX*cos(PSII)-dX*dPSI*sin(PSII), ...
    ddX*sin(PSII)+dX*dPSI*cos(PSII)]));
% pretty(K1)

%% Matrices for q=[x psi phi]'

dqq = [dX dPSI dphi]'; ddqq = [ddX ddPSI ddphi]';
AA = sym(zeros(3,3)); CC = sym(zeros(3,3)); QQ=sym(zeros(3,1));
for i=1:3
    for j=1:3
        AA(i,j)=getcoeff(K1(i),ddqq(j),1);
        CC(i,j)=getcoeff(K1(i), dqq(j),2)*dqq(j);
        ccc = getcoeff(K1(i),dqq(j),1); 
        CC(i,j) = CC(i,j)+ccc;
        for k=1:3
            CC(i,j) = CC(i,j) - 0.5*(getcoeff(ccc,dqq(k),1))*dqq(k);
        end
    end
    QQ(i) = K1(i)-AA(i,1:3)*ddqq-CC(i,1:3)*dqq;
end

AA=simplify(AA);
CC=simplify(CC);
QQ=simplify(QQ);











