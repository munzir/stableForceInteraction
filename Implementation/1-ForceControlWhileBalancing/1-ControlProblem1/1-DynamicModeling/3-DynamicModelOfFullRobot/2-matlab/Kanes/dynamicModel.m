

syms x psii dpsi dx ddpsi ddx L mw real
syms XXw XYw XZw YYw YZw ZZw real
syms tau_R tau_L R real

syms t X(t) PSI(t) dX dPSI ddX ddPSI real
dX=diff(X,t);dPSI=diff(PSI,t);
ddX=diff(dX,t);ddPSI=diff(dPSI,t);ddPHI=diff(dPHI,t);
mydiff = @(H) formula(subs(diff(symfun(subs(H,[x,psii,dx,dpsi,...
    ddx,ddpsi],[X,PSI,dX,dPSI,ddX,ddPSI]),t),t),...
    [X,PSI,dX,dPSI,ddX,ddPSI],[x,psii,dx,dpsi,...
    ddx,ddpsi]));

% Frame 0
w0=[0; 0; dpsi];
v0=[dx; 0; 0];
alpha0=ddpsi*[0; 0; 1]+dpsi*cross(w0,[0; 0; 1]);
a0=ddx*[1; 0; 0]+dx*cross(w0,[1; 0; 0]);

% Wheels
rOL=L*[0; 1; 0]; rOR=-L*[0; 1; 0];
vL=vO+cross(w0,rOL); vR=vO+cross(w0,rOR);
aL=aO+cross(alpha0,rOL)+cross(w0,cross(w0,rOL));
aR=aO+cross(alpha0,rOR)+cross(w0,cross(w0,rOR));
wL=dpsi*[0; 0; 1]+(dx/R-dpsi*L/R)*[0; 1; 0]; 
alphaL=ddpsi*[0; 0; 1]+(ddx/R-ddpsi*L/R)*[0; 1; 0];%+(dx/R-dpsi*L/R)*cross(w,J);
wR=dpsi*[0; 0; 1]+(dx/R+dpsi*L/R)*[0; 1; 0]; 
alphaR=ddpsi*[0; 0; 1]+(ddx/R+ddpsi*L/R)*[0; 1; 0];%+(dx/R+dpsi*L/R)*cross(w,J);
Iw=[XXw 0 0;0 YYw 0;0 0 ZZw];

HL=Iw*wL; HR=Iw*wR;
dHL=mydiff(HL)+cross(w0,HL); dHR=mydiff(HR)+cross(w0,HL);
KK=sym(zeros(2,1)); dq=[dx dpsi]'; ddq=[ddx ddpsi]';
for i=1:2
    KK(i)=mw*aL'*diff(vL,dq(i))+dHL'*diff(wL,dq(i)) ...
        + mw*aR'*diff(vR,dq(i))+dHR'*diff(wR,dq(i));
end

% Body
f = getKrangFrames(17);
[KK, QQ, KHist] = kanesLHS(f,[w0 v0 alpha0 a0], dq, KK);
[AA, CC] = getAC(f, KK, dq, ddq);
