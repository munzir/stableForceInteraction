%% Strategy described in the paper
% 1. Express dq_i in terms of the generalized speeds u_i
% 2. Express angular velocity of each frame wrt world frame expressed in 
% the local frame in two forms:
%    a- one involving generalized speeds u_i implicitly
%    b- explicitly
% 3. Express linear velocity of COM of body wrt world frame expressed in 
% the whatever vector basis permits one to write simplest expression in 
% two forms: a- involving generalized speeds u_i implicitly b- explicitly
% 4. Angular accelerations explicit form keeping du_i in evidence
% 5. Linear acc of COM in explicit form keeping du_i in evidence
% 6. LHS with du_i in evidence and the other terms encapsulated

%% Angular velocities

% Wheels
% dthetaL = dx/R - dpsi*L/(2*R);
% iL = [1 0 0]'; jL = [0 1 0]'; kL = [0 0 1]';
% i0 = [cos(thetaL) 0 sin(thetaL)]'; j0 = [0 1 0]'; k0 = [-sin(thetaL) 0 cos(thetaL)]';
syms thetaL thetaR dx dpsi R L real
Z1 = 1/R;
Z2 = L/(2*R);
Z3 = sin(thetaL);
Z4 = cos(thetaL);

dthetaL = Z1*dx - Z2*dpsi;
i0L = [Z4 0 Z3]'; j0L = [0 1 0]'; k0L = [-Z3 0 Z4]';

% w0L = dpsi*k0L;
% wL = w0L + dthetaL*j0L;
% wL =
%  
%         -Z3*dpsi
%  Z1*dx - Z2*dpsi
%          Z4*dpsi
Z5 =         -Z3*dpsi;
Z6 =  Z1*dx - Z2*dpsi;
Z7 =          Z4*dpsi;

wLi = [Z5; Z6; Z7];
wLe = [-Z3*dpsi; Z1*dx-Z2*dpsi;Z4*dpsi];
dwL = [[0 Z1 0]' [-Z3 -Z2 Z4]' zeros(3,17)];

% dthetaR = dx/R + dpsi*L/(2*R);
% iR = [1 0 0]'; jR = [0 1 0]'; kR = [0 0 1]';
% i0 = [cos(thetaR) 0 sin(thetaR)]'; j0 = [0 1 0]'; k0 = [-sin(thetaR) 0 cos(thetaR)]';
Z8 = sin(thetaR); 
Z9 = cos(thetaR);

dthetaR = Z1*dx+Z2*dpsi;
i0R = [Z9 0 Z8]'; j0R = [0 1 0]'; k0R = [-Z8 0 Z9]';

% w0R = dpsi*k0R;
% wR = w0R + dthetaR*j0R
% wR =
%  
%         -Z8*dpsi
%  Z2*dpsi + Z1*dx
%          Z9*dpsi
Z10 =          -Z8*dpsi;
Z11 =   Z2*dpsi + Z1*dx;
Z12 =           Z9*dpsi;

wRi = [Z10; Z11; Z12];
wRe = [-Z8*dpsi; Z2*dpsi + Z1*dx;  Z9*dpsi];
dwR = [[0 Z1 0]' [-Z8 Z2 Z9]' zeros(3,17)];


% Tree
% ************************************************************************
% *                                                                      *
% * w = Rot(f, f(key).a, key) * angVel(f, f(key).a) + f(key).e*f(key).dq *
% *                                                                      *
% ************************************************************************
% w0 = [0; 0; dpsi]; 
% w1 = Rot(f, '0', '1') * w0 + f('1').e*f('1').dq;
% => w1 = [-dq_imu; dpsi*cos(q_imu); dpsi*sin(q_imu)]
syms dq_imu q_imu real
Z13 = cos(q_imu);
Z14 = sin(q_imu);
Z15 = Z13*dpsi;
Z16 = Z14*dpsi;

w1i = [-dq_imu; Z15; Z16]; % implicit
w1e = [-dq_imu; Z13*dpsi; Z14*dpsi]; % explicit
dw1 = [[0 0 0]' [0 Z13 Z14]' [-1 0 0]' zeros(3,16)]; % partial derivatives

% w2 = Rot(f, '1', '2') * w1 + f('2').e*f('2').dq;
% w2i = [-dq_w-dq_imu; Z15*cos(q_w)-Z16*sin(q_w); Z16*cos(q_w)+Z15*sin(q_w)];
% w2e = [-dq_w-dq_imu; Z13*dpsi*cos(q_w)-Z14*dpsi*sin(q_w);
% Z13*dpsi*sin(q_w)+Z14*dpsi*cos(q_w)]
syms dq_w q_w real
Z17 = -dq_w-dq_imu; 
Z18 = Z15*cos(q_w)-Z16*sin(q_w); 
Z19 = Z16*cos(q_w)+Z15*sin(q_w);
Z20 = Z13*cos(q_w)-Z14*sin(q_w);
Z21 = Z13*sin(q_w)+Z14*cos(q_w);

w2i = [Z17; Z18; Z19];
w2e = [-dq_w-dq_imu; Z20*dpsi; Z21*dpsi];
dw2 = [[0 0 0]' [0 Z20 Z21]' [-1 0 0]' [-1 0 0]' zeros(3,15)];

% w3 = Rot(f, '2', '3') * w2 + f('3').e*f('3').dq
% w3i = [-Z17*cos(q_torso)-Z19*sin(q_torso); Z18-dq_torso;
% Z17*sin(q_torso)-Z19*cos(q_torso)]
% w3e = [cos(q_torso)*(dq_w + dq_imu)-Z21*dpsi*sin(q_torso);
% Z20*dpsi-dq_torso; -sin(q_torso)*(dq_w+dq_imu)-Z21*dpsi*cos(q_torso)];
syms dq_torso q_torso real
Z22 = -Z17*cos(q_torso)-Z19*sin(q_torso);
Z23 = Z18-dq_torso;
Z24 = Z17*sin(q_torso)-Z19*cos(q_torso);
Z25 = cos(q_torso);
Z26 = -Z21*sin(q_torso);
Z27 = -sin(q_torso);
Z28 = -Z21*cos(q_torso);

w3i = [Z22; Z23; Z24];
w3e = [Z25*(dq_w + dq_imu)+Z26*dpsi; Z20*dpsi-dq_torso; Z27*(dq_w+dq_imu)+Z28*dpsi];
dw3 = [[0 0 0]' [Z26 Z20 Z28]' [Z25 0 Z27]' [Z25 0 Z27]' [0 -1 0]' ...
    zeros(3,14)];

% w4li = Rot(f, '3', '4l') * w2i + f('4l').e*f('4l').dq
% w4li =
%  
%    Z23*cos(q_1l) - Z24*sin(q_1l)
%                      Z22 - dq_1l
%  - Z24*cos(q_1l) - Z23*sin(q_1l)
%  
%
% w4le =
% 
%  (Z20*cos(q_1l) - Z28*sin(q_1l))*dpsi + (-Z27*sin(q_1l))*dq_imu + (-Z27*sin(q_1l))*dq_w + (-cos(q_1l))*dq_torso
%                                                                        Z26*dpsi + Z25*dq_imu + Z25*dq_w - dq_1l
%   (- Z28*cos(q_1l) - Z20*sin(q_1l))*dpsi + (-Z27*cos(q_1l))*dq_imu + (-Z27*cos(q_1l))*dq_w + sin(q_1l)*dq_torso
syms q_1l dq_1l real
Z29 =    Z23*cos(q_1l) - Z24*sin(q_1l);
Z30 =                       Z22 - dq_1l;
Z31 =  - Z24*cos(q_1l) - Z23*sin(q_1l);
Z32 = Z20*cos(q_1l) - Z28*sin(q_1l);
Z33 = -Z27*sin(q_1l); 
Z34 = -cos(q_1l); 
Z35 = -Z28*cos(q_1l) - Z20*sin(q_1l); 
Z36 = -Z27*cos(q_1l); 
Z37 = sin(q_1l);

w4li = [Z29; Z30; Z31];
w4le = [Z32*dpsi+Z33*dq_imu+Z33*dq_w+Z34*dq_torso;  
        Z26*dpsi+Z25*dq_imu+Z25*dq_w-dq_1l; 
        Z35*dpsi+Z36*dq_imu+Z36*dq_w+Z37*dq_torso];
dw4l = [[0 0 0]' [Z32 Z26 Z35]' [Z33 Z25 Z36]' [Z33 Z25 Z36]' ...
    [Z34 0 Z37]' [0 -1 0]' zeros(3,13)];


% w5l = Rot(f, '4l', '5l') * w4l + f('5l').e*f('5l').dq
% w5li =
%  
%                    - Z29 - dq_2l
%  - Z30*cos(q_2l) - Z31*sin(q_2l)
%    Z31*cos(q_2l) - Z30*sin(q_2l)
%  
%  
% w5le =
%  
%                                                                                                       (-Z32)*dpsi + (-Z33)*dq_imu + (-Z33)*dq_w + (-Z34)*dq_torso - dq_2l
%  (- Z26*cos(q_2l) - Z35*sin(q_2l))*dpsi + (- Z25*cos(q_2l) - Z36*sin(q_2l))*dq_imu + (- Z25*cos(q_2l) - Z36*sin(q_2l))*dq_w + (-Z37*sin(q_2l))*dq_torso + cos(q_2l)*dq_1l
%         (Z35*cos(q_2l) - Z26*sin(q_2l))*dpsi + (Z36*cos(q_2l) - Z25*sin(q_2l))*dq_imu + (Z36*cos(q_2l) - Z25*sin(q_2l))*dq_w + (Z37*cos(q_2l))*dq_torso + sin(q_2l)*dq_1l
syms q_2l dq_2l real 
Z38 =                   - Z29 - dq_2l;
Z39 = - Z30*cos(q_2l) - Z31*sin(q_2l);
Z40 =   Z31*cos(q_2l) - Z30*sin(q_2l);
Z41 = (- Z26*cos(q_2l) - Z35*sin(q_2l));
Z42 = + (- Z25*cos(q_2l) - Z36*sin(q_2l));
Z43 = + (-Z37*sin(q_2l)); 
Z44 = + cos(q_2l);
Z45 = (Z35*cos(q_2l) - Z26*sin(q_2l));
Z46 = + (Z36*cos(q_2l) - Z25*sin(q_2l));
Z47 = + (Z37*cos(q_2l));
Z48 = + sin(q_2l);

w5li = [Z38; Z39; Z40];
w5le = [(-Z32)*dpsi+(-Z33)*dq_imu+(-Z33)*dq_w+(-Z34)*dq_torso-dq_2l;
    Z41*dpsi+Z42*dq_imu+Z42*dq_w+Z43*dq_torso+Z44*dq_1l;
    Z45*dpsi+Z46*dq_imu+Z46*dq_w+Z47*dq_torso+Z48*dq_1l];
dw5l = [[0 0 0]' [-Z32 Z41 Z45]' [-Z33 Z42 Z46]' [-Z33 Z42 Z46]' ...
    [-Z34 Z43 Z47]' [0 Z44 Z48]' [-1 0 0]' zeros(3,12)];

% w6li = Rot(f, '6l', '7l') * w6li + f('7l').e*f('7l').dq
% w6li =
%  
%  Z40*sin(q_3l) - Z38*cos(q_3l)
%                  - Z39 - dq_3l
%  Z40*cos(q_3l) + Z38*sin(q_3l)
%  
%  
% w6le =
%  
%     (Z32*cos(q_3l) + Z45*sin(q_3l))*dpsi + (Z33*cos(q_3l) + Z46*sin(q_3l))*dq_imu + (Z33*cos(q_3l) + Z46*sin(q_3l))*dq_w + (Z34*cos(q_3l) + Z47*sin(q_3l))*dq_torso + (Z48*sin(q_3l))*dq_1l + cos(q_3l)*dq_2l
%                                                                                                                            (-Z41)*dpsi + (-Z42)*dq_imu + (-Z42)*dq_w + (-Z43)*dq_torso + (-Z44)*dq_1l - dq_3l
%  (Z45*cos(q_3l) - Z32*sin(q_3l))*dpsi + (Z46*cos(q_3l) - Z33*sin(q_3l))*dq_imu + (Z46*cos(q_3l) - Z33*sin(q_3l))*dq_w + (Z47*cos(q_3l) - Z34*sin(q_3l))*dq_torso + (Z48*cos(q_3l))*dq_1l + (-sin(q_3l))*dq_2l
syms q_3l dq_3l real
Z49 = Z40*sin(q_3l) - Z38*cos(q_3l);
Z50 =                 - Z39 - dq_3l;
Z51 = Z40*cos(q_3l) + Z38*sin(q_3l);
Z52 = (Z32*cos(q_3l) + Z45*sin(q_3l));
Z53 = + (Z33*cos(q_3l) + Z46*sin(q_3l));
Z54 = + (Z34*cos(q_3l) + Z47*sin(q_3l));
Z55 = + (Z48*sin(q_3l)); 
Z56 = + cos(q_3l);
Z57 = (Z45*cos(q_3l) - Z32*sin(q_3l)); 
Z58 = + (Z46*cos(q_3l) - Z33*sin(q_3l));
Z59 = + (Z47*cos(q_3l) - Z34*sin(q_3l));
Z60 = + (Z48*cos(q_3l)); 
Z61 = + (-sin(q_3l));
 
w6li = [Z49;Z50;Z51]; 
w6le = [Z52*dpsi+Z53*dq_imu+Z53*dq_w+Z54*dq_torso+Z55*dq_1l+Z56*dq_2l;
    (-Z41)*dpsi + (-Z42)*dq_imu + (-Z42)*dq_w + (-Z43)*dq_torso + (-Z44)*dq_1l - dq_3l;
    Z57*dpsi+Z58*dq_imu+Z58*dq_w+Z59*dq_torso+Z60*dq_1l+Z61*dq_2l;]; 
dw6l = [[0 0 0]' [Z52 -Z41 Z57]' [Z53 -Z42 Z58]' [Z53 -Z42 Z58]' ...
    [Z54 -Z43 Z59]' [Z55 -Z44 Z60]' [Z56 0 Z61]' [0 -1 0]' zeros(3,11)];

% w7l = Rot(f, '6l', '7l') * w6l + f('7l').e*f('7l').dq
% w7li =
%  
%                    - Z49 - dq_4l
%  - Z50*cos(q_4l) - Z51*sin(q_4l)
%    Z51*cos(q_4l) - Z50*sin(q_4l)
%  
%  
% w7le =
%  
%                                                                                                                                                   (-Z52)*dpsi + (-Z53)*dq_imu + (-Z53)*dq_w + (-Z54)*dq_torso + (-Z55)*dq_1l + (-Z56)*dq_2l - dq_4l
%  (Z41*cos(q_4l) - Z57*sin(q_4l))*dpsi + (Z42*cos(q_4l) - Z58*sin(q_4l))*dq_imu + (Z42*cos(q_4l) - Z58*sin(q_4l))*dq_w + (Z43*cos(q_4l) - Z59*sin(q_4l))*dq_torso + (Z44*cos(q_4l) - Z60*sin(q_4l))*dq_1l + (-Z61*sin(q_4l))*dq_2l + cos(q_4l)*dq_3l
%   (Z57*cos(q_4l) + Z41*sin(q_4l))*dpsi + (Z58*cos(q_4l) + Z42*sin(q_4l))*dq_imu + (Z58*cos(q_4l) + Z42*sin(q_4l))*dq_w + (Z59*cos(q_4l) + Z43*sin(q_4l))*dq_torso + (Z60*cos(q_4l) + Z44*sin(q_4l))*dq_1l + (Z61*cos(q_4l))*dq_2l + sin(q_4l)*dq_3l
syms q_4l dq_4l real
Z62 =                   - Z49 - dq_4l;
Z63 = - Z50*cos(q_4l) - Z51*sin(q_4l);
Z64 =   Z51*cos(q_4l) - Z50*sin(q_4l);
Z65 = (Z41*cos(q_4l) - Z57*sin(q_4l)); 
Z66 = + (Z42*cos(q_4l) - Z58*sin(q_4l));
Z67 = + (Z43*cos(q_4l) - Z59*sin(q_4l));
Z68 = + (Z44*cos(q_4l) - Z60*sin(q_4l));
Z69 = + (-Z61*sin(q_4l)); 
Z70 = + cos(q_4l);
Z71 = (Z57*cos(q_4l) + Z41*sin(q_4l));
Z72 = + (Z58*cos(q_4l) + Z42*sin(q_4l));
Z73 = + (Z59*cos(q_4l) + Z43*sin(q_4l));
Z74 = + (Z60*cos(q_4l) + Z44*sin(q_4l));
Z75 = + (Z61*cos(q_4l)); 
Z76 = + sin(q_4l);

w7li = [Z62; Z63; Z64];
w7le = [(-Z52)*dpsi + (-Z53)*dq_imu + (-Z53)*dq_w + (-Z54)*dq_torso + (-Z55)*dq_1l + (-Z56)*dq_2l - dq_4l;
    Z65*dpsi+Z66*dq_imu+Z66*dq_w+Z67*dq_torso+Z68*dq_1l+Z69*dq_2l+Z70*dq_3l;
    Z71*dpsi+Z72*dq_imu+Z72*dq_w+Z73*dq_torso+Z74*dq_1l+Z75*dq_2l+Z76*dq_3l];
dw7l = [[0 0 0]' [-Z52 Z65 Z71]' [-Z53 Z66 Z72]' [-Z53 Z66 Z72]' ...
    [-Z54 Z67 Z73]' [-Z55 Z68 Z74]' [-Z56 Z69 Z75]' [0 Z70 Z76]' ...
    [-1 0 0]' zeros(3,10)];

% w8li = Rot(f, '7l', '8l') * w7li + f('8l').e*f('8l').dq
% w8le = collect(Rot(f, '7l', '8l') * w7le + f('8l').e*f('8l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l])
% w8li =
%  
%  Z64*sin(q_5l) - Z62*cos(q_5l)
%                  - Z63 - dq_5l
%  Z64*cos(q_5l) + Z62*sin(q_5l)
%  
%  
% w8le =
%  
%     (Z52*cos(q_5l) + Z71*sin(q_5l))*dpsi + (Z53*cos(q_5l) + Z72*sin(q_5l))*dq_imu + (Z53*cos(q_5l) + Z72*sin(q_5l))*dq_w + (Z54*cos(q_5l) + Z73*sin(q_5l))*dq_torso + (Z55*cos(q_5l) + Z74*sin(q_5l))*dq_1l + (Z56*cos(q_5l) + Z75*sin(q_5l))*dq_2l + (Z76*sin(q_5l))*dq_3l + cos(q_5l)*dq_4l
%                                                                                                                                                                             (-Z65)*dpsi + (-Z66)*dq_imu + (-Z66)*dq_w + (-Z67)*dq_torso + (-Z68)*dq_1l + (-Z69)*dq_2l + (-Z70)*dq_3l - dq_5l
%  (Z71*cos(q_5l) - Z52*sin(q_5l))*dpsi + (Z72*cos(q_5l) - Z53*sin(q_5l))*dq_imu + (Z72*cos(q_5l) - Z53*sin(q_5l))*dq_w + (Z73*cos(q_5l) - Z54*sin(q_5l))*dq_torso + (Z74*cos(q_5l) - Z55*sin(q_5l))*dq_1l + (Z75*cos(q_5l) - Z56*sin(q_5l))*dq_2l + (Z76*cos(q_5l))*dq_3l + (-sin(q_5l))*dq_4l
syms q_5l dq_5l real
Z77 =  Z64*sin(q_5l) - Z62*cos(q_5l);
Z78 =                 - Z63 - dq_5l;
Z79 = Z64*cos(q_5l) + Z62*sin(q_5l);
Z80 = (Z52*cos(q_5l) + Z71*sin(q_5l));
Z81 = + (Z53*cos(q_5l) + Z72*sin(q_5l));
Z82 = + (Z54*cos(q_5l) + Z73*sin(q_5l));
Z83 = + (Z55*cos(q_5l) + Z74*sin(q_5l));
Z84 = + (Z56*cos(q_5l) + Z75*sin(q_5l));
Z85 = + (Z76*sin(q_5l));
Z86 = + cos(q_5l);
Z87 = (Z71*cos(q_5l) - Z52*sin(q_5l));
Z88 = + (Z72*cos(q_5l) - Z53*sin(q_5l));
Z89 = + (Z73*cos(q_5l) - Z54*sin(q_5l));
Z90 = + (Z74*cos(q_5l) - Z55*sin(q_5l));
Z91 = + (Z75*cos(q_5l) - Z56*sin(q_5l));
Z92 = + (Z76*cos(q_5l));
Z93 = + (-sin(q_5l));

w8li = [Z77; Z78; Z79];
w8le = [Z80*dpsi+Z81*dq_imu+Z81*dq_w+Z82*dq_torso+Z83*dq_1l+Z84*dq_2l+Z85*dq_3l+Z86*dq_4l;
    (-Z65)*dpsi + (-Z66)*dq_imu + (-Z66)*dq_w + (-Z67)*dq_torso + (-Z68)*dq_1l + (-Z69)*dq_2l + (-Z70)*dq_3l - dq_5l;
    Z87*dpsi+Z88*dq_imu+Z88*dq_w+Z89*dq_torso+Z90*dq_1l+Z91*dq_2l+Z92*dq_3l+Z93*dq_4l];
dw8l = [[0 0 0]' [Z80 -Z65 Z87]' [Z81 -Z66 Z88]' [Z81 -Z66 Z88]' ...
    [Z82 -Z67 Z89]' [Z83 -Z68 Z90]' [Z84 -Z69 Z91]' [Z85 -Z70 Z92]' ...
    [Z86 0 Z93]' [0 -1 0]' zeros(3,9)];

% w9li = Rot(f, '8l', '9l') * w8li + f('9l').e*f('9l').dq
% w9le = collect(Rot(f, '8l', '9l') * w8le + f('9l').e*f('9l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l])
% w9li =
%  
%                    - Z77 - dq_6l
%  - Z78*cos(q_6l) - Z79*sin(q_6l)
%    Z79*cos(q_6l) - Z78*sin(q_6l)
%  
%  
% w9le =
%  
%                                                                                                                                                                                                     (-Z80)*dpsi + (-Z81)*dq_imu + (-Z81)*dq_w + (-Z82)*dq_torso + (-Z83)*dq_1l + (-Z84)*dq_2l + (-Z85)*dq_3l + (-Z86)*dq_4l - dq_6l
%  (Z65*cos(q_6l) - Z87*sin(q_6l))*dpsi + (Z66*cos(q_6l) - Z88*sin(q_6l))*dq_imu + (Z66*cos(q_6l) - Z88*sin(q_6l))*dq_w + (Z67*cos(q_6l) - Z89*sin(q_6l))*dq_torso + (Z68*cos(q_6l) - Z90*sin(q_6l))*dq_1l + (Z69*cos(q_6l) - Z91*sin(q_6l))*dq_2l + (Z70*cos(q_6l) - Z92*sin(q_6l))*dq_3l + (-Z93*sin(q_6l))*dq_4l + cos(q_6l)*dq_5l
%   (Z87*cos(q_6l) + Z65*sin(q_6l))*dpsi + (Z88*cos(q_6l) + Z66*sin(q_6l))*dq_imu + (Z88*cos(q_6l) + Z66*sin(q_6l))*dq_w + (Z89*cos(q_6l) + Z67*sin(q_6l))*dq_torso + (Z90*cos(q_6l) + Z68*sin(q_6l))*dq_1l + (Z91*cos(q_6l) + Z69*sin(q_6l))*dq_2l + (Z92*cos(q_6l) + Z70*sin(q_6l))*dq_3l + (Z93*cos(q_6l))*dq_4l + sin(q_6l)*dq_5l
syms q_6l dq_6l real  
Z94 =                   - Z77 - dq_6l;
Z95 = - Z78*cos(q_6l) - Z79*sin(q_6l);
Z96 =   Z79*cos(q_6l) - Z78*sin(q_6l);
Z97 = (Z65*cos(q_6l) - Z87*sin(q_6l));
Z98 = + (Z66*cos(q_6l) - Z88*sin(q_6l));
Z99 = + (Z67*cos(q_6l) - Z89*sin(q_6l));
Z100 = + (Z68*cos(q_6l) - Z90*sin(q_6l));
Z101 = + (Z69*cos(q_6l) - Z91*sin(q_6l));
Z102 = + (Z70*cos(q_6l) - Z92*sin(q_6l));
Z103 = + (-Z93*sin(q_6l)); 
Z104 = + cos(q_6l);
Z105 = (Z87*cos(q_6l) + Z65*sin(q_6l));
Z106 = + (Z88*cos(q_6l) + Z66*sin(q_6l));
Z107 = + (Z89*cos(q_6l) + Z67*sin(q_6l));
Z108 = + (Z90*cos(q_6l) + Z68*sin(q_6l));
Z109 = + (Z91*cos(q_6l) + Z69*sin(q_6l));
Z110 = + (Z92*cos(q_6l) + Z70*sin(q_6l));
Z111 = + (Z93*cos(q_6l));
Z112 = + sin(q_6l);

w9li = [Z94; Z95; Z96];
w9le = [(-Z80)*dpsi + (-Z81)*dq_imu + (-Z81)*dq_w + (-Z82)*dq_torso + (-Z83)*dq_1l + (-Z84)*dq_2l + (-Z85)*dq_3l + (-Z86)*dq_4l - dq_6l;
    Z97*dpsi+Z98*dq_imu+Z98*dq_w+Z99*dq_torso+Z100*dq_1l+Z101*dq_2l+Z102*dq_3l+Z103*dq_4l+Z104*dq_5l;
    Z105*dpsi+Z106*dq_imu+Z106*dq_w+Z107*dq_torso+Z108*dq_1l+Z109*dq_2l+Z110*dq_3l+Z111*dq_4l+Z112*dq_5l];
dw9l = [[0 0 0]' [-Z80 Z97 Z105]' [-Z81 Z98 Z106]' [-Z81 Z98 Z106]' ...
    [-Z82 Z99 Z107]' [-Z83 Z100 Z108]' [-Z84 Z101 Z109]' [-Z85 Z102 Z110]' ...
    [-Z86 Z103 Z111]' [0 Z104 Z112]' [-1 0 0]' zeros(3,18)];


% w10li = Rot(f, '9l', '10l') * w9li + f('10l').e*f('10l').dq
% w10le = collect(Rot(f, '9l', '10l') * w9le + f('10l').e*f('10l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l,dq_7l])
% w10li =
%  
%    Z96*sin(q_7l) - Z94*cos(q_7l)
%  - Z96*cos(q_7l) - Z94*sin(q_7l)
%                    - Z95 - dq_7l
%  
%  
% w10le =
%  
%   (Z80*cos(q_7l) + Z105*sin(q_7l))*dpsi + (Z81*cos(q_7l) + Z106*sin(q_7l))*dq_imu + (Z81*cos(q_7l) + Z106*sin(q_7l))*dq_w + (Z82*cos(q_7l) + Z107*sin(q_7l))*dq_torso + (Z83*cos(q_7l) + Z108*sin(q_7l))*dq_1l + (Z84*cos(q_7l) + Z109*sin(q_7l))*dq_2l + (Z85*cos(q_7l) + Z110*sin(q_7l))*dq_3l + (Z86*cos(q_7l) + Z111*sin(q_7l))*dq_4l + (Z112*sin(q_7l))*dq_5l + cos(q_7l)*dq_6l
%  (Z80*sin(q_7l) - Z105*cos(q_7l))*dpsi + (Z81*sin(q_7l) - Z106*cos(q_7l))*dq_imu + (Z81*sin(q_7l) - Z106*cos(q_7l))*dq_w + (Z82*sin(q_7l) - Z107*cos(q_7l))*dq_torso + (Z83*sin(q_7l) - Z108*cos(q_7l))*dq_1l + (Z84*sin(q_7l) - Z109*cos(q_7l))*dq_2l + (Z85*sin(q_7l) - Z110*cos(q_7l))*dq_3l + (Z86*sin(q_7l) - Z111*cos(q_7l))*dq_4l + (-Z112*cos(q_7l))*dq_5l + sin(q_7l)*dq_6l
%                                                                                                                                                                                                                                   (-Z97)*dpsi + (-Z98)*dq_imu + (-Z98)*dq_w + (-Z99)*dq_torso + (-Z100)*dq_1l + (-Z101)*dq_2l + (-Z102)*dq_3l + (-Z103)*dq_4l + (-Z104)*dq_5l - dq_7l
                                                                                                                                                                                                                               
syms q_7l dq_7l real 
Z113 =   Z96*sin(q_7l) - Z94*cos(q_7l);
Z114 = - Z96*cos(q_7l) - Z94*sin(q_7l);
Z115 =                   - Z95 - dq_7l;
Z116 = (Z80*cos(q_7l) + Z105*sin(q_7l));
Z117 = + (Z81*cos(q_7l) + Z106*sin(q_7l));
Z118 = + (Z82*cos(q_7l) + Z107*sin(q_7l));
Z119 = + (Z83*cos(q_7l) + Z108*sin(q_7l));
Z120 = + (Z84*cos(q_7l) + Z109*sin(q_7l));
Z121 = + (Z85*cos(q_7l) + Z110*sin(q_7l));
Z122 = + (Z86*cos(q_7l) + Z111*sin(q_7l));
Z123 = + (Z112*sin(q_7l));
Z124 = + cos(q_7l);
Z125 = (Z80*sin(q_7l) - Z105*cos(q_7l));
Z126 = + (Z81*sin(q_7l) - Z106*cos(q_7l));
Z127 = + (Z82*sin(q_7l) - Z107*cos(q_7l));
Z128 = + (Z83*sin(q_7l) - Z108*cos(q_7l));
Z129 = + (Z84*sin(q_7l) - Z109*cos(q_7l));
Z130 = + (Z85*sin(q_7l) - Z110*cos(q_7l));
Z131 = + (Z86*sin(q_7l) - Z111*cos(q_7l));
Z132 = + (-Z112*cos(q_7l));
Z133 = + sin(q_7l);
                                                                                                                                                                                                                                  

w10li = [Z113; Z114; Z115];
w10le = [Z116*dpsi+Z117*dq_imu+Z117*dq_w+Z118*dq_torso+Z119*dq_1l+Z120*dq_2l+Z121*dq_3l+Z122*dq_4l+Z123*dq_5l+Z124*dq_6l;
    Z125*dpsi+Z126*dq_imu+Z126*dq_w+Z127*dq_torso+Z128*dq_1l+Z129*dq_2l+Z130*dq_3l+Z131*dq_4l+Z132*dq_5l+Z133*dq_6l
    (-Z97)*dpsi + (-Z98)*dq_imu + (-Z98)*dq_w + (-Z99)*dq_torso + (-Z100)*dq_1l + (-Z101)*dq_2l + (-Z102)*dq_3l + (-Z103)*dq_4l + (-Z104)*dq_5l - dq_7l];
dw10l = [[0 0 0]' [Z116 Z125 -Z97]' [Z117 Z126 -Z98]' [Z117 Z126 -Z98]' ...
    [Z118 Z127 -Z99]' [Z119 Z128 -Z100]' [Z120 Z129 -Z101]' [Z121 Z130 -Z102]' ...
    [Z122 Z131 -Z103]' [Z123 Z132 -Z104]' [Z124 Z133 0]' [0 0 -1]' zeros(3,7)];


% w4ri = Rot(f, '3', '4r') * w3i + f('4r').e*f('4r').dq
% w4re = collect(Rot(f, '3', '4r') * w3e + f('4r').e*f('4r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r])
% w4ri =
%  
%  Z23*cos(q_1r) + Z24*sin(q_1r)
%                  - Z22 - dq_1r
%  Z24*cos(q_1r) - Z23*sin(q_1r)
%  
%  
% w4re =
%  
%  (Z20*cos(q_1r) + Z28*sin(q_1r))*dpsi + (Z27*sin(q_1r))*dq_imu + (Z27*sin(q_1r))*dq_w + (-cos(q_1r))*dq_torso
%                                                             (-Z26)*dpsi + (-Z25)*dq_imu + (-Z25)*dq_w - dq_1r
%     (Z28*cos(q_1r) - Z20*sin(q_1r))*dpsi + (Z27*cos(q_1r))*dq_imu + (Z27*cos(q_1r))*dq_w + sin(q_1r)*dq_torso
syms q_1r dq_1r real
Z134 = Z23*cos(q_1r) + Z24*sin(q_1r);
Z135 =                 - Z22 - dq_1r;
Z136 = Z24*cos(q_1r) - Z23*sin(q_1r);
Z137 = (Z20*cos(q_1r) + Z28*sin(q_1r));
Z138 = + (Z27*sin(q_1r));
Z139 = + (-cos(q_1r));
Z140 = (Z28*cos(q_1r) - Z20*sin(q_1r));
Z141 = + (Z27*cos(q_1r));
Z142 = + sin(q_1r);

w4ri = [Z134; Z135; Z136];
w4re = [Z137*dpsi+Z138*dq_imu+Z138*dq_w+Z139*dq_torso;  
        (-Z26)*dpsi + (-Z25)*dq_imu + (-Z25)*dq_w - dq_1r;
        Z140*dpsi+Z141*dq_imu+Z141*dq_w+Z142*dq_torso];
dw4r = [[0 0 0]' [Z137 -Z26 Z140]' [Z138 -Z25 Z141]' [Z138 -Z25 Z141]' ...
    [Z139 0 Z142]' zeros(3,7) [0 -1 0]' zeros(3,6)];

% w5ri = Rot(f, '4r', '5r') * w4ri + f('5r').e*f('5r').dq
% w5re = collect(Rot(f, '4r', '5r') * w4re + f('5r').e*f('5r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r])
% w5ri =
%  
%                     - Z134 - dq_2r
%  - Z135*cos(q_2r) - Z136*sin(q_2r)
%    Z136*cos(q_2r) - Z135*sin(q_2r)
%  
%  
% w5re =
%  
%                                                                                                 (-Z137)*dpsi + (-Z138)*dq_imu + (-Z138)*dq_w + (-Z139)*dq_torso - dq_2r
%  (Z26*cos(q_2r) - Z140*sin(q_2r))*dpsi + (Z25*cos(q_2r) - Z141*sin(q_2r))*dq_imu + (Z25*cos(q_2r) - Z141*sin(q_2r))*dq_w + (-Z142*sin(q_2r))*dq_torso + cos(q_2r)*dq_1r
%   (Z140*cos(q_2r) + Z26*sin(q_2r))*dpsi + (Z141*cos(q_2r) + Z25*sin(q_2r))*dq_imu + (Z141*cos(q_2r) + Z25*sin(q_2r))*dq_w + (Z142*cos(q_2r))*dq_torso + sin(q_2r)*dq_1r
syms q_2r dq_2r real
Z143 = - Z134 - dq_2r;
Z144 = - Z135*cos(q_2r) - Z136*sin(q_2r);
Z145 =   Z136*cos(q_2r) - Z135*sin(q_2r);                                                                                                
Z146 = (Z26*cos(q_2r) - Z140*sin(q_2r)); 
Z147 = + (Z25*cos(q_2r) - Z141*sin(q_2r));
Z148 = + (-Z142*sin(q_2r));
Z149 = + cos(q_2r);
Z150 = (Z140*cos(q_2r) + Z26*sin(q_2r));
Z151 = + (Z141*cos(q_2r) + Z25*sin(q_2r));
Z152 = + (Z142*cos(q_2r));
Z153 = + sin(q_2r);
 
w5ri = [Z143; Z144; Z145];
w5re = [(-Z137)*dpsi + (-Z138)*dq_imu + (-Z138)*dq_w + (-Z139)*dq_torso - dq_2r;
    Z146*dpsi+Z147*dq_imu+Z147*dq_w+Z148*dq_torso+Z149*dq_1r;
    Z150*dpsi+Z151*dq_imu+Z151*dq_w+Z152*dq_torso+Z153*dq_1r];
dw5r = [[0 0 0]' [-Z137 Z146 Z150]' [-Z138 Z147 Z151]' [-Z138 Z147 Z151]' ...
    [-Z139 Z148 Z152]' zeros(3,7) [0 Z149 Z153]' [-1 0 0]' zeros(3,5)];
  
% w6ri = Rot(f, '6r', '7r') * w6ri + f('7r').e*f('7r').dq
% w6ri =
%  
%  Z145*sin(q_3r) - Z143*cos(q_3r)
%                  - Z144 - dq_3r
%  Z145*cos(q_3r) + Z143*sin(q_3r)
%  
%  
% w6re =
%  
%     (Z137*cos(q_3r) + Z150*sin(q_3r))*dpsi + (Z138*cos(q_3r) + Z151*sin(q_3r))*dq_imu + (Z138*cos(q_3r) + Z151*sin(q_3r))*dq_w + (Z139*cos(q_3r) + Z152*sin(q_3r))*dq_torso + (Z153*sin(q_3r))*dq_1r + cos(q_3r)*dq_2r
%                                                                                                                            (-Z146)*dpsi + (-Z147)*dq_imu + (-Z147)*dq_w + (-Z148)*dq_torso + (-Z149)*dq_1r - dq_3r
%  (Z150*cos(q_3r) - Z137*sin(q_3r))*dpsi + (Z151*cos(q_3r) - Z138*sin(q_3r))*dq_imu + (Z151*cos(q_3r) - Z138*sin(q_3r))*dq_w + (Z152*cos(q_3r) - Z139*sin(q_3r))*dq_torso + (Z153*cos(q_3r))*dq_1r + (-sin(q_3r))*dq_2r
syms q_3r dq_3r real
Z154 = Z145*sin(q_3r) - Z143*cos(q_3r);
Z155 =                 - Z144 - dq_3r;
Z156 = Z145*cos(q_3r) + Z143*sin(q_3r);
Z157 = (Z137*cos(q_3r) + Z150*sin(q_3r));
Z158 = + (Z138*cos(q_3r) + Z151*sin(q_3r));
Z159 = + (Z139*cos(q_3r) + Z152*sin(q_3r));
Z160 = + (Z153*sin(q_3r)); 
Z161 = + cos(q_3r);
Z162 = (Z150*cos(q_3r) - Z137*sin(q_3r)); 
Z163 = + (Z151*cos(q_3r) - Z138*sin(q_3r));
Z164 = + (Z152*cos(q_3r) - Z139*sin(q_3r));
Z165 = + (Z153*cos(q_3r)); 
Z166 = + (-sin(q_3r));
 
w6ri = [Z154;Z155;Z156]; 
w6re = [Z157*dpsi+Z158*dq_imu+Z158*dq_w+Z159*dq_torso+Z160*dq_1r+Z161*dq_2r;
    (-Z146)*dpsi + (-Z147)*dq_imu + (-Z147)*dq_w + (-Z148)*dq_torso + (-Z149)*dq_1r - dq_3r;
    Z162*dpsi+Z163*dq_imu+Z163*dq_w+Z164*dq_torso+Z165*dq_1r+Z166*dq_2r;]; 
dw6r = [[0 0 0]' [Z157 -Z146 Z162]' [Z158 -Z147 Z163]' [Z158 -Z147 Z163]' ...
    [Z159 -Z148 Z164]' zeros(3,7) [Z160 -Z149 Z165]' [Z161 0 Z166]' ... 
    [0 -1 0]' zeros(3,4)];

% w7r = Rot(f, '6r', '7r') * w6r + f('7r').e*f('7r').dq
% w7ri =
%  
%                    - Z154 - dq_4r
%  - Z155*cos(q_4r) - Z156*sin(q_4r)
%    Z156*cos(q_4r) - Z155*sin(q_4r)
%  
%  
% w7re =
%  
%                                                                                                                                                   (-Z157)*dpsi + (-Z158)*dq_imu + (-Z158)*dq_w + (-Z159)*dq_torso + (-Z160)*dq_1r + (-Z161)*dq_2r - dq_4r
%  (Z146*cos(q_4r) - Z162*sin(q_4r))*dpsi + (Z147*cos(q_4r) - Z163*sin(q_4r))*dq_imu + (Z147*cos(q_4r) - Z163*sin(q_4r))*dq_w + (Z148*cos(q_4r) - Z164*sin(q_4r))*dq_torso + (Z149*cos(q_4r) - Z165*sin(q_4r))*dq_1r + (-Z166*sin(q_4r))*dq_2r + cos(q_4r)*dq_3r
%   (Z162*cos(q_4r) + Z146*sin(q_4r))*dpsi + (Z163*cos(q_4r) + Z147*sin(q_4r))*dq_imu + (Z163*cos(q_4r) + Z147*sin(q_4r))*dq_w + (Z164*cos(q_4r) + Z148*sin(q_4r))*dq_torso + (Z165*cos(q_4r) + Z149*sin(q_4r))*dq_1r + (Z166*cos(q_4r))*dq_2r + sin(q_4r)*dq_3r
syms q_4r dq_4r real
Z167 =                   - Z154 - dq_4r;
Z168 = - Z155*cos(q_4r) - Z156*sin(q_4r);
Z169 =   Z156*cos(q_4r) - Z155*sin(q_4r);
Z170 = (Z146*cos(q_4r) - Z162*sin(q_4r)); 
Z171 = + (Z147*cos(q_4r) - Z163*sin(q_4r));
Z172 = + (Z148*cos(q_4r) - Z164*sin(q_4r));
Z173 = + (Z149*cos(q_4r) - Z165*sin(q_4r));
Z174 = + (-Z166*sin(q_4r)); 
Z175 = + cos(q_4r);
Z176 = (Z162*cos(q_4r) + Z146*sin(q_4r));
Z177 = + (Z163*cos(q_4r) + Z147*sin(q_4r));
Z178 = + (Z164*cos(q_4r) + Z148*sin(q_4r));
Z179 = + (Z165*cos(q_4r) + Z149*sin(q_4r));
Z180 = + (Z166*cos(q_4r)); 
Z181 = + sin(q_4r);

w7ri = [Z167; Z168; Z169];
w7re = [(-Z157)*dpsi + (-Z158)*dq_imu + (-Z158)*dq_w + (-Z159)*dq_torso + (-Z160)*dq_1r + (-Z161)*dq_2r - dq_4r;
    Z170*dpsi+Z171*dq_imu+Z171*dq_w+Z172*dq_torso+Z173*dq_1r+Z174*dq_2r+Z175*dq_3r;
    Z176*dpsi+Z177*dq_imu+Z177*dq_w+Z178*dq_torso+Z179*dq_1r+Z180*dq_2r+Z181*dq_3r];
dw7r = [[0 0 0]' [-Z157 Z170 Z176]' [-Z158 Z171 Z177]' [-Z158 Z171 Z177]' ...
    [-Z159 Z172 Z178]' zeros(3,7) [-Z160 Z173 Z179]' [-Z161 Z174 Z180]' ...
    [0 Z175 Z181]' [-1 0 0]' zeros(3,3)];

% w8ri = Rot(f, '7r', '8r') * w7ri + f('8r').e*f('8r').dq
% w8re = correct(Rot(f, '7r', '8r') * w7re + f('8r').e*f('8r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r])
% w8ri =
%  
%  Z169*sin(q_5r) - Z167*cos(q_5r)
%                  - Z168 - dq_5r
%  Z169*cos(q_5r) + Z167*sin(q_5r)
%  
%  
% w8re =
%  
%     (Z157*cos(q_5r) + Z176*sin(q_5r))*dpsi + (Z158*cos(q_5r) + Z177*sin(q_5r))*dq_imu + (Z158*cos(q_5r) + Z177*sin(q_5r))*dq_w + (Z159*cos(q_5r) + Z178*sin(q_5r))*dq_torso + (Z160*cos(q_5r) + Z179*sin(q_5r))*dq_1r + (Z161*cos(q_5r) + Z180*sin(q_5r))*dq_2r + (Z181*sin(q_5r))*dq_3r + cos(q_5r)*dq_4r
%                                                                                                                                                                             (-Z170)*dpsi + (-Z171)*dq_imu + (-Z171)*dq_w + (-Z172)*dq_torso + (-Z173)*dq_1r + (-Z174)*dq_2r + (-Z175)*dq_3r - dq_5r
%  (Z176*cos(q_5r) - Z157*sin(q_5r))*dpsi + (Z177*cos(q_5r) - Z158*sin(q_5r))*dq_imu + (Z177*cos(q_5r) - Z158*sin(q_5r))*dq_w + (Z178*cos(q_5r) - Z159*sin(q_5r))*dq_torso + (Z179*cos(q_5r) - Z160*sin(q_5r))*dq_1r + (Z180*cos(q_5r) - Z161*sin(q_5r))*dq_2r + (Z181*cos(q_5r))*dq_3r + (-sin(q_5r))*dq_4r
syms q_5r dq_5r real
Z182 =  Z169*sin(q_5r) - Z167*cos(q_5r);
Z183 =                 - Z168 - dq_5r;
Z184 = Z169*cos(q_5r) + Z167*sin(q_5r);
Z185 = (Z157*cos(q_5r) + Z176*sin(q_5r));
Z186 = + (Z158*cos(q_5r) + Z177*sin(q_5r));
Z187 = + (Z159*cos(q_5r) + Z178*sin(q_5r));
Z188 = + (Z160*cos(q_5r) + Z179*sin(q_5r));
Z189 = + (Z161*cos(q_5r) + Z180*sin(q_5r));
Z190 = + (Z181*sin(q_5r));
Z191 = + cos(q_5r);
Z192 = (Z176*cos(q_5r) - Z157*sin(q_5r));
Z193 = + (Z177*cos(q_5r) - Z158*sin(q_5r));
Z194 = + (Z178*cos(q_5r) - Z159*sin(q_5r));
Z195 = + (Z179*cos(q_5r) - Z160*sin(q_5r));
Z196 = + (Z180*cos(q_5r) - Z161*sin(q_5r));
Z197 = + (Z181*cos(q_5r));
Z198 = + (-sin(q_5r));

w8ri = [Z182; Z183; Z184];
w8re = [Z185*dpsi+Z186*dq_imu+Z186*dq_w+Z187*dq_torso+Z188*dq_1r+Z189*dq_2r+Z190*dq_3r+Z191*dq_4r;
    (-Z170)*dpsi + (-Z171)*dq_imu + (-Z171)*dq_w + (-Z172)*dq_torso + (-Z173)*dq_1r + (-Z174)*dq_2r + (-Z175)*dq_3r - dq_5r;
    Z192*dpsi+Z193*dq_imu+Z193*dq_w+Z194*dq_torso+Z195*dq_1r+Z196*dq_2r+Z197*dq_3r+Z198*dq_4r];
dw8r = [[0 0 0]' [Z185 -Z170 Z192]' [Z186 -Z171 Z193]' [Z186 -Z171 Z193]' ...
    [Z187 -Z172 Z194]' zeros(3,7) [Z188 -Z173 Z195]' [Z189 -Z174 Z196]' ...
    [Z190 -Z175 Z197]' [Z191 0 Z198]' [0 -1 0]' zeros(3,2)];

% w9ri = Rot(f, '8r', '9r') * w8ri + f('9r').e*f('9r').dq
% w9re = correct(Rot(f, '8r', '9r') * w8re + f('9r').e*f('9r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r])
% w9ri =
%  
%                    - Z182 - dq_6r
%  - Z183*cos(q_6r) - Z184*sin(q_6r)
%    Z184*cos(q_6r) - Z183*sin(q_6r)
%  
%  
% w9re =
%  
%                                                                                                                                                                                                     (-Z185)*dpsi + (-Z186)*dq_imu + (-Z186)*dq_w + (-Z187)*dq_torso + (-Z188)*dq_1r + (-Z189)*dq_2r + (-Z190)*dq_3r + (-Z191)*dq_4r - dq_6r
%  (Z170*cos(q_6r) - Z192*sin(q_6r))*dpsi + (Z171*cos(q_6r) - Z193*sin(q_6r))*dq_imu + (Z171*cos(q_6r) - Z193*sin(q_6r))*dq_w + (Z172*cos(q_6r) - Z194*sin(q_6r))*dq_torso + (Z173*cos(q_6r) - Z195*sin(q_6r))*dq_1r + (Z174*cos(q_6r) - Z196*sin(q_6r))*dq_2r + (Z175*cos(q_6r) - Z197*sin(q_6r))*dq_3r + (-Z198*sin(q_6r))*dq_4r + cos(q_6r)*dq_5r
%   (Z192*cos(q_6r) + Z170*sin(q_6r))*dpsi + (Z193*cos(q_6r) + Z171*sin(q_6r))*dq_imu + (Z193*cos(q_6r) + Z171*sin(q_6r))*dq_w + (Z194*cos(q_6r) + Z172*sin(q_6r))*dq_torso + (Z195*cos(q_6r) + Z173*sin(q_6r))*dq_1r + (Z196*cos(q_6r) + Z174*sin(q_6r))*dq_2r + (Z197*cos(q_6r) + Z175*sin(q_6r))*dq_3r + (Z198*cos(q_6r))*dq_4r + sin(q_6r)*dq_5r
syms q_6r dq_6r real  
Z199 =                   - Z182 - dq_6r;
Z200 = - Z183*cos(q_6r) - Z184*sin(q_6r);
Z201 =   Z184*cos(q_6r) - Z183*sin(q_6r);
Z202 = (Z170*cos(q_6r) - Z192*sin(q_6r));
Z203 = + (Z171*cos(q_6r) - Z193*sin(q_6r));
Z204 = + (Z172*cos(q_6r) - Z194*sin(q_6r));
Z205 = + (Z173*cos(q_6r) - Z195*sin(q_6r));
Z206 = + (Z174*cos(q_6r) - Z196*sin(q_6r));
Z207 = + (Z175*cos(q_6r) - Z197*sin(q_6r));
Z208 = + (-Z198*sin(q_6r)); 
Z209 = + cos(q_6r);
Z210 = (Z192*cos(q_6r) + Z170*sin(q_6r));
Z211 = + (Z193*cos(q_6r) + Z171*sin(q_6r));
Z212 = + (Z194*cos(q_6r) + Z172*sin(q_6r));
Z213 = + (Z195*cos(q_6r) + Z173*sin(q_6r));
Z214 = + (Z196*cos(q_6r) + Z174*sin(q_6r));
Z215 = + (Z197*cos(q_6r) + Z175*sin(q_6r));
Z216 = + (Z198*cos(q_6r));
Z217 = + sin(q_6r);

w9ri = [Z199; Z200; Z201];
w9re = [(-Z185)*dpsi + (-Z186)*dq_imu + (-Z186)*dq_w + (-Z187)*dq_torso + (-Z188)*dq_1r + (-Z189)*dq_2r + (-Z190)*dq_3r + (-Z191)*dq_4r - dq_6r;
    Z202*dpsi+Z203*dq_imu+Z203*dq_w+Z204*dq_torso+Z205*dq_1r+Z206*dq_2r+Z207*dq_3r+Z208*dq_4r+Z209*dq_5r;
    Z210*dpsi+Z211*dq_imu+Z211*dq_w+Z212*dq_torso+Z213*dq_1r+Z214*dq_2r+Z215*dq_3r+Z216*dq_4r+Z217*dq_5r];
dw9r = [[0 0 0]' [-Z185 Z202 Z210]' [-Z186 Z203 Z211]' [-Z186 Z203 Z211]' ...
    [-Z187 Z204 Z212]' zeros(3,7) [-Z188 Z205 Z213]' [-Z189 Z206 Z214]'...
    [-Z190 Z207 Z215]' [-Z191 Z208 Z216]' [0 Z209 Z217]' [-1 0 0]'...
    zeros(3,1)];


% w10ri = Rot(f, '9r', '10r') * w9ri + f('10r').e*f('10r').dq
% w10re = correct(Rot(f, '9r', '10r') * w9re + f('10r').e*f('10r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r,dq_7r])
% w10ri =
%  
%    Z201*sin(q_7r) - Z199*cos(q_7r)
%  - Z201*cos(q_7r) - Z199*sin(q_7r)
%                    - Z200 - dq_7r
%  
%  
% w10re =
%  
%   (Z185*cos(q_7r) + Z210*sin(q_7r))*dpsi + (Z186*cos(q_7r) + Z211*sin(q_7r))*dq_imu + (Z186*cos(q_7r) + Z211*sin(q_7r))*dq_w + (Z187*cos(q_7r) + Z212*sin(q_7r))*dq_torso + (Z188*cos(q_7r) + Z213*sin(q_7r))*dq_1r + (Z189*cos(q_7r) + Z214*sin(q_7r))*dq_2r + (Z190*cos(q_7r) + Z215*sin(q_7r))*dq_3r + (Z191*cos(q_7r) + Z216*sin(q_7r))*dq_4r + (Z217*sin(q_7r))*dq_5r + cos(q_7r)*dq_6r
%  (Z185*sin(q_7r) - Z210*cos(q_7r))*dpsi + (Z186*sin(q_7r) - Z211*cos(q_7r))*dq_imu + (Z186*sin(q_7r) - Z211*cos(q_7r))*dq_w + (Z187*sin(q_7r) - Z212*cos(q_7r))*dq_torso + (Z188*sin(q_7r) - Z213*cos(q_7r))*dq_1r + (Z189*sin(q_7r) - Z214*cos(q_7r))*dq_2r + (Z190*sin(q_7r) - Z215*cos(q_7r))*dq_3r + (Z191*sin(q_7r) - Z216*cos(q_7r))*dq_4r + (-Z217*cos(q_7r))*dq_5r + sin(q_7r)*dq_6r
%                                                                                                                                                                                                                                   (-Z202)*dpsi + (-Z203)*dq_imu + (-Z203)*dq_w + (-Z204)*dq_torso + (-Z205)*dq_1r + (-Z206)*dq_2r + (-Z207)*dq_3r + (-Z208)*dq_4r + (-Z209)*dq_5r - dq_7r
syms q_7r dq_7r real
Z218 = Z201*sin(q_7r) - Z199*cos(q_7r);
Z219 = - Z201*cos(q_7r) - Z199*sin(q_7r);
Z220 =                   - Z200 - dq_7r;
Z221 = (Z185*cos(q_7r) + Z210*sin(q_7r));
Z222 = + (Z186*cos(q_7r) + Z211*sin(q_7r));
Z223 = + (Z187*cos(q_7r) + Z212*sin(q_7r));
Z224 = + (Z188*cos(q_7r) + Z213*sin(q_7r));
Z225 = + (Z189*cos(q_7r) + Z214*sin(q_7r));
Z226 = + (Z190*cos(q_7r) + Z215*sin(q_7r));
Z227 = + (Z191*cos(q_7r) + Z216*sin(q_7r));
Z228 = + (Z217*sin(q_7r));
Z229 = + cos(q_7r);
Z230 = (Z185*sin(q_7r) - Z210*cos(q_7r));
Z231 = + (Z186*sin(q_7r) - Z211*cos(q_7r));
Z232 = + (Z187*sin(q_7r) - Z212*cos(q_7r));
Z233 = + (Z188*sin(q_7r) - Z213*cos(q_7r));
Z234 = + (Z189*sin(q_7r) - Z214*cos(q_7r));
Z235 = + (Z190*sin(q_7r) - Z215*cos(q_7r));
Z236 = + (Z191*sin(q_7r) - Z216*cos(q_7r));
Z237 = + (-Z217*cos(q_7r));
Z238 = + sin(q_7r);

w10ri = [Z218; Z219; Z220];
w10re = [Z221*dpsi+Z222*dq_imu+Z222*dq_w+Z223*dq_torso+Z224*dq_1r+Z225*dq_2r+Z226*dq_3r+Z227*dq_4r+Z228*dq_5r+Z229*dq_6r;
    Z230*dpsi+Z231*dq_imu+Z231*dq_w+Z232*dq_torso+Z233*dq_1r+Z234*dq_2r+Z235*dq_3r+Z236*dq_4r+Z237*dq_5r+Z238*dq_6r;
    (-Z202)*dpsi + (-Z203)*dq_imu + (-Z203)*dq_w + (-Z204)*dq_torso + (-Z205)*dq_1r + (-Z206)*dq_2r + (-Z207)*dq_3r + (-Z208)*dq_4r + (-Z209)*dq_5r - dq_7r];
dw10r = [[0 0 0]' [Z221 Z230 -Z202]' [Z222 Z231 -Z203]' [Z222 Z231 -Z203]' ...
    [Z223 Z232 -Z204]' zeros(3,7) [Z224 Z233 -Z205]' [Z225 Z234 -Z206]'...
    [Z226 Z235 -Z207]' [Z227 Z236 -Z208]' [Z228 Z237 -Z209]' ...
    [Z229 Z238 0]' [0 0 -1]'];

%% Linear Velocity

% Wheels
% rOL = L/2*[0 1 0]'; rOR = -L/2*[0 1 0]';
% w0 = [0; 0; dpsi]; 
% v0 = [dx; 0; 0]; 
% vL = v0 + cross(w0, rOL); 
% vR = v0 + cross(w0, rOR);
% vL =
%  
%  dx - (L*dpsi)/2
%                0
%                0
%  
% vR =
%  
%  dx + (L*dpsi)/2
%                0
%                0

Z239 = dx - (L*dpsi)/2;
Z240 = dx + (L*dpsi)/2;
Z241 = L/2;

vLi = [Z239; 0; 0];
vLe = [dx-Z241*dpsi; 0; 0];
dvL = [[1 0 0]' [-Z241 0 0]' zeros(3, 17)];

vRi = [Z240; 0; 0];
vRe = [dx+Z241*dpsi; 0; 0];
dvR = [[1 0 0]' [+Z241 0 0]' zeros(3, 17)];

% Tree
% *************************************************************************
% *       V = Rot(f, f(key).a, key) * (linVel(f, f(key).a) + ...          *
% *                  cross(angVel(f, f(key).a), f(key).P))                *
% *************************************************************************

% v1 = Rot(f, '0', '1') * (v0 + cross(w0, f('1').P))   
% v1 =
%  
%               0
%   dx*sin(q_imu)
%  -dx*cos(q_imu)

Z242 =   dx*sin(q_imu);
Z243 =  -dx*cos(q_imu);
Z244 = sin(q_imu);
Z245 = -cos(q_imu);


v1i = [0; Z242; Z243];
v1e = [0; Z244*dx; Z245*dx];
dv1 = [[0 Z244 Z245]' zeros(3,18)];

% v2i = Rot(f, '1', '2') * (v1i + cross(w1i, f('2').P))
% v2e = collect(Rot(f, '1', '2') * (v1e + cross(w1e, f('2').P)),[dx,dpsi,dq_imu])
% v2i =
%  
%                                            - L1*Z16 - L2*Z15
%  cos(q_w)*(Z242 - L2*dq_imu) - sin(q_w)*(Z243 - L1*dq_imu)
%  sin(q_w)*(Z242 - L2*dq_imu) + cos(q_w)*(Z243 - L1*dq_imu)
%  
%  
% v2e =
%  
%                                                     (- L1*Z14 - L2*Z13)*dpsi
%    (Z244*cos(q_w) - Z245*sin(q_w))*dx + (L1*sin(q_w) - L2*cos(q_w))*dq_imu
%  (Z245*cos(q_w) + Z244*sin(q_w))*dx + (- L1*cos(q_w) - L2*sin(q_w))*dq_imu
syms L1 L2 L3 L4 L5 L6 L7 L8 L9 real
Z246 =                                           - L1*Z16 - L2*Z15;
Z247 = cos(q_w)*(Z242 - L2*dq_imu) - sin(q_w)*(Z243 - L1*dq_imu);
Z248 = sin(q_w)*(Z242 - L2*dq_imu) + cos(q_w)*(Z243 - L1*dq_imu);
Z249 = (- L1*Z14 - L2*Z13);
Z250 = (Z244*cos(q_w) - Z245*sin(q_w));
Z251 = + (L1*sin(q_w) - L2*cos(q_w));
Z252 = (Z245*cos(q_w) + Z244*sin(q_w));
Z253 = + (- L1*cos(q_w) - L2*sin(q_w));

v2i = [Z246; Z247; Z248];
v2e = [Z249*dpsi; Z250*dx+Z251*dq_imu; Z252*dx+Z253*dq_imu];
dv2 = [[0 Z250 Z252]' [Z249 0 0]' [0 Z251 Z253]' zeros(3,16)];

% v3i = Rot(f, '2', '3') * (v2i + cross(w2i, f('3').P))
% v3e = collect(Rot(f, '2', '3') * (v2e + cross(w2e, f('3').P)),[dx,dpsi,dq_imu,dq_w])
% v3i =
%  
%  - sin(q_torso)*(Z248 + L3*Z17) - cos(q_torso)*(Z246 - L3*Z19 + L4*Z18)
%                                                           Z247 - L4*Z17
%    sin(q_torso)*(Z246 - L3*Z19 + L4*Z18) - cos(q_torso)*(Z248 + L3*Z17)
%  
%  
% v3e =
%  
%  (-Z252*sin(q_torso))*dx + (-cos(q_torso)*(Z249 - L3*Z21 + L4*Z20))*dpsi + (sin(q_torso)*(L3 - Z253))*dq_imu + (L3*sin(q_torso))*dq_w
%                                                                                                Z250*dx + (L4 + Z251)*dq_imu + L4*dq_w
%   (-Z252*cos(q_torso))*dx + (sin(q_torso)*(Z249 - L3*Z21 + L4*Z20))*dpsi + (cos(q_torso)*(L3 - Z253))*dq_imu + (L3*cos(q_torso))*dq_w
 
Z254 = - sin(q_torso)*(Z248 + L3*Z17) - cos(q_torso)*(Z246 - L3*Z19 + L4*Z18);
Z255 =                                                          Z247 - L4*Z17;
Z256 =   sin(q_torso)*(Z246 - L3*Z19 + L4*Z18) - cos(q_torso)*(Z248 + L3*Z17);
Z257 = (-Z252*sin(q_torso));
Z258 = + (-cos(q_torso)*(Z249 - L3*Z21 + L4*Z20));
Z259 = + (sin(q_torso)*(L3 - Z253));
Z260 = + (L3*sin(q_torso));
Z261 = (L4 + Z251);
Z262 = (-Z252*cos(q_torso));
Z263 = + (sin(q_torso)*(Z249 - L3*Z21 + L4*Z20));
Z264 = + (cos(q_torso)*(L3 - Z253));
Z265 = + (L3*cos(q_torso));

v3i = [Z254; Z255; Z256];
v3e = [Z257*dx+Z258*dpsi+Z259*dq_imu+Z260*dq_w; 
    Z250*dx+Z261*dq_imu+L4*dq_w; 
    Z262*dx+Z263*dpsi+Z264*dq_imu+Z265*dq_w];
dv3 = [[Z257 Z250 Z262]' [Z258 Z61 Z63]' [Z259 0 Z264]' [Z260 L4 Z265]' ...
    zeros(3,15)];

% v4li = Rot(f, '3', '4l') * (v3i + cross(w3i, f('4l').P))
% v4le = collect(Rot(f, '3', '4l') * (v3e + cross(w3e, f('4l').P)),[dx,dpsi,dq_imu,dq_w,dq_1l])
% v4li =
%  
%    cos(q_1l)*(Z255 + L6*Z24) - sin(q_1l)*(Z256 + L5*Z22 - L6*Z23)
%                                                     Z254 - L5*Z24
%  - sin(q_1l)*(Z255 + L6*Z24) - cos(q_1l)*(Z256 + L5*Z22 - L6*Z23)
%  
%  
% v4le =
%  
%          (Z250*cos(q_1l) - Z262*sin(q_1l))*dx + (L6*Z28*cos(q_1l) - sin(q_1l)*(Z263 - L6*Z20 + L5*Z26))*dpsi + (cos(q_1l)*(Z261 + L6*Z27) - sin(q_1l)*(Z264 + L5*Z25))*dq_imu + (cos(q_1l)*(L4 + L6*Z27) - sin(q_1l)*(Z265 + L5*Z25))*dq_w - L6*dq_torso*sin(q_1l)
%                                                                                                                                                                                     Z257*dx + (Z258 - L5*Z28)*dpsi + (Z259 - L5*Z27)*dq_imu + (Z260 - L5*Z27)*dq_w
%  (- Z262*cos(q_1l) - Z250*sin(q_1l))*dx + (- cos(q_1l)*(Z263 - L6*Z20 + L5*Z26) - L6*Z28*sin(q_1l))*dpsi + (- sin(q_1l)*(Z261 + L6*Z27) - cos(q_1l)*(Z264 + L5*Z25))*dq_imu + (- cos(q_1l)*(Z265 + L5*Z25) - sin(q_1l)*(L4 + L6*Z27))*dq_w - L6*dq_torso*cos(q_1l)

Z266 =   cos(q_1l)*(Z255 + L6*Z24) - sin(q_1l)*(Z256 + L5*Z22 - L6*Z23);
Z267 =                                                    Z254 - L5*Z24;
Z268 = - sin(q_1l)*(Z255 + L6*Z24) - cos(q_1l)*(Z256 + L5*Z22 - L6*Z23);
Z269 =  (Z250*cos(q_1l) - Z262*sin(q_1l));
Z270 = + (L6*Z28*cos(q_1l) - sin(q_1l)*(Z263 - L6*Z20 + L5*Z26));
Z271 = + (cos(q_1l)*(Z261 + L6*Z27) - sin(q_1l)*(Z264 + L5*Z25));
Z272 = + (cos(q_1l)*(L4 + L6*Z27) - sin(q_1l)*(Z265 + L5*Z25));
Z273 = - L6*sin(q_1l);
Z274 = (Z258 - L5*Z28);
Z275 = + (Z259 - L5*Z27);
Z276 = + (Z260 - L5*Z27);
Z277 = (- Z262*cos(q_1l) - Z250*sin(q_1l));
Z278 = + (- cos(q_1l)*(Z263 - L6*Z20 + L5*Z26) - L6*Z28*sin(q_1l));
Z279 =  + (- sin(q_1l)*(Z261 + L6*Z27) - cos(q_1l)*(Z264 + L5*Z25));
Z280 =  + (- cos(q_1l)*(Z265 + L5*Z25) - sin(q_1l)*(L4 + L6*Z27));
Z281 =  - L6*cos(q_1l);

v4li = [Z266; Z267; Z268];
v4le = [Z269*dx+Z270*dpsi+Z271*dq_imu+Z272*dq_w+Z273*dq_torso; 
    Z257*dx+Z274*dpsi+Z275*dq_imu+Z276*dq_w; 
    Z277*dx+Z278*dpsi+Z279*dq_imu+Z280*dq_w+Z281*dq_torso];
dv4l = [[Z269 Z257 Z277]' [Z270 Z74 Z278]' [Z271 Z275 Z279]' ...
    [Z272 Z276 Z280]' [Z273 0 Z281]' zeros(3,14)];

% v5li = Rot(f, '4l', '5l') * (v4li + cross(w4li, f('5l').P))
% v5le = collect(Rot(f, '4l', '5l') * (v4le + cross(w4le, f('5l').P)),[dx,dpsi,dq_imu,dq_w,dq_1l])
% v5li =
%  
%                              -Z266
%  - Z267*cos(q_2l) - Z268*sin(q_2l)
%    Z268*cos(q_2l) - Z267*sin(q_2l)
%  
%  
% v5le =
%  
%                                                                                                                            (-Z269)*dx + (-Z270)*dpsi + (-Z271)*dq_imu + (-Z272)*dq_w - Z273*dq_torso
%  (- Z257*cos(q_2l) - Z277*sin(q_2l))*dx + (- Z274*cos(q_2l) - Z278*sin(q_2l))*dpsi + (- Z275*cos(q_2l) - Z279*sin(q_2l))*dq_imu + (- Z276*cos(q_2l) - Z280*sin(q_2l))*dq_w - Z281*dq_torso*sin(q_2l)
%          (Z277*cos(q_2l) - Z257*sin(q_2l))*dx + (Z278*cos(q_2l) - Z274*sin(q_2l))*dpsi + (Z279*cos(q_2l) - Z275*sin(q_2l))*dq_imu + (Z280*cos(q_2l) - Z276*sin(q_2l))*dq_w + Z281*dq_torso*cos(q_2l)

Z282 = - Z267*cos(q_2l) - Z268*sin(q_2l);
Z283 =   Z268*cos(q_2l) - Z267*sin(q_2l);
Z284 = (- Z257*cos(q_2l) - Z277*sin(q_2l));
Z285 = + (- Z274*cos(q_2l) - Z278*sin(q_2l));
Z286 = + (- Z275*cos(q_2l) - Z279*sin(q_2l));
Z287 = + (- Z276*cos(q_2l) - Z280*sin(q_2l));
Z288 = - Z281*sin(q_2l);
Z289 = (Z277*cos(q_2l) - Z257*sin(q_2l));
Z290 = + (Z278*cos(q_2l) - Z274*sin(q_2l));
Z291 = + (Z279*cos(q_2l) - Z275*sin(q_2l));
Z292 = + (Z280*cos(q_2l) - Z276*sin(q_2l));
Z293 = + Z281*cos(q_2l);

v5li = [-Z266; Z282; Z283];
v5le = [(-Z269)*dx + (-Z270)*dpsi + (-Z271)*dq_imu + (-Z272)*dq_w - Z273*dq_torso;
    Z284*dx+Z285*dpsi+Z286*dq_imu+Z287*dq_w+Z288*dq_torso; 
    Z289*dx+Z290*dpsi+Z291*dq_imu+Z292*dq_w+Z293*dq_torso];
dv5l = [[-Z269 Z284 Z289]' [-Z270 Z85 Z290]' [-Z271 Z286 Z291]' ...
    [-Z272 Z287 Z292]' [-Z273 Z288 Z293]' zeros(3,14)];

% v6li = Rot(f, '5l', '6l') * (v5li + cross(w5li, f('6l').P))
% v6le = collect(Rot(f, '5l', '6l') * (v5le + cross(w5le, f('6l').P)),[dx,dpsi,dq_imu,dq_w,dq_1l,dq_2l])
% v6li =
%  
%  sin(q_3l)*(Z283 - L7*Z38) + cos(q_3l)*(Z266 - L7*Z40)
%                                                  -Z282
%  cos(q_3l)*(Z283 - L7*Z38) - sin(q_3l)*(Z266 - L7*Z40)
%  
%  
% v6le =
%  
%  (Z269*cos(q_3l) + Z289*sin(q_3l))*dx + (sin(q_3l)*(Z290 + L7*Z32) + cos(q_3l)*(Z270 - L7*Z45))*dpsi + (sin(q_3l)*(Z291 + L7*Z33) + cos(q_3l)*(Z271 - L7*Z46))*dq_imu + (sin(q_3l)*(Z292 + L7*Z33) + cos(q_3l)*(Z272 - L7*Z46))*dq_w + (sin(q_3l)*(Z293 + L7*Z34) + cos(q_3l)*(Z273 - L7*Z47))*dq_torso + (-L7*Z48*cos(q_3l))*dq_1l + (L7*sin(q_3l))*dq_2l
%                                                                                                                                                                                                                                                                               (-Z284)*dx + (-Z285)*dpsi + (-Z286)*dq_imu + (-Z287)*dq_w + (-Z288)*dq_torso
%   (Z289*cos(q_3l) - Z269*sin(q_3l))*dx + (cos(q_3l)*(Z290 + L7*Z32) - sin(q_3l)*(Z270 - L7*Z45))*dpsi + (cos(q_3l)*(Z291 + L7*Z33) - sin(q_3l)*(Z271 - L7*Z46))*dq_imu + (cos(q_3l)*(Z292 + L7*Z33) - sin(q_3l)*(Z272 - L7*Z46))*dq_w + (cos(q_3l)*(Z293 + L7*Z34) - sin(q_3l)*(Z273 - L7*Z47))*dq_torso + (L7*Z48*sin(q_3l))*dq_1l + (L7*cos(q_3l))*dq_2l
 
Z294 = sin(q_3l)*(Z283 - L7*Z38) + cos(q_3l)*(Z266 - L7*Z40);
Z295 = cos(q_3l)*(Z283 - L7*Z38) - sin(q_3l)*(Z266 - L7*Z40);
Z296 = (Z269*cos(q_3l) + Z289*sin(q_3l));
Z297 = + (sin(q_3l)*(Z290 + L7*Z32) + cos(q_3l)*(Z270 - L7*Z45));
Z298 = + (sin(q_3l)*(Z291 + L7*Z33) + cos(q_3l)*(Z271 - L7*Z46));
Z299 = + (sin(q_3l)*(Z292 + L7*Z33) + cos(q_3l)*(Z272 - L7*Z46));
Z300 = + (sin(q_3l)*(Z293 + L7*Z34) + cos(q_3l)*(Z273 - L7*Z47));
Z301 = + (-L7*Z48*cos(q_3l));
Z302 = + (L7*sin(q_3l));
Z303 = (Z289*cos(q_3l) - Z269*sin(q_3l));
Z304 = + (cos(q_3l)*(Z290 + L7*Z32) - sin(q_3l)*(Z270 - L7*Z45));
Z305 = + (cos(q_3l)*(Z291 + L7*Z33) - sin(q_3l)*(Z271 - L7*Z46));
Z306 = + (cos(q_3l)*(Z292 + L7*Z33) - sin(q_3l)*(Z272 - L7*Z46));
Z307 = + (cos(q_3l)*(Z293 + L7*Z34) - sin(q_3l)*(Z273 - L7*Z47));
Z308 = + (L7*Z48*sin(q_3l));
Z309 = + (L7*cos(q_3l));

v6li = [Z294; -Z282; Z295];
v6le = [Z296*dx+Z297*dpsi+Z298*dq_imu+Z299*dq_w+Z300*dq_torso+Z301*dq_1l+Z302*dq_2l; 
    (-Z284)*dx + (-Z285)*dpsi + (-Z286)*dq_imu + (-Z287)*dq_w + (-Z288)*dq_torso;
    Z303*dx+Z304*dpsi+Z305*dq_imu+Z306*dq_w+Z307*dq_torso+Z308*dq_1l+Z309*dq_2l];
dv6l = [[Z296 -Z284 Z303]' [Z297 -Z85 Z304]' [Z298 -Z286 Z305]' ...
    [Z299 -Z287 Z306]' [Z300 -Z288 Z307]' [Z301 0 Z308]' [Z302 0 Z309]' ...
    zeros(3,12)];

% v7li = Rot(f, '6l', '7l') * (v6li + cross(w6li, f('7l').P))
% v7le = collect(Rot(f, '6l', '7l') * (v6le + cross(w6le, f('7l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l])
% v7li =
%  
%                            -Z294
%  Z282*cos(q_4l) - Z295*sin(q_4l)
%  Z295*cos(q_4l) + Z282*sin(q_4l)
%  
%  
% v7le =
%  
%                                                                                                                                                        (-Z296)*dx + (-Z297)*dpsi + (-Z298)*dq_imu + (-Z299)*dq_w + (-Z300)*dq_torso + (-Z301)*dq_1l + (-Z302)*dq_2l
%  (Z284*cos(q_4l) - Z303*sin(q_4l))*dx + (Z285*cos(q_4l) - Z304*sin(q_4l))*dpsi + (Z286*cos(q_4l) - Z305*sin(q_4l))*dq_imu + (Z287*cos(q_4l) - Z306*sin(q_4l))*dq_w + (Z288*cos(q_4l) - Z307*sin(q_4l))*dq_torso + (-Z308*sin(q_4l))*dq_1l + (-Z309*sin(q_4l))*dq_2l
%    (Z303*cos(q_4l) + Z284*sin(q_4l))*dx + (Z304*cos(q_4l) + Z285*sin(q_4l))*dpsi + (Z305*cos(q_4l) + Z286*sin(q_4l))*dq_imu + (Z306*cos(q_4l) + Z287*sin(q_4l))*dq_w + (Z307*cos(q_4l) + Z288*sin(q_4l))*dq_torso + (Z308*cos(q_4l))*dq_1l + (Z309*cos(q_4l))*dq_2l
%  
% v7li = Rot(f, '6l', '7l') * (v6li + cross(w6li, f('7l').P))
% v7le = collect(Rot(f, '6l', '7l') * (v6le + cross(w6le, f('7l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l])

Z310 = Z282*cos(q_4l) - Z295*sin(q_4l);
Z311 = Z295*cos(q_4l) + Z282*sin(q_4l);
Z312 = (Z284*cos(q_4l) - Z303*sin(q_4l));
Z313 = + (Z285*cos(q_4l) - Z304*sin(q_4l));
Z314 = + (Z286*cos(q_4l) - Z305*sin(q_4l));
Z315 = + (Z287*cos(q_4l) - Z306*sin(q_4l));
Z316 = + (Z288*cos(q_4l) - Z307*sin(q_4l));
Z317 = + (-Z308*sin(q_4l));
Z318 = + (-Z309*sin(q_4l));
Z319 = (Z303*cos(q_4l) + Z284*sin(q_4l));
Z320 = + (Z304*cos(q_4l) + Z285*sin(q_4l));
Z321 = + (Z305*cos(q_4l) + Z286*sin(q_4l));
Z322 = + (Z306*cos(q_4l) + Z287*sin(q_4l));
Z323 = + (Z307*cos(q_4l) + Z288*sin(q_4l));
Z324 = + (Z308*cos(q_4l)); 
Z325 = + (Z309*cos(q_4l));
 
v7li = [-Z294; Z310; Z311];
v7le = [(-Z296)*dx + (-Z297)*dpsi + (-Z298)*dq_imu + (-Z299)*dq_w + (-Z300)*dq_torso + (-Z301)*dq_1l + (-Z302)*dq_2l;
    Z312*dx+Z313*dpsi+Z314*dq_imu+Z315*dq_w+Z316*dq_torso+Z317*dq_1l+Z318*dq_2l; 
    Z319*dx+Z320*dpsi+Z321*dq_imu+Z322*dq_w+Z323*dq_torso+Z324*dq_1l+Z325*dq_2l];
dv7l = [[-Z296 Z312 Z319]' [-Z297 Z313 Z320]' [-Z298 Z314 Z321]' ...
    [-Z299 Z315 Z322]' [-Z300 Z316 Z323]' [-Z301 Z317 Z324]' ...
    [-Z302 Z318 Z325]' zeros(3,12)];

% v8li = Rot(f, '7l', '8l') * (v7li + cross(w7li, f('8l').P))
% v8le = collect(Rot(f, '7l', '8l') * (v7le + cross(w7le, f('8l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l])
% v8li =
%  
%  sin(q_5l)*(Z311 - L8*Z62) + cos(q_5l)*(Z294 - L8*Z64)
%                                                  -Z310
%  cos(q_5l)*(Z311 - L8*Z62) - sin(q_5l)*(Z294 - L8*Z64)
%  
%  
% v8le =
%  
%  (Z296*cos(q_5l) + Z319*sin(q_5l))*dx + (sin(q_5l)*(Z320 + L8*Z52) + cos(q_5l)*(Z297 - L8*Z71))*dpsi + (sin(q_5l)*(Z321 + L8*Z53) + cos(q_5l)*(Z298 - L8*Z72))*dq_imu + (sin(q_5l)*(Z322 + L8*Z53) + cos(q_5l)*(Z299 - L8*Z72))*dq_w + (sin(q_5l)*(Z323 + L8*Z54) + cos(q_5l)*(Z300 - L8*Z73))*dq_torso + (sin(q_5l)*(Z324 + L8*Z55) + cos(q_5l)*(Z301 - L8*Z74))*dq_1l + (sin(q_5l)*(Z325 + L8*Z56) + cos(q_5l)*(Z302 - L8*Z75))*dq_2l + (-L8*Z76*cos(q_5l))*dq_3l + (L8*sin(q_5l))*dq_4l
%                                                                                                                                                                                                                                                                                                                                                                               (-Z312)*dx + (-Z313)*dpsi + (-Z314)*dq_imu + (-Z315)*dq_w + (-Z316)*dq_torso + (-Z317)*dq_1l + (-Z318)*dq_2l
%   (Z319*cos(q_5l) - Z296*sin(q_5l))*dx + (cos(q_5l)*(Z320 + L8*Z52) - sin(q_5l)*(Z297 - L8*Z71))*dpsi + (cos(q_5l)*(Z321 + L8*Z53) - sin(q_5l)*(Z298 - L8*Z72))*dq_imu + (cos(q_5l)*(Z322 + L8*Z53) - sin(q_5l)*(Z299 - L8*Z72))*dq_w + (cos(q_5l)*(Z323 + L8*Z54) - sin(q_5l)*(Z300 - L8*Z73))*dq_torso + (cos(q_5l)*(Z324 + L8*Z55) - sin(q_5l)*(Z301 - L8*Z74))*dq_1l + (cos(q_5l)*(Z325 + L8*Z56) - sin(q_5l)*(Z302 - L8*Z75))*dq_2l + (L8*Z76*sin(q_5l))*dq_3l + (L8*cos(q_5l))*dq_4l

Z326 = sin(q_5l)*(Z311 - L8*Z62) + cos(q_5l)*(Z294 - L8*Z64);
Z327 = cos(q_5l)*(Z311 - L8*Z62) - sin(q_5l)*(Z294 - L8*Z64);
Z328 = (Z296*cos(q_5l) + Z319*sin(q_5l));
Z329 = + (sin(q_5l)*(Z320 + L8*Z52) + cos(q_5l)*(Z297 - L8*Z71));
Z330 = + (sin(q_5l)*(Z321 + L8*Z53) + cos(q_5l)*(Z298 - L8*Z72));
Z331 = + (sin(q_5l)*(Z322 + L8*Z53) + cos(q_5l)*(Z299 - L8*Z72));
Z332 = + (sin(q_5l)*(Z323 + L8*Z54) + cos(q_5l)*(Z300 - L8*Z73));
Z333 = + (sin(q_5l)*(Z324 + L8*Z55) + cos(q_5l)*(Z301 - L8*Z74));
Z334 = + (sin(q_5l)*(Z325 + L8*Z56) + cos(q_5l)*(Z302 - L8*Z75));
Z335 = + (-L8*Z76*cos(q_5l));
Z336 = + (L8*sin(q_5l));
Z337 = (Z319*cos(q_5l) - Z296*sin(q_5l));
Z338 = + (cos(q_5l)*(Z320 + L8*Z52) - sin(q_5l)*(Z297 - L8*Z71));
Z339 = + (cos(q_5l)*(Z321 + L8*Z53) - sin(q_5l)*(Z298 - L8*Z72));
Z340 = + (cos(q_5l)*(Z322 + L8*Z53) - sin(q_5l)*(Z299 - L8*Z72));
Z341 = + (cos(q_5l)*(Z323 + L8*Z54) - sin(q_5l)*(Z300 - L8*Z73));
Z342 = + (cos(q_5l)*(Z324 + L8*Z55) - sin(q_5l)*(Z301 - L8*Z74));
Z343 = + (cos(q_5l)*(Z325 + L8*Z56) - sin(q_5l)*(Z302 - L8*Z75));
Z344 = + (L8*Z76*sin(q_5l));
Z345 = + (L8*cos(q_5l));

v8li = [Z326; -Z310; Z327];
v8le = [Z328*dx+Z329*dpsi+Z330*dq_imu+Z331*dq_w+Z332*dq_torso+Z333*dq_1l+Z334*dq_2l+Z335*dq_3l+Z336*dq_4l; 
    (-Z312)*dx + (-Z313)*dpsi + (-Z314)*dq_imu + (-Z315)*dq_w + (-Z316)*dq_torso + (-Z317)*dq_1l + (-Z318)*dq_2l
    Z337*dx+Z338*dpsi+Z339*dq_imu+Z340*dq_w+Z341*dq_torso+Z342*dq_1l+Z343*dq_2l+Z344*dq_3l+Z345*dq_4l];
dv8l = [[Z328 -Z312 Z337]' [Z329 -Z313 Z338]' [Z330 -Z314 Z339]' ...
    [Z331 -Z315 Z340]' [Z332 -Z316 Z341]' [Z333 -Z317 Z342]' ...
    [Z334 -Z318 Z343]' [Z335 0 Z344]' [Z336 0 Z345]' zeros(3,10)];


% v9li = Rot(f, '8l', '9l') * (v8li + cross(w8li, f('9l').P))
% v9le = collect(Rot(f, '8l', '9l') * (v8le + cross(w8le, f('9l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l])
% v9li =
%  
%                            -Z326
%  Z310*cos(q_6l) - Z327*sin(q_6l)
%  Z327*cos(q_6l) + Z310*sin(q_6l)
%  
%  
% v9le =
%  
%                                                                                                                                                                                                            (-Z328)*dx + (-Z329)*dpsi + (-Z330)*dq_imu + (-Z331)*dq_w + (-Z332)*dq_torso + (-Z333)*dq_1l + (-Z334)*dq_2l + (-Z335)*dq_3l + (-Z336)*dq_4l
%  (Z312*cos(q_6l) - Z337*sin(q_6l))*dx + (Z313*cos(q_6l) - Z338*sin(q_6l))*dpsi + (Z314*cos(q_6l) - Z339*sin(q_6l))*dq_imu + (Z315*cos(q_6l) - Z340*sin(q_6l))*dq_w + (Z316*cos(q_6l) - Z341*sin(q_6l))*dq_torso + (Z317*cos(q_6l) - Z342*sin(q_6l))*dq_1l + (Z318*cos(q_6l) - Z343*sin(q_6l))*dq_2l + (-Z344*sin(q_6l))*dq_3l + (-Z345*sin(q_6l))*dq_4l
%    (Z337*cos(q_6l) + Z312*sin(q_6l))*dx + (Z338*cos(q_6l) + Z313*sin(q_6l))*dpsi + (Z339*cos(q_6l) + Z314*sin(q_6l))*dq_imu + (Z340*cos(q_6l) + Z315*sin(q_6l))*dq_w + (Z341*cos(q_6l) + Z316*sin(q_6l))*dq_torso + (Z342*cos(q_6l) + Z317*sin(q_6l))*dq_1l + (Z343*cos(q_6l) + Z318*sin(q_6l))*dq_2l + (Z344*cos(q_6l))*dq_3l + (Z345*cos(q_6l))*dq_4l

Z346 = Z310*cos(q_6l) - Z327*sin(q_6l);
Z347 = Z327*cos(q_6l) + Z310*sin(q_6l);
Z348 = (Z312*cos(q_6l) - Z337*sin(q_6l));
Z349 = + (Z313*cos(q_6l) - Z338*sin(q_6l));
Z350 = + (Z314*cos(q_6l) - Z339*sin(q_6l));
Z351 = + (Z315*cos(q_6l) - Z340*sin(q_6l));
Z352 = + (Z316*cos(q_6l) - Z341*sin(q_6l));
Z353 = + (Z317*cos(q_6l) - Z342*sin(q_6l));
Z354 = + (Z318*cos(q_6l) - Z343*sin(q_6l));
Z355 = + (-Z344*sin(q_6l));
Z356 = + (-Z345*sin(q_6l));
Z357 = (Z337*cos(q_6l) + Z312*sin(q_6l));
Z358 = + (Z338*cos(q_6l) + Z313*sin(q_6l));
Z359 = + (Z339*cos(q_6l) + Z314*sin(q_6l));
Z360 = + (Z340*cos(q_6l) + Z315*sin(q_6l));
Z361 = + (Z341*cos(q_6l) + Z316*sin(q_6l));
Z362 = + (Z342*cos(q_6l) + Z317*sin(q_6l));
Z363 = + (Z343*cos(q_6l) + Z318*sin(q_6l));
Z364 = + (Z344*cos(q_6l));
Z365 = + (Z345*cos(q_6l));

v9li = [-Z326; Z346; Z347];
v9le = [(-Z328)*dx + (-Z329)*dpsi + (-Z330)*dq_imu + (-Z331)*dq_w + (-Z332)*dq_torso + (-Z333)*dq_1l + (-Z334)*dq_2l + (-Z335)*dq_3l + (-Z336)*dq_4l;
    Z348*dx+Z349*dpsi+Z350*dq_imu+Z351*dq_w+Z352*dq_torso+Z353*dq_1l+Z354*dq_2l+Z355*dq_3l+Z356*dq_4l; 
    Z357*dx+Z358*dpsi+Z359*dq_imu+Z360*dq_w+Z361*dq_torso+Z362*dq_1l+Z363*dq_2l+Z364*dq_3l+Z365*dq_4l];
dv9l = [[-Z328 Z348 Z357]' [-Z329 Z349 Z358]' [-Z330 Z350 Z359]' ...
    [-Z331 Z351 Z360]' [-Z332 Z352 Z361]' [-Z333 Z353 Z362]' ...
    [-Z334 Z354 Z363]' [-Z335 Z355 Z364]' [-Z336 Z356 Z365]' zeros(3,10)];


% v10li = Rot(f, '9l', '10l') * (v9li + cross(w9li, f('10l').P))
% v10le = collect(Rot(f, '9l', '10l') * (v9le + cross(w9le, f('10l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l])
% v10li =
%  
%  sin(q_7l)*(Z347 - L9*Z94) + cos(q_7l)*(Z326 - L9*Z96)
%  sin(q_7l)*(Z326 - L9*Z96) - cos(q_7l)*(Z347 - L9*Z94)
%                                                  -Z346
%  
%  
% v10le =
%  
%   (Z328*cos(q_7l) + Z357*sin(q_7l))*dx + (sin(q_7l)*(Z338 + L9*Z80) + cos(q_7l)*(Z329 - L9*Z105))*dpsi + (sin(q_7l)*(Z359 + L9*Z81) + cos(q_7l)*(Z330 - L9*Z106))*dq_imu + (sin(q_7l)*(Z360 + L9*Z81) + cos(q_7l)*(Z331 - L9*Z106))*dq_w + (sin(q_7l)*(Z361 + L9*Z82) + cos(q_7l)*(Z332 - L9*Z107))*dq_torso + (sin(q_7l)*(Z362 + L9*Z83) + cos(q_7l)*(Z333 - L9*Z108))*dq_1l + (sin(q_7l)*(Z363 + L9*Z84) + cos(q_7l)*(Z334 - L9*Z109))*dq_2l + (sin(q_7l)*(Z364 + L9*Z85) + cos(q_7l)*(Z335 - L9*Z110))*dq_3l + (sin(q_7l)*(Z365 + L9*Z86) + cos(q_7l)*(Z336 - L9*Z111))*dq_4l + (-L9*Z112*cos(q_7l))*dq_5l + (L9*sin(q_7l))*dq_6l
%  (Z328*sin(q_7l) - Z357*cos(q_7l))*dx + (sin(q_7l)*(Z329 - L9*Z105) - cos(q_7l)*(Z338 + L9*Z80))*dpsi + (sin(q_7l)*(Z330 - L9*Z106) - cos(q_7l)*(Z359 + L9*Z81))*dq_imu + (sin(q_7l)*(Z331 - L9*Z106) - cos(q_7l)*(Z360 + L9*Z81))*dq_w + (sin(q_7l)*(Z332 - L9*Z107) - cos(q_7l)*(Z361 + L9*Z82))*dq_torso + (sin(q_7l)*(Z333 - L9*Z108) - cos(q_7l)*(Z362 + L9*Z83))*dq_1l + (sin(q_7l)*(Z334 - L9*Z109) - cos(q_7l)*(Z363 + L9*Z84))*dq_2l + (sin(q_7l)*(Z335 - L9*Z110) - cos(q_7l)*(Z364 + L9*Z85))*dq_3l + (sin(q_7l)*(Z336 - L9*Z111) - cos(q_7l)*(Z365 + L9*Z86))*dq_4l + (-L9*Z112*sin(q_7l))*dq_5l + (-L9*cos(q_7l))*dq_6l
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     (-Z348)*dx + (-Z329)*dpsi + (-Z350)*dq_imu + (-Z351)*dq_w + (-Z352)*dq_torso + (-Z353)*dq_1l + (-Z354)*dq_2l + (-Z355)*dq_3l + (-Z356)*dq_4l

Z366 = sin(q_7l)*(Z347 - L9*Z94) + cos(q_7l)*(Z326 - L9*Z96);
Z367 = sin(q_7l)*(Z326 - L9*Z96) - cos(q_7l)*(Z347 - L9*Z94);
Z368 = (Z328*cos(q_7l) + Z357*sin(q_7l));
Z369 = + (sin(q_7l)*(Z358 + L9*Z80) + cos(q_7l)*(Z329 - L9*Z105));
Z370 = + (sin(q_7l)*(Z359 + L9*Z81) + cos(q_7l)*(Z330 - L9*Z106));
Z371 = + (sin(q_7l)*(Z360 + L9*Z81) + cos(q_7l)*(Z331 - L9*Z106));
Z372 = + (sin(q_7l)*(Z361 + L9*Z82) + cos(q_7l)*(Z332 - L9*Z107));
Z373 = + (sin(q_7l)*(Z362 + L9*Z83) + cos(q_7l)*(Z333 - L9*Z108));
Z374 = + (sin(q_7l)*(Z363 + L9*Z84) + cos(q_7l)*(Z334 - L9*Z109));
Z375 = + (sin(q_7l)*(Z364 + L9*Z85) + cos(q_7l)*(Z335 - L9*Z110));
Z376 = + (sin(q_7l)*(Z365 + L9*Z86) + cos(q_7l)*(Z336 - L9*Z111));
Z377 = + (-L9*Z112*cos(q_7l));
Z378 = + (L9*sin(q_7l));
Z379 = (Z328*sin(q_7l) - Z357*cos(q_7l));
Z380 = + (sin(q_7l)*(Z329 - L9*Z105) - cos(q_7l)*(Z358 + L9*Z80));
Z381 = + (sin(q_7l)*(Z330 - L9*Z106) - cos(q_7l)*(Z359 + L9*Z81));
Z382 = + (sin(q_7l)*(Z331 - L9*Z106) - cos(q_7l)*(Z360 + L9*Z81));
Z383 = + (sin(q_7l)*(Z332 - L9*Z107) - cos(q_7l)*(Z361 + L9*Z82));
Z384 = + (sin(q_7l)*(Z333 - L9*Z108) - cos(q_7l)*(Z362 + L9*Z83));
Z385 = + (sin(q_7l)*(Z334 - L9*Z109) - cos(q_7l)*(Z363 + L9*Z84));
Z386 = + (sin(q_7l)*(Z335 - L9*Z110) - cos(q_7l)*(Z364 + L9*Z85));
Z387 = + (sin(q_7l)*(Z336 - L9*Z111) - cos(q_7l)*(Z365 + L9*Z86));
Z388 = + (-L9*Z112*sin(q_7l));
Z389 = + (-L9*cos(q_7l));

v10li = [Z366; Z367; -Z346];
v10le = [Z368*dx+Z369*dpsi+Z370*dq_imu+Z371*dq_w+Z372*dq_torso+Z373*dq_1l+Z374*dq_2l+Z375*dq_3l+Z376*dq_4l+Z377*dq_5l+Z378*dq_6l; 
    Z379*dx+Z380*dpsi+Z381*dq_imu+Z382*dq_w+Z383*dq_torso+Z384*dq_1l+Z385*dq_2l+Z386*dq_3l+Z387*dq_4l+Z388*dq_5l+Z389*dq_6l; 
    (-Z348)*dx + (-Z349)*dpsi + (-Z350)*dq_imu + (-Z351)*dq_w + (-Z352)*dq_torso + (-Z353)*dq_1l + (-Z354)*dq_2l + (-Z355)*dq_3l + (-Z356)*dq_4l];
dv10l = [[Z368 Z379 -Z348]' [Z369 Z380 -Z349]' [Z370 Z381 -Z350]' ...
    [Z371 Z382 -Z351]' [Z372 Z383 -Z352]' [Z373 Z384 -Z353]' ...
    [Z374 Z385 -Z354]' [Z375 Z386 -Z355]' [Z376 Z387 -Z356]' ...
    [Z377 Z388 0]' [Z378 Z389 0]' zeros(3,8)];

% v4ri = Rot(f, '3', '4r') * (v3i + cross(w3i, f('4r').P))
% v4re = collect(Rot(f, '3', '4r') * (v3e + cross(w3e, f('4r').P)),[dx,dpsi,dq_imu,dq_w,dq_1r])
% v4ri =
%  
%  sin(q_1r)*(Z256 + L5*Z22 + L6*Z23) + cos(q_1r)*(Z255 - L6*Z24)
%                                                   L5*Z24 - Z254
%  cos(q_1r)*(Z256 + L5*Z22 + L6*Z23) - sin(q_1r)*(Z255 - L6*Z24)
%  
%  
% v4re =
%  
%  (Z250*cos(q_1r) + Z262*sin(q_1r))*dx + (sin(q_1r)*(Z263 + L6*Z20 + L5*Z26) - L6*Z28*cos(q_1r))*dpsi + (sin(q_1r)*(Z264 + L5*Z25) + cos(q_1r)*(Z261 - L6*Z27))*dq_imu + (sin(q_1r)*(Z265 + L5*Z25) + cos(q_1r)*(L4 - L6*Z27))*dq_w - L6*dq_torso*sin(q_1r)
%                                                                                                                                                                          (-Z257)*dx + (L5*Z28 - Z258)*dpsi + (L5*Z27 - Z259)*dq_imu + (L5*Z27 - Z260)*dq_w
%  (Z262*cos(q_1r) - Z250*sin(q_1r))*dx + (cos(q_1r)*(Z263 + L6*Z20 + L5*Z26) + L6*Z28*sin(q_1r))*dpsi + (cos(q_1r)*(Z264 + L5*Z25) - sin(q_1r)*(Z261 - L6*Z27))*dq_imu + (cos(q_1r)*(Z265 + L5*Z25) - sin(q_1r)*(L4 - L6*Z27))*dq_w - L6*dq_torso*cos(q_1r)

Z390 = sin(q_1r)*(Z256 + L5*Z22 + L6*Z23) + cos(q_1r)*(Z255 - L6*Z24);
Z391 =                                                  L5*Z24 - Z254;
Z392 = cos(q_1r)*(Z256 + L5*Z22 + L6*Z23) - sin(q_1r)*(Z255 - L6*Z24);
Z393 = (Z250*cos(q_1r) + Z262*sin(q_1r));
Z394 = + (sin(q_1r)*(Z263 + L6*Z20 + L5*Z26) - L6*Z28*cos(q_1r));
Z395 = + (sin(q_1r)*(Z264 + L5*Z25) + cos(q_1r)*(Z261 - L6*Z27));
Z396 = + (sin(q_1r)*(Z265 + L5*Z25) + cos(q_1r)*(L4 - L6*Z27));
Z397 = - L6*sin(q_1r);
Z398 = + (L5*Z28 - Z258);
Z399 = + (L5*Z27 - Z259);
Z400 = + (L5*Z27 - Z260);
Z401 = (Z262*cos(q_1r) - Z250*sin(q_1r));
Z402 = + (cos(q_1r)*(Z263 + L6*Z20 + L5*Z26) + L6*Z28*sin(q_1r));
Z403 = + (cos(q_1r)*(Z264 + L5*Z25) - sin(q_1r)*(Z261 - L6*Z27));
Z404 = + (cos(q_1r)*(Z265 + L5*Z25) - sin(q_1r)*(L4 - L6*Z27));
Z405 = - L6*cos(q_1r);

v4ri = [Z390; Z391; Z392];
v4re = [Z393*dx+Z394*dpsi+Z395*dq_imu+Z396*dq_w+Z397*dq_torso; 
    -Z257*dx+Z398*dpsi+Z399*dq_imu+Z400*dq_w; 
    Z401*dx+Z402*dpsi+Z403*dq_imu+Z404*dq_w+Z405*dq_torso];
dv4r = [[Z393 -Z257 Z401]' [Z394 Z398 Z402]' [Z395 Z399 Z403]' ...
    [Z396 Z400 Z404]' [Z397 0 Z405]' zeros(3,14)];

% v5ri = Rot(f, '4r', '5r') * (v4ri + cross(w4ri, f('5r').P))
% v5re = correct(Rot(f, '4r', '5r') * (v4re + cross(w4re, f('5r').P)),[dx,dpsi,dq_imu,dq_w,dq_1r])
% v5ri =
%  
%                              -Z390
%  - Z391*cos(q_2r) - Z392*sin(q_2r)
%    Z392*cos(q_2r) - Z391*sin(q_2r)
%  
%  
% v5re =
%  
%                                                                                                                            (-Z393)*dx + (-Z394)*dpsi + (-Z395)*dq_imu + (-Z396)*dq_w - Z397*dq_torso
%  (Z257*cos(q_2r) - Z401*sin(q_2r))*dx + (- Z398*cos(q_2r) - Z402*sin(q_2r))*dpsi + (- Z399*cos(q_2r) - Z403*sin(q_2r))*dq_imu + (- Z400*cos(q_2r) - Z404*sin(q_2r))*dq_w - Z405*dq_torso*sin(q_2r)
%          (Z401*cos(q_2r) + Z257*sin(q_2r))*dx + (Z402*cos(q_2r) - Z398*sin(q_2r))*dpsi + (Z403*cos(q_2r) - Z399*sin(q_2r))*dq_imu + (Z404*cos(q_2r) - Z400*sin(q_2r))*dq_w + Z405*dq_torso*cos(q_2r)

Z406 = - Z391*cos(q_2r) - Z392*sin(q_2r);
Z407 =   Z392*cos(q_2r) - Z391*sin(q_2r);
Z408 = (Z257*cos(q_2r) - Z401*sin(q_2r));
Z409 = + (- Z398*cos(q_2r) - Z402*sin(q_2r));
Z410 = + (- Z399*cos(q_2r) - Z403*sin(q_2r));
Z411 = + (- Z400*cos(q_2r) - Z404*sin(q_2r));
Z412 = - Z405*sin(q_2r);
Z413 = (Z401*cos(q_2r) + Z257*sin(q_2r));
Z414 = + (Z402*cos(q_2r) - Z398*sin(q_2r));
Z415 = + (Z403*cos(q_2r) - Z399*sin(q_2r));
Z416 = + (Z404*cos(q_2r) - Z400*sin(q_2r));
Z417 = + Z405*cos(q_2r);

v5ri = [-Z390; Z406; Z407];
v5re = [(-Z393)*dx + (-Z394)*dpsi + (-Z395)*dq_imu + (-Z396)*dq_w - Z397*dq_torso;
    Z408*dx+Z409*dpsi+Z410*dq_imu+Z411*dq_w+Z412*dq_torso; 
    Z413*dx+Z414*dpsi+Z415*dq_imu+Z416*dq_w+Z417*dq_torso];
dv5r = [[-Z393 Z408 Z413]' [-Z394 Z190 Z414]' [-Z395 Z410 Z415]' ...
    [-Z396 Z411 Z416]' [-Z397 Z412 Z417]' zeros(3,14)];

% v6ri = Rot(f, '5r', '6r') * (v5ri + cross(w5ri, f('6r').P))
% v6re = correct(Rot(f, '5r', '6r') * (v5re + cross(w5re, f('6r').P)),[dx,dpsi,dq_imu,dq_w,dq_1r,dq_2r])
% v6ri =
%  
%  sin(q_3r)*(Z407 - L7*Z143) + cos(q_3r)*(Z390 - L7*Z145)
%                                                  -Z406
%  cos(q_3r)*(Z407 - L7*Z143) - sin(q_3r)*(Z390 - L7*Z145)
%  
%  
% v6re =
%  
%  (Z393*cos(q_3r) + Z413*sin(q_3r))*dx + (sin(q_3r)*(Z414 + L7*Z137) + cos(q_3r)*(Z394 - L7*Z150))*dpsi + (sin(q_3r)*(Z415 + L7*Z138) + cos(q_3r)*(Z395 - L7*Z151))*dq_imu + (sin(q_3r)*(Z416 + L7*Z138) + cos(q_3r)*(Z396 - L7*Z151))*dq_w + (sin(q_3r)*(Z417 + L7*Z139) + cos(q_3r)*(Z397 - L7*Z152))*dq_torso + (-L7*Z153*cos(q_3r))*dq_1r + (L7*sin(q_3r))*dq_2r
%                                                                                                                                                                                                                                                                               (-Z408)*dx + (-Z409)*dpsi + (-Z410)*dq_imu + (-Z411)*dq_w + (-Z412)*dq_torso
%   (Z413*cos(q_3r) - Z393*sin(q_3r))*dx + (cos(q_3r)*(Z414 + L7*Z137) - sin(q_3r)*(Z394 - L7*Z150))*dpsi + (cos(q_3r)*(Z415 + L7*Z138) - sin(q_3r)*(Z395 - L7*Z151))*dq_imu + (cos(q_3r)*(Z416 + L7*Z138) - sin(q_3r)*(Z396 - L7*Z151))*dq_w + (cos(q_3r)*(Z417 + L7*Z139) - sin(q_3r)*(Z397 - L7*Z152))*dq_torso + (L7*Z153*sin(q_3r))*dq_1r + (L7*cos(q_3r))*dq_2r
 
Z418 = sin(q_3r)*(Z407 - L7*Z143) + cos(q_3r)*(Z390 - L7*Z145);
Z419 = cos(q_3r)*(Z407 - L7*Z143) - sin(q_3r)*(Z390 - L7*Z145);
Z420 = (Z393*cos(q_3r) + Z413*sin(q_3r));
Z421 = + (sin(q_3r)*(Z414 + L7*Z137) + cos(q_3r)*(Z394 - L7*Z150));
Z422 = + (sin(q_3r)*(Z415 + L7*Z138) + cos(q_3r)*(Z395 - L7*Z151));
Z423 = + (sin(q_3r)*(Z416 + L7*Z138) + cos(q_3r)*(Z396 - L7*Z151));
Z424 = + (sin(q_3r)*(Z417 + L7*Z139) + cos(q_3r)*(Z397 - L7*Z152));
Z425 = + (-L7*Z153*cos(q_3r));
Z426 = + (L7*sin(q_3r));
Z427 = (Z413*cos(q_3r) - Z393*sin(q_3r));
Z428 = + (cos(q_3r)*(Z414 + L7*Z137) - sin(q_3r)*(Z394 - L7*Z150));
Z429 = + (cos(q_3r)*(Z415 + L7*Z138) - sin(q_3r)*(Z395 - L7*Z151));
Z430 = + (cos(q_3r)*(Z416 + L7*Z138) - sin(q_3r)*(Z396 - L7*Z151));
Z431 = + (cos(q_3r)*(Z417 + L7*Z139) - sin(q_3r)*(Z397 - L7*Z152));
Z432 = + (L7*Z153*sin(q_3r));
Z433 = + (L7*cos(q_3r));

v6ri = [Z418; -Z406; Z419];
v6re = [Z420*dx+Z421*dpsi+Z422*dq_imu+Z423*dq_w+Z424*dq_torso+Z425*dq_1r+Z426*dq_2r; 
    (-Z408)*dx + (-Z409)*dpsi + (-Z410)*dq_imu + (-Z411)*dq_w + (-Z412)*dq_torso;
    Z427*dx+Z428*dpsi+Z429*dq_imu+Z430*dq_w+Z431*dq_torso+Z432*dq_1r+Z433*dq_2r];
dv6r = [[Z420 -Z408 Z427]' [Z421 -Z190 Z428]' [Z422 -Z410 Z429]' ...
    [Z423 -Z411 Z430]' [Z424 -Z412 Z431]' zeros(3,7) [Z425 0 Z432]' ...
    [Z426 0 Z433]' zeros(3,5)];

% v7ri = Rot(f, '6r', '7r') * (v6ri + cross(w6ri, f('7r').P))
% v7re = correct(Rot(f, '6r', '7r') * (v6re + cross(w6re, f('7r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r])
% v7ri =
%  
%                            -Z418
%  Z406*cos(q_4r) - Z419*sin(q_4r)
%  Z419*cos(q_4r) + Z406*sin(q_4r)
%  
%  
% v7re =
%  
%                                                                                                                                                        (-Z420)*dx + (-Z421)*dpsi + (-Z422)*dq_imu + (-Z423)*dq_w + (-Z424)*dq_torso + (-Z425)*dq_1r + (-Z426)*dq_2r
%  (Z408*cos(q_4r) - Z427*sin(q_4r))*dx + (Z409*cos(q_4r) - Z428*sin(q_4r))*dpsi + (Z410*cos(q_4r) - Z429*sin(q_4r))*dq_imu + (Z411*cos(q_4r) - Z430*sin(q_4r))*dq_w + (Z412*cos(q_4r) - Z431*sin(q_4r))*dq_torso + (-Z432*sin(q_4r))*dq_1r + (-Z433*sin(q_4r))*dq_2r
%    (Z427*cos(q_4r) + Z408*sin(q_4r))*dx + (Z428*cos(q_4r) + Z409*sin(q_4r))*dpsi + (Z429*cos(q_4r) + Z410*sin(q_4r))*dq_imu + (Z430*cos(q_4r) + Z411*sin(q_4r))*dq_w + (Z431*cos(q_4r) + Z412*sin(q_4r))*dq_torso + (Z432*cos(q_4r))*dq_1r + (Z433*cos(q_4r))*dq_2r
%  
% v7ri = Rot(f, '6r', '7r') * (v6ri + cross(w6ri, f('7r').P))
% v7re = correct(Rot(f, '6r', '7r') * (v6re + cross(w6re, f('7r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r])

Z434 = Z406*cos(q_4r) - Z419*sin(q_4r);
Z435 = Z419*cos(q_4r) + Z406*sin(q_4r);
Z436 = (Z408*cos(q_4r) - Z427*sin(q_4r));
Z437 = + (Z409*cos(q_4r) - Z428*sin(q_4r));
Z438 = + (Z410*cos(q_4r) - Z429*sin(q_4r));
Z439 = + (Z411*cos(q_4r) - Z430*sin(q_4r));
Z440 = + (Z412*cos(q_4r) - Z431*sin(q_4r));
Z441 = + (-Z432*sin(q_4r));
Z442 = + (-Z433*sin(q_4r));
Z443 = (Z427*cos(q_4r) + Z408*sin(q_4r));
Z444 = + (Z428*cos(q_4r) + Z409*sin(q_4r));
Z445 = + (Z429*cos(q_4r) + Z410*sin(q_4r));
Z446 = + (Z430*cos(q_4r) + Z411*sin(q_4r));
Z447 = + (Z431*cos(q_4r) + Z412*sin(q_4r));
Z448 = + (Z432*cos(q_4r)); 
Z449 = + (Z433*cos(q_4r));
 
v7ri = [-Z418; Z434; Z435];
v7re = [(-Z420)*dx + (-Z421)*dpsi + (-Z422)*dq_imu + (-Z423)*dq_w + (-Z424)*dq_torso + (-Z425)*dq_1r + (-Z426)*dq_2r;
    Z436*dx+Z437*dpsi+Z438*dq_imu+Z439*dq_w+Z440*dq_torso+Z441*dq_1r+Z442*dq_2r; 
    Z443*dx+Z444*dpsi+Z445*dq_imu+Z446*dq_w+Z447*dq_torso+Z448*dq_1r+Z449*dq_2r];
dv7r = [[-Z420 Z436 Z443]' [-Z421 Z437 Z444]' [-Z422 Z438 Z445]' ...
    [-Z423 Z439 Z446]' [-Z424 Z440 Z447]' zeros(3,7) [-Z425 Z441 Z448]' ...
    [-Z426 Z442 Z449]' zeros(3,5)];

% v8ri = Rot(f, '7r', '8r') * (v7ri + cross(w7ri, f('8r').P))
% v8re = correct(Rot(f, '7r', '8r') * (v7re + cross(w7re, f('8r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r])
% v8ri =
%  
%  sin(q_5r)*(Z435 - L8*Z167) + cos(q_5r)*(Z418 - L8*Z169)
%                                                  -Z434
%  cos(q_5r)*(Z435 - L8*Z167) - sin(q_5r)*(Z418 - L8*Z169)
%  
%  
% v8re =
%  
%  (Z420*cos(q_5r) + Z443*sin(q_5r))*dx + (sin(q_5r)*(Z444 + L8*Z157) + cos(q_5r)*(Z421 - L8*Z176))*dpsi + (sin(q_5r)*(Z445 + L8*Z158) + cos(q_5r)*(Z422 - L8*Z177))*dq_imu + (sin(q_5r)*(Z446 + L8*Z158) + cos(q_5r)*(Z423 - L8*Z177))*dq_w + (sin(q_5r)*(Z447 + L8*Z159) + cos(q_5r)*(Z424 - L8*Z178))*dq_torso + (sin(q_5r)*(Z448 + L8*Z160) + cos(q_5r)*(Z425 - L8*Z179))*dq_1r + (sin(q_5r)*(Z449 + L8*Z161) + cos(q_5r)*(Z426 - L8*Z180))*dq_2r + (-L8*Z181*cos(q_5r))*dq_3r + (L8*sin(q_5r))*dq_4r
%                                                                                                                                                                                                                                                                                                                                                                               (-Z436)*dx + (-Z437)*dpsi + (-Z438)*dq_imu + (-Z439)*dq_w + (-Z440)*dq_torso + (-Z441)*dq_1r + (-Z442)*dq_2r
%   (Z443*cos(q_5r) - Z420*sin(q_5r))*dx + (cos(q_5r)*(Z444 + L8*Z157) - sin(q_5r)*(Z421 - L8*Z176))*dpsi + (cos(q_5r)*(Z445 + L8*Z158) - sin(q_5r)*(Z422 - L8*Z177))*dq_imu + (cos(q_5r)*(Z446 + L8*Z158) - sin(q_5r)*(Z423 - L8*Z177))*dq_w + (cos(q_5r)*(Z447 + L8*Z159) - sin(q_5r)*(Z424 - L8*Z178))*dq_torso + (cos(q_5r)*(Z448 + L8*Z160) - sin(q_5r)*(Z425 - L8*Z179))*dq_1r + (cos(q_5r)*(Z449 + L8*Z161) - sin(q_5r)*(Z426 - L8*Z180))*dq_2r + (L8*Z181*sin(q_5r))*dq_3r + (L8*cos(q_5r))*dq_4r

Z450 = sin(q_5r)*(Z435 - L8*Z167) + cos(q_5r)*(Z418 - L8*Z169);
Z451 = cos(q_5r)*(Z435 - L8*Z167) - sin(q_5r)*(Z418 - L8*Z169);
Z452 = (Z420*cos(q_5r) + Z443*sin(q_5r));
Z453 = + (sin(q_5r)*(Z444 + L8*Z157) + cos(q_5r)*(Z421 - L8*Z176));
Z454 = + (sin(q_5r)*(Z445 + L8*Z158) + cos(q_5r)*(Z422 - L8*Z177));
Z455 = + (sin(q_5r)*(Z446 + L8*Z158) + cos(q_5r)*(Z423 - L8*Z177));
Z456 = + (sin(q_5r)*(Z447 + L8*Z159) + cos(q_5r)*(Z424 - L8*Z178));
Z457 = + (sin(q_5r)*(Z448 + L8*Z160) + cos(q_5r)*(Z425 - L8*Z179));
Z458 = + (sin(q_5r)*(Z449 + L8*Z161) + cos(q_5r)*(Z426 - L8*Z180));
Z459 = + (-L8*Z181*cos(q_5r));
Z460 = + (L8*sin(q_5r));
Z461 = (Z443*cos(q_5r) - Z420*sin(q_5r));
Z462 = + (cos(q_5r)*(Z444 + L8*Z157) - sin(q_5r)*(Z421 - L8*Z176));
Z463 = + (cos(q_5r)*(Z445 + L8*Z158) - sin(q_5r)*(Z422 - L8*Z177));
Z464 = + (cos(q_5r)*(Z446 + L8*Z158) - sin(q_5r)*(Z423 - L8*Z177));
Z465 = + (cos(q_5r)*(Z447 + L8*Z159) - sin(q_5r)*(Z424 - L8*Z178));
Z466 = + (cos(q_5r)*(Z448 + L8*Z160) - sin(q_5r)*(Z425 - L8*Z179));
Z467 = + (cos(q_5r)*(Z449 + L8*Z161) - sin(q_5r)*(Z426 - L8*Z180));
Z468 = + (L8*Z181*sin(q_5r));
Z469 = + (L8*cos(q_5r));

v8ri = [Z450; -Z434; Z451];
v8re = [Z452*dx+Z453*dpsi+Z454*dq_imu+Z455*dq_w+Z456*dq_torso+Z457*dq_1r+Z458*dq_2r+Z459*dq_3r+Z460*dq_4r; 
    (-Z436)*dx + (-Z437)*dpsi + (-Z438)*dq_imu + (-Z439)*dq_w + (-Z440)*dq_torso + (-Z441)*dq_1r + (-Z442)*dq_2r
    Z461*dx+Z462*dpsi+Z463*dq_imu+Z464*dq_w+Z465*dq_torso+Z466*dq_1r+Z467*dq_2r+Z468*dq_3r+Z469*dq_4r];
dv8r = [[Z452 -Z436 Z461]' [Z453 -Z437 Z462]' [Z454 -Z438 Z463]' ...
    [Z455 -Z439 Z464]' [Z456 -Z440 Z465]' zeros(3,7) [Z457 -Z441 Z466]' ...
    [Z458 -Z442 Z467]' [Z459 0 Z468]' [Z460 0 Z469]' zeros(3,3)];


% v9ri = Rot(f, '8r', '9r') * (v8ri + cross(w8ri, f('9r').P))
% v9re = correct(Rot(f, '8r', '9r') * (v8re + cross(w8re, f('9r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r])
% v9ri =
%  
%                            -Z450
%  Z434*cos(q_6r) - Z451*sin(q_6r)
%  Z451*cos(q_6r) + Z434*sin(q_6r)
%  
%  
% v9re =
%  
%                                                                                                                                                                                                            (-Z452)*dx + (-Z453)*dpsi + (-Z454)*dq_imu + (-Z455)*dq_w + (-Z456)*dq_torso + (-Z457)*dq_1r + (-Z458)*dq_2r + (-Z459)*dq_3r + (-Z460)*dq_4r
%  (Z436*cos(q_6r) - Z461*sin(q_6r))*dx + (Z437*cos(q_6r) - Z462*sin(q_6r))*dpsi + (Z438*cos(q_6r) - Z463*sin(q_6r))*dq_imu + (Z439*cos(q_6r) - Z464*sin(q_6r))*dq_w + (Z440*cos(q_6r) - Z465*sin(q_6r))*dq_torso + (Z441*cos(q_6r) - Z466*sin(q_6r))*dq_1r + (Z442*cos(q_6r) - Z467*sin(q_6r))*dq_2r + (-Z468*sin(q_6r))*dq_3r + (-Z469*sin(q_6r))*dq_4r
%    (Z461*cos(q_6r) + Z436*sin(q_6r))*dx + (Z462*cos(q_6r) + Z437*sin(q_6r))*dpsi + (Z463*cos(q_6r) + Z438*sin(q_6r))*dq_imu + (Z464*cos(q_6r) + Z439*sin(q_6r))*dq_w + (Z465*cos(q_6r) + Z440*sin(q_6r))*dq_torso + (Z466*cos(q_6r) + Z441*sin(q_6r))*dq_1r + (Z467*cos(q_6r) + Z442*sin(q_6r))*dq_2r + (Z468*cos(q_6r))*dq_3r + (Z469*cos(q_6r))*dq_4r

Z470 = Z434*cos(q_6r) - Z451*sin(q_6r);
Z471 = Z451*cos(q_6r) + Z434*sin(q_6r);
Z472 = (Z436*cos(q_6r) - Z461*sin(q_6r));
Z473 = + (Z437*cos(q_6r) - Z462*sin(q_6r));
Z474 = + (Z438*cos(q_6r) - Z463*sin(q_6r));
Z475 = + (Z439*cos(q_6r) - Z464*sin(q_6r));
Z476 = + (Z440*cos(q_6r) - Z465*sin(q_6r));
Z477 = + (Z441*cos(q_6r) - Z466*sin(q_6r));
Z478 = + (Z442*cos(q_6r) - Z467*sin(q_6r));
Z479 = + (-Z468*sin(q_6r));
Z480 = + (-Z469*sin(q_6r));
Z481 = (Z461*cos(q_6r) + Z436*sin(q_6r));
Z482 = + (Z462*cos(q_6r) + Z437*sin(q_6r));
Z483 = + (Z463*cos(q_6r) + Z438*sin(q_6r));
Z484 = + (Z464*cos(q_6r) + Z439*sin(q_6r));
Z485 = + (Z465*cos(q_6r) + Z440*sin(q_6r));
Z486 = + (Z466*cos(q_6r) + Z441*sin(q_6r));
Z487 = + (Z467*cos(q_6r) + Z442*sin(q_6r));
Z488 = + (Z468*cos(q_6r));
Z489 = + (Z469*cos(q_6r));

v9ri = [-Z450; Z470; Z471];
v9re = [(-Z452)*dx + (-Z453)*dpsi + (-Z454)*dq_imu + (-Z455)*dq_w + (-Z456)*dq_torso + (-Z457)*dq_1r + (-Z458)*dq_2r + (-Z459)*dq_3r + (-Z460)*dq_4r;
    Z472*dx+Z473*dpsi+Z474*dq_imu+Z475*dq_w+Z476*dq_torso+Z477*dq_1r+Z478*dq_2r+Z479*dq_3r+Z480*dq_4r; 
    Z481*dx+Z482*dpsi+Z483*dq_imu+Z484*dq_w+Z485*dq_torso+Z486*dq_1r+Z487*dq_2r+Z488*dq_3r+Z489*dq_4r];
dv9r = [[-Z452 Z472 Z481]' [-Z453 Z473 Z482]' [-Z454 Z474 Z483]' ...
    [-Z455 Z475 Z484]' [-Z456 Z476 Z485]' zeros(3,7) [-Z457 Z477 Z486]' ...
    [-Z458 Z478 Z487]' [-Z459 Z479 Z488]' [-Z460 Z480 Z489]' zeros(3,3)];


% v10ri = Rot(f, '9r', '10r') * (v9ri + cross(w9ri, f('10r').P))
% v10re = correct(Rot(f, '9r', '10r') * (v9re + cross(w9re, f('10r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r])
% v10ri =
%  
%  sin(q_7r)*(Z471 - L9*Z199) + cos(q_7r)*(Z450 - L9*Z201)
%  sin(q_7r)*(Z450 - L9*Z201) - cos(q_7r)*(Z471 - L9*Z199)
%                                                  -Z470
%  
%  
% v10re =
%  
%   (Z452*cos(q_7r) + Z481*sin(q_7r))*dx + (sin(q_7r)*(Z462 + L9*Z185) + cos(q_7r)*(Z453 - L9*Z210))*dpsi + (sin(q_7r)*(Z483 + L9*Z186) + cos(q_7r)*(Z454 - L9*Z211))*dq_imu + (sin(q_7r)*(Z484 + L9*Z186) + cos(q_7r)*(Z455 - L9*Z211))*dq_w + (sin(q_7r)*(Z485 + L9*Z187) + cos(q_7r)*(Z456 - L9*Z212))*dq_torso + (sin(q_7r)*(Z486 + L9*Z188) + cos(q_7r)*(Z457 - L9*Z213))*dq_1r + (sin(q_7r)*(Z487 + L9*Z189) + cos(q_7r)*(Z458 - L9*Z214))*dq_2r + (sin(q_7r)*(Z488 + L9*Z190) + cos(q_7r)*(Z459 - L9*Z215))*dq_3r + (sin(q_7r)*(Z489 + L9*Z191) + cos(q_7r)*(Z460 - L9*Z216))*dq_4r + (-L9*Z217*cos(q_7r))*dq_5r + (L9*sin(q_7r))*dq_6r
%  (Z452*sin(q_7r) - Z481*cos(q_7r))*dx + (sin(q_7r)*(Z453 - L9*Z210) - cos(q_7r)*(Z462 + L9*Z185))*dpsi + (sin(q_7r)*(Z454 - L9*Z211) - cos(q_7r)*(Z483 + L9*Z186))*dq_imu + (sin(q_7r)*(Z455 - L9*Z211) - cos(q_7r)*(Z484 + L9*Z186))*dq_w + (sin(q_7r)*(Z456 - L9*Z212) - cos(q_7r)*(Z485 + L9*Z187))*dq_torso + (sin(q_7r)*(Z457 - L9*Z213) - cos(q_7r)*(Z486 + L9*Z188))*dq_1r + (sin(q_7r)*(Z458 - L9*Z214) - cos(q_7r)*(Z487 + L9*Z189))*dq_2r + (sin(q_7r)*(Z459 - L9*Z215) - cos(q_7r)*(Z488 + L9*Z190))*dq_3r + (sin(q_7r)*(Z460 - L9*Z216) - cos(q_7r)*(Z489 + L9*Z191))*dq_4r + (-L9*Z217*sin(q_7r))*dq_5r + (-L9*cos(q_7r))*dq_6r
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     (-Z472)*dx + (-Z453)*dpsi + (-Z474)*dq_imu + (-Z475)*dq_w + (-Z476)*dq_torso + (-Z477)*dq_1r + (-Z478)*dq_2r + (-Z479)*dq_3r + (-Z480)*dq_4r

Z490 = sin(q_7r)*(Z471 - L9*Z199) + cos(q_7r)*(Z450 - L9*Z201);
Z491 = sin(q_7r)*(Z450 - L9*Z201) - cos(q_7r)*(Z471 - L9*Z199);
Z492 = (Z452*cos(q_7r) + Z481*sin(q_7r));
Z493 = + (sin(q_7r)*(Z482 + L9*Z185) + cos(q_7r)*(Z453 - L9*Z210));
Z494 = + (sin(q_7r)*(Z483 + L9*Z186) + cos(q_7r)*(Z454 - L9*Z211));
Z495 = + (sin(q_7r)*(Z484 + L9*Z186) + cos(q_7r)*(Z455 - L9*Z211));
Z496 = + (sin(q_7r)*(Z485 + L9*Z187) + cos(q_7r)*(Z456 - L9*Z212));
Z497 = + (sin(q_7r)*(Z486 + L9*Z188) + cos(q_7r)*(Z457 - L9*Z213));
Z498 = + (sin(q_7r)*(Z487 + L9*Z189) + cos(q_7r)*(Z458 - L9*Z214));
Z499 = + (sin(q_7r)*(Z488 + L9*Z190) + cos(q_7r)*(Z459 - L9*Z215));
Z500 = + (sin(q_7r)*(Z489 + L9*Z191) + cos(q_7r)*(Z460 - L9*Z216));
Z501 = + (-L9*Z217*cos(q_7r));
Z502 = + (L9*sin(q_7r));
Z503 = (Z452*sin(q_7r) - Z481*cos(q_7r));
Z504 = + (sin(q_7r)*(Z453 - L9*Z210) - cos(q_7r)*(Z482 + L9*Z185));
Z505 = + (sin(q_7r)*(Z454 - L9*Z211) - cos(q_7r)*(Z483 + L9*Z186));
Z506 = + (sin(q_7r)*(Z455 - L9*Z211) - cos(q_7r)*(Z484 + L9*Z186));
Z507 = + (sin(q_7r)*(Z456 - L9*Z212) - cos(q_7r)*(Z485 + L9*Z187));
Z508 = + (sin(q_7r)*(Z457 - L9*Z213) - cos(q_7r)*(Z486 + L9*Z188));
Z509 = + (sin(q_7r)*(Z458 - L9*Z214) - cos(q_7r)*(Z487 + L9*Z189));
Z510 = + (sin(q_7r)*(Z459 - L9*Z215) - cos(q_7r)*(Z488 + L9*Z190));
Z511 = + (sin(q_7r)*(Z460 - L9*Z216) - cos(q_7r)*(Z489 + L9*Z191));
Z512 = + (-L9*Z217*sin(q_7r));
Z513 = + (-L9*cos(q_7r));

v10ri = [Z490; Z491; -Z470];
v10re = [Z492*dx+Z493*dpsi+Z494*dq_imu+Z495*dq_w+Z496*dq_torso+Z497*dq_1r+Z498*dq_2r+Z499*dq_3r+Z500*dq_4r+Z501*dq_5r+Z502*dq_6r; 
    Z503*dx+Z504*dpsi+Z505*dq_imu+Z506*dq_w+Z507*dq_torso+Z508*dq_1r+Z509*dq_2r+Z510*dq_3r+Z511*dq_4r+Z512*dq_5r+Z513*dq_6r; 
    (-Z472)*dx + (-Z473)*dpsi + (-Z474)*dq_imu + (-Z475)*dq_w + (-Z476)*dq_torso + (-Z477)*dq_1r + (-Z478)*dq_2r + (-Z479)*dq_3r + (-Z480)*dq_4r];
dv10r = [[Z492 Z503 -Z472]' [Z493 Z504 -Z473]' [Z494 Z505 -Z474]' ...
    [Z495 Z506 -Z475]' [Z496 Z507 -Z476]' zeros(3,7) [Z497 Z508 -Z477]' ...
    [Z498 Z509 -Z478]' [Z499 Z510 -Z479]' [Z500 Z511 -Z480]' ...
    [Z501 Z512 0]' [Z502 Z513 0]' zeros(3,1)];

%% Angular accelerations

% Wheels
% ddthetaL = Z1*ddx - Z2*ddpsi;
% alpha0L = ddpsi*k0L;
% alphaL = collect(alpha0L + ddthetaL*j0L + wLi(2)*cross(w0L,j0L),[ddx,ddpsi])
% alphaL =
%  
%  (-Z3)*ddpsi - Z4*Z6*dpsi
%      Z1*ddx + (-Z2)*ddpsi
%     Z4*ddpsi - Z3*Z6*dpsi
syms ddx ddpsi real
Z514 =  - Z4*Z6*dpsi;
Z515 =  - Z3*Z6*dpsi;

alphaL = [-Z3*ddpsi+Z514; Z1*ddx-Z2*ddpsi; Z4*ddpsi+Z515];

% ddthetaR = Z1*ddx + Z2*ddpsi;
% alpha0R = ddpsi*k0R;
% alphaR = collect(alpha0R + ddthetaR*j0R + wRi(2)*cross(w0R,j0R),[ddx,ddpsi])
% alphaR =
%  
%  (-Z8)*ddpsi - Z9*Z11*dpsi
%          Z1*ddx + Z2*ddpsi
%     Z9*ddpsi - Z8*Z11*dpsi
Z516 = - Z9*Z11*dpsi;
Z517 = - Z8*Z11*dpsi;

alphaR = [-Z8*ddpsi+Z516; Z1*ddx+Z2*ddpsi; Z4*ddpsi+Z517];

% Tree
% *************************************************************************
% *      alpha_a = Rot(f, f(key).a, key) * angAcc(f, f(key).a);           *
% *      alpha = alpha_a + f(key).e * f(key).ddq ...                      *
% *             + f(key).dq * cross(angVel(f, key), f(key).e);            *
% *************************************************************************

% alpha0 = [0; 0; ddpsi]; 
% this = '1'; w = w1i; prev = '0'; alphaLast = alpha0;
% alpha1 = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu])
% alpha1 =
%  
%                       -ddq_imu
%  cos(q_imu)*ddpsi - Z16*dq_imu
%  sin(q_imu)*ddpsi + Z15*dq_imu
syms ddq_imu real
Z518 = - Z16*dq_imu;
Z519 = + Z15*dq_imu;
alpha1 = [-ddq_imu; Z13*ddpsi+Z518; Z14*ddpsi+Z519];

% this = '2'; w = w2i; prev = '1'; alphaLast = alpha1;
% alpha2 = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu])
% alpha2 =
%  
%                                                               - ddq_imu - ddq_w
%  (Z13*cos(q_w) - Z14*sin(q_w))*ddpsi + Z518*cos(q_w) - Z19*dq_w - Z519*sin(q_w)
%  (Z14*cos(q_w) + Z13*sin(q_w))*ddpsi + Z18*dq_w + Z519*cos(q_w) + Z518*sin(q_w)
syms ddq_w real
Z520 = + Z518*cos(q_w) - Z19*dq_w - Z519*sin(q_w);
Z521 = + Z18*dq_w + Z519*cos(q_w) + Z518*sin(q_w);
alpha2 = [-ddq_imu-ddq_w; Z20*ddpsi+Z520; Z21*ddpsi+Z521];

% this = '3'; w = w3i; prev = '2'; alphaLast = alpha2;
% alpha3 = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso])
% alpha3 =
%  
%        (-Z21*sin(q_torso))*ddpsi + cos(q_torso)*ddq_imu + cos(q_torso)*ddq_w + Z24*dq_torso - Z521*sin(q_torso)
%                                                                                    Z20*ddpsi - ddq_torso + Z520
%  (-Z21*cos(q_torso))*ddpsi + (-sin(q_torso))*ddq_imu + (-sin(q_torso))*ddq_w - Z22*dq_torso - Z521*cos(q_torso)
syms ddq_torso real
Z522 = + Z24*dq_torso - Z521*sin(q_torso);
Z523 = - Z22*dq_torso - Z521*cos(q_torso);
alpha3 = [Z26*ddpsi+Z25*ddq_imu+Z25*ddq_w+Z522;
    Z20*ddpsi-ddq_torso+Z520;
    Z28*ddpsi+Z27*ddq_imu+Z27*ddq_w+Z523];

% this = '4l'; w = w4li; prev = '3'; alphaLast = alpha3;
% alpha4l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_4l])
% alpha4l =
%  
%  (Z20*cos(q_1l) - Z28*sin(q_1l))*ddpsi + (-Z27*sin(q_1l))*ddq_imu + (-Z27*sin(q_1l))*ddq_w + (-cos(q_1l))*ddq_torso + Z31*dq_1l + Z520*cos(q_1l) - Z523*sin(q_1l)
%                                                                                                               Z26*ddpsi + Z25*ddq_imu + Z25*ddq_w + Z522 - ddq_1l
%   (- Z28*cos(q_1l) - Z20*sin(q_1l))*ddpsi + (-Z27*cos(q_1l))*ddq_imu + (-Z27*cos(q_1l))*ddq_w + sin(q_1l)*ddq_torso - Z29*dq_1l - Z523*cos(q_1l) - Z520*sin(q_1l)
syms ddq_1l real
Z524 = + Z31*dq_1l + Z520*cos(q_1l) - Z523*sin(q_1l);
Z525 = - Z29*dq_1l - Z523*cos(q_1l) - Z520*sin(q_1l);
alpha4l = [Z32*ddpsi+Z33*ddq_imu+Z33*ddq_w+Z34*ddq_torso+Z524;
    Z26*ddpsi + Z25*ddq_imu + Z25*ddq_w + Z522 - ddq_1l;
    Z35*ddpsi+Z36*ddq_imu+Z36*ddq_w+Z37*ddq_torso+Z525];

% this = '5l'; w = w5li; prev = '4l'; alphaLast = alpha4l;
% alpha5l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l])
% alpha5l =
%  
%                                                                                                                                              (-Z32)*ddpsi + (-Z33)*ddq_imu + (-Z33)*ddq_w + (-Z34)*ddq_torso - ddq_2l - Z524
%  (- Z26*cos(q_2l) - Z35*sin(q_2l))*ddpsi + (- Z25*cos(q_2l) - Z36*sin(q_2l))*ddq_imu + (- Z25*cos(q_2l) - Z36*sin(q_2l))*ddq_w + (-Z37*sin(q_2l))*ddq_torso + cos(q_2l)*ddq_1l - Z40*dq_2l - Z522*cos(q_2l) - Z525*sin(q_2l)
%         (Z35*cos(q_2l) - Z26*sin(q_2l))*ddpsi + (Z36*cos(q_2l) - Z25*sin(q_2l))*ddq_imu + (Z36*cos(q_2l) - Z25*sin(q_2l))*ddq_w + (Z37*cos(q_2l))*ddq_torso + sin(q_2l)*ddq_1l + Z39*dq_2l + Z525*cos(q_2l) - Z522*sin(q_2l)
syms ddq_2l real
Z526 = - Z40*dq_2l - Z522*cos(q_2l) - Z525*sin(q_2l);
Z527 = + Z39*dq_2l + Z525*cos(q_2l) - Z522*sin(q_2l);
alpha5l =[(-Z32)*ddpsi + (-Z33)*ddq_imu + (-Z33)*ddq_w + (-Z34)*ddq_torso - ddq_2l - Z524;
    Z41*ddpsi+Z42*ddq_imu+Z42*ddq_w+Z43*ddq_torso+Z44*ddq_1l+Z526;
    Z45*ddpsi+Z46*ddq_imu+Z46*ddq_w+Z47*ddq_torso+Z48*ddq_1l+Z527];

% this = '6l'; w = w6li; prev = '5l'; alphaLast = alpha5l;
% alpha6l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l])
% alpha6l =
%  
%     (Z32*cos(q_3l) + Z45*sin(q_3l))*ddpsi + (Z33*cos(q_3l) + Z46*sin(q_3l))*ddq_imu + (Z33*cos(q_3l) + Z46*sin(q_3l))*ddq_w + (Z34*cos(q_3l) + Z47*sin(q_3l))*ddq_torso + (Z48*sin(q_3l))*ddq_1l + cos(q_3l)*ddq_2l + Z51*dq_3l + Z524*cos(q_3l) + Z527*sin(q_3l)
%                                                                                                                                                                   (-Z41)*ddpsi + (-Z42)*ddq_imu + (-Z42)*ddq_w + (-Z43)*ddq_torso + (-Z44)*ddq_1l - ddq_3l - Z526
%  (Z45*cos(q_3l) - Z32*sin(q_3l))*ddpsi + (Z46*cos(q_3l) - Z33*sin(q_3l))*ddq_imu + (Z46*cos(q_3l) - Z33*sin(q_3l))*ddq_w + (Z47*cos(q_3l) - Z34*sin(q_3l))*ddq_torso + (Z48*cos(q_3l))*ddq_1l + (-sin(q_3l))*ddq_2l + Z527*cos(q_3l) - Z49*dq_3l - Z524*sin(q_3l)
syms ddq_3l real
Z528 = + Z51*dq_3l + Z524*cos(q_3l) + Z527*sin(q_3l);
Z529 = + Z527*cos(q_3l) - Z49*dq_3l - Z524*sin(q_3l);
alpha6l = [Z52*ddpsi+Z53*ddq_imu+Z53*ddq_w+Z54*ddq_torso+Z55*ddq_1l+Z56*ddq_2l+Z528;
    (-Z41)*ddpsi + (-Z42)*ddq_imu + (-Z42)*ddq_w + (-Z43)*ddq_torso + (-Z44)*ddq_1l - ddq_3l - Z526;
    Z57*ddpsi+Z58*ddq_imu+Z58*ddq_w+Z59*ddq_torso+Z60*ddq_1l+Z61*ddq_2l+Z529]; 

% this = '7l'; w = w7li; prev = '6l'; alphaLast = alpha6l;
% alpha7l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l])
% alpha7l =
%  (-Z52)*ddpsi + (-Z53)*ddq_imu + (-Z53)*ddq_w + (-Z54)*ddq_torso + (-Z55)*ddq_1l + (-Z56)*ddq_2l - ddq_4l - Z528
%  (Z41*cos(q_4l) - Z57*sin(q_4l))*ddpsi + (Z42*cos(q_4l) - Z58*sin(q_4l))*ddq_imu + (Z42*cos(q_4l) - Z58*sin(q_4l))*ddq_w + (Z43*cos(q_4l) - Z59*sin(q_4l))*ddq_torso + (Z44*cos(q_4l) - Z60*sin(q_4l))*ddq_1l + (-Z61*sin(q_4l))*ddq_2l + cos(q_4l)*ddq_3l + Z526*cos(q_4l) - Z64*dq_4l - Z529*sin(q_4l)
%   (Z57*cos(q_4l) + Z41*sin(q_4l))*ddpsi + (Z58*cos(q_4l) + Z42*sin(q_4l))*ddq_imu + (Z58*cos(q_4l) + Z42*sin(q_4l))*ddq_w + (Z59*cos(q_4l) + Z43*sin(q_4l))*ddq_torso + (Z60*cos(q_4l) + Z44*sin(q_4l))*ddq_1l + (Z61*cos(q_4l))*ddq_2l + sin(q_4l)*ddq_3l + Z63*dq_4l + Z529*cos(q_4l) + Z526*sin(q_4l)
syms ddq_4l real
Z530 =  Z526*cos(q_4l) - Z64*dq_4l - Z529*sin(q_4l);
Z531 =  + Z63*dq_4l + Z529*cos(q_4l) + Z526*sin(q_4l);
alpha7l = [ (-Z52)*ddpsi + (-Z53)*ddq_imu + (-Z53)*ddq_w + (-Z54)*ddq_torso + (-Z55)*ddq_1l + (-Z56)*ddq_2l - ddq_4l - Z528;
    Z65*ddpsi+Z66*ddq_imu+Z66*ddq_w+Z67*ddq_torso+Z68*ddq_1l+Z69*ddq_2l+Z70*ddq_3l+Z530;
    Z71*ddpsi+Z72*ddq_imu+Z72*ddq_w+Z73*ddq_torso+Z74*ddq_1l+Z75*ddq_2l+Z76*ddq_3l+Z531];

% this = '8l'; w = w8li; prev = '7l'; alphaLast = alpha7l;
% alpha8l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l])
% alpha8l =
%  
%     (Z52*cos(q_5l) + Z71*sin(q_5l))*ddpsi + (Z53*cos(q_5l) + Z72*sin(q_5l))*ddq_imu + (Z53*cos(q_5l) + Z72*sin(q_5l))*ddq_w + (Z54*cos(q_5l) + Z73*sin(q_5l))*ddq_torso + (Z55*cos(q_5l) + Z74*sin(q_5l))*ddq_1l + (Z56*cos(q_5l) + Z75*sin(q_5l))*ddq_2l + (Z76*sin(q_5l))*ddq_3l + cos(q_5l)*ddq_4l + Z79*dq_5l + Z528*cos(q_5l) + Z531*sin(q_5l)
%                                                                                                                                                                                                                     (-Z65)*ddpsi + (-Z66)*ddq_imu + (-Z66)*ddq_w + (-Z67)*ddq_torso + (-Z68)*ddq_1l + (-Z69)*ddq_2l + (-Z70)*ddq_3l - ddq_5l - Z530
%  (Z71*cos(q_5l) - Z52*sin(q_5l))*ddpsi + (Z72*cos(q_5l) - Z53*sin(q_5l))*ddq_imu + (Z72*cos(q_5l) - Z53*sin(q_5l))*ddq_w + (Z73*cos(q_5l) - Z54*sin(q_5l))*ddq_torso + (Z74*cos(q_5l) - Z55*sin(q_5l))*ddq_1l + (Z75*cos(q_5l) - Z56*sin(q_5l))*ddq_2l + (Z76*cos(q_5l))*ddq_3l + (-sin(q_5l))*ddq_4l + Z531*cos(q_5l) - Z77*dq_5l - Z528*sin(q_5l)
syms ddq_5l real
Z532 = + Z79*dq_5l + Z528*cos(q_5l) + Z531*sin(q_5l);
Z533 = + Z531*cos(q_5l) - Z77*dq_5l - Z528*sin(q_5l);
alpha8l = [Z80*ddpsi+Z81*ddq_imu+Z81*ddq_w+Z82*ddq_torso+Z83*ddq_1l+Z84*ddq_2l+Z85*ddq_3l+Z86*ddq_4l+Z532;
    (-Z65)*ddpsi + (-Z66)*ddq_imu + (-Z66)*ddq_w + (-Z67)*ddq_torso + (-Z68)*ddq_1l + (-Z69)*ddq_2l + (-Z70)*ddq_3l - ddq_5l - Z530;
    Z87*ddpsi+Z88*ddq_imu+Z88*ddq_w+Z89*ddq_torso+Z90*ddq_1l+Z91*ddq_2l+Z92*ddq_3l+Z93*ddq_4l+Z533];

% this = '9l'; w = w9li; prev = '8l'; alphaLast = alpha8l;
% alpha9l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l])
% alpha9l =
%  
%                                                                                                                                                                                                                                            (-Z80)*ddpsi + (-Z81)*ddq_imu + (-Z81)*ddq_w + (-Z82)*ddq_torso + (-Z83)*ddq_1l + (-Z84)*ddq_2l + (-Z85)*ddq_3l + (-Z86)*ddq_4l - ddq_6l - Z532
%  (Z65*cos(q_6l) - Z87*sin(q_6l))*ddpsi + (Z66*cos(q_6l) - Z88*sin(q_6l))*ddq_imu + (Z66*cos(q_6l) - Z88*sin(q_6l))*ddq_w + (Z67*cos(q_6l) - Z89*sin(q_6l))*ddq_torso + (Z68*cos(q_6l) - Z90*sin(q_6l))*ddq_1l + (Z69*cos(q_6l) - Z91*sin(q_6l))*ddq_2l + (Z70*cos(q_6l) - Z92*sin(q_6l))*ddq_3l + (-Z93*sin(q_6l))*ddq_4l + cos(q_6l)*ddq_5l + Z530*cos(q_6l) - Z96*dq_6l - Z533*sin(q_6l)
%   (Z87*cos(q_6l) + Z65*sin(q_6l))*ddpsi + (Z88*cos(q_6l) + Z66*sin(q_6l))*ddq_imu + (Z88*cos(q_6l) + Z66*sin(q_6l))*ddq_w + (Z89*cos(q_6l) + Z67*sin(q_6l))*ddq_torso + (Z90*cos(q_6l) + Z68*sin(q_6l))*ddq_1l + (Z91*cos(q_6l) + Z69*sin(q_6l))*ddq_2l + (Z92*cos(q_6l) + Z70*sin(q_6l))*ddq_3l + (Z93*cos(q_6l))*ddq_4l + sin(q_6l)*ddq_5l + Z95*dq_6l + Z533*cos(q_6l) + Z530*sin(q_6l)
syms ddq_6l real
Z534 = + Z530*cos(q_6l) - Z96*dq_6l - Z533*sin(q_6l);
Z535 = + Z95*dq_6l + Z533*cos(q_6l) + Z530*sin(q_6l);
alpha9l = [(-Z80)*ddpsi + (-Z81)*ddq_imu + (-Z81)*ddq_w + (-Z82)*ddq_torso + (-Z83)*ddq_1l + (-Z84)*ddq_2l + (-Z85)*ddq_3l + (-Z86)*ddq_4l - ddq_6l - Z532;
    Z97*ddpsi+Z98*ddq_imu+Z98*ddq_w+Z99*ddq_torso+Z100*ddq_1l+Z101*ddq_2l+Z102*ddq_3l+Z103*ddq_4l+Z104*ddq_5l+Z534;
    Z105*ddpsi+Z106*ddq_imu+Z106*ddq_w+Z107*ddq_torso+Z108*ddq_1l+Z109*ddq_2l+Z110*ddq_3l+Z111*ddq_4l+Z112*ddq_5l+Z535];

% this = '10l'; w = w10li; prev = '9l'; alphaLast = alpha9l;
% alpha10l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l,ddq_7l])
% alpha10l =
%  
%   (Z80*cos(q_7l) + Z105*sin(q_7l))*ddpsi + (Z81*cos(q_7l) + Z106*sin(q_7l))*ddq_imu + (Z81*cos(q_7l) + Z106*sin(q_7l))*ddq_w + (Z82*cos(q_7l) + Z107*sin(q_7l))*ddq_torso + (Z83*cos(q_7l) + Z108*sin(q_7l))*ddq_1l + (Z84*cos(q_7l) + Z109*sin(q_7l))*ddq_2l + (Z85*cos(q_7l) + Z110*sin(q_7l))*ddq_3l + (Z86*cos(q_7l) + Z111*sin(q_7l))*ddq_4l + (Z112*sin(q_7l))*ddq_5l + cos(q_7l)*ddq_6l + Z532*cos(q_7l) - Z114*dq_7l + Z535*sin(q_7l)
%  (Z80*sin(q_7l) - Z105*cos(q_7l))*ddpsi + (Z81*sin(q_7l) - Z106*cos(q_7l))*ddq_imu + (Z81*sin(q_7l) - Z106*cos(q_7l))*ddq_w + (Z82*sin(q_7l) - Z107*cos(q_7l))*ddq_torso + (Z83*sin(q_7l) - Z108*cos(q_7l))*ddq_1l + (Z84*sin(q_7l) - Z109*cos(q_7l))*ddq_2l + (Z85*sin(q_7l) - Z110*cos(q_7l))*ddq_3l + (Z86*sin(q_7l) - Z111*cos(q_7l))*ddq_4l + (-Z112*cos(q_7l))*ddq_5l + sin(q_7l)*ddq_6l + Z113*dq_7l - Z535*cos(q_7l) + Z532*sin(q_7l)
%                                                                                                                                                                                                                                                                          (-Z97)*ddpsi + (-Z98)*ddq_imu + (-Z98)*ddq_w + (-Z99)*ddq_torso + (-Z100)*ddq_1l + (-Z101)*ddq_2l + (-Z102)*ddq_3l + (-Z103)*ddq_4l + (-Z104)*ddq_5l - ddq_7l - Z534
syms ddq_7l real
Z536 = + Z532*cos(q_7l) - Z114*dq_7l + Z535*sin(q_7l);
Z537 = + Z113*dq_7l - Z535*cos(q_7l) + Z532*sin(q_7l);
alpha10l = [Z116*ddpsi+Z117*ddq_imu+Z117*ddq_w+Z118*ddq_torso+Z119*ddq_1l+Z120*ddq_2l+Z121*ddq_3l+Z122*ddq_4l+Z123*ddq_5l+Z124*ddq_6l+Z536;
    Z125*ddpsi+Z126*ddq_imu+Z126*ddq_w+Z127*ddq_torso+Z128*ddq_1l+Z129*ddq_2l+Z130*ddq_3l+Z131*ddq_4l+Z132*ddq_5l+Z133*ddq_6l+Z537;
    (-Z97)*ddpsi + (-Z98)*ddq_imu + (-Z98)*ddq_w + (-Z99)*ddq_torso + (-Z100)*ddq_1l + (-Z101)*ddq_2l + (-Z102)*ddq_3l + (-Z103)*ddq_4l + (-Z104)*ddq_5l - ddq_7l - Z534];

% this = '4r'; w = w4ri; prev = '3'; alphaLast = alpha3;
% alpha4r = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r])
% alpha4r =
%  
%  (Z20*cos(q_1r) + Z28*sin(q_1r))*ddpsi + (Z27*sin(q_1r))*ddq_imu + (Z27*sin(q_1r))*ddq_w + (-cos(q_1r))*ddq_torso + Z136*dq_1r + Z520*cos(q_1r) + Z523*sin(q_1r)
%                                                                                                     (-Z26)*ddpsi + (-Z25)*ddq_imu + (-Z25)*ddq_w - ddq_1r - Z522
%     (Z28*cos(q_1r) - Z20*sin(q_1r))*ddpsi + (Z27*cos(q_1r))*ddq_imu + (Z27*cos(q_1r))*ddq_w + sin(q_1r)*ddq_torso + Z523*cos(q_1r) - Z134*dq_1r - Z520*sin(q_1r)
syms ddq_1r real
Z538 =   + Z136*dq_1r + Z520*cos(q_1r) + Z523*sin(q_1r);
Z539 =   + Z523*cos(q_1r) - Z134*dq_1r - Z520*sin(q_1r);
alpha4r = [Z137*ddpsi+Z138*ddq_imu+Z138*ddq_w+Z139*ddq_torso+Z538;  
        (-Z26)*ddpsi + (-Z25)*ddq_imu + (-Z25)*ddq_w - ddq_1r-Z522;
        Z140*ddpsi+Z141*ddq_imu+Z141*ddq_w+Z142*ddq_torso+Z539];

% this = '5r'; w = w5ri; prev = '4r'; alphaLast = alpha4r;
% alpha5r = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r])
% alpha5r =
%  
%                                                                                                                                         (-Z137)*ddpsi + (-Z138)*ddq_imu + (-Z138)*ddq_w + (-Z139)*ddq_torso - ddq_2r - Z538
%  (Z26*cos(q_2r) - Z140*sin(q_2r))*ddpsi + (Z25*cos(q_2r) - Z141*sin(q_2r))*ddq_imu + (Z25*cos(q_2r) - Z141*sin(q_2r))*ddq_w + (-Z142*sin(q_2r))*ddq_torso + cos(q_2r)*ddq_1r + Z522*cos(q_2r) - Z145*dq_2r - Z539*sin(q_2r)
%   (Z140*cos(q_2r) + Z26*sin(q_2r))*ddpsi + (Z141*cos(q_2r) + Z25*sin(q_2r))*ddq_imu + (Z141*cos(q_2r) + Z25*sin(q_2r))*ddq_w + (Z142*cos(q_2r))*ddq_torso + sin(q_2r)*ddq_1r + Z144*dq_2r + Z539*cos(q_2r) + Z522*sin(q_2r)
syms ddq_2r real
Z540 = + Z522*cos(q_2r) - Z145*dq_2r - Z539*sin(q_2r);
Z541 = + Z144*dq_2r + Z539*cos(q_2r) + Z522*sin(q_2r);
alpha5r = [(-Z137)*dpsi + (-Z138)*dq_imu + (-Z138)*dq_w + (-Z139)*dq_torso - dq_2r-Z538;
    Z146*dpsi+Z147*dq_imu+Z147*dq_w+Z148*dq_torso+Z149*dq_1r+Z540;
    Z150*dpsi+Z151*dq_imu+Z151*dq_w+Z152*dq_torso+Z153*dq_1r+Z541];

% this = '6r'; w = w6ri; prev = '5r'; arphaLast = arpha5r;
% arpha6r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r])
% arpha6r =
%  
%     (Z137*cos(q_3r) + Z150*sin(q_3r))*ddpsi + (Z138*cos(q_3r) + Z151*sin(q_3r))*ddq_imu + (Z138*cos(q_3r) + Z151*sin(q_3r))*ddq_w + (Z139*cos(q_3r) + Z152*sin(q_3r))*ddq_torso + (Z153*sin(q_3r))*ddq_1r + cos(q_3r)*ddq_2r + Z156*dq_3r + Z538*cos(q_3r) + Z541*sin(q_3r)
%                                                                                                                                                                   (-Z146)*ddpsi + (-Z147)*ddq_imu + (-Z147)*ddq_w + (-Z148)*ddq_torso + (-Z149)*ddq_1r - ddq_3r - Z540
%  (Z150*cos(q_3r) - Z137*sin(q_3r))*ddpsi + (Z151*cos(q_3r) - Z138*sin(q_3r))*ddq_imu + (Z151*cos(q_3r) - Z138*sin(q_3r))*ddq_w + (Z152*cos(q_3r) - Z139*sin(q_3r))*ddq_torso + (Z153*cos(q_3r))*ddq_1r + (-sin(q_3r))*ddq_2r + Z541*cos(q_3r) - Z154*dq_3r - Z538*sin(q_3r)
syms ddq_3r real
Z542 = + Z156*dq_3r + Z538*cos(q_3r) + Z541*sin(q_3r);
Z543 = + Z541*cos(q_3r) - Z154*dq_3r - Z538*sin(q_3r);
alpha6r = [Z157*ddpsi+Z158*ddq_imu+Z158*ddq_w+Z159*ddq_torso+Z160*ddq_1r+Z161*ddq_2r+Z542;
    (-Z146)*ddpsi + (-Z147)*ddq_imu + (-Z147)*ddq_w + (-Z148)*ddq_torso + (-Z149)*ddq_1r - ddq_3r - Z540;
    Z162*ddpsi+Z163*ddq_imu+Z163*ddq_w+Z164*ddq_torso+Z165*ddq_1r+Z166*ddq_2r+Z543]; 

% this = '7r'; w = w7ri; prev = '6r'; alphaLast = alpha6r;
% alpha7r = correct(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r])
% alpha7r =
%  (-Z157)*ddpsi + (-Z158)*ddq_imu + (-Z158)*ddq_w + (-Z159)*ddq_torso + (-Z160)*ddq_1r + (-Z161)*ddq_2r - ddq_4r - Z542
%  (Z146*cos(q_4r) - Z162*sin(q_4r))*ddpsi + (Z147*cos(q_4r) - Z163*sin(q_4r))*ddq_imu + (Z147*cos(q_4r) - Z163*sin(q_4r))*ddq_w + (Z148*cos(q_4r) - Z164*sin(q_4r))*ddq_torso + (Z149*cos(q_4r) - Z165*sin(q_4r))*ddq_1r + (-Z166*sin(q_4r))*ddq_2r + cos(q_4r)*ddq_3r + Z540*cos(q_4r) - Z169*dq_4r - Z543*sin(q_4r)
%   (Z162*cos(q_4r) + Z146*sin(q_4r))*ddpsi + (Z163*cos(q_4r) + Z147*sin(q_4r))*ddq_imu + (Z163*cos(q_4r) + Z147*sin(q_4r))*ddq_w + (Z164*cos(q_4r) + Z148*sin(q_4r))*ddq_torso + (Z165*cos(q_4r) + Z149*sin(q_4r))*ddq_1r + (Z166*cos(q_4r))*ddq_2r + sin(q_4r)*ddq_3r + Z168*dq_4r + Z543*cos(q_4r) + Z540*sin(q_4r)
syms ddq_4r real
Z544 =  Z540*cos(q_4r) - Z169*dq_4r - Z543*sin(q_4r);
Z545 =  + Z168*dq_4r + Z543*cos(q_4r) + Z540*sin(q_4r);
alpha7r = [ (-Z157)*ddpsi + (-Z158)*ddq_imu + (-Z158)*ddq_w + (-Z159)*ddq_torso + (-Z160)*ddq_1r + (-Z161)*ddq_2r - ddq_4r - Z542;
    Z170*ddpsi+Z171*ddq_imu+Z171*ddq_w+Z172*ddq_torso+Z173*ddq_1r+Z174*ddq_2r+Z175*ddq_3r+Z544;
    Z176*ddpsi+Z177*ddq_imu+Z177*ddq_w+Z178*ddq_torso+Z179*ddq_1r+Z180*ddq_2r+Z181*ddq_3r+Z545];

% this = '8r'; w = w8ri; prev = '7r'; alphaLast = alpha7r;
% alpha8r = correct(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r])
% alpha8r =
%  
%     (Z157*cos(q_5r) + Z176*sin(q_5r))*ddpsi + (Z158*cos(q_5r) + Z177*sin(q_5r))*ddq_imu + (Z158*cos(q_5r) + Z177*sin(q_5r))*ddq_w + (Z159*cos(q_5r) + Z178*sin(q_5r))*ddq_torso + (Z160*cos(q_5r) + Z179*sin(q_5r))*ddq_1r + (Z161*cos(q_5r) + Z180*sin(q_5r))*ddq_2r + (Z181*sin(q_5r))*ddq_3r + cos(q_5r)*ddq_4r + Z184*dq_5r + Z542*cos(q_5r) + Z545*sin(q_5r)
%                                                                                                                                                                                                                     (-Z170)*ddpsi + (-Z171)*ddq_imu + (-Z171)*ddq_w + (-Z172)*ddq_torso + (-Z173)*ddq_1r + (-Z174)*ddq_2r + (-Z175)*ddq_3r - ddq_5r - Z544
%  (Z176*cos(q_5r) - Z157*sin(q_5r))*ddpsi + (Z177*cos(q_5r) - Z158*sin(q_5r))*ddq_imu + (Z177*cos(q_5r) - Z158*sin(q_5r))*ddq_w + (Z178*cos(q_5r) - Z159*sin(q_5r))*ddq_torso + (Z179*cos(q_5r) - Z160*sin(q_5r))*ddq_1r + (Z180*cos(q_5r) - Z161*sin(q_5r))*ddq_2r + (Z181*cos(q_5r))*ddq_3r + (-sin(q_5r))*ddq_4r + Z545*cos(q_5r) - Z182*dq_5r - Z542*sin(q_5r)
syms ddq_5r real
Z546 = + Z184*dq_5r + Z542*cos(q_5r) + Z545*sin(q_5r);
Z547 = + Z545*cos(q_5r) - Z182*dq_5r - Z542*sin(q_5r);
alpha8r = [Z185*ddpsi+Z186*ddq_imu+Z186*ddq_w+Z187*ddq_torso+Z188*ddq_1r+Z189*ddq_2r+Z190*ddq_3r+Z191*ddq_4r+Z546;
    (-Z170)*ddpsi + (-Z171)*ddq_imu + (-Z171)*ddq_w + (-Z172)*ddq_torso + (-Z173)*ddq_1r + (-Z174)*ddq_2r + (-Z175)*ddq_3r - ddq_5r - Z544;
    Z192*ddpsi+Z193*ddq_imu+Z193*ddq_w+Z194*ddq_torso+Z195*ddq_1r+Z196*ddq_2r+Z197*ddq_3r+Z198*ddq_4r+Z547];

% this = '9r'; w = w9ri; prev = '8r'; alphaLast = alpha8r;
% alpha9r = correct(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r])
% alpha9r =
%  
%                                                                                                                                                                                                                                            (-Z185)*ddpsi + (-Z186)*ddq_imu + (-Z186)*ddq_w + (-Z187)*ddq_torso + (-Z188)*ddq_1r + (-Z189)*ddq_2r + (-Z190)*ddq_3r + (-Z191)*ddq_4r - ddq_6r - Z546
%  (Z170*cos(q_6r) - Z192*sin(q_6r))*ddpsi + (Z171*cos(q_6r) - Z193*sin(q_6r))*ddq_imu + (Z171*cos(q_6r) - Z193*sin(q_6r))*ddq_w + (Z172*cos(q_6r) - Z194*sin(q_6r))*ddq_torso + (Z173*cos(q_6r) - Z195*sin(q_6r))*ddq_1r + (Z174*cos(q_6r) - Z196*sin(q_6r))*ddq_2r + (Z175*cos(q_6r) - Z197*sin(q_6r))*ddq_3r + (-Z198*sin(q_6r))*ddq_4r + cos(q_6r)*ddq_5r + Z544*cos(q_6r) - Z201*dq_6r - Z547*sin(q_6r)
%   (Z192*cos(q_6r) + Z170*sin(q_6r))*ddpsi + (Z193*cos(q_6r) + Z171*sin(q_6r))*ddq_imu + (Z193*cos(q_6r) + Z171*sin(q_6r))*ddq_w + (Z194*cos(q_6r) + Z172*sin(q_6r))*ddq_torso + (Z195*cos(q_6r) + Z173*sin(q_6r))*ddq_1r + (Z196*cos(q_6r) + Z174*sin(q_6r))*ddq_2r + (Z197*cos(q_6r) + Z175*sin(q_6r))*ddq_3r + (Z198*cos(q_6r))*ddq_4r + sin(q_6r)*ddq_5r + Z200*dq_6r + Z547*cos(q_6r) + Z544*sin(q_6r)
syms ddq_6r real
Z548 = + Z544*cos(q_6r) - Z201*dq_6r - Z547*sin(q_6r);
Z549 = + Z200*dq_6r + Z547*cos(q_6r) + Z544*sin(q_6r);
alpha9r = [(-Z185)*ddpsi + (-Z186)*ddq_imu + (-Z186)*ddq_w + (-Z187)*ddq_torso + (-Z188)*ddq_1r + (-Z189)*ddq_2r + (-Z190)*ddq_3r + (-Z191)*ddq_4r - ddq_6r - Z546;
    Z202*ddpsi+Z203*ddq_imu+Z203*ddq_w+Z204*ddq_torso+Z205*ddq_1r+Z206*ddq_2r+Z207*ddq_3r+Z208*ddq_4r+Z209*ddq_5r+Z548;
    Z210*ddpsi+Z211*ddq_imu+Z211*ddq_w+Z212*ddq_torso+Z213*ddq_1r+Z214*ddq_2r+Z215*ddq_3r+Z216*ddq_4r+Z217*ddq_5r+Z549];

% this = '10r'; w = w10ri; prev = '9r'; alphaLast = alpha9r;
% alpha10r = correct(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r])
% alpha10r =
%  
%   (Z185*cos(q_7r) + Z210*sin(q_7r))*ddpsi + (Z186*cos(q_7r) + Z211*sin(q_7r))*ddq_imu + (Z186*cos(q_7r) + Z211*sin(q_7r))*ddq_w + (Z187*cos(q_7r) + Z212*sin(q_7r))*ddq_torso + (Z188*cos(q_7r) + Z213*sin(q_7r))*ddq_1r + (Z189*cos(q_7r) + Z214*sin(q_7r))*ddq_2r + (Z190*cos(q_7r) + Z215*sin(q_7r))*ddq_3r + (Z191*cos(q_7r) + Z216*sin(q_7r))*ddq_4r + (Z217*sin(q_7r))*ddq_5r + cos(q_7r)*ddq_6r + Z546*cos(q_7r) - Z219*dq_7r + Z549*sin(q_7r)
%  (Z185*sin(q_7r) - Z210*cos(q_7r))*ddpsi + (Z186*sin(q_7r) - Z211*cos(q_7r))*ddq_imu + (Z186*sin(q_7r) - Z211*cos(q_7r))*ddq_w + (Z187*sin(q_7r) - Z212*cos(q_7r))*ddq_torso + (Z188*sin(q_7r) - Z213*cos(q_7r))*ddq_1r + (Z189*sin(q_7r) - Z214*cos(q_7r))*ddq_2r + (Z190*sin(q_7r) - Z215*cos(q_7r))*ddq_3r + (Z191*sin(q_7r) - Z216*cos(q_7r))*ddq_4r + (-Z217*cos(q_7r))*ddq_5r + sin(q_7r)*ddq_6r + Z218*dq_7r - Z549*cos(q_7r) + Z546*sin(q_7r)
%                                                                                                                                                                                                                                                                          (-Z202)*ddpsi + (-Z203)*ddq_imu + (-Z203)*ddq_w + (-Z204)*ddq_torso + (-Z205)*ddq_1r + (-Z206)*ddq_2r + (-Z207)*ddq_3r + (-Z208)*ddq_4r + (-Z209)*ddq_5r - ddq_7r - Z548
syms ddq_7r real
Z550 = + Z546*cos(q_7r) - Z219*dq_7r + Z549*sin(q_7r);
Z551 = + Z218*dq_7r - Z549*cos(q_7r) + Z546*sin(q_7r);
alpha10r = [Z221*ddpsi+Z222*ddq_imu+Z222*ddq_w+Z223*ddq_torso+Z224*ddq_1r+Z225*ddq_2r+Z226*ddq_3r+Z227*ddq_4r+Z228*ddq_5r+Z229*ddq_6r+Z550;
    Z230*ddpsi+Z231*ddq_imu+Z231*ddq_w+Z232*ddq_torso+Z233*ddq_1r+Z234*ddq_2r+Z235*ddq_3r+Z236*ddq_4r+Z237*ddq_5r+Z238*ddq_6r+Z551;
    (-Z202)*ddpsi + (-Z203)*ddq_imu + (-Z203)*ddq_w + (-Z204)*ddq_torso + (-Z205)*ddq_1r + (-Z206)*ddq_2r + (-Z207)*ddq_3r + (-Z208)*ddq_4r + (-Z209)*ddq_5r - ddq_7r - Z548];

%% Linear Acceleration

% Wheels
% rOL = Z552*j0L;
% a0L = ddx*i0L + dx*(cross(dpsi*k0L,i0L));
% aGL = collect(a0L + cross(alpha0L, rOL) + cross(w0L, cross(w0L, rOL)),[ddx,ddpsi])
% aGL =
%  
%                                         Z4*ddx + (-Z4*Z552)*ddpsi
%  dx*(dpsi*Z3^2 + dpsi*Z4^2) - Z3^2*Z552*dpsi^2 - Z4^2*Z552*dpsi^2
%                                         Z3*ddx + (-Z3*Z552)*ddpsi
Z552 = L/2;
Z553 = + (-Z4*Z552);
Z554 = dx*dpsi - Z552*dpsi^2;
Z555 = (-Z3*Z552);
aGL = [Z4*ddx+Z553*ddpsi; Z554; Z3*ddx+Z555*ddpsi];

% rOR = -Z552*j0R;
% a0R = ddx*i0R + dx*(cross(dpsi*k0R,i0R));
% aGR = collect(a0R + cross(alpha0R, rOR) + cross(w0R, cross(w0R, rOR)),[ddx,ddpsi])
% aGR =
%  
%                                          Z9*ddx + (Z9*Z552)*ddpsi
%  dx*(dpsi*Z8^2 + dpsi*Z9^2) + Z8^2*Z552*dpsi^2 + Z9^2*Z552*dpsi^2
%                                          Z8*ddx + (Z8*Z552)*ddpsi
Z556 = Z9*Z552;
Z557 = dx*dpsi + Z552*dpsi^2;
Z558 = Z8*Z552;
aGR = [Z9*ddx+Z556*ddpsi; Z557; Z8*ddx+Z558*ddpsi];

% Tree
% *************************************************************************    
% *    w_a = angVel(f, f(key).a);                                         *
% *    alpha_a = angAcc(f, f(key).a);                                     *   
% *    a_a = linAcc(f, f(key).a);                                         * 
% *                                                                       *       
% *    % Acceleration of the current frame                                *       
% *    a = Rot(f, f(key).a, key) * (a_a + cross(alpha_a, f(key).P) ...    *                                   
% *        + cross(w_a, cross(w_a, f(key).P)));                           *            
% *************************************************************************

% a0 = [ddx; 0; 0] + cross(w0, [1; 0; 0]); 
% this = '1'; prev = '0'; aLast = a0; alphaLast = alpha0; wLast = w0;
% a1 = Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P)))
% a1 =
%  
%            -dpsi
%   ddx*sin(q_imu)
%  -ddx*cos(q_imu)
a1 = [-dpsi; Z14*ddx; -Z13*ddx];

% this = '2'; prev = '1'; aLast = a1; alphaLast = alpha1; wLast = w1i;
% a2 = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu])
% a2 =
%  
%                                                                                         (- L1*Z14 - L2*Z13)*ddpsi + L2*Z16*dq_imu - L1*Z519 - L2*Z518 - L1*Z15*dq_imu - dpsi
%    (Z14*cos(q_w) + Z13*sin(q_w))*ddx + (L1*sin(q_w) - L2*cos(q_w))*ddq_imu - cos(q_w)*(L1*dq_imu^2 + Z16*(L1*Z16 + L2*Z15)) - sin(q_w)*(L2*dq_imu^2 + Z15*(L1*Z16 + L2*Z15))
%  (Z14*sin(q_w) - Z13*cos(q_w))*ddx + (- L1*cos(q_w) - L2*sin(q_w))*ddq_imu + cos(q_w)*(L2*dq_imu^2 + Z15*(L1*Z16 + L2*Z15)) - sin(q_w)*(L1*dq_imu^2 + Z16*(L1*Z16 + L2*Z15))
Z559 = L2*Z16*dq_imu - L1*Z519 - L2*Z518 - L1*Z15*dq_imu - dpsi;
Z560 = - cos(q_w)*(L1*dq_imu^2 + Z16*(L1*Z16 + L2*Z15)) - sin(q_w)*(L2*dq_imu^2 + Z15*(L1*Z16 + L2*Z15));
Z561 = cos(q_w)*(L2*dq_imu^2 + Z15*(L1*Z16 + L2*Z15)) - sin(q_w)*(L1*dq_imu^2 + Z16*(L1*Z16 + L2*Z15));
a2 = [Z249*ddpsi+Z559; Z250*ddx+Z251*ddq_imu+Z560; Z252*ddx+Z253*ddq_imu+Z561];

% this = '3'; prev = '2'; aLast = a2; alphaLast = alpha2; wLast = w2i;
% a3 = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu])
% a3 =
%  
%  (-Z252*sin(q_torso))*ddx + (-cos(q_torso)*(Z249 - L3*Z21 + L4*Z20))*ddpsi + (sin(q_torso)*(L3 - Z253))*ddq_imu + (L3*sin(q_torso))*ddq_w - sin(q_torso)*(- L4*Z17^2 + Z561 + Z18*(L3*Z19 - L4*Z18)) - cos(q_torso)*(Z559 - L3*Z521 + L4*Z520 + L3*Z17*Z18 + L4*Z17*Z19)
%                                                                                                                                                                                    - L3*Z17^2 + Z560 + L4*ddq_w + Z250*ddx - Z19*(L3*Z19 - L4*Z18) + ddq_imu*(L4 + Z251)
%   (-Z252*cos(q_torso))*ddx + (sin(q_torso)*(Z249 - L3*Z21 + L4*Z20))*ddpsi + (cos(q_torso)*(L3 - Z253))*ddq_imu + (L3*cos(q_torso))*ddq_w + sin(q_torso)*(Z559 - L3*Z521 + L4*Z520 + L3*Z17*Z18 + L4*Z17*Z19) - cos(q_torso)*(- L4*Z17^2 + Z561 + Z18*(L3*Z19 - L4*Z18))

Z562 = - sin(q_torso)*(- L4*Z17^2 + Z561 + Z18*(L3*Z19 - L4*Z18)) - cos(q_torso)*(Z559 - L3*Z521 + L4*Z520 + L3*Z17*Z18 + L4*Z17*Z19);
Z563 = - L3*Z17^2 + Z560 - Z19*(L3*Z19 - L4*Z18);
Z564 = + sin(q_torso)*(Z559 - L3*Z521 + L4*Z520 + L3*Z17*Z18 + L4*Z17*Z19) - cos(q_torso)*(- L4*Z17^2 + Z561 + Z18*(L3*Z19 - L4*Z18));
 
a3 = [Z257*ddx+Z258*ddpsi+Z259*ddq_imu+Z260*ddq_w+Z562; 
    Z250*ddx+Z261*ddq_imu+L4*ddq_w+Z563; 
    Z262*ddx+Z263*ddpsi+Z264*ddq_imu+Z265*ddq_w+Z564];

% this = '4l'; prev = '3'; aLast = a3; alphaLast = alpha3; wLast = w3i;
% a4l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w])
% a4l =
%  
%          (Z250*cos(q_1l) - Z262*sin(q_1l))*ddx + (L6*Z28*cos(q_1l) - sin(q_1l)*(Z263 - L6*Z20 + L5*Z26))*ddpsi + (cos(q_1l)*(Z261 + L6*Z27) - sin(q_1l)*(Z264 + L5*Z25))*ddq_imu + (cos(q_1l)*(L4 + L6*Z27) - sin(q_1l)*(Z265 + L5*Z25))*ddq_w + (-L6*sin(q_1l))*ddq_torso + cos(q_1l)*(- L5*Z24^2 + Z563 + L6*Z523 - Z22*(L5*Z22 - L6*Z23)) - sin(q_1l)*(Z564 - L6*Z520 + L5*Z522 + L5*Z23*Z24 + L6*Z22*Z24)
%                                                                                                                                                                                                                                                                      - L6*Z24^2 + Z562 - L5*Z523 + Z257*ddx + Z23*(L5*Z22 - L6*Z23) + ddpsi*(Z258 - L5*Z28) + ddq_w*(Z260 - L5*Z27) + ddq_imu*(Z259 - L5*Z27)
%  (- Z262*cos(q_1l) - Z250*sin(q_1l))*ddx + (- cos(q_1l)*(Z263 - L6*Z20 + L5*Z26) - L6*Z28*sin(q_1l))*ddpsi + (- sin(q_1l)*(Z261 + L6*Z27) - cos(q_1l)*(Z264 + L5*Z25))*ddq_imu + (- cos(q_1l)*(Z265 + L5*Z25) - sin(q_1l)*(L4 + L6*Z27))*ddq_w + (-L6*cos(q_1l))*ddq_torso - sin(q_1l)*(- L5*Z24^2 + Z563 + L6*Z523 - Z22*(L5*Z22 - L6*Z23)) - cos(q_1l)*(Z564 - L6*Z520 + L5*Z522 + L5*Z23*Z24 + L6*Z22*Z24)
Z565 =  + cos(q_1l)*(- L5*Z24^2 + Z563 + L6*Z523 - Z22*(L5*Z22 - L6*Z23)) - sin(q_1l)*(Z564 - L6*Z520 + L5*Z522 + L5*Z23*Z24 + L6*Z22*Z24);
Z566 = - L6*Z24^2 + Z562 - L5*Z523 + Z23*(L5*Z22 - L6*Z23) ;
Z567 = - sin(q_1l)*(- L5*Z24^2 + Z563 + L6*Z523 - Z22*(L5*Z22 - L6*Z23)) - cos(q_1l)*(Z564 - L6*Z520 + L5*Z522 + L5*Z23*Z24 + L6*Z22*Z24);

a4l = [Z269*ddx+Z270*ddpsi+Z271*ddq_imu+Z272*ddq_w+Z273*ddq_torso+Z565; 
    Z257*ddx+Z274*ddpsi+Z275*ddq_imu+Z276*ddq_w+Z566; 
    Z277*ddx+Z278*ddpsi+Z279*ddq_imu+Z280*ddq_w+Z281*ddq_torso+Z567];

% this = '5l'; prev = '4l'; aLast = a4l; alphaLast = alpha4l; wLast = w4li;
% a5l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l])
% a5l =
%  
%                                                                                                                                                       (-Z269)*ddx + (-Z270)*ddpsi + (-Z271)*ddq_imu + (-Z272)*ddq_w + (-Z273)*ddq_torso - Z565
%  (- Z257*cos(q_2l) - Z277*sin(q_2l))*ddx + (- Z274*cos(q_2l) - Z278*sin(q_2l))*ddpsi + (- Z275*cos(q_2l) - Z279*sin(q_2l))*ddq_imu + (- Z276*cos(q_2l) - Z280*sin(q_2l))*ddq_w + (-Z281*sin(q_2l))*ddq_torso - Z566*cos(q_2l) - Z567*sin(q_2l)
%           (Z277*cos(q_2l) - Z257*sin(q_2l))*ddx + (Z278*cos(q_2l) - Z274*sin(q_2l))*ddpsi + (Z279*cos(q_2l) - Z275*sin(q_2l))*ddq_imu + (Z280*cos(q_2l) - Z276*sin(q_2l))*ddq_w + (Z281*cos(q_2l))*ddq_torso + Z567*cos(q_2l) - Z566*sin(q_2l)
% 
Z568 =  - Z566*cos(q_2l) - Z567*sin(q_2l);
Z569 =  + Z567*cos(q_2l) - Z566*sin(q_2l);
a5l = [(-Z269)*ddx + (-Z270)*ddpsi + (-Z271)*ddq_imu + (-Z272)*ddq_w - Z273*ddq_torso - Z565;
    Z284*ddx+Z285*ddpsi+Z286*ddq_imu+Z287*ddq_w+Z288*ddq_torso+Z568; 
    Z289*ddx+Z290*ddpsi+Z291*ddq_imu+Z292*ddq_w+Z293*ddq_torso+Z569];

% this = '6l'; prev = '5l'; aLast = a5l; alphaLast = alpha5l; wLast = w5li;
% a6l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l])
% a6l =
%  
%  (Z269*cos(q_3l) + Z289*sin(q_3l))*ddx + (sin(q_3l)*(Z290 + L7*Z32) + cos(q_3l)*(Z270 - L7*Z45))*ddpsi + (sin(q_3l)*(Z291 + L7*Z33) + cos(q_3l)*(Z271 - L7*Z46))*ddq_imu + (sin(q_3l)*(Z292 + L7*Z33) + cos(q_3l)*(Z272 - L7*Z46))*ddq_w + (sin(q_3l)*(Z293 + L7*Z34) + cos(q_3l)*(Z273 - L7*Z47))*ddq_torso + (-L7*Z48*cos(q_3l))*ddq_1l + (L7*sin(q_3l))*ddq_2l + cos(q_3l)*(Z565 - L7*Z527 + L7*Z38*Z39) + sin(q_3l)*(Z569 + L7*Z524 - L7*Z39*Z40)
%                                                                                                                                                                                                                                                                                                                                                     - L7*Z38^2 - L7*Z40^2 - Z568 - Z285*ddpsi - Z287*ddq_w - Z286*ddq_imu - Z288*ddq_torso - Z284*ddx
%   (Z289*cos(q_3l) - Z269*sin(q_3l))*ddx + (cos(q_3l)*(Z290 + L7*Z32) - sin(q_3l)*(Z270 - L7*Z45))*ddpsi + (cos(q_3l)*(Z291 + L7*Z33) - sin(q_3l)*(Z271 - L7*Z46))*ddq_imu + (cos(q_3l)*(Z292 + L7*Z33) - sin(q_3l)*(Z272 - L7*Z46))*ddq_w + (cos(q_3l)*(Z293 + L7*Z34) - sin(q_3l)*(Z273 - L7*Z47))*ddq_torso + (L7*Z48*sin(q_3l))*ddq_1l + (L7*cos(q_3l))*ddq_2l + cos(q_3l)*(Z569 + L7*Z524 - L7*Z39*Z40) - sin(q_3l)*(Z565 - L7*Z527 + L7*Z38*Z39)
Z570 = + cos(q_3l)*(Z565 - L7*Z527 + L7*Z38*Z39) + sin(q_3l)*(Z569 + L7*Z524 - L7*Z39*Z40);
Z571 = - L7*Z38^2 - L7*Z40^2 - Z568 ;
Z572 =  + cos(q_3l)*(Z569 + L7*Z524 - L7*Z39*Z40) - sin(q_3l)*(Z565 - L7*Z527 + L7*Z38*Z39);

a6l = [Z296*ddx+Z297*ddpsi+Z298*ddq_imu+Z299*ddq_w+Z300*ddq_torso+Z301*ddq_1l+Z302*ddq_2l+Z570; 
    (-Z284)*ddx + (-Z285)*ddpsi + (-Z286)*ddq_imu + (-Z287)*ddq_w + (-Z288)*ddq_torso+Z571;
    Z303*ddx+Z304*ddpsi+Z305*ddq_imu+Z306*ddq_w+Z307*ddq_torso+Z308*ddq_1l+Z309*ddq_2l+Z572];

% this = '7l'; prev = '6l'; aLast = a6l; alphaLast = alpha6l; wLast = w6li;
% a7l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_q3l])
% a7l =
%  
%                                                                                                                                                                                   (-Z296)*ddx + (-Z297)*ddpsi + (-Z298)*ddq_imu + (-Z299)*ddq_w + (-Z300)*ddq_torso + (-Z301)*ddq_1l + (-Z302)*ddq_2l - Z570
%  (Z284*cos(q_4l) - Z303*sin(q_4l))*ddx + (Z285*cos(q_4l) - Z304*sin(q_4l))*ddpsi + (Z286*cos(q_4l) - Z305*sin(q_4l))*ddq_imu + (Z287*cos(q_4l) - Z306*sin(q_4l))*ddq_w + (Z288*cos(q_4l) - Z307*sin(q_4l))*ddq_torso + (-Z308*sin(q_4l))*ddq_1l + (-Z309*sin(q_4l))*ddq_2l - Z571*cos(q_4l) - Z572*sin(q_4l)
%    (Z303*cos(q_4l) + Z284*sin(q_4l))*ddx + (Z304*cos(q_4l) + Z285*sin(q_4l))*ddpsi + (Z305*cos(q_4l) + Z286*sin(q_4l))*ddq_imu + (Z306*cos(q_4l) + Z287*sin(q_4l))*ddq_w + (Z307*cos(q_4l) + Z288*sin(q_4l))*ddq_torso + (Z308*cos(q_4l))*ddq_1l + (Z309*cos(q_4l))*ddq_2l + Z572*cos(q_4l) - Z571*sin(q_4l)
Z573 = - Z571*cos(q_4l) - Z572*sin(q_4l);
Z574 = + Z572*cos(q_4l) - Z571*sin(q_4l);
 
a7l = [(-Z296)*ddx + (-Z297)*ddpsi + (-Z298)*ddq_imu + (-Z299)*ddq_w + (-Z300)*ddq_torso + (-Z301)*ddq_1l + (-Z302)*ddq_2l- Z570;
    Z312*ddx+Z313*ddpsi+Z314*ddq_imu+Z315*ddq_w+Z316*ddq_torso+Z317*ddq_1l+Z318*ddq_2l+Z573; 
    Z319*ddx+Z320*ddpsi+Z321*ddq_imu+Z322*ddq_w+Z323*ddq_torso+Z324*ddq_1l+Z325*ddq_2l+Z574];
% 
% this = '8l'; prev = '7l'; aLast = a7l; alphaLast = alpha7l; wLast = w7li;
% a8l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_q3l,ddq_q4l])
% a8l =
%  
%  (Z296*cos(q_5l) + Z319*sin(q_5l))*ddx + (sin(q_5l)*(Z320 + L8*Z52) + cos(q_5l)*(Z297 - L8*Z71))*ddpsi + (sin(q_5l)*(Z321 + L8*Z53) + cos(q_5l)*(Z298 - L8*Z72))*ddq_imu + (sin(q_5l)*(Z322 + L8*Z53) + cos(q_5l)*(Z299 - L8*Z72))*ddq_w + (sin(q_5l)*(Z323 + L8*Z54) + cos(q_5l)*(Z300 - L8*Z73))*ddq_torso + (sin(q_5l)*(Z324 + L8*Z55) + cos(q_5l)*(Z301 - L8*Z74))*ddq_1l + (sin(q_5l)*(Z325 + L8*Z56) + cos(q_5l)*(Z302 - L8*Z75))*ddq_2l + (-L8*Z76*cos(q_5l))*ddq_3l + (L8*sin(q_5l))*ddq_4l + cos(q_5l)*(Z570 - L8*Z531 + L8*Z62*Z63) + sin(q_5l)*(Z574 + L8*Z528 - L8*Z63*Z64)
%                                                                                                                                                                                                                                                                                                                                                                                                                                                           - L8*Z62^2 - L8*Z64^2 - Z573 - Z313*ddpsi - Z317*ddq_1l - Z318*ddq_2l - Z315*ddq_w - Z314*ddq_imu - Z316*ddq_torso - Z312*ddx
%   (Z319*cos(q_5l) - Z296*sin(q_5l))*ddx + (cos(q_5l)*(Z320 + L8*Z52) - sin(q_5l)*(Z297 - L8*Z71))*ddpsi + (cos(q_5l)*(Z321 + L8*Z53) - sin(q_5l)*(Z298 - L8*Z72))*ddq_imu + (cos(q_5l)*(Z322 + L8*Z53) - sin(q_5l)*(Z299 - L8*Z72))*ddq_w + (cos(q_5l)*(Z323 + L8*Z54) - sin(q_5l)*(Z300 - L8*Z73))*ddq_torso + (cos(q_5l)*(Z324 + L8*Z55) - sin(q_5l)*(Z301 - L8*Z74))*ddq_1l + (cos(q_5l)*(Z325 + L8*Z56) - sin(q_5l)*(Z302 - L8*Z75))*ddq_2l + (L8*Z76*sin(q_5l))*ddq_3l + (L8*cos(q_5l))*ddq_4l + cos(q_5l)*(Z574 + L8*Z528 - L8*Z63*Z64) - sin(q_5l)*(Z570 - L8*Z531 + L8*Z62*Z63)
 
Z575 = + cos(q_5l)*(Z570 - L8*Z531 + L8*Z62*Z63) + sin(q_5l)*(Z574 + L8*Z528 - L8*Z63*Z64);
Z576 = - L8*Z62^2 - L8*Z64^2 - Z573 ;
Z577 =  + cos(q_5l)*(Z574 + L8*Z528 - L8*Z63*Z64) - sin(q_5l)*(Z570 - L8*Z531 + L8*Z62*Z63);

a8l = [Z328*ddx+Z329*ddpsi+Z330*ddq_imu+Z331*ddq_w+Z332*ddq_torso+Z333*ddq_1l+Z334*ddq_2l+Z335*ddq_3l+Z336*ddq_4l+Z575; 
    (-Z312)*ddx + (-Z313)*ddpsi + (-Z314)*ddq_imu + (-Z315)*ddq_w + (-Z316)*ddq_torso + (-Z317)*ddq_1l + (-Z318)*ddq_2l+Z576;
    Z337*ddx+Z338*ddpsi+Z339*ddq_imu+Z340*ddq_w+Z341*ddq_torso+Z342*ddq_1l+Z343*ddq_2l+Z344*ddq_3l+Z345*ddq_4l+Z577];
% 
% this = '9l'; prev = '8l'; aLast = a8l; alphaLast = alpha8l; wLast = w8li;
% a9l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_q3l,ddq_q4l,ddq_q5l])
% a9l =
%  
%                                                                                                                                                                                                                                       (-Z328)*ddx + (-Z329)*ddpsi + (-Z330)*ddq_imu + (-Z331)*ddq_w + (-Z332)*ddq_torso + (-Z333)*ddq_1l + (-Z334)*ddq_2l + (-Z335)*ddq_3l + (-Z336)*ddq_4l - Z575
%  (Z312*cos(q_6l) - Z337*sin(q_6l))*ddx + (Z313*cos(q_6l) - Z338*sin(q_6l))*ddpsi + (Z314*cos(q_6l) - Z339*sin(q_6l))*ddq_imu + (Z315*cos(q_6l) - Z340*sin(q_6l))*ddq_w + (Z316*cos(q_6l) - Z341*sin(q_6l))*ddq_torso + (Z317*cos(q_6l) - Z342*sin(q_6l))*ddq_1l + (Z318*cos(q_6l) - Z343*sin(q_6l))*ddq_2l + (-Z344*sin(q_6l))*ddq_3l + (-Z345*sin(q_6l))*ddq_4l - Z576*cos(q_6l) - Z577*sin(q_6l)
%    (Z337*cos(q_6l) + Z312*sin(q_6l))*ddx + (Z338*cos(q_6l) + Z313*sin(q_6l))*ddpsi + (Z339*cos(q_6l) + Z314*sin(q_6l))*ddq_imu + (Z340*cos(q_6l) + Z315*sin(q_6l))*ddq_w + (Z341*cos(q_6l) + Z316*sin(q_6l))*ddq_torso + (Z342*cos(q_6l) + Z317*sin(q_6l))*ddq_1l + (Z343*cos(q_6l) + Z318*sin(q_6l))*ddq_2l + (Z344*cos(q_6l))*ddq_3l + (Z345*cos(q_6l))*ddq_4l + Z577*cos(q_6l) - Z576*sin(q_6l)
Z578 =  - Z576*cos(q_6l) - Z577*sin(q_6l);
Z579 =  + Z577*cos(q_6l) - Z576*sin(q_6l);

a9l = [(-Z328)*ddx + (-Z329)*ddpsi + (-Z330)*ddq_imu + (-Z331)*ddq_w + (-Z332)*ddq_torso + (-Z333)*ddq_1l + (-Z334)*ddq_2l + (-Z335)*ddq_3l + (-Z336)*ddq_4l- Z575;
    Z348*ddx+Z349*ddpsi+Z350*ddq_imu+Z351*ddq_w+Z352*ddq_torso+Z353*ddq_1l+Z354*ddq_2l+Z355*ddq_3l+Z356*ddq_4l+Z578; 
    Z357*ddx+Z358*ddpsi+Z359*ddq_imu+Z360*ddq_w+Z361*ddq_torso+Z362*ddq_1l+Z363*ddq_2l+Z364*ddq_3l+Z365*ddq_4l+Z579];
% 
% this = '10l'; prev = '9l'; aLast = a9l; alphaLast = alpha9l; wLast = w9li;
% a10l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_q3l,ddq_q4l,ddq_q5l,ddq_q6l])
% a10l =
%  
%   (Z328*cos(q_7l) + Z357*sin(q_7l))*ddx + (sin(q_7l)*(Z358 + L9*Z80) + cos(q_7l)*(Z329 - L9*Z105))*ddpsi + (sin(q_7l)*(Z359 + L9*Z81) + cos(q_7l)*(Z330 - L9*Z106))*ddq_imu + (sin(q_7l)*(Z360 + L9*Z81) + cos(q_7l)*(Z331 - L9*Z106))*ddq_w + (sin(q_7l)*(Z361 + L9*Z82) + cos(q_7l)*(Z332 - L9*Z107))*ddq_torso + (sin(q_7l)*(Z362 + L9*Z83) + cos(q_7l)*(Z333 - L9*Z108))*ddq_1l + (sin(q_7l)*(Z363 + L9*Z84) + cos(q_7l)*(Z334 - L9*Z109))*ddq_2l + (sin(q_7l)*(Z364 + L9*Z85) + cos(q_7l)*(Z335 - L9*Z110))*ddq_3l + (sin(q_7l)*(Z365 + L9*Z86) + cos(q_7l)*(Z336 - L9*Z111))*ddq_4l + (-L9*Z112*cos(q_7l))*ddq_5l + (L9*sin(q_7l))*ddq_6l + cos(q_7l)*(Z575 - L9*Z535 + L9*Z94*Z95) + sin(q_7l)*(Z579 + L9*Z532 - L9*Z95*Z96)
%  (Z328*sin(q_7l) - Z357*cos(q_7l))*ddx + (sin(q_7l)*(Z329 - L9*Z105) - cos(q_7l)*(Z358 + L9*Z80))*ddpsi + (sin(q_7l)*(Z330 - L9*Z106) - cos(q_7l)*(Z359 + L9*Z81))*ddq_imu + (sin(q_7l)*(Z331 - L9*Z106) - cos(q_7l)*(Z360 + L9*Z81))*ddq_w + (sin(q_7l)*(Z332 - L9*Z107) - cos(q_7l)*(Z361 + L9*Z82))*ddq_torso + (sin(q_7l)*(Z333 - L9*Z108) - cos(q_7l)*(Z362 + L9*Z83))*ddq_1l + (sin(q_7l)*(Z334 - L9*Z109) - cos(q_7l)*(Z363 + L9*Z84))*ddq_2l + (sin(q_7l)*(Z335 - L9*Z110) - cos(q_7l)*(Z364 + L9*Z85))*ddq_3l + (sin(q_7l)*(Z336 - L9*Z111) - cos(q_7l)*(Z365 + L9*Z86))*ddq_4l + (-L9*Z112*sin(q_7l))*ddq_5l + (-L9*cos(q_7l))*ddq_6l + sin(q_7l)*(Z575 - L9*Z535 + L9*Z94*Z95) - cos(q_7l)*(Z579 + L9*Z532 - L9*Z95*Z96)
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           - L9*Z94^2 - L9*Z96^2 - Z578 - Z349*ddpsi - Z353*ddq_1l - Z354*ddq_2l - Z355*ddq_3l - Z356*ddq_4l - Z351*ddq_w - Z350*ddq_imu - Z352*ddq_torso - Z348*ddx
Z580 =  + cos(q_7l)*(Z575 - L9*Z535 + L9*Z94*Z95) + sin(q_7l)*(Z579 + L9*Z532 - L9*Z95*Z96);
Z581 =  + sin(q_7l)*(Z575 - L9*Z535 + L9*Z94*Z95) - cos(q_7l)*(Z579 + L9*Z532 - L9*Z95*Z96);
Z582 = - L9*Z94^2 - L9*Z96^2 - Z578 ;
a10l = [Z368*ddx+Z369*ddpsi+Z370*ddq_imu+Z371*ddq_w+Z372*ddq_torso+Z373*ddq_1l+Z374*ddq_2l+Z375*ddq_3l+Z376*ddq_4l+Z377*ddq_5l+Z378*ddq_6l+Z580; 
    Z379*ddx+Z380*ddpsi+Z381*ddq_imu+Z382*ddq_w+Z383*ddq_torso+Z384*ddq_1l+Z385*ddq_2l+Z386*ddq_3l+Z387*ddq_4l+Z388*ddq_5l+Z389*ddq_6l+Z581; 
    (-Z348)*ddx + (-Z349)*ddpsi + (-Z350)*ddq_imu + (-Z351)*ddq_w + (-Z352)*ddq_torso + (-Z353)*ddq_1l + (-Z354)*ddq_2l + (-Z355)*ddq_3l + (-Z356)*ddq_4l+Z582];


% this = '4r'; prev = '3'; aLast = a3; alphaLast = alpha3; wLast = w3i;
% a4r = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso])
% a4r =
%  
%  (Z250*cos(q_1r) + Z262*sin(q_1r))*ddx + (sin(q_1r)*(Z263 + L6*Z20 + L5*Z26) - L6*Z28*cos(q_1r))*ddpsi + (sin(q_1r)*(Z264 + L5*Z25) + cos(q_1r)*(Z261 - L6*Z27))*ddq_imu + (sin(q_1r)*(Z265 + L5*Z25) + cos(q_1r)*(L4 - L6*Z27))*ddq_w + (-L6*sin(q_1r))*ddq_torso + sin(q_1r)*(Z564 + L6*Z520 + L5*Z522 + L5*Z23*Z24 - L6*Z22*Z24) - cos(q_1r)*(L5*Z24^2 - Z563 + L6*Z523 + Z22*(L5*Z22 + L6*Z23))
%                                                                                                                                                                                                                                                            - L6*Z24^2 - Z562 + L5*Z523 - Z257*ddx - Z23*(L5*Z22 + L6*Z23) - ddpsi*(Z258 - L5*Z28) - ddq_w*(Z260 - L5*Z27) - ddq_imu*(Z259 - L5*Z27)
%  (Z262*cos(q_1r) - Z250*sin(q_1r))*ddx + (cos(q_1r)*(Z263 + L6*Z20 + L5*Z26) + L6*Z28*sin(q_1r))*ddpsi + (cos(q_1r)*(Z264 + L5*Z25) - sin(q_1r)*(Z261 - L6*Z27))*ddq_imu + (cos(q_1r)*(Z265 + L5*Z25) - sin(q_1r)*(L4 - L6*Z27))*ddq_w + (-L6*cos(q_1r))*ddq_torso + cos(q_1r)*(Z564 + L6*Z520 + L5*Z522 + L5*Z23*Z24 - L6*Z22*Z24) + sin(q_1r)*(L5*Z24^2 - Z563 + L6*Z523 + Z22*(L5*Z22 + L6*Z23))
Z583 = + sin(q_1r)*(Z564 + L6*Z520 + L5*Z522 + L5*Z23*Z24 - L6*Z22*Z24) - cos(q_1r)*(L5*Z24^2 - Z563 + L6*Z523 + Z22*(L5*Z22 + L6*Z23));
Z584 = - L6*Z24^2 - Z562 + L5*Z523 - Z23*(L5*Z22 + L6*Z23) ;
Z585 = + cos(q_1r)*(Z564 + L6*Z520 + L5*Z522 + L5*Z23*Z24 - L6*Z22*Z24) + sin(q_1r)*(L5*Z24^2 - Z563 + L6*Z523 + Z22*(L5*Z22 + L6*Z23));
a4r = [Z393*ddx+Z394*ddpsi+Z395*ddq_imu+Z396*ddq_w+Z397*ddq_torso+Z583; 
    -Z257*ddx+Z398*ddpsi+Z399*ddq_imu+Z400*ddq_w+Z584; 
    Z401*ddx+Z402*ddpsi+Z403*ddq_imu+Z404*ddq_w+Z405*ddq_torso+Z585];

% this = '5r'; prev = '4r'; aLast = a4r; alphaLast = alpha4r; wLast = w4ri;
% a5r = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso])
% a5r =
%  
%                                                                                                                                                     (-Z393)*ddx + (-Z394)*ddpsi + (-Z395)*ddq_imu + (-Z396)*ddq_w + (-Z397)*ddq_torso - Z583
%  (Z257*cos(q_2r) - Z401*sin(q_2r))*ddx + (- Z398*cos(q_2r) - Z402*sin(q_2r))*ddpsi + (- Z399*cos(q_2r) - Z403*sin(q_2r))*ddq_imu + (- Z400*cos(q_2r) - Z404*sin(q_2r))*ddq_w + (-Z405*sin(q_2r))*ddq_torso - Z584*cos(q_2r) - Z585*sin(q_2r)
%         (Z401*cos(q_2r) + Z257*sin(q_2r))*ddx + (Z402*cos(q_2r) - Z398*sin(q_2r))*ddpsi + (Z403*cos(q_2r) - Z399*sin(q_2r))*ddq_imu + (Z404*cos(q_2r) - Z400*sin(q_2r))*ddq_w + (Z405*cos(q_2r))*ddq_torso + Z585*cos(q_2r) - Z584*sin(q_2r)
Z586 =  - Z584*cos(q_2r) - Z585*sin(q_2r);
Z587 =  + Z585*cos(q_2r) - Z584*sin(q_2r);
a5r = [(-Z393)*ddx + (-Z394)*ddpsi + (-Z395)*ddq_imu + (-Z396)*ddq_w - Z397*ddq_torso- Z583;
    Z408*ddx+Z409*ddpsi+Z410*ddq_imu+Z411*ddq_w+Z412*ddq_torso+Z586; 
    Z413*ddx+Z414*ddpsi+Z415*ddq_imu+Z416*ddq_w+Z417*ddq_torso+Z587];

% this = '6r'; prev = '5r'; aLast = a5r; arphaLast = arpha5r; wLast = w5ri;
% a6r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r])
% a6r =
%  
%  (Z393*cos(q_3r) + Z413*sin(q_3r))*ddx + (sin(q_3r)*(Z414 + L7*Z137) + cos(q_3r)*(Z394 - L7*Z150))*ddpsi + (sin(q_3r)*(Z415 + L7*Z138) + cos(q_3r)*(Z395 - L7*Z151))*ddq_imu + (sin(q_3r)*(Z416 + L7*Z138) + cos(q_3r)*(Z396 - L7*Z151))*ddq_w + (sin(q_3r)*(Z417 + L7*Z139) + cos(q_3r)*(Z397 - L7*Z152))*ddq_torso + (-L7*Z153*cos(q_3r))*ddq_1r + (L7*sin(q_3r))*ddq_2r + cos(q_3r)*(Z583 - L7*Z541 + L7*Z143*Z144) + sin(q_3r)*(Z587 + L7*Z538 - L7*Z144*Z145)
%                                                                                                                                                                                                                                                                                                                                                     - L7*Z143^2 - L7*Z145^2 - Z586 - Z409*ddpsi - Z411*ddq_w - Z410*ddq_imu - Z412*ddq_torso - Z408*ddx
%   (Z413*cos(q_3r) - Z393*sin(q_3r))*ddx + (cos(q_3r)*(Z414 + L7*Z137) - sin(q_3r)*(Z394 - L7*Z150))*ddpsi + (cos(q_3r)*(Z415 + L7*Z138) - sin(q_3r)*(Z395 - L7*Z151))*ddq_imu + (cos(q_3r)*(Z416 + L7*Z138) - sin(q_3r)*(Z396 - L7*Z151))*ddq_w + (cos(q_3r)*(Z417 + L7*Z139) - sin(q_3r)*(Z397 - L7*Z152))*ddq_torso + (L7*Z153*sin(q_3r))*ddq_1r + (L7*cos(q_3r))*ddq_2r + cos(q_3r)*(Z587 + L7*Z538 - L7*Z144*Z145) - sin(q_3r)*(Z583 - L7*Z541 + L7*Z143*Z144)
Z588 = + cos(q_3r)*(Z583 - L7*Z541 + L7*Z143*Z144) + sin(q_3r)*(Z587 + L7*Z538 - L7*Z144*Z145);
Z589 = - L7*Z143^2 - L7*Z145^2 - Z586 ;
Z590 =  + cos(q_3r)*(Z587 + L7*Z538 - L7*Z144*Z145) - sin(q_3r)*(Z583 - L7*Z541 + L7*Z143*Z144);

a6r = [Z420*ddx+Z421*ddpsi+Z422*ddq_imu+Z423*ddq_w+Z424*ddq_torso+Z425*ddq_1r+Z426*ddq_2r+Z588; 
    (-Z408)*ddx + (-Z409)*ddpsi + (-Z410)*ddq_imu + (-Z411)*ddq_w + (-Z412)*ddq_torso+Z589;
    Z427*ddx+Z428*ddpsi+Z429*ddq_imu+Z430*ddq_w+Z431*ddq_torso+Z432*ddq_1r+Z433*ddq_2r+Z590];

% this = '7r'; prev = '6r'; aLast = a6r; arphaLast = arpha6r; wLast = w6ri;
% a7r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_q3r])
% a7r =
%  
%                                                                                                                                                                                   (-Z420)*ddx + (-Z421)*ddpsi + (-Z422)*ddq_imu + (-Z423)*ddq_w + (-Z424)*ddq_torso + (-Z425)*ddq_1r + (-Z426)*ddq_2r - Z588
%  (Z408*cos(q_4r) - Z427*sin(q_4r))*ddx + (Z409*cos(q_4r) - Z428*sin(q_4r))*ddpsi + (Z410*cos(q_4r) - Z429*sin(q_4r))*ddq_imu + (Z411*cos(q_4r) - Z430*sin(q_4r))*ddq_w + (Z412*cos(q_4r) - Z431*sin(q_4r))*ddq_torso + (-Z432*sin(q_4r))*ddq_1r + (-Z433*sin(q_4r))*ddq_2r - Z589*cos(q_4r) - Z590*sin(q_4r)
%    (Z427*cos(q_4r) + Z408*sin(q_4r))*ddx + (Z428*cos(q_4r) + Z409*sin(q_4r))*ddpsi + (Z429*cos(q_4r) + Z410*sin(q_4r))*ddq_imu + (Z430*cos(q_4r) + Z411*sin(q_4r))*ddq_w + (Z431*cos(q_4r) + Z412*sin(q_4r))*ddq_torso + (Z432*cos(q_4r))*ddq_1r + (Z433*cos(q_4r))*ddq_2r + Z590*cos(q_4r) - Z589*sin(q_4r)
Z591 = - Z589*cos(q_4r) - Z590*sin(q_4r);
Z592 = + Z590*cos(q_4r) - Z589*sin(q_4r);
 
a7r = [(-Z420)*ddx + (-Z421)*ddpsi + (-Z422)*ddq_imu + (-Z423)*ddq_w + (-Z424)*ddq_torso + (-Z425)*ddq_1r + (-Z426)*ddq_2r- Z588;
    Z436*ddx+Z437*ddpsi+Z438*ddq_imu+Z439*ddq_w+Z440*ddq_torso+Z441*ddq_1r+Z442*ddq_2r+Z591; 
    Z443*ddx+Z444*ddpsi+Z445*ddq_imu+Z446*ddq_w+Z447*ddq_torso+Z448*ddq_1r+Z449*ddq_2r+Z592];
% 
% this = '8r'; prev = '7r'; aLast = a7r; arphaLast = arpha7r; wLast = w7ri;
% a8r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_q3r,ddq_q4r])
% a8r =
%  
%  (Z420*cos(q_5r) + Z443*sin(q_5r))*ddx + (sin(q_5r)*(Z444 + L8*Z157) + cos(q_5r)*(Z421 - L8*Z176))*ddpsi + (sin(q_5r)*(Z445 + L8*Z158) + cos(q_5r)*(Z422 - L8*Z177))*ddq_imu + (sin(q_5r)*(Z446 + L8*Z158) + cos(q_5r)*(Z423 - L8*Z177))*ddq_w + (sin(q_5r)*(Z447 + L8*Z159) + cos(q_5r)*(Z424 - L8*Z178))*ddq_torso + (sin(q_5r)*(Z448 + L8*Z160) + cos(q_5r)*(Z425 - L8*Z179))*ddq_1r + (sin(q_5r)*(Z449 + L8*Z161) + cos(q_5r)*(Z426 - L8*Z180))*ddq_2r + (-L8*Z181*cos(q_5r))*ddq_3r + (L8*sin(q_5r))*ddq_4r + cos(q_5r)*(Z588 - L8*Z545 + L8*Z167*Z168) + sin(q_5r)*(Z592 + L8*Z542 - L8*Z168*Z169)
%                                                                                                                                                                                                                                                                                                                                                                                                                                                           - L8*Z167^2 - L8*Z169^2 - Z591 - Z437*ddpsi - Z441*ddq_1r - Z442*ddq_2r - Z439*ddq_w - Z438*ddq_imu - Z440*ddq_torso - Z436*ddx
%   (Z443*cos(q_5r) - Z420*sin(q_5r))*ddx + (cos(q_5r)*(Z444 + L8*Z157) - sin(q_5r)*(Z421 - L8*Z176))*ddpsi + (cos(q_5r)*(Z445 + L8*Z158) - sin(q_5r)*(Z422 - L8*Z177))*ddq_imu + (cos(q_5r)*(Z446 + L8*Z158) - sin(q_5r)*(Z423 - L8*Z177))*ddq_w + (cos(q_5r)*(Z447 + L8*Z159) - sin(q_5r)*(Z424 - L8*Z178))*ddq_torso + (cos(q_5r)*(Z448 + L8*Z160) - sin(q_5r)*(Z425 - L8*Z179))*ddq_1r + (cos(q_5r)*(Z449 + L8*Z161) - sin(q_5r)*(Z426 - L8*Z180))*ddq_2r + (L8*Z181*sin(q_5r))*ddq_3r + (L8*cos(q_5r))*ddq_4r + cos(q_5r)*(Z592 + L8*Z542 - L8*Z168*Z169) - sin(q_5r)*(Z588 - L8*Z545 + L8*Z167*Z168)
 
Z593 = + cos(q_5r)*(Z588 - L8*Z545 + L8*Z167*Z168) + sin(q_5r)*(Z592 + L8*Z542 - L8*Z168*Z169);
Z594 = - L8*Z167^2 - L8*Z169^2 - Z591 ;
Z595 =  + cos(q_5r)*(Z592 + L8*Z542 - L8*Z168*Z169) - sin(q_5r)*(Z588 - L8*Z545 + L8*Z167*Z168);

a8r = [Z452*ddx+Z453*ddpsi+Z454*ddq_imu+Z455*ddq_w+Z456*ddq_torso+Z457*ddq_1r+Z458*ddq_2r+Z459*ddq_3r+Z460*ddq_4r+Z593; 
    (-Z436)*ddx + (-Z437)*ddpsi + (-Z438)*ddq_imu + (-Z439)*ddq_w + (-Z440)*ddq_torso + (-Z441)*ddq_1r + (-Z442)*ddq_2r+Z594;
    Z461*ddx+Z462*ddpsi+Z463*ddq_imu+Z464*ddq_w+Z465*ddq_torso+Z466*ddq_1r+Z467*ddq_2r+Z468*ddq_3r+Z469*ddq_4r+Z595];
% 
% this = '9r'; prev = '8r'; aLast = a8r; arphaLast = arpha8r; wLast = w8ri;
% a9r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_q3r,ddq_q4r,ddq_q5r])
% a9r =
%  
%                                                                                                                                                                                                                                       (-Z452)*ddx + (-Z453)*ddpsi + (-Z454)*ddq_imu + (-Z455)*ddq_w + (-Z456)*ddq_torso + (-Z457)*ddq_1r + (-Z458)*ddq_2r + (-Z459)*ddq_3r + (-Z460)*ddq_4r - Z593
%  (Z436*cos(q_6r) - Z461*sin(q_6r))*ddx + (Z437*cos(q_6r) - Z462*sin(q_6r))*ddpsi + (Z438*cos(q_6r) - Z463*sin(q_6r))*ddq_imu + (Z439*cos(q_6r) - Z464*sin(q_6r))*ddq_w + (Z440*cos(q_6r) - Z465*sin(q_6r))*ddq_torso + (Z441*cos(q_6r) - Z466*sin(q_6r))*ddq_1r + (Z442*cos(q_6r) - Z467*sin(q_6r))*ddq_2r + (-Z468*sin(q_6r))*ddq_3r + (-Z469*sin(q_6r))*ddq_4r - Z594*cos(q_6r) - Z595*sin(q_6r)
%    (Z461*cos(q_6r) + Z436*sin(q_6r))*ddx + (Z462*cos(q_6r) + Z437*sin(q_6r))*ddpsi + (Z463*cos(q_6r) + Z438*sin(q_6r))*ddq_imu + (Z464*cos(q_6r) + Z439*sin(q_6r))*ddq_w + (Z465*cos(q_6r) + Z440*sin(q_6r))*ddq_torso + (Z466*cos(q_6r) + Z441*sin(q_6r))*ddq_1r + (Z467*cos(q_6r) + Z442*sin(q_6r))*ddq_2r + (Z468*cos(q_6r))*ddq_3r + (Z469*cos(q_6r))*ddq_4r + Z595*cos(q_6r) - Z594*sin(q_6r)
Z596 =  - Z594*cos(q_6r) - Z595*sin(q_6r);
Z597 =  + Z595*cos(q_6r) - Z594*sin(q_6r);

a9r = [(-Z452)*ddx + (-Z453)*ddpsi + (-Z454)*ddq_imu + (-Z455)*ddq_w + (-Z456)*ddq_torso + (-Z457)*ddq_1r + (-Z458)*ddq_2r + (-Z459)*ddq_3r + (-Z460)*ddq_4r- Z593;
    Z472*ddx+Z473*ddpsi+Z474*ddq_imu+Z475*ddq_w+Z476*ddq_torso+Z477*ddq_1r+Z478*ddq_2r+Z479*ddq_3r+Z480*ddq_4r+Z596; 
    Z481*ddx+Z482*ddpsi+Z483*ddq_imu+Z484*ddq_w+Z485*ddq_torso+Z486*ddq_1r+Z487*ddq_2r+Z488*ddq_3r+Z489*ddq_4r+Z597];
% 
% this = '10r'; prev = '9r'; aLast = a9r; arphaLast = arpha9r; wLast = w9ri;
% a10r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_q3r,ddq_q4r,ddq_q5r,ddq_q6r])
% a10r =
%  
%   (Z452*cos(q_7r) + Z481*sin(q_7r))*ddx + (sin(q_7r)*(Z482 + L9*Z185) + cos(q_7r)*(Z453 - L9*Z210))*ddpsi + (sin(q_7r)*(Z483 + L9*Z186) + cos(q_7r)*(Z454 - L9*Z211))*ddq_imu + (sin(q_7r)*(Z484 + L9*Z186) + cos(q_7r)*(Z455 - L9*Z211))*ddq_w + (sin(q_7r)*(Z485 + L9*Z187) + cos(q_7r)*(Z456 - L9*Z212))*ddq_torso + (sin(q_7r)*(Z486 + L9*Z188) + cos(q_7r)*(Z457 - L9*Z213))*ddq_1r + (sin(q_7r)*(Z487 + L9*Z189) + cos(q_7r)*(Z458 - L9*Z214))*ddq_2r + (sin(q_7r)*(Z488 + L9*Z190) + cos(q_7r)*(Z459 - L9*Z215))*ddq_3r + (sin(q_7r)*(Z489 + L9*Z191) + cos(q_7r)*(Z460 - L9*Z216))*ddq_4r + (-L9*Z217*cos(q_7r))*ddq_5r + (L9*sin(q_7r))*ddq_6r + cos(q_7r)*(Z593 - L9*Z549 + L9*Z199*Z200) + sin(q_7r)*(Z597 + L9*Z546 - L9*Z200*Z201)
%  (Z452*sin(q_7r) - Z481*cos(q_7r))*ddx + (sin(q_7r)*(Z453 - L9*Z210) - cos(q_7r)*(Z482 + L9*Z185))*ddpsi + (sin(q_7r)*(Z454 - L9*Z211) - cos(q_7r)*(Z483 + L9*Z186))*ddq_imu + (sin(q_7r)*(Z455 - L9*Z211) - cos(q_7r)*(Z484 + L9*Z186))*ddq_w + (sin(q_7r)*(Z456 - L9*Z212) - cos(q_7r)*(Z485 + L9*Z187))*ddq_torso + (sin(q_7r)*(Z457 - L9*Z213) - cos(q_7r)*(Z486 + L9*Z188))*ddq_1r + (sin(q_7r)*(Z458 - L9*Z214) - cos(q_7r)*(Z487 + L9*Z189))*ddq_2r + (sin(q_7r)*(Z459 - L9*Z215) - cos(q_7r)*(Z488 + L9*Z190))*ddq_3r + (sin(q_7r)*(Z460 - L9*Z216) - cos(q_7r)*(Z489 + L9*Z191))*ddq_4r + (-L9*Z217*sin(q_7r))*ddq_5r + (-L9*cos(q_7r))*ddq_6r + sin(q_7r)*(Z593 - L9*Z549 + L9*Z199*Z200) - cos(q_7r)*(Z597 + L9*Z546 - L9*Z200*Z201)
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           - L9*Z199^2 - L9*Z201^2 - Z596 - Z473*ddpsi - Z477*ddq_1r - Z478*ddq_2r - Z479*ddq_3r - Z480*ddq_4r - Z475*ddq_w - Z474*ddq_imu - Z476*ddq_torso - Z472*ddx
Z598 =  + cos(q_7r)*(Z593 - L9*Z549 + L9*Z199*Z200) + sin(q_7r)*(Z597 + L9*Z546 - L9*Z200*Z201);
Z599 =  + sin(q_7r)*(Z593 - L9*Z549 + L9*Z199*Z200) - cos(q_7r)*(Z597 + L9*Z546 - L9*Z200*Z201);
Z600 = - L9*Z199^2 - L9*Z201^2 - Z596 ;
a10r = [Z492*ddx+Z493*ddpsi+Z494*ddq_imu+Z495*ddq_w+Z496*ddq_torso+Z497*ddq_1r+Z498*ddq_2r+Z499*ddq_3r+Z500*ddq_4r+Z501*ddq_5r+Z502*ddq_6r+Z598; 
    Z503*ddx+Z504*ddpsi+Z505*ddq_imu+Z506*ddq_w+Z507*ddq_torso+Z508*ddq_1r+Z509*ddq_2r+Z510*ddq_3r+Z511*ddq_4r+Z512*ddq_5r+Z513*ddq_6r+Z599; 
    (-Z472)*ddx + (-Z473)*ddpsi + (-Z474)*ddq_imu + (-Z475)*ddq_w + (-Z476)*ddq_torso + (-Z477)*ddq_1r + (-Z478)*ddq_2r + (-Z479)*ddq_3r + (-Z480)*ddq_4r+Z600];

%% Inertial Forces

% Wheels
% syms mw real
% maGL = collect(mw*aGL,[ddx,ddpsi])
% maGR = collect(mw*aGR,[ddx,ddpsi])
% 
% syms YYw ZZw real
% Iw = [ZZw 0 0; 0 YYw 0; 0 0 ZZw];
% dHGL = collect(Iw*alphaL + cross(wLi,Iw*wLi),[ddx,ddpsi])
% dHGR = collect(Iw*alphaR + cross(wRi,Iw*wRi),[ddx,ddpsi])
% 
% % Tree
% keys = {'1', '2', '3', '4l', '5l', '6l', '7l', '8l', '8l', '10l', ...
%     '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% aa = {a1, a2, a3, a4l, a5l, a6l, a7l, a8l, a9l, a10l, ...
%     a4r, a5r, a6r, a7r, a8r, a9r, a10r};
% alphaa = {alpha1, alpha2, alpha3, alpha4l, alpha5l, alpha6l, alpha7l, alpha8l, alpha9l, alpha10l, ...
%     alpha4r, alpha5r, alpha6r, alpha7r, alpha8r, alpha9r, alpha10r};
% ww = {w1i, w2i, w3i, w4li, w5li, w6li, w7li, w8li, w9li, w10li, ...
%     w4ri, w5ri, w6ri, w7ri, w8ri, w9ri, w10ri};
% for i=1:17
%     this=keys{i}; a=aa{i}; alpha=alphaa{i}; w=ww{i};
%     m=mass(f,this); mS=mCOM(f,this); J=inertiaMat(f,this);
%     display(this);
%     maG = collect(m*a + cross(alpha,mS) + cross(w,cross(w,mS)),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l,ddq_7l,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r])
%     dHnew = collect(cross(mS,a) + J*alpha + cross(w,J*w),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l,ddq_7l,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r])
% end

% maGL =
%  
%  (Z4*mw)*ddx + (Z553*mw)*ddpsi
%                        Z554*mw
%  (Z3*mw)*ddx + (Z555*mw)*ddpsi
syms mw YYw ZZw real
syms m_1 MX_1 MY_1 MZ_1 XX_1 XY_1 XZ_1 YY_1 YZ_1 ZZ_1 real
syms m_2 MX_2 MY_2 MZ_2 XX_2 XY_2 XZ_2 YY_2 YZ_2 ZZ_2 real
syms m_3 MX_3 MY_3 MZ_3 XX_3 XY_3 XZ_3 YY_3 YZ_3 ZZ_3 real
syms m_4l MX_4l MY_4l MZ_4l XX_4l XY_4l XZ_4l YY_4l YZ_4l ZZ_4l real
syms m_5l MX_5l MY_5l MZ_5l XX_5l XY_5l XZ_5l YY_5l YZ_5l ZZ_5l real
syms m_6l MX_6l MY_6l MZ_6l XX_6l XY_6l XZ_6l YY_6l YZ_6l ZZ_6l real
syms m_7l MX_7l MY_7l MZ_7l XX_7l XY_7l XZ_7l YY_7l YZ_7l ZZ_7l real
syms m_8l MX_8l MY_8l MZ_8l XX_8l XY_8l XZ_8l YY_8l YZ_8l ZZ_8l real
syms m_9l MX_9l MY_9l MZ_9l XX_9l XY_9l XZ_9l YY_9l YZ_9l ZZ_9l real
syms m_10l MX_10l MY_10l MZ_10l XX_10l XY_10l XZ_10l YY_10l YZ_10l ZZ_10l real
syms m_4r MX_4r MY_4r MZ_4r XX_4r XY_4r XZ_4r YY_4r YZ_4r ZZ_4r real
syms m_5r MX_5r MY_5r MZ_5r XX_5r XY_5r XZ_5r YY_5r YZ_5r ZZ_5r real
syms m_6r MX_6r MY_6r MZ_6r XX_6r XY_6r XZ_6r YY_6r YZ_6r ZZ_6r real
syms m_7r MX_7r MY_7r MZ_7r XX_7r XY_7r XZ_7r YY_7r YZ_7r ZZ_7r real
syms m_8r MX_8r MY_8r MZ_8r XX_8r XY_8r XZ_8r YY_8r YZ_8r ZZ_8r real
syms m_9r MX_9r MY_9r MZ_9r XX_9r XY_9r XZ_9r YY_9r YZ_9r ZZ_9r real
syms m_10r MX_10r MY_10r MZ_10r XX_10r XY_10r XZ_10r YY_10r YZ_10r ZZ_10r real

Z601 = (Z4*mw);
Z602 = + (Z553*mw);
Z603 =  Z554*mw;
Z604 = (Z3*mw);
Z605 = + (Z555*mw);
maGL = [Z601*ddx+Z602*ddpsi;Z603; Z604*ddx+Z605*ddpsi]; 
 
% maGR =
%  
%  (Z9*mw)*ddx + (Z556*mw)*ddpsi
%                        Z557*mw
%  (Z8*mw)*ddx + (Z558*mw)*ddpsi
Z606 = (Z9*mw);
Z607 =+ (Z556*mw);
Z608 =  Z557*mw;
Z609 = (Z8*mw);
Z610 = + (Z558*mw);
maGR = [Z606*ddx+Z607*ddpsi;Z608; Z609*ddx+Z610*ddpsi]; 
 
% dHGL =
%  
%  (-Z3*ZZw)*ddpsi + Z514*ZZw - YYw*Z6*Z7 + Z6*Z7*ZZw
%                      (YYw*Z1)*ddx + (-YYw*Z2)*ddpsi
%   (Z4*ZZw)*ddpsi + Z515*ZZw + YYw*Z5*Z6 - Z5*Z6*ZZw
Z611 = (-Z3*ZZw);
Z612 = + Z514*ZZw - YYw*Z6*Z7 + Z6*Z7*ZZw;
Z613 = (YYw*Z1);
Z614 = + (-YYw*Z2);
Z615 = (Z4*ZZw);
Z616 = + Z515*ZZw + YYw*Z5*Z6 - Z5*Z6*ZZw;
dHGL = [Z611*ddpsi+Z612; Z613*ddx+Z614*ddpsi; Z615*ddpsi+Z616];
 
 
% dHGR =
%  
%  (-Z8*ZZw)*ddpsi + Z516*ZZw - YYw*Z11*Z12 + Z11*Z12*ZZw
%                           (YYw*Z1)*ddx + (YYw*Z2)*ddpsi
%   (Z4*ZZw)*ddpsi + Z517*ZZw + YYw*Z10*Z11 - Z10*Z11*ZZw
Z617 = (-Z8*ZZw); 
Z618 = + Z516*ZZw - YYw*Z11*Z12 + Z11*Z12*ZZw;
Z619 = (YYw*Z1);
Z620 = + (YYw*Z2);
Z621 = (Z4*ZZw);
Z622 = + Z517*ZZw + YYw*Z10*Z11 - Z10*Z11*ZZw;
dHGR = [Z617*ddpsi+Z618; Z619*ddx+Z620*ddpsi; Z621*ddpsi+Z622];

 
% maG1 = 
%
%      (MZ_1*Z13 - MY_1*Z14)*ddpsi + (MZ_1*Z518 - MY_1*Z519 - Z15*(MX_1*Z15 + MY_1*dq_imu) - Z16*(MX_1*Z16 + MZ_1*dq_imu) - dpsi*m_1)
%      (Z14*m_1)*ddx + (MX_1*Z14)*ddpsi + MZ_1*ddq_imu + (MX_1*Z519 - Z16*(MY_1*Z16 - MZ_1*Z15) - dq_imu*(MX_1*Z15 + MY_1*dq_imu))
%      (-Z13*m_1)*ddx + (-MX_1*Z13)*ddpsi + (-MY_1)*ddq_imu + (Z15*(MY_1*Z16 - MZ_1*Z15) - MX_1*Z518 - dq_imu*(MX_1*Z16 + MZ_1*dq_imu))
Z623 = MZ_1*Z13 - MY_1*Z14;
Z624 = MZ_1*Z518 - MY_1*Z519 - Z15*(MX_1*Z15 + MY_1*dq_imu) - Z16*(MX_1*Z16 + MZ_1*dq_imu) - dpsi*m_1;
 
Z625 = Z14*m_1;
Z626 = MX_1*Z14;
Z627 = MZ_1;
Z628 = MX_1*Z519 - Z16*(MY_1*Z16 - MZ_1*Z15) - dq_imu*(MX_1*Z15 + MY_1*dq_imu);
 
Z629 = -Z13*m_1;
Z630 = -MX_1*Z13;
Z631 = -MY_1;
Z632 = Z15*(MY_1*Z16 - MZ_1*Z15) - MX_1*Z518 - dq_imu*(MX_1*Z16 + MZ_1*dq_imu);
 
maG1 = [Z623*ddpsi+Z624;
    Z625*ddx+Z626*ddpsi+Z627*ddq_imu+Z628;
    Z629*ddx+Z630*ddpsi+Z631*ddq_imu+Z632];
 
% dHnew1 = 
%
%      (MZ_1*Z13 - MY_1*Z14)*ddpsi + (MZ_1*Z518 - MY_1*Z519 - Z15*(MX_1*Z15 + MY_1*dq_imu) - Z16*(MX_1*Z16 + MZ_1*dq_imu) - dpsi*m_1)
%      (Z14*m_1)*ddx + (MX_1*Z14)*ddpsi + MZ_1*ddq_imu + (MX_1*Z519 - Z16*(MY_1*Z16 - MZ_1*Z15) - dq_imu*(MX_1*Z15 + MY_1*dq_imu))
%      (-Z13*m_1)*ddx + (-MX_1*Z13)*ddpsi + (-MY_1)*ddq_imu + (Z15*(MY_1*Z16 - MZ_1*Z15) - MX_1*Z518 - dq_imu*(MX_1*Z16 + MZ_1*dq_imu))
Z633 = - MY_1*Z13 - MZ_1*Z14;
Z634 = XY_1*Z13 + XZ_1*Z14;
Z635 = -XX_1;
Z636 = XY_1*Z518 + XZ_1*Z519 - Z16*(YY_1*Z15 + YZ_1*Z16 - XY_1*dq_imu) + Z15*(YZ_1*Z15 + Z16*ZZ_1 - XZ_1*dq_imu);
 
Z637 = MX_1*Z13;
Z638 = YY_1*Z13 + YZ_1*Z14;
Z639 = -XY_1;
Z640 = YY_1*Z518 - MZ_1*dpsi + YZ_1*Z519 + Z16*(XY_1*Z15 + XZ_1*Z16 - XX_1*dq_imu) + dq_imu*(YZ_1*Z15 + Z16*ZZ_1 - XZ_1*dq_imu);
 
Z641 = MX_1*Z14;
Z642 = YZ_1*Z13 + Z14*ZZ_1;
Z643 = -XZ_1;
Z644 = MY_1*dpsi + YZ_1*Z518 + Z519*ZZ_1 - Z15*(XY_1*Z15 + XZ_1*Z16 - XX_1*dq_imu) - dq_imu*(YY_1*Z15 + YZ_1*Z16 - XY_1*dq_imu);
 
dHnew1 = [Z633*ddx+Z634*ddpsi+Z635*ddq_imu+Z636;
    Z637*ddx+Z638*ddpsi+Z639*ddq_imu+Z640;
    Z641*ddx+Z642*ddpsi+Z643*ddq_imu+Z644];
 
 
% maG2 = 
%
%      (MZ_2*Z20 - MY_2*Z21 + Z249*m_2)*ddpsi + (MZ_2*Z520 - MY_2*Z521 - Z18*(MX_2*Z18 - MY_2*Z17) - Z19*(MX_2*Z19 - MZ_2*Z17) + Z559*m_2)
%      (Z250*m_2)*ddx + (MX_2*Z21)*ddpsi + (MZ_2 + Z251*m_2)*ddq_imu + MZ_2*ddq_w + (MX_2*Z521 + Z17*(MX_2*Z18 - MY_2*Z17) - Z19*(MY_2*Z19 - MZ_2*Z18) + Z560*m_2)
%      (Z252*m_2)*ddx + (-MX_2*Z20)*ddpsi + (Z253*m_2 - MY_2)*ddq_imu + (-MY_2)*ddq_w + (Z17*(MX_2*Z19 - MZ_2*Z17) - MX_2*Z520 + Z18*(MY_2*Z19 - MZ_2*Z18) + Z561*m_2)
Z645 = MZ_2*Z20 - MY_2*Z21 + Z249*m_2;
Z646 = MZ_2*Z520 - MY_2*Z521 - Z18*(MX_2*Z18 - MY_2*Z17) - Z19*(MX_2*Z19 - MZ_2*Z17) + Z559*m_2;
 
Z647 = Z250*m_2;
Z648 = MX_2*Z21;
Z649 = MZ_2 + Z251*m_2;
Z650 = MZ_2;
Z651 = MX_2*Z521 + Z17*(MX_2*Z18 - MY_2*Z17) - Z19*(MY_2*Z19 - MZ_2*Z18) + Z560*m_2;
 
Z652 = Z252*m_2;
Z653 = -MX_2*Z20;
Z654 = Z253*m_2 - MY_2;
Z655 = -MY_2;
Z656 = Z17*(MX_2*Z19 - MZ_2*Z17) - MX_2*Z520 + Z18*(MY_2*Z19 - MZ_2*Z18) + Z561*m_2;
 
maG2 = [Z645*ddpsi+Z646;
    Z647*ddx+Z648*ddpsi+Z649*ddq_imu+Z650*ddq_w+Z651;
    Z652*ddx+Z653*ddpsi+Z654*ddq_imu+Z655*ddq_w+Z656];
 
% dHnew2 = 
%
%      (MZ_2*Z20 - MY_2*Z21 + Z249*m_2)*ddpsi + (MZ_2*Z520 - MY_2*Z521 - Z18*(MX_2*Z18 - MY_2*Z17) - Z19*(MX_2*Z19 - MZ_2*Z17) + Z559*m_2)
%      (Z250*m_2)*ddx + (MX_2*Z21)*ddpsi + (MZ_2 + Z251*m_2)*ddq_imu + MZ_2*ddq_w + (MX_2*Z521 + Z17*(MX_2*Z18 - MY_2*Z17) - Z19*(MY_2*Z19 - MZ_2*Z18) + Z560*m_2)
%      (Z252*m_2)*ddx + (-MX_2*Z20)*ddpsi + (Z253*m_2 - MY_2)*ddq_imu + (-MY_2)*ddq_w + (Z17*(MX_2*Z19 - MZ_2*Z17) - MX_2*Z520 + Z18*(MY_2*Z19 - MZ_2*Z18) + Z561*m_2)
Z657 = MY_2*Z252 - MZ_2*Z250;
Z658 = XY_2*Z20 + XZ_2*Z21;
Z659 = MY_2*Z253 - XX_2 - MZ_2*Z251;
Z660 = -XX_2;
Z661 = MY_2*Z561 - MZ_2*Z560 + XY_2*Z520 + XZ_2*Z521 - Z19*(XY_2*Z17 + YY_2*Z18 + YZ_2*Z19) + Z18*(XZ_2*Z17 + YZ_2*Z18 + Z19*ZZ_2);
 
Z662 = -MX_2*Z252;
Z663 = MZ_2*Z249 + YY_2*Z20 + YZ_2*Z21;
Z664 = - XY_2 - MX_2*Z253;
Z665 = -XY_2;
Z666 = MZ_2*Z559 - MX_2*Z561 + YY_2*Z520 + YZ_2*Z521 + Z19*(XX_2*Z17 + XY_2*Z18 + XZ_2*Z19) - Z17*(XZ_2*Z17 + YZ_2*Z18 + Z19*ZZ_2);
 
Z667 = MX_2*Z250;
Z668 = YZ_2*Z20 - MY_2*Z249 + Z21*ZZ_2;
Z669 = MX_2*Z251 - XZ_2;
Z670 = -XZ_2;
Z671 = MX_2*Z560 - MY_2*Z559 + YZ_2*Z520 + Z521*ZZ_2 - Z18*(XX_2*Z17 + XY_2*Z18 + XZ_2*Z19) + Z17*(XY_2*Z17 + YY_2*Z18 + YZ_2*Z19);
 
dHnew2 = [Z657*ddx+Z658*ddpsi+Z659*ddq_imu+Z660*ddq_w+Z661;
    Z662*ddx+Z663*ddpsi+Z664*ddq_imu+Z665*ddq_w+Z666;
    Z667*ddx+Z668*ddpsi+Z669*ddq_imu+Z670*ddq_w+Z671];
 
 
% maG3 = 
%
%      (Z257*m_3)*ddx + (MZ_3*Z20 - MY_3*Z28 + Z258*m_3)*ddpsi + (Z259*m_3 - MY_3*Z27)*ddq_imu + (Z260*m_3 - MY_3*Z27)*ddq_w + (Z562*m_3 - Z23*(MX_3*Z23 - MY_3*Z22) - Z24*(MX_3*Z24 - MZ_3*Z22) - MY_3*Z523 + MZ_3*(Z520 - ddq_torso))
%      (Z250*m_3)*ddx + (MX_3*Z28 - MZ_3*Z26)*ddpsi + (MX_3*Z27 - MZ_3*Z25 + Z261*m_3)*ddq_imu + (MX_3*Z27 - MZ_3*Z25 + L4*m_3)*ddq_w + (MX_3*Z523 - MZ_3*Z522 + Z22*(MX_3*Z23 - MY_3*Z22) - Z24*(MY_3*Z24 - MZ_3*Z23) + Z563*m_3)
%      (Z262*m_3)*ddx + (MY_3*Z26 - MX_3*Z20 + Z263*m_3)*ddpsi + (MY_3*Z25 + Z264*m_3)*ddq_imu + (MY_3*Z25 + Z265*m_3)*ddq_w + (MY_3*Z522 + Z22*(MX_3*Z24 - MZ_3*Z22) + Z23*(MY_3*Z24 - MZ_3*Z23) + Z564*m_3 - MX_3*(Z520 - ddq_torso))
Z672 = Z257*m_3;
Z673 = MZ_3*Z20 - MY_3*Z28 + Z258*m_3;
Z674 = Z259*m_3 - MY_3*Z27;
Z675 = Z260*m_3 - MY_3*Z27;
Z676 = -MZ_3;
Z677 = MZ_3*Z520 - MY_3*Z523 + Z562*m_3 - MX_3*Z23^2 - MX_3*Z24^2 + MY_3*Z22*Z23 + MZ_3*Z22*Z24;
 
Z678 = Z250*m_3;
Z679 = MX_3*Z28 - MZ_3*Z26;
Z680 = MX_3*Z27 - MZ_3*Z25 + Z261*m_3;
Z681 = MX_3*Z27 - MZ_3*Z25 + L4*m_3;
Z682 = MX_3*Z523 - MZ_3*Z522 + Z22*(MX_3*Z23 - MY_3*Z22) - Z24*(MY_3*Z24 - MZ_3*Z23) + Z563*m_3;
 
Z683 = Z262*m_3;
Z684 = MY_3*Z26 - MX_3*Z20 + Z263*m_3;
Z685 = MY_3*Z25 + Z264*m_3;
Z686 = MY_3*Z25 + Z265*m_3;
Z687 = MX_3;
Z688 = MY_3*Z522 - MX_3*Z520 + Z564*m_3 - MZ_3*Z22^2 - MZ_3*Z23^2 + MX_3*Z22*Z24 + MY_3*Z23*Z24;
 
maG3 = [Z672*ddx+Z673*ddpsi+Z674*ddq_imu+Z675*ddq_w+Z676*ddq_torso+Z677;
    Z678*ddx+Z679*ddpsi+Z680*ddq_imu+Z681*ddq_w+Z682;
    Z683*ddx+Z684*ddpsi+Z685*ddq_imu+Z686*ddq_w+Z687*ddq_torso+Z688];
 
% dHnew3 = 
%
%      (Z257*m_3)*ddx + (MZ_3*Z20 - MY_3*Z28 + Z258*m_3)*ddpsi + (Z259*m_3 - MY_3*Z27)*ddq_imu + (Z260*m_3 - MY_3*Z27)*ddq_w + (Z562*m_3 - Z23*(MX_3*Z23 - MY_3*Z22) - Z24*(MX_3*Z24 - MZ_3*Z22) - MY_3*Z523 + MZ_3*(Z520 - ddq_torso))
%      (Z250*m_3)*ddx + (MX_3*Z28 - MZ_3*Z26)*ddpsi + (MX_3*Z27 - MZ_3*Z25 + Z261*m_3)*ddq_imu + (MX_3*Z27 - MZ_3*Z25 + L4*m_3)*ddq_w + (MX_3*Z523 - MZ_3*Z522 + Z22*(MX_3*Z23 - MY_3*Z22) - Z24*(MY_3*Z24 - MZ_3*Z23) + Z563*m_3)
%      (Z262*m_3)*ddx + (MY_3*Z26 - MX_3*Z20 + Z263*m_3)*ddpsi + (MY_3*Z25 + Z264*m_3)*ddq_imu + (MY_3*Z25 + Z265*m_3)*ddq_w + (MY_3*Z522 + Z22*(MX_3*Z24 - MZ_3*Z22) + Z23*(MY_3*Z24 - MZ_3*Z23) + Z564*m_3 - MX_3*(Z520 - ddq_torso))
Z689 = MY_3*Z262 - MZ_3*Z250;
Z690 = MY_3*Z263 + XX_3*Z26 + XY_3*Z20 + XZ_3*Z28;
Z691 = MY_3*Z264 - MZ_3*Z261 + XX_3*Z25 + XZ_3*Z27;
Z692 = MY_3*Z265 + XX_3*Z25 + XZ_3*Z27 - L4*MZ_3;
Z693 = -XY_3;
Z694 = MY_3*Z564 - MZ_3*Z563 + XX_3*Z522 + XY_3*Z520 + XZ_3*Z523 + YZ_3*Z23^2 - YZ_3*Z24^2 - XY_3*Z22*Z24 + XZ_3*Z22*Z23 - YY_3*Z23*Z24 + Z23*Z24*ZZ_3;
 
Z695 = MZ_3*Z257 - MX_3*Z262;
Z696 = MZ_3*Z258 - MX_3*Z263 + XY_3*Z26 + YY_3*Z20 + YZ_3*Z28;
Z697 = MZ_3*Z259 - MX_3*Z264 + XY_3*Z25 + YZ_3*Z27;
Z698 = MZ_3*Z260 - MX_3*Z265 + XY_3*Z25 + YZ_3*Z27;
Z699 = -YY_3;
Z700 = MZ_3*Z562 - MX_3*Z564 + XY_3*Z522 + YY_3*Z520 + YZ_3*Z523 - XZ_3*Z22^2 + XZ_3*Z24^2 + XX_3*Z22*Z24 + XY_3*Z23*Z24 - YZ_3*Z22*Z23 - Z22*Z24*ZZ_3;
 
Z701 = MX_3*Z250 - MY_3*Z257;
Z702 = XZ_3*Z26 - MY_3*Z258 + YZ_3*Z20 + Z28*ZZ_3;
Z703 = MX_3*Z261 - MY_3*Z259 + XZ_3*Z25 + Z27*ZZ_3;
Z704 = XZ_3*Z25 - MY_3*Z260 + Z27*ZZ_3 + L4*MX_3;
Z705 = -YZ_3;
Z706 = MX_3*Z563 - MY_3*Z562 + XZ_3*Z522 + YZ_3*Z520 + Z523*ZZ_3 + XY_3*Z22^2 - XY_3*Z23^2 - XX_3*Z22*Z23 - XZ_3*Z23*Z24 + YY_3*Z22*Z23 + YZ_3*Z22*Z24;
 
dHnew3 = [Z689*ddx+Z690*ddpsi+Z691*ddq_imu+Z692*ddq_w+Z693*ddq_torso+Z694;
    Z695*ddx+Z696*ddpsi+Z697*ddq_imu+Z698*ddq_w+Z699*ddq_torso+Z700;
    Z701*ddx+Z702*ddpsi+Z703*ddq_imu+Z704*ddq_w+Z705*ddq_torso+Z706];
 
 
% maG4l = 
%
%      (Z269*m_4l)*ddx + (MZ_4l*Z26 - MY_4l*Z35 + Z270*m_4l)*ddpsi + (MZ_4l*Z25 - MY_4l*Z36 + Z271*m_4l)*ddq_imu + (MZ_4l*Z25 - MY_4l*Z36 + Z272*m_4l)*ddq_w + (-MZ_4l)*ddq_1l + (MZ_4l*Z522 - Z30*(MX_4l*Z30 - MY_4l*Z29) - Z31*(MX_4l*Z31 - MZ_4l*Z29) - MY_4l*(Z525 + Z37*ddq_torso) + m_4l*(Z565 + Z273*ddq_torso))
%      (Z257*m_4l)*ddx + (MX_4l*Z35 - MZ_4l*Z32 + Z274*m_4l)*ddpsi + (MX_4l*Z36 - MZ_4l*Z33 + Z275*m_4l)*ddq_imu + (MX_4l*Z36 - MZ_4l*Z33 + Z276*m_4l)*ddq_w + (Z29*(MX_4l*Z30 - MY_4l*Z29) - Z31*(MY_4l*Z31 - MZ_4l*Z30) + Z566*m_4l + MX_4l*(Z525 + Z37*ddq_torso) - MZ_4l*(Z524 + Z34*ddq_torso))
%      (Z277*m_4l)*ddx + (MY_4l*Z32 - MX_4l*Z26 + Z278*m_4l)*ddpsi + (MY_4l*Z33 - MX_4l*Z25 + Z279*m_4l)*ddq_imu + (MY_4l*Z33 - MX_4l*Z25 + Z280*m_4l)*ddq_w + MX_4l*ddq_1l + (Z29*(MX_4l*Z31 - MZ_4l*Z29) - MX_4l*Z522 + Z30*(MY_4l*Z31 - MZ_4l*Z30) + MY_4l*(Z524 + Z34*ddq_torso) + m_4l*(Z567 + Z281*ddq_torso))
Z707 = Z269*m_4l;
Z708 = MZ_4l*Z26 - MY_4l*Z35 + Z270*m_4l;
Z709 = MZ_4l*Z25 - MY_4l*Z36 + Z271*m_4l;
Z710 = MZ_4l*Z25 - MY_4l*Z36 + Z272*m_4l;
Z711 = Z273*m_4l - MY_4l*Z37;
Z712 = -MZ_4l;
Z713 = MZ_4l*Z522 - MY_4l*Z525 + Z565*m_4l - MX_4l*Z30^2 - MX_4l*Z31^2 + MY_4l*Z29*Z30 + MZ_4l*Z29*Z31;
 
Z714 = Z257*m_4l;
Z715 = MX_4l*Z35 - MZ_4l*Z32 + Z274*m_4l;
Z716 = MX_4l*Z36 - MZ_4l*Z33 + Z275*m_4l;
Z717 = MX_4l*Z36 - MZ_4l*Z33 + Z276*m_4l;
Z718 = MX_4l*Z37 - MZ_4l*Z34;
Z719 = MX_4l*Z525 - MZ_4l*Z524 + Z566*m_4l - MY_4l*Z29^2 - MY_4l*Z31^2 + MX_4l*Z29*Z30 + MZ_4l*Z30*Z31;
 
Z720 = Z277*m_4l;
Z721 = MY_4l*Z32 - MX_4l*Z26 + Z278*m_4l;
Z722 = MY_4l*Z33 - MX_4l*Z25 + Z279*m_4l;
Z723 = MY_4l*Z33 - MX_4l*Z25 + Z280*m_4l;
Z724 = MY_4l*Z34 + Z281*m_4l;
Z725 = MX_4l;
Z726 = MY_4l*Z524 - MX_4l*Z522 + Z567*m_4l - MZ_4l*Z29^2 - MZ_4l*Z30^2 + MX_4l*Z29*Z31 + MY_4l*Z30*Z31;
 
maG4l = [Z707*ddx+Z708*ddpsi+Z709*ddq_imu+Z710*ddq_w+Z711*ddq_torso+Z712*ddq_1l+Z713;
    Z714*ddx+Z715*ddpsi+Z716*ddq_imu+Z717*ddq_w+Z718*ddq_torso+Z719;
    Z720*ddx+Z721*ddpsi+Z722*ddq_imu+Z723*ddq_w+Z724*ddq_torso+Z725*ddq_1l+Z726];
 
% dHnew4l = 
%
%      (Z269*m_4l)*ddx + (MZ_4l*Z26 - MY_4l*Z35 + Z270*m_4l)*ddpsi + (MZ_4l*Z25 - MY_4l*Z36 + Z271*m_4l)*ddq_imu + (MZ_4l*Z25 - MY_4l*Z36 + Z272*m_4l)*ddq_w + (-MZ_4l)*ddq_1l + (MZ_4l*Z522 - Z30*(MX_4l*Z30 - MY_4l*Z29) - Z31*(MX_4l*Z31 - MZ_4l*Z29) - MY_4l*(Z525 + Z37*ddq_torso) + m_4l*(Z565 + Z273*ddq_torso))
%      (Z257*m_4l)*ddx + (MX_4l*Z35 - MZ_4l*Z32 + Z274*m_4l)*ddpsi + (MX_4l*Z36 - MZ_4l*Z33 + Z275*m_4l)*ddq_imu + (MX_4l*Z36 - MZ_4l*Z33 + Z276*m_4l)*ddq_w + (Z29*(MX_4l*Z30 - MY_4l*Z29) - Z31*(MY_4l*Z31 - MZ_4l*Z30) + Z566*m_4l + MX_4l*(Z525 + Z37*ddq_torso) - MZ_4l*(Z524 + Z34*ddq_torso))
%      (Z277*m_4l)*ddx + (MY_4l*Z32 - MX_4l*Z26 + Z278*m_4l)*ddpsi + (MY_4l*Z33 - MX_4l*Z25 + Z279*m_4l)*ddq_imu + (MY_4l*Z33 - MX_4l*Z25 + Z280*m_4l)*ddq_w + MX_4l*ddq_1l + (Z29*(MX_4l*Z31 - MZ_4l*Z29) - MX_4l*Z522 + Z30*(MY_4l*Z31 - MZ_4l*Z30) + MY_4l*(Z524 + Z34*ddq_torso) + m_4l*(Z567 + Z281*ddq_torso))
Z727 = MY_4l*Z277 - MZ_4l*Z257;
Z728 = MY_4l*Z278 - MZ_4l*Z274 + XX_4l*Z32 + XY_4l*Z26 + XZ_4l*Z35;
Z729 = MY_4l*Z279 - MZ_4l*Z275 + XX_4l*Z33 + XY_4l*Z25 + XZ_4l*Z36;
Z730 = MY_4l*Z280 - MZ_4l*Z276 + XX_4l*Z33 + XY_4l*Z25 + XZ_4l*Z36;
Z731 = MY_4l*Z281 + XX_4l*Z34 + XZ_4l*Z37;
Z732 = -XY_4l;
Z733 = MY_4l*Z567 - MZ_4l*Z566 + XX_4l*Z524 + XY_4l*Z522 + XZ_4l*Z525 + YZ_4l*Z30^2 - YZ_4l*Z31^2 - XY_4l*Z29*Z31 + XZ_4l*Z29*Z30 - YY_4l*Z30*Z31 + Z30*Z31*ZZ_4l;
 
Z734 = MZ_4l*Z269 - MX_4l*Z277;
Z735 = MZ_4l*Z270 - MX_4l*Z278 + XY_4l*Z32 + YY_4l*Z26 + YZ_4l*Z35;
Z736 = MZ_4l*Z271 - MX_4l*Z279 + XY_4l*Z33 + YY_4l*Z25 + YZ_4l*Z36;
Z737 = MZ_4l*Z272 - MX_4l*Z280 + XY_4l*Z33 + YY_4l*Z25 + YZ_4l*Z36;
Z738 = MZ_4l*Z273 - MX_4l*Z281 + XY_4l*Z34 + YZ_4l*Z37;
Z739 = -YY_4l;
Z740 = MZ_4l*Z565 - MX_4l*Z567 + XY_4l*Z524 + YY_4l*Z522 + YZ_4l*Z525 - XZ_4l*Z29^2 + XZ_4l*Z31^2 + XX_4l*Z29*Z31 + XY_4l*Z30*Z31 - YZ_4l*Z29*Z30 - Z29*Z31*ZZ_4l;
 
Z741 = MX_4l*Z257 - MY_4l*Z269;
Z742 = MX_4l*Z274 - MY_4l*Z270 + XZ_4l*Z32 + YZ_4l*Z26 + Z35*ZZ_4l;
Z743 = MX_4l*Z275 - MY_4l*Z271 + XZ_4l*Z33 + YZ_4l*Z25 + Z36*ZZ_4l;
Z744 = MX_4l*Z276 - MY_4l*Z272 + XZ_4l*Z33 + YZ_4l*Z25 + Z36*ZZ_4l;
Z745 = XZ_4l*Z34 - MY_4l*Z273 + Z37*ZZ_4l;
Z746 = -YZ_4l;
Z747 = MX_4l*Z566 - MY_4l*Z565 + XZ_4l*Z524 + YZ_4l*Z522 + Z525*ZZ_4l + XY_4l*Z29^2 - XY_4l*Z30^2 - XX_4l*Z29*Z30 - XZ_4l*Z30*Z31 + YY_4l*Z29*Z30 + YZ_4l*Z29*Z31;
 
dHnew4l = [Z727*ddx+Z728*ddpsi+Z729*ddq_imu+Z730*ddq_w+Z731*ddq_torso+Z732*ddq_1l+Z733;
    Z734*ddx+Z735*ddpsi+Z736*ddq_imu+Z737*ddq_w+Z738*ddq_torso+Z739*ddq_1l+Z740;
    Z741*ddx+Z742*ddpsi+Z743*ddq_imu+Z744*ddq_w+Z745*ddq_torso+Z746*ddq_1l+Z747];
 
 
% maG5l = 
%
%      (-Z269*m_5l)*ddx + (MZ_5l*Z41 - MY_5l*Z45 - Z270*m_5l)*ddpsi + (MZ_5l*Z42 - MY_5l*Z46 - Z271*m_5l)*ddq_imu + (MZ_5l*Z42 - MY_5l*Z46 - Z272*m_5l)*ddq_w + (MZ_5l*Z44 - MY_5l*Z48)*ddq_1l + (MZ_5l*(Z526 + Z43*ddq_torso) - Z40*(MX_5l*Z40 - MZ_5l*Z38) - MY_5l*(Z527 + Z47*ddq_torso) - Z39*(MX_5l*Z39 - MY_5l*Z38) - m_5l*(Z565 + Z273*ddq_torso))
%      (Z284*m_5l)*ddx + (MX_5l*Z45 + MZ_5l*Z32 + Z285*m_5l)*ddpsi + (MX_5l*Z46 + MZ_5l*Z33 + Z286*m_5l)*ddq_imu + (MX_5l*Z46 + MZ_5l*Z33 + Z287*m_5l)*ddq_w + (MX_5l*Z48)*ddq_1l + MZ_5l*ddq_2l + (Z38*(MX_5l*Z39 - MY_5l*Z38) - Z40*(MY_5l*Z40 - MZ_5l*Z39) + MX_5l*(Z527 + Z47*ddq_torso) + MZ_5l*(Z524 + Z34*ddq_torso) + m_5l*(Z568 + Z288*ddq_torso))
%      (Z289*m_5l)*ddx + (Z290*m_5l - MY_5l*Z32 - MX_5l*Z41)*ddpsi + (Z291*m_5l - MY_5l*Z33 - MX_5l*Z42)*ddq_imu + (Z292*m_5l - MY_5l*Z33 - MX_5l*Z42)*ddq_w + (-MX_5l*Z44)*ddq_1l + (-MY_5l)*ddq_2l + (Z38*(MX_5l*Z40 - MZ_5l*Z38) + Z39*(MY_5l*Z40 - MZ_5l*Z39) - MX_5l*(Z526 + Z43*ddq_torso) - MY_5l*(Z524 + Z34*ddq_torso) + m_5l*(Z569 + Z293*ddq_torso))
Z748 = -Z269*m_5l;
Z749 = MZ_5l*Z41 - MY_5l*Z45 - Z270*m_5l;
Z750 = MZ_5l*Z42 - MY_5l*Z46 - Z271*m_5l;
Z751 = MZ_5l*Z42 - MY_5l*Z46 - Z272*m_5l;
Z752 = MZ_5l*Z43 - MY_5l*Z47 - Z273*m_5l;
Z753 = MZ_5l*Z44 - MY_5l*Z48;
Z754 = MZ_5l*Z526 - MY_5l*Z527 - Z565*m_5l - MX_5l*Z39^2 - MX_5l*Z40^2 + MY_5l*Z38*Z39 + MZ_5l*Z38*Z40;
 
Z755 = Z284*m_5l;
Z756 = MX_5l*Z45 + MZ_5l*Z32 + Z285*m_5l;
Z757 = MX_5l*Z46 + MZ_5l*Z33 + Z286*m_5l;
Z758 = MX_5l*Z46 + MZ_5l*Z33 + Z287*m_5l;
Z759 = MX_5l*Z47 + MZ_5l*Z34 + Z288*m_5l;
Z760 = MX_5l*Z48;
Z761 = MZ_5l;
Z762 = MX_5l*Z527 + MZ_5l*Z524 + Z568*m_5l - MY_5l*Z38^2 - MY_5l*Z40^2 + MX_5l*Z38*Z39 + MZ_5l*Z39*Z40;
 
Z763 = Z289*m_5l;
Z764 = Z290*m_5l - MY_5l*Z32 - MX_5l*Z41;
Z765 = Z291*m_5l - MY_5l*Z33 - MX_5l*Z42;
Z766 = Z292*m_5l - MY_5l*Z33 - MX_5l*Z42;
Z767 = Z293*m_5l - MY_5l*Z34 - MX_5l*Z43;
Z768 = -MX_5l*Z44;
Z769 = -MY_5l;
Z770 = Z569*m_5l - MY_5l*Z524 - MX_5l*Z526 - MZ_5l*Z38^2 - MZ_5l*Z39^2 + MX_5l*Z38*Z40 + MY_5l*Z39*Z40;
 
maG5l = [Z748*ddx+Z749*ddpsi+Z750*ddq_imu+Z751*ddq_w+Z752*ddq_torso+Z753*ddq_1l+Z754;
    Z755*ddx+Z756*ddpsi+Z757*ddq_imu+Z758*ddq_w+Z759*ddq_torso+Z760*ddq_1l+Z761*ddq_2l+Z762;
    Z763*ddx+Z764*ddpsi+Z765*ddq_imu+Z766*ddq_w+Z767*ddq_torso+Z768*ddq_1l+Z769*ddq_2l+Z770];
 
% dHnew5l = 
%
%      (-Z269*m_5l)*ddx + (MZ_5l*Z41 - MY_5l*Z45 - Z270*m_5l)*ddpsi + (MZ_5l*Z42 - MY_5l*Z46 - Z271*m_5l)*ddq_imu + (MZ_5l*Z42 - MY_5l*Z46 - Z272*m_5l)*ddq_w + (MZ_5l*Z44 - MY_5l*Z48)*ddq_1l + (MZ_5l*(Z526 + Z43*ddq_torso) - Z40*(MX_5l*Z40 - MZ_5l*Z38) - MY_5l*(Z527 + Z47*ddq_torso) - Z39*(MX_5l*Z39 - MY_5l*Z38) - m_5l*(Z565 + Z273*ddq_torso))
%      (Z284*m_5l)*ddx + (MX_5l*Z45 + MZ_5l*Z32 + Z285*m_5l)*ddpsi + (MX_5l*Z46 + MZ_5l*Z33 + Z286*m_5l)*ddq_imu + (MX_5l*Z46 + MZ_5l*Z33 + Z287*m_5l)*ddq_w + (MX_5l*Z48)*ddq_1l + MZ_5l*ddq_2l + (Z38*(MX_5l*Z39 - MY_5l*Z38) - Z40*(MY_5l*Z40 - MZ_5l*Z39) + MX_5l*(Z527 + Z47*ddq_torso) + MZ_5l*(Z524 + Z34*ddq_torso) + m_5l*(Z568 + Z288*ddq_torso))
%      (Z289*m_5l)*ddx + (Z290*m_5l - MY_5l*Z32 - MX_5l*Z41)*ddpsi + (Z291*m_5l - MY_5l*Z33 - MX_5l*Z42)*ddq_imu + (Z292*m_5l - MY_5l*Z33 - MX_5l*Z42)*ddq_w + (-MX_5l*Z44)*ddq_1l + (-MY_5l)*ddq_2l + (Z38*(MX_5l*Z40 - MZ_5l*Z38) + Z39*(MY_5l*Z40 - MZ_5l*Z39) - MX_5l*(Z526 + Z43*ddq_torso) - MY_5l*(Z524 + Z34*ddq_torso) + m_5l*(Z569 + Z293*ddq_torso))
Z771 = MY_5l*Z289 - MZ_5l*Z284;
Z772 = MY_5l*Z290 - MZ_5l*Z285 - XX_5l*Z32 + XY_5l*Z41 + XZ_5l*Z45;
Z773 = MY_5l*Z291 - MZ_5l*Z286 - XX_5l*Z33 + XY_5l*Z42 + XZ_5l*Z46;
Z774 = MY_5l*Z292 - MZ_5l*Z287 - XX_5l*Z33 + XY_5l*Z42 + XZ_5l*Z46;
Z775 = MY_5l*Z293 - MZ_5l*Z288 - XX_5l*Z34 + XY_5l*Z43 + XZ_5l*Z47;
Z776 = XY_5l*Z44 + XZ_5l*Z48;
Z777 = -XX_5l;
Z778 = MY_5l*Z569 - MZ_5l*Z568 - XX_5l*Z524 + XY_5l*Z526 + XZ_5l*Z527 + YZ_5l*Z39^2 - YZ_5l*Z40^2 - XY_5l*Z38*Z40 + XZ_5l*Z38*Z39 - YY_5l*Z39*Z40 + Z39*Z40*ZZ_5l;
 
Z779 = - MX_5l*Z289 - MZ_5l*Z269;
Z780 = YY_5l*Z41 - MZ_5l*Z270 - XY_5l*Z32 - MX_5l*Z290 + YZ_5l*Z45;
Z781 = YY_5l*Z42 - MZ_5l*Z271 - XY_5l*Z33 - MX_5l*Z291 + YZ_5l*Z46;
Z782 = YY_5l*Z42 - MZ_5l*Z272 - XY_5l*Z33 - MX_5l*Z292 + YZ_5l*Z46;
Z783 = YY_5l*Z43 - MZ_5l*Z273 - XY_5l*Z34 - MX_5l*Z293 + YZ_5l*Z47;
Z784 = YY_5l*Z44 + YZ_5l*Z48;
Z785 = -XY_5l;
Z786 = YY_5l*Z526 - MZ_5l*Z565 - XY_5l*Z524 - MX_5l*Z569 + YZ_5l*Z527 - XZ_5l*Z38^2 + XZ_5l*Z40^2 + XX_5l*Z38*Z40 + XY_5l*Z39*Z40 - YZ_5l*Z38*Z39 - Z38*Z40*ZZ_5l;
 
Z787 = MX_5l*Z284 + MY_5l*Z269;
Z788 = MX_5l*Z285 + MY_5l*Z270 - XZ_5l*Z32 + YZ_5l*Z41 + Z45*ZZ_5l;
Z789 = MX_5l*Z286 + MY_5l*Z271 - XZ_5l*Z33 + YZ_5l*Z42 + Z46*ZZ_5l;
Z790 = MX_5l*Z287 + MY_5l*Z272 - XZ_5l*Z33 + YZ_5l*Z42 + Z46*ZZ_5l;
Z791 = MX_5l*Z288 + MY_5l*Z273 - XZ_5l*Z34 + YZ_5l*Z43 + Z47*ZZ_5l;
Z792 = YZ_5l*Z44 + Z48*ZZ_5l;
Z793 = -XZ_5l;
Z794 = MX_5l*Z568 + MY_5l*Z565 - XZ_5l*Z524 + YZ_5l*Z526 + Z527*ZZ_5l + XY_5l*Z38^2 - XY_5l*Z39^2 - XX_5l*Z38*Z39 - XZ_5l*Z39*Z40 + YY_5l*Z38*Z39 + YZ_5l*Z38*Z40;
 
dHnew5l = [Z771*ddx+Z772*ddpsi+Z773*ddq_imu+Z774*ddq_w+Z775*ddq_torso+Z776*ddq_1l+Z777*ddq_2l+Z778;
    Z779*ddx+Z780*ddpsi+Z781*ddq_imu+Z782*ddq_w+Z783*ddq_torso+Z784*ddq_1l+Z785*ddq_2l+Z786;
    Z787*ddx+Z788*ddpsi+Z789*ddq_imu+Z790*ddq_w+Z791*ddq_torso+Z792*ddq_1l+Z793*ddq_2l+Z794];
 
 
% maG6l = 
%
%      (Z296*m_6l)*ddx + (Z297*m_6l - MZ_6l*Z41 - MY_6l*Z57)*ddpsi + (Z298*m_6l - MZ_6l*Z42 - MY_6l*Z58)*ddq_imu + (Z299*m_6l - MZ_6l*Z42 - MY_6l*Z58)*ddq_w + (Z301*m_6l - MZ_6l*Z44 - MY_6l*Z60)*ddq_1l + (Z302*m_6l - MY_6l*Z61)*ddq_2l + (-MZ_6l)*ddq_3l + (m_6l*(Z570 + Z300*ddq_torso) - Z51*(MX_6l*Z51 - MZ_6l*Z49) - MY_6l*(Z529 + Z59*ddq_torso) - MZ_6l*(Z526 + Z43*ddq_torso) - Z50*(MX_6l*Z50 - MY_6l*Z49))
%      (-Z284*m_6l)*ddx + (MX_6l*Z57 - MZ_6l*Z52 - Z285*m_6l)*ddpsi + (MX_6l*Z58 - MZ_6l*Z53 - Z286*m_6l)*ddq_imu + (MX_6l*Z58 - MZ_6l*Z53 - Z287*m_6l)*ddq_w + (MX_6l*Z60 - MZ_6l*Z55)*ddq_1l + (MX_6l*Z61 - MZ_6l*Z56)*ddq_2l + (Z49*(MX_6l*Z50 - MY_6l*Z49) - Z51*(MY_6l*Z51 - MZ_6l*Z50) + MX_6l*(Z529 + Z59*ddq_torso) - MZ_6l*(Z528 + Z54*ddq_torso) + m_6l*(Z571 - Z288*ddq_torso))
%      (Z303*m_6l)*ddx + (MX_6l*Z41 + MY_6l*Z52 + Z304*m_6l)*ddpsi + (MX_6l*Z42 + MY_6l*Z53 + Z305*m_6l)*ddq_imu + (MX_6l*Z42 + MY_6l*Z53 + Z306*m_6l)*ddq_w + (MX_6l*Z44 + MY_6l*Z55 + Z308*m_6l)*ddq_1l + (MY_6l*Z56 + Z309*m_6l)*ddq_2l + MX_6l*ddq_3l + (Z49*(MX_6l*Z51 - MZ_6l*Z49) + Z50*(MY_6l*Z51 - MZ_6l*Z50) + MX_6l*(Z526 + Z43*ddq_torso) + MY_6l*(Z528 + Z54*ddq_torso) + m_6l*(Z572 + Z307*ddq_torso))
Z795 = Z296*m_6l;
Z796 = Z297*m_6l - MZ_6l*Z41 - MY_6l*Z57;
Z797 = Z298*m_6l - MZ_6l*Z42 - MY_6l*Z58;
Z798 = Z299*m_6l - MZ_6l*Z42 - MY_6l*Z58;
Z799 = Z300*m_6l - MZ_6l*Z43 - MY_6l*Z59;
Z800 = Z301*m_6l - MZ_6l*Z44 - MY_6l*Z60;
Z801 = Z302*m_6l - MY_6l*Z61;
Z802 = -MZ_6l;
Z803 = Z570*m_6l - MZ_6l*Z526 - MY_6l*Z529 - MX_6l*Z50^2 - MX_6l*Z51^2 + MY_6l*Z49*Z50 + MZ_6l*Z49*Z51;
 
Z804 = -Z284*m_6l;
Z805 = MX_6l*Z57 - MZ_6l*Z52 - Z285*m_6l;
Z806 = MX_6l*Z58 - MZ_6l*Z53 - Z286*m_6l;
Z807 = MX_6l*Z58 - MZ_6l*Z53 - Z287*m_6l;
Z808 = MX_6l*Z59 - MZ_6l*Z54 - Z288*m_6l;
Z809 = MX_6l*Z60 - MZ_6l*Z55;
Z810 = MX_6l*Z61 - MZ_6l*Z56;
Z811 = MX_6l*Z529 - MZ_6l*Z528 + Z571*m_6l - MY_6l*Z49^2 - MY_6l*Z51^2 + MX_6l*Z49*Z50 + MZ_6l*Z50*Z51;
 
Z812 = Z303*m_6l;
Z813 = MX_6l*Z41 + MY_6l*Z52 + Z304*m_6l;
Z814 = MX_6l*Z42 + MY_6l*Z53 + Z305*m_6l;
Z815 = MX_6l*Z42 + MY_6l*Z53 + Z306*m_6l;
Z816 = MX_6l*Z43 + MY_6l*Z54 + Z307*m_6l;
Z817 = MX_6l*Z44 + MY_6l*Z55 + Z308*m_6l;
Z818 = MY_6l*Z56 + Z309*m_6l;
Z819 = MX_6l;
Z820 = MX_6l*Z526 + MY_6l*Z528 + Z572*m_6l - MZ_6l*Z49^2 - MZ_6l*Z50^2 + MX_6l*Z49*Z51 + MY_6l*Z50*Z51;
 
maG6l = [Z795*ddx+Z796*ddpsi+Z797*ddq_imu+Z798*ddq_w+Z799*ddq_torso+Z800*ddq_1l+Z801*ddq_2l+Z802*ddq_3l+Z803;
    Z804*ddx+Z805*ddpsi+Z806*ddq_imu+Z807*ddq_w+Z808*ddq_torso+Z809*ddq_1l+Z810*ddq_2l+Z811;
    Z812*ddx+Z813*ddpsi+Z814*ddq_imu+Z815*ddq_w+Z816*ddq_torso+Z817*ddq_1l+Z818*ddq_2l+Z819*ddq_3l+Z820];
 
% dHnew6l = 
%
%      (Z296*m_6l)*ddx + (Z297*m_6l - MZ_6l*Z41 - MY_6l*Z57)*ddpsi + (Z298*m_6l - MZ_6l*Z42 - MY_6l*Z58)*ddq_imu + (Z299*m_6l - MZ_6l*Z42 - MY_6l*Z58)*ddq_w + (Z301*m_6l - MZ_6l*Z44 - MY_6l*Z60)*ddq_1l + (Z302*m_6l - MY_6l*Z61)*ddq_2l + (-MZ_6l)*ddq_3l + (m_6l*(Z570 + Z300*ddq_torso) - Z51*(MX_6l*Z51 - MZ_6l*Z49) - MY_6l*(Z529 + Z59*ddq_torso) - MZ_6l*(Z526 + Z43*ddq_torso) - Z50*(MX_6l*Z50 - MY_6l*Z49))
%      (-Z284*m_6l)*ddx + (MX_6l*Z57 - MZ_6l*Z52 - Z285*m_6l)*ddpsi + (MX_6l*Z58 - MZ_6l*Z53 - Z286*m_6l)*ddq_imu + (MX_6l*Z58 - MZ_6l*Z53 - Z287*m_6l)*ddq_w + (MX_6l*Z60 - MZ_6l*Z55)*ddq_1l + (MX_6l*Z61 - MZ_6l*Z56)*ddq_2l + (Z49*(MX_6l*Z50 - MY_6l*Z49) - Z51*(MY_6l*Z51 - MZ_6l*Z50) + MX_6l*(Z529 + Z59*ddq_torso) - MZ_6l*(Z528 + Z54*ddq_torso) + m_6l*(Z571 - Z288*ddq_torso))
%      (Z303*m_6l)*ddx + (MX_6l*Z41 + MY_6l*Z52 + Z304*m_6l)*ddpsi + (MX_6l*Z42 + MY_6l*Z53 + Z305*m_6l)*ddq_imu + (MX_6l*Z42 + MY_6l*Z53 + Z306*m_6l)*ddq_w + (MX_6l*Z44 + MY_6l*Z55 + Z308*m_6l)*ddq_1l + (MY_6l*Z56 + Z309*m_6l)*ddq_2l + MX_6l*ddq_3l + (Z49*(MX_6l*Z51 - MZ_6l*Z49) + Z50*(MY_6l*Z51 - MZ_6l*Z50) + MX_6l*(Z526 + Z43*ddq_torso) + MY_6l*(Z528 + Z54*ddq_torso) + m_6l*(Z572 + Z307*ddq_torso))
Z821 = MY_6l*Z303 + MZ_6l*Z284;
Z822 = MY_6l*Z304 + MZ_6l*Z285 + XX_6l*Z52 - XY_6l*Z41 + XZ_6l*Z57;
Z823 = MY_6l*Z305 + MZ_6l*Z286 + XX_6l*Z53 - XY_6l*Z42 + XZ_6l*Z58;
Z824 = MY_6l*Z306 + MZ_6l*Z287 + XX_6l*Z53 - XY_6l*Z42 + XZ_6l*Z58;
Z825 = MY_6l*Z307 + MZ_6l*Z288 + XX_6l*Z54 - XY_6l*Z43 + XZ_6l*Z59;
Z826 = MY_6l*Z308 + XX_6l*Z55 - XY_6l*Z44 + XZ_6l*Z60;
Z827 = MY_6l*Z309 + XX_6l*Z56 + XZ_6l*Z61;
Z828 = -XY_6l;
Z829 = MY_6l*Z572 - MZ_6l*Z571 + XX_6l*Z528 - XY_6l*Z526 + XZ_6l*Z529 + YZ_6l*Z50^2 - YZ_6l*Z51^2 - XY_6l*Z49*Z51 + XZ_6l*Z49*Z50 - YY_6l*Z50*Z51 + Z50*Z51*ZZ_6l;
 
Z830 = MZ_6l*Z296 - MX_6l*Z303;
Z831 = MZ_6l*Z297 - MX_6l*Z304 + XY_6l*Z52 - YY_6l*Z41 + YZ_6l*Z57;
Z832 = MZ_6l*Z298 - MX_6l*Z305 + XY_6l*Z53 - YY_6l*Z42 + YZ_6l*Z58;
Z833 = MZ_6l*Z299 - MX_6l*Z306 + XY_6l*Z53 - YY_6l*Z42 + YZ_6l*Z58;
Z834 = MZ_6l*Z300 - MX_6l*Z307 + XY_6l*Z54 - YY_6l*Z43 + YZ_6l*Z59;
Z835 = MZ_6l*Z301 - MX_6l*Z308 + XY_6l*Z55 - YY_6l*Z44 + YZ_6l*Z60;
Z836 = MZ_6l*Z302 - MX_6l*Z309 + XY_6l*Z56 + YZ_6l*Z61;
Z837 = -YY_6l;
Z838 = MZ_6l*Z570 - MX_6l*Z572 + XY_6l*Z528 - YY_6l*Z526 + YZ_6l*Z529 - XZ_6l*Z49^2 + XZ_6l*Z51^2 + XX_6l*Z49*Z51 + XY_6l*Z50*Z51 - YZ_6l*Z49*Z50 - Z49*Z51*ZZ_6l;
 
Z839 = - MX_6l*Z284 - MY_6l*Z296;
Z840 = XZ_6l*Z52 - MY_6l*Z297 - MX_6l*Z285 - YZ_6l*Z41 + Z57*ZZ_6l;
Z841 = XZ_6l*Z53 - MY_6l*Z298 - MX_6l*Z286 - YZ_6l*Z42 + Z58*ZZ_6l;
Z842 = XZ_6l*Z53 - MY_6l*Z299 - MX_6l*Z287 - YZ_6l*Z42 + Z58*ZZ_6l;
Z843 = XZ_6l*Z54 - MY_6l*Z300 - MX_6l*Z288 - YZ_6l*Z43 + Z59*ZZ_6l;
Z844 = XZ_6l*Z55 - MY_6l*Z301 - YZ_6l*Z44 + Z60*ZZ_6l;
Z845 = XZ_6l*Z56 - MY_6l*Z302 + Z61*ZZ_6l;
Z846 = -YZ_6l;
Z847 = MX_6l*Z571 - MY_6l*Z570 + XZ_6l*Z528 - YZ_6l*Z526 + Z529*ZZ_6l + XY_6l*Z49^2 - XY_6l*Z50^2 - XX_6l*Z49*Z50 - XZ_6l*Z50*Z51 + YY_6l*Z49*Z50 + YZ_6l*Z49*Z51;
 
dHnew6l = [Z821*ddx+Z822*ddpsi+Z823*ddq_imu+Z824*ddq_w+Z825*ddq_torso+Z826*ddq_1l+Z827*ddq_2l+Z828*ddq_3l+Z829;
    Z830*ddx+Z831*ddpsi+Z832*ddq_imu+Z833*ddq_w+Z834*ddq_torso+Z835*ddq_1l+Z836*ddq_2l+Z837*ddq_3l+Z838;
    Z839*ddx+Z840*ddpsi+Z841*ddq_imu+Z842*ddq_w+Z843*ddq_torso+Z844*ddq_1l+Z845*ddq_2l+Z846*ddq_3l+Z847];
 
 
% maG7l = 
%
%      (-Z296*m_7l)*ddx + (MZ_7l*Z65 - MY_7l*Z71 - Z297*m_7l)*ddpsi + (MZ_7l*Z66 - MY_7l*Z72 - Z298*m_7l)*ddq_imu + (MZ_7l*Z66 - MY_7l*Z72 - Z299*m_7l)*ddq_w + (MZ_7l*Z68 - MY_7l*Z74 - Z301*m_7l)*ddq_1l + (MZ_7l*Z69 - MY_7l*Z75 - Z302*m_7l)*ddq_2l + (MZ_7l*Z70 - MY_7l*Z76)*ddq_3l + (MZ_7l*(Z530 + Z67*ddq_torso) - Z64*(MX_7l*Z64 - MZ_7l*Z62) - MY_7l*(Z531 + Z73*ddq_torso) - Z63*(MX_7l*Z63 - MY_7l*Z62) - m_7l*(Z570 + Z300*ddq_torso))
%      (Z312*m_7l)*ddx + (MX_7l*Z71 + MZ_7l*Z52 + Z313*m_7l)*ddpsi + (MX_7l*Z72 + MZ_7l*Z53 + Z314*m_7l)*ddq_imu + (MX_7l*Z72 + MZ_7l*Z53 + Z315*m_7l)*ddq_w + (MX_7l*Z74 + MZ_7l*Z55 + Z317*m_7l)*ddq_1l + (MX_7l*Z75 + MZ_7l*Z56 + Z318*m_7l)*ddq_2l + (MX_7l*Z76)*ddq_3l + MZ_7l*ddq_4l + (Z62*(MX_7l*Z63 - MY_7l*Z62) - Z64*(MY_7l*Z64 - MZ_7l*Z63) + MX_7l*(Z531 + Z73*ddq_torso) + MZ_7l*(Z528 + Z54*ddq_torso) + m_7l*(Z573 + Z316*ddq_torso))
%      (Z319*m_7l)*ddx + (Z320*m_7l - MY_7l*Z52 - MX_7l*Z65)*ddpsi + (Z321*m_7l - MY_7l*Z53 - MX_7l*Z66)*ddq_imu + (Z322*m_7l - MY_7l*Z53 - MX_7l*Z66)*ddq_w + (Z324*m_7l - MY_7l*Z55 - MX_7l*Z68)*ddq_1l + (Z325*m_7l - MY_7l*Z56 - MX_7l*Z69)*ddq_2l + (-MX_7l*Z70)*ddq_3l + (-MY_7l)*ddq_4l + (Z62*(MX_7l*Z64 - MZ_7l*Z62) + Z63*(MY_7l*Z64 - MZ_7l*Z63) - MX_7l*(Z530 + Z67*ddq_torso) - MY_7l*(Z528 + Z54*ddq_torso) + m_7l*(Z574 + Z323*ddq_torso))
Z848 = -Z296*m_7l;
Z849 = MZ_7l*Z65 - MY_7l*Z71 - Z297*m_7l;
Z850 = MZ_7l*Z66 - MY_7l*Z72 - Z298*m_7l;
Z851 = MZ_7l*Z66 - MY_7l*Z72 - Z299*m_7l;
Z852 = MZ_7l*Z67 - MY_7l*Z73 - Z300*m_7l;
Z853 = MZ_7l*Z68 - MY_7l*Z74 - Z301*m_7l;
Z854 = MZ_7l*Z69 - MY_7l*Z75 - Z302*m_7l;
Z855 = MZ_7l*Z70 - MY_7l*Z76;
Z856 = MZ_7l*Z530 - MY_7l*Z531 - Z570*m_7l - MX_7l*Z63^2 - MX_7l*Z64^2 + MY_7l*Z62*Z63 + MZ_7l*Z62*Z64;
 
Z857 = Z312*m_7l;
Z858 = MX_7l*Z71 + MZ_7l*Z52 + Z313*m_7l;
Z859 = MX_7l*Z72 + MZ_7l*Z53 + Z314*m_7l;
Z860 = MX_7l*Z72 + MZ_7l*Z53 + Z315*m_7l;
Z861 = MX_7l*Z73 + MZ_7l*Z54 + Z316*m_7l;
Z862 = MX_7l*Z74 + MZ_7l*Z55 + Z317*m_7l;
Z863 = MX_7l*Z75 + MZ_7l*Z56 + Z318*m_7l;
Z864 = MX_7l*Z76;
Z865 = MZ_7l;
Z866 = MX_7l*Z531 + MZ_7l*Z528 + Z573*m_7l - MY_7l*Z62^2 - MY_7l*Z64^2 + MX_7l*Z62*Z63 + MZ_7l*Z63*Z64;
 
Z867 = Z319*m_7l;
Z868 = Z320*m_7l - MY_7l*Z52 - MX_7l*Z65;
Z869 = Z321*m_7l - MY_7l*Z53 - MX_7l*Z66;
Z870 = Z322*m_7l - MY_7l*Z53 - MX_7l*Z66;
Z871 = Z323*m_7l - MY_7l*Z54 - MX_7l*Z67;
Z872 = Z324*m_7l - MY_7l*Z55 - MX_7l*Z68;
Z873 = Z325*m_7l - MY_7l*Z56 - MX_7l*Z69;
Z874 = -MX_7l*Z70;
Z875 = -MY_7l;
Z876 = Z574*m_7l - MY_7l*Z528 - MX_7l*Z530 - MZ_7l*Z62^2 - MZ_7l*Z63^2 + MX_7l*Z62*Z64 + MY_7l*Z63*Z64;
 
maG7l = [Z848*ddx+Z849*ddpsi+Z850*ddq_imu+Z851*ddq_w+Z852*ddq_torso+Z853*ddq_1l+Z854*ddq_2l+Z855*ddq_3l+Z856;
    Z857*ddx+Z858*ddpsi+Z859*ddq_imu+Z860*ddq_w+Z861*ddq_torso+Z862*ddq_1l+Z863*ddq_2l+Z864*ddq_3l+Z865*ddq_4l+Z866;
    Z867*ddx+Z868*ddpsi+Z869*ddq_imu+Z870*ddq_w+Z871*ddq_torso+Z872*ddq_1l+Z873*ddq_2l+Z874*ddq_3l+Z875*ddq_4l+Z876];
 
% dHnew7l = 
%
%      (-Z296*m_7l)*ddx + (MZ_7l*Z65 - MY_7l*Z71 - Z297*m_7l)*ddpsi + (MZ_7l*Z66 - MY_7l*Z72 - Z298*m_7l)*ddq_imu + (MZ_7l*Z66 - MY_7l*Z72 - Z299*m_7l)*ddq_w + (MZ_7l*Z68 - MY_7l*Z74 - Z301*m_7l)*ddq_1l + (MZ_7l*Z69 - MY_7l*Z75 - Z302*m_7l)*ddq_2l + (MZ_7l*Z70 - MY_7l*Z76)*ddq_3l + (MZ_7l*(Z530 + Z67*ddq_torso) - Z64*(MX_7l*Z64 - MZ_7l*Z62) - MY_7l*(Z531 + Z73*ddq_torso) - Z63*(MX_7l*Z63 - MY_7l*Z62) - m_7l*(Z570 + Z300*ddq_torso))
%      (Z312*m_7l)*ddx + (MX_7l*Z71 + MZ_7l*Z52 + Z313*m_7l)*ddpsi + (MX_7l*Z72 + MZ_7l*Z53 + Z314*m_7l)*ddq_imu + (MX_7l*Z72 + MZ_7l*Z53 + Z315*m_7l)*ddq_w + (MX_7l*Z74 + MZ_7l*Z55 + Z317*m_7l)*ddq_1l + (MX_7l*Z75 + MZ_7l*Z56 + Z318*m_7l)*ddq_2l + (MX_7l*Z76)*ddq_3l + MZ_7l*ddq_4l + (Z62*(MX_7l*Z63 - MY_7l*Z62) - Z64*(MY_7l*Z64 - MZ_7l*Z63) + MX_7l*(Z531 + Z73*ddq_torso) + MZ_7l*(Z528 + Z54*ddq_torso) + m_7l*(Z573 + Z316*ddq_torso))
%      (Z319*m_7l)*ddx + (Z320*m_7l - MY_7l*Z52 - MX_7l*Z65)*ddpsi + (Z321*m_7l - MY_7l*Z53 - MX_7l*Z66)*ddq_imu + (Z322*m_7l - MY_7l*Z53 - MX_7l*Z66)*ddq_w + (Z324*m_7l - MY_7l*Z55 - MX_7l*Z68)*ddq_1l + (Z325*m_7l - MY_7l*Z56 - MX_7l*Z69)*ddq_2l + (-MX_7l*Z70)*ddq_3l + (-MY_7l)*ddq_4l + (Z62*(MX_7l*Z64 - MZ_7l*Z62) + Z63*(MY_7l*Z64 - MZ_7l*Z63) - MX_7l*(Z530 + Z67*ddq_torso) - MY_7l*(Z528 + Z54*ddq_torso) + m_7l*(Z574 + Z323*ddq_torso))
Z877 = MY_7l*Z319 - MZ_7l*Z312;
Z878 = MY_7l*Z320 - MZ_7l*Z313 - XX_7l*Z52 + XY_7l*Z65 + XZ_7l*Z71;
Z879 = MY_7l*Z321 - MZ_7l*Z314 - XX_7l*Z53 + XY_7l*Z66 + XZ_7l*Z72;
Z880 = MY_7l*Z322 - MZ_7l*Z315 - XX_7l*Z53 + XY_7l*Z66 + XZ_7l*Z72;
Z881 = MY_7l*Z323 - MZ_7l*Z316 - XX_7l*Z54 + XY_7l*Z67 + XZ_7l*Z73;
Z882 = MY_7l*Z324 - MZ_7l*Z317 - XX_7l*Z55 + XY_7l*Z68 + XZ_7l*Z74;
Z883 = MY_7l*Z325 - MZ_7l*Z318 - XX_7l*Z56 + XY_7l*Z69 + XZ_7l*Z75;
Z884 = XY_7l*Z70 + XZ_7l*Z76;
Z885 = -XX_7l;
Z886 = MY_7l*Z574 - MZ_7l*Z573 - XX_7l*Z528 + XY_7l*Z530 + XZ_7l*Z531 + YZ_7l*Z63^2 - YZ_7l*Z64^2 - XY_7l*Z62*Z64 + XZ_7l*Z62*Z63 - YY_7l*Z63*Z64 + Z63*Z64*ZZ_7l;
 
Z887 = - MX_7l*Z319 - MZ_7l*Z296;
Z888 = YY_7l*Z65 - MZ_7l*Z297 - XY_7l*Z52 - MX_7l*Z320 + YZ_7l*Z71;
Z889 = YY_7l*Z66 - MZ_7l*Z298 - XY_7l*Z53 - MX_7l*Z321 + YZ_7l*Z72;
Z890 = YY_7l*Z66 - MZ_7l*Z299 - XY_7l*Z53 - MX_7l*Z322 + YZ_7l*Z72;
Z891 = YY_7l*Z67 - MZ_7l*Z300 - XY_7l*Z54 - MX_7l*Z323 + YZ_7l*Z73;
Z892 = YY_7l*Z68 - MZ_7l*Z301 - XY_7l*Z55 - MX_7l*Z324 + YZ_7l*Z74;
Z893 = YY_7l*Z69 - MZ_7l*Z302 - XY_7l*Z56 - MX_7l*Z325 + YZ_7l*Z75;
Z894 = YY_7l*Z70 + YZ_7l*Z76;
Z895 = -XY_7l;
Z896 = YY_7l*Z530 - MZ_7l*Z570 - XY_7l*Z528 - MX_7l*Z574 + YZ_7l*Z531 - XZ_7l*Z62^2 + XZ_7l*Z64^2 + XX_7l*Z62*Z64 + XY_7l*Z63*Z64 - YZ_7l*Z62*Z63 - Z62*Z64*ZZ_7l;
 
Z897 = MX_7l*Z312 + MY_7l*Z296;
Z898 = MX_7l*Z313 + MY_7l*Z297 - XZ_7l*Z52 + YZ_7l*Z65 + Z71*ZZ_7l;
Z899 = MX_7l*Z314 + MY_7l*Z298 - XZ_7l*Z53 + YZ_7l*Z66 + Z72*ZZ_7l;
Z900 = MX_7l*Z315 + MY_7l*Z299 - XZ_7l*Z53 + YZ_7l*Z66 + Z72*ZZ_7l;
Z901 = MX_7l*Z316 + MY_7l*Z300 - XZ_7l*Z54 + YZ_7l*Z67 + Z73*ZZ_7l;
Z902 = MX_7l*Z317 + MY_7l*Z301 - XZ_7l*Z55 + YZ_7l*Z68 + Z74*ZZ_7l;
Z903 = MX_7l*Z318 + MY_7l*Z302 - XZ_7l*Z56 + YZ_7l*Z69 + Z75*ZZ_7l;
Z904 = YZ_7l*Z70 + Z76*ZZ_7l;
Z905 = -XZ_7l;
Z906 = MX_7l*Z573 + MY_7l*Z570 - XZ_7l*Z528 + YZ_7l*Z530 + Z531*ZZ_7l + XY_7l*Z62^2 - XY_7l*Z63^2 - XX_7l*Z62*Z63 - XZ_7l*Z63*Z64 + YY_7l*Z62*Z63 + YZ_7l*Z62*Z64;
 
dHnew7l = [Z877*ddx+Z878*ddpsi+Z879*ddq_imu+Z880*ddq_w+Z881*ddq_torso+Z882*ddq_1l+Z883*ddq_2l+Z884*ddq_3l+Z885*ddq_4l+Z886;
    Z887*ddx+Z888*ddpsi+Z889*ddq_imu+Z890*ddq_w+Z891*ddq_torso+Z892*ddq_1l+Z893*ddq_2l+Z894*ddq_3l+Z895*ddq_4l+Z896;
    Z897*ddx+Z898*ddpsi+Z899*ddq_imu+Z900*ddq_w+Z901*ddq_torso+Z902*ddq_1l+Z903*ddq_2l+Z904*ddq_3l+Z905*ddq_4l+Z906];
 
 
% maG8l = 
%
%      (Z328*m_8l)*ddx + (Z329*m_8l - MZ_8l*Z65 - MY_8l*Z87)*ddpsi + (Z330*m_8l - MZ_8l*Z66 - MY_8l*Z88)*ddq_imu + (Z331*m_8l - MZ_8l*Z66 - MY_8l*Z88)*ddq_w + (Z333*m_8l - MZ_8l*Z68 - MY_8l*Z90)*ddq_1l + (Z334*m_8l - MZ_8l*Z69 - MY_8l*Z91)*ddq_2l + (Z335*m_8l - MZ_8l*Z70 - MY_8l*Z92)*ddq_3l + (Z336*m_8l - MY_8l*Z93)*ddq_4l + (-MZ_8l)*ddq_5l + (m_8l*(Z575 + Z332*ddq_torso) - Z79*(MX_8l*Z79 - MZ_8l*Z77) - MY_8l*(Z533 + Z89*ddq_torso) - MZ_8l*(Z530 + Z67*ddq_torso) - Z78*(MX_8l*Z78 - MY_8l*Z77))
%      (-Z312*m_8l)*ddx + (MX_8l*Z87 - MZ_8l*Z80 - Z313*m_8l)*ddpsi + (MX_8l*Z88 - MZ_8l*Z81 - Z314*m_8l)*ddq_imu + (MX_8l*Z88 - MZ_8l*Z81 - Z315*m_8l)*ddq_w + (MX_8l*Z90 - MZ_8l*Z83 - Z317*m_8l)*ddq_1l + (MX_8l*Z91 - MZ_8l*Z84 - Z318*m_8l)*ddq_2l + (MX_8l*Z92 - MZ_8l*Z85)*ddq_3l + (MX_8l*Z93 - MZ_8l*Z86)*ddq_4l + (Z77*(MX_8l*Z78 - MY_8l*Z77) - Z79*(MY_8l*Z79 - MZ_8l*Z78) + MX_8l*(Z533 + Z89*ddq_torso) - MZ_8l*(Z532 + Z82*ddq_torso) + m_8l*(Z576 - Z316*ddq_torso))
%      (Z337*m_8l)*ddx + (MX_8l*Z65 + MY_8l*Z80 + Z338*m_8l)*ddpsi + (MX_8l*Z66 + MY_8l*Z81 + Z339*m_8l)*ddq_imu + (MX_8l*Z66 + MY_8l*Z81 + Z340*m_8l)*ddq_w + (MX_8l*Z68 + MY_8l*Z83 + Z342*m_8l)*ddq_1l + (MX_8l*Z69 + MY_8l*Z84 + Z343*m_8l)*ddq_2l + (MX_8l*Z70 + MY_8l*Z85 + Z344*m_8l)*ddq_3l + (MY_8l*Z86 + Z345*m_8l)*ddq_4l + MX_8l*ddq_5l + (Z77*(MX_8l*Z79 - MZ_8l*Z77) + Z78*(MY_8l*Z79 - MZ_8l*Z78) + MX_8l*(Z530 + Z67*ddq_torso) + MY_8l*(Z532 + Z82*ddq_torso) + m_8l*(Z577 + Z341*ddq_torso))
Z907 = Z328*m_8l;
Z908 = Z329*m_8l - MZ_8l*Z65 - MY_8l*Z87;
Z909 = Z330*m_8l - MZ_8l*Z66 - MY_8l*Z88;
Z910 = Z331*m_8l - MZ_8l*Z66 - MY_8l*Z88;
Z911 = Z332*m_8l - MZ_8l*Z67 - MY_8l*Z89;
Z912 = Z333*m_8l - MZ_8l*Z68 - MY_8l*Z90;
Z913 = Z334*m_8l - MZ_8l*Z69 - MY_8l*Z91;
Z914 = Z335*m_8l - MZ_8l*Z70 - MY_8l*Z92;
Z915 = Z336*m_8l - MY_8l*Z93;
Z916 = -MZ_8l;
Z917 = Z575*m_8l - MZ_8l*Z530 - MY_8l*Z533 - MX_8l*Z78^2 - MX_8l*Z79^2 + MY_8l*Z77*Z78 + MZ_8l*Z77*Z79;
 
Z918 = -Z312*m_8l;
Z919 = MX_8l*Z87 - MZ_8l*Z80 - Z313*m_8l;
Z920 = MX_8l*Z88 - MZ_8l*Z81 - Z314*m_8l;
Z921 = MX_8l*Z88 - MZ_8l*Z81 - Z315*m_8l;
Z922 = MX_8l*Z89 - MZ_8l*Z82 - Z316*m_8l;
Z923 = MX_8l*Z90 - MZ_8l*Z83 - Z317*m_8l;
Z924 = MX_8l*Z91 - MZ_8l*Z84 - Z318*m_8l;
Z925 = MX_8l*Z92 - MZ_8l*Z85;
Z926 = MX_8l*Z93 - MZ_8l*Z86;
Z927 = MX_8l*Z533 - MZ_8l*Z532 + Z576*m_8l - MY_8l*Z77^2 - MY_8l*Z79^2 + MX_8l*Z77*Z78 + MZ_8l*Z78*Z79;
 
Z928 = Z337*m_8l;
Z929 = MX_8l*Z65 + MY_8l*Z80 + Z338*m_8l;
Z930 = MX_8l*Z66 + MY_8l*Z81 + Z339*m_8l;
Z931 = MX_8l*Z66 + MY_8l*Z81 + Z340*m_8l;
Z932 = MX_8l*Z67 + MY_8l*Z82 + Z341*m_8l;
Z933 = MX_8l*Z68 + MY_8l*Z83 + Z342*m_8l;
Z934 = MX_8l*Z69 + MY_8l*Z84 + Z343*m_8l;
Z935 = MX_8l*Z70 + MY_8l*Z85 + Z344*m_8l;
Z936 = MY_8l*Z86 + Z345*m_8l;
Z937 = MX_8l;
Z938 = MX_8l*Z530 + MY_8l*Z532 + Z577*m_8l - MZ_8l*Z77^2 - MZ_8l*Z78^2 + MX_8l*Z77*Z79 + MY_8l*Z78*Z79;
 
maG8l = [Z907*ddx+Z908*ddpsi+Z909*ddq_imu+Z910*ddq_w+Z911*ddq_torso+Z912*ddq_1l+Z913*ddq_2l+Z914*ddq_3l+Z915*ddq_4l+Z916*ddq_5l+Z917;
    Z918*ddx+Z919*ddpsi+Z920*ddq_imu+Z921*ddq_w+Z922*ddq_torso+Z923*ddq_1l+Z924*ddq_2l+Z925*ddq_3l+Z926*ddq_4l+Z927;
    Z928*ddx+Z929*ddpsi+Z930*ddq_imu+Z931*ddq_w+Z932*ddq_torso+Z933*ddq_1l+Z934*ddq_2l+Z935*ddq_3l+Z936*ddq_4l+Z937*ddq_5l+Z938];
 
% dHnew8l = 
%
%      (Z328*m_8l)*ddx + (Z329*m_8l - MZ_8l*Z65 - MY_8l*Z87)*ddpsi + (Z330*m_8l - MZ_8l*Z66 - MY_8l*Z88)*ddq_imu + (Z331*m_8l - MZ_8l*Z66 - MY_8l*Z88)*ddq_w + (Z333*m_8l - MZ_8l*Z68 - MY_8l*Z90)*ddq_1l + (Z334*m_8l - MZ_8l*Z69 - MY_8l*Z91)*ddq_2l + (Z335*m_8l - MZ_8l*Z70 - MY_8l*Z92)*ddq_3l + (Z336*m_8l - MY_8l*Z93)*ddq_4l + (-MZ_8l)*ddq_5l + (m_8l*(Z575 + Z332*ddq_torso) - Z79*(MX_8l*Z79 - MZ_8l*Z77) - MY_8l*(Z533 + Z89*ddq_torso) - MZ_8l*(Z530 + Z67*ddq_torso) - Z78*(MX_8l*Z78 - MY_8l*Z77))
%      (-Z312*m_8l)*ddx + (MX_8l*Z87 - MZ_8l*Z80 - Z313*m_8l)*ddpsi + (MX_8l*Z88 - MZ_8l*Z81 - Z314*m_8l)*ddq_imu + (MX_8l*Z88 - MZ_8l*Z81 - Z315*m_8l)*ddq_w + (MX_8l*Z90 - MZ_8l*Z83 - Z317*m_8l)*ddq_1l + (MX_8l*Z91 - MZ_8l*Z84 - Z318*m_8l)*ddq_2l + (MX_8l*Z92 - MZ_8l*Z85)*ddq_3l + (MX_8l*Z93 - MZ_8l*Z86)*ddq_4l + (Z77*(MX_8l*Z78 - MY_8l*Z77) - Z79*(MY_8l*Z79 - MZ_8l*Z78) + MX_8l*(Z533 + Z89*ddq_torso) - MZ_8l*(Z532 + Z82*ddq_torso) + m_8l*(Z576 - Z316*ddq_torso))
%      (Z337*m_8l)*ddx + (MX_8l*Z65 + MY_8l*Z80 + Z338*m_8l)*ddpsi + (MX_8l*Z66 + MY_8l*Z81 + Z339*m_8l)*ddq_imu + (MX_8l*Z66 + MY_8l*Z81 + Z340*m_8l)*ddq_w + (MX_8l*Z68 + MY_8l*Z83 + Z342*m_8l)*ddq_1l + (MX_8l*Z69 + MY_8l*Z84 + Z343*m_8l)*ddq_2l + (MX_8l*Z70 + MY_8l*Z85 + Z344*m_8l)*ddq_3l + (MY_8l*Z86 + Z345*m_8l)*ddq_4l + MX_8l*ddq_5l + (Z77*(MX_8l*Z79 - MZ_8l*Z77) + Z78*(MY_8l*Z79 - MZ_8l*Z78) + MX_8l*(Z530 + Z67*ddq_torso) + MY_8l*(Z532 + Z82*ddq_torso) + m_8l*(Z577 + Z341*ddq_torso))
Z939 = MY_8l*Z337 + MZ_8l*Z312;
Z940 = MY_8l*Z338 + MZ_8l*Z313 + XX_8l*Z80 - XY_8l*Z65 + XZ_8l*Z87;
Z941 = MY_8l*Z339 + MZ_8l*Z314 + XX_8l*Z81 - XY_8l*Z66 + XZ_8l*Z88;
Z942 = MY_8l*Z340 + MZ_8l*Z315 + XX_8l*Z81 - XY_8l*Z66 + XZ_8l*Z88;
Z943 = MY_8l*Z341 + MZ_8l*Z316 + XX_8l*Z82 - XY_8l*Z67 + XZ_8l*Z89;
Z944 = MY_8l*Z342 + MZ_8l*Z317 + XX_8l*Z83 - XY_8l*Z68 + XZ_8l*Z90;
Z945 = MY_8l*Z343 + MZ_8l*Z318 + XX_8l*Z84 - XY_8l*Z69 + XZ_8l*Z91;
Z946 = MY_8l*Z344 + XX_8l*Z85 - XY_8l*Z70 + XZ_8l*Z92;
Z947 = MY_8l*Z345 + XX_8l*Z86 + XZ_8l*Z93;
Z948 = -XY_8l;
Z949 = MY_8l*Z577 - MZ_8l*Z576 + XX_8l*Z532 - XY_8l*Z530 + XZ_8l*Z533 + YZ_8l*Z78^2 - YZ_8l*Z79^2 - XY_8l*Z77*Z79 + XZ_8l*Z77*Z78 - YY_8l*Z78*Z79 + Z78*Z79*ZZ_8l;
 
Z950 = MZ_8l*Z328 - MX_8l*Z337;
Z951 = MZ_8l*Z329 - MX_8l*Z338 + XY_8l*Z80 - YY_8l*Z65 + YZ_8l*Z87;
Z952 = MZ_8l*Z330 - MX_8l*Z339 + XY_8l*Z81 - YY_8l*Z66 + YZ_8l*Z88;
Z953 = MZ_8l*Z331 - MX_8l*Z340 + XY_8l*Z81 - YY_8l*Z66 + YZ_8l*Z88;
Z954 = MZ_8l*Z332 - MX_8l*Z341 + XY_8l*Z82 - YY_8l*Z67 + YZ_8l*Z89;
Z955 = MZ_8l*Z333 - MX_8l*Z342 + XY_8l*Z83 - YY_8l*Z68 + YZ_8l*Z90;
Z956 = MZ_8l*Z334 - MX_8l*Z343 + XY_8l*Z84 - YY_8l*Z69 + YZ_8l*Z91;
Z957 = MZ_8l*Z335 - MX_8l*Z344 + XY_8l*Z85 - YY_8l*Z70 + YZ_8l*Z92;
Z958 = MZ_8l*Z336 - MX_8l*Z345 + XY_8l*Z86 + YZ_8l*Z93;
Z959 = -YY_8l;
Z960 = MZ_8l*Z575 - MX_8l*Z577 + XY_8l*Z532 - YY_8l*Z530 + YZ_8l*Z533 - XZ_8l*Z77^2 + XZ_8l*Z79^2 + XX_8l*Z77*Z79 + XY_8l*Z78*Z79 - YZ_8l*Z77*Z78 - Z77*Z79*ZZ_8l;
 
Z961 = - MX_8l*Z312 - MY_8l*Z328;
Z962 = XZ_8l*Z80 - MY_8l*Z329 - MX_8l*Z313 - YZ_8l*Z65 + Z87*ZZ_8l;
Z963 = XZ_8l*Z81 - MY_8l*Z330 - MX_8l*Z314 - YZ_8l*Z66 + Z88*ZZ_8l;
Z964 = XZ_8l*Z81 - MY_8l*Z331 - MX_8l*Z315 - YZ_8l*Z66 + Z88*ZZ_8l;
Z965 = XZ_8l*Z82 - MY_8l*Z332 - MX_8l*Z316 - YZ_8l*Z67 + Z89*ZZ_8l;
Z966 = XZ_8l*Z83 - MY_8l*Z333 - MX_8l*Z317 - YZ_8l*Z68 + Z90*ZZ_8l;
Z967 = XZ_8l*Z84 - MY_8l*Z334 - MX_8l*Z318 - YZ_8l*Z69 + Z91*ZZ_8l;
Z968 = XZ_8l*Z85 - MY_8l*Z335 - YZ_8l*Z70 + Z92*ZZ_8l;
Z969 = XZ_8l*Z86 - MY_8l*Z336 + Z93*ZZ_8l;
Z970 = -YZ_8l;
Z971 = MX_8l*Z576 - MY_8l*Z575 + XZ_8l*Z532 - YZ_8l*Z530 + Z533*ZZ_8l + XY_8l*Z77^2 - XY_8l*Z78^2 - XX_8l*Z77*Z78 - XZ_8l*Z78*Z79 + YY_8l*Z77*Z78 + YZ_8l*Z77*Z79;
 
dHnew8l = [Z939*ddx+Z940*ddpsi+Z941*ddq_imu+Z942*ddq_w+Z943*ddq_torso+Z944*ddq_1l+Z945*ddq_2l+Z946*ddq_3l+Z947*ddq_4l+Z948*ddq_5l+Z949;
    Z950*ddx+Z951*ddpsi+Z952*ddq_imu+Z953*ddq_w+Z954*ddq_torso+Z955*ddq_1l+Z956*ddq_2l+Z957*ddq_3l+Z958*ddq_4l+Z959*ddq_5l+Z960;
    Z961*ddx+Z962*ddpsi+Z963*ddq_imu+Z964*ddq_w+Z965*ddq_torso+Z966*ddq_1l+Z967*ddq_2l+Z968*ddq_3l+Z969*ddq_4l+Z970*ddq_5l+Z971];
 
 
% maG9l = 
%
%      (-Z328*m_9l)*ddx + (MZ_9l*Z97 - MY_9l*Z105 - Z329*m_9l)*ddpsi + (MZ_9l*Z98 - MY_9l*Z106 - Z330*m_9l)*ddq_imu + (MZ_9l*Z98 - MY_9l*Z106 - Z331*m_9l)*ddq_w + (MZ_9l*Z100 - MY_9l*Z108 - Z333*m_9l)*ddq_1l + (MZ_9l*Z101 - MY_9l*Z109 - Z334*m_9l)*ddq_2l + (MZ_9l*Z102 - MY_9l*Z110 - Z335*m_9l)*ddq_3l + (MZ_9l*Z103 - MY_9l*Z111 - Z336*m_9l)*ddq_4l + (MZ_9l*Z104 - MY_9l*Z112)*ddq_5l + (MZ_9l*(Z534 + Z99*ddq_torso) - Z96*(MX_9l*Z96 - MZ_9l*Z94) - MY_9l*(Z535 + Z107*ddq_torso) - Z95*(MX_9l*Z95 - MY_9l*Z94) - m_9l*(Z575 + Z332*ddq_torso))
%      (Z348*m_9l)*ddx + (MX_9l*Z105 + MZ_9l*Z80 + Z349*m_9l)*ddpsi + (MX_9l*Z106 + MZ_9l*Z81 + Z350*m_9l)*ddq_imu + (MX_9l*Z106 + MZ_9l*Z81 + Z351*m_9l)*ddq_w + (MX_9l*Z108 + MZ_9l*Z83 + Z353*m_9l)*ddq_1l + (MX_9l*Z109 + MZ_9l*Z84 + Z354*m_9l)*ddq_2l + (MX_9l*Z110 + MZ_9l*Z85 + Z355*m_9l)*ddq_3l + (MX_9l*Z111 + MZ_9l*Z86 + Z356*m_9l)*ddq_4l + (MX_9l*Z112)*ddq_5l + MZ_9l*ddq_6l + (Z94*(MX_9l*Z95 - MY_9l*Z94) - Z96*(MY_9l*Z96 - MZ_9l*Z95) + MX_9l*(Z535 + Z107*ddq_torso) + MZ_9l*(Z532 + Z82*ddq_torso) + m_9l*(Z578 + Z352*ddq_torso))
%      (Z357*m_9l)*ddx + (Z358*m_9l - MY_9l*Z80 - MX_9l*Z97)*ddpsi + (Z359*m_9l - MY_9l*Z81 - MX_9l*Z98)*ddq_imu + (Z360*m_9l - MY_9l*Z81 - MX_9l*Z98)*ddq_w + (Z362*m_9l - MY_9l*Z83 - MX_9l*Z100)*ddq_1l + (Z363*m_9l - MY_9l*Z84 - MX_9l*Z101)*ddq_2l + (Z364*m_9l - MY_9l*Z85 - MX_9l*Z102)*ddq_3l + (Z365*m_9l - MY_9l*Z86 - MX_9l*Z103)*ddq_4l + (-MX_9l*Z104)*ddq_5l + (-MY_9l)*ddq_6l + (Z94*(MX_9l*Z96 - MZ_9l*Z94) + Z95*(MY_9l*Z96 - MZ_9l*Z95) - MX_9l*(Z534 + Z99*ddq_torso) - MY_9l*(Z532 + Z82*ddq_torso) + m_9l*(Z579 + Z361*ddq_torso))
Z972 = -Z328*m_9l;
Z973 = MZ_9l*Z97 - MY_9l*Z105 - Z329*m_9l;
Z974 = MZ_9l*Z98 - MY_9l*Z106 - Z330*m_9l;
Z975 = MZ_9l*Z98 - MY_9l*Z106 - Z331*m_9l;
Z976 = MZ_9l*Z99 - MY_9l*Z107 - Z332*m_9l;
Z977 = MZ_9l*Z100 - MY_9l*Z108 - Z333*m_9l;
Z978 = MZ_9l*Z101 - MY_9l*Z109 - Z334*m_9l;
Z979 = MZ_9l*Z102 - MY_9l*Z110 - Z335*m_9l;
Z980 = MZ_9l*Z103 - MY_9l*Z111 - Z336*m_9l;
Z981 = MZ_9l*Z104 - MY_9l*Z112;
Z982 = MZ_9l*Z534 - MY_9l*Z535 - Z575*m_9l - MX_9l*Z95^2 - MX_9l*Z96^2 + MY_9l*Z94*Z95 + MZ_9l*Z94*Z96;
 
Z983 = Z348*m_9l;
Z984 = MX_9l*Z105 + MZ_9l*Z80 + Z349*m_9l;
Z985 = MX_9l*Z106 + MZ_9l*Z81 + Z350*m_9l;
Z986 = MX_9l*Z106 + MZ_9l*Z81 + Z351*m_9l;
Z987 = MX_9l*Z107 + MZ_9l*Z82 + Z352*m_9l;
Z988 = MX_9l*Z108 + MZ_9l*Z83 + Z353*m_9l;
Z989 = MX_9l*Z109 + MZ_9l*Z84 + Z354*m_9l;
Z990 = MX_9l*Z110 + MZ_9l*Z85 + Z355*m_9l;
Z991 = MX_9l*Z111 + MZ_9l*Z86 + Z356*m_9l;
Z992 = MX_9l*Z112;
Z993 = MZ_9l;
Z994 = MX_9l*Z535 + MZ_9l*Z532 + Z578*m_9l - MY_9l*Z94^2 - MY_9l*Z96^2 + MX_9l*Z94*Z95 + MZ_9l*Z95*Z96;
 
Z995 = Z357*m_9l;
Z996 = Z358*m_9l - MY_9l*Z80 - MX_9l*Z97;
Z997 = Z359*m_9l - MY_9l*Z81 - MX_9l*Z98;
Z998 = Z360*m_9l - MY_9l*Z81 - MX_9l*Z98;
Z999 = Z361*m_9l - MY_9l*Z82 - MX_9l*Z99;
Z1000 = Z362*m_9l - MY_9l*Z83 - MX_9l*Z100;
Z1001 = Z363*m_9l - MY_9l*Z84 - MX_9l*Z101;
Z1002 = Z364*m_9l - MY_9l*Z85 - MX_9l*Z102;
Z1003 = Z365*m_9l - MY_9l*Z86 - MX_9l*Z103;
Z1004 = -MX_9l*Z104;
Z1005 = -MY_9l;
Z1006 = Z579*m_9l - MY_9l*Z532 - MX_9l*Z534 - MZ_9l*Z94^2 - MZ_9l*Z95^2 + MX_9l*Z94*Z96 + MY_9l*Z95*Z96;
 
maG9l = [Z972*ddx+Z973*ddpsi+Z974*ddq_imu+Z975*ddq_w+Z976*ddq_torso+Z977*ddq_1l+Z978*ddq_2l+Z979*ddq_3l+Z980*ddq_4l+Z981*ddq_5l+Z982;
    Z983*ddx+Z984*ddpsi+Z985*ddq_imu+Z986*ddq_w+Z987*ddq_torso+Z988*ddq_1l+Z989*ddq_2l+Z990*ddq_3l+Z991*ddq_4l+Z992*ddq_5l+Z993*ddq_6l+Z994;
    Z995*ddx+Z996*ddpsi+Z997*ddq_imu+Z998*ddq_w+Z999*ddq_torso+Z1000*ddq_1l+Z1001*ddq_2l+Z1002*ddq_3l+Z1003*ddq_4l+Z1004*ddq_5l+Z1005*ddq_6l+Z1006];
 
% dHnew9l = 
%
%      (-Z328*m_9l)*ddx + (MZ_9l*Z97 - MY_9l*Z105 - Z329*m_9l)*ddpsi + (MZ_9l*Z98 - MY_9l*Z106 - Z330*m_9l)*ddq_imu + (MZ_9l*Z98 - MY_9l*Z106 - Z331*m_9l)*ddq_w + (MZ_9l*Z100 - MY_9l*Z108 - Z333*m_9l)*ddq_1l + (MZ_9l*Z101 - MY_9l*Z109 - Z334*m_9l)*ddq_2l + (MZ_9l*Z102 - MY_9l*Z110 - Z335*m_9l)*ddq_3l + (MZ_9l*Z103 - MY_9l*Z111 - Z336*m_9l)*ddq_4l + (MZ_9l*Z104 - MY_9l*Z112)*ddq_5l + (MZ_9l*(Z534 + Z99*ddq_torso) - Z96*(MX_9l*Z96 - MZ_9l*Z94) - MY_9l*(Z535 + Z107*ddq_torso) - Z95*(MX_9l*Z95 - MY_9l*Z94) - m_9l*(Z575 + Z332*ddq_torso))
%      (Z348*m_9l)*ddx + (MX_9l*Z105 + MZ_9l*Z80 + Z349*m_9l)*ddpsi + (MX_9l*Z106 + MZ_9l*Z81 + Z350*m_9l)*ddq_imu + (MX_9l*Z106 + MZ_9l*Z81 + Z351*m_9l)*ddq_w + (MX_9l*Z108 + MZ_9l*Z83 + Z353*m_9l)*ddq_1l + (MX_9l*Z109 + MZ_9l*Z84 + Z354*m_9l)*ddq_2l + (MX_9l*Z110 + MZ_9l*Z85 + Z355*m_9l)*ddq_3l + (MX_9l*Z111 + MZ_9l*Z86 + Z356*m_9l)*ddq_4l + (MX_9l*Z112)*ddq_5l + MZ_9l*ddq_6l + (Z94*(MX_9l*Z95 - MY_9l*Z94) - Z96*(MY_9l*Z96 - MZ_9l*Z95) + MX_9l*(Z535 + Z107*ddq_torso) + MZ_9l*(Z532 + Z82*ddq_torso) + m_9l*(Z578 + Z352*ddq_torso))
%      (Z357*m_9l)*ddx + (Z358*m_9l - MY_9l*Z80 - MX_9l*Z97)*ddpsi + (Z359*m_9l - MY_9l*Z81 - MX_9l*Z98)*ddq_imu + (Z360*m_9l - MY_9l*Z81 - MX_9l*Z98)*ddq_w + (Z362*m_9l - MY_9l*Z83 - MX_9l*Z100)*ddq_1l + (Z363*m_9l - MY_9l*Z84 - MX_9l*Z101)*ddq_2l + (Z364*m_9l - MY_9l*Z85 - MX_9l*Z102)*ddq_3l + (Z365*m_9l - MY_9l*Z86 - MX_9l*Z103)*ddq_4l + (-MX_9l*Z104)*ddq_5l + (-MY_9l)*ddq_6l + (Z94*(MX_9l*Z96 - MZ_9l*Z94) + Z95*(MY_9l*Z96 - MZ_9l*Z95) - MX_9l*(Z534 + Z99*ddq_torso) - MY_9l*(Z532 + Z82*ddq_torso) + m_9l*(Z579 + Z361*ddq_torso))
Z1007 = MY_9l*Z357 - MZ_9l*Z348;
Z1008 = MY_9l*Z358 - MZ_9l*Z349 - XX_9l*Z80 + XY_9l*Z97 + XZ_9l*Z105;
Z1009 = MY_9l*Z359 - MZ_9l*Z350 - XX_9l*Z81 + XY_9l*Z98 + XZ_9l*Z106;
Z1010 = MY_9l*Z360 - MZ_9l*Z351 - XX_9l*Z81 + XY_9l*Z98 + XZ_9l*Z106;
Z1011 = MY_9l*Z361 - MZ_9l*Z352 - XX_9l*Z82 + XY_9l*Z99 + XZ_9l*Z107;
Z1012 = MY_9l*Z362 - MZ_9l*Z353 - XX_9l*Z83 + XY_9l*Z100 + XZ_9l*Z108;
Z1013 = MY_9l*Z363 - MZ_9l*Z354 - XX_9l*Z84 + XY_9l*Z101 + XZ_9l*Z109;
Z1014 = MY_9l*Z364 - MZ_9l*Z355 - XX_9l*Z85 + XY_9l*Z102 + XZ_9l*Z110;
Z1015 = MY_9l*Z365 - MZ_9l*Z356 - XX_9l*Z86 + XY_9l*Z103 + XZ_9l*Z111;
Z1016 = XY_9l*Z104 + XZ_9l*Z112;
Z1017 = -XX_9l;
Z1018 = MY_9l*Z579 - MZ_9l*Z578 - XX_9l*Z532 + XY_9l*Z534 + XZ_9l*Z535 + YZ_9l*Z95^2 - YZ_9l*Z96^2 - XY_9l*Z94*Z96 + XZ_9l*Z94*Z95 - YY_9l*Z95*Z96 + Z95*Z96*ZZ_9l;
 
Z1019 = - MX_9l*Z357 - MZ_9l*Z328;
Z1020 = YY_9l*Z97 - MZ_9l*Z329 - XY_9l*Z80 - MX_9l*Z358 + YZ_9l*Z105;
Z1021 = YY_9l*Z98 - MZ_9l*Z330 - XY_9l*Z81 - MX_9l*Z359 + YZ_9l*Z106;
Z1022 = YY_9l*Z98 - MZ_9l*Z331 - XY_9l*Z81 - MX_9l*Z360 + YZ_9l*Z106;
Z1023 = YY_9l*Z99 - MZ_9l*Z332 - XY_9l*Z82 - MX_9l*Z361 + YZ_9l*Z107;
Z1024 = YY_9l*Z100 - MZ_9l*Z333 - XY_9l*Z83 - MX_9l*Z362 + YZ_9l*Z108;
Z1025 = YY_9l*Z101 - MZ_9l*Z334 - XY_9l*Z84 - MX_9l*Z363 + YZ_9l*Z109;
Z1026 = YY_9l*Z102 - MZ_9l*Z335 - XY_9l*Z85 - MX_9l*Z364 + YZ_9l*Z110;
Z1027 = YY_9l*Z103 - MZ_9l*Z336 - XY_9l*Z86 - MX_9l*Z365 + YZ_9l*Z111;
Z1028 = YY_9l*Z104 + YZ_9l*Z112;
Z1029 = -XY_9l;
Z1030 = YY_9l*Z534 - MZ_9l*Z575 - XY_9l*Z532 - MX_9l*Z579 + YZ_9l*Z535 - XZ_9l*Z94^2 + XZ_9l*Z96^2 + XX_9l*Z94*Z96 + XY_9l*Z95*Z96 - YZ_9l*Z94*Z95 - Z94*Z96*ZZ_9l;
 
Z1031 = MX_9l*Z348 + MY_9l*Z328;
Z1032 = MX_9l*Z349 + MY_9l*Z329 - XZ_9l*Z80 + YZ_9l*Z97 + Z105*ZZ_9l;
Z1033 = MX_9l*Z350 + MY_9l*Z330 - XZ_9l*Z81 + YZ_9l*Z98 + Z106*ZZ_9l;
Z1034 = MX_9l*Z351 + MY_9l*Z331 - XZ_9l*Z81 + YZ_9l*Z98 + Z106*ZZ_9l;
Z1035 = MX_9l*Z352 + MY_9l*Z332 - XZ_9l*Z82 + YZ_9l*Z99 + Z107*ZZ_9l;
Z1036 = MX_9l*Z353 + MY_9l*Z333 - XZ_9l*Z83 + YZ_9l*Z100 + Z108*ZZ_9l;
Z1037 = MX_9l*Z354 + MY_9l*Z334 - XZ_9l*Z84 + YZ_9l*Z101 + Z109*ZZ_9l;
Z1038 = MX_9l*Z355 + MY_9l*Z335 - XZ_9l*Z85 + YZ_9l*Z102 + Z110*ZZ_9l;
Z1039 = MX_9l*Z356 + MY_9l*Z336 - XZ_9l*Z86 + YZ_9l*Z103 + Z111*ZZ_9l;
Z1040 = YZ_9l*Z104 + Z112*ZZ_9l;
Z1041 = -XZ_9l;
Z1042 = MX_9l*Z578 + MY_9l*Z575 - XZ_9l*Z532 + YZ_9l*Z534 + Z535*ZZ_9l + XY_9l*Z94^2 - XY_9l*Z95^2 - XX_9l*Z94*Z95 - XZ_9l*Z95*Z96 + YY_9l*Z94*Z95 + YZ_9l*Z94*Z96;
 
dHnew9l = [Z1007*ddx+Z1008*ddpsi+Z1009*ddq_imu+Z1010*ddq_w+Z1011*ddq_torso+Z1012*ddq_1l+Z1013*ddq_2l+Z1014*ddq_3l+Z1015*ddq_4l+Z1016*ddq_5l+Z1017*ddq_6l+Z1018;
    Z1019*ddx+Z1020*ddpsi+Z1021*ddq_imu+Z1022*ddq_w+Z1023*ddq_torso+Z1024*ddq_1l+Z1025*ddq_2l+Z1026*ddq_3l+Z1027*ddq_4l+Z1028*ddq_5l+Z1029*ddq_6l+Z1030;
    Z1031*ddx+Z1032*ddpsi+Z1033*ddq_imu+Z1034*ddq_w+Z1035*ddq_torso+Z1036*ddq_1l+Z1037*ddq_2l+Z1038*ddq_3l+Z1039*ddq_4l+Z1040*ddq_5l+Z1041*ddq_6l+Z1042];
 
 
% maG10l = 
%
%      (Z368*m_10l)*ddx + (MY_10l*Z97 + MZ_10l*Z125 + Z369*m_10l)*ddpsi + (MY_10l*Z98 + MZ_10l*Z126 + Z370*m_10l)*ddq_imu + (MY_10l*Z98 + MZ_10l*Z126 + Z371*m_10l)*ddq_w + (MY_10l*Z100 + MZ_10l*Z128 + Z373*m_10l)*ddq_1l + (MY_10l*Z101 + MZ_10l*Z129 + Z374*m_10l)*ddq_2l + (MY_10l*Z102 + MZ_10l*Z130 + Z375*m_10l)*ddq_3l + (MY_10l*Z103 + MZ_10l*Z131 + Z376*m_10l)*ddq_4l + (MY_10l*Z104 + MZ_10l*Z132 + Z377*m_10l)*ddq_5l + (MZ_10l*Z133 + Z378*m_10l)*ddq_6l + MY_10l*ddq_7l + (MY_10l*(Z534 + Z99*ddq_torso) - Z115*(MX_10l*Z115 - MZ_10l*Z113) - Z114*(MX_10l*Z114 - MY_10l*Z113) + MZ_10l*(Z537 + Z127*ddq_torso) + m_10l*(Z580 + Z372*ddq_torso))
%      (Z379*m_10l)*ddx + (Z380*m_10l - MZ_10l*Z116 - MX_10l*Z97)*ddpsi + (Z381*m_10l - MZ_10l*Z117 - MX_10l*Z98)*ddq_imu + (Z382*m_10l - MZ_10l*Z117 - MX_10l*Z98)*ddq_w + (Z384*m_10l - MZ_10l*Z119 - MX_10l*Z100)*ddq_1l + (Z385*m_10l - MZ_10l*Z120 - MX_10l*Z101)*ddq_2l + (Z386*m_10l - MZ_10l*Z121 - MX_10l*Z102)*ddq_3l + (Z387*m_10l - MZ_10l*Z122 - MX_10l*Z103)*ddq_4l + (Z388*m_10l - MZ_10l*Z123 - MX_10l*Z104)*ddq_5l + (Z389*m_10l - MZ_10l*Z124)*ddq_6l + (-MX_10l)*ddq_7l + (Z113*(MX_10l*Z114 - MY_10l*Z113) - Z115*(MY_10l*Z115 - MZ_10l*Z114) - MX_10l*(Z534 + Z99*ddq_torso) - MZ_10l*(Z536 + Z118*ddq_torso) + m_10l*(Z581 + Z383*ddq_torso))
%      (-Z348*m_10l)*ddx + (MY_10l*Z116 - MX_10l*Z125 - Z349*m_10l)*ddpsi + (MY_10l*Z117 - MX_10l*Z126 - Z350*m_10l)*ddq_imu + (MY_10l*Z117 - MX_10l*Z126 - Z351*m_10l)*ddq_w + (MY_10l*Z119 - MX_10l*Z128 - Z353*m_10l)*ddq_1l + (MY_10l*Z120 - MX_10l*Z129 - Z354*m_10l)*ddq_2l + (MY_10l*Z121 - MX_10l*Z130 - Z355*m_10l)*ddq_3l + (MY_10l*Z122 - MX_10l*Z131 - Z356*m_10l)*ddq_4l + (MY_10l*Z123 - MX_10l*Z132)*ddq_5l + (MY_10l*Z124 - MX_10l*Z133)*ddq_6l + (Z113*(MX_10l*Z115 - MZ_10l*Z113) + Z114*(MY_10l*Z115 - MZ_10l*Z114) - MX_10l*(Z537 + Z127*ddq_torso) + MY_10l*(Z536 + Z118*ddq_torso) + m_10l*(Z582 - Z352*ddq_torso))
Z1043 = Z368*m_10l;
Z1044 = MY_10l*Z97 + MZ_10l*Z125 + Z369*m_10l;
Z1045 = MY_10l*Z98 + MZ_10l*Z126 + Z370*m_10l;
Z1046 = MY_10l*Z98 + MZ_10l*Z126 + Z371*m_10l;
Z1047 = MY_10l*Z99 + MZ_10l*Z127 + Z372*m_10l;
Z1048 = MY_10l*Z100 + MZ_10l*Z128 + Z373*m_10l;
Z1049 = MY_10l*Z101 + MZ_10l*Z129 + Z374*m_10l;
Z1050 = MY_10l*Z102 + MZ_10l*Z130 + Z375*m_10l;
Z1051 = MY_10l*Z103 + MZ_10l*Z131 + Z376*m_10l;
Z1052 = MY_10l*Z104 + MZ_10l*Z132 + Z377*m_10l;
Z1053 = MZ_10l*Z133 + Z378*m_10l;
Z1054 = MY_10l;
Z1055 = MY_10l*Z534 + MZ_10l*Z537 + Z580*m_10l - MX_10l*Z114^2 - MX_10l*Z115^2 + MY_10l*Z113*Z114 + MZ_10l*Z113*Z115;
 
Z1056 = Z379*m_10l;
Z1057 = Z380*m_10l - MZ_10l*Z116 - MX_10l*Z97;
Z1058 = Z381*m_10l - MZ_10l*Z117 - MX_10l*Z98;
Z1059 = Z382*m_10l - MZ_10l*Z117 - MX_10l*Z98;
Z1060 = Z383*m_10l - MZ_10l*Z118 - MX_10l*Z99;
Z1061 = Z384*m_10l - MZ_10l*Z119 - MX_10l*Z100;
Z1062 = Z385*m_10l - MZ_10l*Z120 - MX_10l*Z101;
Z1063 = Z386*m_10l - MZ_10l*Z121 - MX_10l*Z102;
Z1064 = Z387*m_10l - MZ_10l*Z122 - MX_10l*Z103;
Z1065 = Z388*m_10l - MZ_10l*Z123 - MX_10l*Z104;
Z1066 = Z389*m_10l - MZ_10l*Z124;
Z1067 = -MX_10l;
Z1068 = Z581*m_10l - MZ_10l*Z536 - MX_10l*Z534 - MY_10l*Z113^2 - MY_10l*Z115^2 + MX_10l*Z113*Z114 + MZ_10l*Z114*Z115;
 
Z1069 = -Z348*m_10l;
Z1070 = MY_10l*Z116 - MX_10l*Z125 - Z349*m_10l;
Z1071 = MY_10l*Z117 - MX_10l*Z126 - Z350*m_10l;
Z1072 = MY_10l*Z117 - MX_10l*Z126 - Z351*m_10l;
Z1073 = MY_10l*Z118 - MX_10l*Z127 - Z352*m_10l;
Z1074 = MY_10l*Z119 - MX_10l*Z128 - Z353*m_10l;
Z1075 = MY_10l*Z120 - MX_10l*Z129 - Z354*m_10l;
Z1076 = MY_10l*Z121 - MX_10l*Z130 - Z355*m_10l;
Z1077 = MY_10l*Z122 - MX_10l*Z131 - Z356*m_10l;
Z1078 = MY_10l*Z123 - MX_10l*Z132;
Z1079 = MY_10l*Z124 - MX_10l*Z133;
Z1080 = MY_10l*Z536 - MX_10l*Z537 + Z582*m_10l - MZ_10l*Z113^2 - MZ_10l*Z114^2 + MX_10l*Z113*Z115 + MY_10l*Z114*Z115;
 
maG10l = [Z1043*ddx+Z1044*ddpsi+Z1045*ddq_imu+Z1046*ddq_w+Z1047*ddq_torso+Z1048*ddq_1l+Z1049*ddq_2l+Z1050*ddq_3l+Z1051*ddq_4l+Z1052*ddq_5l+Z1053*ddq_6l+Z1054*ddq_7l+Z1055;
    Z1056*ddx+Z1057*ddpsi+Z1058*ddq_imu+Z1059*ddq_w+Z1060*ddq_torso+Z1061*ddq_1l+Z1062*ddq_2l+Z1063*ddq_3l+Z1064*ddq_4l+Z1065*ddq_5l+Z1066*ddq_6l+Z1067*ddq_7l+Z1068;
    Z1069*ddx+Z1070*ddpsi+Z1071*ddq_imu+Z1072*ddq_w+Z1073*ddq_torso+Z1074*ddq_1l+Z1075*ddq_2l+Z1076*ddq_3l+Z1077*ddq_4l+Z1078*ddq_5l+Z1079*ddq_6l+Z1080];
 
% dHnew10l = 
%
%      (Z368*m_10l)*ddx + (MY_10l*Z97 + MZ_10l*Z125 + Z369*m_10l)*ddpsi + (MY_10l*Z98 + MZ_10l*Z126 + Z370*m_10l)*ddq_imu + (MY_10l*Z98 + MZ_10l*Z126 + Z371*m_10l)*ddq_w + (MY_10l*Z100 + MZ_10l*Z128 + Z373*m_10l)*ddq_1l + (MY_10l*Z101 + MZ_10l*Z129 + Z374*m_10l)*ddq_2l + (MY_10l*Z102 + MZ_10l*Z130 + Z375*m_10l)*ddq_3l + (MY_10l*Z103 + MZ_10l*Z131 + Z376*m_10l)*ddq_4l + (MY_10l*Z104 + MZ_10l*Z132 + Z377*m_10l)*ddq_5l + (MZ_10l*Z133 + Z378*m_10l)*ddq_6l + MY_10l*ddq_7l + (MY_10l*(Z534 + Z99*ddq_torso) - Z115*(MX_10l*Z115 - MZ_10l*Z113) - Z114*(MX_10l*Z114 - MY_10l*Z113) + MZ_10l*(Z537 + Z127*ddq_torso) + m_10l*(Z580 + Z372*ddq_torso))
%      (Z379*m_10l)*ddx + (Z380*m_10l - MZ_10l*Z116 - MX_10l*Z97)*ddpsi + (Z381*m_10l - MZ_10l*Z117 - MX_10l*Z98)*ddq_imu + (Z382*m_10l - MZ_10l*Z117 - MX_10l*Z98)*ddq_w + (Z384*m_10l - MZ_10l*Z119 - MX_10l*Z100)*ddq_1l + (Z385*m_10l - MZ_10l*Z120 - MX_10l*Z101)*ddq_2l + (Z386*m_10l - MZ_10l*Z121 - MX_10l*Z102)*ddq_3l + (Z387*m_10l - MZ_10l*Z122 - MX_10l*Z103)*ddq_4l + (Z388*m_10l - MZ_10l*Z123 - MX_10l*Z104)*ddq_5l + (Z389*m_10l - MZ_10l*Z124)*ddq_6l + (-MX_10l)*ddq_7l + (Z113*(MX_10l*Z114 - MY_10l*Z113) - Z115*(MY_10l*Z115 - MZ_10l*Z114) - MX_10l*(Z534 + Z99*ddq_torso) - MZ_10l*(Z536 + Z118*ddq_torso) + m_10l*(Z581 + Z383*ddq_torso))
%      (-Z348*m_10l)*ddx + (MY_10l*Z116 - MX_10l*Z125 - Z349*m_10l)*ddpsi + (MY_10l*Z117 - MX_10l*Z126 - Z350*m_10l)*ddq_imu + (MY_10l*Z117 - MX_10l*Z126 - Z351*m_10l)*ddq_w + (MY_10l*Z119 - MX_10l*Z128 - Z353*m_10l)*ddq_1l + (MY_10l*Z120 - MX_10l*Z129 - Z354*m_10l)*ddq_2l + (MY_10l*Z121 - MX_10l*Z130 - Z355*m_10l)*ddq_3l + (MY_10l*Z122 - MX_10l*Z131 - Z356*m_10l)*ddq_4l + (MY_10l*Z123 - MX_10l*Z132)*ddq_5l + (MY_10l*Z124 - MX_10l*Z133)*ddq_6l + (Z113*(MX_10l*Z115 - MZ_10l*Z113) + Z114*(MY_10l*Z115 - MZ_10l*Z114) - MX_10l*(Z537 + Z127*ddq_torso) + MY_10l*(Z536 + Z118*ddq_torso) + m_10l*(Z582 - Z352*ddq_torso))
Z1081 = - MY_10l*Z348 - MZ_10l*Z379;
Z1082 = XX_10l*Z116 - MZ_10l*Z380 - MY_10l*Z349 + XY_10l*Z125 - XZ_10l*Z97;
Z1083 = XX_10l*Z117 - MZ_10l*Z381 - MY_10l*Z350 + XY_10l*Z126 - XZ_10l*Z98;
Z1084 = XX_10l*Z117 - MZ_10l*Z382 - MY_10l*Z351 + XY_10l*Z126 - XZ_10l*Z98;
Z1085 = XX_10l*Z118 - MZ_10l*Z383 - MY_10l*Z352 + XY_10l*Z127 - XZ_10l*Z99;
Z1086 = XX_10l*Z119 - MZ_10l*Z384 - MY_10l*Z353 + XY_10l*Z128 - XZ_10l*Z100;
Z1087 = XX_10l*Z120 - MZ_10l*Z385 - MY_10l*Z354 + XY_10l*Z129 - XZ_10l*Z101;
Z1088 = XX_10l*Z121 - MZ_10l*Z386 - MY_10l*Z355 + XY_10l*Z130 - XZ_10l*Z102;
Z1089 = XX_10l*Z122 - MZ_10l*Z387 - MY_10l*Z356 + XY_10l*Z131 - XZ_10l*Z103;
Z1090 = XX_10l*Z123 - MZ_10l*Z388 + XY_10l*Z132 - XZ_10l*Z104;
Z1091 = XX_10l*Z124 - MZ_10l*Z389 + XY_10l*Z133;
Z1092 = -XZ_10l;
Z1093 = MY_10l*Z582 - MZ_10l*Z581 + XX_10l*Z536 + XY_10l*Z537 - XZ_10l*Z534 + YZ_10l*Z114^2 - YZ_10l*Z115^2 - XY_10l*Z113*Z115 + XZ_10l*Z113*Z114 - YY_10l*Z114*Z115 + Z114*Z115*ZZ_10l;
 
Z1094 = MX_10l*Z348 + MZ_10l*Z368;
Z1095 = MX_10l*Z349 + MZ_10l*Z369 + XY_10l*Z116 + YY_10l*Z125 - YZ_10l*Z97;
Z1096 = MX_10l*Z350 + MZ_10l*Z370 + XY_10l*Z117 + YY_10l*Z126 - YZ_10l*Z98;
Z1097 = MX_10l*Z351 + MZ_10l*Z371 + XY_10l*Z117 + YY_10l*Z126 - YZ_10l*Z98;
Z1098 = MX_10l*Z352 + MZ_10l*Z372 + XY_10l*Z118 + YY_10l*Z127 - YZ_10l*Z99;
Z1099 = MX_10l*Z353 + MZ_10l*Z373 + XY_10l*Z119 + YY_10l*Z128 - YZ_10l*Z100;
Z1100 = MX_10l*Z354 + MZ_10l*Z374 + XY_10l*Z120 + YY_10l*Z129 - YZ_10l*Z101;
Z1101 = MX_10l*Z355 + MZ_10l*Z375 + XY_10l*Z121 + YY_10l*Z130 - YZ_10l*Z102;
Z1102 = MX_10l*Z356 + MZ_10l*Z376 + XY_10l*Z122 + YY_10l*Z131 - YZ_10l*Z103;
Z1103 = MZ_10l*Z377 + XY_10l*Z123 + YY_10l*Z132 - YZ_10l*Z104;
Z1104 = MZ_10l*Z378 + XY_10l*Z124 + YY_10l*Z133;
Z1105 = -YZ_10l;
Z1106 = MZ_10l*Z580 - MX_10l*Z582 + XY_10l*Z536 + YY_10l*Z537 - YZ_10l*Z534 - XZ_10l*Z113^2 + XZ_10l*Z115^2 + XX_10l*Z113*Z115 + XY_10l*Z114*Z115 - YZ_10l*Z113*Z114 - Z113*Z115*ZZ_10l;
 
Z1107 = MX_10l*Z379 - MY_10l*Z368;
Z1108 = MX_10l*Z380 - MY_10l*Z369 + XZ_10l*Z116 + YZ_10l*Z125 - Z97*ZZ_10l;
Z1109 = MX_10l*Z381 - MY_10l*Z370 + XZ_10l*Z117 + YZ_10l*Z126 - Z98*ZZ_10l;
Z1110 = MX_10l*Z382 - MY_10l*Z371 + XZ_10l*Z117 + YZ_10l*Z126 - Z98*ZZ_10l;
Z1111 = MX_10l*Z383 - MY_10l*Z372 + XZ_10l*Z118 + YZ_10l*Z127 - Z99*ZZ_10l;
Z1112 = MX_10l*Z384 - MY_10l*Z373 + XZ_10l*Z119 + YZ_10l*Z128 - Z100*ZZ_10l;
Z1113 = MX_10l*Z385 - MY_10l*Z374 + XZ_10l*Z120 + YZ_10l*Z129 - Z101*ZZ_10l;
Z1114 = MX_10l*Z386 - MY_10l*Z375 + XZ_10l*Z121 + YZ_10l*Z130 - Z102*ZZ_10l;
Z1115 = MX_10l*Z387 - MY_10l*Z376 + XZ_10l*Z122 + YZ_10l*Z131 - Z103*ZZ_10l;
Z1116 = MX_10l*Z388 - MY_10l*Z377 + XZ_10l*Z123 + YZ_10l*Z132 - Z104*ZZ_10l;
Z1117 = MX_10l*Z389 - MY_10l*Z378 + XZ_10l*Z124 + YZ_10l*Z133;
Z1118 = -ZZ_10l;
Z1119 = MX_10l*Z581 - MY_10l*Z580 + XZ_10l*Z536 + YZ_10l*Z537 - Z534*ZZ_10l + XY_10l*Z113^2 - XY_10l*Z114^2 - XX_10l*Z113*Z114 - XZ_10l*Z114*Z115 + YY_10l*Z113*Z114 + YZ_10l*Z113*Z115;
 
dHnew10l = [Z1081*ddx+Z1082*ddpsi+Z1083*ddq_imu+Z1084*ddq_w+Z1085*ddq_torso+Z1086*ddq_1l+Z1087*ddq_2l+Z1088*ddq_3l+Z1089*ddq_4l+Z1090*ddq_5l+Z1091*ddq_6l+Z1092*ddq_7l+Z1093;
    Z1094*ddx+Z1095*ddpsi+Z1096*ddq_imu+Z1097*ddq_w+Z1098*ddq_torso+Z1099*ddq_1l+Z1100*ddq_2l+Z1101*ddq_3l+Z1102*ddq_4l+Z1103*ddq_5l+Z1104*ddq_6l+Z1105*ddq_7l+Z1106;
    Z1107*ddx+Z1108*ddpsi+Z1109*ddq_imu+Z1110*ddq_w+Z1111*ddq_torso+Z1112*ddq_1l+Z1113*ddq_2l+Z1114*ddq_3l+Z1115*ddq_4l+Z1116*ddq_5l+Z1117*ddq_6l+Z1118*ddq_7l+Z1119];
 
 
% maG4r = 
%
%      (Z393*m_4r)*ddx + (Z394*m_4r - MZ_4r*Z26 - MY_4r*Z140)*ddpsi + (Z395*m_4r - MZ_4r*Z25 - MY_4r*Z141)*ddq_imu + (Z396*m_4r - MZ_4r*Z25 - MY_4r*Z141)*ddq_w + (-MZ_4r)*ddq_1r + (m_4r*(Z583 + Z397*ddq_torso) - Z135*(MX_4r*Z135 - MY_4r*Z134) - Z136*(MX_4r*Z136 - MZ_4r*Z134) - MY_4r*(Z539 + Z142*ddq_torso) - MZ_4r*Z522)
%      (-Z257*m_4r)*ddx + (MX_4r*Z140 - MZ_4r*Z137 + Z398*m_4r)*ddpsi + (MX_4r*Z141 - MZ_4r*Z138 + Z399*m_4r)*ddq_imu + (MX_4r*Z141 - MZ_4r*Z138 + Z400*m_4r)*ddq_w + (Z134*(MX_4r*Z135 - MY_4r*Z134) - Z136*(MY_4r*Z136 - MZ_4r*Z135) + Z584*m_4r + MX_4r*(Z539 + Z142*ddq_torso) - MZ_4r*(Z538 + Z139*ddq_torso))
%      (Z401*m_4r)*ddx + (MX_4r*Z26 + MY_4r*Z137 + Z402*m_4r)*ddpsi + (MX_4r*Z25 + MY_4r*Z138 + Z403*m_4r)*ddq_imu + (MX_4r*Z25 + MY_4r*Z138 + Z404*m_4r)*ddq_w + MX_4r*ddq_1r + (MX_4r*Z522 + Z134*(MX_4r*Z136 - MZ_4r*Z134) + Z135*(MY_4r*Z136 - MZ_4r*Z135) + MY_4r*(Z538 + Z139*ddq_torso) + m_4r*(Z585 + Z405*ddq_torso))
Z1120 = Z393*m_4r;
Z1121 = Z394*m_4r - MZ_4r*Z26 - MY_4r*Z140;
Z1122 = Z395*m_4r - MZ_4r*Z25 - MY_4r*Z141;
Z1123 = Z396*m_4r - MZ_4r*Z25 - MY_4r*Z141;
Z1124 = Z397*m_4r - MY_4r*Z142;
Z1125 = -MZ_4r;
Z1126 = Z583*m_4r - MZ_4r*Z522 - MY_4r*Z539 - MX_4r*Z135^2 - MX_4r*Z136^2 + MY_4r*Z134*Z135 + MZ_4r*Z134*Z136;
 
Z1127 = -Z257*m_4r;
Z1128 = MX_4r*Z140 - MZ_4r*Z137 + Z398*m_4r;
Z1129 = MX_4r*Z141 - MZ_4r*Z138 + Z399*m_4r;
Z1130 = MX_4r*Z141 - MZ_4r*Z138 + Z400*m_4r;
Z1131 = MX_4r*Z142 - MZ_4r*Z139;
Z1132 = MX_4r*Z539 - MZ_4r*Z538 + Z584*m_4r - MY_4r*Z134^2 - MY_4r*Z136^2 + MX_4r*Z134*Z135 + MZ_4r*Z135*Z136;
 
Z1133 = Z401*m_4r;
Z1134 = MX_4r*Z26 + MY_4r*Z137 + Z402*m_4r;
Z1135 = MX_4r*Z25 + MY_4r*Z138 + Z403*m_4r;
Z1136 = MX_4r*Z25 + MY_4r*Z138 + Z404*m_4r;
Z1137 = MY_4r*Z139 + Z405*m_4r;
Z1138 = MX_4r;
Z1139 = MX_4r*Z522 + MY_4r*Z538 + Z585*m_4r - MZ_4r*Z134^2 - MZ_4r*Z135^2 + MX_4r*Z134*Z136 + MY_4r*Z135*Z136;
 
maG4r = [Z1120*ddx+Z1121*ddpsi+Z1122*ddq_imu+Z1123*ddq_w+Z1124*ddq_torso+Z1125*ddq_1r+Z1126;
    Z1127*ddx+Z1128*ddpsi+Z1129*ddq_imu+Z1130*ddq_w+Z1131*ddq_torso+Z1132;
    Z1133*ddx+Z1134*ddpsi+Z1135*ddq_imu+Z1136*ddq_w+Z1137*ddq_torso+Z1138*ddq_1r+Z1139];
 
% dHnew4r = 
%
%      (Z393*m_4r)*ddx + (Z394*m_4r - MZ_4r*Z26 - MY_4r*Z140)*ddpsi + (Z395*m_4r - MZ_4r*Z25 - MY_4r*Z141)*ddq_imu + (Z396*m_4r - MZ_4r*Z25 - MY_4r*Z141)*ddq_w + (-MZ_4r)*ddq_1r + (m_4r*(Z583 + Z397*ddq_torso) - Z135*(MX_4r*Z135 - MY_4r*Z134) - Z136*(MX_4r*Z136 - MZ_4r*Z134) - MY_4r*(Z539 + Z142*ddq_torso) - MZ_4r*Z522)
%      (-Z257*m_4r)*ddx + (MX_4r*Z140 - MZ_4r*Z137 + Z398*m_4r)*ddpsi + (MX_4r*Z141 - MZ_4r*Z138 + Z399*m_4r)*ddq_imu + (MX_4r*Z141 - MZ_4r*Z138 + Z400*m_4r)*ddq_w + (Z134*(MX_4r*Z135 - MY_4r*Z134) - Z136*(MY_4r*Z136 - MZ_4r*Z135) + Z584*m_4r + MX_4r*(Z539 + Z142*ddq_torso) - MZ_4r*(Z538 + Z139*ddq_torso))
%      (Z401*m_4r)*ddx + (MX_4r*Z26 + MY_4r*Z137 + Z402*m_4r)*ddpsi + (MX_4r*Z25 + MY_4r*Z138 + Z403*m_4r)*ddq_imu + (MX_4r*Z25 + MY_4r*Z138 + Z404*m_4r)*ddq_w + MX_4r*ddq_1r + (MX_4r*Z522 + Z134*(MX_4r*Z136 - MZ_4r*Z134) + Z135*(MY_4r*Z136 - MZ_4r*Z135) + MY_4r*(Z538 + Z139*ddq_torso) + m_4r*(Z585 + Z405*ddq_torso))
Z1140 = MY_4r*Z401 + MZ_4r*Z257;
Z1141 = MY_4r*Z402 - MZ_4r*Z398 + XX_4r*Z137 - XY_4r*Z26 + XZ_4r*Z140;
Z1142 = MY_4r*Z403 - MZ_4r*Z399 + XX_4r*Z138 - XY_4r*Z25 + XZ_4r*Z141;
Z1143 = MY_4r*Z404 - MZ_4r*Z400 + XX_4r*Z138 - XY_4r*Z25 + XZ_4r*Z141;
Z1144 = MY_4r*Z405 + XX_4r*Z139 + XZ_4r*Z142;
Z1145 = -XY_4r;
Z1146 = MY_4r*Z585 - MZ_4r*Z584 + XX_4r*Z538 - XY_4r*Z522 + XZ_4r*Z539 + YZ_4r*Z135^2 - YZ_4r*Z136^2 - XY_4r*Z134*Z136 + XZ_4r*Z134*Z135 - YY_4r*Z135*Z136 + Z135*Z136*ZZ_4r;
 
Z1147 = MZ_4r*Z393 - MX_4r*Z401;
Z1148 = MZ_4r*Z394 - MX_4r*Z402 + XY_4r*Z137 - YY_4r*Z26 + YZ_4r*Z140;
Z1149 = MZ_4r*Z395 - MX_4r*Z403 + XY_4r*Z138 - YY_4r*Z25 + YZ_4r*Z141;
Z1150 = MZ_4r*Z396 - MX_4r*Z404 + XY_4r*Z138 - YY_4r*Z25 + YZ_4r*Z141;
Z1151 = MZ_4r*Z397 - MX_4r*Z405 + XY_4r*Z139 + YZ_4r*Z142;
Z1152 = -YY_4r;
Z1153 = MZ_4r*Z583 - MX_4r*Z585 + XY_4r*Z538 - YY_4r*Z522 + YZ_4r*Z539 - XZ_4r*Z134^2 + XZ_4r*Z136^2 + XX_4r*Z134*Z136 + XY_4r*Z135*Z136 - YZ_4r*Z134*Z135 - Z134*Z136*ZZ_4r;
 
Z1154 = - MX_4r*Z257 - MY_4r*Z393;
Z1155 = MX_4r*Z398 - MY_4r*Z394 + XZ_4r*Z137 - YZ_4r*Z26 + Z140*ZZ_4r;
Z1156 = MX_4r*Z399 - MY_4r*Z395 + XZ_4r*Z138 - YZ_4r*Z25 + Z141*ZZ_4r;
Z1157 = MX_4r*Z400 - MY_4r*Z396 + XZ_4r*Z138 - YZ_4r*Z25 + Z141*ZZ_4r;
Z1158 = XZ_4r*Z139 - MY_4r*Z397 + Z142*ZZ_4r;
Z1159 = -YZ_4r;
Z1160 = MX_4r*Z584 - MY_4r*Z583 + XZ_4r*Z538 - YZ_4r*Z522 + Z539*ZZ_4r + XY_4r*Z134^2 - XY_4r*Z135^2 - XX_4r*Z134*Z135 - XZ_4r*Z135*Z136 + YY_4r*Z134*Z135 + YZ_4r*Z134*Z136;
 
dHnew4r = [Z1140*ddx+Z1141*ddpsi+Z1142*ddq_imu+Z1143*ddq_w+Z1144*ddq_torso+Z1145*ddq_1r+Z1146;
    Z1147*ddx+Z1148*ddpsi+Z1149*ddq_imu+Z1150*ddq_w+Z1151*ddq_torso+Z1152*ddq_1r+Z1153;
    Z1154*ddx+Z1155*ddpsi+Z1156*ddq_imu+Z1157*ddq_w+Z1158*ddq_torso+Z1159*ddq_1r+Z1160];
 
 
% maG5r = 
%
%      (-Z393*m_5r)*ddx + (-Z394*m_5r)*ddpsi + (-Z395*m_5r)*ddq_imu + (-Z396*m_5r)*ddq_w + (MZ_5r*(Z540 + Z146*dpsi + Z149*dq_1r + Z147*dq_w + Z147*dq_imu + Z148*dq_torso) - Z145*(MX_5r*Z145 - MZ_5r*Z143) - m_5r*(Z583 + Z397*ddq_torso) - MY_5r*(Z541 + Z150*dpsi + Z153*dq_1r + Z151*dq_w + Z151*dq_imu + Z152*dq_torso) - Z144*(MX_5r*Z144 - MY_5r*Z143))
%      (Z408*m_5r)*ddx + (Z409*m_5r)*ddpsi + (Z410*m_5r)*ddq_imu + (Z411*m_5r)*ddq_w + (Z143*(MX_5r*Z144 - MY_5r*Z143) - Z145*(MY_5r*Z145 - MZ_5r*Z144) + MZ_5r*(Z538 + dq_2r + Z137*dpsi + Z138*dq_w + Z138*dq_imu + Z139*dq_torso) + m_5r*(Z586 + Z412*ddq_torso) + MX_5r*(Z541 + Z150*dpsi + Z153*dq_1r + Z151*dq_w + Z151*dq_imu + Z152*dq_torso))
%      (Z413*m_5r)*ddx + (Z414*m_5r)*ddpsi + (Z415*m_5r)*ddq_imu + (Z416*m_5r)*ddq_w + (Z143*(MX_5r*Z145 - MZ_5r*Z143) + Z144*(MY_5r*Z145 - MZ_5r*Z144) - MY_5r*(Z538 + dq_2r + Z137*dpsi + Z138*dq_w + Z138*dq_imu + Z139*dq_torso) + m_5r*(Z587 + Z417*ddq_torso) - MX_5r*(Z540 + Z146*dpsi + Z149*dq_1r + Z147*dq_w + Z147*dq_imu + Z148*dq_torso))
Z1161 = -Z393*m_5r;
Z1162 = -Z394*m_5r;
Z1163 = -Z395*m_5r;
Z1164 = -Z396*m_5r;
Z1165 = -Z397*m_5r;
Z1166 = MZ_5r*Z540 - MY_5r*Z541 - Z583*m_5r - MX_5r*Z144^2 - MX_5r*Z145^2 + MY_5r*Z143*Z144 + MZ_5r*Z143*Z145 - MY_5r*Z150*dpsi - MY_5r*Z153*dq_1r - MY_5r*Z151*dq_w - MY_5r*Z151*dq_imu - MY_5r*Z152*dq_torso + MZ_5r*Z146*dpsi + MZ_5r*Z149*dq_1r + MZ_5r*Z147*dq_w + MZ_5r*Z147*dq_imu + MZ_5r*Z148*dq_torso;
 
Z1167 = Z408*m_5r;
Z1168 = Z409*m_5r;
Z1169 = Z410*m_5r;
Z1170 = Z411*m_5r;
Z1171 = Z412*m_5r;
Z1172 = MX_5r*Z541 + MZ_5r*Z538 + MZ_5r*dq_2r + Z586*m_5r - MY_5r*Z143^2 - MY_5r*Z145^2 + MX_5r*Z143*Z144 + MZ_5r*Z144*Z145 + MX_5r*Z150*dpsi + MX_5r*Z153*dq_1r + MX_5r*Z151*dq_w + MX_5r*Z151*dq_imu + MX_5r*Z152*dq_torso + MZ_5r*Z137*dpsi + MZ_5r*Z138*dq_w + MZ_5r*Z138*dq_imu + MZ_5r*Z139*dq_torso;
 
Z1173 = Z413*m_5r;
Z1174 = Z414*m_5r;
Z1175 = Z415*m_5r;
Z1176 = Z416*m_5r;
Z1177 = Z417*m_5r;
Z1178 = Z587*m_5r - MY_5r*Z538 - MY_5r*dq_2r - MX_5r*Z540 - MZ_5r*Z143^2 - MZ_5r*Z144^2 + MX_5r*Z143*Z145 + MY_5r*Z144*Z145 - MX_5r*Z146*dpsi - MX_5r*Z149*dq_1r - MX_5r*Z147*dq_w - MX_5r*Z147*dq_imu - MX_5r*Z148*dq_torso - MY_5r*Z137*dpsi - MY_5r*Z138*dq_w - MY_5r*Z138*dq_imu - MY_5r*Z139*dq_torso;
 
maG5r = [Z1161*ddx+Z1162*ddpsi+Z1163*ddq_imu+Z1164*ddq_w+Z1165*ddq_torso+Z1166;
    Z1167*ddx+Z1168*ddpsi+Z1169*ddq_imu+Z1170*ddq_w+Z1171*ddq_torso+Z1172;
    Z1173*ddx+Z1174*ddpsi+Z1175*ddq_imu+Z1176*ddq_w+Z1177*ddq_torso+Z1178];
 
% dHnew5r = 
%
%      (-Z393*m_5r)*ddx + (-Z394*m_5r)*ddpsi + (-Z395*m_5r)*ddq_imu + (-Z396*m_5r)*ddq_w + (MZ_5r*(Z540 + Z146*dpsi + Z149*dq_1r + Z147*dq_w + Z147*dq_imu + Z148*dq_torso) - Z145*(MX_5r*Z145 - MZ_5r*Z143) - m_5r*(Z583 + Z397*ddq_torso) - MY_5r*(Z541 + Z150*dpsi + Z153*dq_1r + Z151*dq_w + Z151*dq_imu + Z152*dq_torso) - Z144*(MX_5r*Z144 - MY_5r*Z143))
%      (Z408*m_5r)*ddx + (Z409*m_5r)*ddpsi + (Z410*m_5r)*ddq_imu + (Z411*m_5r)*ddq_w + (Z143*(MX_5r*Z144 - MY_5r*Z143) - Z145*(MY_5r*Z145 - MZ_5r*Z144) + MZ_5r*(Z538 + dq_2r + Z137*dpsi + Z138*dq_w + Z138*dq_imu + Z139*dq_torso) + m_5r*(Z586 + Z412*ddq_torso) + MX_5r*(Z541 + Z150*dpsi + Z153*dq_1r + Z151*dq_w + Z151*dq_imu + Z152*dq_torso))
%      (Z413*m_5r)*ddx + (Z414*m_5r)*ddpsi + (Z415*m_5r)*ddq_imu + (Z416*m_5r)*ddq_w + (Z143*(MX_5r*Z145 - MZ_5r*Z143) + Z144*(MY_5r*Z145 - MZ_5r*Z144) - MY_5r*(Z538 + dq_2r + Z137*dpsi + Z138*dq_w + Z138*dq_imu + Z139*dq_torso) + m_5r*(Z587 + Z417*ddq_torso) - MX_5r*(Z540 + Z146*dpsi + Z149*dq_1r + Z147*dq_w + Z147*dq_imu + Z148*dq_torso))
Z1179 = MY_5r*Z413 - MZ_5r*Z408;
Z1180 = MY_5r*Z414 - MZ_5r*Z409;
Z1181 = MY_5r*Z415 - MZ_5r*Z410;
Z1182 = MY_5r*Z416 - MZ_5r*Z411;
Z1183 = MY_5r*Z417 - MZ_5r*Z412;
Z1184 = MY_5r*Z587 - MZ_5r*Z586 - XX_5r*Z538 + XY_5r*Z540 + XZ_5r*Z541 - XX_5r*dq_2r + YZ_5r*Z144^2 - YZ_5r*Z145^2 - XY_5r*Z143*Z145 + XZ_5r*Z143*Z144 - YY_5r*Z144*Z145 + Z144*Z145*ZZ_5r - XX_5r*Z137*dpsi - XX_5r*Z138*dq_w - XX_5r*Z138*dq_imu - XX_5r*Z139*dq_torso + XY_5r*Z146*dpsi + XY_5r*Z149*dq_1r + XY_5r*Z147*dq_w + XY_5r*Z147*dq_imu + XY_5r*Z148*dq_torso + XZ_5r*Z150*dpsi + XZ_5r*Z153*dq_1r + XZ_5r*Z151*dq_w + XZ_5r*Z151*dq_imu + XZ_5r*Z152*dq_torso;
 
Z1185 = - MX_5r*Z413 - MZ_5r*Z393;
Z1186 = - MX_5r*Z414 - MZ_5r*Z394;
Z1187 = - MX_5r*Z415 - MZ_5r*Z395;
Z1188 = - MX_5r*Z416 - MZ_5r*Z396;
Z1189 = - MX_5r*Z417 - MZ_5r*Z397;
Z1190 = YY_5r*Z540 - MZ_5r*Z583 - XY_5r*Z538 - MX_5r*Z587 + YZ_5r*Z541 - XY_5r*dq_2r - XZ_5r*Z143^2 + XZ_5r*Z145^2 + XX_5r*Z143*Z145 + XY_5r*Z144*Z145 - YZ_5r*Z143*Z144 - Z143*Z145*ZZ_5r - XY_5r*Z137*dpsi - XY_5r*Z138*dq_w - XY_5r*Z138*dq_imu - XY_5r*Z139*dq_torso + YY_5r*Z146*dpsi + YY_5r*Z149*dq_1r + YY_5r*Z147*dq_w + YY_5r*Z147*dq_imu + YY_5r*Z148*dq_torso + YZ_5r*Z150*dpsi + YZ_5r*Z153*dq_1r + YZ_5r*Z151*dq_w + YZ_5r*Z151*dq_imu + YZ_5r*Z152*dq_torso;
 
Z1191 = MX_5r*Z408 + MY_5r*Z393;
Z1192 = MX_5r*Z409 + MY_5r*Z394;
Z1193 = MX_5r*Z410 + MY_5r*Z395;
Z1194 = MX_5r*Z411 + MY_5r*Z396;
Z1195 = MX_5r*Z412 + MY_5r*Z397;
Z1196 = MX_5r*Z586 + MY_5r*Z583 - XZ_5r*Z538 + YZ_5r*Z540 + Z541*ZZ_5r - XZ_5r*dq_2r + XY_5r*Z143^2 - XY_5r*Z144^2 - XX_5r*Z143*Z144 - XZ_5r*Z144*Z145 + YY_5r*Z143*Z144 + YZ_5r*Z143*Z145 - XZ_5r*Z137*dpsi - XZ_5r*Z138*dq_w - XZ_5r*Z138*dq_imu - XZ_5r*Z139*dq_torso + YZ_5r*Z146*dpsi + YZ_5r*Z149*dq_1r + YZ_5r*Z147*dq_w + YZ_5r*Z147*dq_imu + YZ_5r*Z148*dq_torso + Z150*ZZ_5r*dpsi + Z153*ZZ_5r*dq_1r + Z151*ZZ_5r*dq_w + Z151*ZZ_5r*dq_imu + Z152*ZZ_5r*dq_torso;
 
dHnew5r = [Z1179*ddx+Z1180*ddpsi+Z1181*ddq_imu+Z1182*ddq_w+Z1183*ddq_torso+Z1184;
    Z1185*ddx+Z1186*ddpsi+Z1187*ddq_imu+Z1188*ddq_w+Z1189*ddq_torso+Z1190;
    Z1191*ddx+Z1192*ddpsi+Z1193*ddq_imu+Z1194*ddq_w+Z1195*ddq_torso+Z1196];
 
 
% maG6r = 
%
%      (Z420*m_6r)*ddx + (Z421*m_6r - MZ_6r*Z146 - MY_6r*Z162)*ddpsi + (Z422*m_6r - MZ_6r*Z147 - MY_6r*Z163)*ddq_imu + (Z423*m_6r - MZ_6r*Z147 - MY_6r*Z163)*ddq_w + (Z425*m_6r - MZ_6r*Z149 - MY_6r*Z165)*ddq_1r + (Z426*m_6r - MY_6r*Z166)*ddq_2r + (-MZ_6r)*ddq_3r + (m_6r*(Z588 + Z424*ddq_torso) - Z156*(MX_6r*Z156 - MZ_6r*Z154) - MY_6r*(Z543 + Z164*ddq_torso) - MZ_6r*(Z540 + Z148*ddq_torso) - Z155*(MX_6r*Z155 - MY_6r*Z154))
%      (-Z408*m_6r)*ddx + (MX_6r*Z162 - MZ_6r*Z157 - Z409*m_6r)*ddpsi + (MX_6r*Z163 - MZ_6r*Z158 - Z410*m_6r)*ddq_imu + (MX_6r*Z163 - MZ_6r*Z158 - Z411*m_6r)*ddq_w + (MX_6r*Z165 - MZ_6r*Z160)*ddq_1r + (MX_6r*Z166 - MZ_6r*Z161)*ddq_2r + (Z154*(MX_6r*Z155 - MY_6r*Z154) - Z156*(MY_6r*Z156 - MZ_6r*Z155) + MX_6r*(Z543 + Z164*ddq_torso) - MZ_6r*(Z542 + Z159*ddq_torso) + m_6r*(Z589 - Z412*ddq_torso))
%      (Z427*m_6r)*ddx + (MX_6r*Z146 + MY_6r*Z157 + Z428*m_6r)*ddpsi + (MX_6r*Z147 + MY_6r*Z158 + Z429*m_6r)*ddq_imu + (MX_6r*Z147 + MY_6r*Z158 + Z430*m_6r)*ddq_w + (MX_6r*Z149 + MY_6r*Z160 + Z432*m_6r)*ddq_1r + (MY_6r*Z161 + Z433*m_6r)*ddq_2r + MX_6r*ddq_3r + (Z154*(MX_6r*Z156 - MZ_6r*Z154) + Z155*(MY_6r*Z156 - MZ_6r*Z155) + MX_6r*(Z540 + Z148*ddq_torso) + MY_6r*(Z542 + Z159*ddq_torso) + m_6r*(Z590 + Z431*ddq_torso))
Z1197 = Z420*m_6r;
Z1198 = Z421*m_6r - MZ_6r*Z146 - MY_6r*Z162;
Z1199 = Z422*m_6r - MZ_6r*Z147 - MY_6r*Z163;
Z1200 = Z423*m_6r - MZ_6r*Z147 - MY_6r*Z163;
Z1201 = Z424*m_6r - MZ_6r*Z148 - MY_6r*Z164;
Z1202 = Z425*m_6r - MZ_6r*Z149 - MY_6r*Z165;
Z1203 = Z426*m_6r - MY_6r*Z166;
Z1204 = -MZ_6r;
Z1205 = Z588*m_6r - MZ_6r*Z540 - MY_6r*Z543 - MX_6r*Z155^2 - MX_6r*Z156^2 + MY_6r*Z154*Z155 + MZ_6r*Z154*Z156;
 
Z1206 = -Z408*m_6r;
Z1207 = MX_6r*Z162 - MZ_6r*Z157 - Z409*m_6r;
Z1208 = MX_6r*Z163 - MZ_6r*Z158 - Z410*m_6r;
Z1209 = MX_6r*Z163 - MZ_6r*Z158 - Z411*m_6r;
Z1210 = MX_6r*Z164 - MZ_6r*Z159 - Z412*m_6r;
Z1211 = MX_6r*Z165 - MZ_6r*Z160;
Z1212 = MX_6r*Z166 - MZ_6r*Z161;
Z1213 = MX_6r*Z543 - MZ_6r*Z542 + Z589*m_6r - MY_6r*Z154^2 - MY_6r*Z156^2 + MX_6r*Z154*Z155 + MZ_6r*Z155*Z156;
 
Z1214 = Z427*m_6r;
Z1215 = MX_6r*Z146 + MY_6r*Z157 + Z428*m_6r;
Z1216 = MX_6r*Z147 + MY_6r*Z158 + Z429*m_6r;
Z1217 = MX_6r*Z147 + MY_6r*Z158 + Z430*m_6r;
Z1218 = MX_6r*Z148 + MY_6r*Z159 + Z431*m_6r;
Z1219 = MX_6r*Z149 + MY_6r*Z160 + Z432*m_6r;
Z1220 = MY_6r*Z161 + Z433*m_6r;
Z1221 = MX_6r;
Z1222 = MX_6r*Z540 + MY_6r*Z542 + Z590*m_6r - MZ_6r*Z154^2 - MZ_6r*Z155^2 + MX_6r*Z154*Z156 + MY_6r*Z155*Z156;
 
maG6r = [Z1197*ddx+Z1198*ddpsi+Z1199*ddq_imu+Z1200*ddq_w+Z1201*ddq_torso+Z1202*ddq_1r+Z1203*ddq_2r+Z1204*ddq_3r+Z1205;
    Z1206*ddx+Z1207*ddpsi+Z1208*ddq_imu+Z1209*ddq_w+Z1210*ddq_torso+Z1211*ddq_1r+Z1212*ddq_2r+Z1213;
    Z1214*ddx+Z1215*ddpsi+Z1216*ddq_imu+Z1217*ddq_w+Z1218*ddq_torso+Z1219*ddq_1r+Z1220*ddq_2r+Z1221*ddq_3r+Z1222];
 
% dHnew6r = 
%
%      (Z420*m_6r)*ddx + (Z421*m_6r - MZ_6r*Z146 - MY_6r*Z162)*ddpsi + (Z422*m_6r - MZ_6r*Z147 - MY_6r*Z163)*ddq_imu + (Z423*m_6r - MZ_6r*Z147 - MY_6r*Z163)*ddq_w + (Z425*m_6r - MZ_6r*Z149 - MY_6r*Z165)*ddq_1r + (Z426*m_6r - MY_6r*Z166)*ddq_2r + (-MZ_6r)*ddq_3r + (m_6r*(Z588 + Z424*ddq_torso) - Z156*(MX_6r*Z156 - MZ_6r*Z154) - MY_6r*(Z543 + Z164*ddq_torso) - MZ_6r*(Z540 + Z148*ddq_torso) - Z155*(MX_6r*Z155 - MY_6r*Z154))
%      (-Z408*m_6r)*ddx + (MX_6r*Z162 - MZ_6r*Z157 - Z409*m_6r)*ddpsi + (MX_6r*Z163 - MZ_6r*Z158 - Z410*m_6r)*ddq_imu + (MX_6r*Z163 - MZ_6r*Z158 - Z411*m_6r)*ddq_w + (MX_6r*Z165 - MZ_6r*Z160)*ddq_1r + (MX_6r*Z166 - MZ_6r*Z161)*ddq_2r + (Z154*(MX_6r*Z155 - MY_6r*Z154) - Z156*(MY_6r*Z156 - MZ_6r*Z155) + MX_6r*(Z543 + Z164*ddq_torso) - MZ_6r*(Z542 + Z159*ddq_torso) + m_6r*(Z589 - Z412*ddq_torso))
%      (Z427*m_6r)*ddx + (MX_6r*Z146 + MY_6r*Z157 + Z428*m_6r)*ddpsi + (MX_6r*Z147 + MY_6r*Z158 + Z429*m_6r)*ddq_imu + (MX_6r*Z147 + MY_6r*Z158 + Z430*m_6r)*ddq_w + (MX_6r*Z149 + MY_6r*Z160 + Z432*m_6r)*ddq_1r + (MY_6r*Z161 + Z433*m_6r)*ddq_2r + MX_6r*ddq_3r + (Z154*(MX_6r*Z156 - MZ_6r*Z154) + Z155*(MY_6r*Z156 - MZ_6r*Z155) + MX_6r*(Z540 + Z148*ddq_torso) + MY_6r*(Z542 + Z159*ddq_torso) + m_6r*(Z590 + Z431*ddq_torso))
Z1223 = MY_6r*Z427 + MZ_6r*Z408;
Z1224 = MY_6r*Z428 + MZ_6r*Z409 + XX_6r*Z157 - XY_6r*Z146 + XZ_6r*Z162;
Z1225 = MY_6r*Z429 + MZ_6r*Z410 + XX_6r*Z158 - XY_6r*Z147 + XZ_6r*Z163;
Z1226 = MY_6r*Z430 + MZ_6r*Z411 + XX_6r*Z158 - XY_6r*Z147 + XZ_6r*Z163;
Z1227 = MY_6r*Z431 + MZ_6r*Z412 + XX_6r*Z159 - XY_6r*Z148 + XZ_6r*Z164;
Z1228 = MY_6r*Z432 + XX_6r*Z160 - XY_6r*Z149 + XZ_6r*Z165;
Z1229 = MY_6r*Z433 + XX_6r*Z161 + XZ_6r*Z166;
Z1230 = -XY_6r;
Z1231 = MY_6r*Z590 - MZ_6r*Z589 + XX_6r*Z542 - XY_6r*Z540 + XZ_6r*Z543 + YZ_6r*Z155^2 - YZ_6r*Z156^2 - XY_6r*Z154*Z156 + XZ_6r*Z154*Z155 - YY_6r*Z155*Z156 + Z155*Z156*ZZ_6r;
 
Z1232 = MZ_6r*Z420 - MX_6r*Z427;
Z1233 = MZ_6r*Z421 - MX_6r*Z428 + XY_6r*Z157 - YY_6r*Z146 + YZ_6r*Z162;
Z1234 = MZ_6r*Z422 - MX_6r*Z429 + XY_6r*Z158 - YY_6r*Z147 + YZ_6r*Z163;
Z1235 = MZ_6r*Z423 - MX_6r*Z430 + XY_6r*Z158 - YY_6r*Z147 + YZ_6r*Z163;
Z1236 = MZ_6r*Z424 - MX_6r*Z431 + XY_6r*Z159 - YY_6r*Z148 + YZ_6r*Z164;
Z1237 = MZ_6r*Z425 - MX_6r*Z432 + XY_6r*Z160 - YY_6r*Z149 + YZ_6r*Z165;
Z1238 = MZ_6r*Z426 - MX_6r*Z433 + XY_6r*Z161 + YZ_6r*Z166;
Z1239 = -YY_6r;
Z1240 = MZ_6r*Z588 - MX_6r*Z590 + XY_6r*Z542 - YY_6r*Z540 + YZ_6r*Z543 - XZ_6r*Z154^2 + XZ_6r*Z156^2 + XX_6r*Z154*Z156 + XY_6r*Z155*Z156 - YZ_6r*Z154*Z155 - Z154*Z156*ZZ_6r;
 
Z1241 = - MX_6r*Z408 - MY_6r*Z420;
Z1242 = XZ_6r*Z157 - MY_6r*Z421 - MX_6r*Z409 - YZ_6r*Z146 + Z162*ZZ_6r;
Z1243 = XZ_6r*Z158 - MY_6r*Z422 - MX_6r*Z410 - YZ_6r*Z147 + Z163*ZZ_6r;
Z1244 = XZ_6r*Z158 - MY_6r*Z423 - MX_6r*Z411 - YZ_6r*Z147 + Z163*ZZ_6r;
Z1245 = XZ_6r*Z159 - MY_6r*Z424 - MX_6r*Z412 - YZ_6r*Z148 + Z164*ZZ_6r;
Z1246 = XZ_6r*Z160 - MY_6r*Z425 - YZ_6r*Z149 + Z165*ZZ_6r;
Z1247 = XZ_6r*Z161 - MY_6r*Z426 + Z166*ZZ_6r;
Z1248 = -YZ_6r;
Z1249 = MX_6r*Z589 - MY_6r*Z588 + XZ_6r*Z542 - YZ_6r*Z540 + Z543*ZZ_6r + XY_6r*Z154^2 - XY_6r*Z155^2 - XX_6r*Z154*Z155 - XZ_6r*Z155*Z156 + YY_6r*Z154*Z155 + YZ_6r*Z154*Z156;
 
dHnew6r = [Z1223*ddx+Z1224*ddpsi+Z1225*ddq_imu+Z1226*ddq_w+Z1227*ddq_torso+Z1228*ddq_1r+Z1229*ddq_2r+Z1230*ddq_3r+Z1231;
    Z1232*ddx+Z1233*ddpsi+Z1234*ddq_imu+Z1235*ddq_w+Z1236*ddq_torso+Z1237*ddq_1r+Z1238*ddq_2r+Z1239*ddq_3r+Z1240;
    Z1241*ddx+Z1242*ddpsi+Z1243*ddq_imu+Z1244*ddq_w+Z1245*ddq_torso+Z1246*ddq_1r+Z1247*ddq_2r+Z1248*ddq_3r+Z1249];
 
 
% maG7r = 
%
%      (-Z420*m_7r)*ddx + (MZ_7r*Z170 - MY_7r*Z176 - Z421*m_7r)*ddpsi + (MZ_7r*Z171 - MY_7r*Z177 - Z422*m_7r)*ddq_imu + (MZ_7r*Z171 - MY_7r*Z177 - Z423*m_7r)*ddq_w + (MZ_7r*Z173 - MY_7r*Z179 - Z425*m_7r)*ddq_1r + (MZ_7r*Z174 - MY_7r*Z180 - Z426*m_7r)*ddq_2r + (MZ_7r*Z175 - MY_7r*Z181)*ddq_3r + (MZ_7r*(Z544 + Z172*ddq_torso) - Z169*(MX_7r*Z169 - MZ_7r*Z167) - MY_7r*(Z545 + Z178*ddq_torso) - Z168*(MX_7r*Z168 - MY_7r*Z167) - m_7r*(Z588 + Z424*ddq_torso))
%      (Z436*m_7r)*ddx + (MX_7r*Z176 + MZ_7r*Z157 + Z437*m_7r)*ddpsi + (MX_7r*Z177 + MZ_7r*Z158 + Z438*m_7r)*ddq_imu + (MX_7r*Z177 + MZ_7r*Z158 + Z439*m_7r)*ddq_w + (MX_7r*Z179 + MZ_7r*Z160 + Z441*m_7r)*ddq_1r + (MX_7r*Z180 + MZ_7r*Z161 + Z442*m_7r)*ddq_2r + (MX_7r*Z181)*ddq_3r + MZ_7r*ddq_4r + (Z167*(MX_7r*Z168 - MY_7r*Z167) - Z169*(MY_7r*Z169 - MZ_7r*Z168) + MX_7r*(Z545 + Z178*ddq_torso) + MZ_7r*(Z542 + Z159*ddq_torso) + m_7r*(Z591 + Z440*ddq_torso))
%      (Z443*m_7r)*ddx + (Z444*m_7r - MY_7r*Z157 - MX_7r*Z170)*ddpsi + (Z445*m_7r - MY_7r*Z158 - MX_7r*Z171)*ddq_imu + (Z446*m_7r - MY_7r*Z158 - MX_7r*Z171)*ddq_w + (Z448*m_7r - MY_7r*Z160 - MX_7r*Z173)*ddq_1r + (Z449*m_7r - MY_7r*Z161 - MX_7r*Z174)*ddq_2r + (-MX_7r*Z175)*ddq_3r + (-MY_7r)*ddq_4r + (Z167*(MX_7r*Z169 - MZ_7r*Z167) + Z168*(MY_7r*Z169 - MZ_7r*Z168) - MX_7r*(Z544 + Z172*ddq_torso) - MY_7r*(Z542 + Z159*ddq_torso) + m_7r*(Z592 + Z447*ddq_torso))
Z1250 = -Z420*m_7r;
Z1251 = MZ_7r*Z170 - MY_7r*Z176 - Z421*m_7r;
Z1252 = MZ_7r*Z171 - MY_7r*Z177 - Z422*m_7r;
Z1253 = MZ_7r*Z171 - MY_7r*Z177 - Z423*m_7r;
Z1254 = MZ_7r*Z172 - MY_7r*Z178 - Z424*m_7r;
Z1255 = MZ_7r*Z173 - MY_7r*Z179 - Z425*m_7r;
Z1256 = MZ_7r*Z174 - MY_7r*Z180 - Z426*m_7r;
Z1257 = MZ_7r*Z175 - MY_7r*Z181;
Z1258 = MZ_7r*Z544 - MY_7r*Z545 - Z588*m_7r - MX_7r*Z168^2 - MX_7r*Z169^2 + MY_7r*Z167*Z168 + MZ_7r*Z167*Z169;
 
Z1259 = Z436*m_7r;
Z1260 = MX_7r*Z176 + MZ_7r*Z157 + Z437*m_7r;
Z1261 = MX_7r*Z177 + MZ_7r*Z158 + Z438*m_7r;
Z1262 = MX_7r*Z177 + MZ_7r*Z158 + Z439*m_7r;
Z1263 = MX_7r*Z178 + MZ_7r*Z159 + Z440*m_7r;
Z1264 = MX_7r*Z179 + MZ_7r*Z160 + Z441*m_7r;
Z1265 = MX_7r*Z180 + MZ_7r*Z161 + Z442*m_7r;
Z1266 = MX_7r*Z181;
Z1267 = MZ_7r;
Z1268 = MX_7r*Z545 + MZ_7r*Z542 + Z591*m_7r - MY_7r*Z167^2 - MY_7r*Z169^2 + MX_7r*Z167*Z168 + MZ_7r*Z168*Z169;
 
Z1269 = Z443*m_7r;
Z1270 = Z444*m_7r - MY_7r*Z157 - MX_7r*Z170;
Z1271 = Z445*m_7r - MY_7r*Z158 - MX_7r*Z171;
Z1272 = Z446*m_7r - MY_7r*Z158 - MX_7r*Z171;
Z1273 = Z447*m_7r - MY_7r*Z159 - MX_7r*Z172;
Z1274 = Z448*m_7r - MY_7r*Z160 - MX_7r*Z173;
Z1275 = Z449*m_7r - MY_7r*Z161 - MX_7r*Z174;
Z1276 = -MX_7r*Z175;
Z1277 = -MY_7r;
Z1278 = Z592*m_7r - MY_7r*Z542 - MX_7r*Z544 - MZ_7r*Z167^2 - MZ_7r*Z168^2 + MX_7r*Z167*Z169 + MY_7r*Z168*Z169;
 
maG7r = [Z1250*ddx+Z1251*ddpsi+Z1252*ddq_imu+Z1253*ddq_w+Z1254*ddq_torso+Z1255*ddq_1r+Z1256*ddq_2r+Z1257*ddq_3r+Z1258;
    Z1259*ddx+Z1260*ddpsi+Z1261*ddq_imu+Z1262*ddq_w+Z1263*ddq_torso+Z1264*ddq_1r+Z1265*ddq_2r+Z1266*ddq_3r+Z1267*ddq_4r+Z1268;
    Z1269*ddx+Z1270*ddpsi+Z1271*ddq_imu+Z1272*ddq_w+Z1273*ddq_torso+Z1274*ddq_1r+Z1275*ddq_2r+Z1276*ddq_3r+Z1277*ddq_4r+Z1278];
 
% dHnew7r = 
%
%      (-Z420*m_7r)*ddx + (MZ_7r*Z170 - MY_7r*Z176 - Z421*m_7r)*ddpsi + (MZ_7r*Z171 - MY_7r*Z177 - Z422*m_7r)*ddq_imu + (MZ_7r*Z171 - MY_7r*Z177 - Z423*m_7r)*ddq_w + (MZ_7r*Z173 - MY_7r*Z179 - Z425*m_7r)*ddq_1r + (MZ_7r*Z174 - MY_7r*Z180 - Z426*m_7r)*ddq_2r + (MZ_7r*Z175 - MY_7r*Z181)*ddq_3r + (MZ_7r*(Z544 + Z172*ddq_torso) - Z169*(MX_7r*Z169 - MZ_7r*Z167) - MY_7r*(Z545 + Z178*ddq_torso) - Z168*(MX_7r*Z168 - MY_7r*Z167) - m_7r*(Z588 + Z424*ddq_torso))
%      (Z436*m_7r)*ddx + (MX_7r*Z176 + MZ_7r*Z157 + Z437*m_7r)*ddpsi + (MX_7r*Z177 + MZ_7r*Z158 + Z438*m_7r)*ddq_imu + (MX_7r*Z177 + MZ_7r*Z158 + Z439*m_7r)*ddq_w + (MX_7r*Z179 + MZ_7r*Z160 + Z441*m_7r)*ddq_1r + (MX_7r*Z180 + MZ_7r*Z161 + Z442*m_7r)*ddq_2r + (MX_7r*Z181)*ddq_3r + MZ_7r*ddq_4r + (Z167*(MX_7r*Z168 - MY_7r*Z167) - Z169*(MY_7r*Z169 - MZ_7r*Z168) + MX_7r*(Z545 + Z178*ddq_torso) + MZ_7r*(Z542 + Z159*ddq_torso) + m_7r*(Z591 + Z440*ddq_torso))
%      (Z443*m_7r)*ddx + (Z444*m_7r - MY_7r*Z157 - MX_7r*Z170)*ddpsi + (Z445*m_7r - MY_7r*Z158 - MX_7r*Z171)*ddq_imu + (Z446*m_7r - MY_7r*Z158 - MX_7r*Z171)*ddq_w + (Z448*m_7r - MY_7r*Z160 - MX_7r*Z173)*ddq_1r + (Z449*m_7r - MY_7r*Z161 - MX_7r*Z174)*ddq_2r + (-MX_7r*Z175)*ddq_3r + (-MY_7r)*ddq_4r + (Z167*(MX_7r*Z169 - MZ_7r*Z167) + Z168*(MY_7r*Z169 - MZ_7r*Z168) - MX_7r*(Z544 + Z172*ddq_torso) - MY_7r*(Z542 + Z159*ddq_torso) + m_7r*(Z592 + Z447*ddq_torso))
Z1279 = MY_7r*Z443 - MZ_7r*Z436;
Z1280 = MY_7r*Z444 - MZ_7r*Z437 - XX_7r*Z157 + XY_7r*Z170 + XZ_7r*Z176;
Z1281 = MY_7r*Z445 - MZ_7r*Z438 - XX_7r*Z158 + XY_7r*Z171 + XZ_7r*Z177;
Z1282 = MY_7r*Z446 - MZ_7r*Z439 - XX_7r*Z158 + XY_7r*Z171 + XZ_7r*Z177;
Z1283 = MY_7r*Z447 - MZ_7r*Z440 - XX_7r*Z159 + XY_7r*Z172 + XZ_7r*Z178;
Z1284 = MY_7r*Z448 - MZ_7r*Z441 - XX_7r*Z160 + XY_7r*Z173 + XZ_7r*Z179;
Z1285 = MY_7r*Z449 - MZ_7r*Z442 - XX_7r*Z161 + XY_7r*Z174 + XZ_7r*Z180;
Z1286 = XY_7r*Z175 + XZ_7r*Z181;
Z1287 = -XX_7r;
Z1288 = MY_7r*Z592 - MZ_7r*Z591 - XX_7r*Z542 + XY_7r*Z544 + XZ_7r*Z545 + YZ_7r*Z168^2 - YZ_7r*Z169^2 - XY_7r*Z167*Z169 + XZ_7r*Z167*Z168 - YY_7r*Z168*Z169 + Z168*Z169*ZZ_7r;
 
Z1289 = - MX_7r*Z443 - MZ_7r*Z420;
Z1290 = YY_7r*Z170 - MZ_7r*Z421 - XY_7r*Z157 - MX_7r*Z444 + YZ_7r*Z176;
Z1291 = YY_7r*Z171 - MZ_7r*Z422 - XY_7r*Z158 - MX_7r*Z445 + YZ_7r*Z177;
Z1292 = YY_7r*Z171 - MZ_7r*Z423 - XY_7r*Z158 - MX_7r*Z446 + YZ_7r*Z177;
Z1293 = YY_7r*Z172 - MZ_7r*Z424 - XY_7r*Z159 - MX_7r*Z447 + YZ_7r*Z178;
Z1294 = YY_7r*Z173 - MZ_7r*Z425 - XY_7r*Z160 - MX_7r*Z448 + YZ_7r*Z179;
Z1295 = YY_7r*Z174 - MZ_7r*Z426 - XY_7r*Z161 - MX_7r*Z449 + YZ_7r*Z180;
Z1296 = YY_7r*Z175 + YZ_7r*Z181;
Z1297 = -XY_7r;
Z1298 = YY_7r*Z544 - MZ_7r*Z588 - XY_7r*Z542 - MX_7r*Z592 + YZ_7r*Z545 - XZ_7r*Z167^2 + XZ_7r*Z169^2 + XX_7r*Z167*Z169 + XY_7r*Z168*Z169 - YZ_7r*Z167*Z168 - Z167*Z169*ZZ_7r;
 
Z1299 = MX_7r*Z436 + MY_7r*Z420;
Z1300 = MX_7r*Z437 + MY_7r*Z421 - XZ_7r*Z157 + YZ_7r*Z170 + Z176*ZZ_7r;
Z1301 = MX_7r*Z438 + MY_7r*Z422 - XZ_7r*Z158 + YZ_7r*Z171 + Z177*ZZ_7r;
Z1302 = MX_7r*Z439 + MY_7r*Z423 - XZ_7r*Z158 + YZ_7r*Z171 + Z177*ZZ_7r;
Z1303 = MX_7r*Z440 + MY_7r*Z424 - XZ_7r*Z159 + YZ_7r*Z172 + Z178*ZZ_7r;
Z1304 = MX_7r*Z441 + MY_7r*Z425 - XZ_7r*Z160 + YZ_7r*Z173 + Z179*ZZ_7r;
Z1305 = MX_7r*Z442 + MY_7r*Z426 - XZ_7r*Z161 + YZ_7r*Z174 + Z180*ZZ_7r;
Z1306 = YZ_7r*Z175 + Z181*ZZ_7r;
Z1307 = -XZ_7r;
Z1308 = MX_7r*Z591 + MY_7r*Z588 - XZ_7r*Z542 + YZ_7r*Z544 + Z545*ZZ_7r + XY_7r*Z167^2 - XY_7r*Z168^2 - XX_7r*Z167*Z168 - XZ_7r*Z168*Z169 + YY_7r*Z167*Z168 + YZ_7r*Z167*Z169;
 
dHnew7r = [Z1279*ddx+Z1280*ddpsi+Z1281*ddq_imu+Z1282*ddq_w+Z1283*ddq_torso+Z1284*ddq_1r+Z1285*ddq_2r+Z1286*ddq_3r+Z1287*ddq_4r+Z1288;
    Z1289*ddx+Z1290*ddpsi+Z1291*ddq_imu+Z1292*ddq_w+Z1293*ddq_torso+Z1294*ddq_1r+Z1295*ddq_2r+Z1296*ddq_3r+Z1297*ddq_4r+Z1298;
    Z1299*ddx+Z1300*ddpsi+Z1301*ddq_imu+Z1302*ddq_w+Z1303*ddq_torso+Z1304*ddq_1r+Z1305*ddq_2r+Z1306*ddq_3r+Z1307*ddq_4r+Z1308];
 
 
% maG8r = 
%
%      (Z452*m_8r)*ddx + (Z453*m_8r - MZ_8r*Z170 - MY_8r*Z192)*ddpsi + (Z454*m_8r - MZ_8r*Z171 - MY_8r*Z193)*ddq_imu + (Z455*m_8r - MZ_8r*Z171 - MY_8r*Z193)*ddq_w + (Z457*m_8r - MZ_8r*Z173 - MY_8r*Z195)*ddq_1r + (Z458*m_8r - MZ_8r*Z174 - MY_8r*Z196)*ddq_2r + (Z459*m_8r - MZ_8r*Z175 - MY_8r*Z197)*ddq_3r + (Z460*m_8r - MY_8r*Z198)*ddq_4r + (-MZ_8r)*ddq_5r + (m_8r*(Z593 + Z456*ddq_torso) - Z184*(MX_8r*Z184 - MZ_8r*Z182) - MY_8r*(Z547 + Z194*ddq_torso) - MZ_8r*(Z544 + Z172*ddq_torso) - Z183*(MX_8r*Z183 - MY_8r*Z182))
%      (-Z436*m_8r)*ddx + (MX_8r*Z192 - MZ_8r*Z185 - Z437*m_8r)*ddpsi + (MX_8r*Z193 - MZ_8r*Z186 - Z438*m_8r)*ddq_imu + (MX_8r*Z193 - MZ_8r*Z186 - Z439*m_8r)*ddq_w + (MX_8r*Z195 - MZ_8r*Z188 - Z441*m_8r)*ddq_1r + (MX_8r*Z196 - MZ_8r*Z189 - Z442*m_8r)*ddq_2r + (MX_8r*Z197 - MZ_8r*Z190)*ddq_3r + (MX_8r*Z198 - MZ_8r*Z191)*ddq_4r + (Z182*(MX_8r*Z183 - MY_8r*Z182) - Z184*(MY_8r*Z184 - MZ_8r*Z183) + MX_8r*(Z547 + Z194*ddq_torso) - MZ_8r*(Z546 + Z187*ddq_torso) + m_8r*(Z594 - Z440*ddq_torso))
%      (Z461*m_8r)*ddx + (MX_8r*Z170 + MY_8r*Z185 + Z462*m_8r)*ddpsi + (MX_8r*Z171 + MY_8r*Z186 + Z463*m_8r)*ddq_imu + (MX_8r*Z171 + MY_8r*Z186 + Z464*m_8r)*ddq_w + (MX_8r*Z173 + MY_8r*Z188 + Z466*m_8r)*ddq_1r + (MX_8r*Z174 + MY_8r*Z189 + Z467*m_8r)*ddq_2r + (MX_8r*Z175 + MY_8r*Z190 + Z468*m_8r)*ddq_3r + (MY_8r*Z191 + Z469*m_8r)*ddq_4r + MX_8r*ddq_5r + (Z182*(MX_8r*Z184 - MZ_8r*Z182) + Z183*(MY_8r*Z184 - MZ_8r*Z183) + MX_8r*(Z544 + Z172*ddq_torso) + MY_8r*(Z546 + Z187*ddq_torso) + m_8r*(Z595 + Z465*ddq_torso))
Z1309 = Z452*m_8r;
Z1310 = Z453*m_8r - MZ_8r*Z170 - MY_8r*Z192;
Z1311 = Z454*m_8r - MZ_8r*Z171 - MY_8r*Z193;
Z1312 = Z455*m_8r - MZ_8r*Z171 - MY_8r*Z193;
Z1313 = Z456*m_8r - MZ_8r*Z172 - MY_8r*Z194;
Z1314 = Z457*m_8r - MZ_8r*Z173 - MY_8r*Z195;
Z1315 = Z458*m_8r - MZ_8r*Z174 - MY_8r*Z196;
Z1316 = Z459*m_8r - MZ_8r*Z175 - MY_8r*Z197;
Z1317 = Z460*m_8r - MY_8r*Z198;
Z1318 = -MZ_8r;
Z1319 = Z593*m_8r - MZ_8r*Z544 - MY_8r*Z547 - MX_8r*Z183^2 - MX_8r*Z184^2 + MY_8r*Z182*Z183 + MZ_8r*Z182*Z184;
 
Z1320 = -Z436*m_8r;
Z1321 = MX_8r*Z192 - MZ_8r*Z185 - Z437*m_8r;
Z1322 = MX_8r*Z193 - MZ_8r*Z186 - Z438*m_8r;
Z1323 = MX_8r*Z193 - MZ_8r*Z186 - Z439*m_8r;
Z1324 = MX_8r*Z194 - MZ_8r*Z187 - Z440*m_8r;
Z1325 = MX_8r*Z195 - MZ_8r*Z188 - Z441*m_8r;
Z1326 = MX_8r*Z196 - MZ_8r*Z189 - Z442*m_8r;
Z1327 = MX_8r*Z197 - MZ_8r*Z190;
Z1328 = MX_8r*Z198 - MZ_8r*Z191;
Z1329 = MX_8r*Z547 - MZ_8r*Z546 + Z594*m_8r - MY_8r*Z182^2 - MY_8r*Z184^2 + MX_8r*Z182*Z183 + MZ_8r*Z183*Z184;
 
Z1330 = Z461*m_8r;
Z1331 = MX_8r*Z170 + MY_8r*Z185 + Z462*m_8r;
Z1332 = MX_8r*Z171 + MY_8r*Z186 + Z463*m_8r;
Z1333 = MX_8r*Z171 + MY_8r*Z186 + Z464*m_8r;
Z1334 = MX_8r*Z172 + MY_8r*Z187 + Z465*m_8r;
Z1335 = MX_8r*Z173 + MY_8r*Z188 + Z466*m_8r;
Z1336 = MX_8r*Z174 + MY_8r*Z189 + Z467*m_8r;
Z1337 = MX_8r*Z175 + MY_8r*Z190 + Z468*m_8r;
Z1338 = MY_8r*Z191 + Z469*m_8r;
Z1339 = MX_8r;
Z1340 = MX_8r*Z544 + MY_8r*Z546 + Z595*m_8r - MZ_8r*Z182^2 - MZ_8r*Z183^2 + MX_8r*Z182*Z184 + MY_8r*Z183*Z184;
 
maG8r = [Z1309*ddx+Z1310*ddpsi+Z1311*ddq_imu+Z1312*ddq_w+Z1313*ddq_torso+Z1314*ddq_1r+Z1315*ddq_2r+Z1316*ddq_3r+Z1317*ddq_4r+Z1318*ddq_5r+Z1319;
    Z1320*ddx+Z1321*ddpsi+Z1322*ddq_imu+Z1323*ddq_w+Z1324*ddq_torso+Z1325*ddq_1r+Z1326*ddq_2r+Z1327*ddq_3r+Z1328*ddq_4r+Z1329;
    Z1330*ddx+Z1331*ddpsi+Z1332*ddq_imu+Z1333*ddq_w+Z1334*ddq_torso+Z1335*ddq_1r+Z1336*ddq_2r+Z1337*ddq_3r+Z1338*ddq_4r+Z1339*ddq_5r+Z1340];
 
% dHnew8r = 
%
%      (Z452*m_8r)*ddx + (Z453*m_8r - MZ_8r*Z170 - MY_8r*Z192)*ddpsi + (Z454*m_8r - MZ_8r*Z171 - MY_8r*Z193)*ddq_imu + (Z455*m_8r - MZ_8r*Z171 - MY_8r*Z193)*ddq_w + (Z457*m_8r - MZ_8r*Z173 - MY_8r*Z195)*ddq_1r + (Z458*m_8r - MZ_8r*Z174 - MY_8r*Z196)*ddq_2r + (Z459*m_8r - MZ_8r*Z175 - MY_8r*Z197)*ddq_3r + (Z460*m_8r - MY_8r*Z198)*ddq_4r + (-MZ_8r)*ddq_5r + (m_8r*(Z593 + Z456*ddq_torso) - Z184*(MX_8r*Z184 - MZ_8r*Z182) - MY_8r*(Z547 + Z194*ddq_torso) - MZ_8r*(Z544 + Z172*ddq_torso) - Z183*(MX_8r*Z183 - MY_8r*Z182))
%      (-Z436*m_8r)*ddx + (MX_8r*Z192 - MZ_8r*Z185 - Z437*m_8r)*ddpsi + (MX_8r*Z193 - MZ_8r*Z186 - Z438*m_8r)*ddq_imu + (MX_8r*Z193 - MZ_8r*Z186 - Z439*m_8r)*ddq_w + (MX_8r*Z195 - MZ_8r*Z188 - Z441*m_8r)*ddq_1r + (MX_8r*Z196 - MZ_8r*Z189 - Z442*m_8r)*ddq_2r + (MX_8r*Z197 - MZ_8r*Z190)*ddq_3r + (MX_8r*Z198 - MZ_8r*Z191)*ddq_4r + (Z182*(MX_8r*Z183 - MY_8r*Z182) - Z184*(MY_8r*Z184 - MZ_8r*Z183) + MX_8r*(Z547 + Z194*ddq_torso) - MZ_8r*(Z546 + Z187*ddq_torso) + m_8r*(Z594 - Z440*ddq_torso))
%      (Z461*m_8r)*ddx + (MX_8r*Z170 + MY_8r*Z185 + Z462*m_8r)*ddpsi + (MX_8r*Z171 + MY_8r*Z186 + Z463*m_8r)*ddq_imu + (MX_8r*Z171 + MY_8r*Z186 + Z464*m_8r)*ddq_w + (MX_8r*Z173 + MY_8r*Z188 + Z466*m_8r)*ddq_1r + (MX_8r*Z174 + MY_8r*Z189 + Z467*m_8r)*ddq_2r + (MX_8r*Z175 + MY_8r*Z190 + Z468*m_8r)*ddq_3r + (MY_8r*Z191 + Z469*m_8r)*ddq_4r + MX_8r*ddq_5r + (Z182*(MX_8r*Z184 - MZ_8r*Z182) + Z183*(MY_8r*Z184 - MZ_8r*Z183) + MX_8r*(Z544 + Z172*ddq_torso) + MY_8r*(Z546 + Z187*ddq_torso) + m_8r*(Z595 + Z465*ddq_torso))
Z1341 = MY_8r*Z461 + MZ_8r*Z436;
Z1342 = MY_8r*Z462 + MZ_8r*Z437 + XX_8r*Z185 - XY_8r*Z170 + XZ_8r*Z192;
Z1343 = MY_8r*Z463 + MZ_8r*Z438 + XX_8r*Z186 - XY_8r*Z171 + XZ_8r*Z193;
Z1344 = MY_8r*Z464 + MZ_8r*Z439 + XX_8r*Z186 - XY_8r*Z171 + XZ_8r*Z193;
Z1345 = MY_8r*Z465 + MZ_8r*Z440 + XX_8r*Z187 - XY_8r*Z172 + XZ_8r*Z194;
Z1346 = MY_8r*Z466 + MZ_8r*Z441 + XX_8r*Z188 - XY_8r*Z173 + XZ_8r*Z195;
Z1347 = MY_8r*Z467 + MZ_8r*Z442 + XX_8r*Z189 - XY_8r*Z174 + XZ_8r*Z196;
Z1348 = MY_8r*Z468 + XX_8r*Z190 - XY_8r*Z175 + XZ_8r*Z197;
Z1349 = MY_8r*Z469 + XX_8r*Z191 + XZ_8r*Z198;
Z1350 = -XY_8r;
Z1351 = MY_8r*Z595 - MZ_8r*Z594 + XX_8r*Z546 - XY_8r*Z544 + XZ_8r*Z547 + YZ_8r*Z183^2 - YZ_8r*Z184^2 - XY_8r*Z182*Z184 + XZ_8r*Z182*Z183 - YY_8r*Z183*Z184 + Z183*Z184*ZZ_8r;
 
Z1352 = MZ_8r*Z452 - MX_8r*Z461;
Z1353 = MZ_8r*Z453 - MX_8r*Z462 + XY_8r*Z185 - YY_8r*Z170 + YZ_8r*Z192;
Z1354 = MZ_8r*Z454 - MX_8r*Z463 + XY_8r*Z186 - YY_8r*Z171 + YZ_8r*Z193;
Z1355 = MZ_8r*Z455 - MX_8r*Z464 + XY_8r*Z186 - YY_8r*Z171 + YZ_8r*Z193;
Z1356 = MZ_8r*Z456 - MX_8r*Z465 + XY_8r*Z187 - YY_8r*Z172 + YZ_8r*Z194;
Z1357 = MZ_8r*Z457 - MX_8r*Z466 + XY_8r*Z188 - YY_8r*Z173 + YZ_8r*Z195;
Z1358 = MZ_8r*Z458 - MX_8r*Z467 + XY_8r*Z189 - YY_8r*Z174 + YZ_8r*Z196;
Z1359 = MZ_8r*Z459 - MX_8r*Z468 + XY_8r*Z190 - YY_8r*Z175 + YZ_8r*Z197;
Z1360 = MZ_8r*Z460 - MX_8r*Z469 + XY_8r*Z191 + YZ_8r*Z198;
Z1361 = -YY_8r;
Z1362 = MZ_8r*Z593 - MX_8r*Z595 + XY_8r*Z546 - YY_8r*Z544 + YZ_8r*Z547 - XZ_8r*Z182^2 + XZ_8r*Z184^2 + XX_8r*Z182*Z184 + XY_8r*Z183*Z184 - YZ_8r*Z182*Z183 - Z182*Z184*ZZ_8r;
 
Z1363 = - MX_8r*Z436 - MY_8r*Z452;
Z1364 = XZ_8r*Z185 - MY_8r*Z453 - MX_8r*Z437 - YZ_8r*Z170 + Z192*ZZ_8r;
Z1365 = XZ_8r*Z186 - MY_8r*Z454 - MX_8r*Z438 - YZ_8r*Z171 + Z193*ZZ_8r;
Z1366 = XZ_8r*Z186 - MY_8r*Z455 - MX_8r*Z439 - YZ_8r*Z171 + Z193*ZZ_8r;
Z1367 = XZ_8r*Z187 - MY_8r*Z456 - MX_8r*Z440 - YZ_8r*Z172 + Z194*ZZ_8r;
Z1368 = XZ_8r*Z188 - MY_8r*Z457 - MX_8r*Z441 - YZ_8r*Z173 + Z195*ZZ_8r;
Z1369 = XZ_8r*Z189 - MY_8r*Z458 - MX_8r*Z442 - YZ_8r*Z174 + Z196*ZZ_8r;
Z1370 = XZ_8r*Z190 - MY_8r*Z459 - YZ_8r*Z175 + Z197*ZZ_8r;
Z1371 = XZ_8r*Z191 - MY_8r*Z460 + Z198*ZZ_8r;
Z1372 = -YZ_8r;
Z1373 = MX_8r*Z594 - MY_8r*Z593 + XZ_8r*Z546 - YZ_8r*Z544 + Z547*ZZ_8r + XY_8r*Z182^2 - XY_8r*Z183^2 - XX_8r*Z182*Z183 - XZ_8r*Z183*Z184 + YY_8r*Z182*Z183 + YZ_8r*Z182*Z184;
 
dHnew8r = [Z1341*ddx+Z1342*ddpsi+Z1343*ddq_imu+Z1344*ddq_w+Z1345*ddq_torso+Z1346*ddq_1r+Z1347*ddq_2r+Z1348*ddq_3r+Z1349*ddq_4r+Z1350*ddq_5r+Z1351;
    Z1352*ddx+Z1353*ddpsi+Z1354*ddq_imu+Z1355*ddq_w+Z1356*ddq_torso+Z1357*ddq_1r+Z1358*ddq_2r+Z1359*ddq_3r+Z1360*ddq_4r+Z1361*ddq_5r+Z1362;
    Z1363*ddx+Z1364*ddpsi+Z1365*ddq_imu+Z1366*ddq_w+Z1367*ddq_torso+Z1368*ddq_1r+Z1369*ddq_2r+Z1370*ddq_3r+Z1371*ddq_4r+Z1372*ddq_5r+Z1373];
 
 
% maG9r = 
%
%      (-Z452*m_9r)*ddx + (MZ_9r*Z202 - MY_9r*Z210 - Z453*m_9r)*ddpsi + (MZ_9r*Z203 - MY_9r*Z211 - Z454*m_9r)*ddq_imu + (MZ_9r*Z203 - MY_9r*Z211 - Z455*m_9r)*ddq_w + (MZ_9r*Z205 - MY_9r*Z213 - Z457*m_9r)*ddq_1r + (MZ_9r*Z206 - MY_9r*Z214 - Z458*m_9r)*ddq_2r + (MZ_9r*Z207 - MY_9r*Z215 - Z459*m_9r)*ddq_3r + (MZ_9r*Z208 - MY_9r*Z216 - Z460*m_9r)*ddq_4r + (MZ_9r*Z209 - MY_9r*Z217)*ddq_5r + (MZ_9r*(Z548 + Z204*ddq_torso) - Z201*(MX_9r*Z201 - MZ_9r*Z199) - MY_9r*(Z549 + Z212*ddq_torso) - Z200*(MX_9r*Z200 - MY_9r*Z199) - m_9r*(Z593 + Z456*ddq_torso))
%      (Z472*m_9r)*ddx + (MX_9r*Z210 + MZ_9r*Z185 + Z473*m_9r)*ddpsi + (MX_9r*Z211 + MZ_9r*Z186 + Z474*m_9r)*ddq_imu + (MX_9r*Z211 + MZ_9r*Z186 + Z475*m_9r)*ddq_w + (MX_9r*Z213 + MZ_9r*Z188 + Z477*m_9r)*ddq_1r + (MX_9r*Z214 + MZ_9r*Z189 + Z478*m_9r)*ddq_2r + (MX_9r*Z215 + MZ_9r*Z190 + Z479*m_9r)*ddq_3r + (MX_9r*Z216 + MZ_9r*Z191 + Z480*m_9r)*ddq_4r + (MX_9r*Z217)*ddq_5r + MZ_9r*ddq_6r + (Z199*(MX_9r*Z200 - MY_9r*Z199) - Z201*(MY_9r*Z201 - MZ_9r*Z200) + MX_9r*(Z549 + Z212*ddq_torso) + MZ_9r*(Z546 + Z187*ddq_torso) + m_9r*(Z596 + Z476*ddq_torso))
%      (Z481*m_9r)*ddx + (Z482*m_9r - MY_9r*Z185 - MX_9r*Z202)*ddpsi + (Z483*m_9r - MY_9r*Z186 - MX_9r*Z203)*ddq_imu + (Z484*m_9r - MY_9r*Z186 - MX_9r*Z203)*ddq_w + (Z486*m_9r - MY_9r*Z188 - MX_9r*Z205)*ddq_1r + (Z487*m_9r - MY_9r*Z189 - MX_9r*Z206)*ddq_2r + (Z488*m_9r - MY_9r*Z190 - MX_9r*Z207)*ddq_3r + (Z489*m_9r - MY_9r*Z191 - MX_9r*Z208)*ddq_4r + (-MX_9r*Z209)*ddq_5r + (-MY_9r)*ddq_6r + (Z199*(MX_9r*Z201 - MZ_9r*Z199) + Z200*(MY_9r*Z201 - MZ_9r*Z200) - MX_9r*(Z548 + Z204*ddq_torso) - MY_9r*(Z546 + Z187*ddq_torso) + m_9r*(Z597 + Z485*ddq_torso))
Z1374 = -Z452*m_9r;
Z1375 = MZ_9r*Z202 - MY_9r*Z210 - Z453*m_9r;
Z1376 = MZ_9r*Z203 - MY_9r*Z211 - Z454*m_9r;
Z1377 = MZ_9r*Z203 - MY_9r*Z211 - Z455*m_9r;
Z1378 = MZ_9r*Z204 - MY_9r*Z212 - Z456*m_9r;
Z1379 = MZ_9r*Z205 - MY_9r*Z213 - Z457*m_9r;
Z1380 = MZ_9r*Z206 - MY_9r*Z214 - Z458*m_9r;
Z1381 = MZ_9r*Z207 - MY_9r*Z215 - Z459*m_9r;
Z1382 = MZ_9r*Z208 - MY_9r*Z216 - Z460*m_9r;
Z1383 = MZ_9r*Z209 - MY_9r*Z217;
Z1384 = MZ_9r*Z548 - MY_9r*Z549 - Z593*m_9r - MX_9r*Z200^2 - MX_9r*Z201^2 + MY_9r*Z199*Z200 + MZ_9r*Z199*Z201;
 
Z1385 = Z472*m_9r;
Z1386 = MX_9r*Z210 + MZ_9r*Z185 + Z473*m_9r;
Z1387 = MX_9r*Z211 + MZ_9r*Z186 + Z474*m_9r;
Z1388 = MX_9r*Z211 + MZ_9r*Z186 + Z475*m_9r;
Z1389 = MX_9r*Z212 + MZ_9r*Z187 + Z476*m_9r;
Z1390 = MX_9r*Z213 + MZ_9r*Z188 + Z477*m_9r;
Z1391 = MX_9r*Z214 + MZ_9r*Z189 + Z478*m_9r;
Z1392 = MX_9r*Z215 + MZ_9r*Z190 + Z479*m_9r;
Z1393 = MX_9r*Z216 + MZ_9r*Z191 + Z480*m_9r;
Z1394 = MX_9r*Z217;
Z1395 = MZ_9r;
Z1396 = MX_9r*Z549 + MZ_9r*Z546 + Z596*m_9r - MY_9r*Z199^2 - MY_9r*Z201^2 + MX_9r*Z199*Z200 + MZ_9r*Z200*Z201;
 
Z1397 = Z481*m_9r;
Z1398 = Z482*m_9r - MY_9r*Z185 - MX_9r*Z202;
Z1399 = Z483*m_9r - MY_9r*Z186 - MX_9r*Z203;
Z1400 = Z484*m_9r - MY_9r*Z186 - MX_9r*Z203;
Z1401 = Z485*m_9r - MY_9r*Z187 - MX_9r*Z204;
Z1402 = Z486*m_9r - MY_9r*Z188 - MX_9r*Z205;
Z1403 = Z487*m_9r - MY_9r*Z189 - MX_9r*Z206;
Z1404 = Z488*m_9r - MY_9r*Z190 - MX_9r*Z207;
Z1405 = Z489*m_9r - MY_9r*Z191 - MX_9r*Z208;
Z1406 = -MX_9r*Z209;
Z1407 = -MY_9r;
Z1408 = Z597*m_9r - MY_9r*Z546 - MX_9r*Z548 - MZ_9r*Z199^2 - MZ_9r*Z200^2 + MX_9r*Z199*Z201 + MY_9r*Z200*Z201;
 
maG9r = [Z1374*ddx+Z1375*ddpsi+Z1376*ddq_imu+Z1377*ddq_w+Z1378*ddq_torso+Z1379*ddq_1r+Z1380*ddq_2r+Z1381*ddq_3r+Z1382*ddq_4r+Z1383*ddq_5r+Z1384;
    Z1385*ddx+Z1386*ddpsi+Z1387*ddq_imu+Z1388*ddq_w+Z1389*ddq_torso+Z1390*ddq_1r+Z1391*ddq_2r+Z1392*ddq_3r+Z1393*ddq_4r+Z1394*ddq_5r+Z1395*ddq_6r+Z1396;
    Z1397*ddx+Z1398*ddpsi+Z1399*ddq_imu+Z1400*ddq_w+Z1401*ddq_torso+Z1402*ddq_1r+Z1403*ddq_2r+Z1404*ddq_3r+Z1405*ddq_4r+Z1406*ddq_5r+Z1407*ddq_6r+Z1408];
 
% dHnew9r = 
%
%      (-Z452*m_9r)*ddx + (MZ_9r*Z202 - MY_9r*Z210 - Z453*m_9r)*ddpsi + (MZ_9r*Z203 - MY_9r*Z211 - Z454*m_9r)*ddq_imu + (MZ_9r*Z203 - MY_9r*Z211 - Z455*m_9r)*ddq_w + (MZ_9r*Z205 - MY_9r*Z213 - Z457*m_9r)*ddq_1r + (MZ_9r*Z206 - MY_9r*Z214 - Z458*m_9r)*ddq_2r + (MZ_9r*Z207 - MY_9r*Z215 - Z459*m_9r)*ddq_3r + (MZ_9r*Z208 - MY_9r*Z216 - Z460*m_9r)*ddq_4r + (MZ_9r*Z209 - MY_9r*Z217)*ddq_5r + (MZ_9r*(Z548 + Z204*ddq_torso) - Z201*(MX_9r*Z201 - MZ_9r*Z199) - MY_9r*(Z549 + Z212*ddq_torso) - Z200*(MX_9r*Z200 - MY_9r*Z199) - m_9r*(Z593 + Z456*ddq_torso))
%      (Z472*m_9r)*ddx + (MX_9r*Z210 + MZ_9r*Z185 + Z473*m_9r)*ddpsi + (MX_9r*Z211 + MZ_9r*Z186 + Z474*m_9r)*ddq_imu + (MX_9r*Z211 + MZ_9r*Z186 + Z475*m_9r)*ddq_w + (MX_9r*Z213 + MZ_9r*Z188 + Z477*m_9r)*ddq_1r + (MX_9r*Z214 + MZ_9r*Z189 + Z478*m_9r)*ddq_2r + (MX_9r*Z215 + MZ_9r*Z190 + Z479*m_9r)*ddq_3r + (MX_9r*Z216 + MZ_9r*Z191 + Z480*m_9r)*ddq_4r + (MX_9r*Z217)*ddq_5r + MZ_9r*ddq_6r + (Z199*(MX_9r*Z200 - MY_9r*Z199) - Z201*(MY_9r*Z201 - MZ_9r*Z200) + MX_9r*(Z549 + Z212*ddq_torso) + MZ_9r*(Z546 + Z187*ddq_torso) + m_9r*(Z596 + Z476*ddq_torso))
%      (Z481*m_9r)*ddx + (Z482*m_9r - MY_9r*Z185 - MX_9r*Z202)*ddpsi + (Z483*m_9r - MY_9r*Z186 - MX_9r*Z203)*ddq_imu + (Z484*m_9r - MY_9r*Z186 - MX_9r*Z203)*ddq_w + (Z486*m_9r - MY_9r*Z188 - MX_9r*Z205)*ddq_1r + (Z487*m_9r - MY_9r*Z189 - MX_9r*Z206)*ddq_2r + (Z488*m_9r - MY_9r*Z190 - MX_9r*Z207)*ddq_3r + (Z489*m_9r - MY_9r*Z191 - MX_9r*Z208)*ddq_4r + (-MX_9r*Z209)*ddq_5r + (-MY_9r)*ddq_6r + (Z199*(MX_9r*Z201 - MZ_9r*Z199) + Z200*(MY_9r*Z201 - MZ_9r*Z200) - MX_9r*(Z548 + Z204*ddq_torso) - MY_9r*(Z546 + Z187*ddq_torso) + m_9r*(Z597 + Z485*ddq_torso))
Z1409 = MY_9r*Z481 - MZ_9r*Z472;
Z1410 = MY_9r*Z482 - MZ_9r*Z473 - XX_9r*Z185 + XY_9r*Z202 + XZ_9r*Z210;
Z1411 = MY_9r*Z483 - MZ_9r*Z474 - XX_9r*Z186 + XY_9r*Z203 + XZ_9r*Z211;
Z1412 = MY_9r*Z484 - MZ_9r*Z475 - XX_9r*Z186 + XY_9r*Z203 + XZ_9r*Z211;
Z1413 = MY_9r*Z485 - MZ_9r*Z476 - XX_9r*Z187 + XY_9r*Z204 + XZ_9r*Z212;
Z1414 = MY_9r*Z486 - MZ_9r*Z477 - XX_9r*Z188 + XY_9r*Z205 + XZ_9r*Z213;
Z1415 = MY_9r*Z487 - MZ_9r*Z478 - XX_9r*Z189 + XY_9r*Z206 + XZ_9r*Z214;
Z1416 = MY_9r*Z488 - MZ_9r*Z479 - XX_9r*Z190 + XY_9r*Z207 + XZ_9r*Z215;
Z1417 = MY_9r*Z489 - MZ_9r*Z480 - XX_9r*Z191 + XY_9r*Z208 + XZ_9r*Z216;
Z1418 = XY_9r*Z209 + XZ_9r*Z217;
Z1419 = -XX_9r;
Z1420 = MY_9r*Z597 - MZ_9r*Z596 - XX_9r*Z546 + XY_9r*Z548 + XZ_9r*Z549 + YZ_9r*Z200^2 - YZ_9r*Z201^2 - XY_9r*Z199*Z201 + XZ_9r*Z199*Z200 - YY_9r*Z200*Z201 + Z200*Z201*ZZ_9r;
 
Z1421 = - MX_9r*Z481 - MZ_9r*Z452;
Z1422 = YY_9r*Z202 - MZ_9r*Z453 - XY_9r*Z185 - MX_9r*Z482 + YZ_9r*Z210;
Z1423 = YY_9r*Z203 - MZ_9r*Z454 - XY_9r*Z186 - MX_9r*Z483 + YZ_9r*Z211;
Z1424 = YY_9r*Z203 - MZ_9r*Z455 - XY_9r*Z186 - MX_9r*Z484 + YZ_9r*Z211;
Z1425 = YY_9r*Z204 - MZ_9r*Z456 - XY_9r*Z187 - MX_9r*Z485 + YZ_9r*Z212;
Z1426 = YY_9r*Z205 - MZ_9r*Z457 - XY_9r*Z188 - MX_9r*Z486 + YZ_9r*Z213;
Z1427 = YY_9r*Z206 - MZ_9r*Z458 - XY_9r*Z189 - MX_9r*Z487 + YZ_9r*Z214;
Z1428 = YY_9r*Z207 - MZ_9r*Z459 - XY_9r*Z190 - MX_9r*Z488 + YZ_9r*Z215;
Z1429 = YY_9r*Z208 - MZ_9r*Z460 - XY_9r*Z191 - MX_9r*Z489 + YZ_9r*Z216;
Z1430 = YY_9r*Z209 + YZ_9r*Z217;
Z1431 = -XY_9r;
Z1432 = YY_9r*Z548 - MZ_9r*Z593 - XY_9r*Z546 - MX_9r*Z597 + YZ_9r*Z549 - XZ_9r*Z199^2 + XZ_9r*Z201^2 + XX_9r*Z199*Z201 + XY_9r*Z200*Z201 - YZ_9r*Z199*Z200 - Z199*Z201*ZZ_9r;
 
Z1433 = MX_9r*Z472 + MY_9r*Z452;
Z1434 = MX_9r*Z473 + MY_9r*Z453 - XZ_9r*Z185 + YZ_9r*Z202 + Z210*ZZ_9r;
Z1435 = MX_9r*Z474 + MY_9r*Z454 - XZ_9r*Z186 + YZ_9r*Z203 + Z211*ZZ_9r;
Z1436 = MX_9r*Z475 + MY_9r*Z455 - XZ_9r*Z186 + YZ_9r*Z203 + Z211*ZZ_9r;
Z1437 = MX_9r*Z476 + MY_9r*Z456 - XZ_9r*Z187 + YZ_9r*Z204 + Z212*ZZ_9r;
Z1438 = MX_9r*Z477 + MY_9r*Z457 - XZ_9r*Z188 + YZ_9r*Z205 + Z213*ZZ_9r;
Z1439 = MX_9r*Z478 + MY_9r*Z458 - XZ_9r*Z189 + YZ_9r*Z206 + Z214*ZZ_9r;
Z1440 = MX_9r*Z479 + MY_9r*Z459 - XZ_9r*Z190 + YZ_9r*Z207 + Z215*ZZ_9r;
Z1441 = MX_9r*Z480 + MY_9r*Z460 - XZ_9r*Z191 + YZ_9r*Z208 + Z216*ZZ_9r;
Z1442 = YZ_9r*Z209 + Z217*ZZ_9r;
Z1443 = -XZ_9r;
Z1444 = MX_9r*Z596 + MY_9r*Z593 - XZ_9r*Z546 + YZ_9r*Z548 + Z549*ZZ_9r + XY_9r*Z199^2 - XY_9r*Z200^2 - XX_9r*Z199*Z200 - XZ_9r*Z200*Z201 + YY_9r*Z199*Z200 + YZ_9r*Z199*Z201;
 
dHnew9r = [Z1409*ddx+Z1410*ddpsi+Z1411*ddq_imu+Z1412*ddq_w+Z1413*ddq_torso+Z1414*ddq_1r+Z1415*ddq_2r+Z1416*ddq_3r+Z1417*ddq_4r+Z1418*ddq_5r+Z1419*ddq_6r+Z1420;
    Z1421*ddx+Z1422*ddpsi+Z1423*ddq_imu+Z1424*ddq_w+Z1425*ddq_torso+Z1426*ddq_1r+Z1427*ddq_2r+Z1428*ddq_3r+Z1429*ddq_4r+Z1430*ddq_5r+Z1431*ddq_6r+Z1432;
    Z1433*ddx+Z1434*ddpsi+Z1435*ddq_imu+Z1436*ddq_w+Z1437*ddq_torso+Z1438*ddq_1r+Z1439*ddq_2r+Z1440*ddq_3r+Z1441*ddq_4r+Z1442*ddq_5r+Z1443*ddq_6r+Z1444];
 
 
% maG10r = 
%
%      (Z492*m_10r)*ddx + (MY_10r*Z202 + MZ_10r*Z230 + Z493*m_10r)*ddpsi + (MY_10r*Z203 + MZ_10r*Z231 + Z494*m_10r)*ddq_imu + (MY_10r*Z203 + MZ_10r*Z231 + Z495*m_10r)*ddq_w + (MY_10r*Z205 + MZ_10r*Z233 + Z497*m_10r)*ddq_1r + (MY_10r*Z206 + MZ_10r*Z234 + Z498*m_10r)*ddq_2r + (MY_10r*Z207 + MZ_10r*Z235 + Z499*m_10r)*ddq_3r + (MY_10r*Z208 + MZ_10r*Z236 + Z500*m_10r)*ddq_4r + (MY_10r*Z209 + MZ_10r*Z237 + Z501*m_10r)*ddq_5r + (MZ_10r*Z238 + Z502*m_10r)*ddq_6r + MY_10r*ddq_7r + (MY_10r*(Z548 + Z204*ddq_torso) - Z220*(MX_10r*Z220 - MZ_10r*Z218) - Z219*(MX_10r*Z219 - MY_10r*Z218) + MZ_10r*(Z551 + Z232*ddq_torso) + m_10r*(Z598 + Z496*ddq_torso))
%      (Z503*m_10r)*ddx + (Z504*m_10r - MZ_10r*Z221 - MX_10r*Z202)*ddpsi + (Z505*m_10r - MZ_10r*Z222 - MX_10r*Z203)*ddq_imu + (Z506*m_10r - MZ_10r*Z222 - MX_10r*Z203)*ddq_w + (Z508*m_10r - MZ_10r*Z224 - MX_10r*Z205)*ddq_1r + (Z509*m_10r - MZ_10r*Z225 - MX_10r*Z206)*ddq_2r + (Z510*m_10r - MZ_10r*Z226 - MX_10r*Z207)*ddq_3r + (Z511*m_10r - MZ_10r*Z227 - MX_10r*Z208)*ddq_4r + (Z512*m_10r - MZ_10r*Z228 - MX_10r*Z209)*ddq_5r + (Z513*m_10r - MZ_10r*Z229)*ddq_6r + (-MX_10r)*ddq_7r + (Z218*(MX_10r*Z219 - MY_10r*Z218) - Z220*(MY_10r*Z220 - MZ_10r*Z219) - MX_10r*(Z548 + Z204*ddq_torso) - MZ_10r*(Z550 + Z223*ddq_torso) + m_10r*(Z599 + Z507*ddq_torso))
%      (-Z472*m_10r)*ddx + (MY_10r*Z221 - MX_10r*Z230 - Z473*m_10r)*ddpsi + (MY_10r*Z222 - MX_10r*Z231 - Z474*m_10r)*ddq_imu + (MY_10r*Z222 - MX_10r*Z231 - Z475*m_10r)*ddq_w + (MY_10r*Z224 - MX_10r*Z233 - Z477*m_10r)*ddq_1r + (MY_10r*Z225 - MX_10r*Z234 - Z478*m_10r)*ddq_2r + (MY_10r*Z226 - MX_10r*Z235 - Z479*m_10r)*ddq_3r + (MY_10r*Z227 - MX_10r*Z236 - Z480*m_10r)*ddq_4r + (MY_10r*Z228 - MX_10r*Z237)*ddq_5r + (MY_10r*Z229 - MX_10r*Z238)*ddq_6r + (Z218*(MX_10r*Z220 - MZ_10r*Z218) + Z219*(MY_10r*Z220 - MZ_10r*Z219) - MX_10r*(Z551 + Z232*ddq_torso) + MY_10r*(Z550 + Z223*ddq_torso) + m_10r*(Z600 - Z476*ddq_torso))
Z1445 = Z492*m_10r;
Z1446 = MY_10r*Z202 + MZ_10r*Z230 + Z493*m_10r;
Z1447 = MY_10r*Z203 + MZ_10r*Z231 + Z494*m_10r;
Z1448 = MY_10r*Z203 + MZ_10r*Z231 + Z495*m_10r;
Z1449 = MY_10r*Z204 + MZ_10r*Z232 + Z496*m_10r;
Z1450 = MY_10r*Z205 + MZ_10r*Z233 + Z497*m_10r;
Z1451 = MY_10r*Z206 + MZ_10r*Z234 + Z498*m_10r;
Z1452 = MY_10r*Z207 + MZ_10r*Z235 + Z499*m_10r;
Z1453 = MY_10r*Z208 + MZ_10r*Z236 + Z500*m_10r;
Z1454 = MY_10r*Z209 + MZ_10r*Z237 + Z501*m_10r;
Z1455 = MZ_10r*Z238 + Z502*m_10r;
Z1456 = MY_10r;
Z1457 = MY_10r*Z548 + MZ_10r*Z551 + Z598*m_10r - MX_10r*Z219^2 - MX_10r*Z220^2 + MY_10r*Z218*Z219 + MZ_10r*Z218*Z220;
 
Z1458 = Z503*m_10r;
Z1459 = Z504*m_10r - MZ_10r*Z221 - MX_10r*Z202;
Z1460 = Z505*m_10r - MZ_10r*Z222 - MX_10r*Z203;
Z1461 = Z506*m_10r - MZ_10r*Z222 - MX_10r*Z203;
Z1462 = Z507*m_10r - MZ_10r*Z223 - MX_10r*Z204;
Z1463 = Z508*m_10r - MZ_10r*Z224 - MX_10r*Z205;
Z1464 = Z509*m_10r - MZ_10r*Z225 - MX_10r*Z206;
Z1465 = Z510*m_10r - MZ_10r*Z226 - MX_10r*Z207;
Z1466 = Z511*m_10r - MZ_10r*Z227 - MX_10r*Z208;
Z1467 = Z512*m_10r - MZ_10r*Z228 - MX_10r*Z209;
Z1468 = Z513*m_10r - MZ_10r*Z229;
Z1469 = -MX_10r;
Z1470 = Z599*m_10r - MZ_10r*Z550 - MX_10r*Z548 - MY_10r*Z218^2 - MY_10r*Z220^2 + MX_10r*Z218*Z219 + MZ_10r*Z219*Z220;
 
Z1471 = -Z472*m_10r;
Z1472 = MY_10r*Z221 - MX_10r*Z230 - Z473*m_10r;
Z1473 = MY_10r*Z222 - MX_10r*Z231 - Z474*m_10r;
Z1474 = MY_10r*Z222 - MX_10r*Z231 - Z475*m_10r;
Z1475 = MY_10r*Z223 - MX_10r*Z232 - Z476*m_10r;
Z1476 = MY_10r*Z224 - MX_10r*Z233 - Z477*m_10r;
Z1477 = MY_10r*Z225 - MX_10r*Z234 - Z478*m_10r;
Z1478 = MY_10r*Z226 - MX_10r*Z235 - Z479*m_10r;
Z1479 = MY_10r*Z227 - MX_10r*Z236 - Z480*m_10r;
Z1480 = MY_10r*Z228 - MX_10r*Z237;
Z1481 = MY_10r*Z229 - MX_10r*Z238;
Z1482 = MY_10r*Z550 - MX_10r*Z551 + Z600*m_10r - MZ_10r*Z218^2 - MZ_10r*Z219^2 + MX_10r*Z218*Z220 + MY_10r*Z219*Z220;
 
maG10r = [Z1445*ddx+Z1446*ddpsi+Z1447*ddq_imu+Z1448*ddq_w+Z1449*ddq_torso+Z1450*ddq_1r+Z1451*ddq_2r+Z1452*ddq_3r+Z1453*ddq_4r+Z1454*ddq_5r+Z1455*ddq_6r+Z1456*ddq_7r+Z1457;
    Z1458*ddx+Z1459*ddpsi+Z1460*ddq_imu+Z1461*ddq_w+Z1462*ddq_torso+Z1463*ddq_1r+Z1464*ddq_2r+Z1465*ddq_3r+Z1466*ddq_4r+Z1467*ddq_5r+Z1468*ddq_6r+Z1469*ddq_7r+Z1470;
    Z1471*ddx+Z1472*ddpsi+Z1473*ddq_imu+Z1474*ddq_w+Z1475*ddq_torso+Z1476*ddq_1r+Z1477*ddq_2r+Z1478*ddq_3r+Z1479*ddq_4r+Z1480*ddq_5r+Z1481*ddq_6r+Z1482];
 
% dHnew10r = 
%
%      (Z492*m_10r)*ddx + (MY_10r*Z202 + MZ_10r*Z230 + Z493*m_10r)*ddpsi + (MY_10r*Z203 + MZ_10r*Z231 + Z494*m_10r)*ddq_imu + (MY_10r*Z203 + MZ_10r*Z231 + Z495*m_10r)*ddq_w + (MY_10r*Z205 + MZ_10r*Z233 + Z497*m_10r)*ddq_1r + (MY_10r*Z206 + MZ_10r*Z234 + Z498*m_10r)*ddq_2r + (MY_10r*Z207 + MZ_10r*Z235 + Z499*m_10r)*ddq_3r + (MY_10r*Z208 + MZ_10r*Z236 + Z500*m_10r)*ddq_4r + (MY_10r*Z209 + MZ_10r*Z237 + Z501*m_10r)*ddq_5r + (MZ_10r*Z238 + Z502*m_10r)*ddq_6r + MY_10r*ddq_7r + (MY_10r*(Z548 + Z204*ddq_torso) - Z220*(MX_10r*Z220 - MZ_10r*Z218) - Z219*(MX_10r*Z219 - MY_10r*Z218) + MZ_10r*(Z551 + Z232*ddq_torso) + m_10r*(Z598 + Z496*ddq_torso))
%      (Z503*m_10r)*ddx + (Z504*m_10r - MZ_10r*Z221 - MX_10r*Z202)*ddpsi + (Z505*m_10r - MZ_10r*Z222 - MX_10r*Z203)*ddq_imu + (Z506*m_10r - MZ_10r*Z222 - MX_10r*Z203)*ddq_w + (Z508*m_10r - MZ_10r*Z224 - MX_10r*Z205)*ddq_1r + (Z509*m_10r - MZ_10r*Z225 - MX_10r*Z206)*ddq_2r + (Z510*m_10r - MZ_10r*Z226 - MX_10r*Z207)*ddq_3r + (Z511*m_10r - MZ_10r*Z227 - MX_10r*Z208)*ddq_4r + (Z512*m_10r - MZ_10r*Z228 - MX_10r*Z209)*ddq_5r + (Z513*m_10r - MZ_10r*Z229)*ddq_6r + (-MX_10r)*ddq_7r + (Z218*(MX_10r*Z219 - MY_10r*Z218) - Z220*(MY_10r*Z220 - MZ_10r*Z219) - MX_10r*(Z548 + Z204*ddq_torso) - MZ_10r*(Z550 + Z223*ddq_torso) + m_10r*(Z599 + Z507*ddq_torso))
%      (-Z472*m_10r)*ddx + (MY_10r*Z221 - MX_10r*Z230 - Z473*m_10r)*ddpsi + (MY_10r*Z222 - MX_10r*Z231 - Z474*m_10r)*ddq_imu + (MY_10r*Z222 - MX_10r*Z231 - Z475*m_10r)*ddq_w + (MY_10r*Z224 - MX_10r*Z233 - Z477*m_10r)*ddq_1r + (MY_10r*Z225 - MX_10r*Z234 - Z478*m_10r)*ddq_2r + (MY_10r*Z226 - MX_10r*Z235 - Z479*m_10r)*ddq_3r + (MY_10r*Z227 - MX_10r*Z236 - Z480*m_10r)*ddq_4r + (MY_10r*Z228 - MX_10r*Z237)*ddq_5r + (MY_10r*Z229 - MX_10r*Z238)*ddq_6r + (Z218*(MX_10r*Z220 - MZ_10r*Z218) + Z219*(MY_10r*Z220 - MZ_10r*Z219) - MX_10r*(Z551 + Z232*ddq_torso) + MY_10r*(Z550 + Z223*ddq_torso) + m_10r*(Z600 - Z476*ddq_torso))
Z1483 = - MY_10r*Z472 - MZ_10r*Z503;
Z1484 = XX_10r*Z221 - MZ_10r*Z504 - MY_10r*Z473 + XY_10r*Z230 - XZ_10r*Z202;
Z1485 = XX_10r*Z222 - MZ_10r*Z505 - MY_10r*Z474 + XY_10r*Z231 - XZ_10r*Z203;
Z1486 = XX_10r*Z222 - MZ_10r*Z506 - MY_10r*Z475 + XY_10r*Z231 - XZ_10r*Z203;
Z1487 = XX_10r*Z223 - MZ_10r*Z507 - MY_10r*Z476 + XY_10r*Z232 - XZ_10r*Z204;
Z1488 = XX_10r*Z224 - MZ_10r*Z508 - MY_10r*Z477 + XY_10r*Z233 - XZ_10r*Z205;
Z1489 = XX_10r*Z225 - MZ_10r*Z509 - MY_10r*Z478 + XY_10r*Z234 - XZ_10r*Z206;
Z1490 = XX_10r*Z226 - MZ_10r*Z510 - MY_10r*Z479 + XY_10r*Z235 - XZ_10r*Z207;
Z1491 = XX_10r*Z227 - MZ_10r*Z511 - MY_10r*Z480 + XY_10r*Z236 - XZ_10r*Z208;
Z1492 = XX_10r*Z228 - MZ_10r*Z512 + XY_10r*Z237 - XZ_10r*Z209;
Z1493 = XX_10r*Z229 - MZ_10r*Z513 + XY_10r*Z238;
Z1494 = -XZ_10r;
Z1495 = MY_10r*Z600 - MZ_10r*Z599 + XX_10r*Z550 + XY_10r*Z551 - XZ_10r*Z548 + YZ_10r*Z219^2 - YZ_10r*Z220^2 - XY_10r*Z218*Z220 + XZ_10r*Z218*Z219 - YY_10r*Z219*Z220 + Z219*Z220*ZZ_10r;
 
Z1496 = MX_10r*Z472 + MZ_10r*Z492;
Z1497 = MX_10r*Z473 + MZ_10r*Z493 + XY_10r*Z221 + YY_10r*Z230 - YZ_10r*Z202;
Z1498 = MX_10r*Z474 + MZ_10r*Z494 + XY_10r*Z222 + YY_10r*Z231 - YZ_10r*Z203;
Z1499 = MX_10r*Z475 + MZ_10r*Z495 + XY_10r*Z222 + YY_10r*Z231 - YZ_10r*Z203;
Z1500 = MX_10r*Z476 + MZ_10r*Z496 + XY_10r*Z223 + YY_10r*Z232 - YZ_10r*Z204;
Z1501 = MX_10r*Z477 + MZ_10r*Z497 + XY_10r*Z224 + YY_10r*Z233 - YZ_10r*Z205;
Z1502 = MX_10r*Z478 + MZ_10r*Z498 + XY_10r*Z225 + YY_10r*Z234 - YZ_10r*Z206;
Z1503 = MX_10r*Z479 + MZ_10r*Z499 + XY_10r*Z226 + YY_10r*Z235 - YZ_10r*Z207;
Z1504 = MX_10r*Z480 + MZ_10r*Z500 + XY_10r*Z227 + YY_10r*Z236 - YZ_10r*Z208;
Z1505 = MZ_10r*Z501 + XY_10r*Z228 + YY_10r*Z237 - YZ_10r*Z209;
Z1506 = MZ_10r*Z502 + XY_10r*Z229 + YY_10r*Z238;
Z1507 = -YZ_10r;
Z1508 = MZ_10r*Z598 - MX_10r*Z600 + XY_10r*Z550 + YY_10r*Z551 - YZ_10r*Z548 - XZ_10r*Z218^2 + XZ_10r*Z220^2 + XX_10r*Z218*Z220 + XY_10r*Z219*Z220 - YZ_10r*Z218*Z219 - Z218*Z220*ZZ_10r;
 
Z1509 = MX_10r*Z503 - MY_10r*Z492;
Z1510 = MX_10r*Z504 - MY_10r*Z493 + XZ_10r*Z221 + YZ_10r*Z230 - Z202*ZZ_10r;
Z1511 = MX_10r*Z505 - MY_10r*Z494 + XZ_10r*Z222 + YZ_10r*Z231 - Z203*ZZ_10r;
Z1512 = MX_10r*Z506 - MY_10r*Z495 + XZ_10r*Z222 + YZ_10r*Z231 - Z203*ZZ_10r;
Z1513 = MX_10r*Z507 - MY_10r*Z496 + XZ_10r*Z223 + YZ_10r*Z232 - Z204*ZZ_10r;
Z1514 = MX_10r*Z508 - MY_10r*Z497 + XZ_10r*Z224 + YZ_10r*Z233 - Z205*ZZ_10r;
Z1515 = MX_10r*Z509 - MY_10r*Z498 + XZ_10r*Z225 + YZ_10r*Z234 - Z206*ZZ_10r;
Z1516 = MX_10r*Z510 - MY_10r*Z499 + XZ_10r*Z226 + YZ_10r*Z235 - Z207*ZZ_10r;
Z1517 = MX_10r*Z511 - MY_10r*Z500 + XZ_10r*Z227 + YZ_10r*Z236 - Z208*ZZ_10r;
Z1518 = MX_10r*Z512 - MY_10r*Z501 + XZ_10r*Z228 + YZ_10r*Z237 - Z209*ZZ_10r;
Z1519 = MX_10r*Z513 - MY_10r*Z502 + XZ_10r*Z229 + YZ_10r*Z238;
Z1520 = -ZZ_10r;
Z1521 = MX_10r*Z599 - MY_10r*Z598 + XZ_10r*Z550 + YZ_10r*Z551 - Z548*ZZ_10r + XY_10r*Z218^2 - XY_10r*Z219^2 - XX_10r*Z218*Z219 - XZ_10r*Z219*Z220 + YY_10r*Z218*Z219 + YZ_10r*Z218*Z220;
 
dHnew10r = [Z1483*ddx+Z1484*ddpsi+Z1485*ddq_imu+Z1486*ddq_w+Z1487*ddq_torso+Z1488*ddq_1r+Z1489*ddq_2r+Z1490*ddq_3r+Z1491*ddq_4r+Z1492*ddq_5r+Z1493*ddq_6r+Z1494*ddq_7r+Z1495;
    Z1496*ddx+Z1497*ddpsi+Z1498*ddq_imu+Z1499*ddq_w+Z1500*ddq_torso+Z1501*ddq_1r+Z1502*ddq_2r+Z1503*ddq_3r+Z1504*ddq_4r+Z1505*ddq_5r+Z1506*ddq_6r+Z1507*ddq_7r+Z1508;
    Z1509*ddx+Z1510*ddpsi+Z1511*ddq_imu+Z1512*ddq_w+Z1513*ddq_torso+Z1514*ddq_1r+Z1515*ddq_2r+Z1516*ddq_3r+Z1517*ddq_4r+Z1518*ddq_5r+Z1519*ddq_6r+Z1520*ddq_7r+Z1521];


%% LHS terms

% keysEq = {'x', 'psi', 'imu', 'w', 'torso', '4l', '5l', '6l', '7l', '8l', '9l', '10l', ...
%      '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% keysBody = {'L', 'R', '1', '2', '3', '4l', '5l', '6l', '7l', '8l', '9l', '10l', ...
%      '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% maGG = {maGL, maGR, maG1, maG2, maG3, maG4l, maG5l, maG6l, maG7l, maG8l, maG9l, maG10l, ...
%     maG4r, maG5r, maG6r, maG7r, maG8r, maG9r, maG10r};
% dvv = {dvL, dvR, dv1, dv2, dv3, dv4l, dv5l, dv6l, dv7l, dv8l, dv9l, dv10l, ...
%     dv4r, dv5r, dv6r, dv7r, dv8r, dv9r, dv10r};
% dHH = {dHGL, dHGR, dHnew1, dHnew2, dHnew3, dHnew4l, dHnew5l, dHnew6l, dHnew7l, dHnew8l, dHnew9l, dHnew10l, ...
%     dHnew4r, dHnew5r, dHnew6r, dHnew7r, dHnew8r, dHnew9r, dHnew10r};
% dww = {dwL, dwR, dw1, dw2, dw3, dw4l, dw5l, dw6l, dw7l, dw8l, dw9l, dw10l, ...
%     dw4r, dw5r, dw6r, dw7r, dw8r, dw9r, dw10r};
% ddq = ddqVec(f);
% n = 1521;
% fid = fopen('LHSout.m', 'w');
% for i=1:19
%     thisEq = keysEq{i};
%     for j=1:19
%         thisBody = keysBody{j};
%         LHSTerm = collect(maGG{j}'*dvv{j}(:,i) + dHH{j}'*dww{j}(:,i),[ddx,ddpsi,ddq_imu,ddq_w,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l,ddq_7l,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r]);
%         display(['% LHS_' thisBody '_' thisEq ' = ']); display('%'); display(['%      ' char(LHSTerm)]);
%         if(~isequal(LHSTerm,0))
%             LHSTermRem = LHSTerm; str = []; op = [];
%             for k = 1:length(ddq)
%                 Z = diff(LHSTerm,ddq(k));
%                 if(~isequal(Z,0))
%                     if(length(symvar(Z)) == 1)
%                         charZ = char(Z);
%                         if(charZ(1) == '-') op = []; end
%                         str = [str op char(Z) '*' char(ddq(k))]; op ='+';
%                     else
%                         n = n + 1;
%                         display(['Z' num2str(n) ' = ' char(Z) ';']);
%                         str = [str op 'Z' num2str(n) '*' char(ddq(k))]; op ='+';
%                     end
%                     LHSTermRem = simplify(LHSTermRem - Z*ddq(k));
%                 end
%             end
%             if(~isequal(LHSTermRem,0))
%                 if(length(symvar(LHSTermRem)) == 1)
%                     charZ = char(Z);
%                     if(charZ(1) == '-') op = []; end
%                     str = [str op char(LHSTermRem)];
%                 else
%                     n = n + 1;
%                     display(['Z' num2str(n) ' = ' char(LHSTermRem) ';']); display(' ');
%                     str = [str op 'Z' num2str(n)];
%                 end
%             end
%             strFull = ['LHS_' thisBody '_' thisEq ' = ' str ';']; 
%             disp(strFull); display(' ');
%             fprintf(fid,'%s\n\n',strFull);
%         else
%             fprintf(fid,'%s\n\n',['LHS_' thisBody '_' thisEq ' = 0;']); 
%         end
%     end
% end
% fclose(fid);

% LHS_L_x = 
%
%      (Z601 + Z1*Z613)*ddx + (Z602 + Z1*Z614)*ddpsi
Z1522 = Z601 + Z1*Z613;
Z1523 = Z602 + Z1*Z614;
LHS_L_x = Z1522*ddx+Z1523*ddpsi;
 
% LHS_R_x = 
%
%      (Z606 + Z1*Z619)*ddx + (Z607 + Z1*Z620)*ddpsi
Z1524 = Z606 + Z1*Z619;
Z1525 = Z607 + Z1*Z620;
LHS_R_x = Z1524*ddx+Z1525*ddpsi;
 
% LHS_1_x = 
%
%      (Z244*Z625 + Z245*Z629)*ddx + (Z244*Z626 + Z245*Z630)*ddpsi + (Z244*Z627 + Z245*Z631)*ddq_imu + (Z244*Z628 + Z245*Z632)
Z1526 = Z244*Z625 + Z245*Z629;
Z1527 = Z244*Z626 + Z245*Z630;
Z1528 = Z244*Z627 + Z245*Z631;
Z1529 = Z244*Z628 + Z245*Z632;
 
LHS_1_x = Z1526*ddx+Z1527*ddpsi+Z1528*ddq_imu+Z1529;
 
% LHS_2_x = 
%
%      (Z250*Z647 + Z252*Z652)*ddx + (Z250*Z648 + Z252*Z653)*ddpsi + (Z250*Z649 + Z252*Z654)*ddq_imu + (Z250*Z650 + Z252*Z655)*ddq_w + (Z250*Z651 + Z252*Z656)
Z1530 = Z250*Z647 + Z252*Z652;
Z1531 = Z250*Z648 + Z252*Z653;
Z1532 = Z250*Z649 + Z252*Z654;
Z1533 = Z250*Z650 + Z252*Z655;
Z1534 = Z250*Z651 + Z252*Z656;
 
LHS_2_x = Z1530*ddx+Z1531*ddpsi+Z1532*ddq_imu+Z1533*ddq_w+Z1534;
 
% LHS_3_x = 
%
%      (Z250*Z678 + Z257*Z672 + Z262*Z683)*ddx + (Z250*Z679 + Z257*Z673 + Z262*Z684)*ddpsi + (Z250*Z680 + Z257*Z674 + Z262*Z685)*ddq_imu + (Z250*Z681 + Z257*Z675 + Z262*Z686)*ddq_w + (Z250*Z682 + Z257*(Z677 + Z676*ddq_torso) + Z262*(Z688 + Z687*ddq_torso))
Z1535 = Z250*Z678 + Z257*Z672 + Z262*Z683;
Z1536 = Z250*Z679 + Z257*Z673 + Z262*Z684;
Z1537 = Z250*Z680 + Z257*Z674 + Z262*Z685;
Z1538 = Z250*Z681 + Z257*Z675 + Z262*Z686;
Z1539 = Z257*Z676 + Z262*Z687;
Z1540 = Z250*Z682 + Z257*Z677 + Z262*Z688;
 
LHS_3_x = Z1535*ddx+Z1536*ddpsi+Z1537*ddq_imu+Z1538*ddq_w+Z1539*ddq_torso+Z1540;
 
% LHS_4l_x = 
%
%      (Z257*Z714 + Z269*Z707 + Z277*Z720)*ddx + (Z257*Z715 + Z269*Z708 + Z277*Z721)*ddpsi + (Z257*Z716 + Z269*Z709 + Z277*Z722)*ddq_imu + (Z257*Z717 + Z269*Z710 + Z277*Z723)*ddq_w + (Z269*Z712 + Z277*Z725)*ddq_1l + (Z269*(Z713 + Z711*ddq_torso) + Z257*(Z719 + Z718*ddq_torso) + Z277*(Z726 + Z724*ddq_torso))
Z1541 = Z257*Z714 + Z269*Z707 + Z277*Z720;
Z1542 = Z257*Z715 + Z269*Z708 + Z277*Z721;
Z1543 = Z257*Z716 + Z269*Z709 + Z277*Z722;
Z1544 = Z257*Z717 + Z269*Z710 + Z277*Z723;
Z1545 = Z257*Z718 + Z269*Z711 + Z277*Z724;
Z1546 = Z269*Z712 + Z277*Z725;
Z1547 = Z257*Z719 + Z269*Z713 + Z277*Z726;
 
LHS_4l_x = Z1541*ddx+Z1542*ddpsi+Z1543*ddq_imu+Z1544*ddq_w+Z1545*ddq_torso+Z1546*ddq_1l+Z1547;
 
% LHS_5l_x = 
%
%      (Z284*Z755 - Z269*Z748 + Z289*Z763)*ddx + (Z284*Z756 - Z269*Z749 + Z289*Z764)*ddpsi + (Z284*Z757 - Z269*Z750 + Z289*Z765)*ddq_imu + (Z284*Z758 - Z269*Z751 + Z289*Z766)*ddq_w + (Z284*Z760 - Z269*Z753 + Z289*Z768)*ddq_1l + (Z284*Z761 + Z289*Z769)*ddq_2l + (Z284*(Z762 + Z759*ddq_torso) - Z269*(Z754 + Z752*ddq_torso) + Z289*(Z770 + Z767*ddq_torso))
Z1548 = Z284*Z755 - Z269*Z748 + Z289*Z763;
Z1549 = Z284*Z756 - Z269*Z749 + Z289*Z764;
Z1550 = Z284*Z757 - Z269*Z750 + Z289*Z765;
Z1551 = Z284*Z758 - Z269*Z751 + Z289*Z766;
Z1552 = Z284*Z759 - Z269*Z752 + Z289*Z767;
Z1553 = Z284*Z760 - Z269*Z753 + Z289*Z768;
Z1554 = Z284*Z761 + Z289*Z769;
Z1555 = Z284*Z762 - Z269*Z754 + Z289*Z770;
 
LHS_5l_x = Z1548*ddx+Z1549*ddpsi+Z1550*ddq_imu+Z1551*ddq_w+Z1552*ddq_torso+Z1553*ddq_1l+Z1554*ddq_2l+Z1555;
 
% LHS_6l_x = 
%
%      (Z296*Z795 - Z284*Z804 + Z303*Z812)*ddx + (Z296*Z796 - Z284*Z805 + Z303*Z813)*ddpsi + (Z296*Z797 - Z284*Z806 + Z303*Z814)*ddq_imu + (Z296*Z798 - Z284*Z807 + Z303*Z815)*ddq_w + (Z296*Z800 - Z284*Z809 + Z303*Z817)*ddq_1l + (Z296*Z801 - Z284*Z810 + Z303*Z818)*ddq_2l + (Z296*Z802 + Z303*Z819)*ddq_3l + (Z296*(Z803 + Z799*ddq_torso) - Z284*(Z811 + Z808*ddq_torso) + Z303*(Z820 + Z816*ddq_torso))
Z1556 = Z296*Z795 - Z284*Z804 + Z303*Z812;
Z1557 = Z296*Z796 - Z284*Z805 + Z303*Z813;
Z1558 = Z296*Z797 - Z284*Z806 + Z303*Z814;
Z1559 = Z296*Z798 - Z284*Z807 + Z303*Z815;
Z1560 = Z296*Z799 - Z284*Z808 + Z303*Z816;
Z1561 = Z296*Z800 - Z284*Z809 + Z303*Z817;
Z1562 = Z296*Z801 - Z284*Z810 + Z303*Z818;
Z1563 = Z296*Z802 + Z303*Z819;
Z1564 = Z296*Z803 - Z284*Z811 + Z303*Z820;
 
LHS_6l_x = Z1556*ddx+Z1557*ddpsi+Z1558*ddq_imu+Z1559*ddq_w+Z1560*ddq_torso+Z1561*ddq_1l+Z1562*ddq_2l+Z1563*ddq_3l+Z1564;
 
% LHS_7l_x = 
%
%      (Z312*Z857 - Z296*Z848 + Z319*Z867)*ddx + (Z312*Z858 - Z296*Z849 + Z319*Z868)*ddpsi + (Z312*Z859 - Z296*Z850 + Z319*Z869)*ddq_imu + (Z312*Z860 - Z296*Z851 + Z319*Z870)*ddq_w + (Z312*Z862 - Z296*Z853 + Z319*Z872)*ddq_1l + (Z312*Z863 - Z296*Z854 + Z319*Z873)*ddq_2l + (Z312*Z864 - Z296*Z855 + Z319*Z874)*ddq_3l + (Z312*Z865 + Z319*Z875)*ddq_4l + (Z312*(Z866 + Z861*ddq_torso) - Z296*(Z856 + Z852*ddq_torso) + Z319*(Z876 + Z871*ddq_torso))
Z1565 = Z312*Z857 - Z296*Z848 + Z319*Z867;
Z1566 = Z312*Z858 - Z296*Z849 + Z319*Z868;
Z1567 = Z312*Z859 - Z296*Z850 + Z319*Z869;
Z1568 = Z312*Z860 - Z296*Z851 + Z319*Z870;
Z1569 = Z312*Z861 - Z296*Z852 + Z319*Z871;
Z1570 = Z312*Z862 - Z296*Z853 + Z319*Z872;
Z1571 = Z312*Z863 - Z296*Z854 + Z319*Z873;
Z1572 = Z312*Z864 - Z296*Z855 + Z319*Z874;
Z1573 = Z312*Z865 + Z319*Z875;
Z1574 = Z312*Z866 - Z296*Z856 + Z319*Z876;
 
LHS_7l_x = Z1565*ddx+Z1566*ddpsi+Z1567*ddq_imu+Z1568*ddq_w+Z1569*ddq_torso+Z1570*ddq_1l+Z1571*ddq_2l+Z1572*ddq_3l+Z1573*ddq_4l+Z1574;
 
% LHS_8l_x = 
%
%      (Z328*Z907 - Z312*Z918 + Z337*Z928)*ddx + (Z328*Z908 - Z312*Z919 + Z337*Z929)*ddpsi + (Z328*Z909 - Z312*Z920 + Z337*Z930)*ddq_imu + (Z328*Z910 - Z312*Z921 + Z337*Z931)*ddq_w + (Z328*Z912 - Z312*Z923 + Z337*Z933)*ddq_1l + (Z328*Z913 - Z312*Z924 + Z337*Z934)*ddq_2l + (Z328*Z914 - Z312*Z925 + Z337*Z935)*ddq_3l + (Z328*Z915 - Z312*Z926 + Z337*Z936)*ddq_4l + (Z328*Z916 + Z337*Z937)*ddq_5l + (Z328*(Z917 + Z911*ddq_torso) - Z312*(Z927 + Z922*ddq_torso) + Z337*(Z938 + Z932*ddq_torso))
Z1575 = Z328*Z907 - Z312*Z918 + Z337*Z928;
Z1576 = Z328*Z908 - Z312*Z919 + Z337*Z929;
Z1577 = Z328*Z909 - Z312*Z920 + Z337*Z930;
Z1578 = Z328*Z910 - Z312*Z921 + Z337*Z931;
Z1579 = Z328*Z911 - Z312*Z922 + Z337*Z932;
Z1580 = Z328*Z912 - Z312*Z923 + Z337*Z933;
Z1581 = Z328*Z913 - Z312*Z924 + Z337*Z934;
Z1582 = Z328*Z914 - Z312*Z925 + Z337*Z935;
Z1583 = Z328*Z915 - Z312*Z926 + Z337*Z936;
Z1584 = Z328*Z916 + Z337*Z937;
Z1585 = Z328*Z917 - Z312*Z927 + Z337*Z938;
 
LHS_8l_x = Z1575*ddx+Z1576*ddpsi+Z1577*ddq_imu+Z1578*ddq_w+Z1579*ddq_torso+Z1580*ddq_1l+Z1581*ddq_2l+Z1582*ddq_3l+Z1583*ddq_4l+Z1584*ddq_5l+Z1585;
 
% LHS_9l_x = 
%
%      (Z348*Z983 - Z328*Z972 + Z357*Z995)*ddx + (Z348*Z984 - Z328*Z973 + Z357*Z996)*ddpsi + (Z348*Z985 - Z328*Z974 + Z357*Z997)*ddq_imu + (Z348*Z986 - Z328*Z975 + Z357*Z998)*ddq_w + (Z348*Z988 - Z328*Z977 + Z357*Z1000)*ddq_1l + (Z348*Z989 - Z328*Z978 + Z357*Z1001)*ddq_2l + (Z348*Z990 - Z328*Z979 + Z357*Z1002)*ddq_3l + (Z348*Z991 - Z328*Z980 + Z357*Z1003)*ddq_4l + (Z348*Z992 - Z328*Z981 + Z357*Z1004)*ddq_5l + (Z348*Z993 + Z357*Z1005)*ddq_6l + (Z348*(Z994 + Z987*ddq_torso) - Z328*(Z982 + Z976*ddq_torso) + Z357*(Z1006 + Z999*ddq_torso))
Z1586 = Z348*Z983 - Z328*Z972 + Z357*Z995;
Z1587 = Z348*Z984 - Z328*Z973 + Z357*Z996;
Z1588 = Z348*Z985 - Z328*Z974 + Z357*Z997;
Z1589 = Z348*Z986 - Z328*Z975 + Z357*Z998;
Z1590 = Z348*Z987 - Z328*Z976 + Z357*Z999;
Z1591 = Z348*Z988 - Z328*Z977 + Z357*Z1000;
Z1592 = Z348*Z989 - Z328*Z978 + Z357*Z1001;
Z1593 = Z348*Z990 - Z328*Z979 + Z357*Z1002;
Z1594 = Z348*Z991 - Z328*Z980 + Z357*Z1003;
Z1595 = Z348*Z992 - Z328*Z981 + Z357*Z1004;
Z1596 = Z348*Z993 + Z357*Z1005;
Z1597 = Z348*Z994 - Z328*Z982 + Z357*Z1006;
 
LHS_9l_x = Z1586*ddx+Z1587*ddpsi+Z1588*ddq_imu+Z1589*ddq_w+Z1590*ddq_torso+Z1591*ddq_1l+Z1592*ddq_2l+Z1593*ddq_3l+Z1594*ddq_4l+Z1595*ddq_5l+Z1596*ddq_6l+Z1597;
 
% LHS_10l_x = 
%
%      (Z368*Z1043 - Z348*Z1069 + Z379*Z1056)*ddx + (Z368*Z1044 - Z348*Z1070 + Z379*Z1057)*ddpsi + (Z368*Z1045 - Z348*Z1071 + Z379*Z1058)*ddq_imu + (Z368*Z1046 - Z348*Z1072 + Z379*Z1059)*ddq_w + (Z368*Z1048 - Z348*Z1074 + Z379*Z1061)*ddq_1l + (Z368*Z1049 - Z348*Z1075 + Z379*Z1062)*ddq_2l + (Z368*Z1050 - Z348*Z1076 + Z379*Z1063)*ddq_3l + (Z368*Z1051 - Z348*Z1077 + Z379*Z1064)*ddq_4l + (Z368*Z1052 - Z348*Z1078 + Z379*Z1065)*ddq_5l + (Z368*Z1053 - Z348*Z1079 + Z379*Z1066)*ddq_6l + (Z368*Z1054 + Z379*Z1067)*ddq_7l + (Z368*(Z1055 + Z1047*ddq_torso) - Z348*(Z1080 + Z1073*ddq_torso) + Z379*(Z1068 + Z1060*ddq_torso))
Z1598 = Z368*Z1043 - Z348*Z1069 + Z379*Z1056;
Z1599 = Z368*Z1044 - Z348*Z1070 + Z379*Z1057;
Z1600 = Z368*Z1045 - Z348*Z1071 + Z379*Z1058;
Z1601 = Z368*Z1046 - Z348*Z1072 + Z379*Z1059;
Z1602 = Z368*Z1047 - Z348*Z1073 + Z379*Z1060;
Z1603 = Z368*Z1048 - Z348*Z1074 + Z379*Z1061;
Z1604 = Z368*Z1049 - Z348*Z1075 + Z379*Z1062;
Z1605 = Z368*Z1050 - Z348*Z1076 + Z379*Z1063;
Z1606 = Z368*Z1051 - Z348*Z1077 + Z379*Z1064;
Z1607 = Z368*Z1052 - Z348*Z1078 + Z379*Z1065;
Z1608 = Z368*Z1053 - Z348*Z1079 + Z379*Z1066;
Z1609 = Z368*Z1054 + Z379*Z1067;
Z1610 = Z368*Z1055 - Z348*Z1080 + Z379*Z1068;
 
LHS_10l_x = Z1598*ddx+Z1599*ddpsi+Z1600*ddq_imu+Z1601*ddq_w+Z1602*ddq_torso+Z1603*ddq_1l+Z1604*ddq_2l+Z1605*ddq_3l+Z1606*ddq_4l+Z1607*ddq_5l+Z1608*ddq_6l+Z1609*ddq_7l+Z1610;
 
% LHS_4r_x = 
%
%      (Z393*Z1120 - Z257*Z1127 + Z401*Z1133)*ddx + (Z393*Z1121 - Z257*Z1128 + Z401*Z1134)*ddpsi + (Z393*Z1122 - Z257*Z1129 + Z401*Z1135)*ddq_imu + (Z393*Z1123 - Z257*Z1130 + Z401*Z1136)*ddq_w + (Z393*Z1125 + Z401*Z1138)*ddq_1r + (Z393*(Z1126 + Z1124*ddq_torso) - Z257*(Z1132 + Z1131*ddq_torso) + Z401*(Z1139 + Z1137*ddq_torso))
Z1611 = Z393*Z1120 - Z257*Z1127 + Z401*Z1133;
Z1612 = Z393*Z1121 - Z257*Z1128 + Z401*Z1134;
Z1613 = Z393*Z1122 - Z257*Z1129 + Z401*Z1135;
Z1614 = Z393*Z1123 - Z257*Z1130 + Z401*Z1136;
Z1615 = Z393*Z1124 - Z257*Z1131 + Z401*Z1137;
Z1616 = Z393*Z1125 + Z401*Z1138;
Z1617 = Z393*Z1126 - Z257*Z1132 + Z401*Z1139;
 
LHS_4r_x = Z1611*ddx+Z1612*ddpsi+Z1613*ddq_imu+Z1614*ddq_w+Z1615*ddq_torso+Z1616*ddq_1r+Z1617;
 
% LHS_5r_x = 
%
%      (Z408*Z1167 - Z393*Z1161 + Z413*Z1173)*ddx + (Z408*Z1168 - Z393*Z1162 + Z413*Z1174)*ddpsi + (Z408*Z1169 - Z393*Z1163 + Z413*Z1175)*ddq_imu + (Z408*Z1170 - Z393*Z1164 + Z413*Z1176)*ddq_w + (Z408*(Z1172 + Z1171*ddq_torso) - Z393*(Z1166 + Z1165*ddq_torso) + Z413*(Z1178 + Z1177*ddq_torso))
Z1618 = Z408*Z1167 - Z393*Z1161 + Z413*Z1173;
Z1619 = Z408*Z1168 - Z393*Z1162 + Z413*Z1174;
Z1620 = Z408*Z1169 - Z393*Z1163 + Z413*Z1175;
Z1621 = Z408*Z1170 - Z393*Z1164 + Z413*Z1176;
Z1622 = Z408*Z1171 - Z393*Z1165 + Z413*Z1177;
Z1623 = Z408*Z1172 - Z393*Z1166 + Z413*Z1178;
 
LHS_5r_x = Z1618*ddx+Z1619*ddpsi+Z1620*ddq_imu+Z1621*ddq_w+Z1622*ddq_torso+Z1623;
 
% LHS_6r_x = 
%
%      (Z420*Z1197 - Z408*Z1206 + Z427*Z1214)*ddx + (Z420*Z1198 - Z408*Z1207 + Z427*Z1215)*ddpsi + (Z420*Z1199 - Z408*Z1208 + Z427*Z1216)*ddq_imu + (Z420*Z1200 - Z408*Z1209 + Z427*Z1217)*ddq_w + (Z420*Z1202 - Z408*Z1211 + Z427*Z1219)*ddq_1r + (Z420*Z1203 - Z408*Z1212 + Z427*Z1220)*ddq_2r + (Z420*Z1204 + Z427*Z1221)*ddq_3r + (Z420*(Z1205 + Z1201*ddq_torso) - Z408*(Z1213 + Z1210*ddq_torso) + Z427*(Z1222 + Z1218*ddq_torso))
Z1624 = Z420*Z1197 - Z408*Z1206 + Z427*Z1214;
Z1625 = Z420*Z1198 - Z408*Z1207 + Z427*Z1215;
Z1626 = Z420*Z1199 - Z408*Z1208 + Z427*Z1216;
Z1627 = Z420*Z1200 - Z408*Z1209 + Z427*Z1217;
Z1628 = Z420*Z1201 - Z408*Z1210 + Z427*Z1218;
Z1629 = Z420*Z1202 - Z408*Z1211 + Z427*Z1219;
Z1630 = Z420*Z1203 - Z408*Z1212 + Z427*Z1220;
Z1631 = Z420*Z1204 + Z427*Z1221;
Z1632 = Z420*Z1205 - Z408*Z1213 + Z427*Z1222;
 
LHS_6r_x = Z1624*ddx+Z1625*ddpsi+Z1626*ddq_imu+Z1627*ddq_w+Z1628*ddq_torso+Z1629*ddq_1r+Z1630*ddq_2r+Z1631*ddq_3r+Z1632;
 
% LHS_7r_x = 
%
%      (Z436*Z1259 - Z420*Z1250 + Z443*Z1269)*ddx + (Z436*Z1260 - Z420*Z1251 + Z443*Z1270)*ddpsi + (Z436*Z1261 - Z420*Z1252 + Z443*Z1271)*ddq_imu + (Z436*Z1262 - Z420*Z1253 + Z443*Z1272)*ddq_w + (Z436*Z1264 - Z420*Z1255 + Z443*Z1274)*ddq_1r + (Z436*Z1265 - Z420*Z1256 + Z443*Z1275)*ddq_2r + (Z436*Z1266 - Z420*Z1257 + Z443*Z1276)*ddq_3r + (Z436*Z1267 + Z443*Z1277)*ddq_4r + (Z436*(Z1268 + Z1263*ddq_torso) - Z420*(Z1258 + Z1254*ddq_torso) + Z443*(Z1278 + Z1273*ddq_torso))
Z1633 = Z436*Z1259 - Z420*Z1250 + Z443*Z1269;
Z1634 = Z436*Z1260 - Z420*Z1251 + Z443*Z1270;
Z1635 = Z436*Z1261 - Z420*Z1252 + Z443*Z1271;
Z1636 = Z436*Z1262 - Z420*Z1253 + Z443*Z1272;
Z1637 = Z436*Z1263 - Z420*Z1254 + Z443*Z1273;
Z1638 = Z436*Z1264 - Z420*Z1255 + Z443*Z1274;
Z1639 = Z436*Z1265 - Z420*Z1256 + Z443*Z1275;
Z1640 = Z436*Z1266 - Z420*Z1257 + Z443*Z1276;
Z1641 = Z436*Z1267 + Z443*Z1277;
Z1642 = Z436*Z1268 - Z420*Z1258 + Z443*Z1278;
 
LHS_7r_x = Z1633*ddx+Z1634*ddpsi+Z1635*ddq_imu+Z1636*ddq_w+Z1637*ddq_torso+Z1638*ddq_1r+Z1639*ddq_2r+Z1640*ddq_3r+Z1641*ddq_4r+Z1642;
 
% LHS_8r_x = 
%
%      (Z452*Z1309 - Z436*Z1320 + Z461*Z1330)*ddx + (Z452*Z1310 - Z436*Z1321 + Z461*Z1331)*ddpsi + (Z452*Z1311 - Z436*Z1322 + Z461*Z1332)*ddq_imu + (Z452*Z1312 - Z436*Z1323 + Z461*Z1333)*ddq_w + (Z452*Z1314 - Z436*Z1325 + Z461*Z1335)*ddq_1r + (Z452*Z1315 - Z436*Z1326 + Z461*Z1336)*ddq_2r + (Z452*Z1316 - Z436*Z1327 + Z461*Z1337)*ddq_3r + (Z452*Z1317 - Z436*Z1328 + Z461*Z1338)*ddq_4r + (Z452*Z1318 + Z461*Z1339)*ddq_5r + (Z452*(Z1319 + Z1313*ddq_torso) - Z436*(Z1329 + Z1324*ddq_torso) + Z461*(Z1340 + Z1334*ddq_torso))
Z1643 = Z452*Z1309 - Z436*Z1320 + Z461*Z1330;
Z1644 = Z452*Z1310 - Z436*Z1321 + Z461*Z1331;
Z1645 = Z452*Z1311 - Z436*Z1322 + Z461*Z1332;
Z1646 = Z452*Z1312 - Z436*Z1323 + Z461*Z1333;
Z1647 = Z452*Z1313 - Z436*Z1324 + Z461*Z1334;
Z1648 = Z452*Z1314 - Z436*Z1325 + Z461*Z1335;
Z1649 = Z452*Z1315 - Z436*Z1326 + Z461*Z1336;
Z1650 = Z452*Z1316 - Z436*Z1327 + Z461*Z1337;
Z1651 = Z452*Z1317 - Z436*Z1328 + Z461*Z1338;
Z1652 = Z452*Z1318 + Z461*Z1339;
Z1653 = Z452*Z1319 - Z436*Z1329 + Z461*Z1340;
 
LHS_8r_x = Z1643*ddx+Z1644*ddpsi+Z1645*ddq_imu+Z1646*ddq_w+Z1647*ddq_torso+Z1648*ddq_1r+Z1649*ddq_2r+Z1650*ddq_3r+Z1651*ddq_4r+Z1652*ddq_5r+Z1653;
 
% LHS_9r_x = 
%
%      (Z472*Z1385 - Z452*Z1374 + Z481*Z1397)*ddx + (Z472*Z1386 - Z452*Z1375 + Z481*Z1398)*ddpsi + (Z472*Z1387 - Z452*Z1376 + Z481*Z1399)*ddq_imu + (Z472*Z1388 - Z452*Z1377 + Z481*Z1400)*ddq_w + (Z472*Z1390 - Z452*Z1379 + Z481*Z1402)*ddq_1r + (Z472*Z1391 - Z452*Z1380 + Z481*Z1403)*ddq_2r + (Z472*Z1392 - Z452*Z1381 + Z481*Z1404)*ddq_3r + (Z472*Z1393 - Z452*Z1382 + Z481*Z1405)*ddq_4r + (Z472*Z1394 - Z452*Z1383 + Z481*Z1406)*ddq_5r + (Z472*Z1395 + Z481*Z1407)*ddq_6r + (Z472*(Z1396 + Z1389*ddq_torso) - Z452*(Z1384 + Z1378*ddq_torso) + Z481*(Z1408 + Z1401*ddq_torso))
Z1654 = Z472*Z1385 - Z452*Z1374 + Z481*Z1397;
Z1655 = Z472*Z1386 - Z452*Z1375 + Z481*Z1398;
Z1656 = Z472*Z1387 - Z452*Z1376 + Z481*Z1399;
Z1657 = Z472*Z1388 - Z452*Z1377 + Z481*Z1400;
Z1658 = Z472*Z1389 - Z452*Z1378 + Z481*Z1401;
Z1659 = Z472*Z1390 - Z452*Z1379 + Z481*Z1402;
Z1660 = Z472*Z1391 - Z452*Z1380 + Z481*Z1403;
Z1661 = Z472*Z1392 - Z452*Z1381 + Z481*Z1404;
Z1662 = Z472*Z1393 - Z452*Z1382 + Z481*Z1405;
Z1663 = Z472*Z1394 - Z452*Z1383 + Z481*Z1406;
Z1664 = Z472*Z1395 + Z481*Z1407;
Z1665 = Z472*Z1396 - Z452*Z1384 + Z481*Z1408;
 
LHS_9r_x = Z1654*ddx+Z1655*ddpsi+Z1656*ddq_imu+Z1657*ddq_w+Z1658*ddq_torso+Z1659*ddq_1r+Z1660*ddq_2r+Z1661*ddq_3r+Z1662*ddq_4r+Z1663*ddq_5r+Z1664*ddq_6r+Z1665;
 
% LHS_10r_x = 
%
%      (Z492*Z1445 - Z472*Z1471 + Z503*Z1458)*ddx + (Z492*Z1446 - Z472*Z1472 + Z503*Z1459)*ddpsi + (Z492*Z1447 - Z472*Z1473 + Z503*Z1460)*ddq_imu + (Z492*Z1448 - Z472*Z1474 + Z503*Z1461)*ddq_w + (Z492*Z1450 - Z472*Z1476 + Z503*Z1463)*ddq_1r + (Z492*Z1451 - Z472*Z1477 + Z503*Z1464)*ddq_2r + (Z492*Z1452 - Z472*Z1478 + Z503*Z1465)*ddq_3r + (Z492*Z1453 - Z472*Z1479 + Z503*Z1466)*ddq_4r + (Z492*Z1454 - Z472*Z1480 + Z503*Z1467)*ddq_5r + (Z492*Z1455 - Z472*Z1481 + Z503*Z1468)*ddq_6r + (Z492*Z1456 + Z503*Z1469)*ddq_7r + (Z492*(Z1457 + Z1449*ddq_torso) - Z472*(Z1482 + Z1475*ddq_torso) + Z503*(Z1470 + Z1462*ddq_torso))
Z1666 = Z492*Z1445 - Z472*Z1471 + Z503*Z1458;
Z1667 = Z492*Z1446 - Z472*Z1472 + Z503*Z1459;
Z1668 = Z492*Z1447 - Z472*Z1473 + Z503*Z1460;
Z1669 = Z492*Z1448 - Z472*Z1474 + Z503*Z1461;
Z1670 = Z492*Z1449 - Z472*Z1475 + Z503*Z1462;
Z1671 = Z492*Z1450 - Z472*Z1476 + Z503*Z1463;
Z1672 = Z492*Z1451 - Z472*Z1477 + Z503*Z1464;
Z1673 = Z492*Z1452 - Z472*Z1478 + Z503*Z1465;
Z1674 = Z492*Z1453 - Z472*Z1479 + Z503*Z1466;
Z1675 = Z492*Z1454 - Z472*Z1480 + Z503*Z1467;
Z1676 = Z492*Z1455 - Z472*Z1481 + Z503*Z1468;
Z1677 = Z492*Z1456 + Z503*Z1469;
Z1678 = Z492*Z1457 - Z472*Z1482 + Z503*Z1470;
 
LHS_10r_x = Z1666*ddx+Z1667*ddpsi+Z1668*ddq_imu+Z1669*ddq_w+Z1670*ddq_torso+Z1671*ddq_1r+Z1672*ddq_2r+Z1673*ddq_3r+Z1674*ddq_4r+Z1675*ddq_5r+Z1676*ddq_6r+Z1677*ddq_7r+Z1678;
 
% LHS_L_psi = 
%
%      (- Z2*Z613 - Z241*Z601)*ddx + (Z4*Z615 - Z2*Z614 - Z3*Z611 - Z241*Z602)*ddpsi + (Z4*Z616 - Z3*Z612)
Z1679 = - Z2*Z613 - Z241*Z601;
Z1680 = Z4*Z615 - Z2*Z614 - Z3*Z611 - Z241*Z602;
Z1681 = Z4*Z616 - Z3*Z612;
 
LHS_L_psi = Z1679*ddx+Z1680*ddpsi+Z1681;
 
% LHS_R_psi = 
%
%      (Z2*Z619 + Z241*Z606)*ddx + (Z2*Z620 - Z8*Z617 + Z9*Z621 + Z241*Z607)*ddpsi + (Z9*Z622 - Z8*Z618)
Z1682 = Z2*Z619 + Z241*Z606;
Z1683 = Z2*Z620 - Z8*Z617 + Z9*Z621 + Z241*Z607;
Z1684 = Z9*Z622 - Z8*Z618;
 
LHS_R_psi = Z1682*ddx+Z1683*ddpsi+Z1684;
 
% LHS_1_psi = 
%
%      (Z13*Z637 + Z14*Z641)*ddx + (Z13*Z638 + Z14*Z642)*ddpsi + (Z13*Z639 + Z14*Z643)*ddq_imu + (Z13*Z640 + Z14*Z644)
Z1685 = Z13*Z637 + Z14*Z641;
Z1686 = Z13*Z638 + Z14*Z642;
Z1687 = Z13*Z639 + Z14*Z643;
Z1688 = Z13*Z640 + Z14*Z644;
 
LHS_1_psi = Z1685*ddx+Z1686*ddpsi+Z1687*ddq_imu+Z1688;
 
% LHS_2_psi = 
%
%      (Z20*Z662 + Z21*Z667)*ddx + (Z20*Z663 + Z21*Z668 + Z249*Z645)*ddpsi + (Z20*Z664 + Z21*Z669)*ddq_imu + (Z20*Z665 + Z21*Z670)*ddq_w + (Z20*Z666 + Z21*Z671 + Z249*Z646)
Z1689 = Z20*Z662 + Z21*Z667;
Z1690 = Z20*Z663 + Z21*Z668 + Z249*Z645;
Z1691 = Z20*Z664 + Z21*Z669;
Z1692 = Z20*Z665 + Z21*Z670;
Z1693 = Z20*Z666 + Z21*Z671 + Z249*Z646;
 
LHS_2_psi = Z1689*ddx+Z1690*ddpsi+Z1691*ddq_imu+Z1692*ddq_w+Z1693;
 
% LHS_3_psi = 
%
%      (Z20*Z695 + Z26*Z689 + Z28*Z701 + Z61*Z678 + Z63*Z683 + Z258*Z672)*ddx + (Z20*Z696 + Z26*Z690 + Z28*Z702 + Z61*Z679 + Z63*Z684 + Z258*Z673)*ddpsi + (Z20*Z697 + Z26*Z691 + Z28*Z703 + Z61*Z680 + Z63*Z685 + Z258*Z674)*ddq_imu + (Z20*Z698 + Z26*Z692 + Z28*Z704 + Z61*Z681 + Z63*Z686 + Z258*Z675)*ddq_w + (Z61*Z682 + Z26*(Z694 + Z693*ddq_torso) + Z20*(Z700 + Z699*ddq_torso) + Z63*(Z688 + Z687*ddq_torso) + Z28*(Z706 + Z705*ddq_torso) + Z258*(Z677 + Z676*ddq_torso))
Z1694 = Z20*Z695 + Z26*Z689 + Z28*Z701 + Z61*Z678 + Z63*Z683 + Z258*Z672;
Z1695 = Z20*Z696 + Z26*Z690 + Z28*Z702 + Z61*Z679 + Z63*Z684 + Z258*Z673;
Z1696 = Z20*Z697 + Z26*Z691 + Z28*Z703 + Z61*Z680 + Z63*Z685 + Z258*Z674;
Z1697 = Z20*Z698 + Z26*Z692 + Z28*Z704 + Z61*Z681 + Z63*Z686 + Z258*Z675;
Z1698 = Z20*Z699 + Z26*Z693 + Z28*Z705 + Z63*Z687 + Z258*Z676;
Z1699 = Z20*Z700 + Z26*Z694 + Z28*Z706 + Z61*Z682 + Z63*Z688 + Z258*Z677;
 
LHS_3_psi = Z1694*ddx+Z1695*ddpsi+Z1696*ddq_imu+Z1697*ddq_w+Z1698*ddq_torso+Z1699;
 
% LHS_4l_psi = 
%
%      (Z32*Z727 + Z26*Z734 + Z35*Z741 + Z74*Z714 + Z270*Z707 + Z278*Z720)*ddx + (Z32*Z728 + Z26*Z735 + Z35*Z742 + Z74*Z715 + Z270*Z708 + Z278*Z721)*ddpsi + (Z32*Z729 + Z26*Z736 + Z35*Z743 + Z74*Z716 + Z270*Z709 + Z278*Z722)*ddq_imu + (Z32*Z730 + Z26*Z737 + Z35*Z744 + Z74*Z717 + Z270*Z710 + Z278*Z723)*ddq_w + (Z32*Z732 + Z26*Z739 + Z35*Z746 + Z270*Z712 + Z278*Z725)*ddq_1l + (Z32*(Z733 + Z731*ddq_torso) + Z26*(Z740 + Z738*ddq_torso) + Z74*(Z719 + Z718*ddq_torso) + Z35*(Z747 + Z745*ddq_torso) + Z270*(Z713 + Z711*ddq_torso) + Z278*(Z726 + Z724*ddq_torso))
Z1700 = Z32*Z727 + Z26*Z734 + Z35*Z741 + Z74*Z714 + Z270*Z707 + Z278*Z720;
Z1701 = Z32*Z728 + Z26*Z735 + Z35*Z742 + Z74*Z715 + Z270*Z708 + Z278*Z721;
Z1702 = Z32*Z729 + Z26*Z736 + Z35*Z743 + Z74*Z716 + Z270*Z709 + Z278*Z722;
Z1703 = Z32*Z730 + Z26*Z737 + Z35*Z744 + Z74*Z717 + Z270*Z710 + Z278*Z723;
Z1704 = Z32*Z731 + Z26*Z738 + Z35*Z745 + Z74*Z718 + Z270*Z711 + Z278*Z724;
Z1705 = Z32*Z732 + Z26*Z739 + Z35*Z746 + Z270*Z712 + Z278*Z725;
Z1706 = Z32*Z733 + Z26*Z740 + Z35*Z747 + Z74*Z719 + Z270*Z713 + Z278*Z726;
 
LHS_4l_psi = Z1700*ddx+Z1701*ddpsi+Z1702*ddq_imu+Z1703*ddq_w+Z1704*ddq_torso+Z1705*ddq_1l+Z1706;
 
% LHS_5l_psi = 
%
%      (Z41*Z779 - Z32*Z771 + Z45*Z787 + Z85*Z755 - Z270*Z748 + Z290*Z763)*ddx + (Z41*Z780 - Z32*Z772 + Z45*Z788 + Z85*Z756 - Z270*Z749 + Z290*Z764)*ddpsi + (Z41*Z781 - Z32*Z773 + Z45*Z789 + Z85*Z757 - Z270*Z750 + Z290*Z765)*ddq_imu + (Z41*Z782 - Z32*Z774 + Z45*Z790 + Z85*Z758 - Z270*Z751 + Z290*Z766)*ddq_w + (Z41*Z784 - Z32*Z776 + Z45*Z792 + Z85*Z760 - Z270*Z753 + Z290*Z768)*ddq_1l + (Z41*Z785 - Z32*Z777 + Z45*Z793 + Z85*Z761 + Z290*Z769)*ddq_2l + (Z85*(Z762 + Z759*ddq_torso) - Z32*(Z778 + Z775*ddq_torso) + Z41*(Z786 + Z783*ddq_torso) + Z45*(Z794 + Z791*ddq_torso) - Z270*(Z754 + Z752*ddq_torso) + Z290*(Z770 + Z767*ddq_torso))
Z1707 = Z41*Z779 - Z32*Z771 + Z45*Z787 + Z85*Z755 - Z270*Z748 + Z290*Z763;
Z1708 = Z41*Z780 - Z32*Z772 + Z45*Z788 + Z85*Z756 - Z270*Z749 + Z290*Z764;
Z1709 = Z41*Z781 - Z32*Z773 + Z45*Z789 + Z85*Z757 - Z270*Z750 + Z290*Z765;
Z1710 = Z41*Z782 - Z32*Z774 + Z45*Z790 + Z85*Z758 - Z270*Z751 + Z290*Z766;
Z1711 = Z41*Z783 - Z32*Z775 + Z45*Z791 + Z85*Z759 - Z270*Z752 + Z290*Z767;
Z1712 = Z41*Z784 - Z32*Z776 + Z45*Z792 + Z85*Z760 - Z270*Z753 + Z290*Z768;
Z1713 = Z41*Z785 - Z32*Z777 + Z45*Z793 + Z85*Z761 + Z290*Z769;
Z1714 = Z41*Z786 - Z32*Z778 + Z45*Z794 + Z85*Z762 - Z270*Z754 + Z290*Z770;
 
LHS_5l_psi = Z1707*ddx+Z1708*ddpsi+Z1709*ddq_imu+Z1710*ddq_w+Z1711*ddq_torso+Z1712*ddq_1l+Z1713*ddq_2l+Z1714;
 
% LHS_6l_psi = 
%
%      (Z52*Z821 - Z41*Z830 - Z85*Z804 + Z57*Z839 + Z297*Z795 + Z304*Z812)*ddx + (Z52*Z822 - Z41*Z831 - Z85*Z805 + Z57*Z840 + Z297*Z796 + Z304*Z813)*ddpsi + (Z52*Z823 - Z41*Z832 - Z85*Z806 + Z57*Z841 + Z297*Z797 + Z304*Z814)*ddq_imu + (Z52*Z824 - Z41*Z833 - Z85*Z807 + Z57*Z842 + Z297*Z798 + Z304*Z815)*ddq_w + (Z52*Z826 - Z41*Z835 - Z85*Z809 + Z57*Z844 + Z297*Z800 + Z304*Z817)*ddq_1l + (Z52*Z827 - Z41*Z836 - Z85*Z810 + Z57*Z845 + Z297*Z801 + Z304*Z818)*ddq_2l + (Z52*Z828 - Z41*Z837 + Z57*Z846 + Z297*Z802 + Z304*Z819)*ddq_3l + (Z52*(Z829 + Z825*ddq_torso) - Z85*(Z811 + Z808*ddq_torso) - Z41*(Z838 + Z834*ddq_torso) + Z57*(Z847 + Z843*ddq_torso) + Z297*(Z803 + Z799*ddq_torso) + Z304*(Z820 + Z816*ddq_torso))
Z1715 = Z52*Z821 - Z41*Z830 - Z85*Z804 + Z57*Z839 + Z297*Z795 + Z304*Z812;
Z1716 = Z52*Z822 - Z41*Z831 - Z85*Z805 + Z57*Z840 + Z297*Z796 + Z304*Z813;
Z1717 = Z52*Z823 - Z41*Z832 - Z85*Z806 + Z57*Z841 + Z297*Z797 + Z304*Z814;
Z1718 = Z52*Z824 - Z41*Z833 - Z85*Z807 + Z57*Z842 + Z297*Z798 + Z304*Z815;
Z1719 = Z52*Z825 - Z41*Z834 - Z85*Z808 + Z57*Z843 + Z297*Z799 + Z304*Z816;
Z1720 = Z52*Z826 - Z41*Z835 - Z85*Z809 + Z57*Z844 + Z297*Z800 + Z304*Z817;
Z1721 = Z52*Z827 - Z41*Z836 - Z85*Z810 + Z57*Z845 + Z297*Z801 + Z304*Z818;
Z1722 = Z52*Z828 - Z41*Z837 + Z57*Z846 + Z297*Z802 + Z304*Z819;
Z1723 = Z52*Z829 - Z41*Z838 - Z85*Z811 + Z57*Z847 + Z297*Z803 + Z304*Z820;
 
LHS_6l_psi = Z1715*ddx+Z1716*ddpsi+Z1717*ddq_imu+Z1718*ddq_w+Z1719*ddq_torso+Z1720*ddq_1l+Z1721*ddq_2l+Z1722*ddq_3l+Z1723;
 
% LHS_7l_psi = 
%
%      (Z65*Z887 - Z52*Z877 + Z71*Z897 - Z297*Z848 + Z313*Z857 + Z320*Z867)*ddx + (Z65*Z888 - Z52*Z878 + Z71*Z898 - Z297*Z849 + Z313*Z858 + Z320*Z868)*ddpsi + (Z65*Z889 - Z52*Z879 + Z71*Z899 - Z297*Z850 + Z313*Z859 + Z320*Z869)*ddq_imu + (Z65*Z890 - Z52*Z880 + Z71*Z900 - Z297*Z851 + Z313*Z860 + Z320*Z870)*ddq_w + (Z65*Z892 - Z52*Z882 + Z71*Z902 - Z297*Z853 + Z313*Z862 + Z320*Z872)*ddq_1l + (Z65*Z893 - Z52*Z883 + Z71*Z903 - Z297*Z854 + Z313*Z863 + Z320*Z873)*ddq_2l + (Z65*Z894 - Z52*Z884 + Z71*Z904 - Z297*Z855 + Z313*Z864 + Z320*Z874)*ddq_3l + (Z65*Z895 - Z52*Z885 + Z71*Z905 + Z313*Z865 + Z320*Z875)*ddq_4l + (Z65*(Z896 + Z891*ddq_torso) - Z52*(Z886 + Z881*ddq_torso) + Z71*(Z906 + Z901*ddq_torso) - Z297*(Z856 + Z852*ddq_torso) + Z313*(Z866 + Z861*ddq_torso) + Z320*(Z876 + Z871*ddq_torso))
Z1724 = Z65*Z887 - Z52*Z877 + Z71*Z897 - Z297*Z848 + Z313*Z857 + Z320*Z867;
Z1725 = Z65*Z888 - Z52*Z878 + Z71*Z898 - Z297*Z849 + Z313*Z858 + Z320*Z868;
Z1726 = Z65*Z889 - Z52*Z879 + Z71*Z899 - Z297*Z850 + Z313*Z859 + Z320*Z869;
Z1727 = Z65*Z890 - Z52*Z880 + Z71*Z900 - Z297*Z851 + Z313*Z860 + Z320*Z870;
Z1728 = Z65*Z891 - Z52*Z881 + Z71*Z901 - Z297*Z852 + Z313*Z861 + Z320*Z871;
Z1729 = Z65*Z892 - Z52*Z882 + Z71*Z902 - Z297*Z853 + Z313*Z862 + Z320*Z872;
Z1730 = Z65*Z893 - Z52*Z883 + Z71*Z903 - Z297*Z854 + Z313*Z863 + Z320*Z873;
Z1731 = Z65*Z894 - Z52*Z884 + Z71*Z904 - Z297*Z855 + Z313*Z864 + Z320*Z874;
Z1732 = Z65*Z895 - Z52*Z885 + Z71*Z905 + Z313*Z865 + Z320*Z875;
Z1733 = Z65*Z896 - Z52*Z886 + Z71*Z906 - Z297*Z856 + Z313*Z866 + Z320*Z876;
 
LHS_7l_psi = Z1724*ddx+Z1725*ddpsi+Z1726*ddq_imu+Z1727*ddq_w+Z1728*ddq_torso+Z1729*ddq_1l+Z1730*ddq_2l+Z1731*ddq_3l+Z1732*ddq_4l+Z1733;
 
% LHS_8l_psi = 
%
%      (Z80*Z939 - Z65*Z950 + Z87*Z961 - Z313*Z918 + Z329*Z907 + Z338*Z928)*ddx + (Z80*Z940 - Z65*Z951 + Z87*Z962 - Z313*Z919 + Z329*Z908 + Z338*Z929)*ddpsi + (Z80*Z941 - Z65*Z952 + Z87*Z963 - Z313*Z920 + Z329*Z909 + Z338*Z930)*ddq_imu + (Z80*Z942 - Z65*Z953 + Z87*Z964 - Z313*Z921 + Z329*Z910 + Z338*Z931)*ddq_w + (Z80*Z944 - Z65*Z955 + Z87*Z966 - Z313*Z923 + Z329*Z912 + Z338*Z933)*ddq_1l + (Z80*Z945 - Z65*Z956 + Z87*Z967 - Z313*Z924 + Z329*Z913 + Z338*Z934)*ddq_2l + (Z80*Z946 - Z65*Z957 + Z87*Z968 - Z313*Z925 + Z329*Z914 + Z338*Z935)*ddq_3l + (Z80*Z947 - Z65*Z958 + Z87*Z969 - Z313*Z926 + Z329*Z915 + Z338*Z936)*ddq_4l + (Z80*Z948 - Z65*Z959 + Z87*Z970 + Z329*Z916 + Z338*Z937)*ddq_5l + (Z80*(Z949 + Z943*ddq_torso) - Z65*(Z960 + Z954*ddq_torso) + Z87*(Z971 + Z965*ddq_torso) + Z329*(Z917 + Z911*ddq_torso) - Z313*(Z927 + Z922*ddq_torso) + Z338*(Z938 + Z932*ddq_torso))
Z1734 = Z80*Z939 - Z65*Z950 + Z87*Z961 - Z313*Z918 + Z329*Z907 + Z338*Z928;
Z1735 = Z80*Z940 - Z65*Z951 + Z87*Z962 - Z313*Z919 + Z329*Z908 + Z338*Z929;
Z1736 = Z80*Z941 - Z65*Z952 + Z87*Z963 - Z313*Z920 + Z329*Z909 + Z338*Z930;
Z1737 = Z80*Z942 - Z65*Z953 + Z87*Z964 - Z313*Z921 + Z329*Z910 + Z338*Z931;
Z1738 = Z80*Z943 - Z65*Z954 + Z87*Z965 - Z313*Z922 + Z329*Z911 + Z338*Z932;
Z1739 = Z80*Z944 - Z65*Z955 + Z87*Z966 - Z313*Z923 + Z329*Z912 + Z338*Z933;
Z1740 = Z80*Z945 - Z65*Z956 + Z87*Z967 - Z313*Z924 + Z329*Z913 + Z338*Z934;
Z1741 = Z80*Z946 - Z65*Z957 + Z87*Z968 - Z313*Z925 + Z329*Z914 + Z338*Z935;
Z1742 = Z80*Z947 - Z65*Z958 + Z87*Z969 - Z313*Z926 + Z329*Z915 + Z338*Z936;
Z1743 = Z80*Z948 - Z65*Z959 + Z87*Z970 + Z329*Z916 + Z338*Z937;
Z1744 = Z80*Z949 - Z65*Z960 + Z87*Z971 - Z313*Z927 + Z329*Z917 + Z338*Z938;
 
LHS_8l_psi = Z1734*ddx+Z1735*ddpsi+Z1736*ddq_imu+Z1737*ddq_w+Z1738*ddq_torso+Z1739*ddq_1l+Z1740*ddq_2l+Z1741*ddq_3l+Z1742*ddq_4l+Z1743*ddq_5l+Z1744;
 
% LHS_9l_psi = 
%
%      (Z97*Z1019 - Z80*Z1007 + Z105*Z1031 - Z329*Z972 + Z349*Z983 + Z358*Z995)*ddx + (Z97*Z1020 - Z80*Z1008 + Z105*Z1032 - Z329*Z973 + Z349*Z984 + Z358*Z996)*ddpsi + (Z97*Z1021 - Z80*Z1009 + Z105*Z1033 - Z329*Z974 + Z349*Z985 + Z358*Z997)*ddq_imu + (Z97*Z1022 - Z80*Z1010 + Z105*Z1034 - Z329*Z975 + Z349*Z986 + Z358*Z998)*ddq_w + (Z97*Z1024 - Z80*Z1012 + Z105*Z1036 - Z329*Z977 + Z349*Z988 + Z358*Z1000)*ddq_1l + (Z97*Z1025 - Z80*Z1013 + Z105*Z1037 - Z329*Z978 + Z349*Z989 + Z358*Z1001)*ddq_2l + (Z97*Z1026 - Z80*Z1014 + Z105*Z1038 - Z329*Z979 + Z349*Z990 + Z358*Z1002)*ddq_3l + (Z97*Z1027 - Z80*Z1015 + Z105*Z1039 - Z329*Z980 + Z349*Z991 + Z358*Z1003)*ddq_4l + (Z97*Z1028 - Z80*Z1016 + Z105*Z1040 - Z329*Z981 + Z349*Z992 + Z358*Z1004)*ddq_5l + (Z97*Z1029 - Z80*Z1017 + Z105*Z1041 + Z349*Z993 + Z358*Z1005)*ddq_6l + (Z97*(Z1030 + Z1023*ddq_torso) - Z80*(Z1018 + Z1011*ddq_torso) + Z105*(Z1042 + Z1035*ddq_torso) - Z329*(Z982 + Z976*ddq_torso) + Z349*(Z994 + Z987*ddq_torso) + Z358*(Z1006 + Z999*ddq_torso))
Z1745 = Z97*Z1019 - Z80*Z1007 + Z105*Z1031 - Z329*Z972 + Z349*Z983 + Z358*Z995;
Z1746 = Z97*Z1020 - Z80*Z1008 + Z105*Z1032 - Z329*Z973 + Z349*Z984 + Z358*Z996;
Z1747 = Z97*Z1021 - Z80*Z1009 + Z105*Z1033 - Z329*Z974 + Z349*Z985 + Z358*Z997;
Z1748 = Z97*Z1022 - Z80*Z1010 + Z105*Z1034 - Z329*Z975 + Z349*Z986 + Z358*Z998;
Z1749 = Z97*Z1023 - Z80*Z1011 + Z105*Z1035 - Z329*Z976 + Z349*Z987 + Z358*Z999;
Z1750 = Z97*Z1024 - Z80*Z1012 + Z105*Z1036 - Z329*Z977 + Z349*Z988 + Z358*Z1000;
Z1751 = Z97*Z1025 - Z80*Z1013 + Z105*Z1037 - Z329*Z978 + Z349*Z989 + Z358*Z1001;
Z1752 = Z97*Z1026 - Z80*Z1014 + Z105*Z1038 - Z329*Z979 + Z349*Z990 + Z358*Z1002;
Z1753 = Z97*Z1027 - Z80*Z1015 + Z105*Z1039 - Z329*Z980 + Z349*Z991 + Z358*Z1003;
Z1754 = Z97*Z1028 - Z80*Z1016 + Z105*Z1040 - Z329*Z981 + Z349*Z992 + Z358*Z1004;
Z1755 = Z97*Z1029 - Z80*Z1017 + Z105*Z1041 + Z349*Z993 + Z358*Z1005;
Z1756 = Z97*Z1030 - Z80*Z1018 + Z105*Z1042 - Z329*Z982 + Z349*Z994 + Z358*Z1006;
 
LHS_9l_psi = Z1745*ddx+Z1746*ddpsi+Z1747*ddq_imu+Z1748*ddq_w+Z1749*ddq_torso+Z1750*ddq_1l+Z1751*ddq_2l+Z1752*ddq_3l+Z1753*ddq_4l+Z1754*ddq_5l+Z1755*ddq_6l+Z1756;
 
% LHS_10l_psi = 
%
%      (Z116*Z1081 - Z97*Z1107 + Z125*Z1094 + Z369*Z1043 - Z349*Z1069 + Z380*Z1056)*ddx + (Z116*Z1082 - Z97*Z1108 + Z125*Z1095 + Z369*Z1044 - Z349*Z1070 + Z380*Z1057)*ddpsi + (Z116*Z1083 - Z97*Z1109 + Z125*Z1096 + Z369*Z1045 - Z349*Z1071 + Z380*Z1058)*ddq_imu + (Z116*Z1084 - Z97*Z1110 + Z125*Z1097 + Z369*Z1046 - Z349*Z1072 + Z380*Z1059)*ddq_w + (Z116*Z1086 - Z97*Z1112 + Z125*Z1099 + Z369*Z1048 - Z349*Z1074 + Z380*Z1061)*ddq_1l + (Z116*Z1087 - Z97*Z1113 + Z125*Z1100 + Z369*Z1049 - Z349*Z1075 + Z380*Z1062)*ddq_2l + (Z116*Z1088 - Z97*Z1114 + Z125*Z1101 + Z369*Z1050 - Z349*Z1076 + Z380*Z1063)*ddq_3l + (Z116*Z1089 - Z97*Z1115 + Z125*Z1102 + Z369*Z1051 - Z349*Z1077 + Z380*Z1064)*ddq_4l + (Z116*Z1090 - Z97*Z1116 + Z125*Z1103 + Z369*Z1052 - Z349*Z1078 + Z380*Z1065)*ddq_5l + (Z116*Z1091 - Z97*Z1117 + Z125*Z1104 + Z369*Z1053 - Z349*Z1079 + Z380*Z1066)*ddq_6l + (Z116*Z1092 - Z97*Z1118 + Z125*Z1105 + Z369*Z1054 + Z380*Z1067)*ddq_7l + (Z116*(Z1093 + Z1085*ddq_torso) - Z97*(Z1119 + Z1111*ddq_torso) + Z125*(Z1106 + Z1098*ddq_torso) + Z369*(Z1055 + Z1047*ddq_torso) - Z349*(Z1080 + Z1073*ddq_torso) + Z380*(Z1068 + Z1060*ddq_torso))
Z1757 = Z116*Z1081 - Z97*Z1107 + Z125*Z1094 + Z369*Z1043 - Z349*Z1069 + Z380*Z1056;
Z1758 = Z116*Z1082 - Z97*Z1108 + Z125*Z1095 + Z369*Z1044 - Z349*Z1070 + Z380*Z1057;
Z1759 = Z116*Z1083 - Z97*Z1109 + Z125*Z1096 + Z369*Z1045 - Z349*Z1071 + Z380*Z1058;
Z1760 = Z116*Z1084 - Z97*Z1110 + Z125*Z1097 + Z369*Z1046 - Z349*Z1072 + Z380*Z1059;
Z1761 = Z116*Z1085 - Z97*Z1111 + Z125*Z1098 + Z369*Z1047 - Z349*Z1073 + Z380*Z1060;
Z1762 = Z116*Z1086 - Z97*Z1112 + Z125*Z1099 + Z369*Z1048 - Z349*Z1074 + Z380*Z1061;
Z1763 = Z116*Z1087 - Z97*Z1113 + Z125*Z1100 + Z369*Z1049 - Z349*Z1075 + Z380*Z1062;
Z1764 = Z116*Z1088 - Z97*Z1114 + Z125*Z1101 + Z369*Z1050 - Z349*Z1076 + Z380*Z1063;
Z1765 = Z116*Z1089 - Z97*Z1115 + Z125*Z1102 + Z369*Z1051 - Z349*Z1077 + Z380*Z1064;
Z1766 = Z116*Z1090 - Z97*Z1116 + Z125*Z1103 + Z369*Z1052 - Z349*Z1078 + Z380*Z1065;
Z1767 = Z116*Z1091 - Z97*Z1117 + Z125*Z1104 + Z369*Z1053 - Z349*Z1079 + Z380*Z1066;
Z1768 = Z116*Z1092 - Z97*Z1118 + Z125*Z1105 + Z369*Z1054 + Z380*Z1067;
Z1769 = Z116*Z1093 - Z97*Z1119 + Z125*Z1106 + Z369*Z1055 - Z349*Z1080 + Z380*Z1068;
 
LHS_10l_psi = Z1757*ddx+Z1758*ddpsi+Z1759*ddq_imu+Z1760*ddq_w+Z1761*ddq_torso+Z1762*ddq_1l+Z1763*ddq_2l+Z1764*ddq_3l+Z1765*ddq_4l+Z1766*ddq_5l+Z1767*ddq_6l+Z1768*ddq_7l+Z1769;
 
% LHS_4r_psi = 
%
%      (Z137*Z1140 - Z26*Z1147 + Z140*Z1154 + Z394*Z1120 + Z398*Z1127 + Z402*Z1133)*ddx + (Z137*Z1141 - Z26*Z1148 + Z140*Z1155 + Z394*Z1121 + Z398*Z1128 + Z402*Z1134)*ddpsi + (Z137*Z1142 - Z26*Z1149 + Z140*Z1156 + Z394*Z1122 + Z398*Z1129 + Z402*Z1135)*ddq_imu + (Z137*Z1143 - Z26*Z1150 + Z140*Z1157 + Z394*Z1123 + Z398*Z1130 + Z402*Z1136)*ddq_w + (Z137*Z1145 - Z26*Z1152 + Z140*Z1159 + Z394*Z1125 + Z402*Z1138)*ddq_1r + (Z137*(Z1146 + Z1144*ddq_torso) - Z26*(Z1153 + Z1151*ddq_torso) + Z140*(Z1160 + Z1158*ddq_torso) + Z394*(Z1126 + Z1124*ddq_torso) + Z398*(Z1132 + Z1131*ddq_torso) + Z402*(Z1139 + Z1137*ddq_torso))
Z1770 = Z137*Z1140 - Z26*Z1147 + Z140*Z1154 + Z394*Z1120 + Z398*Z1127 + Z402*Z1133;
Z1771 = Z137*Z1141 - Z26*Z1148 + Z140*Z1155 + Z394*Z1121 + Z398*Z1128 + Z402*Z1134;
Z1772 = Z137*Z1142 - Z26*Z1149 + Z140*Z1156 + Z394*Z1122 + Z398*Z1129 + Z402*Z1135;
Z1773 = Z137*Z1143 - Z26*Z1150 + Z140*Z1157 + Z394*Z1123 + Z398*Z1130 + Z402*Z1136;
Z1774 = Z137*Z1144 - Z26*Z1151 + Z140*Z1158 + Z394*Z1124 + Z398*Z1131 + Z402*Z1137;
Z1775 = Z137*Z1145 - Z26*Z1152 + Z140*Z1159 + Z394*Z1125 + Z402*Z1138;
Z1776 = Z137*Z1146 - Z26*Z1153 + Z140*Z1160 + Z394*Z1126 + Z398*Z1132 + Z402*Z1139;
 
LHS_4r_psi = Z1770*ddx+Z1771*ddpsi+Z1772*ddq_imu+Z1773*ddq_w+Z1774*ddq_torso+Z1775*ddq_1r+Z1776;
 
% LHS_5r_psi = 
%
%      (Z146*Z1185 - Z137*Z1179 + Z150*Z1191 + Z190*Z1167 - Z394*Z1161 + Z414*Z1173)*ddx + (Z146*Z1186 - Z137*Z1180 + Z150*Z1192 + Z190*Z1168 - Z394*Z1162 + Z414*Z1174)*ddpsi + (Z146*Z1187 - Z137*Z1181 + Z150*Z1193 + Z190*Z1169 - Z394*Z1163 + Z414*Z1175)*ddq_imu + (Z146*Z1188 - Z137*Z1182 + Z150*Z1194 + Z190*Z1170 - Z394*Z1164 + Z414*Z1176)*ddq_w + (Z146*(Z1190 + Z1189*ddq_torso) - Z137*(Z1184 + Z1183*ddq_torso) + Z190*(Z1172 + Z1171*ddq_torso) + Z150*(Z1196 + Z1195*ddq_torso) - Z394*(Z1166 + Z1165*ddq_torso) + Z414*(Z1178 + Z1177*ddq_torso))
Z1777 = Z146*Z1185 - Z137*Z1179 + Z150*Z1191 + Z190*Z1167 - Z394*Z1161 + Z414*Z1173;
Z1778 = Z146*Z1186 - Z137*Z1180 + Z150*Z1192 + Z190*Z1168 - Z394*Z1162 + Z414*Z1174;
Z1779 = Z146*Z1187 - Z137*Z1181 + Z150*Z1193 + Z190*Z1169 - Z394*Z1163 + Z414*Z1175;
Z1780 = Z146*Z1188 - Z137*Z1182 + Z150*Z1194 + Z190*Z1170 - Z394*Z1164 + Z414*Z1176;
Z1781 = Z146*Z1189 - Z137*Z1183 + Z150*Z1195 + Z190*Z1171 - Z394*Z1165 + Z414*Z1177;
Z1782 = Z146*Z1190 - Z137*Z1184 + Z150*Z1196 + Z190*Z1172 - Z394*Z1166 + Z414*Z1178;
 
LHS_5r_psi = Z1777*ddx+Z1778*ddpsi+Z1779*ddq_imu+Z1780*ddq_w+Z1781*ddq_torso+Z1782;
 
% LHS_6r_psi = 
%
%      (Z157*Z1223 - Z146*Z1232 - Z190*Z1206 + Z162*Z1241 + Z421*Z1197 + Z428*Z1214)*ddx + (Z157*Z1224 - Z146*Z1233 - Z190*Z1207 + Z162*Z1242 + Z421*Z1198 + Z428*Z1215)*ddpsi + (Z157*Z1225 - Z146*Z1234 - Z190*Z1208 + Z162*Z1243 + Z421*Z1199 + Z428*Z1216)*ddq_imu + (Z157*Z1226 - Z146*Z1235 - Z190*Z1209 + Z162*Z1244 + Z421*Z1200 + Z428*Z1217)*ddq_w + (Z157*Z1228 - Z146*Z1237 - Z190*Z1211 + Z162*Z1246 + Z421*Z1202 + Z428*Z1219)*ddq_1r + (Z157*Z1229 - Z146*Z1238 - Z190*Z1212 + Z162*Z1247 + Z421*Z1203 + Z428*Z1220)*ddq_2r + (Z157*Z1230 - Z146*Z1239 + Z162*Z1248 + Z421*Z1204 + Z428*Z1221)*ddq_3r + (Z157*(Z1231 + Z1227*ddq_torso) - Z190*(Z1213 + Z1210*ddq_torso) - Z146*(Z1240 + Z1236*ddq_torso) + Z162*(Z1249 + Z1245*ddq_torso) + Z421*(Z1205 + Z1201*ddq_torso) + Z428*(Z1222 + Z1218*ddq_torso))
Z1783 = Z157*Z1223 - Z146*Z1232 - Z190*Z1206 + Z162*Z1241 + Z421*Z1197 + Z428*Z1214;
Z1784 = Z157*Z1224 - Z146*Z1233 - Z190*Z1207 + Z162*Z1242 + Z421*Z1198 + Z428*Z1215;
Z1785 = Z157*Z1225 - Z146*Z1234 - Z190*Z1208 + Z162*Z1243 + Z421*Z1199 + Z428*Z1216;
Z1786 = Z157*Z1226 - Z146*Z1235 - Z190*Z1209 + Z162*Z1244 + Z421*Z1200 + Z428*Z1217;
Z1787 = Z157*Z1227 - Z146*Z1236 - Z190*Z1210 + Z162*Z1245 + Z421*Z1201 + Z428*Z1218;
Z1788 = Z157*Z1228 - Z146*Z1237 - Z190*Z1211 + Z162*Z1246 + Z421*Z1202 + Z428*Z1219;
Z1789 = Z157*Z1229 - Z146*Z1238 - Z190*Z1212 + Z162*Z1247 + Z421*Z1203 + Z428*Z1220;
Z1790 = Z157*Z1230 - Z146*Z1239 + Z162*Z1248 + Z421*Z1204 + Z428*Z1221;
Z1791 = Z157*Z1231 - Z146*Z1240 - Z190*Z1213 + Z162*Z1249 + Z421*Z1205 + Z428*Z1222;
 
LHS_6r_psi = Z1783*ddx+Z1784*ddpsi+Z1785*ddq_imu+Z1786*ddq_w+Z1787*ddq_torso+Z1788*ddq_1r+Z1789*ddq_2r+Z1790*ddq_3r+Z1791;
 
% LHS_7r_psi = 
%
%      (Z170*Z1289 - Z157*Z1279 + Z176*Z1299 - Z421*Z1250 + Z437*Z1259 + Z444*Z1269)*ddx + (Z170*Z1290 - Z157*Z1280 + Z176*Z1300 - Z421*Z1251 + Z437*Z1260 + Z444*Z1270)*ddpsi + (Z170*Z1291 - Z157*Z1281 + Z176*Z1301 - Z421*Z1252 + Z437*Z1261 + Z444*Z1271)*ddq_imu + (Z170*Z1292 - Z157*Z1282 + Z176*Z1302 - Z421*Z1253 + Z437*Z1262 + Z444*Z1272)*ddq_w + (Z170*Z1294 - Z157*Z1284 + Z176*Z1304 - Z421*Z1255 + Z437*Z1264 + Z444*Z1274)*ddq_1r + (Z170*Z1295 - Z157*Z1285 + Z176*Z1305 - Z421*Z1256 + Z437*Z1265 + Z444*Z1275)*ddq_2r + (Z170*Z1296 - Z157*Z1286 + Z176*Z1306 - Z421*Z1257 + Z437*Z1266 + Z444*Z1276)*ddq_3r + (Z170*Z1297 - Z157*Z1287 + Z176*Z1307 + Z437*Z1267 + Z444*Z1277)*ddq_4r + (Z170*(Z1298 + Z1293*ddq_torso) - Z157*(Z1288 + Z1283*ddq_torso) + Z176*(Z1308 + Z1303*ddq_torso) - Z421*(Z1258 + Z1254*ddq_torso) + Z437*(Z1268 + Z1263*ddq_torso) + Z444*(Z1278 + Z1273*ddq_torso))
Z1792 = Z170*Z1289 - Z157*Z1279 + Z176*Z1299 - Z421*Z1250 + Z437*Z1259 + Z444*Z1269;
Z1793 = Z170*Z1290 - Z157*Z1280 + Z176*Z1300 - Z421*Z1251 + Z437*Z1260 + Z444*Z1270;
Z1794 = Z170*Z1291 - Z157*Z1281 + Z176*Z1301 - Z421*Z1252 + Z437*Z1261 + Z444*Z1271;
Z1795 = Z170*Z1292 - Z157*Z1282 + Z176*Z1302 - Z421*Z1253 + Z437*Z1262 + Z444*Z1272;
Z1796 = Z170*Z1293 - Z157*Z1283 + Z176*Z1303 - Z421*Z1254 + Z437*Z1263 + Z444*Z1273;
Z1797 = Z170*Z1294 - Z157*Z1284 + Z176*Z1304 - Z421*Z1255 + Z437*Z1264 + Z444*Z1274;
Z1798 = Z170*Z1295 - Z157*Z1285 + Z176*Z1305 - Z421*Z1256 + Z437*Z1265 + Z444*Z1275;
Z1799 = Z170*Z1296 - Z157*Z1286 + Z176*Z1306 - Z421*Z1257 + Z437*Z1266 + Z444*Z1276;
Z1800 = Z170*Z1297 - Z157*Z1287 + Z176*Z1307 + Z437*Z1267 + Z444*Z1277;
Z1801 = Z170*Z1298 - Z157*Z1288 + Z176*Z1308 - Z421*Z1258 + Z437*Z1268 + Z444*Z1278;
 
LHS_7r_psi = Z1792*ddx+Z1793*ddpsi+Z1794*ddq_imu+Z1795*ddq_w+Z1796*ddq_torso+Z1797*ddq_1r+Z1798*ddq_2r+Z1799*ddq_3r+Z1800*ddq_4r+Z1801;
 
% LHS_8r_psi = 
%
%      (Z185*Z1341 - Z170*Z1352 + Z192*Z1363 - Z437*Z1320 + Z453*Z1309 + Z462*Z1330)*ddx + (Z185*Z1342 - Z170*Z1353 + Z192*Z1364 - Z437*Z1321 + Z453*Z1310 + Z462*Z1331)*ddpsi + (Z185*Z1343 - Z170*Z1354 + Z192*Z1365 - Z437*Z1322 + Z453*Z1311 + Z462*Z1332)*ddq_imu + (Z185*Z1344 - Z170*Z1355 + Z192*Z1366 - Z437*Z1323 + Z453*Z1312 + Z462*Z1333)*ddq_w + (Z185*Z1346 - Z170*Z1357 + Z192*Z1368 - Z437*Z1325 + Z453*Z1314 + Z462*Z1335)*ddq_1r + (Z185*Z1347 - Z170*Z1358 + Z192*Z1369 - Z437*Z1326 + Z453*Z1315 + Z462*Z1336)*ddq_2r + (Z185*Z1348 - Z170*Z1359 + Z192*Z1370 - Z437*Z1327 + Z453*Z1316 + Z462*Z1337)*ddq_3r + (Z185*Z1349 - Z170*Z1360 + Z192*Z1371 - Z437*Z1328 + Z453*Z1317 + Z462*Z1338)*ddq_4r + (Z185*Z1350 - Z170*Z1361 + Z192*Z1372 + Z453*Z1318 + Z462*Z1339)*ddq_5r + (Z185*(Z1351 + Z1345*ddq_torso) - Z170*(Z1362 + Z1356*ddq_torso) + Z192*(Z1373 + Z1367*ddq_torso) + Z453*(Z1319 + Z1313*ddq_torso) - Z437*(Z1329 + Z1324*ddq_torso) + Z462*(Z1340 + Z1334*ddq_torso))
Z1802 = Z185*Z1341 - Z170*Z1352 + Z192*Z1363 - Z437*Z1320 + Z453*Z1309 + Z462*Z1330;
Z1803 = Z185*Z1342 - Z170*Z1353 + Z192*Z1364 - Z437*Z1321 + Z453*Z1310 + Z462*Z1331;
Z1804 = Z185*Z1343 - Z170*Z1354 + Z192*Z1365 - Z437*Z1322 + Z453*Z1311 + Z462*Z1332;
Z1805 = Z185*Z1344 - Z170*Z1355 + Z192*Z1366 - Z437*Z1323 + Z453*Z1312 + Z462*Z1333;
Z1806 = Z185*Z1345 - Z170*Z1356 + Z192*Z1367 - Z437*Z1324 + Z453*Z1313 + Z462*Z1334;
Z1807 = Z185*Z1346 - Z170*Z1357 + Z192*Z1368 - Z437*Z1325 + Z453*Z1314 + Z462*Z1335;
Z1808 = Z185*Z1347 - Z170*Z1358 + Z192*Z1369 - Z437*Z1326 + Z453*Z1315 + Z462*Z1336;
Z1809 = Z185*Z1348 - Z170*Z1359 + Z192*Z1370 - Z437*Z1327 + Z453*Z1316 + Z462*Z1337;
Z1810 = Z185*Z1349 - Z170*Z1360 + Z192*Z1371 - Z437*Z1328 + Z453*Z1317 + Z462*Z1338;
Z1811 = Z185*Z1350 - Z170*Z1361 + Z192*Z1372 + Z453*Z1318 + Z462*Z1339;
Z1812 = Z185*Z1351 - Z170*Z1362 + Z192*Z1373 - Z437*Z1329 + Z453*Z1319 + Z462*Z1340;
 
LHS_8r_psi = Z1802*ddx+Z1803*ddpsi+Z1804*ddq_imu+Z1805*ddq_w+Z1806*ddq_torso+Z1807*ddq_1r+Z1808*ddq_2r+Z1809*ddq_3r+Z1810*ddq_4r+Z1811*ddq_5r+Z1812;
 
% LHS_9r_psi = 
%
%      (Z202*Z1421 - Z185*Z1409 + Z210*Z1433 - Z453*Z1374 + Z473*Z1385 + Z482*Z1397)*ddx + (Z202*Z1422 - Z185*Z1410 + Z210*Z1434 - Z453*Z1375 + Z473*Z1386 + Z482*Z1398)*ddpsi + (Z202*Z1423 - Z185*Z1411 + Z210*Z1435 - Z453*Z1376 + Z473*Z1387 + Z482*Z1399)*ddq_imu + (Z202*Z1424 - Z185*Z1412 + Z210*Z1436 - Z453*Z1377 + Z473*Z1388 + Z482*Z1400)*ddq_w + (Z202*Z1426 - Z185*Z1414 + Z210*Z1438 - Z453*Z1379 + Z473*Z1390 + Z482*Z1402)*ddq_1r + (Z202*Z1427 - Z185*Z1415 + Z210*Z1439 - Z453*Z1380 + Z473*Z1391 + Z482*Z1403)*ddq_2r + (Z202*Z1428 - Z185*Z1416 + Z210*Z1440 - Z453*Z1381 + Z473*Z1392 + Z482*Z1404)*ddq_3r + (Z202*Z1429 - Z185*Z1417 + Z210*Z1441 - Z453*Z1382 + Z473*Z1393 + Z482*Z1405)*ddq_4r + (Z202*Z1430 - Z185*Z1418 + Z210*Z1442 - Z453*Z1383 + Z473*Z1394 + Z482*Z1406)*ddq_5r + (Z202*Z1431 - Z185*Z1419 + Z210*Z1443 + Z473*Z1395 + Z482*Z1407)*ddq_6r + (Z202*(Z1432 + Z1425*ddq_torso) - Z185*(Z1420 + Z1413*ddq_torso) + Z210*(Z1444 + Z1437*ddq_torso) - Z453*(Z1384 + Z1378*ddq_torso) + Z473*(Z1396 + Z1389*ddq_torso) + Z482*(Z1408 + Z1401*ddq_torso))
Z1813 = Z202*Z1421 - Z185*Z1409 + Z210*Z1433 - Z453*Z1374 + Z473*Z1385 + Z482*Z1397;
Z1814 = Z202*Z1422 - Z185*Z1410 + Z210*Z1434 - Z453*Z1375 + Z473*Z1386 + Z482*Z1398;
Z1815 = Z202*Z1423 - Z185*Z1411 + Z210*Z1435 - Z453*Z1376 + Z473*Z1387 + Z482*Z1399;
Z1816 = Z202*Z1424 - Z185*Z1412 + Z210*Z1436 - Z453*Z1377 + Z473*Z1388 + Z482*Z1400;
Z1817 = Z202*Z1425 - Z185*Z1413 + Z210*Z1437 - Z453*Z1378 + Z473*Z1389 + Z482*Z1401;
Z1818 = Z202*Z1426 - Z185*Z1414 + Z210*Z1438 - Z453*Z1379 + Z473*Z1390 + Z482*Z1402;
Z1819 = Z202*Z1427 - Z185*Z1415 + Z210*Z1439 - Z453*Z1380 + Z473*Z1391 + Z482*Z1403;
Z1820 = Z202*Z1428 - Z185*Z1416 + Z210*Z1440 - Z453*Z1381 + Z473*Z1392 + Z482*Z1404;
Z1821 = Z202*Z1429 - Z185*Z1417 + Z210*Z1441 - Z453*Z1382 + Z473*Z1393 + Z482*Z1405;
Z1822 = Z202*Z1430 - Z185*Z1418 + Z210*Z1442 - Z453*Z1383 + Z473*Z1394 + Z482*Z1406;
Z1823 = Z202*Z1431 - Z185*Z1419 + Z210*Z1443 + Z473*Z1395 + Z482*Z1407;
Z1824 = Z202*Z1432 - Z185*Z1420 + Z210*Z1444 - Z453*Z1384 + Z473*Z1396 + Z482*Z1408;
 
LHS_9r_psi = Z1813*ddx+Z1814*ddpsi+Z1815*ddq_imu+Z1816*ddq_w+Z1817*ddq_torso+Z1818*ddq_1r+Z1819*ddq_2r+Z1820*ddq_3r+Z1821*ddq_4r+Z1822*ddq_5r+Z1823*ddq_6r+Z1824;
 
% LHS_10r_psi = 
%
%      (Z221*Z1483 - Z202*Z1509 + Z230*Z1496 + Z493*Z1445 - Z473*Z1471 + Z504*Z1458)*ddx + (Z221*Z1484 - Z202*Z1510 + Z230*Z1497 + Z493*Z1446 - Z473*Z1472 + Z504*Z1459)*ddpsi + (Z221*Z1485 - Z202*Z1511 + Z230*Z1498 + Z493*Z1447 - Z473*Z1473 + Z504*Z1460)*ddq_imu + (Z221*Z1486 - Z202*Z1512 + Z230*Z1499 + Z493*Z1448 - Z473*Z1474 + Z504*Z1461)*ddq_w + (Z221*Z1488 - Z202*Z1514 + Z230*Z1501 + Z493*Z1450 - Z473*Z1476 + Z504*Z1463)*ddq_1r + (Z221*Z1489 - Z202*Z1515 + Z230*Z1502 + Z493*Z1451 - Z473*Z1477 + Z504*Z1464)*ddq_2r + (Z221*Z1490 - Z202*Z1516 + Z230*Z1503 + Z493*Z1452 - Z473*Z1478 + Z504*Z1465)*ddq_3r + (Z221*Z1491 - Z202*Z1517 + Z230*Z1504 + Z493*Z1453 - Z473*Z1479 + Z504*Z1466)*ddq_4r + (Z221*Z1492 - Z202*Z1518 + Z230*Z1505 + Z493*Z1454 - Z473*Z1480 + Z504*Z1467)*ddq_5r + (Z221*Z1493 - Z202*Z1519 + Z230*Z1506 + Z493*Z1455 - Z473*Z1481 + Z504*Z1468)*ddq_6r + (Z221*Z1494 - Z202*Z1520 + Z230*Z1507 + Z493*Z1456 + Z504*Z1469)*ddq_7r + (Z221*(Z1495 + Z1487*ddq_torso) - Z202*(Z1521 + Z1513*ddq_torso) + Z230*(Z1508 + Z1500*ddq_torso) + Z493*(Z1457 + Z1449*ddq_torso) - Z473*(Z1482 + Z1475*ddq_torso) + Z504*(Z1470 + Z1462*ddq_torso))
Z1825 = Z221*Z1483 - Z202*Z1509 + Z230*Z1496 + Z493*Z1445 - Z473*Z1471 + Z504*Z1458;
Z1826 = Z221*Z1484 - Z202*Z1510 + Z230*Z1497 + Z493*Z1446 - Z473*Z1472 + Z504*Z1459;
Z1827 = Z221*Z1485 - Z202*Z1511 + Z230*Z1498 + Z493*Z1447 - Z473*Z1473 + Z504*Z1460;
Z1828 = Z221*Z1486 - Z202*Z1512 + Z230*Z1499 + Z493*Z1448 - Z473*Z1474 + Z504*Z1461;
Z1829 = Z221*Z1487 - Z202*Z1513 + Z230*Z1500 + Z493*Z1449 - Z473*Z1475 + Z504*Z1462;
Z1830 = Z221*Z1488 - Z202*Z1514 + Z230*Z1501 + Z493*Z1450 - Z473*Z1476 + Z504*Z1463;
Z1831 = Z221*Z1489 - Z202*Z1515 + Z230*Z1502 + Z493*Z1451 - Z473*Z1477 + Z504*Z1464;
Z1832 = Z221*Z1490 - Z202*Z1516 + Z230*Z1503 + Z493*Z1452 - Z473*Z1478 + Z504*Z1465;
Z1833 = Z221*Z1491 - Z202*Z1517 + Z230*Z1504 + Z493*Z1453 - Z473*Z1479 + Z504*Z1466;
Z1834 = Z221*Z1492 - Z202*Z1518 + Z230*Z1505 + Z493*Z1454 - Z473*Z1480 + Z504*Z1467;
Z1835 = Z221*Z1493 - Z202*Z1519 + Z230*Z1506 + Z493*Z1455 - Z473*Z1481 + Z504*Z1468;
Z1836 = Z221*Z1494 - Z202*Z1520 + Z230*Z1507 + Z493*Z1456 + Z504*Z1469;
Z1837 = Z221*Z1495 - Z202*Z1521 + Z230*Z1508 + Z493*Z1457 - Z473*Z1482 + Z504*Z1470;
 
LHS_10r_psi = Z1825*ddx+Z1826*ddpsi+Z1827*ddq_imu+Z1828*ddq_w+Z1829*ddq_torso+Z1830*ddq_1r+Z1831*ddq_2r+Z1832*ddq_3r+Z1833*ddq_4r+Z1834*ddq_5r+Z1835*ddq_6r+Z1836*ddq_7r+Z1837;
 
% LHS_L_imu = 
%
%      0
% LHS_R_imu = 
%
%      0
% LHS_1_imu = 
%
%      (-Z633)*ddx + (-Z634)*ddpsi + (-Z635)*ddq_imu - Z636
LHS_1_imu = -Z633*ddx-Z634*ddpsi-Z635*ddq_imu+-Z636;
 
% LHS_2_imu = 
%
%      (Z251*Z647 - Z657 + Z253*Z652)*ddx + (Z251*Z648 - Z658 + Z253*Z653)*ddpsi + (Z251*Z649 - Z659 + Z253*Z654)*ddq_imu + (Z251*Z650 - Z660 + Z253*Z655)*ddq_w + (Z251*Z651 - Z661 + Z253*Z656)
Z1838 = Z251*Z647 - Z657 + Z253*Z652;
Z1839 = Z251*Z648 - Z658 + Z253*Z653;
Z1840 = Z251*Z649 - Z659 + Z253*Z654;
Z1841 = Z251*Z650 - Z660 + Z253*Z655;
Z1842 = Z251*Z651 - Z661 + Z253*Z656;
 
LHS_2_imu = Z1838*ddx+Z1839*ddpsi+Z1840*ddq_imu+Z1841*ddq_w+Z1842;
 
% LHS_3_imu = 
%
%      (Z25*Z689 + Z27*Z701 + Z259*Z672 + Z264*Z683)*ddx + (Z25*Z690 + Z27*Z702 + Z259*Z673 + Z264*Z684)*ddpsi + (Z25*Z691 + Z27*Z703 + Z259*Z674 + Z264*Z685)*ddq_imu + (Z25*Z692 + Z27*Z704 + Z259*Z675 + Z264*Z686)*ddq_w + (Z25*(Z694 + Z693*ddq_torso) + Z27*(Z706 + Z705*ddq_torso) + Z259*(Z677 + Z676*ddq_torso) + Z264*(Z688 + Z687*ddq_torso))
Z1843 = Z25*Z689 + Z27*Z701 + Z259*Z672 + Z264*Z683;
Z1844 = Z25*Z690 + Z27*Z702 + Z259*Z673 + Z264*Z684;
Z1845 = Z25*Z691 + Z27*Z703 + Z259*Z674 + Z264*Z685;
Z1846 = Z25*Z692 + Z27*Z704 + Z259*Z675 + Z264*Z686;
Z1847 = Z25*Z693 + Z27*Z705 + Z259*Z676 + Z264*Z687;
Z1848 = Z25*Z694 + Z27*Z706 + Z259*Z677 + Z264*Z688;
 
LHS_3_imu = Z1843*ddx+Z1844*ddpsi+Z1845*ddq_imu+Z1846*ddq_w+Z1847*ddq_torso+Z1848;
 
% LHS_4l_imu = 
%
%      (Z25*Z734 + Z33*Z727 + Z36*Z741 + Z271*Z707 + Z275*Z714 + Z279*Z720)*ddx + (Z25*Z735 + Z33*Z728 + Z36*Z742 + Z271*Z708 + Z275*Z715 + Z279*Z721)*ddpsi + (Z25*Z736 + Z33*Z729 + Z36*Z743 + Z271*Z709 + Z275*Z716 + Z279*Z722)*ddq_imu + (Z25*Z737 + Z33*Z730 + Z36*Z744 + Z271*Z710 + Z275*Z717 + Z279*Z723)*ddq_w + (Z25*Z739 + Z33*Z732 + Z36*Z746 + Z271*Z712 + Z279*Z725)*ddq_1l + (Z33*(Z733 + Z731*ddq_torso) + Z25*(Z740 + Z738*ddq_torso) + Z36*(Z747 + Z745*ddq_torso) + Z271*(Z713 + Z711*ddq_torso) + Z275*(Z719 + Z718*ddq_torso) + Z279*(Z726 + Z724*ddq_torso))
Z1849 = Z25*Z734 + Z33*Z727 + Z36*Z741 + Z271*Z707 + Z275*Z714 + Z279*Z720;
Z1850 = Z25*Z735 + Z33*Z728 + Z36*Z742 + Z271*Z708 + Z275*Z715 + Z279*Z721;
Z1851 = Z25*Z736 + Z33*Z729 + Z36*Z743 + Z271*Z709 + Z275*Z716 + Z279*Z722;
Z1852 = Z25*Z737 + Z33*Z730 + Z36*Z744 + Z271*Z710 + Z275*Z717 + Z279*Z723;
Z1853 = Z25*Z738 + Z33*Z731 + Z36*Z745 + Z271*Z711 + Z275*Z718 + Z279*Z724;
Z1854 = Z25*Z739 + Z33*Z732 + Z36*Z746 + Z271*Z712 + Z279*Z725;
Z1855 = Z25*Z740 + Z33*Z733 + Z36*Z747 + Z271*Z713 + Z275*Z719 + Z279*Z726;
 
LHS_4l_imu = Z1849*ddx+Z1850*ddpsi+Z1851*ddq_imu+Z1852*ddq_w+Z1853*ddq_torso+Z1854*ddq_1l+Z1855;
 
% LHS_5l_imu = 
%
%      (Z42*Z779 - Z33*Z771 + Z46*Z787 - Z271*Z748 + Z286*Z755 + Z291*Z763)*ddx + (Z42*Z780 - Z33*Z772 + Z46*Z788 - Z271*Z749 + Z286*Z756 + Z291*Z764)*ddpsi + (Z42*Z781 - Z33*Z773 + Z46*Z789 - Z271*Z750 + Z286*Z757 + Z291*Z765)*ddq_imu + (Z42*Z782 - Z33*Z774 + Z46*Z790 - Z271*Z751 + Z286*Z758 + Z291*Z766)*ddq_w + (Z42*Z784 - Z33*Z776 + Z46*Z792 - Z271*Z753 + Z286*Z760 + Z291*Z768)*ddq_1l + (Z42*Z785 - Z33*Z777 + Z46*Z793 + Z286*Z761 + Z291*Z769)*ddq_2l + (Z42*(Z786 + Z783*ddq_torso) - Z33*(Z778 + Z775*ddq_torso) + Z46*(Z794 + Z791*ddq_torso) - Z271*(Z754 + Z752*ddq_torso) + Z286*(Z762 + Z759*ddq_torso) + Z291*(Z770 + Z767*ddq_torso))
Z1856 = Z42*Z779 - Z33*Z771 + Z46*Z787 - Z271*Z748 + Z286*Z755 + Z291*Z763;
Z1857 = Z42*Z780 - Z33*Z772 + Z46*Z788 - Z271*Z749 + Z286*Z756 + Z291*Z764;
Z1858 = Z42*Z781 - Z33*Z773 + Z46*Z789 - Z271*Z750 + Z286*Z757 + Z291*Z765;
Z1859 = Z42*Z782 - Z33*Z774 + Z46*Z790 - Z271*Z751 + Z286*Z758 + Z291*Z766;
Z1860 = Z42*Z783 - Z33*Z775 + Z46*Z791 - Z271*Z752 + Z286*Z759 + Z291*Z767;
Z1861 = Z42*Z784 - Z33*Z776 + Z46*Z792 - Z271*Z753 + Z286*Z760 + Z291*Z768;
Z1862 = Z42*Z785 - Z33*Z777 + Z46*Z793 + Z286*Z761 + Z291*Z769;
Z1863 = Z42*Z786 - Z33*Z778 + Z46*Z794 - Z271*Z754 + Z286*Z762 + Z291*Z770;
 
LHS_5l_imu = Z1856*ddx+Z1857*ddpsi+Z1858*ddq_imu+Z1859*ddq_w+Z1860*ddq_torso+Z1861*ddq_1l+Z1862*ddq_2l+Z1863;
 
% LHS_6l_imu = 
%
%      (Z53*Z821 - Z42*Z830 + Z58*Z839 - Z286*Z804 + Z298*Z795 + Z305*Z812)*ddx + (Z53*Z822 - Z42*Z831 + Z58*Z840 - Z286*Z805 + Z298*Z796 + Z305*Z813)*ddpsi + (Z53*Z823 - Z42*Z832 + Z58*Z841 - Z286*Z806 + Z298*Z797 + Z305*Z814)*ddq_imu + (Z53*Z824 - Z42*Z833 + Z58*Z842 - Z286*Z807 + Z298*Z798 + Z305*Z815)*ddq_w + (Z53*Z826 - Z42*Z835 + Z58*Z844 - Z286*Z809 + Z298*Z800 + Z305*Z817)*ddq_1l + (Z53*Z827 - Z42*Z836 + Z58*Z845 - Z286*Z810 + Z298*Z801 + Z305*Z818)*ddq_2l + (Z53*Z828 - Z42*Z837 + Z58*Z846 + Z298*Z802 + Z305*Z819)*ddq_3l + (Z53*(Z829 + Z825*ddq_torso) - Z42*(Z838 + Z834*ddq_torso) + Z58*(Z847 + Z843*ddq_torso) + Z298*(Z803 + Z799*ddq_torso) - Z286*(Z811 + Z808*ddq_torso) + Z305*(Z820 + Z816*ddq_torso))
Z1864 = Z53*Z821 - Z42*Z830 + Z58*Z839 - Z286*Z804 + Z298*Z795 + Z305*Z812;
Z1865 = Z53*Z822 - Z42*Z831 + Z58*Z840 - Z286*Z805 + Z298*Z796 + Z305*Z813;
Z1866 = Z53*Z823 - Z42*Z832 + Z58*Z841 - Z286*Z806 + Z298*Z797 + Z305*Z814;
Z1867 = Z53*Z824 - Z42*Z833 + Z58*Z842 - Z286*Z807 + Z298*Z798 + Z305*Z815;
Z1868 = Z53*Z825 - Z42*Z834 + Z58*Z843 - Z286*Z808 + Z298*Z799 + Z305*Z816;
Z1869 = Z53*Z826 - Z42*Z835 + Z58*Z844 - Z286*Z809 + Z298*Z800 + Z305*Z817;
Z1870 = Z53*Z827 - Z42*Z836 + Z58*Z845 - Z286*Z810 + Z298*Z801 + Z305*Z818;
Z1871 = Z53*Z828 - Z42*Z837 + Z58*Z846 + Z298*Z802 + Z305*Z819;
Z1872 = Z53*Z829 - Z42*Z838 + Z58*Z847 - Z286*Z811 + Z298*Z803 + Z305*Z820;
 
LHS_6l_imu = Z1864*ddx+Z1865*ddpsi+Z1866*ddq_imu+Z1867*ddq_w+Z1868*ddq_torso+Z1869*ddq_1l+Z1870*ddq_2l+Z1871*ddq_3l+Z1872;
 
% LHS_7l_imu = 
%
%      (Z66*Z887 - Z53*Z877 + Z72*Z897 - Z298*Z848 + Z314*Z857 + Z321*Z867)*ddx + (Z66*Z888 - Z53*Z878 + Z72*Z898 - Z298*Z849 + Z314*Z858 + Z321*Z868)*ddpsi + (Z66*Z889 - Z53*Z879 + Z72*Z899 - Z298*Z850 + Z314*Z859 + Z321*Z869)*ddq_imu + (Z66*Z890 - Z53*Z880 + Z72*Z900 - Z298*Z851 + Z314*Z860 + Z321*Z870)*ddq_w + (Z66*Z892 - Z53*Z882 + Z72*Z902 - Z298*Z853 + Z314*Z862 + Z321*Z872)*ddq_1l + (Z66*Z893 - Z53*Z883 + Z72*Z903 - Z298*Z854 + Z314*Z863 + Z321*Z873)*ddq_2l + (Z66*Z894 - Z53*Z884 + Z72*Z904 - Z298*Z855 + Z314*Z864 + Z321*Z874)*ddq_3l + (Z66*Z895 - Z53*Z885 + Z72*Z905 + Z314*Z865 + Z321*Z875)*ddq_4l + (Z66*(Z896 + Z891*ddq_torso) - Z53*(Z886 + Z881*ddq_torso) + Z72*(Z906 + Z901*ddq_torso) - Z298*(Z856 + Z852*ddq_torso) + Z314*(Z866 + Z861*ddq_torso) + Z321*(Z876 + Z871*ddq_torso))
Z1873 = Z66*Z887 - Z53*Z877 + Z72*Z897 - Z298*Z848 + Z314*Z857 + Z321*Z867;
Z1874 = Z66*Z888 - Z53*Z878 + Z72*Z898 - Z298*Z849 + Z314*Z858 + Z321*Z868;
Z1875 = Z66*Z889 - Z53*Z879 + Z72*Z899 - Z298*Z850 + Z314*Z859 + Z321*Z869;
Z1876 = Z66*Z890 - Z53*Z880 + Z72*Z900 - Z298*Z851 + Z314*Z860 + Z321*Z870;
Z1877 = Z66*Z891 - Z53*Z881 + Z72*Z901 - Z298*Z852 + Z314*Z861 + Z321*Z871;
Z1878 = Z66*Z892 - Z53*Z882 + Z72*Z902 - Z298*Z853 + Z314*Z862 + Z321*Z872;
Z1879 = Z66*Z893 - Z53*Z883 + Z72*Z903 - Z298*Z854 + Z314*Z863 + Z321*Z873;
Z1880 = Z66*Z894 - Z53*Z884 + Z72*Z904 - Z298*Z855 + Z314*Z864 + Z321*Z874;
Z1881 = Z66*Z895 - Z53*Z885 + Z72*Z905 + Z314*Z865 + Z321*Z875;
Z1882 = Z66*Z896 - Z53*Z886 + Z72*Z906 - Z298*Z856 + Z314*Z866 + Z321*Z876;
 
LHS_7l_imu = Z1873*ddx+Z1874*ddpsi+Z1875*ddq_imu+Z1876*ddq_w+Z1877*ddq_torso+Z1878*ddq_1l+Z1879*ddq_2l+Z1880*ddq_3l+Z1881*ddq_4l+Z1882;
 
% LHS_8l_imu = 
%
%      (Z81*Z939 - Z66*Z950 + Z88*Z961 - Z314*Z918 + Z330*Z907 + Z339*Z928)*ddx + (Z81*Z940 - Z66*Z951 + Z88*Z962 - Z314*Z919 + Z330*Z908 + Z339*Z929)*ddpsi + (Z81*Z941 - Z66*Z952 + Z88*Z963 - Z314*Z920 + Z330*Z909 + Z339*Z930)*ddq_imu + (Z81*Z942 - Z66*Z953 + Z88*Z964 - Z314*Z921 + Z330*Z910 + Z339*Z931)*ddq_w + (Z81*Z944 - Z66*Z955 + Z88*Z966 - Z314*Z923 + Z330*Z912 + Z339*Z933)*ddq_1l + (Z81*Z945 - Z66*Z956 + Z88*Z967 - Z314*Z924 + Z330*Z913 + Z339*Z934)*ddq_2l + (Z81*Z946 - Z66*Z957 + Z88*Z968 - Z314*Z925 + Z330*Z914 + Z339*Z935)*ddq_3l + (Z81*Z947 - Z66*Z958 + Z88*Z969 - Z314*Z926 + Z330*Z915 + Z339*Z936)*ddq_4l + (Z81*Z948 - Z66*Z959 + Z88*Z970 + Z330*Z916 + Z339*Z937)*ddq_5l + (Z81*(Z949 + Z943*ddq_torso) - Z66*(Z960 + Z954*ddq_torso) + Z88*(Z971 + Z965*ddq_torso) + Z330*(Z917 + Z911*ddq_torso) - Z314*(Z927 + Z922*ddq_torso) + Z339*(Z938 + Z932*ddq_torso))
Z1883 = Z81*Z939 - Z66*Z950 + Z88*Z961 - Z314*Z918 + Z330*Z907 + Z339*Z928;
Z1884 = Z81*Z940 - Z66*Z951 + Z88*Z962 - Z314*Z919 + Z330*Z908 + Z339*Z929;
Z1885 = Z81*Z941 - Z66*Z952 + Z88*Z963 - Z314*Z920 + Z330*Z909 + Z339*Z930;
Z1886 = Z81*Z942 - Z66*Z953 + Z88*Z964 - Z314*Z921 + Z330*Z910 + Z339*Z931;
Z1887 = Z81*Z943 - Z66*Z954 + Z88*Z965 - Z314*Z922 + Z330*Z911 + Z339*Z932;
Z1888 = Z81*Z944 - Z66*Z955 + Z88*Z966 - Z314*Z923 + Z330*Z912 + Z339*Z933;
Z1889 = Z81*Z945 - Z66*Z956 + Z88*Z967 - Z314*Z924 + Z330*Z913 + Z339*Z934;
Z1890 = Z81*Z946 - Z66*Z957 + Z88*Z968 - Z314*Z925 + Z330*Z914 + Z339*Z935;
Z1891 = Z81*Z947 - Z66*Z958 + Z88*Z969 - Z314*Z926 + Z330*Z915 + Z339*Z936;
Z1892 = Z81*Z948 - Z66*Z959 + Z88*Z970 + Z330*Z916 + Z339*Z937;
Z1893 = Z81*Z949 - Z66*Z960 + Z88*Z971 - Z314*Z927 + Z330*Z917 + Z339*Z938;
 
LHS_8l_imu = Z1883*ddx+Z1884*ddpsi+Z1885*ddq_imu+Z1886*ddq_w+Z1887*ddq_torso+Z1888*ddq_1l+Z1889*ddq_2l+Z1890*ddq_3l+Z1891*ddq_4l+Z1892*ddq_5l+Z1893;
 
% LHS_9l_imu = 
%
%      (Z98*Z1019 - Z81*Z1007 + Z106*Z1031 - Z330*Z972 + Z350*Z983 + Z359*Z995)*ddx + (Z98*Z1020 - Z81*Z1008 + Z106*Z1032 - Z330*Z973 + Z350*Z984 + Z359*Z996)*ddpsi + (Z98*Z1021 - Z81*Z1009 + Z106*Z1033 - Z330*Z974 + Z350*Z985 + Z359*Z997)*ddq_imu + (Z98*Z1022 - Z81*Z1010 + Z106*Z1034 - Z330*Z975 + Z350*Z986 + Z359*Z998)*ddq_w + (Z98*Z1024 - Z81*Z1012 + Z106*Z1036 - Z330*Z977 + Z350*Z988 + Z359*Z1000)*ddq_1l + (Z98*Z1025 - Z81*Z1013 + Z106*Z1037 - Z330*Z978 + Z350*Z989 + Z359*Z1001)*ddq_2l + (Z98*Z1026 - Z81*Z1014 + Z106*Z1038 - Z330*Z979 + Z350*Z990 + Z359*Z1002)*ddq_3l + (Z98*Z1027 - Z81*Z1015 + Z106*Z1039 - Z330*Z980 + Z350*Z991 + Z359*Z1003)*ddq_4l + (Z98*Z1028 - Z81*Z1016 + Z106*Z1040 - Z330*Z981 + Z350*Z992 + Z359*Z1004)*ddq_5l + (Z98*Z1029 - Z81*Z1017 + Z106*Z1041 + Z350*Z993 + Z359*Z1005)*ddq_6l + (Z98*(Z1030 + Z1023*ddq_torso) - Z81*(Z1018 + Z1011*ddq_torso) + Z106*(Z1042 + Z1035*ddq_torso) - Z330*(Z982 + Z976*ddq_torso) + Z350*(Z994 + Z987*ddq_torso) + Z359*(Z1006 + Z999*ddq_torso))
Z1894 = Z98*Z1019 - Z81*Z1007 + Z106*Z1031 - Z330*Z972 + Z350*Z983 + Z359*Z995;
Z1895 = Z98*Z1020 - Z81*Z1008 + Z106*Z1032 - Z330*Z973 + Z350*Z984 + Z359*Z996;
Z1896 = Z98*Z1021 - Z81*Z1009 + Z106*Z1033 - Z330*Z974 + Z350*Z985 + Z359*Z997;
Z1897 = Z98*Z1022 - Z81*Z1010 + Z106*Z1034 - Z330*Z975 + Z350*Z986 + Z359*Z998;
Z1898 = Z98*Z1023 - Z81*Z1011 + Z106*Z1035 - Z330*Z976 + Z350*Z987 + Z359*Z999;
Z1899 = Z98*Z1024 - Z81*Z1012 + Z106*Z1036 - Z330*Z977 + Z350*Z988 + Z359*Z1000;
Z1900 = Z98*Z1025 - Z81*Z1013 + Z106*Z1037 - Z330*Z978 + Z350*Z989 + Z359*Z1001;
Z1901 = Z98*Z1026 - Z81*Z1014 + Z106*Z1038 - Z330*Z979 + Z350*Z990 + Z359*Z1002;
Z1902 = Z98*Z1027 - Z81*Z1015 + Z106*Z1039 - Z330*Z980 + Z350*Z991 + Z359*Z1003;
Z1903 = Z98*Z1028 - Z81*Z1016 + Z106*Z1040 - Z330*Z981 + Z350*Z992 + Z359*Z1004;
Z1904 = Z98*Z1029 - Z81*Z1017 + Z106*Z1041 + Z350*Z993 + Z359*Z1005;
Z1905 = Z98*Z1030 - Z81*Z1018 + Z106*Z1042 - Z330*Z982 + Z350*Z994 + Z359*Z1006;
 
LHS_9l_imu = Z1894*ddx+Z1895*ddpsi+Z1896*ddq_imu+Z1897*ddq_w+Z1898*ddq_torso+Z1899*ddq_1l+Z1900*ddq_2l+Z1901*ddq_3l+Z1902*ddq_4l+Z1903*ddq_5l+Z1904*ddq_6l+Z1905;
 
% LHS_10l_imu = 
%
%      (Z117*Z1081 - Z98*Z1107 + Z126*Z1094 + Z370*Z1043 - Z350*Z1069 + Z381*Z1056)*ddx + (Z117*Z1082 - Z98*Z1108 + Z126*Z1095 + Z370*Z1044 - Z350*Z1070 + Z381*Z1057)*ddpsi + (Z117*Z1083 - Z98*Z1109 + Z126*Z1096 + Z370*Z1045 - Z350*Z1071 + Z381*Z1058)*ddq_imu + (Z117*Z1084 - Z98*Z1110 + Z126*Z1097 + Z370*Z1046 - Z350*Z1072 + Z381*Z1059)*ddq_w + (Z117*Z1086 - Z98*Z1112 + Z126*Z1099 + Z370*Z1048 - Z350*Z1074 + Z381*Z1061)*ddq_1l + (Z117*Z1087 - Z98*Z1113 + Z126*Z1100 + Z370*Z1049 - Z350*Z1075 + Z381*Z1062)*ddq_2l + (Z117*Z1088 - Z98*Z1114 + Z126*Z1101 + Z370*Z1050 - Z350*Z1076 + Z381*Z1063)*ddq_3l + (Z117*Z1089 - Z98*Z1115 + Z126*Z1102 + Z370*Z1051 - Z350*Z1077 + Z381*Z1064)*ddq_4l + (Z117*Z1090 - Z98*Z1116 + Z126*Z1103 + Z370*Z1052 - Z350*Z1078 + Z381*Z1065)*ddq_5l + (Z117*Z1091 - Z98*Z1117 + Z126*Z1104 + Z370*Z1053 - Z350*Z1079 + Z381*Z1066)*ddq_6l + (Z117*Z1092 - Z98*Z1118 + Z126*Z1105 + Z370*Z1054 + Z381*Z1067)*ddq_7l + (Z117*(Z1093 + Z1085*ddq_torso) - Z98*(Z1119 + Z1111*ddq_torso) + Z126*(Z1106 + Z1098*ddq_torso) + Z370*(Z1055 + Z1047*ddq_torso) - Z350*(Z1080 + Z1073*ddq_torso) + Z381*(Z1068 + Z1060*ddq_torso))
Z1906 = Z117*Z1081 - Z98*Z1107 + Z126*Z1094 + Z370*Z1043 - Z350*Z1069 + Z381*Z1056;
Z1907 = Z117*Z1082 - Z98*Z1108 + Z126*Z1095 + Z370*Z1044 - Z350*Z1070 + Z381*Z1057;
Z1908 = Z117*Z1083 - Z98*Z1109 + Z126*Z1096 + Z370*Z1045 - Z350*Z1071 + Z381*Z1058;
Z1909 = Z117*Z1084 - Z98*Z1110 + Z126*Z1097 + Z370*Z1046 - Z350*Z1072 + Z381*Z1059;
Z1910 = Z117*Z1085 - Z98*Z1111 + Z126*Z1098 + Z370*Z1047 - Z350*Z1073 + Z381*Z1060;
Z1911 = Z117*Z1086 - Z98*Z1112 + Z126*Z1099 + Z370*Z1048 - Z350*Z1074 + Z381*Z1061;
Z1912 = Z117*Z1087 - Z98*Z1113 + Z126*Z1100 + Z370*Z1049 - Z350*Z1075 + Z381*Z1062;
Z1913 = Z117*Z1088 - Z98*Z1114 + Z126*Z1101 + Z370*Z1050 - Z350*Z1076 + Z381*Z1063;
Z1914 = Z117*Z1089 - Z98*Z1115 + Z126*Z1102 + Z370*Z1051 - Z350*Z1077 + Z381*Z1064;
Z1915 = Z117*Z1090 - Z98*Z1116 + Z126*Z1103 + Z370*Z1052 - Z350*Z1078 + Z381*Z1065;
Z1916 = Z117*Z1091 - Z98*Z1117 + Z126*Z1104 + Z370*Z1053 - Z350*Z1079 + Z381*Z1066;
Z1917 = Z117*Z1092 - Z98*Z1118 + Z126*Z1105 + Z370*Z1054 + Z381*Z1067;
Z1918 = Z117*Z1093 - Z98*Z1119 + Z126*Z1106 + Z370*Z1055 - Z350*Z1080 + Z381*Z1068;
 
LHS_10l_imu = Z1906*ddx+Z1907*ddpsi+Z1908*ddq_imu+Z1909*ddq_w+Z1910*ddq_torso+Z1911*ddq_1l+Z1912*ddq_2l+Z1913*ddq_3l+Z1914*ddq_4l+Z1915*ddq_5l+Z1916*ddq_6l+Z1917*ddq_7l+Z1918;
 
% LHS_4r_imu = 
%
%      (Z138*Z1140 - Z25*Z1147 + Z141*Z1154 + Z395*Z1120 + Z399*Z1127 + Z403*Z1133)*ddx + (Z138*Z1141 - Z25*Z1148 + Z141*Z1155 + Z395*Z1121 + Z399*Z1128 + Z403*Z1134)*ddpsi + (Z138*Z1142 - Z25*Z1149 + Z141*Z1156 + Z395*Z1122 + Z399*Z1129 + Z403*Z1135)*ddq_imu + (Z138*Z1143 - Z25*Z1150 + Z141*Z1157 + Z395*Z1123 + Z399*Z1130 + Z403*Z1136)*ddq_w + (Z138*Z1145 - Z25*Z1152 + Z141*Z1159 + Z395*Z1125 + Z403*Z1138)*ddq_1r + (Z138*(Z1146 + Z1144*ddq_torso) - Z25*(Z1153 + Z1151*ddq_torso) + Z141*(Z1160 + Z1158*ddq_torso) + Z395*(Z1126 + Z1124*ddq_torso) + Z399*(Z1132 + Z1131*ddq_torso) + Z403*(Z1139 + Z1137*ddq_torso))
Z1919 = Z138*Z1140 - Z25*Z1147 + Z141*Z1154 + Z395*Z1120 + Z399*Z1127 + Z403*Z1133;
Z1920 = Z138*Z1141 - Z25*Z1148 + Z141*Z1155 + Z395*Z1121 + Z399*Z1128 + Z403*Z1134;
Z1921 = Z138*Z1142 - Z25*Z1149 + Z141*Z1156 + Z395*Z1122 + Z399*Z1129 + Z403*Z1135;
Z1922 = Z138*Z1143 - Z25*Z1150 + Z141*Z1157 + Z395*Z1123 + Z399*Z1130 + Z403*Z1136;
Z1923 = Z138*Z1144 - Z25*Z1151 + Z141*Z1158 + Z395*Z1124 + Z399*Z1131 + Z403*Z1137;
Z1924 = Z138*Z1145 - Z25*Z1152 + Z141*Z1159 + Z395*Z1125 + Z403*Z1138;
Z1925 = Z138*Z1146 - Z25*Z1153 + Z141*Z1160 + Z395*Z1126 + Z399*Z1132 + Z403*Z1139;
 
LHS_4r_imu = Z1919*ddx+Z1920*ddpsi+Z1921*ddq_imu+Z1922*ddq_w+Z1923*ddq_torso+Z1924*ddq_1r+Z1925;
 
% LHS_5r_imu = 
%
%      (Z147*Z1185 - Z138*Z1179 + Z151*Z1191 - Z395*Z1161 + Z410*Z1167 + Z415*Z1173)*ddx + (Z147*Z1186 - Z138*Z1180 + Z151*Z1192 - Z395*Z1162 + Z410*Z1168 + Z415*Z1174)*ddpsi + (Z147*Z1187 - Z138*Z1181 + Z151*Z1193 - Z395*Z1163 + Z410*Z1169 + Z415*Z1175)*ddq_imu + (Z147*Z1188 - Z138*Z1182 + Z151*Z1194 - Z395*Z1164 + Z410*Z1170 + Z415*Z1176)*ddq_w + (Z147*(Z1190 + Z1189*ddq_torso) - Z138*(Z1184 + Z1183*ddq_torso) + Z151*(Z1196 + Z1195*ddq_torso) - Z395*(Z1166 + Z1165*ddq_torso) + Z410*(Z1172 + Z1171*ddq_torso) + Z415*(Z1178 + Z1177*ddq_torso))
Z1926 = Z147*Z1185 - Z138*Z1179 + Z151*Z1191 - Z395*Z1161 + Z410*Z1167 + Z415*Z1173;
Z1927 = Z147*Z1186 - Z138*Z1180 + Z151*Z1192 - Z395*Z1162 + Z410*Z1168 + Z415*Z1174;
Z1928 = Z147*Z1187 - Z138*Z1181 + Z151*Z1193 - Z395*Z1163 + Z410*Z1169 + Z415*Z1175;
Z1929 = Z147*Z1188 - Z138*Z1182 + Z151*Z1194 - Z395*Z1164 + Z410*Z1170 + Z415*Z1176;
Z1930 = Z147*Z1189 - Z138*Z1183 + Z151*Z1195 - Z395*Z1165 + Z410*Z1171 + Z415*Z1177;
Z1931 = Z147*Z1190 - Z138*Z1184 + Z151*Z1196 - Z395*Z1166 + Z410*Z1172 + Z415*Z1178;
 
LHS_5r_imu = Z1926*ddx+Z1927*ddpsi+Z1928*ddq_imu+Z1929*ddq_w+Z1930*ddq_torso+Z1931;
 
% LHS_6r_imu = 
%
%      (Z158*Z1223 - Z147*Z1232 + Z163*Z1241 - Z410*Z1206 + Z422*Z1197 + Z429*Z1214)*ddx + (Z158*Z1224 - Z147*Z1233 + Z163*Z1242 - Z410*Z1207 + Z422*Z1198 + Z429*Z1215)*ddpsi + (Z158*Z1225 - Z147*Z1234 + Z163*Z1243 - Z410*Z1208 + Z422*Z1199 + Z429*Z1216)*ddq_imu + (Z158*Z1226 - Z147*Z1235 + Z163*Z1244 - Z410*Z1209 + Z422*Z1200 + Z429*Z1217)*ddq_w + (Z158*Z1228 - Z147*Z1237 + Z163*Z1246 - Z410*Z1211 + Z422*Z1202 + Z429*Z1219)*ddq_1r + (Z158*Z1229 - Z147*Z1238 + Z163*Z1247 - Z410*Z1212 + Z422*Z1203 + Z429*Z1220)*ddq_2r + (Z158*Z1230 - Z147*Z1239 + Z163*Z1248 + Z422*Z1204 + Z429*Z1221)*ddq_3r + (Z158*(Z1231 + Z1227*ddq_torso) - Z147*(Z1240 + Z1236*ddq_torso) + Z163*(Z1249 + Z1245*ddq_torso) + Z422*(Z1205 + Z1201*ddq_torso) - Z410*(Z1213 + Z1210*ddq_torso) + Z429*(Z1222 + Z1218*ddq_torso))
Z1932 = Z158*Z1223 - Z147*Z1232 + Z163*Z1241 - Z410*Z1206 + Z422*Z1197 + Z429*Z1214;
Z1933 = Z158*Z1224 - Z147*Z1233 + Z163*Z1242 - Z410*Z1207 + Z422*Z1198 + Z429*Z1215;
Z1934 = Z158*Z1225 - Z147*Z1234 + Z163*Z1243 - Z410*Z1208 + Z422*Z1199 + Z429*Z1216;
Z1935 = Z158*Z1226 - Z147*Z1235 + Z163*Z1244 - Z410*Z1209 + Z422*Z1200 + Z429*Z1217;
Z1936 = Z158*Z1227 - Z147*Z1236 + Z163*Z1245 - Z410*Z1210 + Z422*Z1201 + Z429*Z1218;
Z1937 = Z158*Z1228 - Z147*Z1237 + Z163*Z1246 - Z410*Z1211 + Z422*Z1202 + Z429*Z1219;
Z1938 = Z158*Z1229 - Z147*Z1238 + Z163*Z1247 - Z410*Z1212 + Z422*Z1203 + Z429*Z1220;
Z1939 = Z158*Z1230 - Z147*Z1239 + Z163*Z1248 + Z422*Z1204 + Z429*Z1221;
Z1940 = Z158*Z1231 - Z147*Z1240 + Z163*Z1249 - Z410*Z1213 + Z422*Z1205 + Z429*Z1222;
 
LHS_6r_imu = Z1932*ddx+Z1933*ddpsi+Z1934*ddq_imu+Z1935*ddq_w+Z1936*ddq_torso+Z1937*ddq_1r+Z1938*ddq_2r+Z1939*ddq_3r+Z1940;
 
% LHS_7r_imu = 
%
%      (Z171*Z1289 - Z158*Z1279 + Z177*Z1299 - Z422*Z1250 + Z438*Z1259 + Z445*Z1269)*ddx + (Z171*Z1290 - Z158*Z1280 + Z177*Z1300 - Z422*Z1251 + Z438*Z1260 + Z445*Z1270)*ddpsi + (Z171*Z1291 - Z158*Z1281 + Z177*Z1301 - Z422*Z1252 + Z438*Z1261 + Z445*Z1271)*ddq_imu + (Z171*Z1292 - Z158*Z1282 + Z177*Z1302 - Z422*Z1253 + Z438*Z1262 + Z445*Z1272)*ddq_w + (Z171*Z1294 - Z158*Z1284 + Z177*Z1304 - Z422*Z1255 + Z438*Z1264 + Z445*Z1274)*ddq_1r + (Z171*Z1295 - Z158*Z1285 + Z177*Z1305 - Z422*Z1256 + Z438*Z1265 + Z445*Z1275)*ddq_2r + (Z171*Z1296 - Z158*Z1286 + Z177*Z1306 - Z422*Z1257 + Z438*Z1266 + Z445*Z1276)*ddq_3r + (Z171*Z1297 - Z158*Z1287 + Z177*Z1307 + Z438*Z1267 + Z445*Z1277)*ddq_4r + (Z171*(Z1298 + Z1293*ddq_torso) - Z158*(Z1288 + Z1283*ddq_torso) + Z177*(Z1308 + Z1303*ddq_torso) - Z422*(Z1258 + Z1254*ddq_torso) + Z438*(Z1268 + Z1263*ddq_torso) + Z445*(Z1278 + Z1273*ddq_torso))
Z1941 = Z171*Z1289 - Z158*Z1279 + Z177*Z1299 - Z422*Z1250 + Z438*Z1259 + Z445*Z1269;
Z1942 = Z171*Z1290 - Z158*Z1280 + Z177*Z1300 - Z422*Z1251 + Z438*Z1260 + Z445*Z1270;
Z1943 = Z171*Z1291 - Z158*Z1281 + Z177*Z1301 - Z422*Z1252 + Z438*Z1261 + Z445*Z1271;
Z1944 = Z171*Z1292 - Z158*Z1282 + Z177*Z1302 - Z422*Z1253 + Z438*Z1262 + Z445*Z1272;
Z1945 = Z171*Z1293 - Z158*Z1283 + Z177*Z1303 - Z422*Z1254 + Z438*Z1263 + Z445*Z1273;
Z1946 = Z171*Z1294 - Z158*Z1284 + Z177*Z1304 - Z422*Z1255 + Z438*Z1264 + Z445*Z1274;
Z1947 = Z171*Z1295 - Z158*Z1285 + Z177*Z1305 - Z422*Z1256 + Z438*Z1265 + Z445*Z1275;
Z1948 = Z171*Z1296 - Z158*Z1286 + Z177*Z1306 - Z422*Z1257 + Z438*Z1266 + Z445*Z1276;
Z1949 = Z171*Z1297 - Z158*Z1287 + Z177*Z1307 + Z438*Z1267 + Z445*Z1277;
Z1950 = Z171*Z1298 - Z158*Z1288 + Z177*Z1308 - Z422*Z1258 + Z438*Z1268 + Z445*Z1278;
 
LHS_7r_imu = Z1941*ddx+Z1942*ddpsi+Z1943*ddq_imu+Z1944*ddq_w+Z1945*ddq_torso+Z1946*ddq_1r+Z1947*ddq_2r+Z1948*ddq_3r+Z1949*ddq_4r+Z1950;
 
% LHS_8r_imu = 
%
%      (Z186*Z1341 - Z171*Z1352 + Z193*Z1363 - Z438*Z1320 + Z454*Z1309 + Z463*Z1330)*ddx + (Z186*Z1342 - Z171*Z1353 + Z193*Z1364 - Z438*Z1321 + Z454*Z1310 + Z463*Z1331)*ddpsi + (Z186*Z1343 - Z171*Z1354 + Z193*Z1365 - Z438*Z1322 + Z454*Z1311 + Z463*Z1332)*ddq_imu + (Z186*Z1344 - Z171*Z1355 + Z193*Z1366 - Z438*Z1323 + Z454*Z1312 + Z463*Z1333)*ddq_w + (Z186*Z1346 - Z171*Z1357 + Z193*Z1368 - Z438*Z1325 + Z454*Z1314 + Z463*Z1335)*ddq_1r + (Z186*Z1347 - Z171*Z1358 + Z193*Z1369 - Z438*Z1326 + Z454*Z1315 + Z463*Z1336)*ddq_2r + (Z186*Z1348 - Z171*Z1359 + Z193*Z1370 - Z438*Z1327 + Z454*Z1316 + Z463*Z1337)*ddq_3r + (Z186*Z1349 - Z171*Z1360 + Z193*Z1371 - Z438*Z1328 + Z454*Z1317 + Z463*Z1338)*ddq_4r + (Z186*Z1350 - Z171*Z1361 + Z193*Z1372 + Z454*Z1318 + Z463*Z1339)*ddq_5r + (Z186*(Z1351 + Z1345*ddq_torso) - Z171*(Z1362 + Z1356*ddq_torso) + Z193*(Z1373 + Z1367*ddq_torso) + Z454*(Z1319 + Z1313*ddq_torso) - Z438*(Z1329 + Z1324*ddq_torso) + Z463*(Z1340 + Z1334*ddq_torso))
Z1951 = Z186*Z1341 - Z171*Z1352 + Z193*Z1363 - Z438*Z1320 + Z454*Z1309 + Z463*Z1330;
Z1952 = Z186*Z1342 - Z171*Z1353 + Z193*Z1364 - Z438*Z1321 + Z454*Z1310 + Z463*Z1331;
Z1953 = Z186*Z1343 - Z171*Z1354 + Z193*Z1365 - Z438*Z1322 + Z454*Z1311 + Z463*Z1332;
Z1954 = Z186*Z1344 - Z171*Z1355 + Z193*Z1366 - Z438*Z1323 + Z454*Z1312 + Z463*Z1333;
Z1955 = Z186*Z1345 - Z171*Z1356 + Z193*Z1367 - Z438*Z1324 + Z454*Z1313 + Z463*Z1334;
Z1956 = Z186*Z1346 - Z171*Z1357 + Z193*Z1368 - Z438*Z1325 + Z454*Z1314 + Z463*Z1335;
Z1957 = Z186*Z1347 - Z171*Z1358 + Z193*Z1369 - Z438*Z1326 + Z454*Z1315 + Z463*Z1336;
Z1958 = Z186*Z1348 - Z171*Z1359 + Z193*Z1370 - Z438*Z1327 + Z454*Z1316 + Z463*Z1337;
Z1959 = Z186*Z1349 - Z171*Z1360 + Z193*Z1371 - Z438*Z1328 + Z454*Z1317 + Z463*Z1338;
Z1960 = Z186*Z1350 - Z171*Z1361 + Z193*Z1372 + Z454*Z1318 + Z463*Z1339;
Z1961 = Z186*Z1351 - Z171*Z1362 + Z193*Z1373 - Z438*Z1329 + Z454*Z1319 + Z463*Z1340;
 
LHS_8r_imu = Z1951*ddx+Z1952*ddpsi+Z1953*ddq_imu+Z1954*ddq_w+Z1955*ddq_torso+Z1956*ddq_1r+Z1957*ddq_2r+Z1958*ddq_3r+Z1959*ddq_4r+Z1960*ddq_5r+Z1961;
 
% LHS_9r_imu = 
%
%      (Z203*Z1421 - Z186*Z1409 + Z211*Z1433 - Z454*Z1374 + Z474*Z1385 + Z483*Z1397)*ddx + (Z203*Z1422 - Z186*Z1410 + Z211*Z1434 - Z454*Z1375 + Z474*Z1386 + Z483*Z1398)*ddpsi + (Z203*Z1423 - Z186*Z1411 + Z211*Z1435 - Z454*Z1376 + Z474*Z1387 + Z483*Z1399)*ddq_imu + (Z203*Z1424 - Z186*Z1412 + Z211*Z1436 - Z454*Z1377 + Z474*Z1388 + Z483*Z1400)*ddq_w + (Z203*Z1426 - Z186*Z1414 + Z211*Z1438 - Z454*Z1379 + Z474*Z1390 + Z483*Z1402)*ddq_1r + (Z203*Z1427 - Z186*Z1415 + Z211*Z1439 - Z454*Z1380 + Z474*Z1391 + Z483*Z1403)*ddq_2r + (Z203*Z1428 - Z186*Z1416 + Z211*Z1440 - Z454*Z1381 + Z474*Z1392 + Z483*Z1404)*ddq_3r + (Z203*Z1429 - Z186*Z1417 + Z211*Z1441 - Z454*Z1382 + Z474*Z1393 + Z483*Z1405)*ddq_4r + (Z203*Z1430 - Z186*Z1418 + Z211*Z1442 - Z454*Z1383 + Z474*Z1394 + Z483*Z1406)*ddq_5r + (Z203*Z1431 - Z186*Z1419 + Z211*Z1443 + Z474*Z1395 + Z483*Z1407)*ddq_6r + (Z203*(Z1432 + Z1425*ddq_torso) - Z186*(Z1420 + Z1413*ddq_torso) + Z211*(Z1444 + Z1437*ddq_torso) - Z454*(Z1384 + Z1378*ddq_torso) + Z474*(Z1396 + Z1389*ddq_torso) + Z483*(Z1408 + Z1401*ddq_torso))
Z1962 = Z203*Z1421 - Z186*Z1409 + Z211*Z1433 - Z454*Z1374 + Z474*Z1385 + Z483*Z1397;
Z1963 = Z203*Z1422 - Z186*Z1410 + Z211*Z1434 - Z454*Z1375 + Z474*Z1386 + Z483*Z1398;
Z1964 = Z203*Z1423 - Z186*Z1411 + Z211*Z1435 - Z454*Z1376 + Z474*Z1387 + Z483*Z1399;
Z1965 = Z203*Z1424 - Z186*Z1412 + Z211*Z1436 - Z454*Z1377 + Z474*Z1388 + Z483*Z1400;
Z1966 = Z203*Z1425 - Z186*Z1413 + Z211*Z1437 - Z454*Z1378 + Z474*Z1389 + Z483*Z1401;
Z1967 = Z203*Z1426 - Z186*Z1414 + Z211*Z1438 - Z454*Z1379 + Z474*Z1390 + Z483*Z1402;
Z1968 = Z203*Z1427 - Z186*Z1415 + Z211*Z1439 - Z454*Z1380 + Z474*Z1391 + Z483*Z1403;
Z1969 = Z203*Z1428 - Z186*Z1416 + Z211*Z1440 - Z454*Z1381 + Z474*Z1392 + Z483*Z1404;
Z1970 = Z203*Z1429 - Z186*Z1417 + Z211*Z1441 - Z454*Z1382 + Z474*Z1393 + Z483*Z1405;
Z1971 = Z203*Z1430 - Z186*Z1418 + Z211*Z1442 - Z454*Z1383 + Z474*Z1394 + Z483*Z1406;
Z1972 = Z203*Z1431 - Z186*Z1419 + Z211*Z1443 + Z474*Z1395 + Z483*Z1407;
Z1973 = Z203*Z1432 - Z186*Z1420 + Z211*Z1444 - Z454*Z1384 + Z474*Z1396 + Z483*Z1408;
 
LHS_9r_imu = Z1962*ddx+Z1963*ddpsi+Z1964*ddq_imu+Z1965*ddq_w+Z1966*ddq_torso+Z1967*ddq_1r+Z1968*ddq_2r+Z1969*ddq_3r+Z1970*ddq_4r+Z1971*ddq_5r+Z1972*ddq_6r+Z1973;
 
% LHS_10r_imu = 
%
%      (Z222*Z1483 - Z203*Z1509 + Z231*Z1496 + Z494*Z1445 - Z474*Z1471 + Z505*Z1458)*ddx + (Z222*Z1484 - Z203*Z1510 + Z231*Z1497 + Z494*Z1446 - Z474*Z1472 + Z505*Z1459)*ddpsi + (Z222*Z1485 - Z203*Z1511 + Z231*Z1498 + Z494*Z1447 - Z474*Z1473 + Z505*Z1460)*ddq_imu + (Z222*Z1486 - Z203*Z1512 + Z231*Z1499 + Z494*Z1448 - Z474*Z1474 + Z505*Z1461)*ddq_w + (Z222*Z1488 - Z203*Z1514 + Z231*Z1501 + Z494*Z1450 - Z474*Z1476 + Z505*Z1463)*ddq_1r + (Z222*Z1489 - Z203*Z1515 + Z231*Z1502 + Z494*Z1451 - Z474*Z1477 + Z505*Z1464)*ddq_2r + (Z222*Z1490 - Z203*Z1516 + Z231*Z1503 + Z494*Z1452 - Z474*Z1478 + Z505*Z1465)*ddq_3r + (Z222*Z1491 - Z203*Z1517 + Z231*Z1504 + Z494*Z1453 - Z474*Z1479 + Z505*Z1466)*ddq_4r + (Z222*Z1492 - Z203*Z1518 + Z231*Z1505 + Z494*Z1454 - Z474*Z1480 + Z505*Z1467)*ddq_5r + (Z222*Z1493 - Z203*Z1519 + Z231*Z1506 + Z494*Z1455 - Z474*Z1481 + Z505*Z1468)*ddq_6r + (Z222*Z1494 - Z203*Z1520 + Z231*Z1507 + Z494*Z1456 + Z505*Z1469)*ddq_7r + (Z222*(Z1495 + Z1487*ddq_torso) - Z203*(Z1521 + Z1513*ddq_torso) + Z231*(Z1508 + Z1500*ddq_torso) + Z494*(Z1457 + Z1449*ddq_torso) - Z474*(Z1482 + Z1475*ddq_torso) + Z505*(Z1470 + Z1462*ddq_torso))
Z1974 = Z222*Z1483 - Z203*Z1509 + Z231*Z1496 + Z494*Z1445 - Z474*Z1471 + Z505*Z1458;
Z1975 = Z222*Z1484 - Z203*Z1510 + Z231*Z1497 + Z494*Z1446 - Z474*Z1472 + Z505*Z1459;
Z1976 = Z222*Z1485 - Z203*Z1511 + Z231*Z1498 + Z494*Z1447 - Z474*Z1473 + Z505*Z1460;
Z1977 = Z222*Z1486 - Z203*Z1512 + Z231*Z1499 + Z494*Z1448 - Z474*Z1474 + Z505*Z1461;
Z1978 = Z222*Z1487 - Z203*Z1513 + Z231*Z1500 + Z494*Z1449 - Z474*Z1475 + Z505*Z1462;
Z1979 = Z222*Z1488 - Z203*Z1514 + Z231*Z1501 + Z494*Z1450 - Z474*Z1476 + Z505*Z1463;
Z1980 = Z222*Z1489 - Z203*Z1515 + Z231*Z1502 + Z494*Z1451 - Z474*Z1477 + Z505*Z1464;
Z1981 = Z222*Z1490 - Z203*Z1516 + Z231*Z1503 + Z494*Z1452 - Z474*Z1478 + Z505*Z1465;
Z1982 = Z222*Z1491 - Z203*Z1517 + Z231*Z1504 + Z494*Z1453 - Z474*Z1479 + Z505*Z1466;
Z1983 = Z222*Z1492 - Z203*Z1518 + Z231*Z1505 + Z494*Z1454 - Z474*Z1480 + Z505*Z1467;
Z1984 = Z222*Z1493 - Z203*Z1519 + Z231*Z1506 + Z494*Z1455 - Z474*Z1481 + Z505*Z1468;
Z1985 = Z222*Z1494 - Z203*Z1520 + Z231*Z1507 + Z494*Z1456 + Z505*Z1469;
Z1986 = Z222*Z1495 - Z203*Z1521 + Z231*Z1508 + Z494*Z1457 - Z474*Z1482 + Z505*Z1470;
 
LHS_10r_imu = Z1974*ddx+Z1975*ddpsi+Z1976*ddq_imu+Z1977*ddq_w+Z1978*ddq_torso+Z1979*ddq_1r+Z1980*ddq_2r+Z1981*ddq_3r+Z1982*ddq_4r+Z1983*ddq_5r+Z1984*ddq_6r+Z1985*ddq_7r+Z1986;
 
% LHS_L_w = 
%
%      0
% LHS_R_w = 
%
%      0
% LHS_1_w = 
%
%      0
% LHS_2_w = 
%
%      (-Z657)*ddx + (-Z658)*ddpsi + (-Z659)*ddq_imu + (-Z660)*ddq_w - Z661
LHS_2_w = -Z657*ddx-Z658*ddpsi-Z659*ddq_imu-Z660*ddq_w+-Z661;
 
% LHS_3_w = 
%
%      (L4*Z678 + Z25*Z689 + Z27*Z701 + Z260*Z672 + Z265*Z683)*ddx + (L4*Z679 + Z25*Z690 + Z27*Z702 + Z260*Z673 + Z265*Z684)*ddpsi + (L4*Z680 + Z25*Z691 + Z27*Z703 + Z260*Z674 + Z265*Z685)*ddq_imu + (L4*Z681 + Z25*Z692 + Z27*Z704 + Z260*Z675 + Z265*Z686)*ddq_w + (L4*Z682 + Z25*(Z694 + Z693*ddq_torso) + Z27*(Z706 + Z705*ddq_torso) + Z260*(Z677 + Z676*ddq_torso) + Z265*(Z688 + Z687*ddq_torso))
Z1987 = L4*Z678 + Z25*Z689 + Z27*Z701 + Z260*Z672 + Z265*Z683;
Z1988 = L4*Z679 + Z25*Z690 + Z27*Z702 + Z260*Z673 + Z265*Z684;
Z1989 = L4*Z680 + Z25*Z691 + Z27*Z703 + Z260*Z674 + Z265*Z685;
Z1990 = L4*Z681 + Z25*Z692 + Z27*Z704 + Z260*Z675 + Z265*Z686;
Z1991 = Z25*Z693 + Z27*Z705 + Z260*Z676 + Z265*Z687;
Z1992 = L4*Z682 + Z25*Z694 + Z27*Z706 + Z260*Z677 + Z265*Z688;
 
LHS_3_w = Z1987*ddx+Z1988*ddpsi+Z1989*ddq_imu+Z1990*ddq_w+Z1991*ddq_torso+Z1992;
 
% LHS_4l_w = 
%
%      (Z25*Z734 + Z33*Z727 + Z36*Z741 + Z272*Z707 + Z276*Z714 + Z280*Z720)*ddx + (Z25*Z735 + Z33*Z728 + Z36*Z742 + Z272*Z708 + Z276*Z715 + Z280*Z721)*ddpsi + (Z25*Z736 + Z33*Z729 + Z36*Z743 + Z272*Z709 + Z276*Z716 + Z280*Z722)*ddq_imu + (Z25*Z737 + Z33*Z730 + Z36*Z744 + Z272*Z710 + Z276*Z717 + Z280*Z723)*ddq_w + (Z25*Z739 + Z33*Z732 + Z36*Z746 + Z272*Z712 + Z280*Z725)*ddq_1l + (Z33*(Z733 + Z731*ddq_torso) + Z25*(Z740 + Z738*ddq_torso) + Z36*(Z747 + Z745*ddq_torso) + Z272*(Z713 + Z711*ddq_torso) + Z276*(Z719 + Z718*ddq_torso) + Z280*(Z726 + Z724*ddq_torso))
Z1993 = Z25*Z734 + Z33*Z727 + Z36*Z741 + Z272*Z707 + Z276*Z714 + Z280*Z720;
Z1994 = Z25*Z735 + Z33*Z728 + Z36*Z742 + Z272*Z708 + Z276*Z715 + Z280*Z721;
Z1995 = Z25*Z736 + Z33*Z729 + Z36*Z743 + Z272*Z709 + Z276*Z716 + Z280*Z722;
Z1996 = Z25*Z737 + Z33*Z730 + Z36*Z744 + Z272*Z710 + Z276*Z717 + Z280*Z723;
Z1997 = Z25*Z738 + Z33*Z731 + Z36*Z745 + Z272*Z711 + Z276*Z718 + Z280*Z724;
Z1998 = Z25*Z739 + Z33*Z732 + Z36*Z746 + Z272*Z712 + Z280*Z725;
Z1999 = Z25*Z740 + Z33*Z733 + Z36*Z747 + Z272*Z713 + Z276*Z719 + Z280*Z726;
 
LHS_4l_w = Z1993*ddx+Z1994*ddpsi+Z1995*ddq_imu+Z1996*ddq_w+Z1997*ddq_torso+Z1998*ddq_1l+Z1999;
 
% LHS_5l_w = 
%
%      (Z42*Z779 - Z33*Z771 + Z46*Z787 - Z272*Z748 + Z287*Z755 + Z292*Z763)*ddx + (Z42*Z780 - Z33*Z772 + Z46*Z788 - Z272*Z749 + Z287*Z756 + Z292*Z764)*ddpsi + (Z42*Z781 - Z33*Z773 + Z46*Z789 - Z272*Z750 + Z287*Z757 + Z292*Z765)*ddq_imu + (Z42*Z782 - Z33*Z774 + Z46*Z790 - Z272*Z751 + Z287*Z758 + Z292*Z766)*ddq_w + (Z42*Z784 - Z33*Z776 + Z46*Z792 - Z272*Z753 + Z287*Z760 + Z292*Z768)*ddq_1l + (Z42*Z785 - Z33*Z777 + Z46*Z793 + Z287*Z761 + Z292*Z769)*ddq_2l + (Z42*(Z786 + Z783*ddq_torso) - Z33*(Z778 + Z775*ddq_torso) + Z46*(Z794 + Z791*ddq_torso) - Z272*(Z754 + Z752*ddq_torso) + Z287*(Z762 + Z759*ddq_torso) + Z292*(Z770 + Z767*ddq_torso))
Z2000 = Z42*Z779 - Z33*Z771 + Z46*Z787 - Z272*Z748 + Z287*Z755 + Z292*Z763;
Z2001 = Z42*Z780 - Z33*Z772 + Z46*Z788 - Z272*Z749 + Z287*Z756 + Z292*Z764;
Z2002 = Z42*Z781 - Z33*Z773 + Z46*Z789 - Z272*Z750 + Z287*Z757 + Z292*Z765;
Z2003 = Z42*Z782 - Z33*Z774 + Z46*Z790 - Z272*Z751 + Z287*Z758 + Z292*Z766;
Z2004 = Z42*Z783 - Z33*Z775 + Z46*Z791 - Z272*Z752 + Z287*Z759 + Z292*Z767;
Z2005 = Z42*Z784 - Z33*Z776 + Z46*Z792 - Z272*Z753 + Z287*Z760 + Z292*Z768;
Z2006 = Z42*Z785 - Z33*Z777 + Z46*Z793 + Z287*Z761 + Z292*Z769;
Z2007 = Z42*Z786 - Z33*Z778 + Z46*Z794 - Z272*Z754 + Z287*Z762 + Z292*Z770;
 
LHS_5l_w = Z2000*ddx+Z2001*ddpsi+Z2002*ddq_imu+Z2003*ddq_w+Z2004*ddq_torso+Z2005*ddq_1l+Z2006*ddq_2l+Z2007;
 
% LHS_6l_w = 
%
%      (Z53*Z821 - Z42*Z830 + Z58*Z839 - Z287*Z804 + Z299*Z795 + Z306*Z812)*ddx + (Z53*Z822 - Z42*Z831 + Z58*Z840 - Z287*Z805 + Z299*Z796 + Z306*Z813)*ddpsi + (Z53*Z823 - Z42*Z832 + Z58*Z841 - Z287*Z806 + Z299*Z797 + Z306*Z814)*ddq_imu + (Z53*Z824 - Z42*Z833 + Z58*Z842 - Z287*Z807 + Z299*Z798 + Z306*Z815)*ddq_w + (Z53*Z826 - Z42*Z835 + Z58*Z844 - Z287*Z809 + Z299*Z800 + Z306*Z817)*ddq_1l + (Z53*Z827 - Z42*Z836 + Z58*Z845 - Z287*Z810 + Z299*Z801 + Z306*Z818)*ddq_2l + (Z53*Z828 - Z42*Z837 + Z58*Z846 + Z299*Z802 + Z306*Z819)*ddq_3l + (Z53*(Z829 + Z825*ddq_torso) - Z42*(Z838 + Z834*ddq_torso) + Z58*(Z847 + Z843*ddq_torso) + Z299*(Z803 + Z799*ddq_torso) - Z287*(Z811 + Z808*ddq_torso) + Z306*(Z820 + Z816*ddq_torso))
Z2008 = Z53*Z821 - Z42*Z830 + Z58*Z839 - Z287*Z804 + Z299*Z795 + Z306*Z812;
Z2009 = Z53*Z822 - Z42*Z831 + Z58*Z840 - Z287*Z805 + Z299*Z796 + Z306*Z813;
Z2010 = Z53*Z823 - Z42*Z832 + Z58*Z841 - Z287*Z806 + Z299*Z797 + Z306*Z814;
Z2011 = Z53*Z824 - Z42*Z833 + Z58*Z842 - Z287*Z807 + Z299*Z798 + Z306*Z815;
Z2012 = Z53*Z825 - Z42*Z834 + Z58*Z843 - Z287*Z808 + Z299*Z799 + Z306*Z816;
Z2013 = Z53*Z826 - Z42*Z835 + Z58*Z844 - Z287*Z809 + Z299*Z800 + Z306*Z817;
Z2014 = Z53*Z827 - Z42*Z836 + Z58*Z845 - Z287*Z810 + Z299*Z801 + Z306*Z818;
Z2015 = Z53*Z828 - Z42*Z837 + Z58*Z846 + Z299*Z802 + Z306*Z819;
Z2016 = Z53*Z829 - Z42*Z838 + Z58*Z847 - Z287*Z811 + Z299*Z803 + Z306*Z820;
 
LHS_6l_w = Z2008*ddx+Z2009*ddpsi+Z2010*ddq_imu+Z2011*ddq_w+Z2012*ddq_torso+Z2013*ddq_1l+Z2014*ddq_2l+Z2015*ddq_3l+Z2016;
 
% LHS_7l_w = 
%
%      (Z66*Z887 - Z53*Z877 + Z72*Z897 - Z299*Z848 + Z315*Z857 + Z322*Z867)*ddx + (Z66*Z888 - Z53*Z878 + Z72*Z898 - Z299*Z849 + Z315*Z858 + Z322*Z868)*ddpsi + (Z66*Z889 - Z53*Z879 + Z72*Z899 - Z299*Z850 + Z315*Z859 + Z322*Z869)*ddq_imu + (Z66*Z890 - Z53*Z880 + Z72*Z900 - Z299*Z851 + Z315*Z860 + Z322*Z870)*ddq_w + (Z66*Z892 - Z53*Z882 + Z72*Z902 - Z299*Z853 + Z315*Z862 + Z322*Z872)*ddq_1l + (Z66*Z893 - Z53*Z883 + Z72*Z903 - Z299*Z854 + Z315*Z863 + Z322*Z873)*ddq_2l + (Z66*Z894 - Z53*Z884 + Z72*Z904 - Z299*Z855 + Z315*Z864 + Z322*Z874)*ddq_3l + (Z66*Z895 - Z53*Z885 + Z72*Z905 + Z315*Z865 + Z322*Z875)*ddq_4l + (Z66*(Z896 + Z891*ddq_torso) - Z53*(Z886 + Z881*ddq_torso) + Z72*(Z906 + Z901*ddq_torso) - Z299*(Z856 + Z852*ddq_torso) + Z315*(Z866 + Z861*ddq_torso) + Z322*(Z876 + Z871*ddq_torso))
Z2017 = Z66*Z887 - Z53*Z877 + Z72*Z897 - Z299*Z848 + Z315*Z857 + Z322*Z867;
Z2018 = Z66*Z888 - Z53*Z878 + Z72*Z898 - Z299*Z849 + Z315*Z858 + Z322*Z868;
Z2019 = Z66*Z889 - Z53*Z879 + Z72*Z899 - Z299*Z850 + Z315*Z859 + Z322*Z869;
Z2020 = Z66*Z890 - Z53*Z880 + Z72*Z900 - Z299*Z851 + Z315*Z860 + Z322*Z870;
Z2021 = Z66*Z891 - Z53*Z881 + Z72*Z901 - Z299*Z852 + Z315*Z861 + Z322*Z871;
Z2022 = Z66*Z892 - Z53*Z882 + Z72*Z902 - Z299*Z853 + Z315*Z862 + Z322*Z872;
Z2023 = Z66*Z893 - Z53*Z883 + Z72*Z903 - Z299*Z854 + Z315*Z863 + Z322*Z873;
Z2024 = Z66*Z894 - Z53*Z884 + Z72*Z904 - Z299*Z855 + Z315*Z864 + Z322*Z874;
Z2025 = Z66*Z895 - Z53*Z885 + Z72*Z905 + Z315*Z865 + Z322*Z875;
Z2026 = Z66*Z896 - Z53*Z886 + Z72*Z906 - Z299*Z856 + Z315*Z866 + Z322*Z876;
 
LHS_7l_w = Z2017*ddx+Z2018*ddpsi+Z2019*ddq_imu+Z2020*ddq_w+Z2021*ddq_torso+Z2022*ddq_1l+Z2023*ddq_2l+Z2024*ddq_3l+Z2025*ddq_4l+Z2026;
 
% LHS_8l_w = 
%
%      (Z81*Z939 - Z66*Z950 + Z88*Z961 - Z315*Z918 + Z331*Z907 + Z340*Z928)*ddx + (Z81*Z940 - Z66*Z951 + Z88*Z962 - Z315*Z919 + Z331*Z908 + Z340*Z929)*ddpsi + (Z81*Z941 - Z66*Z952 + Z88*Z963 - Z315*Z920 + Z331*Z909 + Z340*Z930)*ddq_imu + (Z81*Z942 - Z66*Z953 + Z88*Z964 - Z315*Z921 + Z331*Z910 + Z340*Z931)*ddq_w + (Z81*Z944 - Z66*Z955 + Z88*Z966 - Z315*Z923 + Z331*Z912 + Z340*Z933)*ddq_1l + (Z81*Z945 - Z66*Z956 + Z88*Z967 - Z315*Z924 + Z331*Z913 + Z340*Z934)*ddq_2l + (Z81*Z946 - Z66*Z957 + Z88*Z968 - Z315*Z925 + Z331*Z914 + Z340*Z935)*ddq_3l + (Z81*Z947 - Z66*Z958 + Z88*Z969 - Z315*Z926 + Z331*Z915 + Z340*Z936)*ddq_4l + (Z81*Z948 - Z66*Z959 + Z88*Z970 + Z331*Z916 + Z340*Z937)*ddq_5l + (Z81*(Z949 + Z943*ddq_torso) - Z66*(Z960 + Z954*ddq_torso) + Z88*(Z971 + Z965*ddq_torso) + Z331*(Z917 + Z911*ddq_torso) - Z315*(Z927 + Z922*ddq_torso) + Z340*(Z938 + Z932*ddq_torso))
Z2027 = Z81*Z939 - Z66*Z950 + Z88*Z961 - Z315*Z918 + Z331*Z907 + Z340*Z928;
Z2028 = Z81*Z940 - Z66*Z951 + Z88*Z962 - Z315*Z919 + Z331*Z908 + Z340*Z929;
Z2029 = Z81*Z941 - Z66*Z952 + Z88*Z963 - Z315*Z920 + Z331*Z909 + Z340*Z930;
Z2030 = Z81*Z942 - Z66*Z953 + Z88*Z964 - Z315*Z921 + Z331*Z910 + Z340*Z931;
Z2031 = Z81*Z943 - Z66*Z954 + Z88*Z965 - Z315*Z922 + Z331*Z911 + Z340*Z932;
Z2032 = Z81*Z944 - Z66*Z955 + Z88*Z966 - Z315*Z923 + Z331*Z912 + Z340*Z933;
Z2033 = Z81*Z945 - Z66*Z956 + Z88*Z967 - Z315*Z924 + Z331*Z913 + Z340*Z934;
Z2034 = Z81*Z946 - Z66*Z957 + Z88*Z968 - Z315*Z925 + Z331*Z914 + Z340*Z935;
Z2035 = Z81*Z947 - Z66*Z958 + Z88*Z969 - Z315*Z926 + Z331*Z915 + Z340*Z936;
Z2036 = Z81*Z948 - Z66*Z959 + Z88*Z970 + Z331*Z916 + Z340*Z937;
Z2037 = Z81*Z949 - Z66*Z960 + Z88*Z971 - Z315*Z927 + Z331*Z917 + Z340*Z938;
 
LHS_8l_w = Z2027*ddx+Z2028*ddpsi+Z2029*ddq_imu+Z2030*ddq_w+Z2031*ddq_torso+Z2032*ddq_1l+Z2033*ddq_2l+Z2034*ddq_3l+Z2035*ddq_4l+Z2036*ddq_5l+Z2037;
 
% LHS_9l_w = 
%
%      (Z98*Z1019 - Z81*Z1007 + Z106*Z1031 - Z331*Z972 + Z351*Z983 + Z360*Z995)*ddx + (Z98*Z1020 - Z81*Z1008 + Z106*Z1032 - Z331*Z973 + Z351*Z984 + Z360*Z996)*ddpsi + (Z98*Z1021 - Z81*Z1009 + Z106*Z1033 - Z331*Z974 + Z351*Z985 + Z360*Z997)*ddq_imu + (Z98*Z1022 - Z81*Z1010 + Z106*Z1034 - Z331*Z975 + Z351*Z986 + Z360*Z998)*ddq_w + (Z98*Z1024 - Z81*Z1012 + Z106*Z1036 - Z331*Z977 + Z351*Z988 + Z360*Z1000)*ddq_1l + (Z98*Z1025 - Z81*Z1013 + Z106*Z1037 - Z331*Z978 + Z351*Z989 + Z360*Z1001)*ddq_2l + (Z98*Z1026 - Z81*Z1014 + Z106*Z1038 - Z331*Z979 + Z351*Z990 + Z360*Z1002)*ddq_3l + (Z98*Z1027 - Z81*Z1015 + Z106*Z1039 - Z331*Z980 + Z351*Z991 + Z360*Z1003)*ddq_4l + (Z98*Z1028 - Z81*Z1016 + Z106*Z1040 - Z331*Z981 + Z351*Z992 + Z360*Z1004)*ddq_5l + (Z98*Z1029 - Z81*Z1017 + Z106*Z1041 + Z351*Z993 + Z360*Z1005)*ddq_6l + (Z98*(Z1030 + Z1023*ddq_torso) - Z81*(Z1018 + Z1011*ddq_torso) + Z106*(Z1042 + Z1035*ddq_torso) - Z331*(Z982 + Z976*ddq_torso) + Z351*(Z994 + Z987*ddq_torso) + Z360*(Z1006 + Z999*ddq_torso))
Z2038 = Z98*Z1019 - Z81*Z1007 + Z106*Z1031 - Z331*Z972 + Z351*Z983 + Z360*Z995;
Z2039 = Z98*Z1020 - Z81*Z1008 + Z106*Z1032 - Z331*Z973 + Z351*Z984 + Z360*Z996;
Z2040 = Z98*Z1021 - Z81*Z1009 + Z106*Z1033 - Z331*Z974 + Z351*Z985 + Z360*Z997;
Z2041 = Z98*Z1022 - Z81*Z1010 + Z106*Z1034 - Z331*Z975 + Z351*Z986 + Z360*Z998;
Z2042 = Z98*Z1023 - Z81*Z1011 + Z106*Z1035 - Z331*Z976 + Z351*Z987 + Z360*Z999;
Z2043 = Z98*Z1024 - Z81*Z1012 + Z106*Z1036 - Z331*Z977 + Z351*Z988 + Z360*Z1000;
Z2044 = Z98*Z1025 - Z81*Z1013 + Z106*Z1037 - Z331*Z978 + Z351*Z989 + Z360*Z1001;
Z2045 = Z98*Z1026 - Z81*Z1014 + Z106*Z1038 - Z331*Z979 + Z351*Z990 + Z360*Z1002;
Z2046 = Z98*Z1027 - Z81*Z1015 + Z106*Z1039 - Z331*Z980 + Z351*Z991 + Z360*Z1003;
Z2047 = Z98*Z1028 - Z81*Z1016 + Z106*Z1040 - Z331*Z981 + Z351*Z992 + Z360*Z1004;
Z2048 = Z98*Z1029 - Z81*Z1017 + Z106*Z1041 + Z351*Z993 + Z360*Z1005;
Z2049 = Z98*Z1030 - Z81*Z1018 + Z106*Z1042 - Z331*Z982 + Z351*Z994 + Z360*Z1006;
 
LHS_9l_w = Z2038*ddx+Z2039*ddpsi+Z2040*ddq_imu+Z2041*ddq_w+Z2042*ddq_torso+Z2043*ddq_1l+Z2044*ddq_2l+Z2045*ddq_3l+Z2046*ddq_4l+Z2047*ddq_5l+Z2048*ddq_6l+Z2049;
 
% LHS_10l_w = 
%
%      (Z117*Z1081 - Z98*Z1107 + Z126*Z1094 + Z371*Z1043 - Z351*Z1069 + Z382*Z1056)*ddx + (Z117*Z1082 - Z98*Z1108 + Z126*Z1095 + Z371*Z1044 - Z351*Z1070 + Z382*Z1057)*ddpsi + (Z117*Z1083 - Z98*Z1109 + Z126*Z1096 + Z371*Z1045 - Z351*Z1071 + Z382*Z1058)*ddq_imu + (Z117*Z1084 - Z98*Z1110 + Z126*Z1097 + Z371*Z1046 - Z351*Z1072 + Z382*Z1059)*ddq_w + (Z117*Z1086 - Z98*Z1112 + Z126*Z1099 + Z371*Z1048 - Z351*Z1074 + Z382*Z1061)*ddq_1l + (Z117*Z1087 - Z98*Z1113 + Z126*Z1100 + Z371*Z1049 - Z351*Z1075 + Z382*Z1062)*ddq_2l + (Z117*Z1088 - Z98*Z1114 + Z126*Z1101 + Z371*Z1050 - Z351*Z1076 + Z382*Z1063)*ddq_3l + (Z117*Z1089 - Z98*Z1115 + Z126*Z1102 + Z371*Z1051 - Z351*Z1077 + Z382*Z1064)*ddq_4l + (Z117*Z1090 - Z98*Z1116 + Z126*Z1103 + Z371*Z1052 - Z351*Z1078 + Z382*Z1065)*ddq_5l + (Z117*Z1091 - Z98*Z1117 + Z126*Z1104 + Z371*Z1053 - Z351*Z1079 + Z382*Z1066)*ddq_6l + (Z117*Z1092 - Z98*Z1118 + Z126*Z1105 + Z371*Z1054 + Z382*Z1067)*ddq_7l + (Z117*(Z1093 + Z1085*ddq_torso) - Z98*(Z1119 + Z1111*ddq_torso) + Z126*(Z1106 + Z1098*ddq_torso) + Z371*(Z1055 + Z1047*ddq_torso) - Z351*(Z1080 + Z1073*ddq_torso) + Z382*(Z1068 + Z1060*ddq_torso))
Z2050 = Z117*Z1081 - Z98*Z1107 + Z126*Z1094 + Z371*Z1043 - Z351*Z1069 + Z382*Z1056;
Z2051 = Z117*Z1082 - Z98*Z1108 + Z126*Z1095 + Z371*Z1044 - Z351*Z1070 + Z382*Z1057;
Z2052 = Z117*Z1083 - Z98*Z1109 + Z126*Z1096 + Z371*Z1045 - Z351*Z1071 + Z382*Z1058;
Z2053 = Z117*Z1084 - Z98*Z1110 + Z126*Z1097 + Z371*Z1046 - Z351*Z1072 + Z382*Z1059;
Z2054 = Z117*Z1085 - Z98*Z1111 + Z126*Z1098 + Z371*Z1047 - Z351*Z1073 + Z382*Z1060;
Z2055 = Z117*Z1086 - Z98*Z1112 + Z126*Z1099 + Z371*Z1048 - Z351*Z1074 + Z382*Z1061;
Z2056 = Z117*Z1087 - Z98*Z1113 + Z126*Z1100 + Z371*Z1049 - Z351*Z1075 + Z382*Z1062;
Z2057 = Z117*Z1088 - Z98*Z1114 + Z126*Z1101 + Z371*Z1050 - Z351*Z1076 + Z382*Z1063;
Z2058 = Z117*Z1089 - Z98*Z1115 + Z126*Z1102 + Z371*Z1051 - Z351*Z1077 + Z382*Z1064;
Z2059 = Z117*Z1090 - Z98*Z1116 + Z126*Z1103 + Z371*Z1052 - Z351*Z1078 + Z382*Z1065;
Z2060 = Z117*Z1091 - Z98*Z1117 + Z126*Z1104 + Z371*Z1053 - Z351*Z1079 + Z382*Z1066;
Z2061 = Z117*Z1092 - Z98*Z1118 + Z126*Z1105 + Z371*Z1054 + Z382*Z1067;
Z2062 = Z117*Z1093 - Z98*Z1119 + Z126*Z1106 + Z371*Z1055 - Z351*Z1080 + Z382*Z1068;
 
LHS_10l_w = Z2050*ddx+Z2051*ddpsi+Z2052*ddq_imu+Z2053*ddq_w+Z2054*ddq_torso+Z2055*ddq_1l+Z2056*ddq_2l+Z2057*ddq_3l+Z2058*ddq_4l+Z2059*ddq_5l+Z2060*ddq_6l+Z2061*ddq_7l+Z2062;
 
% LHS_4r_w = 
%
%      (Z138*Z1140 - Z25*Z1147 + Z141*Z1154 + Z396*Z1120 + Z400*Z1127 + Z404*Z1133)*ddx + (Z138*Z1141 - Z25*Z1148 + Z141*Z1155 + Z396*Z1121 + Z400*Z1128 + Z404*Z1134)*ddpsi + (Z138*Z1142 - Z25*Z1149 + Z141*Z1156 + Z396*Z1122 + Z400*Z1129 + Z404*Z1135)*ddq_imu + (Z138*Z1143 - Z25*Z1150 + Z141*Z1157 + Z396*Z1123 + Z400*Z1130 + Z404*Z1136)*ddq_w + (Z138*Z1145 - Z25*Z1152 + Z141*Z1159 + Z396*Z1125 + Z404*Z1138)*ddq_1r + (Z138*(Z1146 + Z1144*ddq_torso) - Z25*(Z1153 + Z1151*ddq_torso) + Z141*(Z1160 + Z1158*ddq_torso) + Z396*(Z1126 + Z1124*ddq_torso) + Z400*(Z1132 + Z1131*ddq_torso) + Z404*(Z1139 + Z1137*ddq_torso))
Z2063 = Z138*Z1140 - Z25*Z1147 + Z141*Z1154 + Z396*Z1120 + Z400*Z1127 + Z404*Z1133;
Z2064 = Z138*Z1141 - Z25*Z1148 + Z141*Z1155 + Z396*Z1121 + Z400*Z1128 + Z404*Z1134;
Z2065 = Z138*Z1142 - Z25*Z1149 + Z141*Z1156 + Z396*Z1122 + Z400*Z1129 + Z404*Z1135;
Z2066 = Z138*Z1143 - Z25*Z1150 + Z141*Z1157 + Z396*Z1123 + Z400*Z1130 + Z404*Z1136;
Z2067 = Z138*Z1144 - Z25*Z1151 + Z141*Z1158 + Z396*Z1124 + Z400*Z1131 + Z404*Z1137;
Z2068 = Z138*Z1145 - Z25*Z1152 + Z141*Z1159 + Z396*Z1125 + Z404*Z1138;
Z2069 = Z138*Z1146 - Z25*Z1153 + Z141*Z1160 + Z396*Z1126 + Z400*Z1132 + Z404*Z1139;
 
LHS_4r_w = Z2063*ddx+Z2064*ddpsi+Z2065*ddq_imu+Z2066*ddq_w+Z2067*ddq_torso+Z2068*ddq_1r+Z2069;
 
% LHS_5r_w = 
%
%      (Z147*Z1185 - Z138*Z1179 + Z151*Z1191 - Z396*Z1161 + Z411*Z1167 + Z416*Z1173)*ddx + (Z147*Z1186 - Z138*Z1180 + Z151*Z1192 - Z396*Z1162 + Z411*Z1168 + Z416*Z1174)*ddpsi + (Z147*Z1187 - Z138*Z1181 + Z151*Z1193 - Z396*Z1163 + Z411*Z1169 + Z416*Z1175)*ddq_imu + (Z147*Z1188 - Z138*Z1182 + Z151*Z1194 - Z396*Z1164 + Z411*Z1170 + Z416*Z1176)*ddq_w + (Z147*(Z1190 + Z1189*ddq_torso) - Z138*(Z1184 + Z1183*ddq_torso) + Z151*(Z1196 + Z1195*ddq_torso) - Z396*(Z1166 + Z1165*ddq_torso) + Z411*(Z1172 + Z1171*ddq_torso) + Z416*(Z1178 + Z1177*ddq_torso))
Z2070 = Z147*Z1185 - Z138*Z1179 + Z151*Z1191 - Z396*Z1161 + Z411*Z1167 + Z416*Z1173;
Z2071 = Z147*Z1186 - Z138*Z1180 + Z151*Z1192 - Z396*Z1162 + Z411*Z1168 + Z416*Z1174;
Z2072 = Z147*Z1187 - Z138*Z1181 + Z151*Z1193 - Z396*Z1163 + Z411*Z1169 + Z416*Z1175;
Z2073 = Z147*Z1188 - Z138*Z1182 + Z151*Z1194 - Z396*Z1164 + Z411*Z1170 + Z416*Z1176;
Z2074 = Z147*Z1189 - Z138*Z1183 + Z151*Z1195 - Z396*Z1165 + Z411*Z1171 + Z416*Z1177;
Z2075 = Z147*Z1190 - Z138*Z1184 + Z151*Z1196 - Z396*Z1166 + Z411*Z1172 + Z416*Z1178;
 
LHS_5r_w = Z2070*ddx+Z2071*ddpsi+Z2072*ddq_imu+Z2073*ddq_w+Z2074*ddq_torso+Z2075;
 
% LHS_6r_w = 
%
%      (Z158*Z1223 - Z147*Z1232 + Z163*Z1241 - Z411*Z1206 + Z423*Z1197 + Z430*Z1214)*ddx + (Z158*Z1224 - Z147*Z1233 + Z163*Z1242 - Z411*Z1207 + Z423*Z1198 + Z430*Z1215)*ddpsi + (Z158*Z1225 - Z147*Z1234 + Z163*Z1243 - Z411*Z1208 + Z423*Z1199 + Z430*Z1216)*ddq_imu + (Z158*Z1226 - Z147*Z1235 + Z163*Z1244 - Z411*Z1209 + Z423*Z1200 + Z430*Z1217)*ddq_w + (Z158*Z1228 - Z147*Z1237 + Z163*Z1246 - Z411*Z1211 + Z423*Z1202 + Z430*Z1219)*ddq_1r + (Z158*Z1229 - Z147*Z1238 + Z163*Z1247 - Z411*Z1212 + Z423*Z1203 + Z430*Z1220)*ddq_2r + (Z158*Z1230 - Z147*Z1239 + Z163*Z1248 + Z423*Z1204 + Z430*Z1221)*ddq_3r + (Z158*(Z1231 + Z1227*ddq_torso) - Z147*(Z1240 + Z1236*ddq_torso) + Z163*(Z1249 + Z1245*ddq_torso) + Z423*(Z1205 + Z1201*ddq_torso) - Z411*(Z1213 + Z1210*ddq_torso) + Z430*(Z1222 + Z1218*ddq_torso))
Z2076 = Z158*Z1223 - Z147*Z1232 + Z163*Z1241 - Z411*Z1206 + Z423*Z1197 + Z430*Z1214;
Z2077 = Z158*Z1224 - Z147*Z1233 + Z163*Z1242 - Z411*Z1207 + Z423*Z1198 + Z430*Z1215;
Z2078 = Z158*Z1225 - Z147*Z1234 + Z163*Z1243 - Z411*Z1208 + Z423*Z1199 + Z430*Z1216;
Z2079 = Z158*Z1226 - Z147*Z1235 + Z163*Z1244 - Z411*Z1209 + Z423*Z1200 + Z430*Z1217;
Z2080 = Z158*Z1227 - Z147*Z1236 + Z163*Z1245 - Z411*Z1210 + Z423*Z1201 + Z430*Z1218;
Z2081 = Z158*Z1228 - Z147*Z1237 + Z163*Z1246 - Z411*Z1211 + Z423*Z1202 + Z430*Z1219;
Z2082 = Z158*Z1229 - Z147*Z1238 + Z163*Z1247 - Z411*Z1212 + Z423*Z1203 + Z430*Z1220;
Z2083 = Z158*Z1230 - Z147*Z1239 + Z163*Z1248 + Z423*Z1204 + Z430*Z1221;
Z2084 = Z158*Z1231 - Z147*Z1240 + Z163*Z1249 - Z411*Z1213 + Z423*Z1205 + Z430*Z1222;
 
LHS_6r_w = Z2076*ddx+Z2077*ddpsi+Z2078*ddq_imu+Z2079*ddq_w+Z2080*ddq_torso+Z2081*ddq_1r+Z2082*ddq_2r+Z2083*ddq_3r+Z2084;
 
% LHS_7r_w = 
%
%      (Z171*Z1289 - Z158*Z1279 + Z177*Z1299 - Z423*Z1250 + Z439*Z1259 + Z446*Z1269)*ddx + (Z171*Z1290 - Z158*Z1280 + Z177*Z1300 - Z423*Z1251 + Z439*Z1260 + Z446*Z1270)*ddpsi + (Z171*Z1291 - Z158*Z1281 + Z177*Z1301 - Z423*Z1252 + Z439*Z1261 + Z446*Z1271)*ddq_imu + (Z171*Z1292 - Z158*Z1282 + Z177*Z1302 - Z423*Z1253 + Z439*Z1262 + Z446*Z1272)*ddq_w + (Z171*Z1294 - Z158*Z1284 + Z177*Z1304 - Z423*Z1255 + Z439*Z1264 + Z446*Z1274)*ddq_1r + (Z171*Z1295 - Z158*Z1285 + Z177*Z1305 - Z423*Z1256 + Z439*Z1265 + Z446*Z1275)*ddq_2r + (Z171*Z1296 - Z158*Z1286 + Z177*Z1306 - Z423*Z1257 + Z439*Z1266 + Z446*Z1276)*ddq_3r + (Z171*Z1297 - Z158*Z1287 + Z177*Z1307 + Z439*Z1267 + Z446*Z1277)*ddq_4r + (Z171*(Z1298 + Z1293*ddq_torso) - Z158*(Z1288 + Z1283*ddq_torso) + Z177*(Z1308 + Z1303*ddq_torso) - Z423*(Z1258 + Z1254*ddq_torso) + Z439*(Z1268 + Z1263*ddq_torso) + Z446*(Z1278 + Z1273*ddq_torso))
Z2085 = Z171*Z1289 - Z158*Z1279 + Z177*Z1299 - Z423*Z1250 + Z439*Z1259 + Z446*Z1269;
Z2086 = Z171*Z1290 - Z158*Z1280 + Z177*Z1300 - Z423*Z1251 + Z439*Z1260 + Z446*Z1270;
Z2087 = Z171*Z1291 - Z158*Z1281 + Z177*Z1301 - Z423*Z1252 + Z439*Z1261 + Z446*Z1271;
Z2088 = Z171*Z1292 - Z158*Z1282 + Z177*Z1302 - Z423*Z1253 + Z439*Z1262 + Z446*Z1272;
Z2089 = Z171*Z1293 - Z158*Z1283 + Z177*Z1303 - Z423*Z1254 + Z439*Z1263 + Z446*Z1273;
Z2090 = Z171*Z1294 - Z158*Z1284 + Z177*Z1304 - Z423*Z1255 + Z439*Z1264 + Z446*Z1274;
Z2091 = Z171*Z1295 - Z158*Z1285 + Z177*Z1305 - Z423*Z1256 + Z439*Z1265 + Z446*Z1275;
Z2092 = Z171*Z1296 - Z158*Z1286 + Z177*Z1306 - Z423*Z1257 + Z439*Z1266 + Z446*Z1276;
Z2093 = Z171*Z1297 - Z158*Z1287 + Z177*Z1307 + Z439*Z1267 + Z446*Z1277;
Z2094 = Z171*Z1298 - Z158*Z1288 + Z177*Z1308 - Z423*Z1258 + Z439*Z1268 + Z446*Z1278;
 
LHS_7r_w = Z2085*ddx+Z2086*ddpsi+Z2087*ddq_imu+Z2088*ddq_w+Z2089*ddq_torso+Z2090*ddq_1r+Z2091*ddq_2r+Z2092*ddq_3r+Z2093*ddq_4r+Z2094;
 
% LHS_8r_w = 
%
%      (Z186*Z1341 - Z171*Z1352 + Z193*Z1363 - Z439*Z1320 + Z455*Z1309 + Z464*Z1330)*ddx + (Z186*Z1342 - Z171*Z1353 + Z193*Z1364 - Z439*Z1321 + Z455*Z1310 + Z464*Z1331)*ddpsi + (Z186*Z1343 - Z171*Z1354 + Z193*Z1365 - Z439*Z1322 + Z455*Z1311 + Z464*Z1332)*ddq_imu + (Z186*Z1344 - Z171*Z1355 + Z193*Z1366 - Z439*Z1323 + Z455*Z1312 + Z464*Z1333)*ddq_w + (Z186*Z1346 - Z171*Z1357 + Z193*Z1368 - Z439*Z1325 + Z455*Z1314 + Z464*Z1335)*ddq_1r + (Z186*Z1347 - Z171*Z1358 + Z193*Z1369 - Z439*Z1326 + Z455*Z1315 + Z464*Z1336)*ddq_2r + (Z186*Z1348 - Z171*Z1359 + Z193*Z1370 - Z439*Z1327 + Z455*Z1316 + Z464*Z1337)*ddq_3r + (Z186*Z1349 - Z171*Z1360 + Z193*Z1371 - Z439*Z1328 + Z455*Z1317 + Z464*Z1338)*ddq_4r + (Z186*Z1350 - Z171*Z1361 + Z193*Z1372 + Z455*Z1318 + Z464*Z1339)*ddq_5r + (Z186*(Z1351 + Z1345*ddq_torso) - Z171*(Z1362 + Z1356*ddq_torso) + Z193*(Z1373 + Z1367*ddq_torso) + Z455*(Z1319 + Z1313*ddq_torso) - Z439*(Z1329 + Z1324*ddq_torso) + Z464*(Z1340 + Z1334*ddq_torso))
Z2095 = Z186*Z1341 - Z171*Z1352 + Z193*Z1363 - Z439*Z1320 + Z455*Z1309 + Z464*Z1330;
Z2096 = Z186*Z1342 - Z171*Z1353 + Z193*Z1364 - Z439*Z1321 + Z455*Z1310 + Z464*Z1331;
Z2097 = Z186*Z1343 - Z171*Z1354 + Z193*Z1365 - Z439*Z1322 + Z455*Z1311 + Z464*Z1332;
Z2098 = Z186*Z1344 - Z171*Z1355 + Z193*Z1366 - Z439*Z1323 + Z455*Z1312 + Z464*Z1333;
Z2099 = Z186*Z1345 - Z171*Z1356 + Z193*Z1367 - Z439*Z1324 + Z455*Z1313 + Z464*Z1334;
Z2100 = Z186*Z1346 - Z171*Z1357 + Z193*Z1368 - Z439*Z1325 + Z455*Z1314 + Z464*Z1335;
Z2101 = Z186*Z1347 - Z171*Z1358 + Z193*Z1369 - Z439*Z1326 + Z455*Z1315 + Z464*Z1336;
Z2102 = Z186*Z1348 - Z171*Z1359 + Z193*Z1370 - Z439*Z1327 + Z455*Z1316 + Z464*Z1337;
Z2103 = Z186*Z1349 - Z171*Z1360 + Z193*Z1371 - Z439*Z1328 + Z455*Z1317 + Z464*Z1338;
Z2104 = Z186*Z1350 - Z171*Z1361 + Z193*Z1372 + Z455*Z1318 + Z464*Z1339;
Z2105 = Z186*Z1351 - Z171*Z1362 + Z193*Z1373 - Z439*Z1329 + Z455*Z1319 + Z464*Z1340;
 
LHS_8r_w = Z2095*ddx+Z2096*ddpsi+Z2097*ddq_imu+Z2098*ddq_w+Z2099*ddq_torso+Z2100*ddq_1r+Z2101*ddq_2r+Z2102*ddq_3r+Z2103*ddq_4r+Z2104*ddq_5r+Z2105;
 
% LHS_9r_w = 
%
%      (Z203*Z1421 - Z186*Z1409 + Z211*Z1433 - Z455*Z1374 + Z475*Z1385 + Z484*Z1397)*ddx + (Z203*Z1422 - Z186*Z1410 + Z211*Z1434 - Z455*Z1375 + Z475*Z1386 + Z484*Z1398)*ddpsi + (Z203*Z1423 - Z186*Z1411 + Z211*Z1435 - Z455*Z1376 + Z475*Z1387 + Z484*Z1399)*ddq_imu + (Z203*Z1424 - Z186*Z1412 + Z211*Z1436 - Z455*Z1377 + Z475*Z1388 + Z484*Z1400)*ddq_w + (Z203*Z1426 - Z186*Z1414 + Z211*Z1438 - Z455*Z1379 + Z475*Z1390 + Z484*Z1402)*ddq_1r + (Z203*Z1427 - Z186*Z1415 + Z211*Z1439 - Z455*Z1380 + Z475*Z1391 + Z484*Z1403)*ddq_2r + (Z203*Z1428 - Z186*Z1416 + Z211*Z1440 - Z455*Z1381 + Z475*Z1392 + Z484*Z1404)*ddq_3r + (Z203*Z1429 - Z186*Z1417 + Z211*Z1441 - Z455*Z1382 + Z475*Z1393 + Z484*Z1405)*ddq_4r + (Z203*Z1430 - Z186*Z1418 + Z211*Z1442 - Z455*Z1383 + Z475*Z1394 + Z484*Z1406)*ddq_5r + (Z203*Z1431 - Z186*Z1419 + Z211*Z1443 + Z475*Z1395 + Z484*Z1407)*ddq_6r + (Z203*(Z1432 + Z1425*ddq_torso) - Z186*(Z1420 + Z1413*ddq_torso) + Z211*(Z1444 + Z1437*ddq_torso) - Z455*(Z1384 + Z1378*ddq_torso) + Z475*(Z1396 + Z1389*ddq_torso) + Z484*(Z1408 + Z1401*ddq_torso))
Z2106 = Z203*Z1421 - Z186*Z1409 + Z211*Z1433 - Z455*Z1374 + Z475*Z1385 + Z484*Z1397;
Z2107 = Z203*Z1422 - Z186*Z1410 + Z211*Z1434 - Z455*Z1375 + Z475*Z1386 + Z484*Z1398;
Z2108 = Z203*Z1423 - Z186*Z1411 + Z211*Z1435 - Z455*Z1376 + Z475*Z1387 + Z484*Z1399;
Z2109 = Z203*Z1424 - Z186*Z1412 + Z211*Z1436 - Z455*Z1377 + Z475*Z1388 + Z484*Z1400;
Z2110 = Z203*Z1425 - Z186*Z1413 + Z211*Z1437 - Z455*Z1378 + Z475*Z1389 + Z484*Z1401;
Z2111 = Z203*Z1426 - Z186*Z1414 + Z211*Z1438 - Z455*Z1379 + Z475*Z1390 + Z484*Z1402;
Z2112 = Z203*Z1427 - Z186*Z1415 + Z211*Z1439 - Z455*Z1380 + Z475*Z1391 + Z484*Z1403;
Z2113 = Z203*Z1428 - Z186*Z1416 + Z211*Z1440 - Z455*Z1381 + Z475*Z1392 + Z484*Z1404;
Z2114 = Z203*Z1429 - Z186*Z1417 + Z211*Z1441 - Z455*Z1382 + Z475*Z1393 + Z484*Z1405;
Z2115 = Z203*Z1430 - Z186*Z1418 + Z211*Z1442 - Z455*Z1383 + Z475*Z1394 + Z484*Z1406;
Z2116 = Z203*Z1431 - Z186*Z1419 + Z211*Z1443 + Z475*Z1395 + Z484*Z1407;
Z2117 = Z203*Z1432 - Z186*Z1420 + Z211*Z1444 - Z455*Z1384 + Z475*Z1396 + Z484*Z1408;
 
LHS_9r_w = Z2106*ddx+Z2107*ddpsi+Z2108*ddq_imu+Z2109*ddq_w+Z2110*ddq_torso+Z2111*ddq_1r+Z2112*ddq_2r+Z2113*ddq_3r+Z2114*ddq_4r+Z2115*ddq_5r+Z2116*ddq_6r+Z2117;
 
% LHS_10r_w = 
%
%      (Z222*Z1483 - Z203*Z1509 + Z231*Z1496 + Z495*Z1445 - Z475*Z1471 + Z506*Z1458)*ddx + (Z222*Z1484 - Z203*Z1510 + Z231*Z1497 + Z495*Z1446 - Z475*Z1472 + Z506*Z1459)*ddpsi + (Z222*Z1485 - Z203*Z1511 + Z231*Z1498 + Z495*Z1447 - Z475*Z1473 + Z506*Z1460)*ddq_imu + (Z222*Z1486 - Z203*Z1512 + Z231*Z1499 + Z495*Z1448 - Z475*Z1474 + Z506*Z1461)*ddq_w + (Z222*Z1488 - Z203*Z1514 + Z231*Z1501 + Z495*Z1450 - Z475*Z1476 + Z506*Z1463)*ddq_1r + (Z222*Z1489 - Z203*Z1515 + Z231*Z1502 + Z495*Z1451 - Z475*Z1477 + Z506*Z1464)*ddq_2r + (Z222*Z1490 - Z203*Z1516 + Z231*Z1503 + Z495*Z1452 - Z475*Z1478 + Z506*Z1465)*ddq_3r + (Z222*Z1491 - Z203*Z1517 + Z231*Z1504 + Z495*Z1453 - Z475*Z1479 + Z506*Z1466)*ddq_4r + (Z222*Z1492 - Z203*Z1518 + Z231*Z1505 + Z495*Z1454 - Z475*Z1480 + Z506*Z1467)*ddq_5r + (Z222*Z1493 - Z203*Z1519 + Z231*Z1506 + Z495*Z1455 - Z475*Z1481 + Z506*Z1468)*ddq_6r + (Z222*Z1494 - Z203*Z1520 + Z231*Z1507 + Z495*Z1456 + Z506*Z1469)*ddq_7r + (Z222*(Z1495 + Z1487*ddq_torso) - Z203*(Z1521 + Z1513*ddq_torso) + Z231*(Z1508 + Z1500*ddq_torso) + Z495*(Z1457 + Z1449*ddq_torso) - Z475*(Z1482 + Z1475*ddq_torso) + Z506*(Z1470 + Z1462*ddq_torso))
Z2118 = Z222*Z1483 - Z203*Z1509 + Z231*Z1496 + Z495*Z1445 - Z475*Z1471 + Z506*Z1458;
Z2119 = Z222*Z1484 - Z203*Z1510 + Z231*Z1497 + Z495*Z1446 - Z475*Z1472 + Z506*Z1459;
Z2120 = Z222*Z1485 - Z203*Z1511 + Z231*Z1498 + Z495*Z1447 - Z475*Z1473 + Z506*Z1460;
Z2121 = Z222*Z1486 - Z203*Z1512 + Z231*Z1499 + Z495*Z1448 - Z475*Z1474 + Z506*Z1461;
Z2122 = Z222*Z1487 - Z203*Z1513 + Z231*Z1500 + Z495*Z1449 - Z475*Z1475 + Z506*Z1462;
Z2123 = Z222*Z1488 - Z203*Z1514 + Z231*Z1501 + Z495*Z1450 - Z475*Z1476 + Z506*Z1463;
Z2124 = Z222*Z1489 - Z203*Z1515 + Z231*Z1502 + Z495*Z1451 - Z475*Z1477 + Z506*Z1464;
Z2125 = Z222*Z1490 - Z203*Z1516 + Z231*Z1503 + Z495*Z1452 - Z475*Z1478 + Z506*Z1465;
Z2126 = Z222*Z1491 - Z203*Z1517 + Z231*Z1504 + Z495*Z1453 - Z475*Z1479 + Z506*Z1466;
Z2127 = Z222*Z1492 - Z203*Z1518 + Z231*Z1505 + Z495*Z1454 - Z475*Z1480 + Z506*Z1467;
Z2128 = Z222*Z1493 - Z203*Z1519 + Z231*Z1506 + Z495*Z1455 - Z475*Z1481 + Z506*Z1468;
Z2129 = Z222*Z1494 - Z203*Z1520 + Z231*Z1507 + Z495*Z1456 + Z506*Z1469;
Z2130 = Z222*Z1495 - Z203*Z1521 + Z231*Z1508 + Z495*Z1457 - Z475*Z1482 + Z506*Z1470;
 
LHS_10r_w = Z2118*ddx+Z2119*ddpsi+Z2120*ddq_imu+Z2121*ddq_w+Z2122*ddq_torso+Z2123*ddq_1r+Z2124*ddq_2r+Z2125*ddq_3r+Z2126*ddq_4r+Z2127*ddq_5r+Z2128*ddq_6r+Z2129*ddq_7r+Z2130;
 
% LHS_L_torso = 
%
%      0
% LHS_R_torso = 
%
%      0
% LHS_1_torso = 
%
%      0
% LHS_2_torso = 
%
%      0
% LHS_3_torso = 
%
%      (-Z695)*ddx + (-Z696)*ddpsi + (-Z697)*ddq_imu + (-Z698)*ddq_w - (Z700 + Z699*ddq_torso)
LHS_3_torso = -Z695*ddx-Z696*ddpsi-Z697*ddq_imu-Z698*ddq_w-Z699*ddq_torso+-Z700;
 
% LHS_4l_torso = 
%
%      (Z34*Z727 + Z37*Z741 + Z273*Z707 + Z281*Z720)*ddx + (Z34*Z728 + Z37*Z742 + Z273*Z708 + Z281*Z721)*ddpsi + (Z34*Z729 + Z37*Z743 + Z273*Z709 + Z281*Z722)*ddq_imu + (Z34*Z730 + Z37*Z744 + Z273*Z710 + Z281*Z723)*ddq_w + (Z34*Z732 + Z37*Z746 + Z273*Z712 + Z281*Z725)*ddq_1l + (Z34*(Z733 + Z731*ddq_torso) + Z37*(Z747 + Z745*ddq_torso) + Z273*(Z713 + Z711*ddq_torso) + Z281*(Z726 + Z724*ddq_torso))
Z2131 = Z34*Z727 + Z37*Z741 + Z273*Z707 + Z281*Z720;
Z2132 = Z34*Z728 + Z37*Z742 + Z273*Z708 + Z281*Z721;
Z2133 = Z34*Z729 + Z37*Z743 + Z273*Z709 + Z281*Z722;
Z2134 = Z34*Z730 + Z37*Z744 + Z273*Z710 + Z281*Z723;
Z2135 = Z34*Z731 + Z37*Z745 + Z273*Z711 + Z281*Z724;
Z2136 = Z34*Z732 + Z37*Z746 + Z273*Z712 + Z281*Z725;
Z2137 = Z34*Z733 + Z37*Z747 + Z273*Z713 + Z281*Z726;
 
LHS_4l_torso = Z2131*ddx+Z2132*ddpsi+Z2133*ddq_imu+Z2134*ddq_w+Z2135*ddq_torso+Z2136*ddq_1l+Z2137;
 
% LHS_5l_torso = 
%
%      (Z43*Z779 - Z34*Z771 + Z47*Z787 - Z273*Z748 + Z288*Z755 + Z293*Z763)*ddx + (Z43*Z780 - Z34*Z772 + Z47*Z788 - Z273*Z749 + Z288*Z756 + Z293*Z764)*ddpsi + (Z43*Z781 - Z34*Z773 + Z47*Z789 - Z273*Z750 + Z288*Z757 + Z293*Z765)*ddq_imu + (Z43*Z782 - Z34*Z774 + Z47*Z790 - Z273*Z751 + Z288*Z758 + Z293*Z766)*ddq_w + (Z43*Z784 - Z34*Z776 + Z47*Z792 - Z273*Z753 + Z288*Z760 + Z293*Z768)*ddq_1l + (Z43*Z785 - Z34*Z777 + Z47*Z793 + Z288*Z761 + Z293*Z769)*ddq_2l + (Z43*(Z786 + Z783*ddq_torso) - Z34*(Z778 + Z775*ddq_torso) + Z47*(Z794 + Z791*ddq_torso) - Z273*(Z754 + Z752*ddq_torso) + Z288*(Z762 + Z759*ddq_torso) + Z293*(Z770 + Z767*ddq_torso))
Z2138 = Z43*Z779 - Z34*Z771 + Z47*Z787 - Z273*Z748 + Z288*Z755 + Z293*Z763;
Z2139 = Z43*Z780 - Z34*Z772 + Z47*Z788 - Z273*Z749 + Z288*Z756 + Z293*Z764;
Z2140 = Z43*Z781 - Z34*Z773 + Z47*Z789 - Z273*Z750 + Z288*Z757 + Z293*Z765;
Z2141 = Z43*Z782 - Z34*Z774 + Z47*Z790 - Z273*Z751 + Z288*Z758 + Z293*Z766;
Z2142 = Z43*Z783 - Z34*Z775 + Z47*Z791 - Z273*Z752 + Z288*Z759 + Z293*Z767;
Z2143 = Z43*Z784 - Z34*Z776 + Z47*Z792 - Z273*Z753 + Z288*Z760 + Z293*Z768;
Z2144 = Z43*Z785 - Z34*Z777 + Z47*Z793 + Z288*Z761 + Z293*Z769;
Z2145 = Z43*Z786 - Z34*Z778 + Z47*Z794 - Z273*Z754 + Z288*Z762 + Z293*Z770;
 
LHS_5l_torso = Z2138*ddx+Z2139*ddpsi+Z2140*ddq_imu+Z2141*ddq_w+Z2142*ddq_torso+Z2143*ddq_1l+Z2144*ddq_2l+Z2145;
 
% LHS_6l_torso = 
%
%      (Z54*Z821 - Z43*Z830 + Z59*Z839 - Z288*Z804 + Z300*Z795 + Z307*Z812)*ddx + (Z54*Z822 - Z43*Z831 + Z59*Z840 - Z288*Z805 + Z300*Z796 + Z307*Z813)*ddpsi + (Z54*Z823 - Z43*Z832 + Z59*Z841 - Z288*Z806 + Z300*Z797 + Z307*Z814)*ddq_imu + (Z54*Z824 - Z43*Z833 + Z59*Z842 - Z288*Z807 + Z300*Z798 + Z307*Z815)*ddq_w + (Z54*Z826 - Z43*Z835 + Z59*Z844 - Z288*Z809 + Z300*Z800 + Z307*Z817)*ddq_1l + (Z54*Z827 - Z43*Z836 + Z59*Z845 - Z288*Z810 + Z300*Z801 + Z307*Z818)*ddq_2l + (Z54*Z828 - Z43*Z837 + Z59*Z846 + Z300*Z802 + Z307*Z819)*ddq_3l + (Z54*(Z829 + Z825*ddq_torso) - Z43*(Z838 + Z834*ddq_torso) + Z59*(Z847 + Z843*ddq_torso) + Z300*(Z803 + Z799*ddq_torso) - Z288*(Z811 + Z808*ddq_torso) + Z307*(Z820 + Z816*ddq_torso))
Z2146 = Z54*Z821 - Z43*Z830 + Z59*Z839 - Z288*Z804 + Z300*Z795 + Z307*Z812;
Z2147 = Z54*Z822 - Z43*Z831 + Z59*Z840 - Z288*Z805 + Z300*Z796 + Z307*Z813;
Z2148 = Z54*Z823 - Z43*Z832 + Z59*Z841 - Z288*Z806 + Z300*Z797 + Z307*Z814;
Z2149 = Z54*Z824 - Z43*Z833 + Z59*Z842 - Z288*Z807 + Z300*Z798 + Z307*Z815;
Z2150 = Z54*Z825 - Z43*Z834 + Z59*Z843 - Z288*Z808 + Z300*Z799 + Z307*Z816;
Z2151 = Z54*Z826 - Z43*Z835 + Z59*Z844 - Z288*Z809 + Z300*Z800 + Z307*Z817;
Z2152 = Z54*Z827 - Z43*Z836 + Z59*Z845 - Z288*Z810 + Z300*Z801 + Z307*Z818;
Z2153 = Z54*Z828 - Z43*Z837 + Z59*Z846 + Z300*Z802 + Z307*Z819;
Z2154 = Z54*Z829 - Z43*Z838 + Z59*Z847 - Z288*Z811 + Z300*Z803 + Z307*Z820;
 
LHS_6l_torso = Z2146*ddx+Z2147*ddpsi+Z2148*ddq_imu+Z2149*ddq_w+Z2150*ddq_torso+Z2151*ddq_1l+Z2152*ddq_2l+Z2153*ddq_3l+Z2154;
 
% LHS_7l_torso = 
%
%      (Z67*Z887 - Z54*Z877 + Z73*Z897 - Z300*Z848 + Z316*Z857 + Z323*Z867)*ddx + (Z67*Z888 - Z54*Z878 + Z73*Z898 - Z300*Z849 + Z316*Z858 + Z323*Z868)*ddpsi + (Z67*Z889 - Z54*Z879 + Z73*Z899 - Z300*Z850 + Z316*Z859 + Z323*Z869)*ddq_imu + (Z67*Z890 - Z54*Z880 + Z73*Z900 - Z300*Z851 + Z316*Z860 + Z323*Z870)*ddq_w + (Z67*Z892 - Z54*Z882 + Z73*Z902 - Z300*Z853 + Z316*Z862 + Z323*Z872)*ddq_1l + (Z67*Z893 - Z54*Z883 + Z73*Z903 - Z300*Z854 + Z316*Z863 + Z323*Z873)*ddq_2l + (Z67*Z894 - Z54*Z884 + Z73*Z904 - Z300*Z855 + Z316*Z864 + Z323*Z874)*ddq_3l + (Z67*Z895 - Z54*Z885 + Z73*Z905 + Z316*Z865 + Z323*Z875)*ddq_4l + (Z67*(Z896 + Z891*ddq_torso) - Z54*(Z886 + Z881*ddq_torso) + Z73*(Z906 + Z901*ddq_torso) - Z300*(Z856 + Z852*ddq_torso) + Z316*(Z866 + Z861*ddq_torso) + Z323*(Z876 + Z871*ddq_torso))
Z2155 = Z67*Z887 - Z54*Z877 + Z73*Z897 - Z300*Z848 + Z316*Z857 + Z323*Z867;
Z2156 = Z67*Z888 - Z54*Z878 + Z73*Z898 - Z300*Z849 + Z316*Z858 + Z323*Z868;
Z2157 = Z67*Z889 - Z54*Z879 + Z73*Z899 - Z300*Z850 + Z316*Z859 + Z323*Z869;
Z2158 = Z67*Z890 - Z54*Z880 + Z73*Z900 - Z300*Z851 + Z316*Z860 + Z323*Z870;
Z2159 = Z67*Z891 - Z54*Z881 + Z73*Z901 - Z300*Z852 + Z316*Z861 + Z323*Z871;
Z2160 = Z67*Z892 - Z54*Z882 + Z73*Z902 - Z300*Z853 + Z316*Z862 + Z323*Z872;
Z2161 = Z67*Z893 - Z54*Z883 + Z73*Z903 - Z300*Z854 + Z316*Z863 + Z323*Z873;
Z2162 = Z67*Z894 - Z54*Z884 + Z73*Z904 - Z300*Z855 + Z316*Z864 + Z323*Z874;
Z2163 = Z67*Z895 - Z54*Z885 + Z73*Z905 + Z316*Z865 + Z323*Z875;
Z2164 = Z67*Z896 - Z54*Z886 + Z73*Z906 - Z300*Z856 + Z316*Z866 + Z323*Z876;
 
LHS_7l_torso = Z2155*ddx+Z2156*ddpsi+Z2157*ddq_imu+Z2158*ddq_w+Z2159*ddq_torso+Z2160*ddq_1l+Z2161*ddq_2l+Z2162*ddq_3l+Z2163*ddq_4l+Z2164;
 
% LHS_8l_torso = 
%
%      (Z82*Z939 - Z67*Z950 + Z89*Z961 - Z316*Z918 + Z332*Z907 + Z341*Z928)*ddx + (Z82*Z940 - Z67*Z951 + Z89*Z962 - Z316*Z919 + Z332*Z908 + Z341*Z929)*ddpsi + (Z82*Z941 - Z67*Z952 + Z89*Z963 - Z316*Z920 + Z332*Z909 + Z341*Z930)*ddq_imu + (Z82*Z942 - Z67*Z953 + Z89*Z964 - Z316*Z921 + Z332*Z910 + Z341*Z931)*ddq_w + (Z82*Z944 - Z67*Z955 + Z89*Z966 - Z316*Z923 + Z332*Z912 + Z341*Z933)*ddq_1l + (Z82*Z945 - Z67*Z956 + Z89*Z967 - Z316*Z924 + Z332*Z913 + Z341*Z934)*ddq_2l + (Z82*Z946 - Z67*Z957 + Z89*Z968 - Z316*Z925 + Z332*Z914 + Z341*Z935)*ddq_3l + (Z82*Z947 - Z67*Z958 + Z89*Z969 - Z316*Z926 + Z332*Z915 + Z341*Z936)*ddq_4l + (Z82*Z948 - Z67*Z959 + Z89*Z970 + Z332*Z916 + Z341*Z937)*ddq_5l + (Z82*(Z949 + Z943*ddq_torso) - Z67*(Z960 + Z954*ddq_torso) + Z89*(Z971 + Z965*ddq_torso) + Z332*(Z917 + Z911*ddq_torso) - Z316*(Z927 + Z922*ddq_torso) + Z341*(Z938 + Z932*ddq_torso))
Z2165 = Z82*Z939 - Z67*Z950 + Z89*Z961 - Z316*Z918 + Z332*Z907 + Z341*Z928;
Z2166 = Z82*Z940 - Z67*Z951 + Z89*Z962 - Z316*Z919 + Z332*Z908 + Z341*Z929;
Z2167 = Z82*Z941 - Z67*Z952 + Z89*Z963 - Z316*Z920 + Z332*Z909 + Z341*Z930;
Z2168 = Z82*Z942 - Z67*Z953 + Z89*Z964 - Z316*Z921 + Z332*Z910 + Z341*Z931;
Z2169 = Z82*Z943 - Z67*Z954 + Z89*Z965 - Z316*Z922 + Z332*Z911 + Z341*Z932;
Z2170 = Z82*Z944 - Z67*Z955 + Z89*Z966 - Z316*Z923 + Z332*Z912 + Z341*Z933;
Z2171 = Z82*Z945 - Z67*Z956 + Z89*Z967 - Z316*Z924 + Z332*Z913 + Z341*Z934;
Z2172 = Z82*Z946 - Z67*Z957 + Z89*Z968 - Z316*Z925 + Z332*Z914 + Z341*Z935;
Z2173 = Z82*Z947 - Z67*Z958 + Z89*Z969 - Z316*Z926 + Z332*Z915 + Z341*Z936;
Z2174 = Z82*Z948 - Z67*Z959 + Z89*Z970 + Z332*Z916 + Z341*Z937;
Z2175 = Z82*Z949 - Z67*Z960 + Z89*Z971 - Z316*Z927 + Z332*Z917 + Z341*Z938;
 
LHS_8l_torso = Z2165*ddx+Z2166*ddpsi+Z2167*ddq_imu+Z2168*ddq_w+Z2169*ddq_torso+Z2170*ddq_1l+Z2171*ddq_2l+Z2172*ddq_3l+Z2173*ddq_4l+Z2174*ddq_5l+Z2175;
 
% LHS_9l_torso = 
%
%      (Z99*Z1019 - Z82*Z1007 + Z107*Z1031 - Z332*Z972 + Z352*Z983 + Z361*Z995)*ddx + (Z99*Z1020 - Z82*Z1008 + Z107*Z1032 - Z332*Z973 + Z352*Z984 + Z361*Z996)*ddpsi + (Z99*Z1021 - Z82*Z1009 + Z107*Z1033 - Z332*Z974 + Z352*Z985 + Z361*Z997)*ddq_imu + (Z99*Z1022 - Z82*Z1010 + Z107*Z1034 - Z332*Z975 + Z352*Z986 + Z361*Z998)*ddq_w + (Z99*Z1024 - Z82*Z1012 + Z107*Z1036 - Z332*Z977 + Z352*Z988 + Z361*Z1000)*ddq_1l + (Z99*Z1025 - Z82*Z1013 + Z107*Z1037 - Z332*Z978 + Z352*Z989 + Z361*Z1001)*ddq_2l + (Z99*Z1026 - Z82*Z1014 + Z107*Z1038 - Z332*Z979 + Z352*Z990 + Z361*Z1002)*ddq_3l + (Z99*Z1027 - Z82*Z1015 + Z107*Z1039 - Z332*Z980 + Z352*Z991 + Z361*Z1003)*ddq_4l + (Z99*Z1028 - Z82*Z1016 + Z107*Z1040 - Z332*Z981 + Z352*Z992 + Z361*Z1004)*ddq_5l + (Z99*Z1029 - Z82*Z1017 + Z107*Z1041 + Z352*Z993 + Z361*Z1005)*ddq_6l + (Z99*(Z1030 + Z1023*ddq_torso) - Z82*(Z1018 + Z1011*ddq_torso) + Z107*(Z1042 + Z1035*ddq_torso) - Z332*(Z982 + Z976*ddq_torso) + Z352*(Z994 + Z987*ddq_torso) + Z361*(Z1006 + Z999*ddq_torso))
Z2176 = Z99*Z1019 - Z82*Z1007 + Z107*Z1031 - Z332*Z972 + Z352*Z983 + Z361*Z995;
Z2177 = Z99*Z1020 - Z82*Z1008 + Z107*Z1032 - Z332*Z973 + Z352*Z984 + Z361*Z996;
Z2178 = Z99*Z1021 - Z82*Z1009 + Z107*Z1033 - Z332*Z974 + Z352*Z985 + Z361*Z997;
Z2179 = Z99*Z1022 - Z82*Z1010 + Z107*Z1034 - Z332*Z975 + Z352*Z986 + Z361*Z998;
Z2180 = Z99*Z1023 - Z82*Z1011 + Z107*Z1035 - Z332*Z976 + Z352*Z987 + Z361*Z999;
Z2181 = Z99*Z1024 - Z82*Z1012 + Z107*Z1036 - Z332*Z977 + Z352*Z988 + Z361*Z1000;
Z2182 = Z99*Z1025 - Z82*Z1013 + Z107*Z1037 - Z332*Z978 + Z352*Z989 + Z361*Z1001;
Z2183 = Z99*Z1026 - Z82*Z1014 + Z107*Z1038 - Z332*Z979 + Z352*Z990 + Z361*Z1002;
Z2184 = Z99*Z1027 - Z82*Z1015 + Z107*Z1039 - Z332*Z980 + Z352*Z991 + Z361*Z1003;
Z2185 = Z99*Z1028 - Z82*Z1016 + Z107*Z1040 - Z332*Z981 + Z352*Z992 + Z361*Z1004;
Z2186 = Z99*Z1029 - Z82*Z1017 + Z107*Z1041 + Z352*Z993 + Z361*Z1005;
Z2187 = Z99*Z1030 - Z82*Z1018 + Z107*Z1042 - Z332*Z982 + Z352*Z994 + Z361*Z1006;
 
LHS_9l_torso = Z2176*ddx+Z2177*ddpsi+Z2178*ddq_imu+Z2179*ddq_w+Z2180*ddq_torso+Z2181*ddq_1l+Z2182*ddq_2l+Z2183*ddq_3l+Z2184*ddq_4l+Z2185*ddq_5l+Z2186*ddq_6l+Z2187;
 
% LHS_10l_torso = 
%
%      (Z118*Z1081 - Z99*Z1107 + Z127*Z1094 + Z372*Z1043 - Z352*Z1069 + Z383*Z1056)*ddx + (Z118*Z1082 - Z99*Z1108 + Z127*Z1095 + Z372*Z1044 - Z352*Z1070 + Z383*Z1057)*ddpsi + (Z118*Z1083 - Z99*Z1109 + Z127*Z1096 + Z372*Z1045 - Z352*Z1071 + Z383*Z1058)*ddq_imu + (Z118*Z1084 - Z99*Z1110 + Z127*Z1097 + Z372*Z1046 - Z352*Z1072 + Z383*Z1059)*ddq_w + (Z118*Z1086 - Z99*Z1112 + Z127*Z1099 + Z372*Z1048 - Z352*Z1074 + Z383*Z1061)*ddq_1l + (Z118*Z1087 - Z99*Z1113 + Z127*Z1100 + Z372*Z1049 - Z352*Z1075 + Z383*Z1062)*ddq_2l + (Z118*Z1088 - Z99*Z1114 + Z127*Z1101 + Z372*Z1050 - Z352*Z1076 + Z383*Z1063)*ddq_3l + (Z118*Z1089 - Z99*Z1115 + Z127*Z1102 + Z372*Z1051 - Z352*Z1077 + Z383*Z1064)*ddq_4l + (Z118*Z1090 - Z99*Z1116 + Z127*Z1103 + Z372*Z1052 - Z352*Z1078 + Z383*Z1065)*ddq_5l + (Z118*Z1091 - Z99*Z1117 + Z127*Z1104 + Z372*Z1053 - Z352*Z1079 + Z383*Z1066)*ddq_6l + (Z118*Z1092 - Z99*Z1118 + Z127*Z1105 + Z372*Z1054 + Z383*Z1067)*ddq_7l + (Z118*(Z1093 + Z1085*ddq_torso) - Z99*(Z1119 + Z1111*ddq_torso) + Z127*(Z1106 + Z1098*ddq_torso) + Z372*(Z1055 + Z1047*ddq_torso) - Z352*(Z1080 + Z1073*ddq_torso) + Z383*(Z1068 + Z1060*ddq_torso))
Z2188 = Z118*Z1081 - Z99*Z1107 + Z127*Z1094 + Z372*Z1043 - Z352*Z1069 + Z383*Z1056;
Z2189 = Z118*Z1082 - Z99*Z1108 + Z127*Z1095 + Z372*Z1044 - Z352*Z1070 + Z383*Z1057;
Z2190 = Z118*Z1083 - Z99*Z1109 + Z127*Z1096 + Z372*Z1045 - Z352*Z1071 + Z383*Z1058;
Z2191 = Z118*Z1084 - Z99*Z1110 + Z127*Z1097 + Z372*Z1046 - Z352*Z1072 + Z383*Z1059;
Z2192 = Z118*Z1085 - Z99*Z1111 + Z127*Z1098 + Z372*Z1047 - Z352*Z1073 + Z383*Z1060;
Z2193 = Z118*Z1086 - Z99*Z1112 + Z127*Z1099 + Z372*Z1048 - Z352*Z1074 + Z383*Z1061;
Z2194 = Z118*Z1087 - Z99*Z1113 + Z127*Z1100 + Z372*Z1049 - Z352*Z1075 + Z383*Z1062;
Z2195 = Z118*Z1088 - Z99*Z1114 + Z127*Z1101 + Z372*Z1050 - Z352*Z1076 + Z383*Z1063;
Z2196 = Z118*Z1089 - Z99*Z1115 + Z127*Z1102 + Z372*Z1051 - Z352*Z1077 + Z383*Z1064;
Z2197 = Z118*Z1090 - Z99*Z1116 + Z127*Z1103 + Z372*Z1052 - Z352*Z1078 + Z383*Z1065;
Z2198 = Z118*Z1091 - Z99*Z1117 + Z127*Z1104 + Z372*Z1053 - Z352*Z1079 + Z383*Z1066;
Z2199 = Z118*Z1092 - Z99*Z1118 + Z127*Z1105 + Z372*Z1054 + Z383*Z1067;
Z2200 = Z118*Z1093 - Z99*Z1119 + Z127*Z1106 + Z372*Z1055 - Z352*Z1080 + Z383*Z1068;
 
LHS_10l_torso = Z2188*ddx+Z2189*ddpsi+Z2190*ddq_imu+Z2191*ddq_w+Z2192*ddq_torso+Z2193*ddq_1l+Z2194*ddq_2l+Z2195*ddq_3l+Z2196*ddq_4l+Z2197*ddq_5l+Z2198*ddq_6l+Z2199*ddq_7l+Z2200;
 
% LHS_4r_torso = 
%
%      (Z139*Z1140 + Z142*Z1154 + Z397*Z1120 + Z405*Z1133)*ddx + (Z139*Z1141 + Z142*Z1155 + Z397*Z1121 + Z405*Z1134)*ddpsi + (Z139*Z1142 + Z142*Z1156 + Z397*Z1122 + Z405*Z1135)*ddq_imu + (Z139*Z1143 + Z142*Z1157 + Z397*Z1123 + Z405*Z1136)*ddq_w + (Z139*Z1145 + Z142*Z1159 + Z397*Z1125 + Z405*Z1138)*ddq_1r + (Z139*(Z1146 + Z1144*ddq_torso) + Z142*(Z1160 + Z1158*ddq_torso) + Z397*(Z1126 + Z1124*ddq_torso) + Z405*(Z1139 + Z1137*ddq_torso))
Z2201 = Z139*Z1140 + Z142*Z1154 + Z397*Z1120 + Z405*Z1133;
Z2202 = Z139*Z1141 + Z142*Z1155 + Z397*Z1121 + Z405*Z1134;
Z2203 = Z139*Z1142 + Z142*Z1156 + Z397*Z1122 + Z405*Z1135;
Z2204 = Z139*Z1143 + Z142*Z1157 + Z397*Z1123 + Z405*Z1136;
Z2205 = Z139*Z1144 + Z142*Z1158 + Z397*Z1124 + Z405*Z1137;
Z2206 = Z139*Z1145 + Z142*Z1159 + Z397*Z1125 + Z405*Z1138;
Z2207 = Z139*Z1146 + Z142*Z1160 + Z397*Z1126 + Z405*Z1139;
 
LHS_4r_torso = Z2201*ddx+Z2202*ddpsi+Z2203*ddq_imu+Z2204*ddq_w+Z2205*ddq_torso+Z2206*ddq_1r+Z2207;
 
% LHS_5r_torso = 
%
%      (Z148*Z1185 - Z139*Z1179 + Z152*Z1191 - Z397*Z1161 + Z412*Z1167 + Z417*Z1173)*ddx + (Z148*Z1186 - Z139*Z1180 + Z152*Z1192 - Z397*Z1162 + Z412*Z1168 + Z417*Z1174)*ddpsi + (Z148*Z1187 - Z139*Z1181 + Z152*Z1193 - Z397*Z1163 + Z412*Z1169 + Z417*Z1175)*ddq_imu + (Z148*Z1188 - Z139*Z1182 + Z152*Z1194 - Z397*Z1164 + Z412*Z1170 + Z417*Z1176)*ddq_w + (Z148*(Z1190 + Z1189*ddq_torso) - Z139*(Z1184 + Z1183*ddq_torso) + Z152*(Z1196 + Z1195*ddq_torso) - Z397*(Z1166 + Z1165*ddq_torso) + Z412*(Z1172 + Z1171*ddq_torso) + Z417*(Z1178 + Z1177*ddq_torso))
Z2208 = Z148*Z1185 - Z139*Z1179 + Z152*Z1191 - Z397*Z1161 + Z412*Z1167 + Z417*Z1173;
Z2209 = Z148*Z1186 - Z139*Z1180 + Z152*Z1192 - Z397*Z1162 + Z412*Z1168 + Z417*Z1174;
Z2210 = Z148*Z1187 - Z139*Z1181 + Z152*Z1193 - Z397*Z1163 + Z412*Z1169 + Z417*Z1175;
Z2211 = Z148*Z1188 - Z139*Z1182 + Z152*Z1194 - Z397*Z1164 + Z412*Z1170 + Z417*Z1176;
Z2212 = Z148*Z1189 - Z139*Z1183 + Z152*Z1195 - Z397*Z1165 + Z412*Z1171 + Z417*Z1177;
Z2213 = Z148*Z1190 - Z139*Z1184 + Z152*Z1196 - Z397*Z1166 + Z412*Z1172 + Z417*Z1178;
 
LHS_5r_torso = Z2208*ddx+Z2209*ddpsi+Z2210*ddq_imu+Z2211*ddq_w+Z2212*ddq_torso+Z2213;
 
% LHS_6r_torso = 
%
%      (Z159*Z1223 - Z148*Z1232 + Z164*Z1241 - Z412*Z1206 + Z424*Z1197 + Z431*Z1214)*ddx + (Z159*Z1224 - Z148*Z1233 + Z164*Z1242 - Z412*Z1207 + Z424*Z1198 + Z431*Z1215)*ddpsi + (Z159*Z1225 - Z148*Z1234 + Z164*Z1243 - Z412*Z1208 + Z424*Z1199 + Z431*Z1216)*ddq_imu + (Z159*Z1226 - Z148*Z1235 + Z164*Z1244 - Z412*Z1209 + Z424*Z1200 + Z431*Z1217)*ddq_w + (Z159*Z1228 - Z148*Z1237 + Z164*Z1246 - Z412*Z1211 + Z424*Z1202 + Z431*Z1219)*ddq_1r + (Z159*Z1229 - Z148*Z1238 + Z164*Z1247 - Z412*Z1212 + Z424*Z1203 + Z431*Z1220)*ddq_2r + (Z159*Z1230 - Z148*Z1239 + Z164*Z1248 + Z424*Z1204 + Z431*Z1221)*ddq_3r + (Z159*(Z1231 + Z1227*ddq_torso) - Z148*(Z1240 + Z1236*ddq_torso) + Z164*(Z1249 + Z1245*ddq_torso) + Z424*(Z1205 + Z1201*ddq_torso) - Z412*(Z1213 + Z1210*ddq_torso) + Z431*(Z1222 + Z1218*ddq_torso))
Z2214 = Z159*Z1223 - Z148*Z1232 + Z164*Z1241 - Z412*Z1206 + Z424*Z1197 + Z431*Z1214;
Z2215 = Z159*Z1224 - Z148*Z1233 + Z164*Z1242 - Z412*Z1207 + Z424*Z1198 + Z431*Z1215;
Z2216 = Z159*Z1225 - Z148*Z1234 + Z164*Z1243 - Z412*Z1208 + Z424*Z1199 + Z431*Z1216;
Z2217 = Z159*Z1226 - Z148*Z1235 + Z164*Z1244 - Z412*Z1209 + Z424*Z1200 + Z431*Z1217;
Z2218 = Z159*Z1227 - Z148*Z1236 + Z164*Z1245 - Z412*Z1210 + Z424*Z1201 + Z431*Z1218;
Z2219 = Z159*Z1228 - Z148*Z1237 + Z164*Z1246 - Z412*Z1211 + Z424*Z1202 + Z431*Z1219;
Z2220 = Z159*Z1229 - Z148*Z1238 + Z164*Z1247 - Z412*Z1212 + Z424*Z1203 + Z431*Z1220;
Z2221 = Z159*Z1230 - Z148*Z1239 + Z164*Z1248 + Z424*Z1204 + Z431*Z1221;
Z2222 = Z159*Z1231 - Z148*Z1240 + Z164*Z1249 - Z412*Z1213 + Z424*Z1205 + Z431*Z1222;
 
LHS_6r_torso = Z2214*ddx+Z2215*ddpsi+Z2216*ddq_imu+Z2217*ddq_w+Z2218*ddq_torso+Z2219*ddq_1r+Z2220*ddq_2r+Z2221*ddq_3r+Z2222;
 
% LHS_7r_torso = 
%
%      (Z172*Z1289 - Z159*Z1279 + Z178*Z1299 - Z424*Z1250 + Z440*Z1259 + Z447*Z1269)*ddx + (Z172*Z1290 - Z159*Z1280 + Z178*Z1300 - Z424*Z1251 + Z440*Z1260 + Z447*Z1270)*ddpsi + (Z172*Z1291 - Z159*Z1281 + Z178*Z1301 - Z424*Z1252 + Z440*Z1261 + Z447*Z1271)*ddq_imu + (Z172*Z1292 - Z159*Z1282 + Z178*Z1302 - Z424*Z1253 + Z440*Z1262 + Z447*Z1272)*ddq_w + (Z172*Z1294 - Z159*Z1284 + Z178*Z1304 - Z424*Z1255 + Z440*Z1264 + Z447*Z1274)*ddq_1r + (Z172*Z1295 - Z159*Z1285 + Z178*Z1305 - Z424*Z1256 + Z440*Z1265 + Z447*Z1275)*ddq_2r + (Z172*Z1296 - Z159*Z1286 + Z178*Z1306 - Z424*Z1257 + Z440*Z1266 + Z447*Z1276)*ddq_3r + (Z172*Z1297 - Z159*Z1287 + Z178*Z1307 + Z440*Z1267 + Z447*Z1277)*ddq_4r + (Z172*(Z1298 + Z1293*ddq_torso) - Z159*(Z1288 + Z1283*ddq_torso) + Z178*(Z1308 + Z1303*ddq_torso) - Z424*(Z1258 + Z1254*ddq_torso) + Z440*(Z1268 + Z1263*ddq_torso) + Z447*(Z1278 + Z1273*ddq_torso))
Z2223 = Z172*Z1289 - Z159*Z1279 + Z178*Z1299 - Z424*Z1250 + Z440*Z1259 + Z447*Z1269;
Z2224 = Z172*Z1290 - Z159*Z1280 + Z178*Z1300 - Z424*Z1251 + Z440*Z1260 + Z447*Z1270;
Z2225 = Z172*Z1291 - Z159*Z1281 + Z178*Z1301 - Z424*Z1252 + Z440*Z1261 + Z447*Z1271;
Z2226 = Z172*Z1292 - Z159*Z1282 + Z178*Z1302 - Z424*Z1253 + Z440*Z1262 + Z447*Z1272;
Z2227 = Z172*Z1293 - Z159*Z1283 + Z178*Z1303 - Z424*Z1254 + Z440*Z1263 + Z447*Z1273;
Z2228 = Z172*Z1294 - Z159*Z1284 + Z178*Z1304 - Z424*Z1255 + Z440*Z1264 + Z447*Z1274;
Z2229 = Z172*Z1295 - Z159*Z1285 + Z178*Z1305 - Z424*Z1256 + Z440*Z1265 + Z447*Z1275;
Z2230 = Z172*Z1296 - Z159*Z1286 + Z178*Z1306 - Z424*Z1257 + Z440*Z1266 + Z447*Z1276;
Z2231 = Z172*Z1297 - Z159*Z1287 + Z178*Z1307 + Z440*Z1267 + Z447*Z1277;
Z2232 = Z172*Z1298 - Z159*Z1288 + Z178*Z1308 - Z424*Z1258 + Z440*Z1268 + Z447*Z1278;
 
LHS_7r_torso = Z2223*ddx+Z2224*ddpsi+Z2225*ddq_imu+Z2226*ddq_w+Z2227*ddq_torso+Z2228*ddq_1r+Z2229*ddq_2r+Z2230*ddq_3r+Z2231*ddq_4r+Z2232;
 
% LHS_8r_torso = 
%
%      (Z187*Z1341 - Z172*Z1352 + Z194*Z1363 - Z440*Z1320 + Z456*Z1309 + Z465*Z1330)*ddx + (Z187*Z1342 - Z172*Z1353 + Z194*Z1364 - Z440*Z1321 + Z456*Z1310 + Z465*Z1331)*ddpsi + (Z187*Z1343 - Z172*Z1354 + Z194*Z1365 - Z440*Z1322 + Z456*Z1311 + Z465*Z1332)*ddq_imu + (Z187*Z1344 - Z172*Z1355 + Z194*Z1366 - Z440*Z1323 + Z456*Z1312 + Z465*Z1333)*ddq_w + (Z187*Z1346 - Z172*Z1357 + Z194*Z1368 - Z440*Z1325 + Z456*Z1314 + Z465*Z1335)*ddq_1r + (Z187*Z1347 - Z172*Z1358 + Z194*Z1369 - Z440*Z1326 + Z456*Z1315 + Z465*Z1336)*ddq_2r + (Z187*Z1348 - Z172*Z1359 + Z194*Z1370 - Z440*Z1327 + Z456*Z1316 + Z465*Z1337)*ddq_3r + (Z187*Z1349 - Z172*Z1360 + Z194*Z1371 - Z440*Z1328 + Z456*Z1317 + Z465*Z1338)*ddq_4r + (Z187*Z1350 - Z172*Z1361 + Z194*Z1372 + Z456*Z1318 + Z465*Z1339)*ddq_5r + (Z187*(Z1351 + Z1345*ddq_torso) - Z172*(Z1362 + Z1356*ddq_torso) + Z194*(Z1373 + Z1367*ddq_torso) + Z456*(Z1319 + Z1313*ddq_torso) - Z440*(Z1329 + Z1324*ddq_torso) + Z465*(Z1340 + Z1334*ddq_torso))
Z2233 = Z187*Z1341 - Z172*Z1352 + Z194*Z1363 - Z440*Z1320 + Z456*Z1309 + Z465*Z1330;
Z2234 = Z187*Z1342 - Z172*Z1353 + Z194*Z1364 - Z440*Z1321 + Z456*Z1310 + Z465*Z1331;
Z2235 = Z187*Z1343 - Z172*Z1354 + Z194*Z1365 - Z440*Z1322 + Z456*Z1311 + Z465*Z1332;
Z2236 = Z187*Z1344 - Z172*Z1355 + Z194*Z1366 - Z440*Z1323 + Z456*Z1312 + Z465*Z1333;
Z2237 = Z187*Z1345 - Z172*Z1356 + Z194*Z1367 - Z440*Z1324 + Z456*Z1313 + Z465*Z1334;
Z2238 = Z187*Z1346 - Z172*Z1357 + Z194*Z1368 - Z440*Z1325 + Z456*Z1314 + Z465*Z1335;
Z2239 = Z187*Z1347 - Z172*Z1358 + Z194*Z1369 - Z440*Z1326 + Z456*Z1315 + Z465*Z1336;
Z2240 = Z187*Z1348 - Z172*Z1359 + Z194*Z1370 - Z440*Z1327 + Z456*Z1316 + Z465*Z1337;
Z2241 = Z187*Z1349 - Z172*Z1360 + Z194*Z1371 - Z440*Z1328 + Z456*Z1317 + Z465*Z1338;
Z2242 = Z187*Z1350 - Z172*Z1361 + Z194*Z1372 + Z456*Z1318 + Z465*Z1339;
Z2243 = Z187*Z1351 - Z172*Z1362 + Z194*Z1373 - Z440*Z1329 + Z456*Z1319 + Z465*Z1340;
 
LHS_8r_torso = Z2233*ddx+Z2234*ddpsi+Z2235*ddq_imu+Z2236*ddq_w+Z2237*ddq_torso+Z2238*ddq_1r+Z2239*ddq_2r+Z2240*ddq_3r+Z2241*ddq_4r+Z2242*ddq_5r+Z2243;
 
% LHS_9r_torso = 
%
%      (Z204*Z1421 - Z187*Z1409 + Z212*Z1433 - Z456*Z1374 + Z476*Z1385 + Z485*Z1397)*ddx + (Z204*Z1422 - Z187*Z1410 + Z212*Z1434 - Z456*Z1375 + Z476*Z1386 + Z485*Z1398)*ddpsi + (Z204*Z1423 - Z187*Z1411 + Z212*Z1435 - Z456*Z1376 + Z476*Z1387 + Z485*Z1399)*ddq_imu + (Z204*Z1424 - Z187*Z1412 + Z212*Z1436 - Z456*Z1377 + Z476*Z1388 + Z485*Z1400)*ddq_w + (Z204*Z1426 - Z187*Z1414 + Z212*Z1438 - Z456*Z1379 + Z476*Z1390 + Z485*Z1402)*ddq_1r + (Z204*Z1427 - Z187*Z1415 + Z212*Z1439 - Z456*Z1380 + Z476*Z1391 + Z485*Z1403)*ddq_2r + (Z204*Z1428 - Z187*Z1416 + Z212*Z1440 - Z456*Z1381 + Z476*Z1392 + Z485*Z1404)*ddq_3r + (Z204*Z1429 - Z187*Z1417 + Z212*Z1441 - Z456*Z1382 + Z476*Z1393 + Z485*Z1405)*ddq_4r + (Z204*Z1430 - Z187*Z1418 + Z212*Z1442 - Z456*Z1383 + Z476*Z1394 + Z485*Z1406)*ddq_5r + (Z204*Z1431 - Z187*Z1419 + Z212*Z1443 + Z476*Z1395 + Z485*Z1407)*ddq_6r + (Z204*(Z1432 + Z1425*ddq_torso) - Z187*(Z1420 + Z1413*ddq_torso) + Z212*(Z1444 + Z1437*ddq_torso) - Z456*(Z1384 + Z1378*ddq_torso) + Z476*(Z1396 + Z1389*ddq_torso) + Z485*(Z1408 + Z1401*ddq_torso))
Z2244 = Z204*Z1421 - Z187*Z1409 + Z212*Z1433 - Z456*Z1374 + Z476*Z1385 + Z485*Z1397;
Z2245 = Z204*Z1422 - Z187*Z1410 + Z212*Z1434 - Z456*Z1375 + Z476*Z1386 + Z485*Z1398;
Z2246 = Z204*Z1423 - Z187*Z1411 + Z212*Z1435 - Z456*Z1376 + Z476*Z1387 + Z485*Z1399;
Z2247 = Z204*Z1424 - Z187*Z1412 + Z212*Z1436 - Z456*Z1377 + Z476*Z1388 + Z485*Z1400;
Z2248 = Z204*Z1425 - Z187*Z1413 + Z212*Z1437 - Z456*Z1378 + Z476*Z1389 + Z485*Z1401;
Z2249 = Z204*Z1426 - Z187*Z1414 + Z212*Z1438 - Z456*Z1379 + Z476*Z1390 + Z485*Z1402;
Z2250 = Z204*Z1427 - Z187*Z1415 + Z212*Z1439 - Z456*Z1380 + Z476*Z1391 + Z485*Z1403;
Z2251 = Z204*Z1428 - Z187*Z1416 + Z212*Z1440 - Z456*Z1381 + Z476*Z1392 + Z485*Z1404;
Z2252 = Z204*Z1429 - Z187*Z1417 + Z212*Z1441 - Z456*Z1382 + Z476*Z1393 + Z485*Z1405;
Z2253 = Z204*Z1430 - Z187*Z1418 + Z212*Z1442 - Z456*Z1383 + Z476*Z1394 + Z485*Z1406;
Z2254 = Z204*Z1431 - Z187*Z1419 + Z212*Z1443 + Z476*Z1395 + Z485*Z1407;
Z2255 = Z204*Z1432 - Z187*Z1420 + Z212*Z1444 - Z456*Z1384 + Z476*Z1396 + Z485*Z1408;
 
LHS_9r_torso = Z2244*ddx+Z2245*ddpsi+Z2246*ddq_imu+Z2247*ddq_w+Z2248*ddq_torso+Z2249*ddq_1r+Z2250*ddq_2r+Z2251*ddq_3r+Z2252*ddq_4r+Z2253*ddq_5r+Z2254*ddq_6r+Z2255;
 
% LHS_10r_torso = 
%
%      (Z223*Z1483 - Z204*Z1509 + Z232*Z1496 + Z496*Z1445 - Z476*Z1471 + Z507*Z1458)*ddx + (Z223*Z1484 - Z204*Z1510 + Z232*Z1497 + Z496*Z1446 - Z476*Z1472 + Z507*Z1459)*ddpsi + (Z223*Z1485 - Z204*Z1511 + Z232*Z1498 + Z496*Z1447 - Z476*Z1473 + Z507*Z1460)*ddq_imu + (Z223*Z1486 - Z204*Z1512 + Z232*Z1499 + Z496*Z1448 - Z476*Z1474 + Z507*Z1461)*ddq_w + (Z223*Z1488 - Z204*Z1514 + Z232*Z1501 + Z496*Z1450 - Z476*Z1476 + Z507*Z1463)*ddq_1r + (Z223*Z1489 - Z204*Z1515 + Z232*Z1502 + Z496*Z1451 - Z476*Z1477 + Z507*Z1464)*ddq_2r + (Z223*Z1490 - Z204*Z1516 + Z232*Z1503 + Z496*Z1452 - Z476*Z1478 + Z507*Z1465)*ddq_3r + (Z223*Z1491 - Z204*Z1517 + Z232*Z1504 + Z496*Z1453 - Z476*Z1479 + Z507*Z1466)*ddq_4r + (Z223*Z1492 - Z204*Z1518 + Z232*Z1505 + Z496*Z1454 - Z476*Z1480 + Z507*Z1467)*ddq_5r + (Z223*Z1493 - Z204*Z1519 + Z232*Z1506 + Z496*Z1455 - Z476*Z1481 + Z507*Z1468)*ddq_6r + (Z223*Z1494 - Z204*Z1520 + Z232*Z1507 + Z496*Z1456 + Z507*Z1469)*ddq_7r + (Z223*(Z1495 + Z1487*ddq_torso) - Z204*(Z1521 + Z1513*ddq_torso) + Z232*(Z1508 + Z1500*ddq_torso) + Z496*(Z1457 + Z1449*ddq_torso) - Z476*(Z1482 + Z1475*ddq_torso) + Z507*(Z1470 + Z1462*ddq_torso))
Z2256 = Z223*Z1483 - Z204*Z1509 + Z232*Z1496 + Z496*Z1445 - Z476*Z1471 + Z507*Z1458;
Z2257 = Z223*Z1484 - Z204*Z1510 + Z232*Z1497 + Z496*Z1446 - Z476*Z1472 + Z507*Z1459;
Z2258 = Z223*Z1485 - Z204*Z1511 + Z232*Z1498 + Z496*Z1447 - Z476*Z1473 + Z507*Z1460;
Z2259 = Z223*Z1486 - Z204*Z1512 + Z232*Z1499 + Z496*Z1448 - Z476*Z1474 + Z507*Z1461;
Z2260 = Z223*Z1487 - Z204*Z1513 + Z232*Z1500 + Z496*Z1449 - Z476*Z1475 + Z507*Z1462;
Z2261 = Z223*Z1488 - Z204*Z1514 + Z232*Z1501 + Z496*Z1450 - Z476*Z1476 + Z507*Z1463;
Z2262 = Z223*Z1489 - Z204*Z1515 + Z232*Z1502 + Z496*Z1451 - Z476*Z1477 + Z507*Z1464;
Z2263 = Z223*Z1490 - Z204*Z1516 + Z232*Z1503 + Z496*Z1452 - Z476*Z1478 + Z507*Z1465;
Z2264 = Z223*Z1491 - Z204*Z1517 + Z232*Z1504 + Z496*Z1453 - Z476*Z1479 + Z507*Z1466;
Z2265 = Z223*Z1492 - Z204*Z1518 + Z232*Z1505 + Z496*Z1454 - Z476*Z1480 + Z507*Z1467;
Z2266 = Z223*Z1493 - Z204*Z1519 + Z232*Z1506 + Z496*Z1455 - Z476*Z1481 + Z507*Z1468;
Z2267 = Z223*Z1494 - Z204*Z1520 + Z232*Z1507 + Z496*Z1456 + Z507*Z1469;
Z2268 = Z223*Z1495 - Z204*Z1521 + Z232*Z1508 + Z496*Z1457 - Z476*Z1482 + Z507*Z1470;
 
LHS_10r_torso = Z2256*ddx+Z2257*ddpsi+Z2258*ddq_imu+Z2259*ddq_w+Z2260*ddq_torso+Z2261*ddq_1r+Z2262*ddq_2r+Z2263*ddq_3r+Z2264*ddq_4r+Z2265*ddq_5r+Z2266*ddq_6r+Z2267*ddq_7r+Z2268;
 
% LHS_L_4l = 
%
%      0
% LHS_R_4l = 
%
%      0
% LHS_1_4l = 
%
%      0
% LHS_2_4l = 
%
%      0
% LHS_3_4l = 
%
%      0
% LHS_4l_4l = 
%
%      (-Z734)*ddx + (-Z735)*ddpsi + (-Z736)*ddq_imu + (-Z737)*ddq_w + (-Z739)*ddq_1l - (Z740 + Z738*ddq_torso)
LHS_4l_4l = -Z734*ddx-Z735*ddpsi-Z736*ddq_imu-Z737*ddq_w-Z738*ddq_torso-Z739*ddq_1l+-Z740;
 
% LHS_5l_4l = 
%
%      (Z44*Z779 + Z48*Z787)*ddx + (Z44*Z780 + Z48*Z788)*ddpsi + (Z44*Z781 + Z48*Z789)*ddq_imu + (Z44*Z782 + Z48*Z790)*ddq_w + (Z44*Z784 + Z48*Z792)*ddq_1l + (Z44*Z785 + Z48*Z793)*ddq_2l + (Z44*(Z786 + Z783*ddq_torso) + Z48*(Z794 + Z791*ddq_torso))
Z2269 = Z44*Z779 + Z48*Z787;
Z2270 = Z44*Z780 + Z48*Z788;
Z2271 = Z44*Z781 + Z48*Z789;
Z2272 = Z44*Z782 + Z48*Z790;
Z2273 = Z44*Z783 + Z48*Z791;
Z2274 = Z44*Z784 + Z48*Z792;
Z2275 = Z44*Z785 + Z48*Z793;
Z2276 = Z44*Z786 + Z48*Z794;
 
LHS_5l_4l = Z2269*ddx+Z2270*ddpsi+Z2271*ddq_imu+Z2272*ddq_w+Z2273*ddq_torso+Z2274*ddq_1l+Z2275*ddq_2l+Z2276;
 
% LHS_6l_4l = 
%
%      (Z55*Z821 - Z44*Z830 + Z60*Z839 + Z301*Z795 + Z308*Z812)*ddx + (Z55*Z822 - Z44*Z831 + Z60*Z840 + Z301*Z796 + Z308*Z813)*ddpsi + (Z55*Z823 - Z44*Z832 + Z60*Z841 + Z301*Z797 + Z308*Z814)*ddq_imu + (Z55*Z824 - Z44*Z833 + Z60*Z842 + Z301*Z798 + Z308*Z815)*ddq_w + (Z55*Z826 - Z44*Z835 + Z60*Z844 + Z301*Z800 + Z308*Z817)*ddq_1l + (Z55*Z827 - Z44*Z836 + Z60*Z845 + Z301*Z801 + Z308*Z818)*ddq_2l + (Z55*Z828 - Z44*Z837 + Z60*Z846 + Z301*Z802 + Z308*Z819)*ddq_3l + (Z55*(Z829 + Z825*ddq_torso) - Z44*(Z838 + Z834*ddq_torso) + Z60*(Z847 + Z843*ddq_torso) + Z301*(Z803 + Z799*ddq_torso) + Z308*(Z820 + Z816*ddq_torso))
Z2277 = Z55*Z821 - Z44*Z830 + Z60*Z839 + Z301*Z795 + Z308*Z812;
Z2278 = Z55*Z822 - Z44*Z831 + Z60*Z840 + Z301*Z796 + Z308*Z813;
Z2279 = Z55*Z823 - Z44*Z832 + Z60*Z841 + Z301*Z797 + Z308*Z814;
Z2280 = Z55*Z824 - Z44*Z833 + Z60*Z842 + Z301*Z798 + Z308*Z815;
Z2281 = Z55*Z825 - Z44*Z834 + Z60*Z843 + Z301*Z799 + Z308*Z816;
Z2282 = Z55*Z826 - Z44*Z835 + Z60*Z844 + Z301*Z800 + Z308*Z817;
Z2283 = Z55*Z827 - Z44*Z836 + Z60*Z845 + Z301*Z801 + Z308*Z818;
Z2284 = Z55*Z828 - Z44*Z837 + Z60*Z846 + Z301*Z802 + Z308*Z819;
Z2285 = Z55*Z829 - Z44*Z838 + Z60*Z847 + Z301*Z803 + Z308*Z820;
 
LHS_6l_4l = Z2277*ddx+Z2278*ddpsi+Z2279*ddq_imu+Z2280*ddq_w+Z2281*ddq_torso+Z2282*ddq_1l+Z2283*ddq_2l+Z2284*ddq_3l+Z2285;
 
% LHS_7l_4l = 
%
%      (Z68*Z887 - Z55*Z877 + Z74*Z897 - Z301*Z848 + Z317*Z857 + Z324*Z867)*ddx + (Z68*Z888 - Z55*Z878 + Z74*Z898 - Z301*Z849 + Z317*Z858 + Z324*Z868)*ddpsi + (Z68*Z889 - Z55*Z879 + Z74*Z899 - Z301*Z850 + Z317*Z859 + Z324*Z869)*ddq_imu + (Z68*Z890 - Z55*Z880 + Z74*Z900 - Z301*Z851 + Z317*Z860 + Z324*Z870)*ddq_w + (Z68*Z892 - Z55*Z882 + Z74*Z902 - Z301*Z853 + Z317*Z862 + Z324*Z872)*ddq_1l + (Z68*Z893 - Z55*Z883 + Z74*Z903 - Z301*Z854 + Z317*Z863 + Z324*Z873)*ddq_2l + (Z68*Z894 - Z55*Z884 + Z74*Z904 - Z301*Z855 + Z317*Z864 + Z324*Z874)*ddq_3l + (Z68*Z895 - Z55*Z885 + Z74*Z905 + Z317*Z865 + Z324*Z875)*ddq_4l + (Z68*(Z896 + Z891*ddq_torso) - Z55*(Z886 + Z881*ddq_torso) + Z74*(Z906 + Z901*ddq_torso) - Z301*(Z856 + Z852*ddq_torso) + Z317*(Z866 + Z861*ddq_torso) + Z324*(Z876 + Z871*ddq_torso))
Z2286 = Z68*Z887 - Z55*Z877 + Z74*Z897 - Z301*Z848 + Z317*Z857 + Z324*Z867;
Z2287 = Z68*Z888 - Z55*Z878 + Z74*Z898 - Z301*Z849 + Z317*Z858 + Z324*Z868;
Z2288 = Z68*Z889 - Z55*Z879 + Z74*Z899 - Z301*Z850 + Z317*Z859 + Z324*Z869;
Z2289 = Z68*Z890 - Z55*Z880 + Z74*Z900 - Z301*Z851 + Z317*Z860 + Z324*Z870;
Z2290 = Z68*Z891 - Z55*Z881 + Z74*Z901 - Z301*Z852 + Z317*Z861 + Z324*Z871;
Z2291 = Z68*Z892 - Z55*Z882 + Z74*Z902 - Z301*Z853 + Z317*Z862 + Z324*Z872;
Z2292 = Z68*Z893 - Z55*Z883 + Z74*Z903 - Z301*Z854 + Z317*Z863 + Z324*Z873;
Z2293 = Z68*Z894 - Z55*Z884 + Z74*Z904 - Z301*Z855 + Z317*Z864 + Z324*Z874;
Z2294 = Z68*Z895 - Z55*Z885 + Z74*Z905 + Z317*Z865 + Z324*Z875;
Z2295 = Z68*Z896 - Z55*Z886 + Z74*Z906 - Z301*Z856 + Z317*Z866 + Z324*Z876;
 
LHS_7l_4l = Z2286*ddx+Z2287*ddpsi+Z2288*ddq_imu+Z2289*ddq_w+Z2290*ddq_torso+Z2291*ddq_1l+Z2292*ddq_2l+Z2293*ddq_3l+Z2294*ddq_4l+Z2295;
 
% LHS_8l_4l = 
%
%      (Z83*Z939 - Z68*Z950 + Z90*Z961 - Z317*Z918 + Z333*Z907 + Z342*Z928)*ddx + (Z83*Z940 - Z68*Z951 + Z90*Z962 - Z317*Z919 + Z333*Z908 + Z342*Z929)*ddpsi + (Z83*Z941 - Z68*Z952 + Z90*Z963 - Z317*Z920 + Z333*Z909 + Z342*Z930)*ddq_imu + (Z83*Z942 - Z68*Z953 + Z90*Z964 - Z317*Z921 + Z333*Z910 + Z342*Z931)*ddq_w + (Z83*Z944 - Z68*Z955 + Z90*Z966 - Z317*Z923 + Z333*Z912 + Z342*Z933)*ddq_1l + (Z83*Z945 - Z68*Z956 + Z90*Z967 - Z317*Z924 + Z333*Z913 + Z342*Z934)*ddq_2l + (Z83*Z946 - Z68*Z957 + Z90*Z968 - Z317*Z925 + Z333*Z914 + Z342*Z935)*ddq_3l + (Z83*Z947 - Z68*Z958 + Z90*Z969 - Z317*Z926 + Z333*Z915 + Z342*Z936)*ddq_4l + (Z83*Z948 - Z68*Z959 + Z90*Z970 + Z333*Z916 + Z342*Z937)*ddq_5l + (Z83*(Z949 + Z943*ddq_torso) - Z68*(Z960 + Z954*ddq_torso) + Z90*(Z971 + Z965*ddq_torso) + Z333*(Z917 + Z911*ddq_torso) - Z317*(Z927 + Z922*ddq_torso) + Z342*(Z938 + Z932*ddq_torso))
Z2296 = Z83*Z939 - Z68*Z950 + Z90*Z961 - Z317*Z918 + Z333*Z907 + Z342*Z928;
Z2297 = Z83*Z940 - Z68*Z951 + Z90*Z962 - Z317*Z919 + Z333*Z908 + Z342*Z929;
Z2298 = Z83*Z941 - Z68*Z952 + Z90*Z963 - Z317*Z920 + Z333*Z909 + Z342*Z930;
Z2299 = Z83*Z942 - Z68*Z953 + Z90*Z964 - Z317*Z921 + Z333*Z910 + Z342*Z931;
Z2300 = Z83*Z943 - Z68*Z954 + Z90*Z965 - Z317*Z922 + Z333*Z911 + Z342*Z932;
Z2301 = Z83*Z944 - Z68*Z955 + Z90*Z966 - Z317*Z923 + Z333*Z912 + Z342*Z933;
Z2302 = Z83*Z945 - Z68*Z956 + Z90*Z967 - Z317*Z924 + Z333*Z913 + Z342*Z934;
Z2303 = Z83*Z946 - Z68*Z957 + Z90*Z968 - Z317*Z925 + Z333*Z914 + Z342*Z935;
Z2304 = Z83*Z947 - Z68*Z958 + Z90*Z969 - Z317*Z926 + Z333*Z915 + Z342*Z936;
Z2305 = Z83*Z948 - Z68*Z959 + Z90*Z970 + Z333*Z916 + Z342*Z937;
Z2306 = Z83*Z949 - Z68*Z960 + Z90*Z971 - Z317*Z927 + Z333*Z917 + Z342*Z938;
 
LHS_8l_4l = Z2296*ddx+Z2297*ddpsi+Z2298*ddq_imu+Z2299*ddq_w+Z2300*ddq_torso+Z2301*ddq_1l+Z2302*ddq_2l+Z2303*ddq_3l+Z2304*ddq_4l+Z2305*ddq_5l+Z2306;
 
% LHS_9l_4l = 
%
%      (Z100*Z1019 - Z83*Z1007 + Z108*Z1031 - Z333*Z972 + Z353*Z983 + Z362*Z995)*ddx + (Z100*Z1020 - Z83*Z1008 + Z108*Z1032 - Z333*Z973 + Z353*Z984 + Z362*Z996)*ddpsi + (Z100*Z1021 - Z83*Z1009 + Z108*Z1033 - Z333*Z974 + Z353*Z985 + Z362*Z997)*ddq_imu + (Z100*Z1022 - Z83*Z1010 + Z108*Z1034 - Z333*Z975 + Z353*Z986 + Z362*Z998)*ddq_w + (Z100*Z1024 - Z83*Z1012 + Z108*Z1036 - Z333*Z977 + Z353*Z988 + Z362*Z1000)*ddq_1l + (Z100*Z1025 - Z83*Z1013 + Z108*Z1037 - Z333*Z978 + Z353*Z989 + Z362*Z1001)*ddq_2l + (Z100*Z1026 - Z83*Z1014 + Z108*Z1038 - Z333*Z979 + Z353*Z990 + Z362*Z1002)*ddq_3l + (Z100*Z1027 - Z83*Z1015 + Z108*Z1039 - Z333*Z980 + Z353*Z991 + Z362*Z1003)*ddq_4l + (Z100*Z1028 - Z83*Z1016 + Z108*Z1040 - Z333*Z981 + Z353*Z992 + Z362*Z1004)*ddq_5l + (Z100*Z1029 - Z83*Z1017 + Z108*Z1041 + Z353*Z993 + Z362*Z1005)*ddq_6l + (Z100*(Z1030 + Z1023*ddq_torso) - Z83*(Z1018 + Z1011*ddq_torso) + Z108*(Z1042 + Z1035*ddq_torso) - Z333*(Z982 + Z976*ddq_torso) + Z353*(Z994 + Z987*ddq_torso) + Z362*(Z1006 + Z999*ddq_torso))
Z2307 = Z100*Z1019 - Z83*Z1007 + Z108*Z1031 - Z333*Z972 + Z353*Z983 + Z362*Z995;
Z2308 = Z100*Z1020 - Z83*Z1008 + Z108*Z1032 - Z333*Z973 + Z353*Z984 + Z362*Z996;
Z2309 = Z100*Z1021 - Z83*Z1009 + Z108*Z1033 - Z333*Z974 + Z353*Z985 + Z362*Z997;
Z2310 = Z100*Z1022 - Z83*Z1010 + Z108*Z1034 - Z333*Z975 + Z353*Z986 + Z362*Z998;
Z2311 = Z100*Z1023 - Z83*Z1011 + Z108*Z1035 - Z333*Z976 + Z353*Z987 + Z362*Z999;
Z2312 = Z100*Z1024 - Z83*Z1012 + Z108*Z1036 - Z333*Z977 + Z353*Z988 + Z362*Z1000;
Z2313 = Z100*Z1025 - Z83*Z1013 + Z108*Z1037 - Z333*Z978 + Z353*Z989 + Z362*Z1001;
Z2314 = Z100*Z1026 - Z83*Z1014 + Z108*Z1038 - Z333*Z979 + Z353*Z990 + Z362*Z1002;
Z2315 = Z100*Z1027 - Z83*Z1015 + Z108*Z1039 - Z333*Z980 + Z353*Z991 + Z362*Z1003;
Z2316 = Z100*Z1028 - Z83*Z1016 + Z108*Z1040 - Z333*Z981 + Z353*Z992 + Z362*Z1004;
Z2317 = Z100*Z1029 - Z83*Z1017 + Z108*Z1041 + Z353*Z993 + Z362*Z1005;
Z2318 = Z100*Z1030 - Z83*Z1018 + Z108*Z1042 - Z333*Z982 + Z353*Z994 + Z362*Z1006;
 
LHS_9l_4l = Z2307*ddx+Z2308*ddpsi+Z2309*ddq_imu+Z2310*ddq_w+Z2311*ddq_torso+Z2312*ddq_1l+Z2313*ddq_2l+Z2314*ddq_3l+Z2315*ddq_4l+Z2316*ddq_5l+Z2317*ddq_6l+Z2318;
 
% LHS_10l_4l = 
%
%      (Z119*Z1081 - Z100*Z1107 + Z128*Z1094 + Z373*Z1043 - Z353*Z1069 + Z384*Z1056)*ddx + (Z119*Z1082 - Z100*Z1108 + Z128*Z1095 + Z373*Z1044 - Z353*Z1070 + Z384*Z1057)*ddpsi + (Z119*Z1083 - Z100*Z1109 + Z128*Z1096 + Z373*Z1045 - Z353*Z1071 + Z384*Z1058)*ddq_imu + (Z119*Z1084 - Z100*Z1110 + Z128*Z1097 + Z373*Z1046 - Z353*Z1072 + Z384*Z1059)*ddq_w + (Z119*Z1086 - Z100*Z1112 + Z128*Z1099 + Z373*Z1048 - Z353*Z1074 + Z384*Z1061)*ddq_1l + (Z119*Z1087 - Z100*Z1113 + Z128*Z1100 + Z373*Z1049 - Z353*Z1075 + Z384*Z1062)*ddq_2l + (Z119*Z1088 - Z100*Z1114 + Z128*Z1101 + Z373*Z1050 - Z353*Z1076 + Z384*Z1063)*ddq_3l + (Z119*Z1089 - Z100*Z1115 + Z128*Z1102 + Z373*Z1051 - Z353*Z1077 + Z384*Z1064)*ddq_4l + (Z119*Z1090 - Z100*Z1116 + Z128*Z1103 + Z373*Z1052 - Z353*Z1078 + Z384*Z1065)*ddq_5l + (Z119*Z1091 - Z100*Z1117 + Z128*Z1104 + Z373*Z1053 - Z353*Z1079 + Z384*Z1066)*ddq_6l + (Z119*Z1092 - Z100*Z1118 + Z128*Z1105 + Z373*Z1054 + Z384*Z1067)*ddq_7l + (Z119*(Z1093 + Z1085*ddq_torso) - Z100*(Z1119 + Z1111*ddq_torso) + Z128*(Z1106 + Z1098*ddq_torso) + Z373*(Z1055 + Z1047*ddq_torso) - Z353*(Z1080 + Z1073*ddq_torso) + Z384*(Z1068 + Z1060*ddq_torso))
Z2319 = Z119*Z1081 - Z100*Z1107 + Z128*Z1094 + Z373*Z1043 - Z353*Z1069 + Z384*Z1056;
Z2320 = Z119*Z1082 - Z100*Z1108 + Z128*Z1095 + Z373*Z1044 - Z353*Z1070 + Z384*Z1057;
Z2321 = Z119*Z1083 - Z100*Z1109 + Z128*Z1096 + Z373*Z1045 - Z353*Z1071 + Z384*Z1058;
Z2322 = Z119*Z1084 - Z100*Z1110 + Z128*Z1097 + Z373*Z1046 - Z353*Z1072 + Z384*Z1059;
Z2323 = Z119*Z1085 - Z100*Z1111 + Z128*Z1098 + Z373*Z1047 - Z353*Z1073 + Z384*Z1060;
Z2324 = Z119*Z1086 - Z100*Z1112 + Z128*Z1099 + Z373*Z1048 - Z353*Z1074 + Z384*Z1061;
Z2325 = Z119*Z1087 - Z100*Z1113 + Z128*Z1100 + Z373*Z1049 - Z353*Z1075 + Z384*Z1062;
Z2326 = Z119*Z1088 - Z100*Z1114 + Z128*Z1101 + Z373*Z1050 - Z353*Z1076 + Z384*Z1063;
Z2327 = Z119*Z1089 - Z100*Z1115 + Z128*Z1102 + Z373*Z1051 - Z353*Z1077 + Z384*Z1064;
Z2328 = Z119*Z1090 - Z100*Z1116 + Z128*Z1103 + Z373*Z1052 - Z353*Z1078 + Z384*Z1065;
Z2329 = Z119*Z1091 - Z100*Z1117 + Z128*Z1104 + Z373*Z1053 - Z353*Z1079 + Z384*Z1066;
Z2330 = Z119*Z1092 - Z100*Z1118 + Z128*Z1105 + Z373*Z1054 + Z384*Z1067;
Z2331 = Z119*Z1093 - Z100*Z1119 + Z128*Z1106 + Z373*Z1055 - Z353*Z1080 + Z384*Z1068;
 
LHS_10l_4l = Z2319*ddx+Z2320*ddpsi+Z2321*ddq_imu+Z2322*ddq_w+Z2323*ddq_torso+Z2324*ddq_1l+Z2325*ddq_2l+Z2326*ddq_3l+Z2327*ddq_4l+Z2328*ddq_5l+Z2329*ddq_6l+Z2330*ddq_7l+Z2331;
 
% LHS_4r_4l = 
%
%      0
% LHS_5r_4l = 
%
%      0
% LHS_6r_4l = 
%
%      0
% LHS_7r_4l = 
%
%      0
% LHS_8r_4l = 
%
%      0
% LHS_9r_4l = 
%
%      0
% LHS_10r_4l = 
%
%      0
% LHS_L_5l = 
%
%      0
% LHS_R_5l = 
%
%      0
% LHS_1_5l = 
%
%      0
% LHS_2_5l = 
%
%      0
% LHS_3_5l = 
%
%      0
% LHS_4l_5l = 
%
%      0
% LHS_5l_5l = 
%
%      (-Z771)*ddx + (-Z772)*ddpsi + (-Z773)*ddq_imu + (-Z774)*ddq_w + (-Z776)*ddq_1l + (-Z777)*ddq_2l - (Z778 + Z775*ddq_torso)
LHS_5l_5l = -Z771*ddx-Z772*ddpsi-Z773*ddq_imu-Z774*ddq_w-Z775*ddq_torso-Z776*ddq_1l-Z777*ddq_2l+-Z778;
 
% LHS_6l_5l = 
%
%      (Z56*Z821 + Z61*Z839 + Z302*Z795 + Z309*Z812)*ddx + (Z56*Z822 + Z61*Z840 + Z302*Z796 + Z309*Z813)*ddpsi + (Z56*Z823 + Z61*Z841 + Z302*Z797 + Z309*Z814)*ddq_imu + (Z56*Z824 + Z61*Z842 + Z302*Z798 + Z309*Z815)*ddq_w + (Z56*Z826 + Z61*Z844 + Z302*Z800 + Z309*Z817)*ddq_1l + (Z56*Z827 + Z61*Z845 + Z302*Z801 + Z309*Z818)*ddq_2l + (Z56*Z828 + Z61*Z846 + Z302*Z802 + Z309*Z819)*ddq_3l + (Z56*(Z829 + Z825*ddq_torso) + Z61*(Z847 + Z843*ddq_torso) + Z302*(Z803 + Z799*ddq_torso) + Z309*(Z820 + Z816*ddq_torso))
Z2332 = Z56*Z821 + Z61*Z839 + Z302*Z795 + Z309*Z812;
Z2333 = Z56*Z822 + Z61*Z840 + Z302*Z796 + Z309*Z813;
Z2334 = Z56*Z823 + Z61*Z841 + Z302*Z797 + Z309*Z814;
Z2335 = Z56*Z824 + Z61*Z842 + Z302*Z798 + Z309*Z815;
Z2336 = Z56*Z825 + Z61*Z843 + Z302*Z799 + Z309*Z816;
Z2337 = Z56*Z826 + Z61*Z844 + Z302*Z800 + Z309*Z817;
Z2338 = Z56*Z827 + Z61*Z845 + Z302*Z801 + Z309*Z818;
Z2339 = Z56*Z828 + Z61*Z846 + Z302*Z802 + Z309*Z819;
Z2340 = Z56*Z829 + Z61*Z847 + Z302*Z803 + Z309*Z820;
 
LHS_6l_5l = Z2332*ddx+Z2333*ddpsi+Z2334*ddq_imu+Z2335*ddq_w+Z2336*ddq_torso+Z2337*ddq_1l+Z2338*ddq_2l+Z2339*ddq_3l+Z2340;
 
% LHS_7l_5l = 
%
%      (Z69*Z887 - Z56*Z877 + Z75*Z897 - Z302*Z848 + Z318*Z857 + Z325*Z867)*ddx + (Z69*Z888 - Z56*Z878 + Z75*Z898 - Z302*Z849 + Z318*Z858 + Z325*Z868)*ddpsi + (Z69*Z889 - Z56*Z879 + Z75*Z899 - Z302*Z850 + Z318*Z859 + Z325*Z869)*ddq_imu + (Z69*Z890 - Z56*Z880 + Z75*Z900 - Z302*Z851 + Z318*Z860 + Z325*Z870)*ddq_w + (Z69*Z892 - Z56*Z882 + Z75*Z902 - Z302*Z853 + Z318*Z862 + Z325*Z872)*ddq_1l + (Z69*Z893 - Z56*Z883 + Z75*Z903 - Z302*Z854 + Z318*Z863 + Z325*Z873)*ddq_2l + (Z69*Z894 - Z56*Z884 + Z75*Z904 - Z302*Z855 + Z318*Z864 + Z325*Z874)*ddq_3l + (Z69*Z895 - Z56*Z885 + Z75*Z905 + Z318*Z865 + Z325*Z875)*ddq_4l + (Z69*(Z896 + Z891*ddq_torso) - Z56*(Z886 + Z881*ddq_torso) + Z75*(Z906 + Z901*ddq_torso) - Z302*(Z856 + Z852*ddq_torso) + Z318*(Z866 + Z861*ddq_torso) + Z325*(Z876 + Z871*ddq_torso))
Z2341 = Z69*Z887 - Z56*Z877 + Z75*Z897 - Z302*Z848 + Z318*Z857 + Z325*Z867;
Z2342 = Z69*Z888 - Z56*Z878 + Z75*Z898 - Z302*Z849 + Z318*Z858 + Z325*Z868;
Z2343 = Z69*Z889 - Z56*Z879 + Z75*Z899 - Z302*Z850 + Z318*Z859 + Z325*Z869;
Z2344 = Z69*Z890 - Z56*Z880 + Z75*Z900 - Z302*Z851 + Z318*Z860 + Z325*Z870;
Z2345 = Z69*Z891 - Z56*Z881 + Z75*Z901 - Z302*Z852 + Z318*Z861 + Z325*Z871;
Z2346 = Z69*Z892 - Z56*Z882 + Z75*Z902 - Z302*Z853 + Z318*Z862 + Z325*Z872;
Z2347 = Z69*Z893 - Z56*Z883 + Z75*Z903 - Z302*Z854 + Z318*Z863 + Z325*Z873;
Z2348 = Z69*Z894 - Z56*Z884 + Z75*Z904 - Z302*Z855 + Z318*Z864 + Z325*Z874;
Z2349 = Z69*Z895 - Z56*Z885 + Z75*Z905 + Z318*Z865 + Z325*Z875;
Z2350 = Z69*Z896 - Z56*Z886 + Z75*Z906 - Z302*Z856 + Z318*Z866 + Z325*Z876;
 
LHS_7l_5l = Z2341*ddx+Z2342*ddpsi+Z2343*ddq_imu+Z2344*ddq_w+Z2345*ddq_torso+Z2346*ddq_1l+Z2347*ddq_2l+Z2348*ddq_3l+Z2349*ddq_4l+Z2350;
 
% LHS_8l_5l = 
%
%      (Z84*Z939 - Z69*Z950 + Z91*Z961 - Z318*Z918 + Z334*Z907 + Z343*Z928)*ddx + (Z84*Z940 - Z69*Z951 + Z91*Z962 - Z318*Z919 + Z334*Z908 + Z343*Z929)*ddpsi + (Z84*Z941 - Z69*Z952 + Z91*Z963 - Z318*Z920 + Z334*Z909 + Z343*Z930)*ddq_imu + (Z84*Z942 - Z69*Z953 + Z91*Z964 - Z318*Z921 + Z334*Z910 + Z343*Z931)*ddq_w + (Z84*Z944 - Z69*Z955 + Z91*Z966 - Z318*Z923 + Z334*Z912 + Z343*Z933)*ddq_1l + (Z84*Z945 - Z69*Z956 + Z91*Z967 - Z318*Z924 + Z334*Z913 + Z343*Z934)*ddq_2l + (Z84*Z946 - Z69*Z957 + Z91*Z968 - Z318*Z925 + Z334*Z914 + Z343*Z935)*ddq_3l + (Z84*Z947 - Z69*Z958 + Z91*Z969 - Z318*Z926 + Z334*Z915 + Z343*Z936)*ddq_4l + (Z84*Z948 - Z69*Z959 + Z91*Z970 + Z334*Z916 + Z343*Z937)*ddq_5l + (Z84*(Z949 + Z943*ddq_torso) - Z69*(Z960 + Z954*ddq_torso) + Z91*(Z971 + Z965*ddq_torso) + Z334*(Z917 + Z911*ddq_torso) - Z318*(Z927 + Z922*ddq_torso) + Z343*(Z938 + Z932*ddq_torso))
Z2351 = Z84*Z939 - Z69*Z950 + Z91*Z961 - Z318*Z918 + Z334*Z907 + Z343*Z928;
Z2352 = Z84*Z940 - Z69*Z951 + Z91*Z962 - Z318*Z919 + Z334*Z908 + Z343*Z929;
Z2353 = Z84*Z941 - Z69*Z952 + Z91*Z963 - Z318*Z920 + Z334*Z909 + Z343*Z930;
Z2354 = Z84*Z942 - Z69*Z953 + Z91*Z964 - Z318*Z921 + Z334*Z910 + Z343*Z931;
Z2355 = Z84*Z943 - Z69*Z954 + Z91*Z965 - Z318*Z922 + Z334*Z911 + Z343*Z932;
Z2356 = Z84*Z944 - Z69*Z955 + Z91*Z966 - Z318*Z923 + Z334*Z912 + Z343*Z933;
Z2357 = Z84*Z945 - Z69*Z956 + Z91*Z967 - Z318*Z924 + Z334*Z913 + Z343*Z934;
Z2358 = Z84*Z946 - Z69*Z957 + Z91*Z968 - Z318*Z925 + Z334*Z914 + Z343*Z935;
Z2359 = Z84*Z947 - Z69*Z958 + Z91*Z969 - Z318*Z926 + Z334*Z915 + Z343*Z936;
Z2360 = Z84*Z948 - Z69*Z959 + Z91*Z970 + Z334*Z916 + Z343*Z937;
Z2361 = Z84*Z949 - Z69*Z960 + Z91*Z971 - Z318*Z927 + Z334*Z917 + Z343*Z938;
 
LHS_8l_5l = Z2351*ddx+Z2352*ddpsi+Z2353*ddq_imu+Z2354*ddq_w+Z2355*ddq_torso+Z2356*ddq_1l+Z2357*ddq_2l+Z2358*ddq_3l+Z2359*ddq_4l+Z2360*ddq_5l+Z2361;
 
% LHS_9l_5l = 
%
%      (Z101*Z1019 - Z84*Z1007 + Z109*Z1031 - Z334*Z972 + Z354*Z983 + Z363*Z995)*ddx + (Z101*Z1020 - Z84*Z1008 + Z109*Z1032 - Z334*Z973 + Z354*Z984 + Z363*Z996)*ddpsi + (Z101*Z1021 - Z84*Z1009 + Z109*Z1033 - Z334*Z974 + Z354*Z985 + Z363*Z997)*ddq_imu + (Z101*Z1022 - Z84*Z1010 + Z109*Z1034 - Z334*Z975 + Z354*Z986 + Z363*Z998)*ddq_w + (Z101*Z1024 - Z84*Z1012 + Z109*Z1036 - Z334*Z977 + Z354*Z988 + Z363*Z1000)*ddq_1l + (Z101*Z1025 - Z84*Z1013 + Z109*Z1037 - Z334*Z978 + Z354*Z989 + Z363*Z1001)*ddq_2l + (Z101*Z1026 - Z84*Z1014 + Z109*Z1038 - Z334*Z979 + Z354*Z990 + Z363*Z1002)*ddq_3l + (Z101*Z1027 - Z84*Z1015 + Z109*Z1039 - Z334*Z980 + Z354*Z991 + Z363*Z1003)*ddq_4l + (Z101*Z1028 - Z84*Z1016 + Z109*Z1040 - Z334*Z981 + Z354*Z992 + Z363*Z1004)*ddq_5l + (Z101*Z1029 - Z84*Z1017 + Z109*Z1041 + Z354*Z993 + Z363*Z1005)*ddq_6l + (Z101*(Z1030 + Z1023*ddq_torso) - Z84*(Z1018 + Z1011*ddq_torso) + Z109*(Z1042 + Z1035*ddq_torso) - Z334*(Z982 + Z976*ddq_torso) + Z354*(Z994 + Z987*ddq_torso) + Z363*(Z1006 + Z999*ddq_torso))
Z2362 = Z101*Z1019 - Z84*Z1007 + Z109*Z1031 - Z334*Z972 + Z354*Z983 + Z363*Z995;
Z2363 = Z101*Z1020 - Z84*Z1008 + Z109*Z1032 - Z334*Z973 + Z354*Z984 + Z363*Z996;
Z2364 = Z101*Z1021 - Z84*Z1009 + Z109*Z1033 - Z334*Z974 + Z354*Z985 + Z363*Z997;
Z2365 = Z101*Z1022 - Z84*Z1010 + Z109*Z1034 - Z334*Z975 + Z354*Z986 + Z363*Z998;
Z2366 = Z101*Z1023 - Z84*Z1011 + Z109*Z1035 - Z334*Z976 + Z354*Z987 + Z363*Z999;
Z2367 = Z101*Z1024 - Z84*Z1012 + Z109*Z1036 - Z334*Z977 + Z354*Z988 + Z363*Z1000;
Z2368 = Z101*Z1025 - Z84*Z1013 + Z109*Z1037 - Z334*Z978 + Z354*Z989 + Z363*Z1001;
Z2369 = Z101*Z1026 - Z84*Z1014 + Z109*Z1038 - Z334*Z979 + Z354*Z990 + Z363*Z1002;
Z2370 = Z101*Z1027 - Z84*Z1015 + Z109*Z1039 - Z334*Z980 + Z354*Z991 + Z363*Z1003;
Z2371 = Z101*Z1028 - Z84*Z1016 + Z109*Z1040 - Z334*Z981 + Z354*Z992 + Z363*Z1004;
Z2372 = Z101*Z1029 - Z84*Z1017 + Z109*Z1041 + Z354*Z993 + Z363*Z1005;
Z2373 = Z101*Z1030 - Z84*Z1018 + Z109*Z1042 - Z334*Z982 + Z354*Z994 + Z363*Z1006;
 
LHS_9l_5l = Z2362*ddx+Z2363*ddpsi+Z2364*ddq_imu+Z2365*ddq_w+Z2366*ddq_torso+Z2367*ddq_1l+Z2368*ddq_2l+Z2369*ddq_3l+Z2370*ddq_4l+Z2371*ddq_5l+Z2372*ddq_6l+Z2373;
 
% LHS_10l_5l = 
%
%      (Z120*Z1081 - Z101*Z1107 + Z129*Z1094 + Z374*Z1043 - Z354*Z1069 + Z385*Z1056)*ddx + (Z120*Z1082 - Z101*Z1108 + Z129*Z1095 + Z374*Z1044 - Z354*Z1070 + Z385*Z1057)*ddpsi + (Z120*Z1083 - Z101*Z1109 + Z129*Z1096 + Z374*Z1045 - Z354*Z1071 + Z385*Z1058)*ddq_imu + (Z120*Z1084 - Z101*Z1110 + Z129*Z1097 + Z374*Z1046 - Z354*Z1072 + Z385*Z1059)*ddq_w + (Z120*Z1086 - Z101*Z1112 + Z129*Z1099 + Z374*Z1048 - Z354*Z1074 + Z385*Z1061)*ddq_1l + (Z120*Z1087 - Z101*Z1113 + Z129*Z1100 + Z374*Z1049 - Z354*Z1075 + Z385*Z1062)*ddq_2l + (Z120*Z1088 - Z101*Z1114 + Z129*Z1101 + Z374*Z1050 - Z354*Z1076 + Z385*Z1063)*ddq_3l + (Z120*Z1089 - Z101*Z1115 + Z129*Z1102 + Z374*Z1051 - Z354*Z1077 + Z385*Z1064)*ddq_4l + (Z120*Z1090 - Z101*Z1116 + Z129*Z1103 + Z374*Z1052 - Z354*Z1078 + Z385*Z1065)*ddq_5l + (Z120*Z1091 - Z101*Z1117 + Z129*Z1104 + Z374*Z1053 - Z354*Z1079 + Z385*Z1066)*ddq_6l + (Z120*Z1092 - Z101*Z1118 + Z129*Z1105 + Z374*Z1054 + Z385*Z1067)*ddq_7l + (Z120*(Z1093 + Z1085*ddq_torso) - Z101*(Z1119 + Z1111*ddq_torso) + Z129*(Z1106 + Z1098*ddq_torso) + Z374*(Z1055 + Z1047*ddq_torso) - Z354*(Z1080 + Z1073*ddq_torso) + Z385*(Z1068 + Z1060*ddq_torso))
Z2374 = Z120*Z1081 - Z101*Z1107 + Z129*Z1094 + Z374*Z1043 - Z354*Z1069 + Z385*Z1056;
Z2375 = Z120*Z1082 - Z101*Z1108 + Z129*Z1095 + Z374*Z1044 - Z354*Z1070 + Z385*Z1057;
Z2376 = Z120*Z1083 - Z101*Z1109 + Z129*Z1096 + Z374*Z1045 - Z354*Z1071 + Z385*Z1058;
Z2377 = Z120*Z1084 - Z101*Z1110 + Z129*Z1097 + Z374*Z1046 - Z354*Z1072 + Z385*Z1059;
Z2378 = Z120*Z1085 - Z101*Z1111 + Z129*Z1098 + Z374*Z1047 - Z354*Z1073 + Z385*Z1060;
Z2379 = Z120*Z1086 - Z101*Z1112 + Z129*Z1099 + Z374*Z1048 - Z354*Z1074 + Z385*Z1061;
Z2380 = Z120*Z1087 - Z101*Z1113 + Z129*Z1100 + Z374*Z1049 - Z354*Z1075 + Z385*Z1062;
Z2381 = Z120*Z1088 - Z101*Z1114 + Z129*Z1101 + Z374*Z1050 - Z354*Z1076 + Z385*Z1063;
Z2382 = Z120*Z1089 - Z101*Z1115 + Z129*Z1102 + Z374*Z1051 - Z354*Z1077 + Z385*Z1064;
Z2383 = Z120*Z1090 - Z101*Z1116 + Z129*Z1103 + Z374*Z1052 - Z354*Z1078 + Z385*Z1065;
Z2384 = Z120*Z1091 - Z101*Z1117 + Z129*Z1104 + Z374*Z1053 - Z354*Z1079 + Z385*Z1066;
Z2385 = Z120*Z1092 - Z101*Z1118 + Z129*Z1105 + Z374*Z1054 + Z385*Z1067;
Z2386 = Z120*Z1093 - Z101*Z1119 + Z129*Z1106 + Z374*Z1055 - Z354*Z1080 + Z385*Z1068;
 
LHS_10l_5l = Z2374*ddx+Z2375*ddpsi+Z2376*ddq_imu+Z2377*ddq_w+Z2378*ddq_torso+Z2379*ddq_1l+Z2380*ddq_2l+Z2381*ddq_3l+Z2382*ddq_4l+Z2383*ddq_5l+Z2384*ddq_6l+Z2385*ddq_7l+Z2386;
 
% LHS_4r_5l = 
%
%      0
% LHS_5r_5l = 
%
%      0
% LHS_6r_5l = 
%
%      0
% LHS_7r_5l = 
%
%      0
% LHS_8r_5l = 
%
%      0
% LHS_9r_5l = 
%
%      0
% LHS_10r_5l = 
%
%      0
% LHS_L_6l = 
%
%      0
% LHS_R_6l = 
%
%      0
% LHS_1_6l = 
%
%      0
% LHS_2_6l = 
%
%      0
% LHS_3_6l = 
%
%      0
% LHS_4l_6l = 
%
%      0
% LHS_5l_6l = 
%
%      0
% LHS_6l_6l = 
%
%      (-Z830)*ddx + (-Z831)*ddpsi + (-Z832)*ddq_imu + (-Z833)*ddq_w + (-Z835)*ddq_1l + (-Z836)*ddq_2l + (-Z837)*ddq_3l - (Z838 + Z834*ddq_torso)
LHS_6l_6l = -Z830*ddx-Z831*ddpsi-Z832*ddq_imu-Z833*ddq_w-Z834*ddq_torso-Z835*ddq_1l-Z836*ddq_2l-Z837*ddq_3l+-Z838;
 
% LHS_7l_6l = 
%
%      (Z70*Z887 + Z76*Z897)*ddx + (Z70*Z888 + Z76*Z898)*ddpsi + (Z70*Z889 + Z76*Z899)*ddq_imu + (Z70*Z890 + Z76*Z900)*ddq_w + (Z70*Z892 + Z76*Z902)*ddq_1l + (Z70*Z893 + Z76*Z903)*ddq_2l + (Z70*Z894 + Z76*Z904)*ddq_3l + (Z70*Z895 + Z76*Z905)*ddq_4l + (Z70*(Z896 + Z891*ddq_torso) + Z76*(Z906 + Z901*ddq_torso))
Z2387 = Z70*Z887 + Z76*Z897;
Z2388 = Z70*Z888 + Z76*Z898;
Z2389 = Z70*Z889 + Z76*Z899;
Z2390 = Z70*Z890 + Z76*Z900;
Z2391 = Z70*Z891 + Z76*Z901;
Z2392 = Z70*Z892 + Z76*Z902;
Z2393 = Z70*Z893 + Z76*Z903;
Z2394 = Z70*Z894 + Z76*Z904;
Z2395 = Z70*Z895 + Z76*Z905;
Z2396 = Z70*Z896 + Z76*Z906;
 
LHS_7l_6l = Z2387*ddx+Z2388*ddpsi+Z2389*ddq_imu+Z2390*ddq_w+Z2391*ddq_torso+Z2392*ddq_1l+Z2393*ddq_2l+Z2394*ddq_3l+Z2395*ddq_4l+Z2396;
 
% LHS_8l_6l = 
%
%      (Z85*Z939 - Z70*Z950 + Z92*Z961 + Z335*Z907 + Z344*Z928)*ddx + (Z85*Z940 - Z70*Z951 + Z92*Z962 + Z335*Z908 + Z344*Z929)*ddpsi + (Z85*Z941 - Z70*Z952 + Z92*Z963 + Z335*Z909 + Z344*Z930)*ddq_imu + (Z85*Z942 - Z70*Z953 + Z92*Z964 + Z335*Z910 + Z344*Z931)*ddq_w + (Z85*Z944 - Z70*Z955 + Z92*Z966 + Z335*Z912 + Z344*Z933)*ddq_1l + (Z85*Z945 - Z70*Z956 + Z92*Z967 + Z335*Z913 + Z344*Z934)*ddq_2l + (Z85*Z946 - Z70*Z957 + Z92*Z968 + Z335*Z914 + Z344*Z935)*ddq_3l + (Z85*Z947 - Z70*Z958 + Z92*Z969 + Z335*Z915 + Z344*Z936)*ddq_4l + (Z85*Z948 - Z70*Z959 + Z92*Z970 + Z335*Z916 + Z344*Z937)*ddq_5l + (Z85*(Z949 + Z943*ddq_torso) - Z70*(Z960 + Z954*ddq_torso) + Z92*(Z971 + Z965*ddq_torso) + Z335*(Z917 + Z911*ddq_torso) + Z344*(Z938 + Z932*ddq_torso))
Z2397 = Z85*Z939 - Z70*Z950 + Z92*Z961 + Z335*Z907 + Z344*Z928;
Z2398 = Z85*Z940 - Z70*Z951 + Z92*Z962 + Z335*Z908 + Z344*Z929;
Z2399 = Z85*Z941 - Z70*Z952 + Z92*Z963 + Z335*Z909 + Z344*Z930;
Z2400 = Z85*Z942 - Z70*Z953 + Z92*Z964 + Z335*Z910 + Z344*Z931;
Z2401 = Z85*Z943 - Z70*Z954 + Z92*Z965 + Z335*Z911 + Z344*Z932;
Z2402 = Z85*Z944 - Z70*Z955 + Z92*Z966 + Z335*Z912 + Z344*Z933;
Z2403 = Z85*Z945 - Z70*Z956 + Z92*Z967 + Z335*Z913 + Z344*Z934;
Z2404 = Z85*Z946 - Z70*Z957 + Z92*Z968 + Z335*Z914 + Z344*Z935;
Z2405 = Z85*Z947 - Z70*Z958 + Z92*Z969 + Z335*Z915 + Z344*Z936;
Z2406 = Z85*Z948 - Z70*Z959 + Z92*Z970 + Z335*Z916 + Z344*Z937;
Z2407 = Z85*Z949 - Z70*Z960 + Z92*Z971 + Z335*Z917 + Z344*Z938;
 
LHS_8l_6l = Z2397*ddx+Z2398*ddpsi+Z2399*ddq_imu+Z2400*ddq_w+Z2401*ddq_torso+Z2402*ddq_1l+Z2403*ddq_2l+Z2404*ddq_3l+Z2405*ddq_4l+Z2406*ddq_5l+Z2407;
 
% LHS_9l_6l = 
%
%      (Z102*Z1019 - Z85*Z1007 + Z110*Z1031 - Z335*Z972 + Z355*Z983 + Z364*Z995)*ddx + (Z102*Z1020 - Z85*Z1008 + Z110*Z1032 - Z335*Z973 + Z355*Z984 + Z364*Z996)*ddpsi + (Z102*Z1021 - Z85*Z1009 + Z110*Z1033 - Z335*Z974 + Z355*Z985 + Z364*Z997)*ddq_imu + (Z102*Z1022 - Z85*Z1010 + Z110*Z1034 - Z335*Z975 + Z355*Z986 + Z364*Z998)*ddq_w + (Z102*Z1024 - Z85*Z1012 + Z110*Z1036 - Z335*Z977 + Z355*Z988 + Z364*Z1000)*ddq_1l + (Z102*Z1025 - Z85*Z1013 + Z110*Z1037 - Z335*Z978 + Z355*Z989 + Z364*Z1001)*ddq_2l + (Z102*Z1026 - Z85*Z1014 + Z110*Z1038 - Z335*Z979 + Z355*Z990 + Z364*Z1002)*ddq_3l + (Z102*Z1027 - Z85*Z1015 + Z110*Z1039 - Z335*Z980 + Z355*Z991 + Z364*Z1003)*ddq_4l + (Z102*Z1028 - Z85*Z1016 + Z110*Z1040 - Z335*Z981 + Z355*Z992 + Z364*Z1004)*ddq_5l + (Z102*Z1029 - Z85*Z1017 + Z110*Z1041 + Z355*Z993 + Z364*Z1005)*ddq_6l + (Z102*(Z1030 + Z1023*ddq_torso) - Z85*(Z1018 + Z1011*ddq_torso) + Z110*(Z1042 + Z1035*ddq_torso) - Z335*(Z982 + Z976*ddq_torso) + Z355*(Z994 + Z987*ddq_torso) + Z364*(Z1006 + Z999*ddq_torso))
Z2408 = Z102*Z1019 - Z85*Z1007 + Z110*Z1031 - Z335*Z972 + Z355*Z983 + Z364*Z995;
Z2409 = Z102*Z1020 - Z85*Z1008 + Z110*Z1032 - Z335*Z973 + Z355*Z984 + Z364*Z996;
Z2410 = Z102*Z1021 - Z85*Z1009 + Z110*Z1033 - Z335*Z974 + Z355*Z985 + Z364*Z997;
Z2411 = Z102*Z1022 - Z85*Z1010 + Z110*Z1034 - Z335*Z975 + Z355*Z986 + Z364*Z998;
Z2412 = Z102*Z1023 - Z85*Z1011 + Z110*Z1035 - Z335*Z976 + Z355*Z987 + Z364*Z999;
Z2413 = Z102*Z1024 - Z85*Z1012 + Z110*Z1036 - Z335*Z977 + Z355*Z988 + Z364*Z1000;
Z2414 = Z102*Z1025 - Z85*Z1013 + Z110*Z1037 - Z335*Z978 + Z355*Z989 + Z364*Z1001;
Z2415 = Z102*Z1026 - Z85*Z1014 + Z110*Z1038 - Z335*Z979 + Z355*Z990 + Z364*Z1002;
Z2416 = Z102*Z1027 - Z85*Z1015 + Z110*Z1039 - Z335*Z980 + Z355*Z991 + Z364*Z1003;
Z2417 = Z102*Z1028 - Z85*Z1016 + Z110*Z1040 - Z335*Z981 + Z355*Z992 + Z364*Z1004;
Z2418 = Z102*Z1029 - Z85*Z1017 + Z110*Z1041 + Z355*Z993 + Z364*Z1005;
Z2419 = Z102*Z1030 - Z85*Z1018 + Z110*Z1042 - Z335*Z982 + Z355*Z994 + Z364*Z1006;
 
LHS_9l_6l = Z2408*ddx+Z2409*ddpsi+Z2410*ddq_imu+Z2411*ddq_w+Z2412*ddq_torso+Z2413*ddq_1l+Z2414*ddq_2l+Z2415*ddq_3l+Z2416*ddq_4l+Z2417*ddq_5l+Z2418*ddq_6l+Z2419;
 
% LHS_10l_6l = 
%
%      (Z121*Z1081 - Z102*Z1107 + Z130*Z1094 + Z375*Z1043 - Z355*Z1069 + Z386*Z1056)*ddx + (Z121*Z1082 - Z102*Z1108 + Z130*Z1095 + Z375*Z1044 - Z355*Z1070 + Z386*Z1057)*ddpsi + (Z121*Z1083 - Z102*Z1109 + Z130*Z1096 + Z375*Z1045 - Z355*Z1071 + Z386*Z1058)*ddq_imu + (Z121*Z1084 - Z102*Z1110 + Z130*Z1097 + Z375*Z1046 - Z355*Z1072 + Z386*Z1059)*ddq_w + (Z121*Z1086 - Z102*Z1112 + Z130*Z1099 + Z375*Z1048 - Z355*Z1074 + Z386*Z1061)*ddq_1l + (Z121*Z1087 - Z102*Z1113 + Z130*Z1100 + Z375*Z1049 - Z355*Z1075 + Z386*Z1062)*ddq_2l + (Z121*Z1088 - Z102*Z1114 + Z130*Z1101 + Z375*Z1050 - Z355*Z1076 + Z386*Z1063)*ddq_3l + (Z121*Z1089 - Z102*Z1115 + Z130*Z1102 + Z375*Z1051 - Z355*Z1077 + Z386*Z1064)*ddq_4l + (Z121*Z1090 - Z102*Z1116 + Z130*Z1103 + Z375*Z1052 - Z355*Z1078 + Z386*Z1065)*ddq_5l + (Z121*Z1091 - Z102*Z1117 + Z130*Z1104 + Z375*Z1053 - Z355*Z1079 + Z386*Z1066)*ddq_6l + (Z121*Z1092 - Z102*Z1118 + Z130*Z1105 + Z375*Z1054 + Z386*Z1067)*ddq_7l + (Z121*(Z1093 + Z1085*ddq_torso) - Z102*(Z1119 + Z1111*ddq_torso) + Z130*(Z1106 + Z1098*ddq_torso) + Z375*(Z1055 + Z1047*ddq_torso) - Z355*(Z1080 + Z1073*ddq_torso) + Z386*(Z1068 + Z1060*ddq_torso))
Z2420 = Z121*Z1081 - Z102*Z1107 + Z130*Z1094 + Z375*Z1043 - Z355*Z1069 + Z386*Z1056;
Z2421 = Z121*Z1082 - Z102*Z1108 + Z130*Z1095 + Z375*Z1044 - Z355*Z1070 + Z386*Z1057;
Z2422 = Z121*Z1083 - Z102*Z1109 + Z130*Z1096 + Z375*Z1045 - Z355*Z1071 + Z386*Z1058;
Z2423 = Z121*Z1084 - Z102*Z1110 + Z130*Z1097 + Z375*Z1046 - Z355*Z1072 + Z386*Z1059;
Z2424 = Z121*Z1085 - Z102*Z1111 + Z130*Z1098 + Z375*Z1047 - Z355*Z1073 + Z386*Z1060;
Z2425 = Z121*Z1086 - Z102*Z1112 + Z130*Z1099 + Z375*Z1048 - Z355*Z1074 + Z386*Z1061;
Z2426 = Z121*Z1087 - Z102*Z1113 + Z130*Z1100 + Z375*Z1049 - Z355*Z1075 + Z386*Z1062;
Z2427 = Z121*Z1088 - Z102*Z1114 + Z130*Z1101 + Z375*Z1050 - Z355*Z1076 + Z386*Z1063;
Z2428 = Z121*Z1089 - Z102*Z1115 + Z130*Z1102 + Z375*Z1051 - Z355*Z1077 + Z386*Z1064;
Z2429 = Z121*Z1090 - Z102*Z1116 + Z130*Z1103 + Z375*Z1052 - Z355*Z1078 + Z386*Z1065;
Z2430 = Z121*Z1091 - Z102*Z1117 + Z130*Z1104 + Z375*Z1053 - Z355*Z1079 + Z386*Z1066;
Z2431 = Z121*Z1092 - Z102*Z1118 + Z130*Z1105 + Z375*Z1054 + Z386*Z1067;
Z2432 = Z121*Z1093 - Z102*Z1119 + Z130*Z1106 + Z375*Z1055 - Z355*Z1080 + Z386*Z1068;
 
LHS_10l_6l = Z2420*ddx+Z2421*ddpsi+Z2422*ddq_imu+Z2423*ddq_w+Z2424*ddq_torso+Z2425*ddq_1l+Z2426*ddq_2l+Z2427*ddq_3l+Z2428*ddq_4l+Z2429*ddq_5l+Z2430*ddq_6l+Z2431*ddq_7l+Z2432;
 
% LHS_4r_6l = 
%
%      0
% LHS_5r_6l = 
%
%      0
% LHS_6r_6l = 
%
%      0
% LHS_7r_6l = 
%
%      0
% LHS_8r_6l = 
%
%      0
% LHS_9r_6l = 
%
%      0
% LHS_10r_6l = 
%
%      0
% LHS_L_7l = 
%
%      0
% LHS_R_7l = 
%
%      0
% LHS_1_7l = 
%
%      0
% LHS_2_7l = 
%
%      0
% LHS_3_7l = 
%
%      0
% LHS_4l_7l = 
%
%      0
% LHS_5l_7l = 
%
%      0
% LHS_6l_7l = 
%
%      0
% LHS_7l_7l = 
%
%      (-Z877)*ddx + (-Z878)*ddpsi + (-Z879)*ddq_imu + (-Z880)*ddq_w + (-Z882)*ddq_1l + (-Z883)*ddq_2l + (-Z884)*ddq_3l + (-Z885)*ddq_4l - (Z886 + Z881*ddq_torso)
LHS_7l_7l = -Z877*ddx-Z878*ddpsi-Z879*ddq_imu-Z880*ddq_w-Z881*ddq_torso-Z882*ddq_1l-Z883*ddq_2l-Z884*ddq_3l-Z885*ddq_4l+-Z886;
 
% LHS_8l_7l = 
%
%      (Z86*Z939 + Z93*Z961 + Z336*Z907 + Z345*Z928)*ddx + (Z86*Z940 + Z93*Z962 + Z336*Z908 + Z345*Z929)*ddpsi + (Z86*Z941 + Z93*Z963 + Z336*Z909 + Z345*Z930)*ddq_imu + (Z86*Z942 + Z93*Z964 + Z336*Z910 + Z345*Z931)*ddq_w + (Z86*Z944 + Z93*Z966 + Z336*Z912 + Z345*Z933)*ddq_1l + (Z86*Z945 + Z93*Z967 + Z336*Z913 + Z345*Z934)*ddq_2l + (Z86*Z946 + Z93*Z968 + Z336*Z914 + Z345*Z935)*ddq_3l + (Z86*Z947 + Z93*Z969 + Z336*Z915 + Z345*Z936)*ddq_4l + (Z86*Z948 + Z93*Z970 + Z336*Z916 + Z345*Z937)*ddq_5l + (Z86*(Z949 + Z943*ddq_torso) + Z93*(Z971 + Z965*ddq_torso) + Z336*(Z917 + Z911*ddq_torso) + Z345*(Z938 + Z932*ddq_torso))
Z2433 = Z86*Z939 + Z93*Z961 + Z336*Z907 + Z345*Z928;
Z2434 = Z86*Z940 + Z93*Z962 + Z336*Z908 + Z345*Z929;
Z2435 = Z86*Z941 + Z93*Z963 + Z336*Z909 + Z345*Z930;
Z2436 = Z86*Z942 + Z93*Z964 + Z336*Z910 + Z345*Z931;
Z2437 = Z86*Z943 + Z93*Z965 + Z336*Z911 + Z345*Z932;
Z2438 = Z86*Z944 + Z93*Z966 + Z336*Z912 + Z345*Z933;
Z2439 = Z86*Z945 + Z93*Z967 + Z336*Z913 + Z345*Z934;
Z2440 = Z86*Z946 + Z93*Z968 + Z336*Z914 + Z345*Z935;
Z2441 = Z86*Z947 + Z93*Z969 + Z336*Z915 + Z345*Z936;
Z2442 = Z86*Z948 + Z93*Z970 + Z336*Z916 + Z345*Z937;
Z2443 = Z86*Z949 + Z93*Z971 + Z336*Z917 + Z345*Z938;
 
LHS_8l_7l = Z2433*ddx+Z2434*ddpsi+Z2435*ddq_imu+Z2436*ddq_w+Z2437*ddq_torso+Z2438*ddq_1l+Z2439*ddq_2l+Z2440*ddq_3l+Z2441*ddq_4l+Z2442*ddq_5l+Z2443;
 
% LHS_9l_7l = 
%
%      (Z103*Z1019 - Z86*Z1007 + Z111*Z1031 - Z336*Z972 + Z356*Z983 + Z365*Z995)*ddx + (Z103*Z1020 - Z86*Z1008 + Z111*Z1032 - Z336*Z973 + Z356*Z984 + Z365*Z996)*ddpsi + (Z103*Z1021 - Z86*Z1009 + Z111*Z1033 - Z336*Z974 + Z356*Z985 + Z365*Z997)*ddq_imu + (Z103*Z1022 - Z86*Z1010 + Z111*Z1034 - Z336*Z975 + Z356*Z986 + Z365*Z998)*ddq_w + (Z103*Z1024 - Z86*Z1012 + Z111*Z1036 - Z336*Z977 + Z356*Z988 + Z365*Z1000)*ddq_1l + (Z103*Z1025 - Z86*Z1013 + Z111*Z1037 - Z336*Z978 + Z356*Z989 + Z365*Z1001)*ddq_2l + (Z103*Z1026 - Z86*Z1014 + Z111*Z1038 - Z336*Z979 + Z356*Z990 + Z365*Z1002)*ddq_3l + (Z103*Z1027 - Z86*Z1015 + Z111*Z1039 - Z336*Z980 + Z356*Z991 + Z365*Z1003)*ddq_4l + (Z103*Z1028 - Z86*Z1016 + Z111*Z1040 - Z336*Z981 + Z356*Z992 + Z365*Z1004)*ddq_5l + (Z103*Z1029 - Z86*Z1017 + Z111*Z1041 + Z356*Z993 + Z365*Z1005)*ddq_6l + (Z103*(Z1030 + Z1023*ddq_torso) - Z86*(Z1018 + Z1011*ddq_torso) + Z111*(Z1042 + Z1035*ddq_torso) - Z336*(Z982 + Z976*ddq_torso) + Z356*(Z994 + Z987*ddq_torso) + Z365*(Z1006 + Z999*ddq_torso))
Z2444 = Z103*Z1019 - Z86*Z1007 + Z111*Z1031 - Z336*Z972 + Z356*Z983 + Z365*Z995;
Z2445 = Z103*Z1020 - Z86*Z1008 + Z111*Z1032 - Z336*Z973 + Z356*Z984 + Z365*Z996;
Z2446 = Z103*Z1021 - Z86*Z1009 + Z111*Z1033 - Z336*Z974 + Z356*Z985 + Z365*Z997;
Z2447 = Z103*Z1022 - Z86*Z1010 + Z111*Z1034 - Z336*Z975 + Z356*Z986 + Z365*Z998;
Z2448 = Z103*Z1023 - Z86*Z1011 + Z111*Z1035 - Z336*Z976 + Z356*Z987 + Z365*Z999;
Z2449 = Z103*Z1024 - Z86*Z1012 + Z111*Z1036 - Z336*Z977 + Z356*Z988 + Z365*Z1000;
Z2450 = Z103*Z1025 - Z86*Z1013 + Z111*Z1037 - Z336*Z978 + Z356*Z989 + Z365*Z1001;
Z2451 = Z103*Z1026 - Z86*Z1014 + Z111*Z1038 - Z336*Z979 + Z356*Z990 + Z365*Z1002;
Z2452 = Z103*Z1027 - Z86*Z1015 + Z111*Z1039 - Z336*Z980 + Z356*Z991 + Z365*Z1003;
Z2453 = Z103*Z1028 - Z86*Z1016 + Z111*Z1040 - Z336*Z981 + Z356*Z992 + Z365*Z1004;
Z2454 = Z103*Z1029 - Z86*Z1017 + Z111*Z1041 + Z356*Z993 + Z365*Z1005;
Z2455 = Z103*Z1030 - Z86*Z1018 + Z111*Z1042 - Z336*Z982 + Z356*Z994 + Z365*Z1006;
 
LHS_9l_7l = Z2444*ddx+Z2445*ddpsi+Z2446*ddq_imu+Z2447*ddq_w+Z2448*ddq_torso+Z2449*ddq_1l+Z2450*ddq_2l+Z2451*ddq_3l+Z2452*ddq_4l+Z2453*ddq_5l+Z2454*ddq_6l+Z2455;
 
% LHS_10l_7l = 
%
%      (Z122*Z1081 - Z103*Z1107 + Z131*Z1094 + Z376*Z1043 - Z356*Z1069 + Z387*Z1056)*ddx + (Z122*Z1082 - Z103*Z1108 + Z131*Z1095 + Z376*Z1044 - Z356*Z1070 + Z387*Z1057)*ddpsi + (Z122*Z1083 - Z103*Z1109 + Z131*Z1096 + Z376*Z1045 - Z356*Z1071 + Z387*Z1058)*ddq_imu + (Z122*Z1084 - Z103*Z1110 + Z131*Z1097 + Z376*Z1046 - Z356*Z1072 + Z387*Z1059)*ddq_w + (Z122*Z1086 - Z103*Z1112 + Z131*Z1099 + Z376*Z1048 - Z356*Z1074 + Z387*Z1061)*ddq_1l + (Z122*Z1087 - Z103*Z1113 + Z131*Z1100 + Z376*Z1049 - Z356*Z1075 + Z387*Z1062)*ddq_2l + (Z122*Z1088 - Z103*Z1114 + Z131*Z1101 + Z376*Z1050 - Z356*Z1076 + Z387*Z1063)*ddq_3l + (Z122*Z1089 - Z103*Z1115 + Z131*Z1102 + Z376*Z1051 - Z356*Z1077 + Z387*Z1064)*ddq_4l + (Z122*Z1090 - Z103*Z1116 + Z131*Z1103 + Z376*Z1052 - Z356*Z1078 + Z387*Z1065)*ddq_5l + (Z122*Z1091 - Z103*Z1117 + Z131*Z1104 + Z376*Z1053 - Z356*Z1079 + Z387*Z1066)*ddq_6l + (Z122*Z1092 - Z103*Z1118 + Z131*Z1105 + Z376*Z1054 + Z387*Z1067)*ddq_7l + (Z122*(Z1093 + Z1085*ddq_torso) - Z103*(Z1119 + Z1111*ddq_torso) + Z131*(Z1106 + Z1098*ddq_torso) + Z376*(Z1055 + Z1047*ddq_torso) - Z356*(Z1080 + Z1073*ddq_torso) + Z387*(Z1068 + Z1060*ddq_torso))
Z2456 = Z122*Z1081 - Z103*Z1107 + Z131*Z1094 + Z376*Z1043 - Z356*Z1069 + Z387*Z1056;
Z2457 = Z122*Z1082 - Z103*Z1108 + Z131*Z1095 + Z376*Z1044 - Z356*Z1070 + Z387*Z1057;
Z2458 = Z122*Z1083 - Z103*Z1109 + Z131*Z1096 + Z376*Z1045 - Z356*Z1071 + Z387*Z1058;
Z2459 = Z122*Z1084 - Z103*Z1110 + Z131*Z1097 + Z376*Z1046 - Z356*Z1072 + Z387*Z1059;
Z2460 = Z122*Z1085 - Z103*Z1111 + Z131*Z1098 + Z376*Z1047 - Z356*Z1073 + Z387*Z1060;
Z2461 = Z122*Z1086 - Z103*Z1112 + Z131*Z1099 + Z376*Z1048 - Z356*Z1074 + Z387*Z1061;
Z2462 = Z122*Z1087 - Z103*Z1113 + Z131*Z1100 + Z376*Z1049 - Z356*Z1075 + Z387*Z1062;
Z2463 = Z122*Z1088 - Z103*Z1114 + Z131*Z1101 + Z376*Z1050 - Z356*Z1076 + Z387*Z1063;
Z2464 = Z122*Z1089 - Z103*Z1115 + Z131*Z1102 + Z376*Z1051 - Z356*Z1077 + Z387*Z1064;
Z2465 = Z122*Z1090 - Z103*Z1116 + Z131*Z1103 + Z376*Z1052 - Z356*Z1078 + Z387*Z1065;
Z2466 = Z122*Z1091 - Z103*Z1117 + Z131*Z1104 + Z376*Z1053 - Z356*Z1079 + Z387*Z1066;
Z2467 = Z122*Z1092 - Z103*Z1118 + Z131*Z1105 + Z376*Z1054 + Z387*Z1067;
Z2468 = Z122*Z1093 - Z103*Z1119 + Z131*Z1106 + Z376*Z1055 - Z356*Z1080 + Z387*Z1068;
 
LHS_10l_7l = Z2456*ddx+Z2457*ddpsi+Z2458*ddq_imu+Z2459*ddq_w+Z2460*ddq_torso+Z2461*ddq_1l+Z2462*ddq_2l+Z2463*ddq_3l+Z2464*ddq_4l+Z2465*ddq_5l+Z2466*ddq_6l+Z2467*ddq_7l+Z2468;
 
% LHS_4r_7l = 
%
%      0
% LHS_5r_7l = 
%
%      0
% LHS_6r_7l = 
%
%      0
% LHS_7r_7l = 
%
%      0
% LHS_8r_7l = 
%
%      0
% LHS_9r_7l = 
%
%      0
% LHS_10r_7l = 
%
%      0
% LHS_L_8l = 
%
%      0
% LHS_R_8l = 
%
%      0
% LHS_1_8l = 
%
%      0
% LHS_2_8l = 
%
%      0
% LHS_3_8l = 
%
%      0
% LHS_4l_8l = 
%
%      0
% LHS_5l_8l = 
%
%      0
% LHS_6l_8l = 
%
%      0
% LHS_7l_8l = 
%
%      0
% LHS_8l_8l = 
%
%      (-Z950)*ddx + (-Z951)*ddpsi + (-Z952)*ddq_imu + (-Z953)*ddq_w + (-Z955)*ddq_1l + (-Z956)*ddq_2l + (-Z957)*ddq_3l + (-Z958)*ddq_4l + (-Z959)*ddq_5l - (Z960 + Z954*ddq_torso)
LHS_8l_8l = -Z950*ddx-Z951*ddpsi-Z952*ddq_imu-Z953*ddq_w-Z954*ddq_torso-Z955*ddq_1l-Z956*ddq_2l-Z957*ddq_3l-Z958*ddq_4l-Z959*ddq_5l+-Z960;
 
% LHS_9l_8l = 
%
%      (Z104*Z1019 + Z112*Z1031)*ddx + (Z104*Z1020 + Z112*Z1032)*ddpsi + (Z104*Z1021 + Z112*Z1033)*ddq_imu + (Z104*Z1022 + Z112*Z1034)*ddq_w + (Z104*Z1024 + Z112*Z1036)*ddq_1l + (Z104*Z1025 + Z112*Z1037)*ddq_2l + (Z104*Z1026 + Z112*Z1038)*ddq_3l + (Z104*Z1027 + Z112*Z1039)*ddq_4l + (Z104*Z1028 + Z112*Z1040)*ddq_5l + (Z104*Z1029 + Z112*Z1041)*ddq_6l + (Z104*(Z1030 + Z1023*ddq_torso) + Z112*(Z1042 + Z1035*ddq_torso))
Z2469 = Z104*Z1019 + Z112*Z1031;
Z2470 = Z104*Z1020 + Z112*Z1032;
Z2471 = Z104*Z1021 + Z112*Z1033;
Z2472 = Z104*Z1022 + Z112*Z1034;
Z2473 = Z104*Z1023 + Z112*Z1035;
Z2474 = Z104*Z1024 + Z112*Z1036;
Z2475 = Z104*Z1025 + Z112*Z1037;
Z2476 = Z104*Z1026 + Z112*Z1038;
Z2477 = Z104*Z1027 + Z112*Z1039;
Z2478 = Z104*Z1028 + Z112*Z1040;
Z2479 = Z104*Z1029 + Z112*Z1041;
Z2480 = Z104*Z1030 + Z112*Z1042;
 
LHS_9l_8l = Z2469*ddx+Z2470*ddpsi+Z2471*ddq_imu+Z2472*ddq_w+Z2473*ddq_torso+Z2474*ddq_1l+Z2475*ddq_2l+Z2476*ddq_3l+Z2477*ddq_4l+Z2478*ddq_5l+Z2479*ddq_6l+Z2480;
 
% LHS_10l_8l = 
%
%      (Z123*Z1081 - Z104*Z1107 + Z132*Z1094 + Z377*Z1043 + Z388*Z1056)*ddx + (Z123*Z1082 - Z104*Z1108 + Z132*Z1095 + Z377*Z1044 + Z388*Z1057)*ddpsi + (Z123*Z1083 - Z104*Z1109 + Z132*Z1096 + Z377*Z1045 + Z388*Z1058)*ddq_imu + (Z123*Z1084 - Z104*Z1110 + Z132*Z1097 + Z377*Z1046 + Z388*Z1059)*ddq_w + (Z123*Z1086 - Z104*Z1112 + Z132*Z1099 + Z377*Z1048 + Z388*Z1061)*ddq_1l + (Z123*Z1087 - Z104*Z1113 + Z132*Z1100 + Z377*Z1049 + Z388*Z1062)*ddq_2l + (Z123*Z1088 - Z104*Z1114 + Z132*Z1101 + Z377*Z1050 + Z388*Z1063)*ddq_3l + (Z123*Z1089 - Z104*Z1115 + Z132*Z1102 + Z377*Z1051 + Z388*Z1064)*ddq_4l + (Z123*Z1090 - Z104*Z1116 + Z132*Z1103 + Z377*Z1052 + Z388*Z1065)*ddq_5l + (Z123*Z1091 - Z104*Z1117 + Z132*Z1104 + Z377*Z1053 + Z388*Z1066)*ddq_6l + (Z123*Z1092 - Z104*Z1118 + Z132*Z1105 + Z377*Z1054 + Z388*Z1067)*ddq_7l + (Z123*(Z1093 + Z1085*ddq_torso) - Z104*(Z1119 + Z1111*ddq_torso) + Z132*(Z1106 + Z1098*ddq_torso) + Z377*(Z1055 + Z1047*ddq_torso) + Z388*(Z1068 + Z1060*ddq_torso))
Z2481 = Z123*Z1081 - Z104*Z1107 + Z132*Z1094 + Z377*Z1043 + Z388*Z1056;
Z2482 = Z123*Z1082 - Z104*Z1108 + Z132*Z1095 + Z377*Z1044 + Z388*Z1057;
Z2483 = Z123*Z1083 - Z104*Z1109 + Z132*Z1096 + Z377*Z1045 + Z388*Z1058;
Z2484 = Z123*Z1084 - Z104*Z1110 + Z132*Z1097 + Z377*Z1046 + Z388*Z1059;
Z2485 = Z123*Z1085 - Z104*Z1111 + Z132*Z1098 + Z377*Z1047 + Z388*Z1060;
Z2486 = Z123*Z1086 - Z104*Z1112 + Z132*Z1099 + Z377*Z1048 + Z388*Z1061;
Z2487 = Z123*Z1087 - Z104*Z1113 + Z132*Z1100 + Z377*Z1049 + Z388*Z1062;
Z2488 = Z123*Z1088 - Z104*Z1114 + Z132*Z1101 + Z377*Z1050 + Z388*Z1063;
Z2489 = Z123*Z1089 - Z104*Z1115 + Z132*Z1102 + Z377*Z1051 + Z388*Z1064;
Z2490 = Z123*Z1090 - Z104*Z1116 + Z132*Z1103 + Z377*Z1052 + Z388*Z1065;
Z2491 = Z123*Z1091 - Z104*Z1117 + Z132*Z1104 + Z377*Z1053 + Z388*Z1066;
Z2492 = Z123*Z1092 - Z104*Z1118 + Z132*Z1105 + Z377*Z1054 + Z388*Z1067;
Z2493 = Z123*Z1093 - Z104*Z1119 + Z132*Z1106 + Z377*Z1055 + Z388*Z1068;
 
LHS_10l_8l = Z2481*ddx+Z2482*ddpsi+Z2483*ddq_imu+Z2484*ddq_w+Z2485*ddq_torso+Z2486*ddq_1l+Z2487*ddq_2l+Z2488*ddq_3l+Z2489*ddq_4l+Z2490*ddq_5l+Z2491*ddq_6l+Z2492*ddq_7l+Z2493;
 
% LHS_4r_8l = 
%
%      0
% LHS_5r_8l = 
%
%      0
% LHS_6r_8l = 
%
%      0
% LHS_7r_8l = 
%
%      0
% LHS_8r_8l = 
%
%      0
% LHS_9r_8l = 
%
%      0
% LHS_10r_8l = 
%
%      0
% LHS_L_9l = 
%
%      0
% LHS_R_9l = 
%
%      0
% LHS_1_9l = 
%
%      0
% LHS_2_9l = 
%
%      0
% LHS_3_9l = 
%
%      0
% LHS_4l_9l = 
%
%      0
% LHS_5l_9l = 
%
%      0
% LHS_6l_9l = 
%
%      0
% LHS_7l_9l = 
%
%      0
% LHS_8l_9l = 
%
%      0
% LHS_9l_9l = 
%
%      (-Z1007)*ddx + (-Z1008)*ddpsi + (-Z1009)*ddq_imu + (-Z1010)*ddq_w + (-Z1012)*ddq_1l + (-Z1013)*ddq_2l + (-Z1014)*ddq_3l + (-Z1015)*ddq_4l + (-Z1016)*ddq_5l + (-Z1017)*ddq_6l - (Z1018 + Z1011*ddq_torso)
LHS_9l_9l = -Z1007*ddx-Z1008*ddpsi-Z1009*ddq_imu-Z1010*ddq_w-Z1011*ddq_torso-Z1012*ddq_1l-Z1013*ddq_2l-Z1014*ddq_3l-Z1015*ddq_4l-Z1016*ddq_5l-Z1017*ddq_6l+-Z1018;
 
% LHS_10l_9l = 
%
%      (Z124*Z1081 + Z133*Z1094 + Z378*Z1043 + Z389*Z1056)*ddx + (Z124*Z1082 + Z133*Z1095 + Z378*Z1044 + Z389*Z1057)*ddpsi + (Z124*Z1083 + Z133*Z1096 + Z378*Z1045 + Z389*Z1058)*ddq_imu + (Z124*Z1084 + Z133*Z1097 + Z378*Z1046 + Z389*Z1059)*ddq_w + (Z124*Z1086 + Z133*Z1099 + Z378*Z1048 + Z389*Z1061)*ddq_1l + (Z124*Z1087 + Z133*Z1100 + Z378*Z1049 + Z389*Z1062)*ddq_2l + (Z124*Z1088 + Z133*Z1101 + Z378*Z1050 + Z389*Z1063)*ddq_3l + (Z124*Z1089 + Z133*Z1102 + Z378*Z1051 + Z389*Z1064)*ddq_4l + (Z124*Z1090 + Z133*Z1103 + Z378*Z1052 + Z389*Z1065)*ddq_5l + (Z124*Z1091 + Z133*Z1104 + Z378*Z1053 + Z389*Z1066)*ddq_6l + (Z124*Z1092 + Z133*Z1105 + Z378*Z1054 + Z389*Z1067)*ddq_7l + (Z124*(Z1093 + Z1085*ddq_torso) + Z133*(Z1106 + Z1098*ddq_torso) + Z378*(Z1055 + Z1047*ddq_torso) + Z389*(Z1068 + Z1060*ddq_torso))
Z2494 = Z124*Z1081 + Z133*Z1094 + Z378*Z1043 + Z389*Z1056;
Z2495 = Z124*Z1082 + Z133*Z1095 + Z378*Z1044 + Z389*Z1057;
Z2496 = Z124*Z1083 + Z133*Z1096 + Z378*Z1045 + Z389*Z1058;
Z2497 = Z124*Z1084 + Z133*Z1097 + Z378*Z1046 + Z389*Z1059;
Z2498 = Z124*Z1085 + Z133*Z1098 + Z378*Z1047 + Z389*Z1060;
Z2499 = Z124*Z1086 + Z133*Z1099 + Z378*Z1048 + Z389*Z1061;
Z2500 = Z124*Z1087 + Z133*Z1100 + Z378*Z1049 + Z389*Z1062;
Z2501 = Z124*Z1088 + Z133*Z1101 + Z378*Z1050 + Z389*Z1063;
Z2502 = Z124*Z1089 + Z133*Z1102 + Z378*Z1051 + Z389*Z1064;
Z2503 = Z124*Z1090 + Z133*Z1103 + Z378*Z1052 + Z389*Z1065;
Z2504 = Z124*Z1091 + Z133*Z1104 + Z378*Z1053 + Z389*Z1066;
Z2505 = Z124*Z1092 + Z133*Z1105 + Z378*Z1054 + Z389*Z1067;
Z2506 = Z124*Z1093 + Z133*Z1106 + Z378*Z1055 + Z389*Z1068;
 
LHS_10l_9l = Z2494*ddx+Z2495*ddpsi+Z2496*ddq_imu+Z2497*ddq_w+Z2498*ddq_torso+Z2499*ddq_1l+Z2500*ddq_2l+Z2501*ddq_3l+Z2502*ddq_4l+Z2503*ddq_5l+Z2504*ddq_6l+Z2505*ddq_7l+Z2506;
 
% LHS_4r_9l = 
%
%      0
% LHS_5r_9l = 
%
%      0
% LHS_6r_9l = 
%
%      0
% LHS_7r_9l = 
%
%      0
% LHS_8r_9l = 
%
%      0
% LHS_9r_9l = 
%
%      0
% LHS_10r_9l = 
%
%      0
% LHS_L_10l = 
%
%      0
% LHS_R_10l = 
%
%      0
% LHS_1_10l = 
%
%      0
% LHS_2_10l = 
%
%      0
% LHS_3_10l = 
%
%      0
% LHS_4l_10l = 
%
%      0
% LHS_5l_10l = 
%
%      0
% LHS_6l_10l = 
%
%      0
% LHS_7l_10l = 
%
%      0
% LHS_8l_10l = 
%
%      0
% LHS_9l_10l = 
%
%      0
% LHS_10l_10l = 
%
%      (-Z1107)*ddx + (-Z1108)*ddpsi + (-Z1109)*ddq_imu + (-Z1110)*ddq_w + (-Z1112)*ddq_1l + (-Z1113)*ddq_2l + (-Z1114)*ddq_3l + (-Z1115)*ddq_4l + (-Z1116)*ddq_5l + (-Z1117)*ddq_6l + (-Z1118)*ddq_7l - (Z1119 + Z1111*ddq_torso)
LHS_10l_10l = -Z1107*ddx-Z1108*ddpsi-Z1109*ddq_imu-Z1110*ddq_w-Z1111*ddq_torso-Z1112*ddq_1l-Z1113*ddq_2l-Z1114*ddq_3l-Z1115*ddq_4l-Z1116*ddq_5l-Z1117*ddq_6l-Z1118*ddq_7l+-Z1119;
 
% LHS_4r_10l = 
%
%      0
% LHS_5r_10l = 
%
%      0
% LHS_6r_10l = 
%
%      0
% LHS_7r_10l = 
%
%      0
% LHS_8r_10l = 
%
%      0
% LHS_9r_10l = 
%
%      0
% LHS_10r_10l = 
%
%      0
% LHS_L_4r = 
%
%      0
% LHS_R_4r = 
%
%      0
% LHS_1_4r = 
%
%      0
% LHS_2_4r = 
%
%      0
% LHS_3_4r = 
%
%      0
% LHS_4l_4r = 
%
%      0
% LHS_5l_4r = 
%
%      0
% LHS_6l_4r = 
%
%      0
% LHS_7l_4r = 
%
%      0
% LHS_8l_4r = 
%
%      0
% LHS_9l_4r = 
%
%      0
% LHS_10l_4r = 
%
%      0
% LHS_4r_4r = 
%
%      (-Z1147)*ddx + (-Z1148)*ddpsi + (-Z1149)*ddq_imu + (-Z1150)*ddq_w + (-Z1152)*ddq_1r - (Z1153 + Z1151*ddq_torso)
LHS_4r_4r = -Z1147*ddx-Z1148*ddpsi-Z1149*ddq_imu-Z1150*ddq_w-Z1151*ddq_torso-Z1152*ddq_1r+-Z1153;
 
% LHS_5r_4r = 
%
%      (Z149*Z1185 + Z153*Z1191)*ddx + (Z149*Z1186 + Z153*Z1192)*ddpsi + (Z149*Z1187 + Z153*Z1193)*ddq_imu + (Z149*Z1188 + Z153*Z1194)*ddq_w + (Z149*(Z1190 + Z1189*ddq_torso) + Z153*(Z1196 + Z1195*ddq_torso))
Z2507 = Z149*Z1185 + Z153*Z1191;
Z2508 = Z149*Z1186 + Z153*Z1192;
Z2509 = Z149*Z1187 + Z153*Z1193;
Z2510 = Z149*Z1188 + Z153*Z1194;
Z2511 = Z149*Z1189 + Z153*Z1195;
Z2512 = Z149*Z1190 + Z153*Z1196;
 
LHS_5r_4r = Z2507*ddx+Z2508*ddpsi+Z2509*ddq_imu+Z2510*ddq_w+Z2511*ddq_torso+Z2512;
 
% LHS_6r_4r = 
%
%      (Z160*Z1223 - Z149*Z1232 + Z165*Z1241 + Z425*Z1197 + Z432*Z1214)*ddx + (Z160*Z1224 - Z149*Z1233 + Z165*Z1242 + Z425*Z1198 + Z432*Z1215)*ddpsi + (Z160*Z1225 - Z149*Z1234 + Z165*Z1243 + Z425*Z1199 + Z432*Z1216)*ddq_imu + (Z160*Z1226 - Z149*Z1235 + Z165*Z1244 + Z425*Z1200 + Z432*Z1217)*ddq_w + (Z160*Z1228 - Z149*Z1237 + Z165*Z1246 + Z425*Z1202 + Z432*Z1219)*ddq_1r + (Z160*Z1229 - Z149*Z1238 + Z165*Z1247 + Z425*Z1203 + Z432*Z1220)*ddq_2r + (Z160*Z1230 - Z149*Z1239 + Z165*Z1248 + Z425*Z1204 + Z432*Z1221)*ddq_3r + (Z160*(Z1231 + Z1227*ddq_torso) - Z149*(Z1240 + Z1236*ddq_torso) + Z165*(Z1249 + Z1245*ddq_torso) + Z425*(Z1205 + Z1201*ddq_torso) + Z432*(Z1222 + Z1218*ddq_torso))
Z2513 = Z160*Z1223 - Z149*Z1232 + Z165*Z1241 + Z425*Z1197 + Z432*Z1214;
Z2514 = Z160*Z1224 - Z149*Z1233 + Z165*Z1242 + Z425*Z1198 + Z432*Z1215;
Z2515 = Z160*Z1225 - Z149*Z1234 + Z165*Z1243 + Z425*Z1199 + Z432*Z1216;
Z2516 = Z160*Z1226 - Z149*Z1235 + Z165*Z1244 + Z425*Z1200 + Z432*Z1217;
Z2517 = Z160*Z1227 - Z149*Z1236 + Z165*Z1245 + Z425*Z1201 + Z432*Z1218;
Z2518 = Z160*Z1228 - Z149*Z1237 + Z165*Z1246 + Z425*Z1202 + Z432*Z1219;
Z2519 = Z160*Z1229 - Z149*Z1238 + Z165*Z1247 + Z425*Z1203 + Z432*Z1220;
Z2520 = Z160*Z1230 - Z149*Z1239 + Z165*Z1248 + Z425*Z1204 + Z432*Z1221;
Z2521 = Z160*Z1231 - Z149*Z1240 + Z165*Z1249 + Z425*Z1205 + Z432*Z1222;
 
LHS_6r_4r = Z2513*ddx+Z2514*ddpsi+Z2515*ddq_imu+Z2516*ddq_w+Z2517*ddq_torso+Z2518*ddq_1r+Z2519*ddq_2r+Z2520*ddq_3r+Z2521;
 
% LHS_7r_4r = 
%
%      (Z173*Z1289 - Z160*Z1279 + Z179*Z1299 - Z425*Z1250 + Z441*Z1259 + Z448*Z1269)*ddx + (Z173*Z1290 - Z160*Z1280 + Z179*Z1300 - Z425*Z1251 + Z441*Z1260 + Z448*Z1270)*ddpsi + (Z173*Z1291 - Z160*Z1281 + Z179*Z1301 - Z425*Z1252 + Z441*Z1261 + Z448*Z1271)*ddq_imu + (Z173*Z1292 - Z160*Z1282 + Z179*Z1302 - Z425*Z1253 + Z441*Z1262 + Z448*Z1272)*ddq_w + (Z173*Z1294 - Z160*Z1284 + Z179*Z1304 - Z425*Z1255 + Z441*Z1264 + Z448*Z1274)*ddq_1r + (Z173*Z1295 - Z160*Z1285 + Z179*Z1305 - Z425*Z1256 + Z441*Z1265 + Z448*Z1275)*ddq_2r + (Z173*Z1296 - Z160*Z1286 + Z179*Z1306 - Z425*Z1257 + Z441*Z1266 + Z448*Z1276)*ddq_3r + (Z173*Z1297 - Z160*Z1287 + Z179*Z1307 + Z441*Z1267 + Z448*Z1277)*ddq_4r + (Z173*(Z1298 + Z1293*ddq_torso) - Z160*(Z1288 + Z1283*ddq_torso) + Z179*(Z1308 + Z1303*ddq_torso) - Z425*(Z1258 + Z1254*ddq_torso) + Z441*(Z1268 + Z1263*ddq_torso) + Z448*(Z1278 + Z1273*ddq_torso))
Z2522 = Z173*Z1289 - Z160*Z1279 + Z179*Z1299 - Z425*Z1250 + Z441*Z1259 + Z448*Z1269;
Z2523 = Z173*Z1290 - Z160*Z1280 + Z179*Z1300 - Z425*Z1251 + Z441*Z1260 + Z448*Z1270;
Z2524 = Z173*Z1291 - Z160*Z1281 + Z179*Z1301 - Z425*Z1252 + Z441*Z1261 + Z448*Z1271;
Z2525 = Z173*Z1292 - Z160*Z1282 + Z179*Z1302 - Z425*Z1253 + Z441*Z1262 + Z448*Z1272;
Z2526 = Z173*Z1293 - Z160*Z1283 + Z179*Z1303 - Z425*Z1254 + Z441*Z1263 + Z448*Z1273;
Z2527 = Z173*Z1294 - Z160*Z1284 + Z179*Z1304 - Z425*Z1255 + Z441*Z1264 + Z448*Z1274;
Z2528 = Z173*Z1295 - Z160*Z1285 + Z179*Z1305 - Z425*Z1256 + Z441*Z1265 + Z448*Z1275;
Z2529 = Z173*Z1296 - Z160*Z1286 + Z179*Z1306 - Z425*Z1257 + Z441*Z1266 + Z448*Z1276;
Z2530 = Z173*Z1297 - Z160*Z1287 + Z179*Z1307 + Z441*Z1267 + Z448*Z1277;
Z2531 = Z173*Z1298 - Z160*Z1288 + Z179*Z1308 - Z425*Z1258 + Z441*Z1268 + Z448*Z1278;
 
LHS_7r_4r = Z2522*ddx+Z2523*ddpsi+Z2524*ddq_imu+Z2525*ddq_w+Z2526*ddq_torso+Z2527*ddq_1r+Z2528*ddq_2r+Z2529*ddq_3r+Z2530*ddq_4r+Z2531;
 
% LHS_8r_4r = 
%
%      (Z188*Z1341 - Z173*Z1352 + Z195*Z1363 - Z441*Z1320 + Z457*Z1309 + Z466*Z1330)*ddx + (Z188*Z1342 - Z173*Z1353 + Z195*Z1364 - Z441*Z1321 + Z457*Z1310 + Z466*Z1331)*ddpsi + (Z188*Z1343 - Z173*Z1354 + Z195*Z1365 - Z441*Z1322 + Z457*Z1311 + Z466*Z1332)*ddq_imu + (Z188*Z1344 - Z173*Z1355 + Z195*Z1366 - Z441*Z1323 + Z457*Z1312 + Z466*Z1333)*ddq_w + (Z188*Z1346 - Z173*Z1357 + Z195*Z1368 - Z441*Z1325 + Z457*Z1314 + Z466*Z1335)*ddq_1r + (Z188*Z1347 - Z173*Z1358 + Z195*Z1369 - Z441*Z1326 + Z457*Z1315 + Z466*Z1336)*ddq_2r + (Z188*Z1348 - Z173*Z1359 + Z195*Z1370 - Z441*Z1327 + Z457*Z1316 + Z466*Z1337)*ddq_3r + (Z188*Z1349 - Z173*Z1360 + Z195*Z1371 - Z441*Z1328 + Z457*Z1317 + Z466*Z1338)*ddq_4r + (Z188*Z1350 - Z173*Z1361 + Z195*Z1372 + Z457*Z1318 + Z466*Z1339)*ddq_5r + (Z188*(Z1351 + Z1345*ddq_torso) - Z173*(Z1362 + Z1356*ddq_torso) + Z195*(Z1373 + Z1367*ddq_torso) + Z457*(Z1319 + Z1313*ddq_torso) - Z441*(Z1329 + Z1324*ddq_torso) + Z466*(Z1340 + Z1334*ddq_torso))
Z2532 = Z188*Z1341 - Z173*Z1352 + Z195*Z1363 - Z441*Z1320 + Z457*Z1309 + Z466*Z1330;
Z2533 = Z188*Z1342 - Z173*Z1353 + Z195*Z1364 - Z441*Z1321 + Z457*Z1310 + Z466*Z1331;
Z2534 = Z188*Z1343 - Z173*Z1354 + Z195*Z1365 - Z441*Z1322 + Z457*Z1311 + Z466*Z1332;
Z2535 = Z188*Z1344 - Z173*Z1355 + Z195*Z1366 - Z441*Z1323 + Z457*Z1312 + Z466*Z1333;
Z2536 = Z188*Z1345 - Z173*Z1356 + Z195*Z1367 - Z441*Z1324 + Z457*Z1313 + Z466*Z1334;
Z2537 = Z188*Z1346 - Z173*Z1357 + Z195*Z1368 - Z441*Z1325 + Z457*Z1314 + Z466*Z1335;
Z2538 = Z188*Z1347 - Z173*Z1358 + Z195*Z1369 - Z441*Z1326 + Z457*Z1315 + Z466*Z1336;
Z2539 = Z188*Z1348 - Z173*Z1359 + Z195*Z1370 - Z441*Z1327 + Z457*Z1316 + Z466*Z1337;
Z2540 = Z188*Z1349 - Z173*Z1360 + Z195*Z1371 - Z441*Z1328 + Z457*Z1317 + Z466*Z1338;
Z2541 = Z188*Z1350 - Z173*Z1361 + Z195*Z1372 + Z457*Z1318 + Z466*Z1339;
Z2542 = Z188*Z1351 - Z173*Z1362 + Z195*Z1373 - Z441*Z1329 + Z457*Z1319 + Z466*Z1340;
 
LHS_8r_4r = Z2532*ddx+Z2533*ddpsi+Z2534*ddq_imu+Z2535*ddq_w+Z2536*ddq_torso+Z2537*ddq_1r+Z2538*ddq_2r+Z2539*ddq_3r+Z2540*ddq_4r+Z2541*ddq_5r+Z2542;
 
% LHS_9r_4r = 
%
%      (Z205*Z1421 - Z188*Z1409 + Z213*Z1433 - Z457*Z1374 + Z477*Z1385 + Z486*Z1397)*ddx + (Z205*Z1422 - Z188*Z1410 + Z213*Z1434 - Z457*Z1375 + Z477*Z1386 + Z486*Z1398)*ddpsi + (Z205*Z1423 - Z188*Z1411 + Z213*Z1435 - Z457*Z1376 + Z477*Z1387 + Z486*Z1399)*ddq_imu + (Z205*Z1424 - Z188*Z1412 + Z213*Z1436 - Z457*Z1377 + Z477*Z1388 + Z486*Z1400)*ddq_w + (Z205*Z1426 - Z188*Z1414 + Z213*Z1438 - Z457*Z1379 + Z477*Z1390 + Z486*Z1402)*ddq_1r + (Z205*Z1427 - Z188*Z1415 + Z213*Z1439 - Z457*Z1380 + Z477*Z1391 + Z486*Z1403)*ddq_2r + (Z205*Z1428 - Z188*Z1416 + Z213*Z1440 - Z457*Z1381 + Z477*Z1392 + Z486*Z1404)*ddq_3r + (Z205*Z1429 - Z188*Z1417 + Z213*Z1441 - Z457*Z1382 + Z477*Z1393 + Z486*Z1405)*ddq_4r + (Z205*Z1430 - Z188*Z1418 + Z213*Z1442 - Z457*Z1383 + Z477*Z1394 + Z486*Z1406)*ddq_5r + (Z205*Z1431 - Z188*Z1419 + Z213*Z1443 + Z477*Z1395 + Z486*Z1407)*ddq_6r + (Z205*(Z1432 + Z1425*ddq_torso) - Z188*(Z1420 + Z1413*ddq_torso) + Z213*(Z1444 + Z1437*ddq_torso) - Z457*(Z1384 + Z1378*ddq_torso) + Z477*(Z1396 + Z1389*ddq_torso) + Z486*(Z1408 + Z1401*ddq_torso))
Z2543 = Z205*Z1421 - Z188*Z1409 + Z213*Z1433 - Z457*Z1374 + Z477*Z1385 + Z486*Z1397;
Z2544 = Z205*Z1422 - Z188*Z1410 + Z213*Z1434 - Z457*Z1375 + Z477*Z1386 + Z486*Z1398;
Z2545 = Z205*Z1423 - Z188*Z1411 + Z213*Z1435 - Z457*Z1376 + Z477*Z1387 + Z486*Z1399;
Z2546 = Z205*Z1424 - Z188*Z1412 + Z213*Z1436 - Z457*Z1377 + Z477*Z1388 + Z486*Z1400;
Z2547 = Z205*Z1425 - Z188*Z1413 + Z213*Z1437 - Z457*Z1378 + Z477*Z1389 + Z486*Z1401;
Z2548 = Z205*Z1426 - Z188*Z1414 + Z213*Z1438 - Z457*Z1379 + Z477*Z1390 + Z486*Z1402;
Z2549 = Z205*Z1427 - Z188*Z1415 + Z213*Z1439 - Z457*Z1380 + Z477*Z1391 + Z486*Z1403;
Z2550 = Z205*Z1428 - Z188*Z1416 + Z213*Z1440 - Z457*Z1381 + Z477*Z1392 + Z486*Z1404;
Z2551 = Z205*Z1429 - Z188*Z1417 + Z213*Z1441 - Z457*Z1382 + Z477*Z1393 + Z486*Z1405;
Z2552 = Z205*Z1430 - Z188*Z1418 + Z213*Z1442 - Z457*Z1383 + Z477*Z1394 + Z486*Z1406;
Z2553 = Z205*Z1431 - Z188*Z1419 + Z213*Z1443 + Z477*Z1395 + Z486*Z1407;
Z2554 = Z205*Z1432 - Z188*Z1420 + Z213*Z1444 - Z457*Z1384 + Z477*Z1396 + Z486*Z1408;
 
LHS_9r_4r = Z2543*ddx+Z2544*ddpsi+Z2545*ddq_imu+Z2546*ddq_w+Z2547*ddq_torso+Z2548*ddq_1r+Z2549*ddq_2r+Z2550*ddq_3r+Z2551*ddq_4r+Z2552*ddq_5r+Z2553*ddq_6r+Z2554;
 
% LHS_10r_4r = 
%
%      (Z224*Z1483 - Z205*Z1509 + Z233*Z1496 + Z497*Z1445 - Z477*Z1471 + Z508*Z1458)*ddx + (Z224*Z1484 - Z205*Z1510 + Z233*Z1497 + Z497*Z1446 - Z477*Z1472 + Z508*Z1459)*ddpsi + (Z224*Z1485 - Z205*Z1511 + Z233*Z1498 + Z497*Z1447 - Z477*Z1473 + Z508*Z1460)*ddq_imu + (Z224*Z1486 - Z205*Z1512 + Z233*Z1499 + Z497*Z1448 - Z477*Z1474 + Z508*Z1461)*ddq_w + (Z224*Z1488 - Z205*Z1514 + Z233*Z1501 + Z497*Z1450 - Z477*Z1476 + Z508*Z1463)*ddq_1r + (Z224*Z1489 - Z205*Z1515 + Z233*Z1502 + Z497*Z1451 - Z477*Z1477 + Z508*Z1464)*ddq_2r + (Z224*Z1490 - Z205*Z1516 + Z233*Z1503 + Z497*Z1452 - Z477*Z1478 + Z508*Z1465)*ddq_3r + (Z224*Z1491 - Z205*Z1517 + Z233*Z1504 + Z497*Z1453 - Z477*Z1479 + Z508*Z1466)*ddq_4r + (Z224*Z1492 - Z205*Z1518 + Z233*Z1505 + Z497*Z1454 - Z477*Z1480 + Z508*Z1467)*ddq_5r + (Z224*Z1493 - Z205*Z1519 + Z233*Z1506 + Z497*Z1455 - Z477*Z1481 + Z508*Z1468)*ddq_6r + (Z224*Z1494 - Z205*Z1520 + Z233*Z1507 + Z497*Z1456 + Z508*Z1469)*ddq_7r + (Z224*(Z1495 + Z1487*ddq_torso) - Z205*(Z1521 + Z1513*ddq_torso) + Z233*(Z1508 + Z1500*ddq_torso) + Z497*(Z1457 + Z1449*ddq_torso) - Z477*(Z1482 + Z1475*ddq_torso) + Z508*(Z1470 + Z1462*ddq_torso))
Z2555 = Z224*Z1483 - Z205*Z1509 + Z233*Z1496 + Z497*Z1445 - Z477*Z1471 + Z508*Z1458;
Z2556 = Z224*Z1484 - Z205*Z1510 + Z233*Z1497 + Z497*Z1446 - Z477*Z1472 + Z508*Z1459;
Z2557 = Z224*Z1485 - Z205*Z1511 + Z233*Z1498 + Z497*Z1447 - Z477*Z1473 + Z508*Z1460;
Z2558 = Z224*Z1486 - Z205*Z1512 + Z233*Z1499 + Z497*Z1448 - Z477*Z1474 + Z508*Z1461;
Z2559 = Z224*Z1487 - Z205*Z1513 + Z233*Z1500 + Z497*Z1449 - Z477*Z1475 + Z508*Z1462;
Z2560 = Z224*Z1488 - Z205*Z1514 + Z233*Z1501 + Z497*Z1450 - Z477*Z1476 + Z508*Z1463;
Z2561 = Z224*Z1489 - Z205*Z1515 + Z233*Z1502 + Z497*Z1451 - Z477*Z1477 + Z508*Z1464;
Z2562 = Z224*Z1490 - Z205*Z1516 + Z233*Z1503 + Z497*Z1452 - Z477*Z1478 + Z508*Z1465;
Z2563 = Z224*Z1491 - Z205*Z1517 + Z233*Z1504 + Z497*Z1453 - Z477*Z1479 + Z508*Z1466;
Z2564 = Z224*Z1492 - Z205*Z1518 + Z233*Z1505 + Z497*Z1454 - Z477*Z1480 + Z508*Z1467;
Z2565 = Z224*Z1493 - Z205*Z1519 + Z233*Z1506 + Z497*Z1455 - Z477*Z1481 + Z508*Z1468;
Z2566 = Z224*Z1494 - Z205*Z1520 + Z233*Z1507 + Z497*Z1456 + Z508*Z1469;
Z2567 = Z224*Z1495 - Z205*Z1521 + Z233*Z1508 + Z497*Z1457 - Z477*Z1482 + Z508*Z1470;
 
LHS_10r_4r = Z2555*ddx+Z2556*ddpsi+Z2557*ddq_imu+Z2558*ddq_w+Z2559*ddq_torso+Z2560*ddq_1r+Z2561*ddq_2r+Z2562*ddq_3r+Z2563*ddq_4r+Z2564*ddq_5r+Z2565*ddq_6r+Z2566*ddq_7r+Z2567;
 
% LHS_L_5r = 
%
%      0
% LHS_R_5r = 
%
%      0
% LHS_1_5r = 
%
%      0
% LHS_2_5r = 
%
%      0
% LHS_3_5r = 
%
%      0
% LHS_4l_5r = 
%
%      0
% LHS_5l_5r = 
%
%      0
% LHS_6l_5r = 
%
%      0
% LHS_7l_5r = 
%
%      0
% LHS_8l_5r = 
%
%      0
% LHS_9l_5r = 
%
%      0
% LHS_10l_5r = 
%
%      0
% LHS_4r_5r = 
%
%      0
% LHS_5r_5r = 
%
%      (-Z1179)*ddx + (-Z1180)*ddpsi + (-Z1181)*ddq_imu + (-Z1182)*ddq_w - (Z1184 + Z1183*ddq_torso)
LHS_5r_5r = -Z1179*ddx-Z1180*ddpsi-Z1181*ddq_imu-Z1182*ddq_w-Z1183*ddq_torso+-Z1184;
 
% LHS_6r_5r = 
%
%      (Z161*Z1223 + Z166*Z1241 + Z426*Z1197 + Z433*Z1214)*ddx + (Z161*Z1224 + Z166*Z1242 + Z426*Z1198 + Z433*Z1215)*ddpsi + (Z161*Z1225 + Z166*Z1243 + Z426*Z1199 + Z433*Z1216)*ddq_imu + (Z161*Z1226 + Z166*Z1244 + Z426*Z1200 + Z433*Z1217)*ddq_w + (Z161*Z1228 + Z166*Z1246 + Z426*Z1202 + Z433*Z1219)*ddq_1r + (Z161*Z1229 + Z166*Z1247 + Z426*Z1203 + Z433*Z1220)*ddq_2r + (Z161*Z1230 + Z166*Z1248 + Z426*Z1204 + Z433*Z1221)*ddq_3r + (Z161*(Z1231 + Z1227*ddq_torso) + Z166*(Z1249 + Z1245*ddq_torso) + Z426*(Z1205 + Z1201*ddq_torso) + Z433*(Z1222 + Z1218*ddq_torso))
Z2568 = Z161*Z1223 + Z166*Z1241 + Z426*Z1197 + Z433*Z1214;
Z2569 = Z161*Z1224 + Z166*Z1242 + Z426*Z1198 + Z433*Z1215;
Z2570 = Z161*Z1225 + Z166*Z1243 + Z426*Z1199 + Z433*Z1216;
Z2571 = Z161*Z1226 + Z166*Z1244 + Z426*Z1200 + Z433*Z1217;
Z2572 = Z161*Z1227 + Z166*Z1245 + Z426*Z1201 + Z433*Z1218;
Z2573 = Z161*Z1228 + Z166*Z1246 + Z426*Z1202 + Z433*Z1219;
Z2574 = Z161*Z1229 + Z166*Z1247 + Z426*Z1203 + Z433*Z1220;
Z2575 = Z161*Z1230 + Z166*Z1248 + Z426*Z1204 + Z433*Z1221;
Z2576 = Z161*Z1231 + Z166*Z1249 + Z426*Z1205 + Z433*Z1222;
 
LHS_6r_5r = Z2568*ddx+Z2569*ddpsi+Z2570*ddq_imu+Z2571*ddq_w+Z2572*ddq_torso+Z2573*ddq_1r+Z2574*ddq_2r+Z2575*ddq_3r+Z2576;
 
% LHS_7r_5r = 
%
%      (Z174*Z1289 - Z161*Z1279 + Z180*Z1299 - Z426*Z1250 + Z442*Z1259 + Z449*Z1269)*ddx + (Z174*Z1290 - Z161*Z1280 + Z180*Z1300 - Z426*Z1251 + Z442*Z1260 + Z449*Z1270)*ddpsi + (Z174*Z1291 - Z161*Z1281 + Z180*Z1301 - Z426*Z1252 + Z442*Z1261 + Z449*Z1271)*ddq_imu + (Z174*Z1292 - Z161*Z1282 + Z180*Z1302 - Z426*Z1253 + Z442*Z1262 + Z449*Z1272)*ddq_w + (Z174*Z1294 - Z161*Z1284 + Z180*Z1304 - Z426*Z1255 + Z442*Z1264 + Z449*Z1274)*ddq_1r + (Z174*Z1295 - Z161*Z1285 + Z180*Z1305 - Z426*Z1256 + Z442*Z1265 + Z449*Z1275)*ddq_2r + (Z174*Z1296 - Z161*Z1286 + Z180*Z1306 - Z426*Z1257 + Z442*Z1266 + Z449*Z1276)*ddq_3r + (Z174*Z1297 - Z161*Z1287 + Z180*Z1307 + Z442*Z1267 + Z449*Z1277)*ddq_4r + (Z174*(Z1298 + Z1293*ddq_torso) - Z161*(Z1288 + Z1283*ddq_torso) + Z180*(Z1308 + Z1303*ddq_torso) - Z426*(Z1258 + Z1254*ddq_torso) + Z442*(Z1268 + Z1263*ddq_torso) + Z449*(Z1278 + Z1273*ddq_torso))
Z2577 = Z174*Z1289 - Z161*Z1279 + Z180*Z1299 - Z426*Z1250 + Z442*Z1259 + Z449*Z1269;
Z2578 = Z174*Z1290 - Z161*Z1280 + Z180*Z1300 - Z426*Z1251 + Z442*Z1260 + Z449*Z1270;
Z2579 = Z174*Z1291 - Z161*Z1281 + Z180*Z1301 - Z426*Z1252 + Z442*Z1261 + Z449*Z1271;
Z2580 = Z174*Z1292 - Z161*Z1282 + Z180*Z1302 - Z426*Z1253 + Z442*Z1262 + Z449*Z1272;
Z2581 = Z174*Z1293 - Z161*Z1283 + Z180*Z1303 - Z426*Z1254 + Z442*Z1263 + Z449*Z1273;
Z2582 = Z174*Z1294 - Z161*Z1284 + Z180*Z1304 - Z426*Z1255 + Z442*Z1264 + Z449*Z1274;
Z2583 = Z174*Z1295 - Z161*Z1285 + Z180*Z1305 - Z426*Z1256 + Z442*Z1265 + Z449*Z1275;
Z2584 = Z174*Z1296 - Z161*Z1286 + Z180*Z1306 - Z426*Z1257 + Z442*Z1266 + Z449*Z1276;
Z2585 = Z174*Z1297 - Z161*Z1287 + Z180*Z1307 + Z442*Z1267 + Z449*Z1277;
Z2586 = Z174*Z1298 - Z161*Z1288 + Z180*Z1308 - Z426*Z1258 + Z442*Z1268 + Z449*Z1278;
 
LHS_7r_5r = Z2577*ddx+Z2578*ddpsi+Z2579*ddq_imu+Z2580*ddq_w+Z2581*ddq_torso+Z2582*ddq_1r+Z2583*ddq_2r+Z2584*ddq_3r+Z2585*ddq_4r+Z2586;
 
% LHS_8r_5r = 
%
%      (Z189*Z1341 - Z174*Z1352 + Z196*Z1363 - Z442*Z1320 + Z458*Z1309 + Z467*Z1330)*ddx + (Z189*Z1342 - Z174*Z1353 + Z196*Z1364 - Z442*Z1321 + Z458*Z1310 + Z467*Z1331)*ddpsi + (Z189*Z1343 - Z174*Z1354 + Z196*Z1365 - Z442*Z1322 + Z458*Z1311 + Z467*Z1332)*ddq_imu + (Z189*Z1344 - Z174*Z1355 + Z196*Z1366 - Z442*Z1323 + Z458*Z1312 + Z467*Z1333)*ddq_w + (Z189*Z1346 - Z174*Z1357 + Z196*Z1368 - Z442*Z1325 + Z458*Z1314 + Z467*Z1335)*ddq_1r + (Z189*Z1347 - Z174*Z1358 + Z196*Z1369 - Z442*Z1326 + Z458*Z1315 + Z467*Z1336)*ddq_2r + (Z189*Z1348 - Z174*Z1359 + Z196*Z1370 - Z442*Z1327 + Z458*Z1316 + Z467*Z1337)*ddq_3r + (Z189*Z1349 - Z174*Z1360 + Z196*Z1371 - Z442*Z1328 + Z458*Z1317 + Z467*Z1338)*ddq_4r + (Z189*Z1350 - Z174*Z1361 + Z196*Z1372 + Z458*Z1318 + Z467*Z1339)*ddq_5r + (Z189*(Z1351 + Z1345*ddq_torso) - Z174*(Z1362 + Z1356*ddq_torso) + Z196*(Z1373 + Z1367*ddq_torso) + Z458*(Z1319 + Z1313*ddq_torso) - Z442*(Z1329 + Z1324*ddq_torso) + Z467*(Z1340 + Z1334*ddq_torso))
Z2587 = Z189*Z1341 - Z174*Z1352 + Z196*Z1363 - Z442*Z1320 + Z458*Z1309 + Z467*Z1330;
Z2588 = Z189*Z1342 - Z174*Z1353 + Z196*Z1364 - Z442*Z1321 + Z458*Z1310 + Z467*Z1331;
Z2589 = Z189*Z1343 - Z174*Z1354 + Z196*Z1365 - Z442*Z1322 + Z458*Z1311 + Z467*Z1332;
Z2590 = Z189*Z1344 - Z174*Z1355 + Z196*Z1366 - Z442*Z1323 + Z458*Z1312 + Z467*Z1333;
Z2591 = Z189*Z1345 - Z174*Z1356 + Z196*Z1367 - Z442*Z1324 + Z458*Z1313 + Z467*Z1334;
Z2592 = Z189*Z1346 - Z174*Z1357 + Z196*Z1368 - Z442*Z1325 + Z458*Z1314 + Z467*Z1335;
Z2593 = Z189*Z1347 - Z174*Z1358 + Z196*Z1369 - Z442*Z1326 + Z458*Z1315 + Z467*Z1336;
Z2594 = Z189*Z1348 - Z174*Z1359 + Z196*Z1370 - Z442*Z1327 + Z458*Z1316 + Z467*Z1337;
Z2595 = Z189*Z1349 - Z174*Z1360 + Z196*Z1371 - Z442*Z1328 + Z458*Z1317 + Z467*Z1338;
Z2596 = Z189*Z1350 - Z174*Z1361 + Z196*Z1372 + Z458*Z1318 + Z467*Z1339;
Z2597 = Z189*Z1351 - Z174*Z1362 + Z196*Z1373 - Z442*Z1329 + Z458*Z1319 + Z467*Z1340;
 
LHS_8r_5r = Z2587*ddx+Z2588*ddpsi+Z2589*ddq_imu+Z2590*ddq_w+Z2591*ddq_torso+Z2592*ddq_1r+Z2593*ddq_2r+Z2594*ddq_3r+Z2595*ddq_4r+Z2596*ddq_5r+Z2597;
 
% LHS_9r_5r = 
%
%      (Z206*Z1421 - Z189*Z1409 + Z214*Z1433 - Z458*Z1374 + Z478*Z1385 + Z487*Z1397)*ddx + (Z206*Z1422 - Z189*Z1410 + Z214*Z1434 - Z458*Z1375 + Z478*Z1386 + Z487*Z1398)*ddpsi + (Z206*Z1423 - Z189*Z1411 + Z214*Z1435 - Z458*Z1376 + Z478*Z1387 + Z487*Z1399)*ddq_imu + (Z206*Z1424 - Z189*Z1412 + Z214*Z1436 - Z458*Z1377 + Z478*Z1388 + Z487*Z1400)*ddq_w + (Z206*Z1426 - Z189*Z1414 + Z214*Z1438 - Z458*Z1379 + Z478*Z1390 + Z487*Z1402)*ddq_1r + (Z206*Z1427 - Z189*Z1415 + Z214*Z1439 - Z458*Z1380 + Z478*Z1391 + Z487*Z1403)*ddq_2r + (Z206*Z1428 - Z189*Z1416 + Z214*Z1440 - Z458*Z1381 + Z478*Z1392 + Z487*Z1404)*ddq_3r + (Z206*Z1429 - Z189*Z1417 + Z214*Z1441 - Z458*Z1382 + Z478*Z1393 + Z487*Z1405)*ddq_4r + (Z206*Z1430 - Z189*Z1418 + Z214*Z1442 - Z458*Z1383 + Z478*Z1394 + Z487*Z1406)*ddq_5r + (Z206*Z1431 - Z189*Z1419 + Z214*Z1443 + Z478*Z1395 + Z487*Z1407)*ddq_6r + (Z206*(Z1432 + Z1425*ddq_torso) - Z189*(Z1420 + Z1413*ddq_torso) + Z214*(Z1444 + Z1437*ddq_torso) - Z458*(Z1384 + Z1378*ddq_torso) + Z478*(Z1396 + Z1389*ddq_torso) + Z487*(Z1408 + Z1401*ddq_torso))
Z2598 = Z206*Z1421 - Z189*Z1409 + Z214*Z1433 - Z458*Z1374 + Z478*Z1385 + Z487*Z1397;
Z2599 = Z206*Z1422 - Z189*Z1410 + Z214*Z1434 - Z458*Z1375 + Z478*Z1386 + Z487*Z1398;
Z2600 = Z206*Z1423 - Z189*Z1411 + Z214*Z1435 - Z458*Z1376 + Z478*Z1387 + Z487*Z1399;
Z2601 = Z206*Z1424 - Z189*Z1412 + Z214*Z1436 - Z458*Z1377 + Z478*Z1388 + Z487*Z1400;
Z2602 = Z206*Z1425 - Z189*Z1413 + Z214*Z1437 - Z458*Z1378 + Z478*Z1389 + Z487*Z1401;
Z2603 = Z206*Z1426 - Z189*Z1414 + Z214*Z1438 - Z458*Z1379 + Z478*Z1390 + Z487*Z1402;
Z2604 = Z206*Z1427 - Z189*Z1415 + Z214*Z1439 - Z458*Z1380 + Z478*Z1391 + Z487*Z1403;
Z2605 = Z206*Z1428 - Z189*Z1416 + Z214*Z1440 - Z458*Z1381 + Z478*Z1392 + Z487*Z1404;
Z2606 = Z206*Z1429 - Z189*Z1417 + Z214*Z1441 - Z458*Z1382 + Z478*Z1393 + Z487*Z1405;
Z2607 = Z206*Z1430 - Z189*Z1418 + Z214*Z1442 - Z458*Z1383 + Z478*Z1394 + Z487*Z1406;
Z2608 = Z206*Z1431 - Z189*Z1419 + Z214*Z1443 + Z478*Z1395 + Z487*Z1407;
Z2609 = Z206*Z1432 - Z189*Z1420 + Z214*Z1444 - Z458*Z1384 + Z478*Z1396 + Z487*Z1408;
 
LHS_9r_5r = Z2598*ddx+Z2599*ddpsi+Z2600*ddq_imu+Z2601*ddq_w+Z2602*ddq_torso+Z2603*ddq_1r+Z2604*ddq_2r+Z2605*ddq_3r+Z2606*ddq_4r+Z2607*ddq_5r+Z2608*ddq_6r+Z2609;
 
% LHS_10r_5r = 
%
%      (Z225*Z1483 - Z206*Z1509 + Z234*Z1496 + Z498*Z1445 - Z478*Z1471 + Z509*Z1458)*ddx + (Z225*Z1484 - Z206*Z1510 + Z234*Z1497 + Z498*Z1446 - Z478*Z1472 + Z509*Z1459)*ddpsi + (Z225*Z1485 - Z206*Z1511 + Z234*Z1498 + Z498*Z1447 - Z478*Z1473 + Z509*Z1460)*ddq_imu + (Z225*Z1486 - Z206*Z1512 + Z234*Z1499 + Z498*Z1448 - Z478*Z1474 + Z509*Z1461)*ddq_w + (Z225*Z1488 - Z206*Z1514 + Z234*Z1501 + Z498*Z1450 - Z478*Z1476 + Z509*Z1463)*ddq_1r + (Z225*Z1489 - Z206*Z1515 + Z234*Z1502 + Z498*Z1451 - Z478*Z1477 + Z509*Z1464)*ddq_2r + (Z225*Z1490 - Z206*Z1516 + Z234*Z1503 + Z498*Z1452 - Z478*Z1478 + Z509*Z1465)*ddq_3r + (Z225*Z1491 - Z206*Z1517 + Z234*Z1504 + Z498*Z1453 - Z478*Z1479 + Z509*Z1466)*ddq_4r + (Z225*Z1492 - Z206*Z1518 + Z234*Z1505 + Z498*Z1454 - Z478*Z1480 + Z509*Z1467)*ddq_5r + (Z225*Z1493 - Z206*Z1519 + Z234*Z1506 + Z498*Z1455 - Z478*Z1481 + Z509*Z1468)*ddq_6r + (Z225*Z1494 - Z206*Z1520 + Z234*Z1507 + Z498*Z1456 + Z509*Z1469)*ddq_7r + (Z225*(Z1495 + Z1487*ddq_torso) - Z206*(Z1521 + Z1513*ddq_torso) + Z234*(Z1508 + Z1500*ddq_torso) + Z498*(Z1457 + Z1449*ddq_torso) - Z478*(Z1482 + Z1475*ddq_torso) + Z509*(Z1470 + Z1462*ddq_torso))
Z2610 = Z225*Z1483 - Z206*Z1509 + Z234*Z1496 + Z498*Z1445 - Z478*Z1471 + Z509*Z1458;
Z2611 = Z225*Z1484 - Z206*Z1510 + Z234*Z1497 + Z498*Z1446 - Z478*Z1472 + Z509*Z1459;
Z2612 = Z225*Z1485 - Z206*Z1511 + Z234*Z1498 + Z498*Z1447 - Z478*Z1473 + Z509*Z1460;
Z2613 = Z225*Z1486 - Z206*Z1512 + Z234*Z1499 + Z498*Z1448 - Z478*Z1474 + Z509*Z1461;
Z2614 = Z225*Z1487 - Z206*Z1513 + Z234*Z1500 + Z498*Z1449 - Z478*Z1475 + Z509*Z1462;
Z2615 = Z225*Z1488 - Z206*Z1514 + Z234*Z1501 + Z498*Z1450 - Z478*Z1476 + Z509*Z1463;
Z2616 = Z225*Z1489 - Z206*Z1515 + Z234*Z1502 + Z498*Z1451 - Z478*Z1477 + Z509*Z1464;
Z2617 = Z225*Z1490 - Z206*Z1516 + Z234*Z1503 + Z498*Z1452 - Z478*Z1478 + Z509*Z1465;
Z2618 = Z225*Z1491 - Z206*Z1517 + Z234*Z1504 + Z498*Z1453 - Z478*Z1479 + Z509*Z1466;
Z2619 = Z225*Z1492 - Z206*Z1518 + Z234*Z1505 + Z498*Z1454 - Z478*Z1480 + Z509*Z1467;
Z2620 = Z225*Z1493 - Z206*Z1519 + Z234*Z1506 + Z498*Z1455 - Z478*Z1481 + Z509*Z1468;
Z2621 = Z225*Z1494 - Z206*Z1520 + Z234*Z1507 + Z498*Z1456 + Z509*Z1469;
Z2622 = Z225*Z1495 - Z206*Z1521 + Z234*Z1508 + Z498*Z1457 - Z478*Z1482 + Z509*Z1470;
 
LHS_10r_5r = Z2610*ddx+Z2611*ddpsi+Z2612*ddq_imu+Z2613*ddq_w+Z2614*ddq_torso+Z2615*ddq_1r+Z2616*ddq_2r+Z2617*ddq_3r+Z2618*ddq_4r+Z2619*ddq_5r+Z2620*ddq_6r+Z2621*ddq_7r+Z2622;
 
% LHS_L_6r = 
%
%      0
% LHS_R_6r = 
%
%      0
% LHS_1_6r = 
%
%      0
% LHS_2_6r = 
%
%      0
% LHS_3_6r = 
%
%      0
% LHS_4l_6r = 
%
%      0
% LHS_5l_6r = 
%
%      0
% LHS_6l_6r = 
%
%      0
% LHS_7l_6r = 
%
%      0
% LHS_8l_6r = 
%
%      0
% LHS_9l_6r = 
%
%      0
% LHS_10l_6r = 
%
%      0
% LHS_4r_6r = 
%
%      0
% LHS_5r_6r = 
%
%      0
% LHS_6r_6r = 
%
%      (-Z1232)*ddx + (-Z1233)*ddpsi + (-Z1234)*ddq_imu + (-Z1235)*ddq_w + (-Z1237)*ddq_1r + (-Z1238)*ddq_2r + (-Z1239)*ddq_3r - (Z1240 + Z1236*ddq_torso)
LHS_6r_6r = -Z1232*ddx-Z1233*ddpsi-Z1234*ddq_imu-Z1235*ddq_w-Z1236*ddq_torso-Z1237*ddq_1r-Z1238*ddq_2r-Z1239*ddq_3r+-Z1240;
 
% LHS_7r_6r = 
%
%      (Z175*Z1289 + Z181*Z1299)*ddx + (Z175*Z1290 + Z181*Z1300)*ddpsi + (Z175*Z1291 + Z181*Z1301)*ddq_imu + (Z175*Z1292 + Z181*Z1302)*ddq_w + (Z175*Z1294 + Z181*Z1304)*ddq_1r + (Z175*Z1295 + Z181*Z1305)*ddq_2r + (Z175*Z1296 + Z181*Z1306)*ddq_3r + (Z175*Z1297 + Z181*Z1307)*ddq_4r + (Z175*(Z1298 + Z1293*ddq_torso) + Z181*(Z1308 + Z1303*ddq_torso))
Z2623 = Z175*Z1289 + Z181*Z1299;
Z2624 = Z175*Z1290 + Z181*Z1300;
Z2625 = Z175*Z1291 + Z181*Z1301;
Z2626 = Z175*Z1292 + Z181*Z1302;
Z2627 = Z175*Z1293 + Z181*Z1303;
Z2628 = Z175*Z1294 + Z181*Z1304;
Z2629 = Z175*Z1295 + Z181*Z1305;
Z2630 = Z175*Z1296 + Z181*Z1306;
Z2631 = Z175*Z1297 + Z181*Z1307;
Z2632 = Z175*Z1298 + Z181*Z1308;
 
LHS_7r_6r = Z2623*ddx+Z2624*ddpsi+Z2625*ddq_imu+Z2626*ddq_w+Z2627*ddq_torso+Z2628*ddq_1r+Z2629*ddq_2r+Z2630*ddq_3r+Z2631*ddq_4r+Z2632;
 
% LHS_8r_6r = 
%
%      (Z190*Z1341 - Z175*Z1352 + Z197*Z1363 + Z459*Z1309 + Z468*Z1330)*ddx + (Z190*Z1342 - Z175*Z1353 + Z197*Z1364 + Z459*Z1310 + Z468*Z1331)*ddpsi + (Z190*Z1343 - Z175*Z1354 + Z197*Z1365 + Z459*Z1311 + Z468*Z1332)*ddq_imu + (Z190*Z1344 - Z175*Z1355 + Z197*Z1366 + Z459*Z1312 + Z468*Z1333)*ddq_w + (Z190*Z1346 - Z175*Z1357 + Z197*Z1368 + Z459*Z1314 + Z468*Z1335)*ddq_1r + (Z190*Z1347 - Z175*Z1358 + Z197*Z1369 + Z459*Z1315 + Z468*Z1336)*ddq_2r + (Z190*Z1348 - Z175*Z1359 + Z197*Z1370 + Z459*Z1316 + Z468*Z1337)*ddq_3r + (Z190*Z1349 - Z175*Z1360 + Z197*Z1371 + Z459*Z1317 + Z468*Z1338)*ddq_4r + (Z190*Z1350 - Z175*Z1361 + Z197*Z1372 + Z459*Z1318 + Z468*Z1339)*ddq_5r + (Z190*(Z1351 + Z1345*ddq_torso) - Z175*(Z1362 + Z1356*ddq_torso) + Z197*(Z1373 + Z1367*ddq_torso) + Z459*(Z1319 + Z1313*ddq_torso) + Z468*(Z1340 + Z1334*ddq_torso))
Z2633 = Z190*Z1341 - Z175*Z1352 + Z197*Z1363 + Z459*Z1309 + Z468*Z1330;
Z2634 = Z190*Z1342 - Z175*Z1353 + Z197*Z1364 + Z459*Z1310 + Z468*Z1331;
Z2635 = Z190*Z1343 - Z175*Z1354 + Z197*Z1365 + Z459*Z1311 + Z468*Z1332;
Z2636 = Z190*Z1344 - Z175*Z1355 + Z197*Z1366 + Z459*Z1312 + Z468*Z1333;
Z2637 = Z190*Z1345 - Z175*Z1356 + Z197*Z1367 + Z459*Z1313 + Z468*Z1334;
Z2638 = Z190*Z1346 - Z175*Z1357 + Z197*Z1368 + Z459*Z1314 + Z468*Z1335;
Z2639 = Z190*Z1347 - Z175*Z1358 + Z197*Z1369 + Z459*Z1315 + Z468*Z1336;
Z2640 = Z190*Z1348 - Z175*Z1359 + Z197*Z1370 + Z459*Z1316 + Z468*Z1337;
Z2641 = Z190*Z1349 - Z175*Z1360 + Z197*Z1371 + Z459*Z1317 + Z468*Z1338;
Z2642 = Z190*Z1350 - Z175*Z1361 + Z197*Z1372 + Z459*Z1318 + Z468*Z1339;
Z2643 = Z190*Z1351 - Z175*Z1362 + Z197*Z1373 + Z459*Z1319 + Z468*Z1340;
 
LHS_8r_6r = Z2633*ddx+Z2634*ddpsi+Z2635*ddq_imu+Z2636*ddq_w+Z2637*ddq_torso+Z2638*ddq_1r+Z2639*ddq_2r+Z2640*ddq_3r+Z2641*ddq_4r+Z2642*ddq_5r+Z2643;
 
% LHS_9r_6r = 
%
%      (Z207*Z1421 - Z190*Z1409 + Z215*Z1433 - Z459*Z1374 + Z479*Z1385 + Z488*Z1397)*ddx + (Z207*Z1422 - Z190*Z1410 + Z215*Z1434 - Z459*Z1375 + Z479*Z1386 + Z488*Z1398)*ddpsi + (Z207*Z1423 - Z190*Z1411 + Z215*Z1435 - Z459*Z1376 + Z479*Z1387 + Z488*Z1399)*ddq_imu + (Z207*Z1424 - Z190*Z1412 + Z215*Z1436 - Z459*Z1377 + Z479*Z1388 + Z488*Z1400)*ddq_w + (Z207*Z1426 - Z190*Z1414 + Z215*Z1438 - Z459*Z1379 + Z479*Z1390 + Z488*Z1402)*ddq_1r + (Z207*Z1427 - Z190*Z1415 + Z215*Z1439 - Z459*Z1380 + Z479*Z1391 + Z488*Z1403)*ddq_2r + (Z207*Z1428 - Z190*Z1416 + Z215*Z1440 - Z459*Z1381 + Z479*Z1392 + Z488*Z1404)*ddq_3r + (Z207*Z1429 - Z190*Z1417 + Z215*Z1441 - Z459*Z1382 + Z479*Z1393 + Z488*Z1405)*ddq_4r + (Z207*Z1430 - Z190*Z1418 + Z215*Z1442 - Z459*Z1383 + Z479*Z1394 + Z488*Z1406)*ddq_5r + (Z207*Z1431 - Z190*Z1419 + Z215*Z1443 + Z479*Z1395 + Z488*Z1407)*ddq_6r + (Z207*(Z1432 + Z1425*ddq_torso) - Z190*(Z1420 + Z1413*ddq_torso) + Z215*(Z1444 + Z1437*ddq_torso) - Z459*(Z1384 + Z1378*ddq_torso) + Z479*(Z1396 + Z1389*ddq_torso) + Z488*(Z1408 + Z1401*ddq_torso))
Z2644 = Z207*Z1421 - Z190*Z1409 + Z215*Z1433 - Z459*Z1374 + Z479*Z1385 + Z488*Z1397;
Z2645 = Z207*Z1422 - Z190*Z1410 + Z215*Z1434 - Z459*Z1375 + Z479*Z1386 + Z488*Z1398;
Z2646 = Z207*Z1423 - Z190*Z1411 + Z215*Z1435 - Z459*Z1376 + Z479*Z1387 + Z488*Z1399;
Z2647 = Z207*Z1424 - Z190*Z1412 + Z215*Z1436 - Z459*Z1377 + Z479*Z1388 + Z488*Z1400;
Z2648 = Z207*Z1425 - Z190*Z1413 + Z215*Z1437 - Z459*Z1378 + Z479*Z1389 + Z488*Z1401;
Z2649 = Z207*Z1426 - Z190*Z1414 + Z215*Z1438 - Z459*Z1379 + Z479*Z1390 + Z488*Z1402;
Z2650 = Z207*Z1427 - Z190*Z1415 + Z215*Z1439 - Z459*Z1380 + Z479*Z1391 + Z488*Z1403;
Z2651 = Z207*Z1428 - Z190*Z1416 + Z215*Z1440 - Z459*Z1381 + Z479*Z1392 + Z488*Z1404;
Z2652 = Z207*Z1429 - Z190*Z1417 + Z215*Z1441 - Z459*Z1382 + Z479*Z1393 + Z488*Z1405;
Z2653 = Z207*Z1430 - Z190*Z1418 + Z215*Z1442 - Z459*Z1383 + Z479*Z1394 + Z488*Z1406;
Z2654 = Z207*Z1431 - Z190*Z1419 + Z215*Z1443 + Z479*Z1395 + Z488*Z1407;
Z2655 = Z207*Z1432 - Z190*Z1420 + Z215*Z1444 - Z459*Z1384 + Z479*Z1396 + Z488*Z1408;
 
LHS_9r_6r = Z2644*ddx+Z2645*ddpsi+Z2646*ddq_imu+Z2647*ddq_w+Z2648*ddq_torso+Z2649*ddq_1r+Z2650*ddq_2r+Z2651*ddq_3r+Z2652*ddq_4r+Z2653*ddq_5r+Z2654*ddq_6r+Z2655;
 
% LHS_10r_6r = 
%
%      (Z226*Z1483 - Z207*Z1509 + Z235*Z1496 + Z499*Z1445 - Z479*Z1471 + Z510*Z1458)*ddx + (Z226*Z1484 - Z207*Z1510 + Z235*Z1497 + Z499*Z1446 - Z479*Z1472 + Z510*Z1459)*ddpsi + (Z226*Z1485 - Z207*Z1511 + Z235*Z1498 + Z499*Z1447 - Z479*Z1473 + Z510*Z1460)*ddq_imu + (Z226*Z1486 - Z207*Z1512 + Z235*Z1499 + Z499*Z1448 - Z479*Z1474 + Z510*Z1461)*ddq_w + (Z226*Z1488 - Z207*Z1514 + Z235*Z1501 + Z499*Z1450 - Z479*Z1476 + Z510*Z1463)*ddq_1r + (Z226*Z1489 - Z207*Z1515 + Z235*Z1502 + Z499*Z1451 - Z479*Z1477 + Z510*Z1464)*ddq_2r + (Z226*Z1490 - Z207*Z1516 + Z235*Z1503 + Z499*Z1452 - Z479*Z1478 + Z510*Z1465)*ddq_3r + (Z226*Z1491 - Z207*Z1517 + Z235*Z1504 + Z499*Z1453 - Z479*Z1479 + Z510*Z1466)*ddq_4r + (Z226*Z1492 - Z207*Z1518 + Z235*Z1505 + Z499*Z1454 - Z479*Z1480 + Z510*Z1467)*ddq_5r + (Z226*Z1493 - Z207*Z1519 + Z235*Z1506 + Z499*Z1455 - Z479*Z1481 + Z510*Z1468)*ddq_6r + (Z226*Z1494 - Z207*Z1520 + Z235*Z1507 + Z499*Z1456 + Z510*Z1469)*ddq_7r + (Z226*(Z1495 + Z1487*ddq_torso) - Z207*(Z1521 + Z1513*ddq_torso) + Z235*(Z1508 + Z1500*ddq_torso) + Z499*(Z1457 + Z1449*ddq_torso) - Z479*(Z1482 + Z1475*ddq_torso) + Z510*(Z1470 + Z1462*ddq_torso))
Z2656 = Z226*Z1483 - Z207*Z1509 + Z235*Z1496 + Z499*Z1445 - Z479*Z1471 + Z510*Z1458;
Z2657 = Z226*Z1484 - Z207*Z1510 + Z235*Z1497 + Z499*Z1446 - Z479*Z1472 + Z510*Z1459;
Z2658 = Z226*Z1485 - Z207*Z1511 + Z235*Z1498 + Z499*Z1447 - Z479*Z1473 + Z510*Z1460;
Z2659 = Z226*Z1486 - Z207*Z1512 + Z235*Z1499 + Z499*Z1448 - Z479*Z1474 + Z510*Z1461;
Z2660 = Z226*Z1487 - Z207*Z1513 + Z235*Z1500 + Z499*Z1449 - Z479*Z1475 + Z510*Z1462;
Z2661 = Z226*Z1488 - Z207*Z1514 + Z235*Z1501 + Z499*Z1450 - Z479*Z1476 + Z510*Z1463;
Z2662 = Z226*Z1489 - Z207*Z1515 + Z235*Z1502 + Z499*Z1451 - Z479*Z1477 + Z510*Z1464;
Z2663 = Z226*Z1490 - Z207*Z1516 + Z235*Z1503 + Z499*Z1452 - Z479*Z1478 + Z510*Z1465;
Z2664 = Z226*Z1491 - Z207*Z1517 + Z235*Z1504 + Z499*Z1453 - Z479*Z1479 + Z510*Z1466;
Z2665 = Z226*Z1492 - Z207*Z1518 + Z235*Z1505 + Z499*Z1454 - Z479*Z1480 + Z510*Z1467;
Z2666 = Z226*Z1493 - Z207*Z1519 + Z235*Z1506 + Z499*Z1455 - Z479*Z1481 + Z510*Z1468;
Z2667 = Z226*Z1494 - Z207*Z1520 + Z235*Z1507 + Z499*Z1456 + Z510*Z1469;
Z2668 = Z226*Z1495 - Z207*Z1521 + Z235*Z1508 + Z499*Z1457 - Z479*Z1482 + Z510*Z1470;
 
LHS_10r_6r = Z2656*ddx+Z2657*ddpsi+Z2658*ddq_imu+Z2659*ddq_w+Z2660*ddq_torso+Z2661*ddq_1r+Z2662*ddq_2r+Z2663*ddq_3r+Z2664*ddq_4r+Z2665*ddq_5r+Z2666*ddq_6r+Z2667*ddq_7r+Z2668;
 
% LHS_L_7r = 
%
%      0
% LHS_R_7r = 
%
%      0
% LHS_1_7r = 
%
%      0
% LHS_2_7r = 
%
%      0
% LHS_3_7r = 
%
%      0
% LHS_4l_7r = 
%
%      0
% LHS_5l_7r = 
%
%      0
% LHS_6l_7r = 
%
%      0
% LHS_7l_7r = 
%
%      0
% LHS_8l_7r = 
%
%      0
% LHS_9l_7r = 
%
%      0
% LHS_10l_7r = 
%
%      0
% LHS_4r_7r = 
%
%      0
% LHS_5r_7r = 
%
%      0
% LHS_6r_7r = 
%
%      0
% LHS_7r_7r = 
%
%      (-Z1279)*ddx + (-Z1280)*ddpsi + (-Z1281)*ddq_imu + (-Z1282)*ddq_w + (-Z1284)*ddq_1r + (-Z1285)*ddq_2r + (-Z1286)*ddq_3r + (-Z1287)*ddq_4r - (Z1288 + Z1283*ddq_torso)
LHS_7r_7r = -Z1279*ddx-Z1280*ddpsi-Z1281*ddq_imu-Z1282*ddq_w-Z1283*ddq_torso-Z1284*ddq_1r-Z1285*ddq_2r-Z1286*ddq_3r-Z1287*ddq_4r+-Z1288;
 
% LHS_8r_7r = 
%
%      (Z191*Z1341 + Z198*Z1363 + Z460*Z1309 + Z469*Z1330)*ddx + (Z191*Z1342 + Z198*Z1364 + Z460*Z1310 + Z469*Z1331)*ddpsi + (Z191*Z1343 + Z198*Z1365 + Z460*Z1311 + Z469*Z1332)*ddq_imu + (Z191*Z1344 + Z198*Z1366 + Z460*Z1312 + Z469*Z1333)*ddq_w + (Z191*Z1346 + Z198*Z1368 + Z460*Z1314 + Z469*Z1335)*ddq_1r + (Z191*Z1347 + Z198*Z1369 + Z460*Z1315 + Z469*Z1336)*ddq_2r + (Z191*Z1348 + Z198*Z1370 + Z460*Z1316 + Z469*Z1337)*ddq_3r + (Z191*Z1349 + Z198*Z1371 + Z460*Z1317 + Z469*Z1338)*ddq_4r + (Z191*Z1350 + Z198*Z1372 + Z460*Z1318 + Z469*Z1339)*ddq_5r + (Z191*(Z1351 + Z1345*ddq_torso) + Z198*(Z1373 + Z1367*ddq_torso) + Z460*(Z1319 + Z1313*ddq_torso) + Z469*(Z1340 + Z1334*ddq_torso))
Z2669 = Z191*Z1341 + Z198*Z1363 + Z460*Z1309 + Z469*Z1330;
Z2670 = Z191*Z1342 + Z198*Z1364 + Z460*Z1310 + Z469*Z1331;
Z2671 = Z191*Z1343 + Z198*Z1365 + Z460*Z1311 + Z469*Z1332;
Z2672 = Z191*Z1344 + Z198*Z1366 + Z460*Z1312 + Z469*Z1333;
Z2673 = Z191*Z1345 + Z198*Z1367 + Z460*Z1313 + Z469*Z1334;
Z2674 = Z191*Z1346 + Z198*Z1368 + Z460*Z1314 + Z469*Z1335;
Z2675 = Z191*Z1347 + Z198*Z1369 + Z460*Z1315 + Z469*Z1336;
Z2676 = Z191*Z1348 + Z198*Z1370 + Z460*Z1316 + Z469*Z1337;
Z2677 = Z191*Z1349 + Z198*Z1371 + Z460*Z1317 + Z469*Z1338;
Z2678 = Z191*Z1350 + Z198*Z1372 + Z460*Z1318 + Z469*Z1339;
Z2679 = Z191*Z1351 + Z198*Z1373 + Z460*Z1319 + Z469*Z1340;
 
LHS_8r_7r = Z2669*ddx+Z2670*ddpsi+Z2671*ddq_imu+Z2672*ddq_w+Z2673*ddq_torso+Z2674*ddq_1r+Z2675*ddq_2r+Z2676*ddq_3r+Z2677*ddq_4r+Z2678*ddq_5r+Z2679;
 
% LHS_9r_7r = 
%
%      (Z208*Z1421 - Z191*Z1409 + Z216*Z1433 - Z460*Z1374 + Z480*Z1385 + Z489*Z1397)*ddx + (Z208*Z1422 - Z191*Z1410 + Z216*Z1434 - Z460*Z1375 + Z480*Z1386 + Z489*Z1398)*ddpsi + (Z208*Z1423 - Z191*Z1411 + Z216*Z1435 - Z460*Z1376 + Z480*Z1387 + Z489*Z1399)*ddq_imu + (Z208*Z1424 - Z191*Z1412 + Z216*Z1436 - Z460*Z1377 + Z480*Z1388 + Z489*Z1400)*ddq_w + (Z208*Z1426 - Z191*Z1414 + Z216*Z1438 - Z460*Z1379 + Z480*Z1390 + Z489*Z1402)*ddq_1r + (Z208*Z1427 - Z191*Z1415 + Z216*Z1439 - Z460*Z1380 + Z480*Z1391 + Z489*Z1403)*ddq_2r + (Z208*Z1428 - Z191*Z1416 + Z216*Z1440 - Z460*Z1381 + Z480*Z1392 + Z489*Z1404)*ddq_3r + (Z208*Z1429 - Z191*Z1417 + Z216*Z1441 - Z460*Z1382 + Z480*Z1393 + Z489*Z1405)*ddq_4r + (Z208*Z1430 - Z191*Z1418 + Z216*Z1442 - Z460*Z1383 + Z480*Z1394 + Z489*Z1406)*ddq_5r + (Z208*Z1431 - Z191*Z1419 + Z216*Z1443 + Z480*Z1395 + Z489*Z1407)*ddq_6r + (Z208*(Z1432 + Z1425*ddq_torso) - Z191*(Z1420 + Z1413*ddq_torso) + Z216*(Z1444 + Z1437*ddq_torso) - Z460*(Z1384 + Z1378*ddq_torso) + Z480*(Z1396 + Z1389*ddq_torso) + Z489*(Z1408 + Z1401*ddq_torso))
Z2680 = Z208*Z1421 - Z191*Z1409 + Z216*Z1433 - Z460*Z1374 + Z480*Z1385 + Z489*Z1397;
Z2681 = Z208*Z1422 - Z191*Z1410 + Z216*Z1434 - Z460*Z1375 + Z480*Z1386 + Z489*Z1398;
Z2682 = Z208*Z1423 - Z191*Z1411 + Z216*Z1435 - Z460*Z1376 + Z480*Z1387 + Z489*Z1399;
Z2683 = Z208*Z1424 - Z191*Z1412 + Z216*Z1436 - Z460*Z1377 + Z480*Z1388 + Z489*Z1400;
Z2684 = Z208*Z1425 - Z191*Z1413 + Z216*Z1437 - Z460*Z1378 + Z480*Z1389 + Z489*Z1401;
Z2685 = Z208*Z1426 - Z191*Z1414 + Z216*Z1438 - Z460*Z1379 + Z480*Z1390 + Z489*Z1402;
Z2686 = Z208*Z1427 - Z191*Z1415 + Z216*Z1439 - Z460*Z1380 + Z480*Z1391 + Z489*Z1403;
Z2687 = Z208*Z1428 - Z191*Z1416 + Z216*Z1440 - Z460*Z1381 + Z480*Z1392 + Z489*Z1404;
Z2688 = Z208*Z1429 - Z191*Z1417 + Z216*Z1441 - Z460*Z1382 + Z480*Z1393 + Z489*Z1405;
Z2689 = Z208*Z1430 - Z191*Z1418 + Z216*Z1442 - Z460*Z1383 + Z480*Z1394 + Z489*Z1406;
Z2690 = Z208*Z1431 - Z191*Z1419 + Z216*Z1443 + Z480*Z1395 + Z489*Z1407;
Z2691 = Z208*Z1432 - Z191*Z1420 + Z216*Z1444 - Z460*Z1384 + Z480*Z1396 + Z489*Z1408;
 
LHS_9r_7r = Z2680*ddx+Z2681*ddpsi+Z2682*ddq_imu+Z2683*ddq_w+Z2684*ddq_torso+Z2685*ddq_1r+Z2686*ddq_2r+Z2687*ddq_3r+Z2688*ddq_4r+Z2689*ddq_5r+Z2690*ddq_6r+Z2691;
 
% LHS_10r_7r = 
%
%      (Z227*Z1483 - Z208*Z1509 + Z236*Z1496 + Z500*Z1445 - Z480*Z1471 + Z511*Z1458)*ddx + (Z227*Z1484 - Z208*Z1510 + Z236*Z1497 + Z500*Z1446 - Z480*Z1472 + Z511*Z1459)*ddpsi + (Z227*Z1485 - Z208*Z1511 + Z236*Z1498 + Z500*Z1447 - Z480*Z1473 + Z511*Z1460)*ddq_imu + (Z227*Z1486 - Z208*Z1512 + Z236*Z1499 + Z500*Z1448 - Z480*Z1474 + Z511*Z1461)*ddq_w + (Z227*Z1488 - Z208*Z1514 + Z236*Z1501 + Z500*Z1450 - Z480*Z1476 + Z511*Z1463)*ddq_1r + (Z227*Z1489 - Z208*Z1515 + Z236*Z1502 + Z500*Z1451 - Z480*Z1477 + Z511*Z1464)*ddq_2r + (Z227*Z1490 - Z208*Z1516 + Z236*Z1503 + Z500*Z1452 - Z480*Z1478 + Z511*Z1465)*ddq_3r + (Z227*Z1491 - Z208*Z1517 + Z236*Z1504 + Z500*Z1453 - Z480*Z1479 + Z511*Z1466)*ddq_4r + (Z227*Z1492 - Z208*Z1518 + Z236*Z1505 + Z500*Z1454 - Z480*Z1480 + Z511*Z1467)*ddq_5r + (Z227*Z1493 - Z208*Z1519 + Z236*Z1506 + Z500*Z1455 - Z480*Z1481 + Z511*Z1468)*ddq_6r + (Z227*Z1494 - Z208*Z1520 + Z236*Z1507 + Z500*Z1456 + Z511*Z1469)*ddq_7r + (Z227*(Z1495 + Z1487*ddq_torso) - Z208*(Z1521 + Z1513*ddq_torso) + Z236*(Z1508 + Z1500*ddq_torso) + Z500*(Z1457 + Z1449*ddq_torso) - Z480*(Z1482 + Z1475*ddq_torso) + Z511*(Z1470 + Z1462*ddq_torso))
Z2692 = Z227*Z1483 - Z208*Z1509 + Z236*Z1496 + Z500*Z1445 - Z480*Z1471 + Z511*Z1458;
Z2693 = Z227*Z1484 - Z208*Z1510 + Z236*Z1497 + Z500*Z1446 - Z480*Z1472 + Z511*Z1459;
Z2694 = Z227*Z1485 - Z208*Z1511 + Z236*Z1498 + Z500*Z1447 - Z480*Z1473 + Z511*Z1460;
Z2695 = Z227*Z1486 - Z208*Z1512 + Z236*Z1499 + Z500*Z1448 - Z480*Z1474 + Z511*Z1461;
Z2696 = Z227*Z1487 - Z208*Z1513 + Z236*Z1500 + Z500*Z1449 - Z480*Z1475 + Z511*Z1462;
Z2697 = Z227*Z1488 - Z208*Z1514 + Z236*Z1501 + Z500*Z1450 - Z480*Z1476 + Z511*Z1463;
Z2698 = Z227*Z1489 - Z208*Z1515 + Z236*Z1502 + Z500*Z1451 - Z480*Z1477 + Z511*Z1464;
Z2699 = Z227*Z1490 - Z208*Z1516 + Z236*Z1503 + Z500*Z1452 - Z480*Z1478 + Z511*Z1465;
Z2700 = Z227*Z1491 - Z208*Z1517 + Z236*Z1504 + Z500*Z1453 - Z480*Z1479 + Z511*Z1466;
Z2701 = Z227*Z1492 - Z208*Z1518 + Z236*Z1505 + Z500*Z1454 - Z480*Z1480 + Z511*Z1467;
Z2702 = Z227*Z1493 - Z208*Z1519 + Z236*Z1506 + Z500*Z1455 - Z480*Z1481 + Z511*Z1468;
Z2703 = Z227*Z1494 - Z208*Z1520 + Z236*Z1507 + Z500*Z1456 + Z511*Z1469;
Z2704 = Z227*Z1495 - Z208*Z1521 + Z236*Z1508 + Z500*Z1457 - Z480*Z1482 + Z511*Z1470;
 
LHS_10r_7r = Z2692*ddx+Z2693*ddpsi+Z2694*ddq_imu+Z2695*ddq_w+Z2696*ddq_torso+Z2697*ddq_1r+Z2698*ddq_2r+Z2699*ddq_3r+Z2700*ddq_4r+Z2701*ddq_5r+Z2702*ddq_6r+Z2703*ddq_7r+Z2704;
 
% LHS_L_8r = 
%
%      0
% LHS_R_8r = 
%
%      0
% LHS_1_8r = 
%
%      0
% LHS_2_8r = 
%
%      0
% LHS_3_8r = 
%
%      0
% LHS_4l_8r = 
%
%      0
% LHS_5l_8r = 
%
%      0
% LHS_6l_8r = 
%
%      0
% LHS_7l_8r = 
%
%      0
% LHS_8l_8r = 
%
%      0
% LHS_9l_8r = 
%
%      0
% LHS_10l_8r = 
%
%      0
% LHS_4r_8r = 
%
%      0
% LHS_5r_8r = 
%
%      0
% LHS_6r_8r = 
%
%      0
% LHS_7r_8r = 
%
%      0
% LHS_8r_8r = 
%
%      (-Z1352)*ddx + (-Z1353)*ddpsi + (-Z1354)*ddq_imu + (-Z1355)*ddq_w + (-Z1357)*ddq_1r + (-Z1358)*ddq_2r + (-Z1359)*ddq_3r + (-Z1360)*ddq_4r + (-Z1361)*ddq_5r - (Z1362 + Z1356*ddq_torso)
LHS_8r_8r = -Z1352*ddx-Z1353*ddpsi-Z1354*ddq_imu-Z1355*ddq_w-Z1356*ddq_torso-Z1357*ddq_1r-Z1358*ddq_2r-Z1359*ddq_3r-Z1360*ddq_4r-Z1361*ddq_5r+-Z1362;
 
% LHS_9r_8r = 
%
%      (Z209*Z1421 + Z217*Z1433)*ddx + (Z209*Z1422 + Z217*Z1434)*ddpsi + (Z209*Z1423 + Z217*Z1435)*ddq_imu + (Z209*Z1424 + Z217*Z1436)*ddq_w + (Z209*Z1426 + Z217*Z1438)*ddq_1r + (Z209*Z1427 + Z217*Z1439)*ddq_2r + (Z209*Z1428 + Z217*Z1440)*ddq_3r + (Z209*Z1429 + Z217*Z1441)*ddq_4r + (Z209*Z1430 + Z217*Z1442)*ddq_5r + (Z209*Z1431 + Z217*Z1443)*ddq_6r + (Z209*(Z1432 + Z1425*ddq_torso) + Z217*(Z1444 + Z1437*ddq_torso))
Z2705 = Z209*Z1421 + Z217*Z1433;
Z2706 = Z209*Z1422 + Z217*Z1434;
Z2707 = Z209*Z1423 + Z217*Z1435;
Z2708 = Z209*Z1424 + Z217*Z1436;
Z2709 = Z209*Z1425 + Z217*Z1437;
Z2710 = Z209*Z1426 + Z217*Z1438;
Z2711 = Z209*Z1427 + Z217*Z1439;
Z2712 = Z209*Z1428 + Z217*Z1440;
Z2713 = Z209*Z1429 + Z217*Z1441;
Z2714 = Z209*Z1430 + Z217*Z1442;
Z2715 = Z209*Z1431 + Z217*Z1443;
Z2716 = Z209*Z1432 + Z217*Z1444;
 
LHS_9r_8r = Z2705*ddx+Z2706*ddpsi+Z2707*ddq_imu+Z2708*ddq_w+Z2709*ddq_torso+Z2710*ddq_1r+Z2711*ddq_2r+Z2712*ddq_3r+Z2713*ddq_4r+Z2714*ddq_5r+Z2715*ddq_6r+Z2716;
 
% LHS_10r_8r = 
%
%      (Z228*Z1483 - Z209*Z1509 + Z237*Z1496 + Z501*Z1445 + Z512*Z1458)*ddx + (Z228*Z1484 - Z209*Z1510 + Z237*Z1497 + Z501*Z1446 + Z512*Z1459)*ddpsi + (Z228*Z1485 - Z209*Z1511 + Z237*Z1498 + Z501*Z1447 + Z512*Z1460)*ddq_imu + (Z228*Z1486 - Z209*Z1512 + Z237*Z1499 + Z501*Z1448 + Z512*Z1461)*ddq_w + (Z228*Z1488 - Z209*Z1514 + Z237*Z1501 + Z501*Z1450 + Z512*Z1463)*ddq_1r + (Z228*Z1489 - Z209*Z1515 + Z237*Z1502 + Z501*Z1451 + Z512*Z1464)*ddq_2r + (Z228*Z1490 - Z209*Z1516 + Z237*Z1503 + Z501*Z1452 + Z512*Z1465)*ddq_3r + (Z228*Z1491 - Z209*Z1517 + Z237*Z1504 + Z501*Z1453 + Z512*Z1466)*ddq_4r + (Z228*Z1492 - Z209*Z1518 + Z237*Z1505 + Z501*Z1454 + Z512*Z1467)*ddq_5r + (Z228*Z1493 - Z209*Z1519 + Z237*Z1506 + Z501*Z1455 + Z512*Z1468)*ddq_6r + (Z228*Z1494 - Z209*Z1520 + Z237*Z1507 + Z501*Z1456 + Z512*Z1469)*ddq_7r + (Z228*(Z1495 + Z1487*ddq_torso) - Z209*(Z1521 + Z1513*ddq_torso) + Z237*(Z1508 + Z1500*ddq_torso) + Z501*(Z1457 + Z1449*ddq_torso) + Z512*(Z1470 + Z1462*ddq_torso))
Z2717 = Z228*Z1483 - Z209*Z1509 + Z237*Z1496 + Z501*Z1445 + Z512*Z1458;
Z2718 = Z228*Z1484 - Z209*Z1510 + Z237*Z1497 + Z501*Z1446 + Z512*Z1459;
Z2719 = Z228*Z1485 - Z209*Z1511 + Z237*Z1498 + Z501*Z1447 + Z512*Z1460;
Z2720 = Z228*Z1486 - Z209*Z1512 + Z237*Z1499 + Z501*Z1448 + Z512*Z1461;
Z2721 = Z228*Z1487 - Z209*Z1513 + Z237*Z1500 + Z501*Z1449 + Z512*Z1462;
Z2722 = Z228*Z1488 - Z209*Z1514 + Z237*Z1501 + Z501*Z1450 + Z512*Z1463;
Z2723 = Z228*Z1489 - Z209*Z1515 + Z237*Z1502 + Z501*Z1451 + Z512*Z1464;
Z2724 = Z228*Z1490 - Z209*Z1516 + Z237*Z1503 + Z501*Z1452 + Z512*Z1465;
Z2725 = Z228*Z1491 - Z209*Z1517 + Z237*Z1504 + Z501*Z1453 + Z512*Z1466;
Z2726 = Z228*Z1492 - Z209*Z1518 + Z237*Z1505 + Z501*Z1454 + Z512*Z1467;
Z2727 = Z228*Z1493 - Z209*Z1519 + Z237*Z1506 + Z501*Z1455 + Z512*Z1468;
Z2728 = Z228*Z1494 - Z209*Z1520 + Z237*Z1507 + Z501*Z1456 + Z512*Z1469;
Z2729 = Z228*Z1495 - Z209*Z1521 + Z237*Z1508 + Z501*Z1457 + Z512*Z1470;
 
LHS_10r_8r = Z2717*ddx+Z2718*ddpsi+Z2719*ddq_imu+Z2720*ddq_w+Z2721*ddq_torso+Z2722*ddq_1r+Z2723*ddq_2r+Z2724*ddq_3r+Z2725*ddq_4r+Z2726*ddq_5r+Z2727*ddq_6r+Z2728*ddq_7r+Z2729;
 
% LHS_L_9r = 
%
%      0
% LHS_R_9r = 
%
%      0
% LHS_1_9r = 
%
%      0
% LHS_2_9r = 
%
%      0
% LHS_3_9r = 
%
%      0
% LHS_4l_9r = 
%
%      0
% LHS_5l_9r = 
%
%      0
% LHS_6l_9r = 
%
%      0
% LHS_7l_9r = 
%
%      0
% LHS_8l_9r = 
%
%      0
% LHS_9l_9r = 
%
%      0
% LHS_10l_9r = 
%
%      0
% LHS_4r_9r = 
%
%      0
% LHS_5r_9r = 
%
%      0
% LHS_6r_9r = 
%
%      0
% LHS_7r_9r = 
%
%      0
% LHS_8r_9r = 
%
%      0
% LHS_9r_9r = 
%
%      (-Z1409)*ddx + (-Z1410)*ddpsi + (-Z1411)*ddq_imu + (-Z1412)*ddq_w + (-Z1414)*ddq_1r + (-Z1415)*ddq_2r + (-Z1416)*ddq_3r + (-Z1417)*ddq_4r + (-Z1418)*ddq_5r + (-Z1419)*ddq_6r - (Z1420 + Z1413*ddq_torso)
LHS_9r_9r = -Z1409*ddx-Z1410*ddpsi-Z1411*ddq_imu-Z1412*ddq_w-Z1413*ddq_torso-Z1414*ddq_1r-Z1415*ddq_2r-Z1416*ddq_3r-Z1417*ddq_4r-Z1418*ddq_5r-Z1419*ddq_6r+-Z1420;
 
% LHS_10r_9r = 
%
%      (Z229*Z1483 + Z238*Z1496 + Z502*Z1445 + Z513*Z1458)*ddx + (Z229*Z1484 + Z238*Z1497 + Z502*Z1446 + Z513*Z1459)*ddpsi + (Z229*Z1485 + Z238*Z1498 + Z502*Z1447 + Z513*Z1460)*ddq_imu + (Z229*Z1486 + Z238*Z1499 + Z502*Z1448 + Z513*Z1461)*ddq_w + (Z229*Z1488 + Z238*Z1501 + Z502*Z1450 + Z513*Z1463)*ddq_1r + (Z229*Z1489 + Z238*Z1502 + Z502*Z1451 + Z513*Z1464)*ddq_2r + (Z229*Z1490 + Z238*Z1503 + Z502*Z1452 + Z513*Z1465)*ddq_3r + (Z229*Z1491 + Z238*Z1504 + Z502*Z1453 + Z513*Z1466)*ddq_4r + (Z229*Z1492 + Z238*Z1505 + Z502*Z1454 + Z513*Z1467)*ddq_5r + (Z229*Z1493 + Z238*Z1506 + Z502*Z1455 + Z513*Z1468)*ddq_6r + (Z229*Z1494 + Z238*Z1507 + Z502*Z1456 + Z513*Z1469)*ddq_7r + (Z229*(Z1495 + Z1487*ddq_torso) + Z238*(Z1508 + Z1500*ddq_torso) + Z502*(Z1457 + Z1449*ddq_torso) + Z513*(Z1470 + Z1462*ddq_torso))
Z2730 = Z229*Z1483 + Z238*Z1496 + Z502*Z1445 + Z513*Z1458;
Z2731 = Z229*Z1484 + Z238*Z1497 + Z502*Z1446 + Z513*Z1459;
Z2732 = Z229*Z1485 + Z238*Z1498 + Z502*Z1447 + Z513*Z1460;
Z2733 = Z229*Z1486 + Z238*Z1499 + Z502*Z1448 + Z513*Z1461;
Z2734 = Z229*Z1487 + Z238*Z1500 + Z502*Z1449 + Z513*Z1462;
Z2735 = Z229*Z1488 + Z238*Z1501 + Z502*Z1450 + Z513*Z1463;
Z2736 = Z229*Z1489 + Z238*Z1502 + Z502*Z1451 + Z513*Z1464;
Z2737 = Z229*Z1490 + Z238*Z1503 + Z502*Z1452 + Z513*Z1465;
Z2738 = Z229*Z1491 + Z238*Z1504 + Z502*Z1453 + Z513*Z1466;
Z2739 = Z229*Z1492 + Z238*Z1505 + Z502*Z1454 + Z513*Z1467;
Z2740 = Z229*Z1493 + Z238*Z1506 + Z502*Z1455 + Z513*Z1468;
Z2741 = Z229*Z1494 + Z238*Z1507 + Z502*Z1456 + Z513*Z1469;
Z2742 = Z229*Z1495 + Z238*Z1508 + Z502*Z1457 + Z513*Z1470;
 
LHS_10r_9r = Z2730*ddx+Z2731*ddpsi+Z2732*ddq_imu+Z2733*ddq_w+Z2734*ddq_torso+Z2735*ddq_1r+Z2736*ddq_2r+Z2737*ddq_3r+Z2738*ddq_4r+Z2739*ddq_5r+Z2740*ddq_6r+Z2741*ddq_7r+Z2742;
 
% LHS_L_10r = 
%
%      0
% LHS_R_10r = 
%
%      0
% LHS_1_10r = 
%
%      0
% LHS_2_10r = 
%
%      0
% LHS_3_10r = 
%
%      0
% LHS_4l_10r = 
%
%      0
% LHS_5l_10r = 
%
%      0
% LHS_6l_10r = 
%
%      0
% LHS_7l_10r = 
%
%      0
% LHS_8l_10r = 
%
%      0
% LHS_9l_10r = 
%
%      0
% LHS_10l_10r = 
%
%      0
% LHS_4r_10r = 
%
%      0
% LHS_5r_10r = 
%
%      0
% LHS_6r_10r = 
%
%      0
% LHS_7r_10r = 
%
%      0
% LHS_8r_10r = 
%
%      0
% LHS_9r_10r = 
%
%      0
% LHS_10r_10r = 
%
%      (-Z1509)*ddx + (-Z1510)*ddpsi + (-Z1511)*ddq_imu + (-Z1512)*ddq_w + (-Z1514)*ddq_1r + (-Z1515)*ddq_2r + (-Z1516)*ddq_3r + (-Z1517)*ddq_4r + (-Z1518)*ddq_5r + (-Z1519)*ddq_6r + (-Z1520)*ddq_7r - (Z1521 + Z1513*ddq_torso)
LHS_10r_10r = -Z1509*ddx-Z1510*ddpsi-Z1511*ddq_imu-Z1512*ddq_w-Z1513*ddq_torso-Z1514*ddq_1r-Z1515*ddq_2r-Z1516*ddq_3r-Z1517*ddq_4r-Z1518*ddq_5r-Z1519*ddq_6r-Z1520*ddq_7r-Z1521;

%% LHS 

% LHS_x = 
%
%    Z1529 + Z1534 + Z1540 + Z1547 + Z1555 + Z1564 + Z1574 + Z1585 + Z1597 + Z1610 + Z1617 + Z1623 + Z1632 + Z1642 + Z1653 + Z1665 + Z1678 + Z1523*ddpsi + Z1525*ddpsi + Z1527*ddpsi + Z1531*ddpsi + Z1536*ddpsi + Z1542*ddpsi + Z1549*ddpsi + Z1557*ddpsi + Z1566*ddpsi + Z1576*ddpsi + Z1587*ddpsi + Z1599*ddpsi + Z1612*ddpsi + Z1619*ddpsi + Z1625*ddpsi + Z1634*ddpsi + Z1644*ddpsi + Z1655*ddpsi + Z1667*ddpsi + Z1533*ddq_w + Z1546*ddq_1l + Z1538*ddq_w + Z1553*ddq_1l + Z1544*ddq_w + Z1554*ddq_2l + Z1551*ddq_w + Z1561*ddq_1l + Z1562*ddq_2l + Z1563*ddq_3l + Z1559*ddq_w + Z1570*ddq_1l + Z1571*ddq_2l + Z1572*ddq_3l + Z1573*ddq_4l + Z1568*ddq_w + Z1580*ddq_1l + Z1581*ddq_2l + Z1582*ddq_3l + Z1583*ddq_4l + Z1578*ddq_w + Z1584*ddq_5l + Z1591*ddq_1l + Z1592*ddq_2l + Z1593*ddq_3l + Z1594*ddq_4l + Z1589*ddq_w + Z1595*ddq_5l + Z1596*ddq_6l + Z1603*ddq_1l + Z1604*ddq_2l + Z1605*ddq_3l + Z1606*ddq_4l + Z1601*ddq_w + Z1607*ddq_5l + Z1608*ddq_6l + Z1609*ddq_7l + Z1616*ddq_1r + Z1614*ddq_w + Z1621*ddq_w + Z1629*ddq_1r + Z1627*ddq_w + Z1630*ddq_2r + Z1631*ddq_3r + Z1638*ddq_1r + Z1636*ddq_w + Z1639*ddq_2r + Z1640*ddq_3r + Z1641*ddq_4r + Z1648*ddq_1r + Z1646*ddq_w + Z1649*ddq_2r + Z1650*ddq_3r + Z1651*ddq_4r + Z1652*ddq_5r + Z1659*ddq_1r + Z1657*ddq_w + Z1660*ddq_2r + Z1661*ddq_3r + Z1662*ddq_4r + Z1663*ddq_5r + Z1664*ddq_6r + Z1671*ddq_1r + Z1669*ddq_w + Z1672*ddq_2r + Z1673*ddq_3r + Z1674*ddq_4r + Z1675*ddq_5r + Z1676*ddq_6r + Z1677*ddq_7r + Z1528*ddq_imu + Z1532*ddq_imu + Z1537*ddq_imu + Z1543*ddq_imu + Z1550*ddq_imu + Z1558*ddq_imu + Z1567*ddq_imu + Z1577*ddq_imu + Z1588*ddq_imu + Z1600*ddq_imu + Z1613*ddq_imu + Z1620*ddq_imu + Z1626*ddq_imu + Z1635*ddq_imu + Z1645*ddq_imu + Z1656*ddq_imu + Z1668*ddq_imu + Z1539*ddq_torso + Z1545*ddq_torso + Z1552*ddq_torso + Z1560*ddq_torso + Z1569*ddq_torso + Z1579*ddq_torso + Z1590*ddq_torso + Z1602*ddq_torso + Z1615*ddq_torso + Z1622*ddq_torso + Z1628*ddq_torso + Z1637*ddq_torso + Z1647*ddq_torso + Z1658*ddq_torso + Z1670*ddq_torso + Z1522*ddx + Z1524*ddx + Z1526*ddx + Z1530*ddx + Z1535*ddx + Z1541*ddx + Z1548*ddx + Z1556*ddx + Z1565*ddx + Z1575*ddx + Z1586*ddx + Z1598*ddx + Z1611*ddx + Z1618*ddx + Z1624*ddx + Z1633*ddx + Z1643*ddx + Z1654*ddx + Z1666*ddx
Z2743 = Z1522 + Z1524 + Z1526 + Z1530 + Z1535 + Z1541 + Z1548 + Z1556 + Z1565 + Z1575 + Z1586 + Z1598 + Z1611 + Z1618 + Z1624 + Z1633 + Z1643 + Z1654 + Z1666;
Z2744 = Z1523 + Z1525 + Z1527 + Z1531 + Z1536 + Z1542 + Z1549 + Z1557 + Z1566 + Z1576 + Z1587 + Z1599 + Z1612 + Z1619 + Z1625 + Z1634 + Z1644 + Z1655 + Z1667;
Z2745 = Z1528 + Z1532 + Z1537 + Z1543 + Z1550 + Z1558 + Z1567 + Z1577 + Z1588 + Z1600 + Z1613 + Z1620 + Z1626 + Z1635 + Z1645 + Z1656 + Z1668;
Z2746 = Z1533 + Z1538 + Z1544 + Z1551 + Z1559 + Z1568 + Z1578 + Z1589 + Z1601 + Z1614 + Z1621 + Z1627 + Z1636 + Z1646 + Z1657 + Z1669;
Z2747 = Z1539 + Z1545 + Z1552 + Z1560 + Z1569 + Z1579 + Z1590 + Z1602 + Z1615 + Z1622 + Z1628 + Z1637 + Z1647 + Z1658 + Z1670;
Z2748 = Z1546 + Z1553 + Z1561 + Z1570 + Z1580 + Z1591 + Z1603;
Z2749 = Z1554 + Z1562 + Z1571 + Z1581 + Z1592 + Z1604;
Z2750 = Z1563 + Z1572 + Z1582 + Z1593 + Z1605;
Z2751 = Z1573 + Z1583 + Z1594 + Z1606;
Z2752 = Z1584 + Z1595 + Z1607;
Z2753 = Z1596 + Z1608;
Z2754 = Z1616 + Z1629 + Z1638 + Z1648 + Z1659 + Z1671;
Z2755 = Z1630 + Z1639 + Z1649 + Z1660 + Z1672;
Z2756 = Z1631 + Z1640 + Z1650 + Z1661 + Z1673;
Z2757 = Z1641 + Z1651 + Z1662 + Z1674;
Z2758 = Z1652 + Z1663 + Z1675;
Z2759 = Z1664 + Z1676;
Z2760 = Z1529 + Z1534 + Z1540 + Z1547 + Z1555 + Z1564 + Z1574 + Z1585 + Z1597 + Z1610 + Z1617 + Z1623 + Z1632 + Z1642 + Z1653 + Z1665 + Z1678;
 
LHS_x = Z2743*ddx+Z2744*ddpsi+Z2745*ddq_imu+Z2746*ddq_w+Z2747*ddq_torso+Z2748*ddq_1l+Z2749*ddq_2l+Z2750*ddq_3l+Z2751*ddq_4l+Z2752*ddq_5l+Z2753*ddq_6l+Z1609*ddq_7l+Z2754*ddq_1r+Z2755*ddq_2r+Z2756*ddq_3r+Z2757*ddq_4r+Z2758*ddq_5r+Z2759*ddq_6r+Z1677*ddq_7r+Z2760;
 
% LHS_psi = 
%
%    Z1681 + Z1684 + Z1688 + Z1693 + Z1699 + Z1706 + Z1714 + Z1723 + Z1733 + Z1744 + Z1756 + Z1769 + Z1776 + Z1782 + Z1791 + Z1801 + Z1812 + Z1824 + Z1837 + Z1680*ddpsi + Z1683*ddpsi + Z1686*ddpsi + Z1690*ddpsi + Z1695*ddpsi + Z1701*ddpsi + Z1708*ddpsi + Z1716*ddpsi + Z1725*ddpsi + Z1735*ddpsi + Z1746*ddpsi + Z1758*ddpsi + Z1771*ddpsi + Z1778*ddpsi + Z1784*ddpsi + Z1793*ddpsi + Z1803*ddpsi + Z1814*ddpsi + Z1826*ddpsi + Z1692*ddq_w + Z1705*ddq_1l + Z1697*ddq_w + Z1712*ddq_1l + Z1703*ddq_w + Z1713*ddq_2l + Z1710*ddq_w + Z1720*ddq_1l + Z1721*ddq_2l + Z1722*ddq_3l + Z1718*ddq_w + Z1729*ddq_1l + Z1730*ddq_2l + Z1731*ddq_3l + Z1732*ddq_4l + Z1727*ddq_w + Z1739*ddq_1l + Z1740*ddq_2l + Z1741*ddq_3l + Z1742*ddq_4l + Z1737*ddq_w + Z1743*ddq_5l + Z1750*ddq_1l + Z1751*ddq_2l + Z1752*ddq_3l + Z1753*ddq_4l + Z1748*ddq_w + Z1754*ddq_5l + Z1755*ddq_6l + Z1762*ddq_1l + Z1763*ddq_2l + Z1764*ddq_3l + Z1765*ddq_4l + Z1760*ddq_w + Z1766*ddq_5l + Z1767*ddq_6l + Z1768*ddq_7l + Z1775*ddq_1r + Z1773*ddq_w + Z1780*ddq_w + Z1788*ddq_1r + Z1786*ddq_w + Z1789*ddq_2r + Z1790*ddq_3r + Z1797*ddq_1r + Z1795*ddq_w + Z1798*ddq_2r + Z1799*ddq_3r + Z1800*ddq_4r + Z1807*ddq_1r + Z1805*ddq_w + Z1808*ddq_2r + Z1809*ddq_3r + Z1810*ddq_4r + Z1811*ddq_5r + Z1818*ddq_1r + Z1816*ddq_w + Z1819*ddq_2r + Z1820*ddq_3r + Z1821*ddq_4r + Z1822*ddq_5r + Z1823*ddq_6r + Z1830*ddq_1r + Z1828*ddq_w + Z1831*ddq_2r + Z1832*ddq_3r + Z1833*ddq_4r + Z1834*ddq_5r + Z1835*ddq_6r + Z1836*ddq_7r + Z1687*ddq_imu + Z1691*ddq_imu + Z1696*ddq_imu + Z1702*ddq_imu + Z1709*ddq_imu + Z1717*ddq_imu + Z1726*ddq_imu + Z1736*ddq_imu + Z1747*ddq_imu + Z1759*ddq_imu + Z1772*ddq_imu + Z1779*ddq_imu + Z1785*ddq_imu + Z1794*ddq_imu + Z1804*ddq_imu + Z1815*ddq_imu + Z1827*ddq_imu + Z1698*ddq_torso + Z1704*ddq_torso + Z1711*ddq_torso + Z1719*ddq_torso + Z1728*ddq_torso + Z1738*ddq_torso + Z1749*ddq_torso + Z1761*ddq_torso + Z1774*ddq_torso + Z1781*ddq_torso + Z1787*ddq_torso + Z1796*ddq_torso + Z1806*ddq_torso + Z1817*ddq_torso + Z1829*ddq_torso + Z1679*ddx + Z1682*ddx + Z1685*ddx + Z1689*ddx + Z1694*ddx + Z1700*ddx + Z1707*ddx + Z1715*ddx + Z1724*ddx + Z1734*ddx + Z1745*ddx + Z1757*ddx + Z1770*ddx + Z1777*ddx + Z1783*ddx + Z1792*ddx + Z1802*ddx + Z1813*ddx + Z1825*ddx
Z2761 = Z1679 + Z1682 + Z1685 + Z1689 + Z1694 + Z1700 + Z1707 + Z1715 + Z1724 + Z1734 + Z1745 + Z1757 + Z1770 + Z1777 + Z1783 + Z1792 + Z1802 + Z1813 + Z1825;
Z2762 = Z1680 + Z1683 + Z1686 + Z1690 + Z1695 + Z1701 + Z1708 + Z1716 + Z1725 + Z1735 + Z1746 + Z1758 + Z1771 + Z1778 + Z1784 + Z1793 + Z1803 + Z1814 + Z1826;
Z2763 = Z1687 + Z1691 + Z1696 + Z1702 + Z1709 + Z1717 + Z1726 + Z1736 + Z1747 + Z1759 + Z1772 + Z1779 + Z1785 + Z1794 + Z1804 + Z1815 + Z1827;
Z2764 = Z1692 + Z1697 + Z1703 + Z1710 + Z1718 + Z1727 + Z1737 + Z1748 + Z1760 + Z1773 + Z1780 + Z1786 + Z1795 + Z1805 + Z1816 + Z1828;
Z2765 = Z1698 + Z1704 + Z1711 + Z1719 + Z1728 + Z1738 + Z1749 + Z1761 + Z1774 + Z1781 + Z1787 + Z1796 + Z1806 + Z1817 + Z1829;
Z2766 = Z1705 + Z1712 + Z1720 + Z1729 + Z1739 + Z1750 + Z1762;
Z2767 = Z1713 + Z1721 + Z1730 + Z1740 + Z1751 + Z1763;
Z2768 = Z1722 + Z1731 + Z1741 + Z1752 + Z1764;
Z2769 = Z1732 + Z1742 + Z1753 + Z1765;
Z2770 = Z1743 + Z1754 + Z1766;
Z2771 = Z1755 + Z1767;
Z2772 = Z1775 + Z1788 + Z1797 + Z1807 + Z1818 + Z1830;
Z2773 = Z1789 + Z1798 + Z1808 + Z1819 + Z1831;
Z2774 = Z1790 + Z1799 + Z1809 + Z1820 + Z1832;
Z2775 = Z1800 + Z1810 + Z1821 + Z1833;
Z2776 = Z1811 + Z1822 + Z1834;
Z2777 = Z1823 + Z1835;
Z2778 = Z1681 + Z1684 + Z1688 + Z1693 + Z1699 + Z1706 + Z1714 + Z1723 + Z1733 + Z1744 + Z1756 + Z1769 + Z1776 + Z1782 + Z1791 + Z1801 + Z1812 + Z1824 + Z1837;
 
LHS_psi = Z2761*ddx+Z2762*ddpsi+Z2763*ddq_imu+Z2764*ddq_w+Z2765*ddq_torso+Z2766*ddq_1l+Z2767*ddq_2l+Z2768*ddq_3l+Z2769*ddq_4l+Z2770*ddq_5l+Z2771*ddq_6l+Z1768*ddq_7l+Z2772*ddq_1r+Z2773*ddq_2r+Z2774*ddq_3r+Z2775*ddq_4r+Z2776*ddq_5r+Z2777*ddq_6r+Z1836*ddq_7r+Z2778;
 
% LHS_imu = 
%
%    Z1842 - Z636 + Z1848 + Z1855 + Z1863 + Z1872 + Z1882 + Z1893 + Z1905 + Z1918 + Z1925 + Z1931 + Z1940 + Z1950 + Z1961 + Z1973 + Z1986 - Z634*ddpsi - Z635*ddq_imu + Z1839*ddpsi + Z1844*ddpsi + Z1850*ddpsi + Z1857*ddpsi + Z1865*ddpsi + Z1874*ddpsi + Z1884*ddpsi + Z1895*ddpsi + Z1907*ddpsi + Z1920*ddpsi + Z1927*ddpsi + Z1933*ddpsi + Z1942*ddpsi + Z1952*ddpsi + Z1963*ddpsi + Z1975*ddpsi + Z1841*ddq_w + Z1854*ddq_1l + Z1846*ddq_w + Z1861*ddq_1l + Z1852*ddq_w + Z1862*ddq_2l + Z1859*ddq_w + Z1869*ddq_1l + Z1870*ddq_2l + Z1871*ddq_3l + Z1867*ddq_w + Z1878*ddq_1l + Z1879*ddq_2l + Z1880*ddq_3l + Z1881*ddq_4l + Z1876*ddq_w + Z1888*ddq_1l + Z1889*ddq_2l + Z1890*ddq_3l + Z1891*ddq_4l + Z1886*ddq_w + Z1892*ddq_5l + Z1899*ddq_1l + Z1900*ddq_2l + Z1901*ddq_3l + Z1902*ddq_4l + Z1897*ddq_w + Z1903*ddq_5l + Z1904*ddq_6l + Z1911*ddq_1l + Z1912*ddq_2l + Z1913*ddq_3l + Z1914*ddq_4l + Z1909*ddq_w + Z1915*ddq_5l + Z1916*ddq_6l + Z1917*ddq_7l + Z1924*ddq_1r + Z1922*ddq_w + Z1929*ddq_w + Z1937*ddq_1r + Z1935*ddq_w + Z1938*ddq_2r + Z1939*ddq_3r + Z1946*ddq_1r + Z1944*ddq_w + Z1947*ddq_2r + Z1948*ddq_3r + Z1949*ddq_4r + Z1956*ddq_1r + Z1954*ddq_w + Z1957*ddq_2r + Z1958*ddq_3r + Z1959*ddq_4r + Z1960*ddq_5r + Z1967*ddq_1r + Z1965*ddq_w + Z1968*ddq_2r + Z1969*ddq_3r + Z1970*ddq_4r + Z1971*ddq_5r + Z1972*ddq_6r + Z1979*ddq_1r + Z1977*ddq_w + Z1980*ddq_2r + Z1981*ddq_3r + Z1982*ddq_4r + Z1983*ddq_5r + Z1984*ddq_6r + Z1985*ddq_7r + Z1840*ddq_imu + Z1845*ddq_imu + Z1851*ddq_imu + Z1858*ddq_imu + Z1866*ddq_imu + Z1875*ddq_imu + Z1885*ddq_imu + Z1896*ddq_imu + Z1908*ddq_imu + Z1921*ddq_imu + Z1928*ddq_imu + Z1934*ddq_imu + Z1943*ddq_imu + Z1953*ddq_imu + Z1964*ddq_imu + Z1976*ddq_imu - Z633*ddx + Z1847*ddq_torso + Z1853*ddq_torso + Z1860*ddq_torso + Z1868*ddq_torso + Z1877*ddq_torso + Z1887*ddq_torso + Z1898*ddq_torso + Z1910*ddq_torso + Z1923*ddq_torso + Z1930*ddq_torso + Z1936*ddq_torso + Z1945*ddq_torso + Z1955*ddq_torso + Z1966*ddq_torso + Z1978*ddq_torso + Z1838*ddx + Z1843*ddx + Z1849*ddx + Z1856*ddx + Z1864*ddx + Z1873*ddx + Z1883*ddx + Z1894*ddx + Z1906*ddx + Z1919*ddx + Z1926*ddx + Z1932*ddx + Z1941*ddx + Z1951*ddx + Z1962*ddx + Z1974*ddx
Z2779 = Z1838 - Z633 + Z1843 + Z1849 + Z1856 + Z1864 + Z1873 + Z1883 + Z1894 + Z1906 + Z1919 + Z1926 + Z1932 + Z1941 + Z1951 + Z1962 + Z1974;
Z2780 = Z1839 - Z634 + Z1844 + Z1850 + Z1857 + Z1865 + Z1874 + Z1884 + Z1895 + Z1907 + Z1920 + Z1927 + Z1933 + Z1942 + Z1952 + Z1963 + Z1975;
Z2781 = Z1840 - Z635 + Z1845 + Z1851 + Z1858 + Z1866 + Z1875 + Z1885 + Z1896 + Z1908 + Z1921 + Z1928 + Z1934 + Z1943 + Z1953 + Z1964 + Z1976;
Z2782 = Z1841 + Z1846 + Z1852 + Z1859 + Z1867 + Z1876 + Z1886 + Z1897 + Z1909 + Z1922 + Z1929 + Z1935 + Z1944 + Z1954 + Z1965 + Z1977;
Z2783 = Z1847 + Z1853 + Z1860 + Z1868 + Z1877 + Z1887 + Z1898 + Z1910 + Z1923 + Z1930 + Z1936 + Z1945 + Z1955 + Z1966 + Z1978;
Z2784 = Z1854 + Z1861 + Z1869 + Z1878 + Z1888 + Z1899 + Z1911;
Z2785 = Z1862 + Z1870 + Z1879 + Z1889 + Z1900 + Z1912;
Z2786 = Z1871 + Z1880 + Z1890 + Z1901 + Z1913;
Z2787 = Z1881 + Z1891 + Z1902 + Z1914;
Z2788 = Z1892 + Z1903 + Z1915;
Z2789 = Z1904 + Z1916;
Z2790 = Z1924 + Z1937 + Z1946 + Z1956 + Z1967 + Z1979;
Z2791 = Z1938 + Z1947 + Z1957 + Z1968 + Z1980;
Z2792 = Z1939 + Z1948 + Z1958 + Z1969 + Z1981;
Z2793 = Z1949 + Z1959 + Z1970 + Z1982;
Z2794 = Z1960 + Z1971 + Z1983;
Z2795 = Z1972 + Z1984;
Z2796 = Z1842 - Z636 + Z1848 + Z1855 + Z1863 + Z1872 + Z1882 + Z1893 + Z1905 + Z1918 + Z1925 + Z1931 + Z1940 + Z1950 + Z1961 + Z1973 + Z1986;
 
LHS_imu = Z2779*ddx+Z2780*ddpsi+Z2781*ddq_imu+Z2782*ddq_w+Z2783*ddq_torso+Z2784*ddq_1l+Z2785*ddq_2l+Z2786*ddq_3l+Z2787*ddq_4l+Z2788*ddq_5l+Z2789*ddq_6l+Z1917*ddq_7l+Z2790*ddq_1r+Z2791*ddq_2r+Z2792*ddq_3r+Z2793*ddq_4r+Z2794*ddq_5r+Z2795*ddq_6r+Z1985*ddq_7r+Z2796;
 
% LHS_w = 
%
%    Z1992 - Z661 + Z1999 + Z2007 + Z2016 + Z2026 + Z2037 + Z2049 + Z2062 + Z2069 + Z2075 + Z2084 + Z2094 + Z2105 + Z2117 + Z2130 - Z658*ddpsi - Z660*ddq_w - Z659*ddq_imu + Z1988*ddpsi + Z1994*ddpsi + Z2001*ddpsi + Z2009*ddpsi + Z2018*ddpsi + Z2028*ddpsi + Z2039*ddpsi + Z2051*ddpsi + Z2064*ddpsi + Z2071*ddpsi + Z2077*ddpsi + Z2086*ddpsi + Z2096*ddpsi + Z2107*ddpsi + Z2119*ddpsi + Z1998*ddq_1l + Z1990*ddq_w + Z2005*ddq_1l + Z1996*ddq_w + Z2006*ddq_2l + Z2003*ddq_w + Z2013*ddq_1l + Z2014*ddq_2l + Z2015*ddq_3l + Z2011*ddq_w + Z2022*ddq_1l + Z2023*ddq_2l + Z2024*ddq_3l + Z2025*ddq_4l + Z2020*ddq_w + Z2032*ddq_1l + Z2033*ddq_2l + Z2034*ddq_3l + Z2035*ddq_4l + Z2030*ddq_w + Z2036*ddq_5l + Z2043*ddq_1l + Z2044*ddq_2l + Z2045*ddq_3l + Z2046*ddq_4l + Z2041*ddq_w + Z2047*ddq_5l + Z2048*ddq_6l + Z2055*ddq_1l + Z2056*ddq_2l + Z2057*ddq_3l + Z2058*ddq_4l + Z2053*ddq_w + Z2059*ddq_5l + Z2060*ddq_6l + Z2061*ddq_7l + Z2068*ddq_1r + Z2066*ddq_w + Z2073*ddq_w + Z2081*ddq_1r + Z2079*ddq_w + Z2082*ddq_2r + Z2083*ddq_3r + Z2090*ddq_1r + Z2088*ddq_w + Z2091*ddq_2r + Z2092*ddq_3r + Z2093*ddq_4r + Z2100*ddq_1r + Z2098*ddq_w + Z2101*ddq_2r + Z2102*ddq_3r + Z2103*ddq_4r + Z2104*ddq_5r + Z2111*ddq_1r + Z2109*ddq_w + Z2112*ddq_2r + Z2113*ddq_3r + Z2114*ddq_4r + Z2115*ddq_5r + Z2116*ddq_6r + Z2123*ddq_1r + Z2121*ddq_w + Z2124*ddq_2r + Z2125*ddq_3r + Z2126*ddq_4r + Z2127*ddq_5r + Z2128*ddq_6r + Z2129*ddq_7r + Z1989*ddq_imu + Z1995*ddq_imu + Z2002*ddq_imu + Z2010*ddq_imu + Z2019*ddq_imu - Z657*ddx + Z2029*ddq_imu + Z2040*ddq_imu + Z2052*ddq_imu + Z2065*ddq_imu + Z2072*ddq_imu + Z2078*ddq_imu + Z2087*ddq_imu + Z2097*ddq_imu + Z2108*ddq_imu + Z2120*ddq_imu + Z1991*ddq_torso + Z1997*ddq_torso + Z2004*ddq_torso + Z2012*ddq_torso + Z2021*ddq_torso + Z2031*ddq_torso + Z2042*ddq_torso + Z2054*ddq_torso + Z2067*ddq_torso + Z2074*ddq_torso + Z2080*ddq_torso + Z2089*ddq_torso + Z2099*ddq_torso + Z2110*ddq_torso + Z2122*ddq_torso + Z1987*ddx + Z1993*ddx + Z2000*ddx + Z2008*ddx + Z2017*ddx + Z2027*ddx + Z2038*ddx + Z2050*ddx + Z2063*ddx + Z2070*ddx + Z2076*ddx + Z2085*ddx + Z2095*ddx + Z2106*ddx + Z2118*ddx
Z2797 = Z1987 - Z657 + Z1993 + Z2000 + Z2008 + Z2017 + Z2027 + Z2038 + Z2050 + Z2063 + Z2070 + Z2076 + Z2085 + Z2095 + Z2106 + Z2118;
Z2798 = Z1988 - Z658 + Z1994 + Z2001 + Z2009 + Z2018 + Z2028 + Z2039 + Z2051 + Z2064 + Z2071 + Z2077 + Z2086 + Z2096 + Z2107 + Z2119;
Z2799 = Z1989 - Z659 + Z1995 + Z2002 + Z2010 + Z2019 + Z2029 + Z2040 + Z2052 + Z2065 + Z2072 + Z2078 + Z2087 + Z2097 + Z2108 + Z2120;
Z2800 = Z1990 - Z660 + Z1996 + Z2003 + Z2011 + Z2020 + Z2030 + Z2041 + Z2053 + Z2066 + Z2073 + Z2079 + Z2088 + Z2098 + Z2109 + Z2121;
Z2801 = Z1991 + Z1997 + Z2004 + Z2012 + Z2021 + Z2031 + Z2042 + Z2054 + Z2067 + Z2074 + Z2080 + Z2089 + Z2099 + Z2110 + Z2122;
Z2802 = Z1998 + Z2005 + Z2013 + Z2022 + Z2032 + Z2043 + Z2055;
Z2803 = Z2006 + Z2014 + Z2023 + Z2033 + Z2044 + Z2056;
Z2804 = Z2015 + Z2024 + Z2034 + Z2045 + Z2057;
Z2805 = Z2025 + Z2035 + Z2046 + Z2058;
Z2806 = Z2036 + Z2047 + Z2059;
Z2807 = Z2048 + Z2060;
Z2808 = Z2068 + Z2081 + Z2090 + Z2100 + Z2111 + Z2123;
Z2809 = Z2082 + Z2091 + Z2101 + Z2112 + Z2124;
Z2810 = Z2083 + Z2092 + Z2102 + Z2113 + Z2125;
Z2811 = Z2093 + Z2103 + Z2114 + Z2126;
Z2812 = Z2104 + Z2115 + Z2127;
Z2813 = Z2116 + Z2128;
Z2814 = Z1992 - Z661 + Z1999 + Z2007 + Z2016 + Z2026 + Z2037 + Z2049 + Z2062 + Z2069 + Z2075 + Z2084 + Z2094 + Z2105 + Z2117 + Z2130;
 
LHS_w = Z2797*ddx+Z2798*ddpsi+Z2799*ddq_imu+Z2800*ddq_w+Z2801*ddq_torso+Z2802*ddq_1l+Z2803*ddq_2l+Z2804*ddq_3l+Z2805*ddq_4l+Z2806*ddq_5l+Z2807*ddq_6l+Z2061*ddq_7l+Z2808*ddq_1r+Z2809*ddq_2r+Z2810*ddq_3r+Z2811*ddq_4r+Z2812*ddq_5r+Z2813*ddq_6r+Z2129*ddq_7r+Z2814;
 
% LHS_torso = 
%
%    Z2137 - Z700 + Z2145 + Z2154 + Z2164 + Z2175 + Z2187 + Z2200 + Z2207 + Z2213 + Z2222 + Z2232 + Z2243 + Z2255 + Z2268 - Z696*ddpsi - Z698*ddq_w - Z697*ddq_imu - Z699*ddq_torso + Z2132*ddpsi + Z2139*ddpsi + Z2147*ddpsi + Z2156*ddpsi + Z2166*ddpsi + Z2177*ddpsi + Z2189*ddpsi + Z2202*ddpsi + Z2209*ddpsi + Z2215*ddpsi + Z2224*ddpsi + Z2234*ddpsi + Z2245*ddpsi + Z2257*ddpsi + Z2136*ddq_1l + Z2143*ddq_1l + Z2134*ddq_w + Z2144*ddq_2l + Z2141*ddq_w + Z2151*ddq_1l + Z2152*ddq_2l + Z2153*ddq_3l + Z2149*ddq_w + Z2160*ddq_1l + Z2161*ddq_2l + Z2162*ddq_3l + Z2163*ddq_4l + Z2158*ddq_w + Z2170*ddq_1l + Z2171*ddq_2l + Z2172*ddq_3l + Z2173*ddq_4l + Z2168*ddq_w + Z2174*ddq_5l + Z2181*ddq_1l + Z2182*ddq_2l + Z2183*ddq_3l + Z2184*ddq_4l + Z2179*ddq_w + Z2185*ddq_5l + Z2186*ddq_6l + Z2193*ddq_1l + Z2194*ddq_2l + Z2195*ddq_3l + Z2196*ddq_4l + Z2191*ddq_w + Z2197*ddq_5l + Z2198*ddq_6l + Z2199*ddq_7l + Z2206*ddq_1r + Z2204*ddq_w + Z2211*ddq_w + Z2219*ddq_1r + Z2217*ddq_w + Z2220*ddq_2r + Z2221*ddq_3r + Z2228*ddq_1r + Z2226*ddq_w + Z2229*ddq_2r + Z2230*ddq_3r + Z2231*ddq_4r + Z2238*ddq_1r + Z2236*ddq_w + Z2239*ddq_2r + Z2240*ddq_3r + Z2241*ddq_4r + Z2242*ddq_5r + Z2249*ddq_1r + Z2247*ddq_w + Z2250*ddq_2r + Z2251*ddq_3r + Z2252*ddq_4r + Z2253*ddq_5r + Z2254*ddq_6r + Z2261*ddq_1r + Z2259*ddq_w + Z2262*ddq_2r + Z2263*ddq_3r + Z2264*ddq_4r + Z2265*ddq_5r + Z2266*ddq_6r + Z2267*ddq_7r - Z695*ddx + Z2133*ddq_imu + Z2140*ddq_imu + Z2148*ddq_imu + Z2157*ddq_imu + Z2167*ddq_imu + Z2178*ddq_imu + Z2190*ddq_imu + Z2203*ddq_imu + Z2210*ddq_imu + Z2216*ddq_imu + Z2225*ddq_imu + Z2235*ddq_imu + Z2246*ddq_imu + Z2258*ddq_imu + Z2135*ddq_torso + Z2142*ddq_torso + Z2150*ddq_torso + Z2159*ddq_torso + Z2169*ddq_torso + Z2180*ddq_torso + Z2192*ddq_torso + Z2205*ddq_torso + Z2212*ddq_torso + Z2218*ddq_torso + Z2227*ddq_torso + Z2237*ddq_torso + Z2248*ddq_torso + Z2260*ddq_torso + Z2131*ddx + Z2138*ddx + Z2146*ddx + Z2155*ddx + Z2165*ddx + Z2176*ddx + Z2188*ddx + Z2201*ddx + Z2208*ddx + Z2214*ddx + Z2223*ddx + Z2233*ddx + Z2244*ddx + Z2256*ddx
Z2815 = Z2131 - Z695 + Z2138 + Z2146 + Z2155 + Z2165 + Z2176 + Z2188 + Z2201 + Z2208 + Z2214 + Z2223 + Z2233 + Z2244 + Z2256;
Z2816 = Z2132 - Z696 + Z2139 + Z2147 + Z2156 + Z2166 + Z2177 + Z2189 + Z2202 + Z2209 + Z2215 + Z2224 + Z2234 + Z2245 + Z2257;
Z2817 = Z2133 - Z697 + Z2140 + Z2148 + Z2157 + Z2167 + Z2178 + Z2190 + Z2203 + Z2210 + Z2216 + Z2225 + Z2235 + Z2246 + Z2258;
Z2818 = Z2134 - Z698 + Z2141 + Z2149 + Z2158 + Z2168 + Z2179 + Z2191 + Z2204 + Z2211 + Z2217 + Z2226 + Z2236 + Z2247 + Z2259;
Z2819 = Z2135 - Z699 + Z2142 + Z2150 + Z2159 + Z2169 + Z2180 + Z2192 + Z2205 + Z2212 + Z2218 + Z2227 + Z2237 + Z2248 + Z2260;
Z2820 = Z2136 + Z2143 + Z2151 + Z2160 + Z2170 + Z2181 + Z2193;
Z2821 = Z2144 + Z2152 + Z2161 + Z2171 + Z2182 + Z2194;
Z2822 = Z2153 + Z2162 + Z2172 + Z2183 + Z2195;
Z2823 = Z2163 + Z2173 + Z2184 + Z2196;
Z2824 = Z2174 + Z2185 + Z2197;
Z2825 = Z2186 + Z2198;
Z2826 = Z2206 + Z2219 + Z2228 + Z2238 + Z2249 + Z2261;
Z2827 = Z2220 + Z2229 + Z2239 + Z2250 + Z2262;
Z2828 = Z2221 + Z2230 + Z2240 + Z2251 + Z2263;
Z2829 = Z2231 + Z2241 + Z2252 + Z2264;
Z2830 = Z2242 + Z2253 + Z2265;
Z2831 = Z2254 + Z2266;
Z2832 = Z2137 - Z700 + Z2145 + Z2154 + Z2164 + Z2175 + Z2187 + Z2200 + Z2207 + Z2213 + Z2222 + Z2232 + Z2243 + Z2255 + Z2268;
 
LHS_torso = Z2815*ddx+Z2816*ddpsi+Z2817*ddq_imu+Z2818*ddq_w+Z2819*ddq_torso+Z2820*ddq_1l+Z2821*ddq_2l+Z2822*ddq_3l+Z2823*ddq_4l+Z2824*ddq_5l+Z2825*ddq_6l+Z2199*ddq_7l+Z2826*ddq_1r+Z2827*ddq_2r+Z2828*ddq_3r+Z2829*ddq_4r+Z2830*ddq_5r+Z2831*ddq_6r+Z2267*ddq_7r+Z2832;
 
% LHS_4l = 
%
%    Z2276 - Z740 + Z2285 + Z2295 + Z2306 + Z2318 + Z2331 - Z735*ddpsi - Z739*ddq_1l - Z737*ddq_w - Z736*ddq_imu - Z738*ddq_torso + Z2270*ddpsi + Z2278*ddpsi + Z2287*ddpsi + Z2297*ddpsi + Z2308*ddpsi + Z2320*ddpsi + Z2274*ddq_1l + Z2275*ddq_2l + Z2272*ddq_w + Z2282*ddq_1l + Z2283*ddq_2l + Z2284*ddq_3l + Z2280*ddq_w + Z2291*ddq_1l + Z2292*ddq_2l + Z2293*ddq_3l + Z2294*ddq_4l + Z2289*ddq_w + Z2301*ddq_1l + Z2302*ddq_2l + Z2303*ddq_3l + Z2304*ddq_4l + Z2299*ddq_w + Z2305*ddq_5l + Z2312*ddq_1l + Z2313*ddq_2l + Z2314*ddq_3l + Z2315*ddq_4l + Z2310*ddq_w + Z2316*ddq_5l - Z734*ddx + Z2317*ddq_6l + Z2324*ddq_1l + Z2325*ddq_2l + Z2326*ddq_3l + Z2327*ddq_4l + Z2322*ddq_w + Z2328*ddq_5l + Z2329*ddq_6l + Z2330*ddq_7l + Z2271*ddq_imu + Z2279*ddq_imu + Z2288*ddq_imu + Z2298*ddq_imu + Z2309*ddq_imu + Z2321*ddq_imu + Z2273*ddq_torso + Z2281*ddq_torso + Z2290*ddq_torso + Z2300*ddq_torso + Z2311*ddq_torso + Z2323*ddq_torso + Z2269*ddx + Z2277*ddx + Z2286*ddx + Z2296*ddx + Z2307*ddx + Z2319*ddx
Z2833 = Z2269 - Z734 + Z2277 + Z2286 + Z2296 + Z2307 + Z2319;
Z2834 = Z2270 - Z735 + Z2278 + Z2287 + Z2297 + Z2308 + Z2320;
Z2835 = Z2271 - Z736 + Z2279 + Z2288 + Z2298 + Z2309 + Z2321;
Z2836 = Z2272 - Z737 + Z2280 + Z2289 + Z2299 + Z2310 + Z2322;
Z2837 = Z2273 - Z738 + Z2281 + Z2290 + Z2300 + Z2311 + Z2323;
Z2838 = Z2274 - Z739 + Z2282 + Z2291 + Z2301 + Z2312 + Z2324;
Z2839 = Z2275 + Z2283 + Z2292 + Z2302 + Z2313 + Z2325;
Z2840 = Z2284 + Z2293 + Z2303 + Z2314 + Z2326;
Z2841 = Z2294 + Z2304 + Z2315 + Z2327;
Z2842 = Z2305 + Z2316 + Z2328;
Z2843 = Z2317 + Z2329;
Z2844 = Z2276 - Z740 + Z2285 + Z2295 + Z2306 + Z2318 + Z2331;
 
LHS_4l = Z2833*ddx+Z2834*ddpsi+Z2835*ddq_imu+Z2836*ddq_w+Z2837*ddq_torso+Z2838*ddq_1l+Z2839*ddq_2l+Z2840*ddq_3l+Z2841*ddq_4l+Z2842*ddq_5l+Z2843*ddq_6l+Z2330*ddq_7l+Z2844;
 
% LHS_5l = 
%
%    Z2340 - Z778 + Z2350 + Z2361 + Z2373 + Z2386 - Z772*ddpsi - Z776*ddq_1l - Z777*ddq_2l - Z774*ddq_w - Z773*ddq_imu - Z775*ddq_torso + Z2333*ddpsi + Z2342*ddpsi + Z2352*ddpsi + Z2363*ddpsi + Z2375*ddpsi + Z2337*ddq_1l + Z2338*ddq_2l + Z2339*ddq_3l + Z2335*ddq_w + Z2346*ddq_1l + Z2347*ddq_2l + Z2348*ddq_3l + Z2349*ddq_4l + Z2344*ddq_w + Z2356*ddq_1l + Z2357*ddq_2l - Z771*ddx + Z2358*ddq_3l + Z2359*ddq_4l + Z2354*ddq_w + Z2360*ddq_5l + Z2367*ddq_1l + Z2368*ddq_2l + Z2369*ddq_3l + Z2370*ddq_4l + Z2365*ddq_w + Z2371*ddq_5l + Z2372*ddq_6l + Z2379*ddq_1l + Z2380*ddq_2l + Z2381*ddq_3l + Z2382*ddq_4l + Z2377*ddq_w + Z2383*ddq_5l + Z2384*ddq_6l + Z2385*ddq_7l + Z2334*ddq_imu + Z2343*ddq_imu + Z2353*ddq_imu + Z2364*ddq_imu + Z2376*ddq_imu + Z2336*ddq_torso + Z2345*ddq_torso + Z2355*ddq_torso + Z2366*ddq_torso + Z2378*ddq_torso + Z2332*ddx + Z2341*ddx + Z2351*ddx + Z2362*ddx + Z2374*ddx
Z2845 = Z2332 - Z771 + Z2341 + Z2351 + Z2362 + Z2374;
Z2846 = Z2333 - Z772 + Z2342 + Z2352 + Z2363 + Z2375;
Z2847 = Z2334 - Z773 + Z2343 + Z2353 + Z2364 + Z2376;
Z2848 = Z2335 - Z774 + Z2344 + Z2354 + Z2365 + Z2377;
Z2849 = Z2336 - Z775 + Z2345 + Z2355 + Z2366 + Z2378;
Z2850 = Z2337 - Z776 + Z2346 + Z2356 + Z2367 + Z2379;
Z2851 = Z2338 - Z777 + Z2347 + Z2357 + Z2368 + Z2380;
Z2852 = Z2339 + Z2348 + Z2358 + Z2369 + Z2381;
Z2853 = Z2349 + Z2359 + Z2370 + Z2382;
Z2854 = Z2360 + Z2371 + Z2383;
Z2855 = Z2372 + Z2384;
Z2856 = Z2340 - Z778 + Z2350 + Z2361 + Z2373 + Z2386;
 
LHS_5l = Z2845*ddx+Z2846*ddpsi+Z2847*ddq_imu+Z2848*ddq_w+Z2849*ddq_torso+Z2850*ddq_1l+Z2851*ddq_2l+Z2852*ddq_3l+Z2853*ddq_4l+Z2854*ddq_5l+Z2855*ddq_6l+Z2385*ddq_7l+Z2856;
 
% LHS_6l = 
%
%    Z2396 - Z838 + Z2407 + Z2419 + Z2432 - Z831*ddpsi - Z835*ddq_1l - Z836*ddq_2l - Z837*ddq_3l - Z833*ddq_w - Z832*ddq_imu - Z834*ddq_torso + Z2388*ddpsi + Z2398*ddpsi + Z2409*ddpsi + Z2421*ddpsi + Z2392*ddq_1l + Z2393*ddq_2l + Z2394*ddq_3l + Z2395*ddq_4l + Z2390*ddq_w + Z2402*ddq_1l + Z2403*ddq_2l + Z2404*ddq_3l + Z2405*ddq_4l + Z2400*ddq_w + Z2406*ddq_5l + Z2413*ddq_1l + Z2414*ddq_2l + Z2415*ddq_3l - Z830*ddx + Z2416*ddq_4l + Z2411*ddq_w + Z2417*ddq_5l + Z2418*ddq_6l + Z2425*ddq_1l + Z2426*ddq_2l + Z2427*ddq_3l + Z2428*ddq_4l + Z2423*ddq_w + Z2429*ddq_5l + Z2430*ddq_6l + Z2431*ddq_7l + Z2389*ddq_imu + Z2399*ddq_imu + Z2410*ddq_imu + Z2422*ddq_imu + Z2391*ddq_torso + Z2401*ddq_torso + Z2412*ddq_torso + Z2424*ddq_torso + Z2387*ddx + Z2397*ddx + Z2408*ddx + Z2420*ddx
Z2857 = Z2387 - Z830 + Z2397 + Z2408 + Z2420;
Z2858 = Z2388 - Z831 + Z2398 + Z2409 + Z2421;
Z2859 = Z2389 - Z832 + Z2399 + Z2410 + Z2422;
Z2860 = Z2390 - Z833 + Z2400 + Z2411 + Z2423;
Z2861 = Z2391 - Z834 + Z2401 + Z2412 + Z2424;
Z2862 = Z2392 - Z835 + Z2402 + Z2413 + Z2425;
Z2863 = Z2393 - Z836 + Z2403 + Z2414 + Z2426;
Z2864 = Z2394 - Z837 + Z2404 + Z2415 + Z2427;
Z2865 = Z2395 + Z2405 + Z2416 + Z2428;
Z2866 = Z2406 + Z2417 + Z2429;
Z2867 = Z2418 + Z2430;
Z2868 = Z2396 - Z838 + Z2407 + Z2419 + Z2432;
 
LHS_6l = Z2857*ddx+Z2858*ddpsi+Z2859*ddq_imu+Z2860*ddq_w+Z2861*ddq_torso+Z2862*ddq_1l+Z2863*ddq_2l+Z2864*ddq_3l+Z2865*ddq_4l+Z2866*ddq_5l+Z2867*ddq_6l+Z2431*ddq_7l+Z2868;
 
% LHS_7l = 
%
%    Z2443 - Z886 + Z2455 + Z2468 - Z878*ddpsi - Z882*ddq_1l - Z883*ddq_2l - Z884*ddq_3l - Z885*ddq_4l - Z880*ddq_w - Z879*ddq_imu - Z881*ddq_torso + Z2434*ddpsi + Z2445*ddpsi + Z2457*ddpsi + Z2438*ddq_1l + Z2439*ddq_2l + Z2440*ddq_3l + Z2441*ddq_4l + Z2436*ddq_w + Z2442*ddq_5l + Z2449*ddq_1l + Z2450*ddq_2l + Z2451*ddq_3l + Z2452*ddq_4l + Z2447*ddq_w + Z2453*ddq_5l + Z2454*ddq_6l + Z2461*ddq_1l + Z2462*ddq_2l - Z877*ddx + Z2463*ddq_3l + Z2464*ddq_4l + Z2459*ddq_w + Z2465*ddq_5l + Z2466*ddq_6l + Z2467*ddq_7l + Z2435*ddq_imu + Z2446*ddq_imu + Z2458*ddq_imu + Z2437*ddq_torso + Z2448*ddq_torso + Z2460*ddq_torso + Z2433*ddx + Z2444*ddx + Z2456*ddx
Z2869 = Z2433 - Z877 + Z2444 + Z2456;
Z2870 = Z2434 - Z878 + Z2445 + Z2457;
Z2871 = Z2435 - Z879 + Z2446 + Z2458;
Z2872 = Z2436 - Z880 + Z2447 + Z2459;
Z2873 = Z2437 - Z881 + Z2448 + Z2460;
Z2874 = Z2438 - Z882 + Z2449 + Z2461;
Z2875 = Z2439 - Z883 + Z2450 + Z2462;
Z2876 = Z2440 - Z884 + Z2451 + Z2463;
Z2877 = Z2441 - Z885 + Z2452 + Z2464;
Z2878 = Z2442 + Z2453 + Z2465;
Z2879 = Z2454 + Z2466;
Z2880 = Z2443 - Z886 + Z2455 + Z2468;
 
LHS_7l = Z2869*ddx+Z2870*ddpsi+Z2871*ddq_imu+Z2872*ddq_w+Z2873*ddq_torso+Z2874*ddq_1l+Z2875*ddq_2l+Z2876*ddq_3l+Z2877*ddq_4l+Z2878*ddq_5l+Z2879*ddq_6l+Z2467*ddq_7l+Z2880;
 
% LHS_8l = 
%
%    Z2480 - Z960 + Z2493 - Z951*ddpsi - Z955*ddq_1l - Z956*ddq_2l - Z957*ddq_3l - Z958*ddq_4l - Z953*ddq_w - Z959*ddq_5l - Z952*ddq_imu - Z954*ddq_torso + Z2470*ddpsi + Z2482*ddpsi + Z2474*ddq_1l + Z2475*ddq_2l + Z2476*ddq_3l + Z2477*ddq_4l + Z2472*ddq_w + Z2478*ddq_5l + Z2479*ddq_6l + Z2486*ddq_1l + Z2487*ddq_2l + Z2488*ddq_3l + Z2489*ddq_4l + Z2484*ddq_w + Z2490*ddq_5l + Z2491*ddq_6l + Z2492*ddq_7l - Z950*ddx + Z2471*ddq_imu + Z2483*ddq_imu + Z2473*ddq_torso + Z2485*ddq_torso + Z2469*ddx + Z2481*ddx
Z2881 = Z2469 - Z950 + Z2481;
Z2882 = Z2470 - Z951 + Z2482;
Z2883 = Z2471 - Z952 + Z2483;
Z2884 = Z2472 - Z953 + Z2484;
Z2885 = Z2473 - Z954 + Z2485;
Z2886 = Z2474 - Z955 + Z2486;
Z2887 = Z2475 - Z956 + Z2487;
Z2888 = Z2476 - Z957 + Z2488;
Z2889 = Z2477 - Z958 + Z2489;
Z2890 = Z2478 - Z959 + Z2490;
Z2891 = Z2479 + Z2491;
Z2892 = Z2480 - Z960 + Z2493;
 
LHS_8l = Z2881*ddx+Z2882*ddpsi+Z2883*ddq_imu+Z2884*ddq_w+Z2885*ddq_torso+Z2886*ddq_1l+Z2887*ddq_2l+Z2888*ddq_3l+Z2889*ddq_4l+Z2890*ddq_5l+Z2891*ddq_6l+Z2492*ddq_7l+Z2892;
 
% LHS_9l = 
%
%    Z2506 - Z1018 - Z1008*ddpsi - Z1012*ddq_1l - Z1013*ddq_2l - Z1014*ddq_3l - Z1015*ddq_4l - Z1010*ddq_w - Z1016*ddq_5l - Z1017*ddq_6l - Z1009*ddq_imu - Z1011*ddq_torso + Z2495*ddpsi + Z2499*ddq_1l + Z2500*ddq_2l + Z2501*ddq_3l + Z2502*ddq_4l + Z2497*ddq_w + Z2503*ddq_5l + Z2504*ddq_6l + Z2505*ddq_7l - Z1007*ddx + Z2496*ddq_imu + Z2498*ddq_torso + Z2494*ddx
Z2893 = Z2494 - Z1007;
Z2894 = Z2495 - Z1008;
Z2895 = Z2496 - Z1009;
Z2896 = Z2497 - Z1010;
Z2897 = Z2498 - Z1011;
Z2898 = Z2499 - Z1012;
Z2899 = Z2500 - Z1013;
Z2900 = Z2501 - Z1014;
Z2901 = Z2502 - Z1015;
Z2902 = Z2503 - Z1016;
Z2903 = Z2504 - Z1017;
Z2904 = Z2506 - Z1018;
 
LHS_9l = Z2893*ddx+Z2894*ddpsi+Z2895*ddq_imu+Z2896*ddq_w+Z2897*ddq_torso+Z2898*ddq_1l+Z2899*ddq_2l+Z2900*ddq_3l+Z2901*ddq_4l+Z2902*ddq_5l+Z2903*ddq_6l+Z2505*ddq_7l+Z2904;
 
% LHS_10l = 
%
%    - Z1119 - Z1108*ddpsi - Z1112*ddq_1l - Z1113*ddq_2l - Z1114*ddq_3l - Z1115*ddq_4l - Z1110*ddq_w - Z1116*ddq_5l - Z1117*ddq_6l - Z1118*ddq_7l - Z1109*ddq_imu - Z1111*ddq_torso - Z1107*ddx
LHS_10l = -Z1107*ddx-Z1108*ddpsi-Z1109*ddq_imu-Z1110*ddq_w-Z1111*ddq_torso-Z1112*ddq_1l-Z1113*ddq_2l-Z1114*ddq_3l-Z1115*ddq_4l-Z1116*ddq_5l-Z1117*ddq_6l-Z1118*ddq_7l+-Z1119;
 
% LHS_4r = 
%
%    Z2512 - Z1153 + Z2521 + Z2531 + Z2542 + Z2554 + Z2567 - Z1148*ddpsi - Z1152*ddq_1r - Z1150*ddq_w - Z1149*ddq_imu - Z1151*ddq_torso + Z2508*ddpsi + Z2514*ddpsi + Z2523*ddpsi + Z2533*ddpsi + Z2544*ddpsi + Z2556*ddpsi + Z2510*ddq_w + Z2518*ddq_1r + Z2516*ddq_w + Z2519*ddq_2r + Z2520*ddq_3r + Z2527*ddq_1r + Z2525*ddq_w + Z2528*ddq_2r + Z2529*ddq_3r + Z2530*ddq_4r + Z2537*ddq_1r + Z2535*ddq_w + Z2538*ddq_2r + Z2539*ddq_3r + Z2540*ddq_4r + Z2541*ddq_5r + Z2548*ddq_1r + Z2546*ddq_w + Z2549*ddq_2r + Z2550*ddq_3r + Z2551*ddq_4r + Z2552*ddq_5r + Z2553*ddq_6r + Z2560*ddq_1r + Z2558*ddq_w + Z2561*ddq_2r + Z2562*ddq_3r + Z2563*ddq_4r + Z2564*ddq_5r + Z2565*ddq_6r + Z2566*ddq_7r + Z2509*ddq_imu - Z1147*ddx + Z2515*ddq_imu + Z2524*ddq_imu + Z2534*ddq_imu + Z2545*ddq_imu + Z2557*ddq_imu + Z2511*ddq_torso + Z2517*ddq_torso + Z2526*ddq_torso + Z2536*ddq_torso + Z2547*ddq_torso + Z2559*ddq_torso + Z2507*ddx + Z2513*ddx + Z2522*ddx + Z2532*ddx + Z2543*ddx + Z2555*ddx
Z2905 = Z2507 - Z1147 + Z2513 + Z2522 + Z2532 + Z2543 + Z2555;
Z2906 = Z2508 - Z1148 + Z2514 + Z2523 + Z2533 + Z2544 + Z2556;
Z2907 = Z2509 - Z1149 + Z2515 + Z2524 + Z2534 + Z2545 + Z2557;
Z2908 = Z2510 - Z1150 + Z2516 + Z2525 + Z2535 + Z2546 + Z2558;
Z2909 = Z2511 - Z1151 + Z2517 + Z2526 + Z2536 + Z2547 + Z2559;
Z2910 = Z2518 - Z1152 + Z2527 + Z2537 + Z2548 + Z2560;
Z2911 = Z2519 + Z2528 + Z2538 + Z2549 + Z2561;
Z2912 = Z2520 + Z2529 + Z2539 + Z2550 + Z2562;
Z2913 = Z2530 + Z2540 + Z2551 + Z2563;
Z2914 = Z2541 + Z2552 + Z2564;
Z2915 = Z2553 + Z2565;
Z2916 = Z2512 - Z1153 + Z2521 + Z2531 + Z2542 + Z2554 + Z2567;
 
LHS_4r = Z2905*ddx+Z2906*ddpsi+Z2907*ddq_imu+Z2908*ddq_w+Z2909*ddq_torso+Z2910*ddq_1r+Z2911*ddq_2r+Z2912*ddq_3r+Z2913*ddq_4r+Z2914*ddq_5r+Z2915*ddq_6r+Z2566*ddq_7r+Z2916;
 
% LHS_5r = 
%
%    Z2576 - Z1184 + Z2586 + Z2597 + Z2609 + Z2622 - Z1180*ddpsi - Z1182*ddq_w - Z1181*ddq_imu - Z1183*ddq_torso + Z2569*ddpsi + Z2578*ddpsi + Z2588*ddpsi + Z2599*ddpsi + Z2611*ddpsi + Z2573*ddq_1r + Z2571*ddq_w + Z2574*ddq_2r + Z2575*ddq_3r + Z2582*ddq_1r + Z2580*ddq_w + Z2583*ddq_2r + Z2584*ddq_3r + Z2585*ddq_4r + Z2592*ddq_1r + Z2590*ddq_w + Z2593*ddq_2r + Z2594*ddq_3r + Z2595*ddq_4r + Z2596*ddq_5r + Z2603*ddq_1r + Z2601*ddq_w + Z2604*ddq_2r + Z2605*ddq_3r + Z2606*ddq_4r + Z2607*ddq_5r + Z2608*ddq_6r + Z2615*ddq_1r + Z2613*ddq_w + Z2616*ddq_2r + Z2617*ddq_3r + Z2618*ddq_4r + Z2619*ddq_5r + Z2620*ddq_6r + Z2621*ddq_7r - Z1179*ddx + Z2570*ddq_imu + Z2579*ddq_imu + Z2589*ddq_imu + Z2600*ddq_imu + Z2612*ddq_imu + Z2572*ddq_torso + Z2581*ddq_torso + Z2591*ddq_torso + Z2602*ddq_torso + Z2614*ddq_torso + Z2568*ddx + Z2577*ddx + Z2587*ddx + Z2598*ddx + Z2610*ddx
Z2917 = Z2568 - Z1179 + Z2577 + Z2587 + Z2598 + Z2610;
Z2918 = Z2569 - Z1180 + Z2578 + Z2588 + Z2599 + Z2611;
Z2919 = Z2570 - Z1181 + Z2579 + Z2589 + Z2600 + Z2612;
Z2920 = Z2571 - Z1182 + Z2580 + Z2590 + Z2601 + Z2613;
Z2921 = Z2572 - Z1183 + Z2581 + Z2591 + Z2602 + Z2614;
Z2922 = Z2573 + Z2582 + Z2592 + Z2603 + Z2615;
Z2923 = Z2574 + Z2583 + Z2593 + Z2604 + Z2616;
Z2924 = Z2575 + Z2584 + Z2594 + Z2605 + Z2617;
Z2925 = Z2585 + Z2595 + Z2606 + Z2618;
Z2926 = Z2596 + Z2607 + Z2619;
Z2927 = Z2608 + Z2620;
Z2928 = Z2576 - Z1184 + Z2586 + Z2597 + Z2609 + Z2622;
 
LHS_5r = Z2917*ddx+Z2918*ddpsi+Z2919*ddq_imu+Z2920*ddq_w+Z2921*ddq_torso+Z2922*ddq_1r+Z2923*ddq_2r+Z2924*ddq_3r+Z2925*ddq_4r+Z2926*ddq_5r+Z2927*ddq_6r+Z2621*ddq_7r+Z2928;
 
% LHS_6r = 
%
%    Z2632 - Z1240 + Z2643 + Z2655 + Z2668 - Z1233*ddpsi - Z1237*ddq_1r - Z1235*ddq_w - Z1238*ddq_2r - Z1239*ddq_3r - Z1234*ddq_imu - Z1236*ddq_torso + Z2624*ddpsi + Z2634*ddpsi + Z2645*ddpsi + Z2657*ddpsi + Z2628*ddq_1r + Z2626*ddq_w + Z2629*ddq_2r + Z2630*ddq_3r + Z2631*ddq_4r + Z2638*ddq_1r + Z2636*ddq_w + Z2639*ddq_2r + Z2640*ddq_3r + Z2641*ddq_4r + Z2642*ddq_5r + Z2649*ddq_1r + Z2647*ddq_w + Z2650*ddq_2r + Z2651*ddq_3r + Z2652*ddq_4r + Z2653*ddq_5r + Z2654*ddq_6r + Z2661*ddq_1r + Z2659*ddq_w + Z2662*ddq_2r + Z2663*ddq_3r + Z2664*ddq_4r + Z2665*ddq_5r + Z2666*ddq_6r + Z2667*ddq_7r - Z1232*ddx + Z2625*ddq_imu + Z2635*ddq_imu + Z2646*ddq_imu + Z2658*ddq_imu + Z2627*ddq_torso + Z2637*ddq_torso + Z2648*ddq_torso + Z2660*ddq_torso + Z2623*ddx + Z2633*ddx + Z2644*ddx + Z2656*ddx
Z2929 = Z2623 - Z1232 + Z2633 + Z2644 + Z2656;
Z2930 = Z2624 - Z1233 + Z2634 + Z2645 + Z2657;
Z2931 = Z2625 - Z1234 + Z2635 + Z2646 + Z2658;
Z2932 = Z2626 - Z1235 + Z2636 + Z2647 + Z2659;
Z2933 = Z2627 - Z1236 + Z2637 + Z2648 + Z2660;
Z2934 = Z2628 - Z1237 + Z2638 + Z2649 + Z2661;
Z2935 = Z2629 - Z1238 + Z2639 + Z2650 + Z2662;
Z2936 = Z2630 - Z1239 + Z2640 + Z2651 + Z2663;
Z2937 = Z2631 + Z2641 + Z2652 + Z2664;
Z2938 = Z2642 + Z2653 + Z2665;
Z2939 = Z2654 + Z2666;
Z2940 = Z2632 - Z1240 + Z2643 + Z2655 + Z2668;
 
LHS_6r = Z2929*ddx+Z2930*ddpsi+Z2931*ddq_imu+Z2932*ddq_w+Z2933*ddq_torso+Z2934*ddq_1r+Z2935*ddq_2r+Z2936*ddq_3r+Z2937*ddq_4r+Z2938*ddq_5r+Z2939*ddq_6r+Z2667*ddq_7r+Z2940;
 
% LHS_7r = 
%
%    Z2679 - Z1288 + Z2691 + Z2704 - Z1280*ddpsi - Z1284*ddq_1r - Z1282*ddq_w - Z1285*ddq_2r - Z1286*ddq_3r - Z1287*ddq_4r - Z1281*ddq_imu - Z1283*ddq_torso + Z2670*ddpsi + Z2681*ddpsi + Z2693*ddpsi + Z2674*ddq_1r + Z2672*ddq_w + Z2675*ddq_2r + Z2676*ddq_3r + Z2677*ddq_4r + Z2678*ddq_5r + Z2685*ddq_1r + Z2683*ddq_w + Z2686*ddq_2r + Z2687*ddq_3r + Z2688*ddq_4r + Z2689*ddq_5r + Z2690*ddq_6r + Z2697*ddq_1r + Z2695*ddq_w + Z2698*ddq_2r + Z2699*ddq_3r + Z2700*ddq_4r + Z2701*ddq_5r + Z2702*ddq_6r + Z2703*ddq_7r - Z1279*ddx + Z2671*ddq_imu + Z2682*ddq_imu + Z2694*ddq_imu + Z2673*ddq_torso + Z2684*ddq_torso + Z2696*ddq_torso + Z2669*ddx + Z2680*ddx + Z2692*ddx
Z2941 = Z2669 - Z1279 + Z2680 + Z2692;
Z2942 = Z2670 - Z1280 + Z2681 + Z2693;
Z2943 = Z2671 - Z1281 + Z2682 + Z2694;
Z2944 = Z2672 - Z1282 + Z2683 + Z2695;
Z2945 = Z2673 - Z1283 + Z2684 + Z2696;
Z2946 = Z2674 - Z1284 + Z2685 + Z2697;
Z2947 = Z2675 - Z1285 + Z2686 + Z2698;
Z2948 = Z2676 - Z1286 + Z2687 + Z2699;
Z2949 = Z2677 - Z1287 + Z2688 + Z2700;
Z2950 = Z2678 + Z2689 + Z2701;
Z2951 = Z2690 + Z2702;
Z2952 = Z2679 - Z1288 + Z2691 + Z2704;
 
LHS_7r = Z2941*ddx+Z2942*ddpsi+Z2943*ddq_imu+Z2944*ddq_w+Z2945*ddq_torso+Z2946*ddq_1r+Z2947*ddq_2r+Z2948*ddq_3r+Z2949*ddq_4r+Z2950*ddq_5r+Z2951*ddq_6r+Z2703*ddq_7r+Z2952;
 
% LHS_8r = 
%
%    Z2716 - Z1362 + Z2729 - Z1353*ddpsi - Z1357*ddq_1r - Z1355*ddq_w - Z1358*ddq_2r - Z1359*ddq_3r - Z1360*ddq_4r - Z1361*ddq_5r - Z1354*ddq_imu - Z1356*ddq_torso + Z2706*ddpsi + Z2718*ddpsi + Z2710*ddq_1r + Z2708*ddq_w + Z2711*ddq_2r + Z2712*ddq_3r + Z2713*ddq_4r + Z2714*ddq_5r + Z2715*ddq_6r + Z2722*ddq_1r + Z2720*ddq_w + Z2723*ddq_2r + Z2724*ddq_3r + Z2725*ddq_4r + Z2726*ddq_5r + Z2727*ddq_6r + Z2728*ddq_7r + Z2707*ddq_imu - Z1352*ddx + Z2719*ddq_imu + Z2709*ddq_torso + Z2721*ddq_torso + Z2705*ddx + Z2717*ddx
Z2953 = Z2705 - Z1352 + Z2717;
Z2954 = Z2706 - Z1353 + Z2718;
Z2955 = Z2707 - Z1354 + Z2719;
Z2956 = Z2708 - Z1355 + Z2720;
Z2957 = Z2709 - Z1356 + Z2721;
Z2958 = Z2710 - Z1357 + Z2722;
Z2959 = Z2711 - Z1358 + Z2723;
Z2960 = Z2712 - Z1359 + Z2724;
Z2961 = Z2713 - Z1360 + Z2725;
Z2962 = Z2714 - Z1361 + Z2726;
Z2963 = Z2715 + Z2727;
Z2964 = Z2716 - Z1362 + Z2729;
 
LHS_8r = Z2953*ddx+Z2954*ddpsi+Z2955*ddq_imu+Z2956*ddq_w+Z2957*ddq_torso+Z2958*ddq_1r+Z2959*ddq_2r+Z2960*ddq_3r+Z2961*ddq_4r+Z2962*ddq_5r+Z2963*ddq_6r+Z2728*ddq_7r+Z2964;
 
% LHS_9r = 
%
%    Z2742 - Z1420 - Z1410*ddpsi - Z1414*ddq_1r - Z1412*ddq_w - Z1415*ddq_2r - Z1416*ddq_3r - Z1417*ddq_4r - Z1418*ddq_5r - Z1419*ddq_6r - Z1411*ddq_imu - Z1413*ddq_torso + Z2731*ddpsi + Z2735*ddq_1r + Z2733*ddq_w + Z2736*ddq_2r + Z2737*ddq_3r + Z2738*ddq_4r + Z2739*ddq_5r + Z2740*ddq_6r + Z2741*ddq_7r + Z2732*ddq_imu - Z1409*ddx + Z2734*ddq_torso + Z2730*ddx
Z2965 = Z2730 - Z1409;
Z2966 = Z2731 - Z1410;
Z2967 = Z2732 - Z1411;
Z2968 = Z2733 - Z1412;
Z2969 = Z2734 - Z1413;
Z2970 = Z2735 - Z1414;
Z2971 = Z2736 - Z1415;
Z2972 = Z2737 - Z1416;
Z2973 = Z2738 - Z1417;
Z2974 = Z2739 - Z1418;
Z2975 = Z2740 - Z1419;
Z2976 = Z2742 - Z1420;
 
LHS_9r = Z2965*ddx+Z2966*ddpsi+Z2967*ddq_imu+Z2968*ddq_w+Z2969*ddq_torso+Z2970*ddq_1r+Z2971*ddq_2r+Z2972*ddq_3r+Z2973*ddq_4r+Z2974*ddq_5r+Z2975*ddq_6r+Z2741*ddq_7r+Z2976;
 
% LHS_10r = 
%
%    - Z1521 - Z1510*ddpsi - Z1514*ddq_1r - Z1512*ddq_w - Z1515*ddq_2r - Z1516*ddq_3r - Z1517*ddq_4r - Z1518*ddq_5r - Z1519*ddq_6r - Z1520*ddq_7r - Z1511*ddq_imu - Z1513*ddq_torso - Z1509*ddx
LHS_10r = -Z1509*ddx-Z1510*ddpsi-Z1511*ddq_imu-Z1512*ddq_w-Z1513*ddq_torso-Z1514*ddq_1r-Z1515*ddq_2r-Z1516*ddq_3r-Z1517*ddq_4r-Z1518*ddq_5r-Z1519*ddq_6r-Z1520*ddq_7r-Z1521;

%% RHS
% End-effector force/torque

syms Flx Fly Flz Frx Fry Frz Tlx Tly Tlz Trx Try Trz real
% Fl = [Flx Fly Flz]'; Tl = [Tlx Tly Tlz]'; % expressed in frame 10l
% Fr = [Frx Fry Frz]'; Tr = [Trx Try Trz]'; % expressed in frame 10r
% keysEq = {'x', 'psi', 'imu', 'w', 'torso', '4l', '5l', '6l', '7l', '8l', '9l', '10l', '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% 
% for i=1:19
%     EEffTerm = collect(Fl'*dv10l(:,i) + Tl'*dw10l(:,i) + Fr'*dv10r(:,i) + Tr'*dw10r(:,i),[Flx, Fly, Flz, Tlx, Tly, Tlz, Frx, Fry, Frz, Trx, Try, Trz]);
%     display(['EE_' keysEq{i} ' = ' char(EEffTerm) ';']);
% end


% End-effector force/torque
EE_x = Z368*Flx + Z379*Fly + (-Z348)*Flz + Z492*Frx + Z503*Fry + (-Z472)*Frz;
EE_psi = Z369*Flx + Z380*Fly + (-Z349)*Flz + Z116*Tlx + Z125*Tly + (-Z97)*Tlz + Z493*Frx + Z504*Fry + (-Z473)*Frz + Z221*Trx + Z230*Try + (-Z202)*Trz;
EE_imu = Z370*Flx + Z381*Fly + (-Z350)*Flz + Z117*Tlx + Z126*Tly + (-Z98)*Tlz + Z494*Frx + Z505*Fry + (-Z474)*Frz + Z222*Trx + Z231*Try + (-Z203)*Trz;
EE_w = Z371*Flx + Z382*Fly + (-Z351)*Flz + Z117*Tlx + Z126*Tly + (-Z98)*Tlz + Z495*Frx + Z506*Fry + (-Z475)*Frz + Z222*Trx + Z231*Try + (-Z203)*Trz;
EE_torso = Z372*Flx + Z383*Fly + (-Z352)*Flz + Z118*Tlx + Z127*Tly + (-Z99)*Tlz + Z496*Frx + Z507*Fry + (-Z476)*Frz + Z223*Trx + Z232*Try + (-Z204)*Trz;
EE_4l = Z373*Flx + Z384*Fly + (-Z353)*Flz + Z119*Tlx + Z128*Tly + (-Z100)*Tlz;
EE_5l = Z374*Flx + Z385*Fly + (-Z354)*Flz + Z120*Tlx + Z129*Tly + (-Z101)*Tlz;
EE_6l = Z375*Flx + Z386*Fly + (-Z355)*Flz + Z121*Tlx + Z130*Tly + (-Z102)*Tlz;
EE_7l = Z376*Flx + Z387*Fly + (-Z356)*Flz + Z122*Tlx + Z131*Tly + (-Z103)*Tlz;
EE_8l = Z377*Flx + Z388*Fly + Z123*Tlx + Z132*Tly + (-Z104)*Tlz;
EE_9l = Z378*Flx + Z389*Fly + Z124*Tlx + Z133*Tly;
EE_10l = (-1)*Tlz;
EE_4r = Z497*Frx + Z508*Fry + (-Z477)*Frz + Z224*Trx + Z233*Try + (-Z205)*Trz;
EE_5r = Z498*Frx + Z509*Fry + (-Z478)*Frz + Z225*Trx + Z234*Try + (-Z206)*Trz;
EE_6r = Z499*Frx + Z510*Fry + (-Z479)*Frz + Z226*Trx + Z235*Try + (-Z207)*Trz;
EE_7r = Z500*Frx + Z511*Fry + (-Z480)*Frz + Z227*Trx + Z236*Try + (-Z208)*Trz;
EE_8r = Z501*Frx + Z512*Fry + Z228*Trx + Z237*Try + (-Z209)*Trz;
EE_9r = Z502*Frx + Z513*Fry + Z229*Trx + Z238*Try;
EE_10r = (-1)*Trz;


% Gravitational forces
syms g real
% g_1 = Rot(f, '0', '1')*[0 0 -g]'
% g_1 =
%  
%              0
%  -g*cos(q_imu)
%  -g*sin(q_imu)
g_1 = [0; -Z13*g; -Z14*g];

% g_2 = collect(Rot(f, '1', '2')*g_1,g)
% g_2 =
%  
%                                  0
%    (Z14*sin(q_w) - Z13*cos(q_w))*g
%  (- Z14*cos(q_w) - Z13*sin(q_w))*g
g_2 = [0; -Z20*g; -Z21*g];

% g_3 = collect(Rot(f, '2', '3')*g_2,g)
% g_3 =
%  
%  (Z21*sin(q_torso))*g
%              (-Z20)*g
%  (Z21*cos(q_torso))*g
g_3 = [-Z26*g; -Z20*g; -Z28*g];

% g_4l = collect(Rot(f, '3', '4l')*g_3,g)
%  (Z28*sin(q_1l) - Z20*cos(q_1l))*g
%                           (-Z26)*g
%  (Z28*cos(q_1l) + Z20*sin(q_1l))*g
g_4l = [-Z32*g; -Z26*g; -Z35*g];

% g_5l = collect(Rot(f, '4l', '5l')*g_4l,g)
% g_5l =
%  
%                              Z32*g
%  (Z26*cos(q_2l) + Z35*sin(q_2l))*g
%  (Z26*sin(q_2l) - Z35*cos(q_2l))*g
g_5l = [Z32*g; -Z41*g; -Z45*g];

% g_6l = collect(Rot(f, '5l', '6l')*g_5l,g)
% g_6l =
%  
%  (- Z32*cos(q_3l) - Z45*sin(q_3l))*g
%                                Z41*g
%    (Z32*sin(q_3l) - Z45*cos(q_3l))*g
g_6l = [-Z52*g; Z41*g; -Z57*g];


% g_7l = collect(Rot(f, '6l', '7l')*g_6l,g)
% g_7l =
%  
%                                Z52*g
%    (Z57*sin(q_4l) - Z41*cos(q_4l))*g
%  (- Z57*cos(q_4l) - Z41*sin(q_4l))*g
g_7l = [Z52*g; -Z65*g; -Z71*g];

% g_8l = collect(Rot(f, '7l', '8l')*g_7l,g)
% g_8l =
%  
%  (- Z52*cos(q_5l) - Z71*sin(q_5l))*g
%                                Z65*g
%    (Z52*sin(q_5l) - Z71*cos(q_5l))*g
g_8l = [-Z80*g; Z65*g; -Z87*g];

% g_9l = collect(Rot(f, '8l', '9l')*g_8l,g)
% g_9l =
%  
%                                Z80*g
%    (Z87*sin(q_6l) - Z65*cos(q_6l))*g
%  (- Z87*cos(q_6l) - Z65*sin(q_6l))*g
g_9l = [Z80*g; -Z97*g; -Z105*g];

% g_10l = collect(Rot(f, '9l', '10l')*g_9l,g)
% g_10l =
%  
%  (- Z80*cos(q_7l) - Z105*sin(q_7l))*g
%    (Z105*cos(q_7l) - Z80*sin(q_7l))*g
%                                 Z97*g
g_10l = [-Z116*g; -Z125*g; Z97*g];

% g_4r = collect(Rot(f, '3', '4r')*g_3,g)
% g_4r =
%  
%  (- Z20*cos(q_1r) - Z28*sin(q_1r))*g
%                                Z26*g
%    (Z20*sin(q_1r) - Z28*cos(q_1r))*g
g_4r = [-Z137*g; Z26*g; -Z140*g];

% g_5r = collect(Rot(f, '4r', '5r')*g_4r,g)
% g_5r =
%  
%                                Z137*g
%    (Z140*sin(q_2r) - Z26*cos(q_2r))*g
%  (- Z140*cos(q_2r) - Z26*sin(q_2r))*g
g_5r = [Z137*g; -Z146*g; -Z150*g];

% g_6r = correct(Rot(f, '5r', '6r')*g_5r,g)
% g_6r =
%  
%  (- Z137*cos(q_3r) - Z150*sin(q_3r))*g
%                                Z146*g
%    (Z137*sin(q_3r) - Z150*cos(q_3r))*g
g_6r = [-Z157*g; Z146*g; -Z162*g];


% g_7r = correct(Rot(f, '6r', '7r')*g_6r,g)
% g_7r =
%  
%                                Z157*g
%    (Z162*sin(q_4r) - Z146*cos(q_4r))*g
%  (- Z162*cos(q_4r) - Z146*sin(q_4r))*g
g_7r = [Z157*g; -Z170*g; -Z176*g];

% g_8r = correct(Rot(f, '7r', '8r')*g_7r,g)
% g_8r =
%  
%  (- Z157*cos(q_5r) - Z176*sin(q_5r))*g
%                                Z170*g
%    (Z157*sin(q_5r) - Z176*cos(q_5r))*g
g_8r = [-Z185*g; Z170*g; -Z192*g];

% g_9r = correct(Rot(f, '8r', '9r')*g_8r,g)
% g_9r =
%  
%                                Z185*g
%    (Z192*sin(q_6r) - Z170*cos(q_6r))*g
%  (- Z192*cos(q_6r) - Z170*sin(q_6r))*g
g_9r = [Z185*g; -Z202*g; -Z210*g];

% g_10r = correct(Rot(f, '9r', '10r')*g_9r,g)
% g_10r =
%  
%  (- Z185*cos(q_7r) - Z210*sin(q_7r))*g
%    (Z210*cos(q_7r) - Z185*sin(q_7r))*g
%                                 Z202*g
g_10r = [-Z221*g; -Z230*g; Z202*g];


% mSxg_1 = 
%    MZ_1*Z13*g - MY_1*Z14*g
%    MX_1*Z14*g
%    -MX_1*Z13*g
Z2977 = MZ_1*Z13 - MY_1*Z14;
Z2978 = MX_1*Z14;
Z2979 = -MX_1*Z13;
mSxg_1 = [Z2977*g;Z2978*g;Z2979*g];
 
% mSxg_2 = 
%    MZ_2*Z20*g - MY_2*Z21*g
%    MX_2*Z21*g
%    -MX_2*Z20*g
Z2980 = MZ_2*Z20 - MY_2*Z21;
Z2981 = MX_2*Z21;
Z2982 = -MX_2*Z20;
mSxg_2 = [Z2980*g;Z2981*g;Z2982*g];
 
% mSxg_3 = 
%    MZ_3*Z20*g - MY_3*Z28*g
%    MX_3*Z28*g - MZ_3*Z26*g
%    MY_3*Z26*g - MX_3*Z20*g
Z2983 = MZ_3*Z20 - MY_3*Z28;
Z2984 = MX_3*Z28 - MZ_3*Z26;
Z2985 = MY_3*Z26 - MX_3*Z20;
mSxg_3 = [Z2983*g;Z2984*g;Z2985*g];
 
% mSxg_4l = 
%    MZ_4l*Z26*g - MY_4l*Z35*g
%    MX_4l*Z35*g - MZ_4l*Z32*g
%    MY_4l*Z32*g - MX_4l*Z26*g
Z2986 = MZ_4l*Z26 - MY_4l*Z35;
Z2987 = MX_4l*Z35 - MZ_4l*Z32;
Z2988 = MY_4l*Z32 - MX_4l*Z26;
mSxg_4l = [Z2986*g;Z2987*g;Z2988*g];
 
% mSxg_5l = 
%    MZ_5l*Z41*g - MY_5l*Z45*g
%    MX_5l*Z45*g + MZ_5l*Z32*g
%    - MX_5l*Z41*g - MY_5l*Z32*g
Z2989 = MZ_5l*Z41 - MY_5l*Z45;
Z2990 = MX_5l*Z45 + MZ_5l*Z32;
Z2991 = - MX_5l*Z41 - MY_5l*Z32;
mSxg_5l = [Z2989*g;Z2990*g;Z2991*g];
 
% mSxg_6l = 
%    - MY_6l*Z57*g - MZ_6l*Z41*g
%    MX_6l*Z57*g - MZ_6l*Z52*g
%    MX_6l*Z41*g + MY_6l*Z52*g
Z2992 = - MY_6l*Z57 - MZ_6l*Z41;
Z2993 = MX_6l*Z57 - MZ_6l*Z52;
Z2994 = MX_6l*Z41 + MY_6l*Z52;
mSxg_6l = [Z2992*g;Z2993*g;Z2994*g];
 
% mSxg_7l = 
%    MZ_7l*Z65*g - MY_7l*Z71*g
%    MX_7l*Z71*g + MZ_7l*Z52*g
%    - MX_7l*Z65*g - MY_7l*Z52*g
Z2995 = MZ_7l*Z65 - MY_7l*Z71;
Z2996 = MX_7l*Z71 + MZ_7l*Z52;
Z2997 = - MX_7l*Z65 - MY_7l*Z52;
mSxg_7l = [Z2995*g;Z2996*g;Z2997*g];
 
% mSxg_8l = 
%    - MY_8l*Z87*g - MZ_8l*Z65*g
%    MX_8l*Z87*g - MZ_8l*Z80*g
%    MX_8l*Z65*g + MY_8l*Z80*g
Z2998 = - MY_8l*Z87 - MZ_8l*Z65;
Z2999 = MX_8l*Z87 - MZ_8l*Z80;
Z3000 = MX_8l*Z65 + MY_8l*Z80;
mSxg_8l = [Z2998*g;Z2999*g;Z3000*g];
 
% mSxg_9l = 
%    MZ_9l*Z97*g - MY_9l*Z105*g
%    MX_9l*Z105*g + MZ_9l*Z80*g
%    - MX_9l*Z97*g - MY_9l*Z80*g
Z3001 = MZ_9l*Z97 - MY_9l*Z105;
Z3002 = MX_9l*Z105 + MZ_9l*Z80;
Z3003 = - MX_9l*Z97 - MY_9l*Z80;
mSxg_9l = [Z3001*g;Z3002*g;Z3003*g];
 
% mSxg_10l = 
%    MY_10l*Z97*g + MZ_10l*Z125*g
%    - MX_10l*Z97*g - MZ_10l*Z116*g
%    MY_10l*Z116*g - MX_10l*Z125*g
Z3004 = MY_10l*Z97 + MZ_10l*Z125;
Z3005 = - MX_10l*Z97 - MZ_10l*Z116;
Z3006 = MY_10l*Z116 - MX_10l*Z125;
mSxg_10l = [Z3004*g;Z3005*g;Z3006*g];
 
% mSxg_4r = 
%    - MY_4r*Z140*g - MZ_4r*Z26*g
%    MX_4r*Z140*g - MZ_4r*Z137*g
%    MX_4r*Z26*g + MY_4r*Z137*g
Z3007 = - MY_4r*Z140 - MZ_4r*Z26;
Z3008 = MX_4r*Z140 - MZ_4r*Z137;
Z3009 = MX_4r*Z26 + MY_4r*Z137;
mSxg_4r = [Z3007*g;Z3008*g;Z3009*g];
 
% mSxg_5r = 
%    MZ_5r*Z146*g - MY_5r*Z150*g
%    MX_5r*Z150*g + MZ_5r*Z137*g
%    - MX_5r*Z146*g - MY_5r*Z137*g
Z3010 = MZ_5r*Z146 - MY_5r*Z150;
Z3011 = MX_5r*Z150 + MZ_5r*Z137;
Z3012 = - MX_5r*Z146 - MY_5r*Z137;
mSxg_5r = [Z3010*g;Z3011*g;Z3012*g];
 
% mSxg_6r = 
%    - MY_6r*Z162*g - MZ_6r*Z146*g
%    MX_6r*Z162*g - MZ_6r*Z157*g
%    MX_6r*Z146*g + MY_6r*Z157*g
Z3013 = - MY_6r*Z162 - MZ_6r*Z146;
Z3014 = MX_6r*Z162 - MZ_6r*Z157;
Z3015 = MX_6r*Z146 + MY_6r*Z157;
mSxg_6r = [Z3013*g;Z3014*g;Z3015*g];
 
% mSxg_7r = 
%    MZ_7r*Z170*g - MY_7r*Z176*g
%    MX_7r*Z176*g + MZ_7r*Z157*g
%    - MX_7r*Z170*g - MY_7r*Z157*g
Z3016 = MZ_7r*Z170 - MY_7r*Z176;
Z3017 = MX_7r*Z176 + MZ_7r*Z157;
Z3018 = - MX_7r*Z170 - MY_7r*Z157;
mSxg_7r = [Z3016*g;Z3017*g;Z3018*g];
 
% mSxg_8r = 
%    - MY_8r*Z192*g - MZ_8r*Z170*g
%    MX_8r*Z192*g - MZ_8r*Z185*g
%    MX_8r*Z170*g + MY_8r*Z185*g
Z3019 = - MY_8r*Z192 - MZ_8r*Z170;
Z3020 = MX_8r*Z192 - MZ_8r*Z185;
Z3021 = MX_8r*Z170 + MY_8r*Z185;
mSxg_8r = [Z3019*g;Z3020*g;Z3021*g];
 
% mSxg_9r = 
%    MZ_9r*Z202*g - MY_9r*Z210*g
%    MX_9r*Z210*g + MZ_9r*Z185*g
%    - MX_9r*Z202*g - MY_9r*Z185*g
Z3022 = MZ_9r*Z202 - MY_9r*Z210;
Z3023 = MX_9r*Z210 + MZ_9r*Z185;
Z3024 = - MX_9r*Z202 - MY_9r*Z185;
mSxg_9r = [Z3022*g;Z3023*g;Z3024*g];
 
% mSxg_10r = 
%    MY_10r*Z202*g + MZ_10r*Z230*g
%    - MX_10r*Z202*g - MZ_10r*Z221*g
%    MY_10r*Z221*g - MX_10r*Z230*g
Z3025 = MY_10r*Z202 + MZ_10r*Z230;
Z3026 = - MX_10r*Z202 - MZ_10r*Z221;
Z3027 = MY_10r*Z221 - MX_10r*Z230;
mSxg_10r = [Z3025*g;Z3026*g;Z3027*g];


% gg = {g_1, g_2, g_3, g_4l, g_5l, g_6l, g_7l, g_8l, g_9l, g_10l, g_4r, g_5r, g_6r, g_7r, g_8r, g_9r, g_10r};
% mSxgg = {mSxg_1, mSxg_2, mSxg_3, mSxg_4l, mSxg_5l, mSxg_6l, mSxg_7l, mSxg_8l, mSxg_9l, mSxg_10l, mSxg_4r, mSxg_5r, mSxg_6r, mSxg_7r, mSxg_8r, mSxg_9r, mSxg_10r};
% keysBody = {'1', '2', '3', '4l', '5l', '6l', '7l', '8l', '9l', '10l', '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% dvv = {dv1, dv2, dv3, dv4l, dv5l, dv6l, dv7l, dv8l, dv9l, dv10l, ...
%     dv4r, dv5r, dv6r, dv7r, dv8r, dv9r, dv10r};
% dww = {dw1, dw2, dw3, dw4l, dw5l, dw6l, dw7l, dw8l, dw9l, dw10l, ...
%     dw4r, dw5r, dw6r, dw7r, dw8r, dw9r, dw10r};
% keysEq = {'x', 'psi', 'imu', 'w', 'torso', '4l', '5l', '6l', '7l', '8l', '9l', '10l', '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% n = 3027; 
% for i=1:19 % for each equation
%     G = sym(0);
%     for j=1:17 % for each body
%         thisBody = keysBody{j};
%         m = mass(f, thisBody);
%         mS = mCOM(f, thisBody);
%         G = G + m*gg{j}'*dvv{j}(:,i) + (mSxgg{j})'*dww{j}(:,i);
%     end
%     G = collect(G, g);
%     display(['% G_' keysEq{i} ' = ' char(G)]);
%     Z = diff(G, g);
%     if(length(symvar(Z))==1)
%         display(['G_' keysEq{i} ' = ' char(G) ';' ]); display(' ');
%     else
%         n = n + 1;
%         display(['Z' num2str(n) ' = ' char(Z) ';']);
%         display(['G_' keysEq{i} ' = Z' num2str(n) '*g;' ]); display(' ');
%     end
% end

% G_x = (- Z13*Z244*m_1 - Z14*Z245*m_1 - Z20*Z250*m_2 - Z20*Z250*m_3 - Z21*Z252*m_2 - Z26*Z257*m_3 - Z28*Z262*m_3 - Z26*Z257*m_4l - Z26*Z257*m_4r - Z32*Z269*m_4l - Z32*Z269*m_5l - Z35*Z277*m_4l - Z41*Z284*m_5l - Z41*Z284*m_6l - Z45*Z289*m_5l - Z52*Z296*m_6l - Z52*Z296*m_7l - Z57*Z303*m_6l - Z65*Z312*m_7l - Z65*Z312*m_8l - Z71*Z319*m_7l - Z80*Z328*m_8l - Z80*Z328*m_9l - Z87*Z337*m_8l - Z97*Z348*m_9l - Z97*Z348*m_10l - Z105*Z357*m_9l - Z116*Z368*m_10l - Z125*Z379*m_10l - Z137*Z393*m_4r - Z137*Z393*m_5r - Z140*Z401*m_4r - Z146*Z408*m_5r - Z146*Z408*m_6r - Z150*Z413*m_5r - Z157*Z420*m_6r - Z157*Z420*m_7r - Z162*Z427*m_6r - Z170*Z436*m_7r - Z170*Z436*m_8r - Z176*Z443*m_7r - Z185*Z452*m_8r - Z185*Z452*m_9r - Z192*Z461*m_8r - Z202*Z472*m_9r - Z202*Z472*m_10r - Z210*Z481*m_9r - Z221*Z492*m_10r - Z230*Z503*m_10r)*g
Z3028 = - Z13*Z244*m_1 - Z14*Z245*m_1 - Z20*Z250*m_2 - Z20*Z250*m_3 - Z21*Z252*m_2 - Z26*Z257*m_3 - Z28*Z262*m_3 - Z26*Z257*m_4l - Z26*Z257*m_4r - Z32*Z269*m_4l - Z32*Z269*m_5l - Z35*Z277*m_4l - Z41*Z284*m_5l - Z41*Z284*m_6l - Z45*Z289*m_5l - Z52*Z296*m_6l - Z52*Z296*m_7l - Z57*Z303*m_6l - Z65*Z312*m_7l - Z65*Z312*m_8l - Z71*Z319*m_7l - Z80*Z328*m_8l - Z80*Z328*m_9l - Z87*Z337*m_8l - Z97*Z348*m_9l - Z97*Z348*m_10l - Z105*Z357*m_9l - Z116*Z368*m_10l - Z125*Z379*m_10l - Z137*Z393*m_4r - Z137*Z393*m_5r - Z140*Z401*m_4r - Z146*Z408*m_5r - Z146*Z408*m_6r - Z150*Z413*m_5r - Z157*Z420*m_6r - Z157*Z420*m_7r - Z162*Z427*m_6r - Z170*Z436*m_7r - Z170*Z436*m_8r - Z176*Z443*m_7r - Z185*Z452*m_8r - Z185*Z452*m_9r - Z192*Z461*m_8r - Z202*Z472*m_9r - Z202*Z472*m_10r - Z210*Z481*m_9r - Z221*Z492*m_10r - Z230*Z503*m_10r;
G_x = Z3028*g;
 
% G_psi = (Z13*Z2978 + Z14*Z2979 + Z20*Z2981 + Z21*Z2982 + Z20*Z2984 + Z26*Z2983 + Z26*Z2987 + Z28*Z2985 + Z32*Z2986 - Z32*Z2989 + Z35*Z2988 + Z41*Z2990 - Z26*Z3008 - Z41*Z2993 + Z45*Z2991 + Z52*Z2992 - Z52*Z2995 + Z57*Z2994 + Z65*Z2996 - Z65*Z2999 + Z71*Z2997 + Z80*Z2998 - Z80*Z3001 + Z87*Z3000 + Z97*Z3002 - Z97*Z3006 + Z105*Z3003 + Z116*Z3004 + Z125*Z3005 + Z137*Z3007 - Z137*Z3010 + Z140*Z3009 + Z146*Z3011 - Z146*Z3014 + Z150*Z3012 + Z157*Z3013 - Z157*Z3016 + Z162*Z3015 + Z170*Z3017 - Z170*Z3020 + Z176*Z3018 + Z185*Z3019 - Z185*Z3022 + Z192*Z3021 + Z202*Z3023 - Z202*Z3027 + Z210*Z3024 + Z221*Z3025 + Z230*Z3026 - Z20*Z61*m_3 - Z28*Z63*m_3 - Z26*Z74*m_4l - Z41*Z85*m_5l - Z41*Z85*m_6l - Z26*Z258*m_3 - Z32*Z270*m_4l - Z32*Z270*m_5l - Z35*Z278*m_4l - Z45*Z290*m_5l - Z146*Z190*m_5r - Z146*Z190*m_6r - Z52*Z297*m_6l - Z52*Z297*m_7l - Z57*Z304*m_6l - Z65*Z313*m_7l - Z65*Z313*m_8l - Z71*Z320*m_7l - Z80*Z329*m_8l - Z80*Z329*m_9l - Z87*Z338*m_8l + Z26*Z398*m_4r - Z97*Z349*m_9l - Z97*Z349*m_10l - Z105*Z358*m_9l - Z116*Z369*m_10l - Z125*Z380*m_10l - Z137*Z394*m_4r - Z137*Z394*m_5r - Z140*Z402*m_4r - Z150*Z414*m_5r - Z157*Z421*m_6r - Z157*Z421*m_7r - Z162*Z428*m_6r - Z170*Z437*m_7r - Z170*Z437*m_8r - Z176*Z444*m_7r - Z185*Z453*m_8r - Z185*Z453*m_9r - Z192*Z462*m_8r - Z202*Z473*m_9r - Z202*Z473*m_10r - Z210*Z482*m_9r - Z221*Z493*m_10r - Z230*Z504*m_10r)*g
Z3029 = Z13*Z2978 + Z14*Z2979 + Z20*Z2981 + Z21*Z2982 + Z20*Z2984 + Z26*Z2983 + Z26*Z2987 + Z28*Z2985 + Z32*Z2986 - Z32*Z2989 + Z35*Z2988 + Z41*Z2990 - Z26*Z3008 - Z41*Z2993 + Z45*Z2991 + Z52*Z2992 - Z52*Z2995 + Z57*Z2994 + Z65*Z2996 - Z65*Z2999 + Z71*Z2997 + Z80*Z2998 - Z80*Z3001 + Z87*Z3000 + Z97*Z3002 - Z97*Z3006 + Z105*Z3003 + Z116*Z3004 + Z125*Z3005 + Z137*Z3007 - Z137*Z3010 + Z140*Z3009 + Z146*Z3011 - Z146*Z3014 + Z150*Z3012 + Z157*Z3013 - Z157*Z3016 + Z162*Z3015 + Z170*Z3017 - Z170*Z3020 + Z176*Z3018 + Z185*Z3019 - Z185*Z3022 + Z192*Z3021 + Z202*Z3023 - Z202*Z3027 + Z210*Z3024 + Z221*Z3025 + Z230*Z3026 - Z20*Z61*m_3 - Z28*Z63*m_3 - Z26*Z74*m_4l - Z41*Z85*m_5l - Z41*Z85*m_6l - Z26*Z258*m_3 - Z32*Z270*m_4l - Z32*Z270*m_5l - Z35*Z278*m_4l - Z45*Z290*m_5l - Z146*Z190*m_5r - Z146*Z190*m_6r - Z52*Z297*m_6l - Z52*Z297*m_7l - Z57*Z304*m_6l - Z65*Z313*m_7l - Z65*Z313*m_8l - Z71*Z320*m_7l - Z80*Z329*m_8l - Z80*Z329*m_9l - Z87*Z338*m_8l + Z26*Z398*m_4r - Z97*Z349*m_9l - Z97*Z349*m_10l - Z105*Z358*m_9l - Z116*Z369*m_10l - Z125*Z380*m_10l - Z137*Z394*m_4r - Z137*Z394*m_5r - Z140*Z402*m_4r - Z150*Z414*m_5r - Z157*Z421*m_6r - Z157*Z421*m_7r - Z162*Z428*m_6r - Z170*Z437*m_7r - Z170*Z437*m_8r - Z176*Z444*m_7r - Z185*Z453*m_8r - Z185*Z453*m_9r - Z192*Z462*m_8r - Z202*Z473*m_9r - Z202*Z473*m_10r - Z210*Z482*m_9r - Z221*Z493*m_10r - Z230*Z504*m_10r;
G_psi = Z3029*g;
 
% G_imu = (Z25*Z2983 - Z2980 - Z2977 + Z25*Z2987 + Z27*Z2985 + Z33*Z2986 - Z33*Z2989 + Z36*Z2988 + Z42*Z2990 - Z25*Z3008 - Z42*Z2993 + Z46*Z2991 + Z53*Z2992 - Z53*Z2995 + Z58*Z2994 + Z66*Z2996 - Z66*Z2999 + Z72*Z2997 + Z81*Z2998 - Z81*Z3001 + Z88*Z3000 + Z98*Z3002 - Z98*Z3006 + Z106*Z3003 + Z117*Z3004 + Z126*Z3005 + Z138*Z3007 - Z138*Z3010 + Z141*Z3009 + Z147*Z3011 - Z147*Z3014 + Z151*Z3012 + Z158*Z3013 - Z158*Z3016 + Z163*Z3015 + Z171*Z3017 - Z171*Z3020 + Z177*Z3018 + Z186*Z3019 - Z186*Z3022 + Z193*Z3021 + Z203*Z3023 - Z203*Z3027 + Z211*Z3024 + Z222*Z3025 + Z231*Z3026 - Z20*Z251*m_2 - Z21*Z253*m_2 - Z26*Z259*m_3 - Z28*Z264*m_3 - Z26*Z275*m_4l - Z32*Z271*m_4l - Z32*Z271*m_5l - Z35*Z279*m_4l - Z41*Z286*m_5l - Z41*Z286*m_6l - Z45*Z291*m_5l - Z52*Z298*m_6l - Z52*Z298*m_7l - Z57*Z305*m_6l - Z65*Z314*m_7l - Z65*Z314*m_8l - Z71*Z321*m_7l - Z80*Z330*m_8l - Z80*Z330*m_9l - Z87*Z339*m_8l + Z26*Z399*m_4r - Z97*Z350*m_9l - Z97*Z350*m_10l - Z105*Z359*m_9l - Z116*Z370*m_10l - Z125*Z381*m_10l - Z137*Z395*m_4r - Z137*Z395*m_5r - Z140*Z403*m_4r - Z146*Z410*m_5r - Z146*Z410*m_6r - Z150*Z415*m_5r - Z157*Z422*m_6r - Z157*Z422*m_7r - Z162*Z429*m_6r - Z170*Z438*m_7r - Z170*Z438*m_8r - Z176*Z445*m_7r - Z185*Z454*m_8r - Z185*Z454*m_9r - Z192*Z463*m_8r - Z202*Z474*m_9r - Z202*Z474*m_10r - Z210*Z483*m_9r - Z221*Z494*m_10r - Z230*Z505*m_10r)*g
Z3030 = Z25*Z2983 - Z2980 - Z2977 + Z25*Z2987 + Z27*Z2985 + Z33*Z2986 - Z33*Z2989 + Z36*Z2988 + Z42*Z2990 - Z25*Z3008 - Z42*Z2993 + Z46*Z2991 + Z53*Z2992 - Z53*Z2995 + Z58*Z2994 + Z66*Z2996 - Z66*Z2999 + Z72*Z2997 + Z81*Z2998 - Z81*Z3001 + Z88*Z3000 + Z98*Z3002 - Z98*Z3006 + Z106*Z3003 + Z117*Z3004 + Z126*Z3005 + Z138*Z3007 - Z138*Z3010 + Z141*Z3009 + Z147*Z3011 - Z147*Z3014 + Z151*Z3012 + Z158*Z3013 - Z158*Z3016 + Z163*Z3015 + Z171*Z3017 - Z171*Z3020 + Z177*Z3018 + Z186*Z3019 - Z186*Z3022 + Z193*Z3021 + Z203*Z3023 - Z203*Z3027 + Z211*Z3024 + Z222*Z3025 + Z231*Z3026 - Z20*Z251*m_2 - Z21*Z253*m_2 - Z26*Z259*m_3 - Z28*Z264*m_3 - Z26*Z275*m_4l - Z32*Z271*m_4l - Z32*Z271*m_5l - Z35*Z279*m_4l - Z41*Z286*m_5l - Z41*Z286*m_6l - Z45*Z291*m_5l - Z52*Z298*m_6l - Z52*Z298*m_7l - Z57*Z305*m_6l - Z65*Z314*m_7l - Z65*Z314*m_8l - Z71*Z321*m_7l - Z80*Z330*m_8l - Z80*Z330*m_9l - Z87*Z339*m_8l + Z26*Z399*m_4r - Z97*Z350*m_9l - Z97*Z350*m_10l - Z105*Z359*m_9l - Z116*Z370*m_10l - Z125*Z381*m_10l - Z137*Z395*m_4r - Z137*Z395*m_5r - Z140*Z403*m_4r - Z146*Z410*m_5r - Z146*Z410*m_6r - Z150*Z415*m_5r - Z157*Z422*m_6r - Z157*Z422*m_7r - Z162*Z429*m_6r - Z170*Z438*m_7r - Z170*Z438*m_8r - Z176*Z445*m_7r - Z185*Z454*m_8r - Z185*Z454*m_9r - Z192*Z463*m_8r - Z202*Z474*m_9r - Z202*Z474*m_10r - Z210*Z483*m_9r - Z221*Z494*m_10r - Z230*Z505*m_10r;
G_imu = Z3030*g;
 
% G_w = (Z25*Z2983 - Z2980 + Z25*Z2987 + Z27*Z2985 + Z33*Z2986 - Z33*Z2989 + Z36*Z2988 + Z42*Z2990 - Z25*Z3008 - Z42*Z2993 + Z46*Z2991 + Z53*Z2992 - Z53*Z2995 + Z58*Z2994 + Z66*Z2996 - Z66*Z2999 + Z72*Z2997 + Z81*Z2998 - Z81*Z3001 + Z88*Z3000 + Z98*Z3002 - Z98*Z3006 + Z106*Z3003 + Z117*Z3004 + Z126*Z3005 + Z138*Z3007 - Z138*Z3010 + Z141*Z3009 + Z147*Z3011 - Z147*Z3014 + Z151*Z3012 + Z158*Z3013 - Z158*Z3016 + Z163*Z3015 + Z171*Z3017 - Z171*Z3020 + Z177*Z3018 + Z186*Z3019 - Z186*Z3022 + Z193*Z3021 + Z203*Z3023 - Z203*Z3027 + Z211*Z3024 + Z222*Z3025 + Z231*Z3026 - L4*Z20*m_3 - Z26*Z260*m_3 - Z28*Z265*m_3 - Z26*Z276*m_4l - Z32*Z272*m_4l - Z32*Z272*m_5l - Z35*Z280*m_4l - Z41*Z287*m_5l - Z41*Z287*m_6l - Z45*Z292*m_5l - Z52*Z299*m_6l - Z52*Z299*m_7l - Z57*Z306*m_6l - Z65*Z315*m_7l - Z65*Z315*m_8l - Z71*Z322*m_7l - Z80*Z331*m_8l - Z80*Z331*m_9l - Z87*Z340*m_8l + Z26*Z400*m_4r - Z97*Z351*m_9l - Z97*Z351*m_10l - Z105*Z360*m_9l - Z116*Z371*m_10l - Z125*Z382*m_10l - Z137*Z396*m_4r - Z137*Z396*m_5r - Z140*Z404*m_4r - Z146*Z411*m_5r - Z146*Z411*m_6r - Z150*Z416*m_5r - Z157*Z423*m_6r - Z157*Z423*m_7r - Z162*Z430*m_6r - Z170*Z439*m_7r - Z170*Z439*m_8r - Z176*Z446*m_7r - Z185*Z455*m_8r - Z185*Z455*m_9r - Z192*Z464*m_8r - Z202*Z475*m_9r - Z202*Z475*m_10r - Z210*Z484*m_9r - Z221*Z495*m_10r - Z230*Z506*m_10r)*g
Z3031 = Z25*Z2983 - Z2980 + Z25*Z2987 + Z27*Z2985 + Z33*Z2986 - Z33*Z2989 + Z36*Z2988 + Z42*Z2990 - Z25*Z3008 - Z42*Z2993 + Z46*Z2991 + Z53*Z2992 - Z53*Z2995 + Z58*Z2994 + Z66*Z2996 - Z66*Z2999 + Z72*Z2997 + Z81*Z2998 - Z81*Z3001 + Z88*Z3000 + Z98*Z3002 - Z98*Z3006 + Z106*Z3003 + Z117*Z3004 + Z126*Z3005 + Z138*Z3007 - Z138*Z3010 + Z141*Z3009 + Z147*Z3011 - Z147*Z3014 + Z151*Z3012 + Z158*Z3013 - Z158*Z3016 + Z163*Z3015 + Z171*Z3017 - Z171*Z3020 + Z177*Z3018 + Z186*Z3019 - Z186*Z3022 + Z193*Z3021 + Z203*Z3023 - Z203*Z3027 + Z211*Z3024 + Z222*Z3025 + Z231*Z3026 - L4*Z20*m_3 - Z26*Z260*m_3 - Z28*Z265*m_3 - Z26*Z276*m_4l - Z32*Z272*m_4l - Z32*Z272*m_5l - Z35*Z280*m_4l - Z41*Z287*m_5l - Z41*Z287*m_6l - Z45*Z292*m_5l - Z52*Z299*m_6l - Z52*Z299*m_7l - Z57*Z306*m_6l - Z65*Z315*m_7l - Z65*Z315*m_8l - Z71*Z322*m_7l - Z80*Z331*m_8l - Z80*Z331*m_9l - Z87*Z340*m_8l + Z26*Z400*m_4r - Z97*Z351*m_9l - Z97*Z351*m_10l - Z105*Z360*m_9l - Z116*Z371*m_10l - Z125*Z382*m_10l - Z137*Z396*m_4r - Z137*Z396*m_5r - Z140*Z404*m_4r - Z146*Z411*m_5r - Z146*Z411*m_6r - Z150*Z416*m_5r - Z157*Z423*m_6r - Z157*Z423*m_7r - Z162*Z430*m_6r - Z170*Z439*m_7r - Z170*Z439*m_8r - Z176*Z446*m_7r - Z185*Z455*m_8r - Z185*Z455*m_9r - Z192*Z464*m_8r - Z202*Z475*m_9r - Z202*Z475*m_10r - Z210*Z484*m_9r - Z221*Z495*m_10r - Z230*Z506*m_10r;
G_w = Z3031*g;
 
% G_torso = (Z34*Z2986 - Z2984 - Z34*Z2989 + Z37*Z2988 + Z43*Z2990 - Z43*Z2993 + Z47*Z2991 + Z54*Z2992 - Z54*Z2995 + Z59*Z2994 + Z67*Z2996 - Z67*Z2999 + Z73*Z2997 + Z82*Z2998 - Z82*Z3001 + Z89*Z3000 + Z99*Z3002 - Z99*Z3006 + Z107*Z3003 + Z118*Z3004 + Z127*Z3005 + Z139*Z3007 - Z139*Z3010 + Z142*Z3009 + Z148*Z3011 - Z148*Z3014 + Z152*Z3012 + Z159*Z3013 - Z159*Z3016 + Z164*Z3015 + Z172*Z3017 - Z172*Z3020 + Z178*Z3018 + Z187*Z3019 - Z187*Z3022 + Z194*Z3021 + Z204*Z3023 - Z204*Z3027 + Z212*Z3024 + Z223*Z3025 + Z232*Z3026 - Z32*Z273*m_4l - Z32*Z273*m_5l - Z35*Z281*m_4l - Z41*Z288*m_5l - Z41*Z288*m_6l - Z45*Z293*m_5l - Z52*Z300*m_6l - Z52*Z300*m_7l - Z57*Z307*m_6l - Z65*Z316*m_7l - Z65*Z316*m_8l - Z71*Z323*m_7l - Z80*Z332*m_8l - Z80*Z332*m_9l - Z87*Z341*m_8l - Z97*Z352*m_9l - Z97*Z352*m_10l - Z105*Z361*m_9l - Z116*Z372*m_10l - Z125*Z383*m_10l - Z137*Z397*m_4r - Z137*Z397*m_5r - Z140*Z405*m_4r - Z146*Z412*m_5r - Z146*Z412*m_6r - Z150*Z417*m_5r - Z157*Z424*m_6r - Z157*Z424*m_7r - Z162*Z431*m_6r - Z170*Z440*m_7r - Z170*Z440*m_8r - Z176*Z447*m_7r - Z185*Z456*m_8r - Z185*Z456*m_9r - Z192*Z465*m_8r - Z202*Z476*m_9r - Z202*Z476*m_10r - Z210*Z485*m_9r - Z221*Z496*m_10r - Z230*Z507*m_10r)*g
Z3032 = Z34*Z2986 - Z2984 - Z34*Z2989 + Z37*Z2988 + Z43*Z2990 - Z43*Z2993 + Z47*Z2991 + Z54*Z2992 - Z54*Z2995 + Z59*Z2994 + Z67*Z2996 - Z67*Z2999 + Z73*Z2997 + Z82*Z2998 - Z82*Z3001 + Z89*Z3000 + Z99*Z3002 - Z99*Z3006 + Z107*Z3003 + Z118*Z3004 + Z127*Z3005 + Z139*Z3007 - Z139*Z3010 + Z142*Z3009 + Z148*Z3011 - Z148*Z3014 + Z152*Z3012 + Z159*Z3013 - Z159*Z3016 + Z164*Z3015 + Z172*Z3017 - Z172*Z3020 + Z178*Z3018 + Z187*Z3019 - Z187*Z3022 + Z194*Z3021 + Z204*Z3023 - Z204*Z3027 + Z212*Z3024 + Z223*Z3025 + Z232*Z3026 - Z32*Z273*m_4l - Z32*Z273*m_5l - Z35*Z281*m_4l - Z41*Z288*m_5l - Z41*Z288*m_6l - Z45*Z293*m_5l - Z52*Z300*m_6l - Z52*Z300*m_7l - Z57*Z307*m_6l - Z65*Z316*m_7l - Z65*Z316*m_8l - Z71*Z323*m_7l - Z80*Z332*m_8l - Z80*Z332*m_9l - Z87*Z341*m_8l - Z97*Z352*m_9l - Z97*Z352*m_10l - Z105*Z361*m_9l - Z116*Z372*m_10l - Z125*Z383*m_10l - Z137*Z397*m_4r - Z137*Z397*m_5r - Z140*Z405*m_4r - Z146*Z412*m_5r - Z146*Z412*m_6r - Z150*Z417*m_5r - Z157*Z424*m_6r - Z157*Z424*m_7r - Z162*Z431*m_6r - Z170*Z440*m_7r - Z170*Z440*m_8r - Z176*Z447*m_7r - Z185*Z456*m_8r - Z185*Z456*m_9r - Z192*Z465*m_8r - Z202*Z476*m_9r - Z202*Z476*m_10r - Z210*Z485*m_9r - Z221*Z496*m_10r - Z230*Z507*m_10r;
G_torso = Z3032*g;
 
% G_4l = (Z44*Z2990 - Z2987 - Z44*Z2993 + Z48*Z2991 + Z55*Z2992 - Z55*Z2995 + Z60*Z2994 + Z68*Z2996 - Z68*Z2999 + Z74*Z2997 + Z83*Z2998 - Z83*Z3001 + Z90*Z3000 + Z100*Z3002 - Z100*Z3006 + Z108*Z3003 + Z119*Z3004 + Z128*Z3005 - Z52*Z301*m_6l - Z52*Z301*m_7l - Z57*Z308*m_6l - Z65*Z317*m_7l - Z65*Z317*m_8l - Z71*Z324*m_7l - Z80*Z333*m_8l - Z80*Z333*m_9l - Z87*Z342*m_8l - Z97*Z353*m_9l - Z97*Z353*m_10l - Z105*Z362*m_9l - Z116*Z373*m_10l - Z125*Z384*m_10l)*g
Z3033 = Z44*Z2990 - Z2987 - Z44*Z2993 + Z48*Z2991 + Z55*Z2992 - Z55*Z2995 + Z60*Z2994 + Z68*Z2996 - Z68*Z2999 + Z74*Z2997 + Z83*Z2998 - Z83*Z3001 + Z90*Z3000 + Z100*Z3002 - Z100*Z3006 + Z108*Z3003 + Z119*Z3004 + Z128*Z3005 - Z52*Z301*m_6l - Z52*Z301*m_7l - Z57*Z308*m_6l - Z65*Z317*m_7l - Z65*Z317*m_8l - Z71*Z324*m_7l - Z80*Z333*m_8l - Z80*Z333*m_9l - Z87*Z342*m_8l - Z97*Z353*m_9l - Z97*Z353*m_10l - Z105*Z362*m_9l - Z116*Z373*m_10l - Z125*Z384*m_10l;
G_4l = Z3033*g;
 
% G_5l = (Z56*Z2992 - Z2989 - Z56*Z2995 + Z61*Z2994 + Z69*Z2996 - Z69*Z2999 + Z75*Z2997 + Z84*Z2998 - Z84*Z3001 + Z91*Z3000 + Z101*Z3002 - Z101*Z3006 + Z109*Z3003 + Z120*Z3004 + Z129*Z3005 - Z52*Z302*m_6l - Z52*Z302*m_7l - Z57*Z309*m_6l - Z65*Z318*m_7l - Z65*Z318*m_8l - Z71*Z325*m_7l - Z80*Z334*m_8l - Z80*Z334*m_9l - Z87*Z343*m_8l - Z97*Z354*m_9l - Z97*Z354*m_10l - Z105*Z363*m_9l - Z116*Z374*m_10l - Z125*Z385*m_10l)*g
Z3034 = Z56*Z2992 - Z2989 - Z56*Z2995 + Z61*Z2994 + Z69*Z2996 - Z69*Z2999 + Z75*Z2997 + Z84*Z2998 - Z84*Z3001 + Z91*Z3000 + Z101*Z3002 - Z101*Z3006 + Z109*Z3003 + Z120*Z3004 + Z129*Z3005 - Z52*Z302*m_6l - Z52*Z302*m_7l - Z57*Z309*m_6l - Z65*Z318*m_7l - Z65*Z318*m_8l - Z71*Z325*m_7l - Z80*Z334*m_8l - Z80*Z334*m_9l - Z87*Z343*m_8l - Z97*Z354*m_9l - Z97*Z354*m_10l - Z105*Z363*m_9l - Z116*Z374*m_10l - Z125*Z385*m_10l;
G_5l = Z3034*g;
 
% G_6l = (Z70*Z2996 - Z2993 - Z70*Z2999 + Z76*Z2997 + Z85*Z2998 - Z85*Z3001 + Z92*Z3000 + Z102*Z3002 - Z102*Z3006 + Z110*Z3003 + Z121*Z3004 + Z130*Z3005 - Z80*Z335*m_8l - Z80*Z335*m_9l - Z87*Z344*m_8l - Z97*Z355*m_9l - Z97*Z355*m_10l - Z105*Z364*m_9l - Z116*Z375*m_10l - Z125*Z386*m_10l)*g
Z3035 = Z70*Z2996 - Z2993 - Z70*Z2999 + Z76*Z2997 + Z85*Z2998 - Z85*Z3001 + Z92*Z3000 + Z102*Z3002 - Z102*Z3006 + Z110*Z3003 + Z121*Z3004 + Z130*Z3005 - Z80*Z335*m_8l - Z80*Z335*m_9l - Z87*Z344*m_8l - Z97*Z355*m_9l - Z97*Z355*m_10l - Z105*Z364*m_9l - Z116*Z375*m_10l - Z125*Z386*m_10l;
G_6l = Z3035*g;
 
% G_7l = (Z86*Z2998 - Z2995 - Z86*Z3001 + Z93*Z3000 + Z103*Z3002 - Z103*Z3006 + Z111*Z3003 + Z122*Z3004 + Z131*Z3005 - Z80*Z336*m_8l - Z80*Z336*m_9l - Z87*Z345*m_8l - Z97*Z356*m_9l - Z97*Z356*m_10l - Z105*Z365*m_9l - Z116*Z376*m_10l - Z125*Z387*m_10l)*g
Z3036 = Z86*Z2998 - Z2995 - Z86*Z3001 + Z93*Z3000 + Z103*Z3002 - Z103*Z3006 + Z111*Z3003 + Z122*Z3004 + Z131*Z3005 - Z80*Z336*m_8l - Z80*Z336*m_9l - Z87*Z345*m_8l - Z97*Z356*m_9l - Z97*Z356*m_10l - Z105*Z365*m_9l - Z116*Z376*m_10l - Z125*Z387*m_10l;
G_7l = Z3036*g;
 
% G_8l = (Z104*Z3002 - Z2999 - Z104*Z3006 + Z112*Z3003 + Z123*Z3004 + Z132*Z3005 - Z116*Z377*m_10l - Z125*Z388*m_10l)*g
Z3037 = Z104*Z3002 - Z2999 - Z104*Z3006 + Z112*Z3003 + Z123*Z3004 + Z132*Z3005 - Z116*Z377*m_10l - Z125*Z388*m_10l;
G_8l = Z3037*g;
 
% G_9l = (Z124*Z3004 - Z3001 + Z133*Z3005 - Z116*Z378*m_10l - Z125*Z389*m_10l)*g
Z3038 = Z124*Z3004 - Z3001 + Z133*Z3005 - Z116*Z378*m_10l - Z125*Z389*m_10l;
G_9l = Z3038*g;
 
% G_10l = (-Z3006)*g
G_10l = (-Z3006)*g;
 
% G_4r = (Z149*Z3011 - Z3008 - Z149*Z3014 + Z153*Z3012 + Z160*Z3013 - Z160*Z3016 + Z165*Z3015 + Z173*Z3017 - Z173*Z3020 + Z179*Z3018 + Z188*Z3019 - Z188*Z3022 + Z195*Z3021 + Z205*Z3023 - Z205*Z3027 + Z213*Z3024 + Z224*Z3025 + Z233*Z3026 - Z157*Z425*m_6r - Z157*Z425*m_7r - Z162*Z432*m_6r - Z170*Z441*m_7r - Z170*Z441*m_8r - Z176*Z448*m_7r - Z185*Z457*m_8r - Z185*Z457*m_9r - Z192*Z466*m_8r - Z202*Z477*m_9r - Z202*Z477*m_10r - Z210*Z486*m_9r - Z221*Z497*m_10r - Z230*Z508*m_10r)*g
Z3039 = Z149*Z3011 - Z3008 - Z149*Z3014 + Z153*Z3012 + Z160*Z3013 - Z160*Z3016 + Z165*Z3015 + Z173*Z3017 - Z173*Z3020 + Z179*Z3018 + Z188*Z3019 - Z188*Z3022 + Z195*Z3021 + Z205*Z3023 - Z205*Z3027 + Z213*Z3024 + Z224*Z3025 + Z233*Z3026 - Z157*Z425*m_6r - Z157*Z425*m_7r - Z162*Z432*m_6r - Z170*Z441*m_7r - Z170*Z441*m_8r - Z176*Z448*m_7r - Z185*Z457*m_8r - Z185*Z457*m_9r - Z192*Z466*m_8r - Z202*Z477*m_9r - Z202*Z477*m_10r - Z210*Z486*m_9r - Z221*Z497*m_10r - Z230*Z508*m_10r;
G_4r = Z3039*g;
 
% G_5r = (Z161*Z3013 - Z3010 - Z161*Z3016 + Z166*Z3015 + Z174*Z3017 - Z174*Z3020 + Z180*Z3018 + Z189*Z3019 - Z189*Z3022 + Z196*Z3021 + Z206*Z3023 - Z206*Z3027 + Z214*Z3024 + Z225*Z3025 + Z234*Z3026 - Z157*Z426*m_6r - Z157*Z426*m_7r - Z162*Z433*m_6r - Z170*Z442*m_7r - Z170*Z442*m_8r - Z176*Z449*m_7r - Z185*Z458*m_8r - Z185*Z458*m_9r - Z192*Z467*m_8r - Z202*Z478*m_9r - Z202*Z478*m_10r - Z210*Z487*m_9r - Z221*Z498*m_10r - Z230*Z509*m_10r)*g
Z3040 = Z161*Z3013 - Z3010 - Z161*Z3016 + Z166*Z3015 + Z174*Z3017 - Z174*Z3020 + Z180*Z3018 + Z189*Z3019 - Z189*Z3022 + Z196*Z3021 + Z206*Z3023 - Z206*Z3027 + Z214*Z3024 + Z225*Z3025 + Z234*Z3026 - Z157*Z426*m_6r - Z157*Z426*m_7r - Z162*Z433*m_6r - Z170*Z442*m_7r - Z170*Z442*m_8r - Z176*Z449*m_7r - Z185*Z458*m_8r - Z185*Z458*m_9r - Z192*Z467*m_8r - Z202*Z478*m_9r - Z202*Z478*m_10r - Z210*Z487*m_9r - Z221*Z498*m_10r - Z230*Z509*m_10r;
G_5r = Z3040*g;
 
% G_6r = (Z175*Z3017 - Z3014 - Z175*Z3020 + Z181*Z3018 + Z190*Z3019 - Z190*Z3022 + Z197*Z3021 + Z207*Z3023 - Z207*Z3027 + Z215*Z3024 + Z226*Z3025 + Z235*Z3026 - Z185*Z459*m_8r - Z185*Z459*m_9r - Z192*Z468*m_8r - Z202*Z479*m_9r - Z202*Z479*m_10r - Z210*Z488*m_9r - Z221*Z499*m_10r - Z230*Z510*m_10r)*g
Z3041 = Z175*Z3017 - Z3014 - Z175*Z3020 + Z181*Z3018 + Z190*Z3019 - Z190*Z3022 + Z197*Z3021 + Z207*Z3023 - Z207*Z3027 + Z215*Z3024 + Z226*Z3025 + Z235*Z3026 - Z185*Z459*m_8r - Z185*Z459*m_9r - Z192*Z468*m_8r - Z202*Z479*m_9r - Z202*Z479*m_10r - Z210*Z488*m_9r - Z221*Z499*m_10r - Z230*Z510*m_10r;
G_6r = Z3041*g;
 
% G_7r = (Z191*Z3019 - Z3016 - Z191*Z3022 + Z198*Z3021 + Z208*Z3023 - Z208*Z3027 + Z216*Z3024 + Z227*Z3025 + Z236*Z3026 - Z185*Z460*m_8r - Z185*Z460*m_9r - Z192*Z469*m_8r - Z202*Z480*m_9r - Z202*Z480*m_10r - Z210*Z489*m_9r - Z221*Z500*m_10r - Z230*Z511*m_10r)*g
Z3042 = Z191*Z3019 - Z3016 - Z191*Z3022 + Z198*Z3021 + Z208*Z3023 - Z208*Z3027 + Z216*Z3024 + Z227*Z3025 + Z236*Z3026 - Z185*Z460*m_8r - Z185*Z460*m_9r - Z192*Z469*m_8r - Z202*Z480*m_9r - Z202*Z480*m_10r - Z210*Z489*m_9r - Z221*Z500*m_10r - Z230*Z511*m_10r;
G_7r = Z3042*g;
 
% G_8r = (Z209*Z3023 - Z3020 - Z209*Z3027 + Z217*Z3024 + Z228*Z3025 + Z237*Z3026 - Z221*Z501*m_10r - Z230*Z512*m_10r)*g
Z3043 = Z209*Z3023 - Z3020 - Z209*Z3027 + Z217*Z3024 + Z228*Z3025 + Z237*Z3026 - Z221*Z501*m_10r - Z230*Z512*m_10r;
G_8r = Z3043*g;
 
% G_9r = (Z229*Z3025 - Z3022 + Z238*Z3026 - Z221*Z502*m_10r - Z230*Z513*m_10r)*g
Z3044 = Z229*Z3025 - Z3022 + Z238*Z3026 - Z221*Z502*m_10r - Z230*Z513*m_10r;
G_9r = Z3044*g;
 
% G_10r = (-Z3027)*g
G_10r = (-Z3027)*g;