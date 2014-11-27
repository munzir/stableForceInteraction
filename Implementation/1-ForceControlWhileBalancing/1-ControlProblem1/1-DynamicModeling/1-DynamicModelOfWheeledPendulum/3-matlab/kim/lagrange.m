%% Definitions:

% define frames:
% XYZ: Origin wheels-mid, Z always up, X always along heading
% xyz: Origin on body COM that lies mid-way between the wheels but at a
% height d. z along the line connecting last origin and COM. y parallel to
% the wheel-connect line towards left wheel
% XYZ_R: Origin on right wheel center. Axes parallel to XYZ.
% xyz_R: Origin of right wheel center. Axes moving with the wheel.
% XYZ_L: Origin on left wheel center. Axes parallel to XYZ.
% xyz_L: Origin of left wheel center. Axes moving with the wheel.
clear all
syms phi dpsi dphi dx ddpsi ddphi ddx d L g Ix Iy Iz Iwx Iwy Iwz mw m real
syms tau_R tau_L R real
dq = [dx dpsi dphi];

%% Wheels

I=[1 0 0]'; J=[0 1 0]'; K=[0 0 1]';
i=cos(phi)*I-sin(phi)*K;
j=J;
k=cos(phi)*K+sin(phi)*I;

% Kinematics using XYZ frame
w=dpsi*K;
alpha=ddpsi*K;
vO=dx*I;
aO=ddx*I+dx*cross(w,I);
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
A = sym(zeros(3, 3));

% row/col 1
E = EB+EL+ER;
A(1, 1) = 2*getcoeff(E, dx, 2);
A(1, 2) = getcoeff(getcoeff(E, dx, 1), dpsi, 1); 
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

Q(1) = diff(U, 'x');
Q(2) = diff(U, 'psii');
Q(3) = diff(U, 'phi');

