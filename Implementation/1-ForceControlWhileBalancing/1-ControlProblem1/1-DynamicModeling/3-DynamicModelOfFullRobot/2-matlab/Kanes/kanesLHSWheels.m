function KK = kanesLHSWheels(f)

syms x psii phi dpsi dphi dx ddpsi ddphi ddx L g mw mb real
syms XXw XYw XZw YYw YZw ZZw real
syms XXb XYb XZb YYb YZb ZZb real
syms tau_R tau_L R qimu_plus_phi qimu real
syms MXb MYb MZb real

syms t X(t) PSI(t) PHI(t) dX dPSI dPHI ddX ddPSI ddPHI real
dX=diff(X,t);dPSI=diff(PSI,t);dPHI=diff(PHI,t); 
ddX=diff(dX,t);ddPSI=diff(dPSI,t);ddPHI=diff(dPHI,t);
q = [x psii phi]'; dq = [dx dpsi dphi]'; ddq = [ddx ddpsi ddphi]';

mydiff = @(H) formula(subs(diff(symfun(subs(H,...
    [x,psii,phi,dx,dpsi,dphi,ddx,ddpsi,ddphi],...
    [X, PSI,PHI,dX,dPSI,dPHI,ddX,ddPSI,ddPHI]),t),t),...
    [X, PSI,PHI,dX,dPSI,dPHI,ddX,ddPSI,ddPHI],...
    [x,psii,phi,dx,dpsi,dphi,ddx,ddpsi,ddphi]));

q_imu = -phi + qimu_plus_phi; % qimu_plus_phi is a constant if pose fixed

%% Left Wheel


thetaL = x/R - psii*L/(2*R);
dthetaL = dx/R - dpsi*L/(2*R);
iL = [1 0 0]'; jL = [0 1 0]'; kL = [0 0 1]';
i0 = [cos(thetaL) 0 sin(thetaL)]'; j0 = [0 1 0]'; k0 = [-sin(thetaL) 0 cos(thetaL)]';
w0 = dpsi*k0;
v0 = dx*i0;
alpha0 = ddpsi*k0;
a0 = ddx*i0 + dx*(cross(dpsi*k0,i0));
rOL = (L/2)*j0;
Iw=[ZZw 0 0;0 YYw 0;0 0 ZZw];
wL = w0 + dthetaL*j0;
vGL = v0 + cross(w0, rOL);
aGL = a0 + cross(alpha0, rOL) + cross(w0, cross(w0, rOL));
HGL = Iw*wL;
p = mydiff(HGL);
dHGL = p + cross(wL,HGL);

% %% Right Wheel


thetaR = x/R + psii*L/(2*R);
dthetaR = dx/R + dpsi*L/(2*R);
iR = [1 0 0]'; jR = [0 1 0]'; kR = [0 0 1]';
i0 = [cos(thetaR) 0 sin(thetaR)]'; j0 = [0 1 0]'; k0 = [-sin(thetaR) 0 cos(thetaR)]';
w0 = dpsi*k0;
v0 = dx*i0;
alpha0 = ddpsi*k0;
a0 = ddx*i0 + dx*(cross(dpsi*k0,i0));
rOR = -(L/2)*j0;
wR = w0 + dthetaR*j0;
vGR = v0 + cross(w0, rOR);
aGR = a0 + cross(alpha0, rOR) + cross(w0, cross(w0, rOR));
HGR = Iw*wR;
dHGR = mydiff(HGR)+cross(wR,HGR);
dq = dqVec(f); KK = sym(zeros(length(dq),1));
for i=1:2
    KK(i) = mw*aGL'*diff(vGL, dq(i)) + dHGL'*diff(wL, dq(i)) ...
          + mw*aGR'*diff(vGR, dq(i)) + dHGR'*diff(wR, dq(i));
end