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

%%

% this = '6l'; prev = '5l'; aLast = a5l; alphaLast = alpha5l; wLast = w5li;
% a6l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l])
syms Z570 Z571 Z572 real
a6l = [Z296*ddx+Z297*ddpsi+Z298*ddq_imu+Z299*ddq_w+Z300*ddq_torso+Z301*ddq_1l+Z302*ddq_2l+Z570; 
    (-Z284)*ddx + (-Z285)*ddpsi + (-Z286)*ddq_imu + (-Z287)*ddq_w + (-Z288)*ddq_torso+Z571;
    Z303*ddx+Z304*ddpsi+Z305*ddq_imu+Z306*ddq_w+Z307*ddq_torso+Z308*ddq_1l+Z309*ddq_2l+Z572];

% this = '7l'; prev = '6l'; aLast = a6l; alphaLast = alpha6l; wLast = w6li;
% a7l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l])
syms Z573 Z574 real
a7l = [(-Z296)*ddx + (-Z297)*ddpsi + (-Z298)*ddq_imu + (-Z299)*ddq_w + (-Z300)*ddq_torso + (-Z301)*ddq_1l + (-Z302)*ddq_2l- Z570;
    Z312*ddx+Z313*ddpsi+Z314*ddq_imu+Z315*ddq_w+Z316*ddq_torso+Z317*ddq_1l+Z318*ddq_2l+Z573; 
    Z319*ddx+Z320*ddpsi+Z321*ddq_imu+Z322*ddq_w+Z323*ddq_torso+Z324*ddq_1l+Z325*ddq_2l+Z574];

% this = '8l'; prev = '7l'; aLast = a7l; alphaLast = alpha7l; wLast = w7li;
% a8l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l])
syms Z575 Z576 Z577 real
a8l = [Z328*ddx+Z329*ddpsi+Z330*ddq_imu+Z331*ddq_w+Z332*ddq_torso+Z333*ddq_1l+Z334*ddq_2l+Z335*ddq_3l+Z336*ddq_4l+Z575; 
    (-Z312)*ddx + (-Z313)*ddpsi + (-Z314)*ddq_imu + (-Z315)*ddq_w + (-Z316)*ddq_torso + (-Z317)*ddq_1l + (-Z318)*ddq_2l+Z576;
    Z337*ddx+Z338*ddpsi+Z339*ddq_imu+Z340*ddq_w+Z341*ddq_torso+Z342*ddq_1l+Z343*ddq_2l+Z344*ddq_3l+Z345*ddq_4l+Z577];

% this = '9l'; prev = '8l'; aLast = a8l; alphaLast = alpha8l; wLast = w8li;
% a9l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l])
syms Z578 Z579 real
a9l = [(-Z328)*ddx + (-Z329)*ddpsi + (-Z330)*ddq_imu + (-Z331)*ddq_w + (-Z332)*ddq_torso + (-Z333)*ddq_1l + (-Z334)*ddq_2l + (-Z335)*ddq_3l + (-Z336)*ddq_4l- Z575;
    Z348*ddx+Z349*ddpsi+Z350*ddq_imu+Z351*ddq_w+Z352*ddq_torso+Z353*ddq_1l+Z354*ddq_2l+Z355*ddq_3l+Z356*ddq_4l+Z578; 
    Z357*ddx+Z358*ddpsi+Z359*ddq_imu+Z360*ddq_w+Z361*ddq_torso+Z362*ddq_1l+Z363*ddq_2l+Z364*ddq_3l+Z365*ddq_4l+Z579];

% this = '10l'; prev = '9l'; aLast = a9l; alphaLast = alpha9l; wLast = w9li;
% a10l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l])
syms Z580 Z581 Z582 real
a10l = [Z368*ddx+Z369*ddpsi+Z370*ddq_imu+Z371*ddq_w+Z372*ddq_torso+Z373*ddq_1l+Z374*ddq_2l+Z375*ddq_3l+Z376*ddq_4l+Z377*ddq_5l+Z378*ddq_6l+Z580; 
    Z379*ddx+Z380*ddpsi+Z381*ddq_imu+Z382*ddq_w+Z383*ddq_torso+Z384*ddq_1l+Z385*ddq_2l+Z386*ddq_3l+Z387*ddq_4l+Z388*ddq_5l+Z389*ddq_6l+Z581; 
    (-Z348)*ddx + (-Z349)*ddpsi + (-Z350)*ddq_imu + (-Z351)*ddq_w + (-Z352)*ddq_torso + (-Z353)*ddq_1l + (-Z354)*ddq_2l + (-Z355)*ddq_3l + (-Z356)*ddq_4l+Z582];
