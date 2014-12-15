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
syms x psii phi dpsi dphi dx ddpsi ddphi ddx d L g Ix Iy Iz Iwx Iwy Iwz mw m real
syms tau_R tau_L R real

syms t X(t) PSI(t) PHI(t) dX dPSI dPHI ddX ddPSI ddPHI real
dX=diff(X,t);dPSI=diff(PSI,t);dPHI=diff(PHI,t);
ddX=diff(dX,t);ddPSI=diff(dPSI,t);ddPHI=diff(dPHI,t);
q = [x psii phi]'; dq = [dx dpsi dphi]'; ddq = [ddx ddpsi ddphi]';

mydiff = @(H) formula(subs(diff(symfun(subs(H,[x,psii,phi,dx,dpsi,dphi,...
    ddx,ddpsi,ddphi],[X,PSI,PHI,dX,dPSI,dPHI,ddX,ddPSI,ddPHI]),t),t),...
    [X,PSI,PHI,dX,dPSI,dPHI,ddX,ddPSI,ddPHI],[x,psii,phi,dx,dpsi,dphi,...
    ddx,ddpsi,ddphi]));

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
aL=aO+cross(alpha,rOL)+cross(w,cross(w,rOL));
aR=aO+cross(alpha,rOR)+cross(w,cross(w,rOR));
wL=dpsi*K+(dx/R-dpsi*L/R)*J; 
alphaL=ddpsi*K+(ddx/R-ddpsi*L/R)*J;%+(dx/R-dpsi*L/R)*cross(w,J);
wR=dpsi*K+(dx/R+dpsi*L/R)*J; 
alphaR=ddpsi*K+(ddx/R+ddpsi*L/R)*J;%+(dx/R+dpsi*L/R)*cross(w,J);
Iw=[Iwx 0 0;0 Iwy 0;0 0 Iwz];

HL=Iw*wL; HR=Iw*wR;
dHL=mydiff(HL)+cross(w,HL); dHR=mydiff(HR)+cross(w,HL);
% delHL=Iw*(ddpsi*K+(ddx/R-ddpsi*L/R)*J); delHR=Iw*(ddpsi*K+(ddx/R+ddpsi*L/R)*J);
KL=sym(zeros(3,1)); KR=sym(zeros(3,1));
for i_=1:3
    KL(i_)=mw*aL'*diff(vL,dq(i_))+dHL'*diff(wL,dq(i_));
    KR(i_)=mw*aR'*diff(vR,dq(i_))+dHR'*diff(wR,dq(i_));
end

%% Body

% Kinematics using XYZ frame
vB_XYZ=d*dphi*i;
aB_XYZ=d*ddphi*i+d*dphi*cross(dphi*J,i);
rOB=d*k;
vB=vO+vB_XYZ+cross(w,rOB);
aB=aO+aB_XYZ+cross(alpha,rOB)+cross(w,cross(w,rOB))+2*cross(w,vB_XYZ);
wB=dpsi*K+dphi*J;
alphaB=ddpsi*K+ddphi*J;%+dphi*cross(w,J);

% We have I in xyz frame. Rotation transformation to find I in XYZ frame
% Rot=[I_xyz';J_xyz';K_xyz'];
Rot = [cos(phi) 0 sin(phi);0 1 0;-sin(phi) 0 cos(phi)];
IB=Rot*[Ix 0 0;0 Iy 0; 0 0 Iz]*Rot';

HB=IB*wB;
dHB=mydiff(HB)+cross(w,HB);
KB=sym(zeros(3,1));
for i_=1:3
    KB(i_)=m*aB'*diff(vB,dq(i_))+dHB'*diff(wB,dq(i_));
end
V=m*g*d*cos(phi);


%% Virtual Work

dW=tau_L*J'*(wL-dphi*J)+tau_R*J'*(wR-dphi*J);


%% Equations

K=KL+KR+KB;
AA = sym(zeros(3,3)); CC = sym(zeros(3,3)); 
QQ=sym(zeros(3,1)); Gamma=sym(zeros(3,1));
for i=1:3
    for j=1:3
        AA(i,j)=getcoeff(K(i),ddq(j),1);
        CC(i,j)=getcoeff(K(i), dq(j),2)*dq(j);
        ccc = getcoeff(K(i),dq(j),1); 
        CC(i,j) = CC(i,j)+ccc;
        for k=1:3
            CC(i,j) = CC(i,j) - 0.5*(getcoeff(ccc,dq(k),1))*dq(k);
        end
    end
    QQ(i) = diff(V,q(i));
    Gamma(i) = diff(dW,dq(i));
end

AA=simplify(AA);
CC=simplify(CC);


