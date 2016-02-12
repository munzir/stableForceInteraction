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
syms m mw Ix Iy Iz Iwx Iwy Iwz real
q=[x0; y0; theta_r; theta_l; phi];
dq=[dx0; dy0; dtheta_l; dtheta_r; dphi];
ddq=[ddx0; ddy0; ddtheta_l; ddtheta_r; ddphi];
psii = -R*(theta_l-theta_r)/L;
dx = dx0*cos(psii)+dy0*sin(psii);
dpsi = -R*(dtheta_l-dtheta_r)/L;

%% Wheels

I=[1 0 0]'; J=[0 1 0]'; K=[0 0 1]';
i=cos(phi)*I-sin(phi)*K;
j=J;
k=cos(phi)*K+sin(phi)*I;

% Kinematics using XYZ frame
w=dpsi*K;
vO=dx*I;
rOL=L*J; rOR=-L*J;
vL=vO+cross(w,rOL); vR=vO+cross(w,rOR);
wL=dpsi*K+(dx/R-dpsi*L/R)*J; 
wR=dpsi*K+(dx/R+dpsi*L/R)*J; 
Iw=[Iwx 0 0;0 Iwy 0;0 0 Iwz];

EL = 0.5*(mw*vL'*vL+wL'*Iw*wL);
ER = 0.5*(mw*vR'*vR+wR'*Iw*wR);


%% Body

% Kinematics using XYZ frame
vB_XYZ=d*dphi*i;
rOB=d*k;
vB=vO+vB_XYZ+cross(w,rOB);
wB=dpsi*K+dphi*J;

% We have I in xyz frame. Rotation transformation to find I in XYZ frame
% Rot=[I_xyz';J_xyz';K_xyz'];
Rot = [cos(phi) 0 sin(phi);0 1 0;-sin(phi) 0 cos(phi)];
IB=Rot*[Ix 0 0;0 Iy 0; 0 0 Iz]*Rot';

EB = 0.5*(m*vB'*vB+wB'*IB*wB);
U = m*g*d*sin(phi);


%% A matrix
E = EB+EL+ER;
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
    Q(i) = diff(U, q(i));
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
    [-L*PSII/R+theta_r, -L*dPSI/R+dtheta_r, -L*ddPSI/R+ddtheta_r]));
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










