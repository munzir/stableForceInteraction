function KK = kanesLHSWheels_(f)


syms x psii dpsi dx ddpsi ddx 
syms L R mw XXw XYw XZw YYw YZw ZZw real

dq = dqVec(f); KK = sym(zeros(length(dq),1));
KK(1) = (2*mw + 2*YYw/R^2)*ddx;
KK(2) = (mw*L^2/2 + YYw*L^2/(2*R^2) + 2*ZZw)*ddpsi;