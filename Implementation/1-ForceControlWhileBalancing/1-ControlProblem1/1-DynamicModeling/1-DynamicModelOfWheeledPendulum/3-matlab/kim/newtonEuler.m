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

syms phi dpsi dphi dx ddpsi ddphi ddx d L g Ix Iy Iz Iwx Iwy Iwz mw m real
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
Iw=[Iwx 0 0;0 Iwy 0;0 0 Iwz];
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
IB=Rot*[Ix 0 0;0 Iy 0; 0 0 Iz]*Rot';

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
% F1 = ddx*m + 2*ddx*mw - tau_L/R - tau_R/R + (2*Iwy*ddx)/R^2 ...
%          + d*ddphi*m*cos(phi) - d*dphi^2*m*sin(phi) - d*dpsi^2*m*sin(phi)
% F2 = dpsi*dx*m + 2*dpsi*dx*mw + d*ddpsi*m*sin(phi) ...
%                                                + 2*d*dphi*dpsi*m*cos(phi)
% F3 = 2*Iwz*ddpsi + Iz*ddpsi*cos(phi)^2 + Ix*ddpsi*sin(phi)^2 ...
%                        + (L*tau_L)/R - (L*tau_R)/R + 2*L^2*ddpsi*mw + ...
%            + (2*Iwy*L^2*ddpsi)/R^2 + 2*Ix*dphi*dpsi*cos(phi)*sin(phi) ...
%              - 2*Iz*dphi*dpsi*cos(phi)*sin(phi) - 2*d*dpsi*dx*mw*sin(phi)
%
% Simplified by hand. F1 gives Equation 1:
%  =======================================================================
% || F1 = (m + 2*Iwy/R^2 + 2*mw)*ddx + m*d*cos(phi)*ddphi ...            ||
% ||                    - m*d*sin(phi)*(dphi^2+dpsi^2) - (tau_R+tau_L)/R ||
%  =======================================================================
% F2 = m*d*sin(phi)*ddpsi + (m+2*mw)*dx*dpsi + 2*m*d*dphi*dpsi*cos(phi) 
% F3 = (2*L^2*mw + 2*Iwy*L^2/R^2 + 2*Iwz + Iz*cos(phi)^2 ...
%         + Ix*sin(phi)^2)*ddpsi + 2*(Ix-Iz)*dphi*dpsi*cos(phi)*sin(phi)...
%                             - 2*mw*dpsi*dx*d*sin(phi) + (tau_L-tau_R)*L/R 
%% Equation 2
%
% Let's substittute the value of -2*mw*dx*dpsi from F2 in F3:
% -2*mw*dx*dpsi = m*d*sin(phi)*ddpsi + m*dx*dpsi + 2*m*d*dphi*dpsi*cos(phi) 
% We get:
F4 = expand(simplify(expand((2*L^2*mw + 2*Iwy*L^2/R^2 + 2*Iwz + ...
                                   Iz*cos(phi)^2 + Ix*sin(phi)^2)*ddpsi ...
            + 2*(Ix-Iz)*dphi*dpsi*cos(phi)*sin(phi)+(m*d*sin(phi)*ddpsi ...
                     + m*dx*dpsi + 2*m*d*dphi*dpsi*cos(phi))*d*sin(phi) ...
                                                   + (tau_L-tau_R)*L/R )));

% Computed by MATLAB:
% F4 = 2*Iwz*ddpsi + Iz*ddpsi*cos(phi)^2 + Ix*ddpsi*sin(phi)^2 ...
% + (L*tau_L)/R - (L*tau_R)/R + 2*L^2*ddpsi*mw + d^2*ddpsi*m*sin(phi)^2 ...
%            + (2*Iwy*L^2*ddpsi)/R^2 + 2*Ix*dphi*dpsi*cos(phi)*sin(phi) ...
%             - 2*Iz*dphi*dpsi*cos(phi)*sin(phi) + d*dpsi*dx*m*sin(phi) ...
%                                     + 2*d^2*dphi*dpsi*m*cos(phi)*sin(phi)
% Simplified by me. gives Equation 2
%  =======================================================================
% || F4 = (2*L^2*mw + (2*Iwy*L^2)/R^2 + 2*Iwz + d^2*m*sin(phi)^2 ...     ||
% ||                          + Iz*cos(phi)^2 + Ix*sin(phi)^2)*ddpsi ... ||
% ||                   + 2*(Ix-Iz+m*d^2)*dphi*dpsi*cos(phi)*sin(phi) ... ||
% ||                         + d*dpsi*dx*m*sin(phi) + L*(tau_L-tau_R)/R; ||
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
% F5 = expand((IB*alphaB+cross(wB,IB*wB))'*J - ((Rx_L+Rx_R)*d*cos(phi)-...
%                            (-(m*aB)'*K-m*g)*d*sin(phi)) + (tau_L+tau_R));
% Computed by MATLAB:
% F5 = tau_L + tau_R + Iy*ddphi - Ix*dpsi^2*cos(phi)*sin(phi) + ...
%                + Iz*dpsi^2*cos(phi)*sin(phi) + d^2*ddphi*m*sin(phi)^2 ...
%         - 2*d*ddx*mw*cos(phi) - d*g*m*sin(phi) + (d*tau_L*cos(phi))/R ...
%               + (d*tau_R*cos(phi))/R + d^2*dphi^2*m*cos(phi)*sin(phi) ...
%                                              - (2*Iwy*d*ddx*cos(phi))/R^2
% Simplified by me:
% F5 = -2*(mw+Iwy/R^2)*d*cos(phi)*ddx + (Iy+m*d^2*sin(phi)^2)*ddphi ...
%    + ((Iz-Ix)*dpsi^2+m*d^2*dphi^2)*cos(phi)*sin(phi) - m*g*d*sin(phi) ...
%                                          + (tau_L+tau_R)*(1+d*cos(phi)/R) 
%
% Since the third equation we have in kim has a coeeficient of mdcos(phi)
% of ddx, we will substitute the value of -(2*Iwy/R^2 + 2*mw)*ddx from
% equation F1 in equation 4. We get:
% -2*(mw+Iwy/R^2)*ddx = m*ddx + m*d*cos(phi)*ddphi ...
%                          - m*d*sin(phi)*(dphi^2+dpsi^2) - (tau_R+tau_L)/R
F5 = expand(simplify(expand((m*ddx + m*d*cos(phi)*ddphi ...
           - m*d*sin(phi)*(dphi^2+dpsi^2) - (tau_R+tau_L)/R)*d*cos(phi) ...
                                          + (Iy+m*d^2*sin(phi)^2)*ddphi ...
     + ((Iz-Ix)*dpsi^2+m*d^2*dphi^2)*cos(phi)*sin(phi) - m*g*d*sin(phi) ...
                                       + (tau_L+tau_R)*(1+d*cos(phi)/R))));

% Computed by MATLAB:
% F5 = tau_L + tau_R + Iy*ddphi + d^2*ddphi*m ...
%           - Ix*dpsi^2*cos(phi)*sin(phi) + Iz*dpsi^2*cos(phi)*sin(phi) ...
%      + d*ddx*m*cos(phi) - d*g*m*sin(phi) - d^2*dpsi^2*m*cos(phi)*sin(phi)
%
% Simplified by me:
%  =======================================================================
% || F5 = d*ddx*m*cos(phi) + (m*d^2+Iy)*ddphi ...                        ||
% ||       + (Iz-Ix-m*d^2)*dpsi^2*cos(phi)*sin(phi) - d*g*m*sin(phi) ... ||
% ||                                                     + tau_L + tau_R || 
%  =======================================================================

% Everything matches exactly with the equations derived using Lagrange by
% us. Exceptions are two:
% Lagrange doesn't give: -m*d*sin(phi)*dpsi^2  in equation 1
% Lagrange doesn't give:  m*d*sin(phi)*dpsi*dx in equation 2

%% The untouched
% Let's just evaluate how Torque.I looks like:
% -(tau_xL+tau_xR)+(Rz_R-Rz_L)*L-(Ry_L-Ry_R)*d*cos(phi)=(IB*alphaB+cross(wB,IB*wB))'*I

syms Rz_R Rz_L real
F6 = expand(simplify(expand((IB*alphaB+cross(wB,IB*wB))'*I-(Rz_R-Rz_L)*L...
                                +(Ry_L-Ry_R)*d*cos(phi)+(tau_xL+tau_xR))));
% Computed by MATLAB
% F6 = L*Rz_L - L*Rz_R + Ix*dphi*dpsi - Iy*dphi*dpsi - Iz*dphi*dpsi ...
%           - (2*Iwx*dpsi*dx)/R - (2*Iwy*dpsi*dx)/R + (2*Iwz*dpsi*dx)/R ...
%               - 2*Ix*dphi*dpsi*cos(phi)^2 + 2*Iz*dphi*dpsi*cos(phi)^2 ...
%             - Ix*ddpsi*cos(phi)*sin(phi) + Iz*ddpsi*cos(phi)*sin(phi) ...
%                                                - 2*L*d*dpsi^2*mw*cos(phi)
% Simplified by me:
% F6=(-Ix+Iz)*ddpsi*cos(phi)*sin(phi)+((-Ix+Iz)*cos(2*phi)-Iy)*dphi*dpsi...
%       + 2*(Iwz-Iwx-Iwy)*dpsi*dx/R-2*L*d*dpsi^2*mw*cos(phi)+L*(Rz_L-Rz_R);
% 
% In an attempt to eliminate dpsi^2 from F1 we subtract F1 and F6 after
% making the coefficients equivalent
F7 = expand(simplify(expand(m*sin(phi)*F6-2*mw*L*cos(phi)*F1)));



% F7 = -2*(2*mw+m+(2*Iwy)/R^2)*mw*L*cos(phi)*ddx...
% -2*(m*d*cos(phi))*mw*L*cos(phi)*ddphi ...
% + 2*(m*d*sin(phi))*mw*L*cos(phi)*dphi^2 ...
% + 2*((tau_L+tau_R)/R)*mw*L*cos(phi);
% + (-Ix+Iz)*ddpsi*m*cos(phi)*sin(phi)^2 ...
% + ((Iz-Ix)*cos(2*phi)-Iy)*m*sin(phi)*dphi*dpsi ...
% + 2*(-Iwx-Iwy+Iwz)*m*sin(phi)/R*dpsi*dx*...
% + L*(Rz_L-*Rz_R)*m*sin(phi);

% F = [(m + 2*Iwy/R^2 + 2*mw)*ddx + m*d*cos(phi)*ddphi - m*d*sin(phi)*(dphi^2+dpsi^2);(2*L^2*mw + (2*Iwy*L^2)/R^2 + 2*Iwz + d^2*m*sin(phi)^2 + Iz*cos(phi)^2 + Ix*sin(phi)^2)*ddpsi + 2*(Ix-Iz+m*d^2)*dphi*dpsi*cos(phi)*sin(phi) + d*dpsi*dx*m*sin(phi); d*ddx*m*cos(phi) + (m*d^2+Iy)*ddphi + (Iz-Ix-m*d^2)*dpsi^2*cos(phi)*sin(phi)];


