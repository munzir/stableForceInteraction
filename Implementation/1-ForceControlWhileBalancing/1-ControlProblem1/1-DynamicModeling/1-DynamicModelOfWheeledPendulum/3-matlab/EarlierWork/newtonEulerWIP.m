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
syms phi dpsi dphi dx ddpsi ddphi ddx d L g mw m real
syms XXw XYw XZw YYw YZw ZZw real
syms XXb XYb XZb YYb YZb ZZb real
syms tau_R tau_L R real

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
alphaL=ddpsi*K+(ddx/R-ddpsi*L/R)*J+(dx/R-dpsi*L/R)*cross(w,J);
wR=dpsi*K+(dx/R+dpsi*L/R)*J; 
alphaR=ddpsi*K+(ddx/R+ddpsi*L/R)*J+(dx/R+dpsi*L/R)*cross(w,J);

% Forces and torques acting on wheels:
% [f 0 N]: friction and normal from ground
% [Rx Ry Rz]: reaction from wheel axle
% [0 tau 0]: motor torque
% [tau_x 0 tau_z]: reaction torque from axle

% Left wheel force and equation
% [f_L 0 N_L]+[Rx_L Ry_L Rz_L]=mw*aL
% [0 tau_L 0]+[tau_xL 0 tau_zL]+[0 -f_L*R 0]=Iw*alphaL+cross(wL,Iw*wL)
Iw=[XXw 0 0;0 YYw 0;0 0 ZZw];
momentRHS_L = Iw*alphaL+cross(wL,Iw*wL);

% Torques: tau_L-f_L*R=momentRHS_L'*J
f_L = (tau_L-momentRHS_L'*J)/R;
% Torque others:
tau_xL=momentRHS_L'*I; tau_zL=momentRHS_L'*K;
% Forces.I: f_L+Rx_L=(mw*aL)'*I;
Rx_L=(mw*aL)'*I-f_L;
Ry_L=(mw*aL)'*J;

% Left wheel force and equation
% [f_R 0 N_R]'+[Rx_R Ry_R Rz_R]'=mw*aR
% [0 tau_R 0]'+[tau_xR 0 tau_zR]'+[0 -f_R*R 0]'=Iw*alphaR+cross(wR,Iw*wR)
momentRHS_R = Iw*alphaR+cross(wR,Iw*wR);

% Torques: tau_R-f_R*R=momentRHS_R'*J
f_R = (tau_R-momentRHS_R'*J)/R;
% Torque others:
tau_xR=momentRHS_R'*I; tau_zR=momentRHS_R'*K;
% Forces.I: f_R+Rx_R=(mw*aR)'*I;
Rx_R=(mw*aR)'*I-f_R;
Ry_R=(mw*aR)'*J;

%% Body

% Kinematics using XYZ frame
vB_XYZ=d*dphi*i;
aB_XYZ=d*ddphi*i+d*dphi*cross(dphi*J,i);
rOB=d*k;
vB=vO+vB_XYZ+cross(w,rOB);
aB=aO+aB_XYZ+cross(alpha,rOB)+cross(w,cross(w,rOB))+2*cross(w,vB_XYZ);
wB=dpsi*K+dphi*J;
alphaB=ddpsi*K+ddphi*J+dphi*cross(w,J);

% We have I in xyz frame. Rotation transformation to find I in XYZ frame
% Rot=[I_xyz';J_xyz';K_xyz'];
Rot = [cos(phi) 0 sin(phi);0 1 0;-sin(phi) 0 cos(phi)];
IB=Rot*[XXb XYb XZb;XYb YYb YZb;XZb YZb ZZb]*Rot';

% Forces and torques on the body about center of mass B
% [-Rx_L -Ry_L -Rz_L]+[-Rx_R -Ry_R -Rz_R]+[0 0 -m*g]=m*aB
% [-(tau_xL+tau_xR) -(tau_L+tau_R) -(tau_zL+tau_zR)]'...
%      +cross(rBL,[-Rx_L -Ry_L -Rz_L]')+cross(rBR,[-Rx_R -Ry_R -Rz_R]') ...
%                                               = IB*alphaB+cross(wB,IB*wB)

% Computed cross products by MATLAB cmd line:
% rBL=-rOB+rOL =[-d*sin(phi)  L -d*cos(phi)]' 
% rBR=-rOB+rOR =[-d*sin(phi) -L -d*cos(phi)]'
% cross(rBL,[-Rx_L -Ry_L -Rz_L]')+cross(rBR,[-Rx_R -Ry_R -Rz_R]')
% =[                   L*Rz_R - L*Rz_L - Ry_L*d*cos(phi) - Ry_R*d*cos(phi);
%    Rx_L*d*cos(phi) + Rx_R*d*cos(phi) - Rz_L*d*sin(phi) - Rz_R*d*sin(phi);
%                      L*Rx_L - L*Rx_R + Ry_L*d*sin(phi) + Ry_R*d*sin(phi)]
% Simplified by me:
% =[(Rz_R-Rz_L)*L-(Ry_L-Ry_R)*d*cos(phi);
%   (Rx_L+Rx_R)*d*cos(phi)-(Rz_L+Rz_R)*d*sin(phi);
%   (Rx_L-Rx_R)*L+(Ry_L+Ry_R)*d*sin(phi)]

%% Equation 1

% Force component 1 and 2 give us two equations for dynamics
% Torque component 3 gives us the third equation
% Force.I
F1=expand((m*aB)'*I+Rx_L+Rx_R);
% Force.J
F2=expand((m*aB)'*J+Ry_L+Ry_R);
% Torque.K
F3=expand((IB*alphaB+cross(wB,IB*wB))'*K+tau_zL+tau_zR-((Rx_L-Rx_R)*L...
                                                 +(Ry_L+Ry_R)*d*sin(phi)));

% Computed by MATLAB
% F1 = ddx*m + 2*ddx*mw - tau_L/R - tau_R/R + (2*YYw*ddx)/R^2 ...
%          + d*ddphi*m*cos(phi) - d*dphi^2*m*sin(phi) - d*dpsi^2*m*sin(phi)
% F2 = dpsi*dx*m + 2*dpsi*dx*mw + d*ddpsi*m*sin(phi) ...
%                                                + 2*d*dphi*dpsi*m*cos(phi)
% F3 = 2*ZZw*ddpsi - XYb*dphi^2*cos(phi) + ZZb*ddpsi*cos(phi)^2 ...
%            + XXb*ddpsi*sin(phi)^2 - YZb*dphi^2*sin(phi) + (L*tau_L)/R ...
%                   - (L*tau_R)/R + 2*L^2*ddpsi*mw + YZb*ddphi*cos(phi) ...
%                          - XYb*ddphi*sin(phi) + (2*L^2*YYw*ddpsi)/R^2 ...
%             - 2*XZb*dphi*dpsi*cos(phi)^2 + 2*XZb*dphi*dpsi*sin(phi)^2 ...
%   - 2*XZb*ddpsi*cos(phi)*sin(phi) + 2*XXb*dphi*dpsi*cos(phi)*sin(phi) ...
%             - 2*ZZb*dphi*dpsi*cos(phi)*sin(phi) - 2*d*dpsi*dx*mw*sin(phi)
%
% Simplified by hand. F1 gives Equation 1:
%  =======================================================================
% || F1 = (m + 2*YYw/R^2 + 2*mw)*ddx + 2*YZw/R*ddpsi ...                 ||
% ||         + m*d*cos(phi)*ddphi + (2*XZw*/R - m*d*sin(phi))*dpsi^2 ... ||
% ||                             + m*d*sin(phi)*dphi^2 - (tau_R+tau_L)/R ||
%  =======================================================================
% F2 = m*d*sin(phi)*ddpsi + (m+2*mw)*dx*dpsi + 2*m*d*dphi*dpsi*cos(phi) 
% F3 = (2*ZZw + ZZb*cos(phi)^2 + XXb*sin(phi)^2 + 2*L^2*mw ...
%       + 2*L^2*YYw/R^2 - 2*XZb*cos(phi)*sin(phi))*ddpsi + (YZb*cos(phi)...
%        - XYb*sin(phi))*ddphi - (XYb*cos(phi) + YZb*sin(phi))*dphi^2 - ...
%                         + 2*d*mw*sin(phi)*dpsi*dx - (2*XZb*cos(2*phi) ...
%                + (ZZb - XXb)*sin(2*phi))*dphi*dpsi + L*(tau_L - tau_R)/R;

%% Equation 2
%
% Let's substittute the value of -2*mw*dx*dpsi from F2 in F3:
% -2*mw*dx*dpsi = m*d*sin(phi)*ddpsi + m*dx*dpsi + 2*m*d*dphi*dpsi*cos(phi) 
% We get:

F4 = expand(simplify(expand((F3+F2*d*sin(phi)))));
 
% Computed by MATLAB:
% F4 = 2*ZZw*ddpsi - XYb*dphi^2*cos(phi) + ZZb*ddpsi*cos(phi)^2 ...
%            + XXb*ddpsi*sin(phi)^2 - YZb*dphi^2*sin(phi) + (L*tau_L)/R ...
%                   - (L*tau_R)/R + 2*L^2*ddpsi*mw + YZb*ddphi*cos(phi) ...
% + XYb*ddphi*sin(phi) + d^2*ddpsi*m*sin(phi)^2 + (2*L^2*YYw*ddpsi)/R^2 ...
%             - 2*XZb*dphi*dpsi*cos(phi)^2 + 2*XZb*dphi*dpsi*sin(phi)^2 ...
%   - 2*XZb*ddpsi*cos(phi)*sin(phi) + 2*XXb*dphi*dpsi*cos(phi)*sin(phi) ...
%            - 2*ZZb*dphi*dpsi*cos(phi)*sin(phi) + d*dpsi*dx*m*sin(phi) ...
%                                     + 2*d^2*dphi*dpsi*m*cos(phi)*sin(phi)
%
% Simplified by me. gives Equation 2
%  =======================================================================
% || F4_ = (2*L^2*mw + (2*L^2*YYw)/R^2 + 2*ZZw + d^2*m*sin(phi)^2 ...    ||
% ||  + ZZb*cos(phi)^2+XXb*sin(phi)^2-2*XZb*cos(phi)*sin(phi))*ddpsi ... ||
% ||                +(YZb*cos(phi)-XYb*sin(phi))*ddphi-(YZb*sin(phi) ... ||
% ||               +XYb*cos(phi))*dphi^2+((XXb-ZZb+d^2*m)*sin(2*phi) ... ||
% || -2*XZb*cos(2*phi))*dphi*dpsi+d*dpsi*dx*m*sin(phi)+(tau_L-tau_R)*L/R;||
%  =======================================================================

%% Equation 3
% The equation F2 contains only terms in dpsii which is also the case with
% F3/F4. So we need one more equation that has ddx or ddphi in it. Do we 
% proceed to find a third equation:
% Force.K: -Rz_L-Rz_R-m*g=(m*aB)'*K => (Rz_L+Rz_R)=-(m*aB)'*K-m*g
% Torque.J: -(tau_L+tau_R) + (Rx_L+Rx_R)*d*cos(phi) ... 
%                  -(Rz_L+Rz_R)*d*sin(phi) = (IB*alphaB+cross(wB,IB*wB))'*J
% => (IB*alphaB+cross(wB,IB*wB))'*J - ((Rx_L+Rx_R)*d*cos(phi) ... 
%                                  -(Rz_L+Rz_R)*d*sin(phi)) + (tau_L+tau_R)
% Substituting Rz_L+Rz_R from Force.K into Torque.J

F5 = expand((IB*alphaB+cross(wB,IB*wB))'*J - ((Rx_L+Rx_R)*d*cos(phi)-...
                            (-(m*aB)'*K-m*g)*d*sin(phi)) + (tau_L+tau_R));
% Computed by MATLAB:
% F5 = tau_L + tau_R + YYb*ddphi + XZb*dpsi^2*cos(phi)^2 ...
%     - XZb*dpsi^2*sin(phi)^2 + YZb*ddpsi*cos(phi) - XYb*ddpsi*sin(phi) ...
%         - XXb*dpsi^2*cos(phi)*sin(phi) + ZZb*dpsi^2*cos(phi)*sin(phi) ...
%       + d^2*ddphi*m*sin(phi)^2 - 2*d*ddx*mw*cos(phi) - d*g*m*sin(phi) ...
%                         + (d*tau_L*cos(phi))/R + (d*tau_R*cos(phi))/R ...
%             - (2*YYw*d*ddx*cos(phi))/R^2 + d^2*dphi^2*m*cos(phi)*sin(phi)
% Simplified by me:
% F5 = -2*(YYw/R^2+mw)*d*cos(phi)*ddx+(YZb*cos(phi)-XYb*sin(phi))*ddpsi ...
%        + (YYb+d^2*m*sin(phi)^2)*ddphi+ d^2*dphi^2*m*cos(phi)*sin(phi) ...
%  +(XZb*cos(2*phi)+(ZZb-XXb)*cos(phi)*sin(phi))*dpsi^2 -d*g*m*sin(phi) ...
%                                          +(tau_L+tau_R)*(1+d*cos(phi)/R);
%
% Since the third equation we have in kim has a coeeficient of mdcos(phi)
% of ddx, we will substitute the value of -(2*Iwy/R^2 + 2*mw)*ddx from
% equation F1 in equation 4. We get:

F6 = expand(simplify(expand((F5+F1*d*cos(phi)))));

% Computed by MATLAB:
% F6 = tau_L + tau_R + YYb*ddphi - XZb*dpsi^2 ...
%          + 2*XZb*dpsi^2*cos(phi)^2 + YZb*ddpsi*cos(phi) + d^2*ddphi*m ...
%                   - XYb*ddpsi*sin(phi) - XXb*dpsi^2*cos(phi)*sin(phi) ...
%                     + ZZb*dpsi^2*cos(phi)*sin(phi) + d*ddx*m*cos(phi) ...
%                         - d*g*m*sin(phi) - d^2*dpsi^2*m*cos(phi)*sin(phi)
% Simplified by me:
%  =======================================================================
% || F6_ = d*ddx*m*cos(phi) + (YZb*cos(phi) - XYb*sin(phi))*ddpsi ...    ||
% ||        + (YYb + d^2*m)*ddphi + (XZb*cos(2*phi)+(ZZb-XXb-m*d^2)*...  ||
% ||          cos(phi)*sin(phi))*dpsi^2-d*g*m*sin(phi) + tau_L + tau_R;  ||
%  =======================================================================
