% w6li = Rot(f, '6l', '7l') * w6li + f('7l').e*f('7l').dq
% w6li =
%  
%  Z32*sin(q_3l) - Z30*cos(q_3l)
%                  - Z31 - dq_3l
%  Z32*cos(q_3l) + Z30*sin(q_3l)
%  
%  
% w6le =
%  
%     (Z24*cos(q_3l) + Z37*sin(q_3l))*dpsi + (Z25*cos(q_3l) + Z38*sin(q_3l))*dq_imu + (Z25*cos(q_3l) + Z38*sin(q_3l))*dq_w + (Z26*cos(q_3l) + Z39*sin(q_3l))*dq_torso + (Z40*sin(q_3l))*dq_1l + cos(q_3l)*dq_2l
%                                                                                                                            (-Z33)*dpsi + (-Z34)*dq_imu + (-Z34)*dq_w + (-Z35)*dq_torso + (-Z36)*dq_1l - dq_3l
%  (Z37*cos(q_3l) - Z24*sin(q_3l))*dpsi + (Z38*cos(q_3l) - Z25*sin(q_3l))*dq_imu + (Z38*cos(q_3l) - Z25*sin(q_3l))*dq_w + (Z39*cos(q_3l) - Z26*sin(q_3l))*dq_torso + (Z40*cos(q_3l))*dq_1l + (-sin(q_3l))*dq_2l

Z41 = Z32*sin(q_3l) - Z30*cos(q_3l);
Z42 =                 - Z31 - dq_3l;
Z43 = Z32*cos(q_3l) + Z30*sin(q_3l);
Z44 = (Z24*cos(q_3l) + Z37*sin(q_3l));
Z45 = + (Z25*cos(q_3l) + Z38*sin(q_3l));
Z46 = + (Z26*cos(q_3l) + Z39*sin(q_3l));
Z47 = + (Z40*sin(q_3l)); 
Z48 = + cos(q_3l);
Z49 = (Z37*cos(q_3l) - Z24*sin(q_3l)); 
Z50 = + (Z38*cos(q_3l) - Z25*sin(q_3l));
Z51 = + (Z39*cos(q_3l) - Z26*sin(q_3l));
Z52 = + (Z40*cos(q_3l)); 
Z53 = + (-sin(q_3l));
 
w6li = [Z41;Z42;Z43]; 
w6le = [Z44*dpsi+Z45*dq_imu+Z45*dq_w+Z46*dq_torso+Z47*dq_1l+Z48*dq_2l;
    (-Z33)*dpsi + (-Z34)*dq_imu + (-Z34)*dq_w + (-Z35)*dq_torso + (-Z36)*dq_1l - dq_3l;
    Z49*dpsi+Z50*dq_imu+Z50*dq_w+Z51*dq_torso+Z52*dq_1l+Z53*dq_2l;]; 
dw6l = [[0 0 0]' [Z44 -Z33 Z49]' [Z45 -Z34 Z50]' [Z45 -Z34 Z50]' ...
    [Z46 -Z35 Z51]' [Z47 -Z36 Z52]' [Z48 0 Z53]' [0 -1 0]' zeros(3,11)];

% w7l = Rot(f, '6l', '7l') * w6l + f('7l').e*f('7l').dq
% w7li =
%  
%                    - Z41 - dq_4l
%  - Z42*cos(q_4l) - Z43*sin(q_4l)
%    Z43*cos(q_4l) - Z42*sin(q_4l)
%  
%  
% w7le =
%  
%                                                                                                                                                   (-Z44)*dpsi + (-Z45)*dq_imu + (-Z45)*dq_w + (-Z46)*dq_torso + (-Z47)*dq_1l + (-Z48)*dq_2l - dq_4l
%  (Z33*cos(q_4l) - Z49*sin(q_4l))*dpsi + (Z34*cos(q_4l) - Z50*sin(q_4l))*dq_imu + (Z34*cos(q_4l) - Z50*sin(q_4l))*dq_w + (Z35*cos(q_4l) - Z51*sin(q_4l))*dq_torso + (Z36*cos(q_4l) - Z52*sin(q_4l))*dq_1l + (-Z53*sin(q_4l))*dq_2l + cos(q_4l)*dq_3l
%   (Z49*cos(q_4l) + Z33*sin(q_4l))*dpsi + (Z50*cos(q_4l) + Z34*sin(q_4l))*dq_imu + (Z50*cos(q_4l) + Z34*sin(q_4l))*dq_w + (Z51*cos(q_4l) + Z35*sin(q_4l))*dq_torso + (Z52*cos(q_4l) + Z36*sin(q_4l))*dq_1l + (Z53*cos(q_4l))*dq_2l + sin(q_4l)*dq_3l

Z54 =                   - Z41 - dq_4l;
Z55 = - Z42*cos(q_4l) - Z43*sin(q_4l);
Z56 =   Z43*cos(q_4l) - Z42*sin(q_4l);
Z57 = (Z33*cos(q_4l) - Z49*sin(q_4l)); 
Z58 = + (Z34*cos(q_4l) - Z50*sin(q_4l));
Z59 = + (Z35*cos(q_4l) - Z51*sin(q_4l));
Z60 = + (Z36*cos(q_4l) - Z52*sin(q_4l));
Z61 = + (-Z53*sin(q_4l)); 
Z62 = + cos(q_4l);
Z63 = (Z49*cos(q_4l) + Z33*sin(q_4l));
Z64 = + (Z50*cos(q_4l) + Z34*sin(q_4l));
Z65 = + (Z51*cos(q_4l) + Z35*sin(q_4l));
Z66 = + (Z52*cos(q_4l) + Z36*sin(q_4l));
Z67 = + (Z53*cos(q_4l)); 
Z68 = + sin(q_4l);

w7li = [Z54; Z55; Z56];
w7le = [(-Z44)*dpsi + (-Z45)*dq_imu + (-Z45)*dq_w + (-Z46)*dq_torso + (-Z47)*dq_1l + (-Z48)*dq_2l - dq_4l;
    Z57*dpsi+Z58*dq_imu+Z58*dq_w+Z59*dq_torso+Z60*dq_1l+Z61*dq_2l+Z62*dq_3l;
    Z63*dpsi+Z64*dq_imu+Z64*dq_w+Z65*dq_torso+Z66*dq_1l+Z67*dq_2l+Z68*dq_3l];
dw7l = [[0 0 0]' [-Z44 Z57 Z63]' [-Z45 Z58 Z64]' [-Z45 Z58 Z64]' ...
    [-Z46 Z59 Z65]' [-Z47 Z60 Z66]' [-Z48 Z61 Z67]' [0 Z62 Z68]' ...
    [-1 0 0]' zeros(3,10)];

% w8li = Rot(f, '7l', '8l') * w7li + f('8l').e*f('8l').dq
% w8le = collect(Rot(f, '7l', '8l') * w7le + f('8l').e*f('8l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l])
% w8li =
%  
%  Z56*sin(q_5l) - Z54*cos(q_5l)
%                  - Z55 - dq_5l
%  Z56*cos(q_5l) + Z54*sin(q_5l)
%  
%  
% w8le =
%  
%     (Z44*cos(q_5l) + Z63*sin(q_5l))*dpsi + (Z45*cos(q_5l) + Z64*sin(q_5l))*dq_imu + (Z45*cos(q_5l) + Z64*sin(q_5l))*dq_w + (Z46*cos(q_5l) + Z65*sin(q_5l))*dq_torso + (Z47*cos(q_5l) + Z66*sin(q_5l))*dq_1l + (Z48*cos(q_5l) + Z67*sin(q_5l))*dq_2l + (Z68*sin(q_5l))*dq_3l + cos(q_5l)*dq_4l
%                                                                                                                                                                             (-Z57)*dpsi + (-Z58)*dq_imu + (-Z58)*dq_w + (-Z59)*dq_torso + (-Z60)*dq_1l + (-Z61)*dq_2l + (-Z62)*dq_3l - dq_5l
%  (Z63*cos(q_5l) - Z44*sin(q_5l))*dpsi + (Z64*cos(q_5l) - Z45*sin(q_5l))*dq_imu + (Z64*cos(q_5l) - Z45*sin(q_5l))*dq_w + (Z65*cos(q_5l) - Z46*sin(q_5l))*dq_torso + (Z66*cos(q_5l) - Z47*sin(q_5l))*dq_1l + (Z67*cos(q_5l) - Z48*sin(q_5l))*dq_2l + (Z68*cos(q_5l))*dq_3l + (-sin(q_5l))*dq_4l

Z69 =  Z56*sin(q_5l) - Z54*cos(q_5l);
Z70 =                 - Z55 - dq_5l;
Z71 = Z56*cos(q_5l) + Z54*sin(q_5l);
Z72 = (Z44*cos(q_5l) + Z63*sin(q_5l));
Z73 = + (Z45*cos(q_5l) + Z64*sin(q_5l));
Z74 = + (Z46*cos(q_5l) + Z65*sin(q_5l));
Z75 = + (Z47*cos(q_5l) + Z66*sin(q_5l));
Z76 = + (Z48*cos(q_5l) + Z67*sin(q_5l));
Z77 = + (Z68*sin(q_5l));
Z78 = + cos(q_5l);
Z79 = (Z63*cos(q_5l) - Z44*sin(q_5l));
Z80 = + (Z64*cos(q_5l) - Z45*sin(q_5l));
Z81 = + (Z65*cos(q_5l) - Z46*sin(q_5l));
Z82 = + (Z66*cos(q_5l) - Z47*sin(q_5l));
Z83 = + (Z67*cos(q_5l) - Z48*sin(q_5l));
Z84 = + (Z68*cos(q_5l));
Z85 = + (-sin(q_5l));

w8li = [Z69; Z70; Z71];
w8le = [Z72*dpsi+Z73*dq_imu+Z73*dq_w+Z74*dq_torso+Z75*dq_1l+Z76*dq_2l+Z77*dq_3l+Z78*dq_4l;
    (-Z57)*dpsi + (-Z58)*dq_imu + (-Z58)*dq_w + (-Z59)*dq_torso + (-Z60)*dq_1l + (-Z61)*dq_2l + (-Z62)*dq_3l - dq_5l;
    Z79*dpsi+Z80*dq_imu+Z80*dq_w+Z81*dq_torso+Z82*dq_1l+Z83*dq_2l+Z84*dq_3l+Z85*dq_4l];
dw8l = [[0 0 0]' [Z72 -Z57 Z79]' [Z73 -Z58 Z80]' [Z73 -Z58 Z80]' ...
    [Z74 -Z59 Z81]' [Z75 -Z60 Z82]' [Z76 -Z61 Z83]' [Z77 -Z62 Z84]' ...
    [Z78 0 Z85]' [0 -1 0]' zeros(3,9)];

% w9li = Rot(f, '8l', '9l') * w8li + f('9l').e*f('9l').dq
% w9le = collect(Rot(f, '8l', '9l') * w8le + f('9l').e*f('9l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l])
% w9li =
%  
%                    - Z69 - dq_6l
%  - Z70*cos(q_6l) - Z71*sin(q_6l)
%    Z71*cos(q_6l) - Z70*sin(q_6l)
%  
%  
% w9le =
%  
%                                                                                                                                                                                                     (-Z72)*dpsi + (-Z73)*dq_imu + (-Z73)*dq_w + (-Z74)*dq_torso + (-Z75)*dq_1l + (-Z76)*dq_2l + (-Z77)*dq_3l + (-Z78)*dq_4l - dq_6l
%  (Z57*cos(q_6l) - Z79*sin(q_6l))*dpsi + (Z58*cos(q_6l) - Z80*sin(q_6l))*dq_imu + (Z58*cos(q_6l) - Z80*sin(q_6l))*dq_w + (Z59*cos(q_6l) - Z81*sin(q_6l))*dq_torso + (Z60*cos(q_6l) - Z82*sin(q_6l))*dq_1l + (Z61*cos(q_6l) - Z83*sin(q_6l))*dq_2l + (Z62*cos(q_6l) - Z84*sin(q_6l))*dq_3l + (-Z85*sin(q_6l))*dq_4l + cos(q_6l)*dq_5l
%   (Z79*cos(q_6l) + Z57*sin(q_6l))*dpsi + (Z80*cos(q_6l) + Z58*sin(q_6l))*dq_imu + (Z80*cos(q_6l) + Z58*sin(q_6l))*dq_w + (Z81*cos(q_6l) + Z59*sin(q_6l))*dq_torso + (Z82*cos(q_6l) + Z60*sin(q_6l))*dq_1l + (Z83*cos(q_6l) + Z61*sin(q_6l))*dq_2l + (Z84*cos(q_6l) + Z62*sin(q_6l))*dq_3l + (Z85*cos(q_6l))*dq_4l + sin(q_6l)*dq_5l
  
Z86 =                   - Z69 - dq_6l;
Z87 = - Z70*cos(q_6l) - Z71*sin(q_6l);
Z88 =   Z71*cos(q_6l) - Z70*sin(q_6l);
Z89 = (Z57*cos(q_6l) - Z79*sin(q_6l));
Z90 = + (Z58*cos(q_6l) - Z80*sin(q_6l));
Z91 = + (Z59*cos(q_6l) - Z81*sin(q_6l));
Z92 = + (Z60*cos(q_6l) - Z82*sin(q_6l));
Z93 = + (Z61*cos(q_6l) - Z83*sin(q_6l)):
Z94 = + (Z62*cos(q_6l) - Z84*sin(q_6l));
Z95 = + (-Z85*sin(q_6l)); 
Z96 = + cos(q_6l);
Z97 = (Z79*cos(q_6l) + Z57*sin(q_6l));
Z98 = + (Z80*cos(q_6l) + Z58*sin(q_6l));
Z99 = + (Z81*cos(q_6l) + Z59*sin(q_6l));
Z100 = + (Z82*cos(q_6l) + Z60*sin(q_6l));
Z101 = + (Z83*cos(q_6l) + Z61*sin(q_6l));
Z102 = + (Z84*cos(q_6l) + Z62*sin(q_6l)):
Z103 = + (Z85*cos(q_6l));
Z104 = + sin(q_6l);

w9li = [Z86; Z87; Z88];
w9le = [(-Z72)*dpsi + (-Z73)*dq_imu + (-Z73)*dq_w + (-Z74)*dq_torso + (-Z75)*dq_1l + (-Z76)*dq_2l + (-Z77)*dq_3l + (-Z78)*dq_4l - dq_6l;
    Z89*dpsi+Z90*dq_imu+Z90*dq_w+Z91*dq_torso+Z92*dq_1l+Z93*dq_2l+Z94*dq_3l+Z95*dq_4l+Z96*dq_5l;
    Z97*dpsi+Z98*dq_imu+Z98*dq_w+Z99*dq_torso+Z100*dq_1l+Z101*dq_2l+Z102*dq_3l+Z103*dq_4l+Z104*dq_5l];
dw9l = [[0 0 0]' [-Z72 Z89 Z97]' [-Z73 Z90 Z98]' [-Z73 Z90 Z98]' ...
    [-Z74 Z91 Z99]' [-Z75 Z92 Z100]' [-Z76 Z93 Z101]' [-Z77 Z94 Z102]' ...
    [-Z78 Z95 Z103]' [0 Z96 Z104]' [-1 0 0]' zeros(3,18)];


% w10li = Rot(f, '9l', '10l') * w9li + f('10l').e*f('10l').dq
% w10le = collect(Rot(f, '9l', '10l') * w9le + f('10l').e*f('10l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l,dq_7l])
% w10li =
%  
%    Z88*sin(q_7l) - Z86*cos(q_7l)
%  - Z88*cos(q_7l) - Z86*sin(q_7l)
%                    - Z87 - dq_7l
%  
%  
% w10le =
%  
%   (Z72*cos(q_7l) + Z97*sin(q_7l))*dpsi + (Z73*cos(q_7l) + Z98*sin(q_7l))*dq_imu + (Z73*cos(q_7l) + Z98*sin(q_7l))*dq_w + (Z74*cos(q_7l) + Z99*sin(q_7l))*dq_torso + (Z75*cos(q_7l) + Z100*sin(q_7l))*dq_1l + (Z76*cos(q_7l) + Z101*sin(q_7l))*dq_2l + (Z77*cos(q_7l) + Z102*sin(q_7l))*dq_3l + (Z78*cos(q_7l) + Z103*sin(q_7l))*dq_4l + (Z104*sin(q_7l))*dq_5l + cos(q_7l)*dq_6l
%  (Z72*sin(q_7l) - Z97*cos(q_7l))*dpsi + (Z73*sin(q_7l) - Z98*cos(q_7l))*dq_imu + (Z73*sin(q_7l) - Z98*cos(q_7l))*dq_w + (Z74*sin(q_7l) - Z99*cos(q_7l))*dq_torso + (Z75*sin(q_7l) - Z100*cos(q_7l))*dq_1l + (Z76*sin(q_7l) - Z101*cos(q_7l))*dq_2l + (Z77*sin(q_7l) - Z102*cos(q_7l))*dq_3l + (Z78*sin(q_7l) - Z103*cos(q_7l))*dq_4l + (-Z104*cos(q_7l))*dq_5l + sin(q_7l)*dq_6l
%                                                                                                                                                                                                                                   (-Z89)*dpsi + (-Z90)*dq_imu + (-Z90)*dq_w + (-Z91)*dq_torso + (-Z92)*dq_1l + (-Z93)*dq_2l + (-Z94)*dq_3l + (-Z95)*dq_4l + (-Z96)*dq_5l - dq_7l

Z105 = Z88*sin(q_7l) - Z86*cos(q_7l);
Z106 = - Z88*cos(q_7l) - Z86*sin(q_7l);
Z107 =                   - Z87 - dq_7l;
Z108 = (Z72*cos(q_7l) + Z97*sin(q_7l));
Z109 = + (Z73*cos(q_7l) + Z98*sin(q_7l));
Z110 = + (Z74*cos(q_7l) + Z99*sin(q_7l)):
Z111 = + (Z75*cos(q_7l) + Z100*sin(q_7l));
Z112 = + (Z76*cos(q_7l) + Z101*sin(q_7l)):
Z113 = + (Z77*cos(q_7l) + Z102*sin(q_7l));
Z114 = + (Z78*cos(q_7l) + Z103*sin(q_7l));
Z115 = + (Z104*sin(q_7l));
Z116 = + cos(q_7l);
Z117 = (Z72*sin(q_7l) - Z97*cos(q_7l));
Z118 = + (Z73*sin(q_7l) - Z98*cos(q_7l));
Z119 = + (Z74*sin(q_7l) - Z99*cos(q_7l));
Z120 = + (Z75*sin(q_7l) - Z100*cos(q_7l));
Z121 = + (Z76*sin(q_7l) - Z101*cos(q_7l));
Z122 = + (Z77*sin(q_7l) - Z102*cos(q_7l));
Z123 = + (Z78*sin(q_7l) - Z103*cos(q_7l));
Z124 = + (-Z104*cos(q_7l));
Z125 = + sin(q_7l);

w10li = [Z105; Z106; Z107];
w10le = [(-Z89)*dpsi + (-Z90)*dq_imu + (-Z90)*dq_w + (-Z91)*dq_torso + (-Z92)*dq_1l + (-Z93)*dq_2l + (-Z94)*dq_3l + (-Z95)*dq_4l + (-Z96)*dq_5l - dq_7l;
    Z108*dpsi+Z109*dq_imu+Z109*dq_w+Z110*dq_torso+Z111*dq_1l+Z112*dq_2l+Z113*dq_3l+Z114*dq_4l+Z115*dq_5l+Z116*dq_6l;
    Z117*dpsi+Z118*dq_imu+Z118*dq_w+Z119*dq_torso+Z120*dq_1l+Z121*dq_2l+Z122*dq_3l+Z123*dq_4l+Z124*dq_5l+Z125*dq_6l];
dw10l = [[0 0 0]' [-Z89 Z108 Z117]' [-Z90 Z109 Z118]' [-Z90 Z109 Z118]' ...
    [-Z91 Z110 Z119]' [-Z92 Z111 Z120]' [-Z93 Z112 Z121]' [-Z94 Z113 Z122]' ...
    [-Z95 Z114 Z123]' [-Z96 Z115 Z124]' [0 Z116 Z125]' [-1 0 0]' zeros(3,7)];


%%
% w5li = Rot(f, '4l', '5l') * w4li + f('5l').e*f('5l').dq
% w5le = collect(Rot(f, '4l', '5l') * w4le + f('5l').e*f('5l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l])
syms dq_2l Z30 Z31 Z32 Z33 Z34 Z35 Z36 Z37 Z38 Z39 Z40 real
w5li = [Z30; Z31; Z32];
w5le = [(-Z24)*dpsi+(-Z25)*dq_imu+(-Z25)*dq_w+(-Z26)*dq_torso-dq_2l;
    Z33*dpsi+Z34*dq_imu+Z34*dq_w+Z35*dq_torso+Z36*dq_1l;
    Z37*dpsi+Z38*dq_imu+Z38*dq_w+Z39*dq_torso+Z40*dq_1l];    

% w6li = Rot(f, '5l', '6l') * w5li + f('6l').e*f('6l').dq
% w6le = collect(Rot(f, '5l', '6l') * w5le + f('6l').e*f('6l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l])
syms dq_3l Z41 Z42 Z43 Z44 Z45 Z46 Z47 Z48 Z49 Z50 Z51 Z52 Z53 real
w6li = [Z41;Z42;Z43]; 
w6le = [Z44*dpsi+Z45*dq_imu+Z45*dq_w+Z46*dq_torso+Z47*dq_1l+Z48*dq_2l;
    (-Z33)*dpsi + (-Z34)*dq_imu + (-Z34)*dq_w + (-Z35)*dq_torso + (-Z36)*dq_1l - dq_3l;
    Z49*dpsi+Z50*dq_imu+Z50*dq_w+Z51*dq_torso+Z52*dq_1l+Z53*dq_2l;]; 

% w7li = Rot(f, '6l', '7l') * w6li + f('7l').e*f('7l').dq
% w7le = collect(Rot(f, '6l', '7l') * w6le + f('7l').e*f('7l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l])
syms dq_4l Z54 Z55 Z56 Z57 Z58 Z59 Z60 Z61 Z62 Z63 Z64 Z65 Z66 Z67 Z68 real
w7li = [Z54; Z55; Z56];
w7le = [(-Z44)*dpsi + (-Z45)*dq_imu + (-Z45)*dq_w + (-Z46)*dq_torso + (-Z47)*dq_1l + (-Z48)*dq_2l - dq_4l;
    Z57*dpsi+Z58*dq_imu+Z58*dq_w+Z59*dq_torso+Z60*dq_1l+Z61*dq_2l+Z62*dq_3l;
    Z63*dpsi+Z64*dq_imu+Z64*dq_w+Z65*dq_torso+Z66*dq_1l+Z67*dq_2l+Z68*dq_3l];

% w8li = Rot(f, '7l', '8l') * w7li + f('8l').e*f('8l').dq
% w8le = collect(Rot(f, '7l', '8l') * w7le + f('8l').e*f('8l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l])
syms dq_5l Z69 Z70 Z71 Z72 Z73 Z74 Z75 Z76 Z77 Z78 Z79 Z80 Z81 Z82 Z83 Z84 Z85 real
w8li = [Z69; Z70; Z71];
w8le = [Z72*dpsi+Z73*dq_imu+Z73*dq_w+Z74*dq_torso+Z75*dq_1l+Z76*dq_2l+Z77*dq_3l+Z78*dq_4l;
    (-Z57)*dpsi + (-Z58)*dq_imu + (-Z58)*dq_w + (-Z59)*dq_torso + (-Z60)*dq_1l + (-Z61)*dq_2l + (-Z62)*dq_3l - dq_5l;
    Z79*dpsi+Z80*dq_imu+Z80*dq_w+Z81*dq_torso+Z82*dq_1l+Z83*dq_2l+Z84*dq_3l+Z85*dq_4l];

% w9li = Rot(f, '8l', '9l') * w8li + f('9l').e*f('9l').dq
% w9le = collect(Rot(f, '8l', '9l') * w8le + f('9l').e*f('9l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l])
syms dq_6l Z86 Z87 Z88 Z89 Z90 Z91 Z92 Z93 Z94 Z95 Z96 Z97 Z98 Z99 Z100 Z101 Z102 Z103 Z104 real
w9li = [Z86; Z87; Z88];
w9le = [(-Z72)*dpsi + (-Z73)*dq_imu + (-Z73)*dq_w + (-Z74)*dq_torso + (-Z75)*dq_1l + (-Z76)*dq_2l + (-Z77)*dq_3l + (-Z78)*dq_4l - dq_6l;
    Z89*dpsi+Z90*dq_imu+Z90*dq_w+Z91*dq_torso+Z92*dq_1l+Z93*dq_2l+Z94*dq_3l+Z95*dq_4l+Z96*dq_5l;
    Z97*dpsi+Z98*dq_imu+Z98*dq_w+Z99*dq_torso+Z100*dq_1l+Z101*dq_2l+Z102*dq_3l+Z103*dq_4l+Z104*dq_5l];

% w10li = Rot(f, '9l', '10l') * w9li + f('10l').e*f('10l').dq
% w10le = collect(Rot(f, '9l', '10l') * w9le + f('10l').e*f('10l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l,dq_7l])
syms dq_7l Z105 Z106 Z107 Z108 Z109 Z110 Z111 Z112 Z113 Z114 Z115 Z116 Z117 Z118 Z119 Z120 Z121 Z122 Z123 Z124 Z125 real
w10li = [Z105; Z106; Z107];
w10le = [(-Z89)*dpsi + (-Z90)*dq_imu + (-Z90)*dq_w + (-Z91)*dq_torso + (-Z92)*dq_1l + (-Z93)*dq_2l + (-Z94)*dq_3l + (-Z95)*dq_4l + (-Z96)*dq_5l - dq_7l;
    Z108*dpsi+Z109*dq_imu+Z109*dq_w+Z110*dq_torso+Z111*dq_1l+Z112*dq_2l+Z113*dq_3l+Z114*dq_4l+Z115*dq_5l+Z116*dq_6l;
    Z117*dpsi+Z118*dq_imu+Z118*dq_w+Z119*dq_torso+Z120*dq_1l+Z121*dq_2l+Z122*dq_3l+Z123*dq_4l+Z124*dq_5l+Z125*dq_6l];
