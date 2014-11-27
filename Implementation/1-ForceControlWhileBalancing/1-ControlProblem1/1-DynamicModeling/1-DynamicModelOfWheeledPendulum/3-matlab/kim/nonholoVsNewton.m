clear all
syms   x0   y0   theta_l   theta_r   phi   x   psi real
syms  dx0  dy0  dtheta_l  dtheta_r  dphi  dx  dpsi real
syms ddx0 ddy0 ddtheta_l ddtheta_r ddphi ddx ddpsi real
syms g L R d tau_l tau_r lambda1 lambda2 real
syms m_S m_C I_1 I_2 I_3 Iw_1 Iw_2 Iw_3 real

load K

F1 = (m_S + 2*Iw_3/R^2 + 2*m_C)*ddx - m_S*d*cos(phi)*ddphi ...           
                    + m_S*d*sin(phi)*(dphi^2+dpsi^2) - (tau_r+tau_l)/R;
                
F1_new = expand(simplify(expand(subs(F1, [ddx, dpsi], ...
    [ddx0*cos(R*(theta_l-theta_r)/L) + ddy0*sin(R*(theta_l-theta_r)/L)...
    - dx0*R*(dtheta_l-dtheta_r)/L*sin(R*(theta_l-theta_r)/L)...
    + dy0*R*(dtheta_l-dtheta_r)/L*cos(R*(theta_l-theta_r)/L),...
    R*(dtheta_l-dtheta_r)/L]))));

K1 = expand(simplify(expand(K(1))));

difference = simplify(F1_new-K1);

% syms PSII dPSI ddPSI dX ddX real
% differenceA = simplify(subs(difference,[theta_l,dtheta_l,ddtheta_l], ...
%     [L*PSII/R+theta_r, L*dPSI/R+dtheta_r, L*ddPSI/R+ddtheta_r]));
% differenceB = simplify(subs(differenceA,[dx0,dy0,ddx0,ddy0], ...
%     [dX*cos(PSII), dX*sin(PSII), ddX*cos(PSII)-dX*dPSI*sin(PSII), ...
%     ddX*sin(PSII)+dX*dPSI*cos(PSII)]));

pretty(difference)

% psi = R*(theta_l-theta_r)/L;
% dx = dx0*cos(psii)+dy0*sin(psii);
% ddx = ddx0*cos(psii)-dx0*dpsi*sin(psii)+ddy0*cos(psii)+dy0*dpsi*cos(psii);
% dpsi = R*(dtheta_l-dtheta_r)/L;
% ddpsi = R*(ddtheta_l-ddtheta_r)/L;
