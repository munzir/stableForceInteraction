% % Wheels
% % dthetaL = dx/R - dpsi*L/(2*R);
% % iL = [1 0 0]'; jL = [0 1 0]'; kL = [0 0 1]';
% % i0 = [cos(thetaL) 0 sin(thetaL)]'; j0 = [0 1 0]'; k0 = [-sin(thetaL) 0 cos(thetaL)]';
% syms thetaL thetaR dx dpsi R L real
% Z1 = 1/R;
% Z2 = L/(2*R);
% Z3 = sin(thetaL);
% Z4 = cos(thetaL);
% 
% dthetaL = Z1*dx - Z2*dpsi;
% i0L = [Z4 0 Z3]'; j0L = [0 1 0]'; k0L = [-Z3 0 Z4]';
% 
% % w0L = dpsi*k0L;
% % wL = w0L + dthetaL*j0L;
% % wL =
% %  
% %         -Z3*dpsi
% %  Z1*dx - Z2*dpsi
% %          Z4*dpsi
% Z5 =         -Z3*dpsi;
% Z6 =  Z1*dx - Z2*dpsi;
% Z7 =          Z4*dpsi;
% 
% wLi = [Z5; Z6; Z7];
% wLe = [-Z3*dpsi; Z1*dx-Z2*dpsi;Z4*dpsi];
% dwL = [[0 Z1 0]' [-Z3 -Z2 Z4]' zeros(3,17)];
% 
% % dthetaR = dx/R + dpsi*L/(2*R);
% % iR = [1 0 0]'; jR = [0 1 0]'; kR = [0 0 1]';
% % i0 = [cos(thetaR) 0 sin(thetaR)]'; j0 = [0 1 0]'; k0 = [-sin(thetaR) 0 cos(thetaR)]';
% Z8 = sin(thetaR); 
% Z9 = cos(thetaR);
% 
% dthetaR = Z1*dx+Z2*dpsi;
% i0R = [Z9 0 Z8]'; j0R = [0 1 0]'; k0R = [-Z8 0 Z9]';
% 
% % w0R = dpsi*k0R;
% % wR = w0R + dthetaR*j0R
% % wR =
% %  
% %         -Z8*dpsi
% %  Z2*dpsi + Z1*dx
% %          Z9*dpsi
% Z10 =          -Z8*dpsi;
% Z11 =   Z2*dpsi + Z1*dx;
% Z12 =           Z9*dpsi;