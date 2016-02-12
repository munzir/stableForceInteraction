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

%%
% this = '6l'; w = w6li; prev = '5l'; alphaLast = alpha5l;
% alpha6l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l])
syms ddq_3l Z528 Z529 real
alpha6l = [Z52*ddpsi+Z53*ddq_imu+Z53*ddq_w+Z54*ddq_torso+Z55*ddq_1l+Z56*ddq_2l+Z528;
    (-Z41)*ddpsi + (-Z42)*ddq_imu + (-Z42)*ddq_w + (-Z43)*ddq_torso + (-Z44)*ddq_1l - ddq_3l - Z526;
    Z57*ddpsi+Z58*ddq_imu+Z58*ddq_w+Z59*ddq_torso+Z60*ddq_1l+Z61*ddq_2l+Z529];   

% this = '7l'; w = w7li; prev = '6l'; alphaLast = alpha6l;
% alpha7l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l])
syms ddq_4l Z530 Z531 real
alpha7l = [ (-Z52)*ddpsi + (-Z53)*ddq_imu + (-Z53)*ddq_w + (-Z54)*ddq_torso + (-Z55)*ddq_1l + (-Z56)*ddq_2l - ddq_4l - Z528;
    Z65*ddpsi+Z66*ddq_imu+Z66*ddq_w+Z67*ddq_torso+Z68*ddq_1l+Z69*ddq_2l+Z70*ddq_3l+Z530;
    Z71*ddpsi+Z72*ddq_imu+Z72*ddq_w+Z73*ddq_torso+Z74*ddq_1l+Z75*ddq_2l+Z76*ddq_3l+Z531];

% this = '8l'; w = w8li; prev = '7l'; alphaLast = alpha7l;
% alpha8l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l])
syms ddq_5l Z532 Z533 real
alpha8l = [Z80*ddpsi+Z81*ddq_imu+Z81*ddq_w+Z82*ddq_torso+Z83*ddq_1l+Z84*ddq_2l+Z85*ddq_3l+Z86*ddq_4l+Z532;
    (-Z65)*ddpsi + (-Z66)*ddq_imu + (-Z66)*ddq_w + (-Z67)*ddq_torso + (-Z68)*ddq_1l + (-Z69)*ddq_2l + (-Z70)*ddq_3l - ddq_5l - Z530;
    Z87*ddpsi+Z88*ddq_imu+Z88*ddq_w+Z89*ddq_torso+Z90*ddq_1l+Z91*ddq_2l+Z92*ddq_3l+Z93*ddq_4l+Z533];

% this = '9l'; w = w9li; prev = '8l'; alphaLast = alpha8l;
% alpha9l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l])
syms ddq_6l Z534 Z535 real
alpha9l = [(-Z80)*ddpsi + (-Z81)*ddq_imu + (-Z81)*ddq_w + (-Z82)*ddq_torso + (-Z83)*ddq_1l + (-Z84)*ddq_2l + (-Z85)*ddq_3l + (-Z86)*ddq_4l - ddq_6l - Z532;
    Z97*ddpsi+Z98*ddq_imu+Z98*ddq_w+Z99*ddq_torso+Z100*ddq_1l+Z101*ddq_2l+Z102*ddq_3l+Z103*ddq_4l+Z104*ddq_5l+Z534;
    Z105*ddpsi+Z106*ddq_imu+Z106*ddq_w+Z107*ddq_torso+Z108*ddq_1l+Z109*ddq_2l+Z110*ddq_3l+Z111*ddq_4l+Z112*ddq_5l+Z535];

% this = '10l'; w = w10li; prev = '9l'; alphaLast = alpha9l;
% alpha10l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l,ddq_7l])
syms ddq_7l Z536 Z537 real
alpha10l = [Z116*ddpsi+Z117*ddq_imu+Z117*ddq_w+Z118*ddq_torso+Z119*ddq_1l+Z120*ddq_2l+Z121*ddq_3l+Z122*ddq_4l+Z123*ddq_5l+Z124*ddq_6l+Z536;
    Z125*ddpsi+Z126*ddq_imu+Z126*ddq_w+Z127*ddq_torso+Z128*ddq_1l+Z129*ddq_2l+Z130*ddq_3l+Z131*ddq_4l+Z132*ddq_5l+Z133*ddq_6l+Z537;
    (-Z97)*ddpsi + (-Z98)*ddq_imu + (-Z98)*ddq_w + (-Z99)*ddq_torso + (-Z100)*ddq_1l + (-Z101)*ddq_2l + (-Z102)*ddq_3l + (-Z103)*ddq_4l + (-Z104)*ddq_5l - ddq_7l - Z534];
