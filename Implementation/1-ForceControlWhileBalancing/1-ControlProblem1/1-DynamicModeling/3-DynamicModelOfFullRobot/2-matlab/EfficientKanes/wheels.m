% Wheels
% dthetaL = dx/R - dpsi*L/(2*R);
% iL = [1 0 0]'; jL = [0 1 0]'; kL = [0 0 1]';
% i0 = [cos(thetaL) 0 sin(thetaL)]'; j0 = [0 1 0]'; k0 = [-sin(thetaL) 0 cos(thetaL)]';
syms dx dpsi Z1 Z2 Z3 Z4 real
dthetaL = Z1*dx - Z2*dpsi;
i0L = [Z4 0 Z3]'; j0L = [0 1 0]'; k0L = [-Z3 0 Z4]';

% w0L = dpsi*k0L;
% wL = w0L + dthetaL*j0L;
syms Z5 Z6 Z7 real
wLi = [Z5; Z6; Z7];
wLe = [-Z3*dpsi; Z1*dx-Z2*dpsi;Z4*dpsi];

% dthetaR = dx/R + dpsi*L/(2*R);
% iR = [1 0 0]'; jR = [0 1 0]'; kR = [0 0 1]';
% i0 = [cos(thetaR) 0 sin(thetaR)]'; j0 = [0 1 0]'; k0 = [-sin(thetaR) 0 cos(thetaR)]';
syms Z8 Z9 real
dthetaR = Z1*dx+Z2*dpsi;
i0R = [Z9 0 Z8]'; j0R = [0 1 0]'; k0R = [-Z8 0 Z9]';

% w0R = dpsi*k0R;
% wR = w0R + dthetaR*j0R
syms Z10 Z11 Z12 real
wRi = [Z10; Z11; Z12];
wRe = [-Z8*dpsi; Z2*dpsi + Z1*dx;  Z9*dpsi];