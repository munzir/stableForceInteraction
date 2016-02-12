addpath('/home/munzir/Me/5-Work/stableForceInteraction/Implementation/1-ForceControlWhileBalancing/1-ControlProblem1/1-DynamicModeling/3-DynamicModelOfFullRobot/2-matlab/Kanes')

% Wheels
% dthetaL = dx/R - dpsi*L/(2*R);
% iL = [1 0 0]'; jL = [0 1 0]'; kL = [0 0 1]';
% i0 = [cos(thetaL) 0 sin(thetaL)]'; j0 = [0 1 0]'; k0 = [-sin(thetaL) 0 cos(thetaL)]';
syms dx dpsi Z1 Z2 Z3 Z4 real
dthetaL = Z1*dx - Z2*dpsi;
i0L = [Z4 0 Z3]'; j0L = [0 1 0]'; k0L = [-Z3 0 Z4]';

w0L = dpsi*k0L;
% wL = w0L + dthetaL*j0L;
syms Z5 Z6 Z7 real
wLi = [Z5; Z6; Z7];
wLe = [-Z3*dpsi; Z1*dx-Z2*dpsi;Z4*dpsi];
dwL = [[0 Z1 0]' [-Z3 -Z2 Z4]' zeros(3,17)];

% dthetaR = dx/R + dpsi*L/(2*R);
% iR = [1 0 0]'; jR = [0 1 0]'; kR = [0 0 1]';
% i0 = [cos(thetaR) 0 sin(thetaR)]'; j0 = [0 1 0]'; k0 = [-sin(thetaR) 0 cos(thetaR)]';
syms Z8 Z9 real
dthetaR = Z1*dx+Z2*dpsi;
i0R = [Z9 0 Z8]'; j0R = [0 1 0]'; k0R = [-Z8 0 Z9]';

w0R = dpsi*k0R;
% wR = w0R + dthetaR*j0R
syms Z10 Z11 Z12 real
wRi = [Z10; Z11; Z12];
wRe = [-Z8*dpsi; Z2*dpsi + Z1*dx;  Z9*dpsi];
dwR = [[0 Z1 0]' [-Z8 Z2 Z9]' zeros(3,17)];

w0 = [0; 0; dpsi]; 
% w1 = Rot(f, '0', '1') * w0 + f('1').e*f('1').dq;
syms dq_imu Z13 Z14 Z15 Z16 real
w1i = [-dq_imu; Z15; Z16]; % implicit
w1e = [-dq_imu; Z13*dpsi; Z14*dpsi]; % explicit
dw1 = [[0 0 0]' [0 Z13 Z14]' [-1 0 0]' zeros(3,16)]; % partial derivatives

% w2i = Rot(f, '1', '2') * w1i + f('2').e*f('2').dq
% w2e = Rot(f, '1', '2') * w1e + f('2').e*f('2').dq
syms dq_w Z17 Z18 Z19 Z20 Z21 real
w2i = [Z17; Z18; Z19];
w2e = [-dq_w-dq_imu; Z20*dpsi; Z21*dpsi];
dw2 = [[0 0 0]' [0 Z20 Z21]' [-1 0 0]' [-1 0 0]' zeros(3,15)];

% w3i = Rot(f, '2', '3') * w2i + f('3').e*f('3').dq
% w3e = Rot(f, '2', '3') * w2e + f('3').e*f('3').dq
syms dq_torso Z22 Z23 Z24 Z25 Z26 Z27 Z28 real
w3i = [Z22; Z23; Z24];
w3e = [Z25*(dq_w + dq_imu)+Z26*dpsi; Z20*dpsi-dq_torso; Z27*(dq_w+dq_imu)+Z28*dpsi];
dw3 = [[0 0 0]' [Z26 Z20 Z28]' [Z25 0 Z27]' [Z25 0 Z27]' [0 -1 0]' ...
    zeros(3,14)];

% w4li = Rot(f, '3', '4l') * w3i + f('4l').e*f('4l').dq
% w4le = Rot(f, '3', '4l') * w3e + f('4l').e*f('4l').dq
syms dq_1l Z29 Z30 Z31 Z32 Z33 Z34 Z35 Z36 Z37 real
w4li = [Z29; Z30; Z31];
w4le = [Z32*dpsi+Z33*dq_imu+Z33*dq_w+Z34*dq_torso;  
        Z26*dpsi+Z25*dq_imu+Z25*dq_w-dq_1l; 
        Z35*dpsi+Z36*dq_imu+Z36*dq_w+Z37*dq_torso];
dw4l = [[0 0 0]' [Z32 Z26 Z35]' [Z33 Z25 Z36]' [Z33 Z25 Z36]' ...
    [Z34 0 Z37]' [0 -1 0]' zeros(3,13)];

% w5li = Rot(f, '4l', '5l') * w4li + f('5l').e*f('5l').dq
% w5le = collect(Rot(f, '4l', '5l') * w4le + f('5l').e*f('5l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l])
syms dq_2l Z38 Z39 Z40 Z41 Z42 Z43 Z44 Z45 Z46 Z47 Z48 real
w5li = [Z38; Z39; Z40];
w5le = [(-Z32)*dpsi+(-Z33)*dq_imu+(-Z33)*dq_w+(-Z34)*dq_torso-dq_2l;
    Z41*dpsi+Z42*dq_imu+Z42*dq_w+Z43*dq_torso+Z44*dq_1l;
    Z45*dpsi+Z46*dq_imu+Z46*dq_w+Z47*dq_torso+Z48*dq_1l];    
dw5l = [[0 0 0]' [-Z32 Z41 Z45]' [-Z33 Z42 Z46]' [-Z33 Z42 Z46]' ...
    [-Z34 Z43 Z47]' [0 Z44 Z48]' [-1 0 0]' zeros(3,12)];

% w6li = Rot(f, '5l', '6l') * w5li + f('6l').e*f('6l').dq
% w6le = collect(Rot(f, '5l', '6l') * w5le + f('6l').e*f('6l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l])
syms dq_3l Z49 Z50 Z51 Z52 Z53 Z54 Z55 Z56 Z57 Z58 Z59 Z60 Z61 real
w6li = [Z49;Z50;Z51]; 
w6le = [Z52*dpsi+Z53*dq_imu+Z53*dq_w+Z54*dq_torso+Z55*dq_1l+Z56*dq_2l;
    (-Z41)*dpsi + (-Z42)*dq_imu + (-Z42)*dq_w + (-Z43)*dq_torso + (-Z44)*dq_1l - dq_3l;
    Z57*dpsi+Z58*dq_imu+Z58*dq_w+Z59*dq_torso+Z60*dq_1l+Z61*dq_2l;]; 
dw6l = [[0 0 0]' [Z52 -Z41 Z57]' [Z53 -Z42 Z58]' [Z53 -Z42 Z58]' ...
    [Z54 -Z43 Z59]' [Z55 -Z44 Z60]' [Z56 0 Z61]' [0 -1 0]' zeros(3,11)];

% w7li = Rot(f, '6l', '7l') * w6li + f('7l').e*f('7l').dq
% w7le = collect(Rot(f, '6l', '7l') * w6le + f('7l').e*f('7l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l])
syms dq_4l Z62 Z63 Z64 Z65 Z66 Z67 Z68 Z69 Z70 Z71 Z72 Z73 Z74 Z75 Z76 real
w7li = [Z62; Z63; Z64];
w7le = [(-Z52)*dpsi + (-Z53)*dq_imu + (-Z53)*dq_w + (-Z54)*dq_torso + (-Z55)*dq_1l + (-Z56)*dq_2l - dq_4l;
    Z65*dpsi+Z66*dq_imu+Z66*dq_w+Z67*dq_torso+Z68*dq_1l+Z69*dq_2l+Z70*dq_3l;
    Z71*dpsi+Z72*dq_imu+Z72*dq_w+Z73*dq_torso+Z74*dq_1l+Z75*dq_2l+Z76*dq_3l];
dw7l = [[0 0 0]' [-Z52 Z65 Z71]' [-Z53 Z66 Z72]' [-Z53 Z66 Z72]' ...
    [-Z54 Z67 Z73]' [-Z55 Z68 Z74]' [-Z56 Z69 Z75]' [0 Z70 Z76]' ...
    [-1 0 0]' zeros(3,10)];

% w8li = Rot(f, '7l', '8l') * w7li + f('8l').e*f('8l').dq
% w8le = collect(Rot(f, '7l', '8l') * w7le + f('8l').e*f('8l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l])
syms dq_5l Z77 Z78 Z79 Z80 Z81 Z82 Z83 Z84 Z85 Z86 Z87 Z88 Z89 Z90 Z91 Z92 Z93 real
w8li = [Z77; Z78; Z79];
w8le = [Z80*dpsi+Z81*dq_imu+Z81*dq_w+Z82*dq_torso+Z83*dq_1l+Z84*dq_2l+Z85*dq_3l+Z86*dq_4l;
    (-Z65)*dpsi + (-Z66)*dq_imu + (-Z66)*dq_w + (-Z67)*dq_torso + (-Z68)*dq_1l + (-Z69)*dq_2l + (-Z70)*dq_3l - dq_5l;
    Z87*dpsi+Z88*dq_imu+Z88*dq_w+Z89*dq_torso+Z90*dq_1l+Z91*dq_2l+Z92*dq_3l+Z93*dq_4l];
dw8l = [[0 0 0]' [Z80 -Z65 Z87]' [Z81 -Z66 Z88]' [Z81 -Z66 Z88]' ...
    [Z82 -Z67 Z89]' [Z83 -Z68 Z90]' [Z84 -Z69 Z91]' [Z85 -Z70 Z92]' ...
    [Z86 0 Z93]' [0 -1 0]' zeros(3,9)];

% w9li = Rot(f, '8l', '9l') * w8li + f('9l').e*f('9l').dq
% w9le = collect(Rot(f, '8l', '9l') * w8le + f('9l').e*f('9l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l])
syms dq_6l Z94 Z95 Z96 Z97 Z98 Z99 Z100 Z101 Z102 Z103 Z104 Z105 Z106 Z107 Z108 Z109 Z110 Z111 Z112 real
w9li = [Z94; Z95; Z96];
w9le = [(-Z80)*dpsi + (-Z81)*dq_imu + (-Z81)*dq_w + (-Z82)*dq_torso + (-Z83)*dq_1l + (-Z84)*dq_2l + (-Z85)*dq_3l + (-Z86)*dq_4l - dq_6l;
    Z97*dpsi+Z98*dq_imu+Z98*dq_w+Z99*dq_torso+Z100*dq_1l+Z101*dq_2l+Z102*dq_3l+Z103*dq_4l+Z104*dq_5l;
    Z105*dpsi+Z106*dq_imu+Z106*dq_w+Z107*dq_torso+Z108*dq_1l+Z109*dq_2l+Z110*dq_3l+Z111*dq_4l+Z112*dq_5l];
dw9l = [[0 0 0]' [-Z80 Z97 Z105]' [-Z81 Z98 Z106]' [-Z81 Z98 Z106]' ...
    [-Z82 Z99 Z107]' [-Z83 Z100 Z108]' [-Z84 Z101 Z109]' [-Z85 Z102 Z110]' ...
    [-Z86 Z103 Z111]' [0 Z104 Z112]' [-1 0 0]' zeros(3,18)];

syms dq_7l real
% w10li = Rot(f, '9l', '10l') * w9li + f('10l').e*f('10l').dq
% w10le = collect(Rot(f, '9l', '10l') * w9le + f('10l').e*f('10l').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l,dq_7l])
syms dq_7l Z113 Z114 Z115 Z116 Z117 Z118 Z119 Z120 Z121 Z122 Z123 Z124 Z125 Z126 Z127 Z128 Z129 Z130 Z131 Z132 Z133 real
w10li = [Z113; Z114; Z115];
w10le = [(-Z97)*dpsi + (-Z98)*dq_imu + (-Z98)*dq_w + (-Z99)*dq_torso + (-Z100)*dq_1l + (-Z101)*dq_2l + (-Z102)*dq_3l + (-Z103)*dq_4l + (-Z104)*dq_5l - dq_7l;
    Z116*dpsi+Z117*dq_imu+Z117*dq_w+Z118*dq_torso+Z119*dq_1l+Z120*dq_2l+Z121*dq_3l+Z122*dq_4l+Z123*dq_5l+Z124*dq_6l;
    Z125*dpsi+Z126*dq_imu+Z126*dq_w+Z127*dq_torso+Z128*dq_1l+Z129*dq_2l+Z130*dq_3l+Z131*dq_4l+Z132*dq_5l+Z133*dq_6l];
dw10l = [[0 0 0]' [Z116 Z125 -Z97]' [Z117 Z126 -Z98]' [Z117 Z126 -Z98]' ...
    [Z118 Z127 -Z99]' [Z119 Z128 -Z100]' [Z120 Z129 -Z101]' [Z121 Z130 -Z102]' ...
    [Z122 Z131 -Z103]' [Z123 Z132 -Z104]' [Z124 Z133 0]' [0 0 -1]' zeros(3,7)];


% w4ri = Rot(f, '3', '4r') * w3i + f('4r').e*f('4r').dq
% w4re = collect(Rot(f, '3', '4r') * w3e + f('4r').e*f('4r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r])
syms dq_1r Z134 Z135 Z136 Z137 Z138 Z139 Z140 Z141 Z142 real
w4ri = [Z134; Z135; Z136];
w4re = [Z137*dpsi+Z138*dq_imu+Z138*dq_w+Z139*dq_torso;  
        (-Z26)*dpsi + (-Z25)*dq_imu + (-Z25)*dq_w - dq_1r;
        Z140*dpsi+Z141*dq_imu+Z141*dq_w+Z142*dq_torso];
dw4r = [[0 0 0]' [Z137 -Z26 Z140]' [Z138 -Z25 Z141]' [Z138 -Z25 Z141]' ...
    [Z139 0 Z142]' zeros(3,7) [0 -1 0]' zeros(3,6)];
    
% w5ri = Rot(f, '4r', '5r') * w4ri + f('5r').e*f('5r').dq
% w5re = collect(Rot(f, '4r', '5r') * w4re + f('5r').e*f('5r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r])
syms dq_2r Z143 Z144 Z145 Z146 Z147 Z148 Z149 Z150 Z151 Z152 Z153 real
w5ri = [Z143; Z144; Z145];
w5re = [(-Z137)*dpsi+(-Z138)*dq_imu+(-Z138)*dq_w+(-Z139)*dq_torso-dq_2r;
    Z146*dpsi+Z147*dq_imu+Z147*dq_w+Z148*dq_torso+Z149*dq_1r;
    Z150*dpsi+Z151*dq_imu+Z151*dq_w+Z152*dq_torso+Z153*dq_1r];    
dw5r = [[0 0 0]' [-Z137 Z146 Z150]' [-Z138 Z147 Z151]' [-Z138 Z147 Z151]' ...
    [-Z139 Z148 Z152]' zeros(3,7) [0 Z149 Z153]' [-1 0 0]' zeros(3,5)];

% w6ri = Rot(f, '5r', '6r') * w5ri + f('6r').e*f('6r').dq
% w6re = collect(Rot(f, '5r', '6r') * w5re + f('6r').e*f('6r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r])
syms dq_3r Z154 Z155 Z156 Z157 Z158 Z159 Z160 Z161 Z162 Z163 Z164 Z165 Z166 real
w6ri = [Z154;Z155;Z156]; 
w6re = [Z157*dpsi+Z158*dq_imu+Z158*dq_w+Z159*dq_torso+Z160*dq_1r+Z161*dq_2r;
    (-Z146)*dpsi + (-Z147)*dq_imu + (-Z147)*dq_w + (-Z148)*dq_torso + (-Z149)*dq_1r - dq_3r;
    Z162*dpsi+Z163*dq_imu+Z163*dq_w+Z164*dq_torso+Z165*dq_1r+Z166*dq_2r;]; 
dw6r = [[0 0 0]' [Z157 -Z146 Z162]' [Z158 -Z147 Z163]' [Z158 -Z147 Z163]' ...
    [Z159 -Z148 Z164]' zeros(3,7) [Z160 -Z149 Z165]' [Z161 0 Z166]' ... 
    [0 -1 0]' zeros(3,4)];

% w7ri = Rot(f, '6r', '7r') * w6ri + f('7r').e*f('7r').dq
% w7re = collect(Rot(f, '6r', '7r') * w6re + f('7r').e*f('7r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r])
syms dq_4r Z167 Z168 Z169 Z170 Z171 Z172 Z173 Z174 Z175 Z176 Z177 Z178 Z179 Z180 Z181 real
w7ri = [Z167; Z168; Z169];
w7re = [(-Z157)*dpsi + (-Z158)*dq_imu + (-Z158)*dq_w + (-Z159)*dq_torso + (-Z160)*dq_1r + (-Z161)*dq_2r - dq_4r;
    Z170*dpsi+Z171*dq_imu+Z171*dq_w+Z172*dq_torso+Z173*dq_1r+Z174*dq_2r+Z175*dq_3r;
    Z176*dpsi+Z177*dq_imu+Z177*dq_w+Z178*dq_torso+Z179*dq_1r+Z180*dq_2r+Z181*dq_3r];
dw7r = [[0 0 0]' [-Z157 Z170 Z176]' [-Z158 Z171 Z177]' [-Z158 Z171 Z177]' ...
    [-Z159 Z172 Z178]' zeros(3,7) [-Z160 Z173 Z179]' [-Z161 Z174 Z180]' ...
    [0 Z175 Z181]' [-1 0 0]' zeros(3,3)];

% w8ri = Rot(f, '7r', '8r') * w7ri + f('8r').e*f('8r').dq
% w8re = collect(Rot(f, '7r', '8r') * w7re + f('8r').e*f('8r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r])
syms dq_5r Z182 Z183 Z184 Z185 Z186 Z187 Z188 Z189 Z190 Z191 Z192 Z193 Z194 Z195 Z196 Z197 Z198 real
w8ri = [Z182; Z183; Z184];
w8re = [Z185*dpsi+Z186*dq_imu+Z186*dq_w+Z187*dq_torso+Z188*dq_1r+Z189*dq_2r+Z190*dq_3r+Z191*dq_4r;
    (-Z170)*dpsi + (-Z171)*dq_imu + (-Z171)*dq_w + (-Z172)*dq_torso + (-Z173)*dq_1r + (-Z174)*dq_2r + (-Z175)*dq_3r - dq_5r;
    Z192*dpsi+Z193*dq_imu+Z193*dq_w+Z194*dq_torso+Z195*dq_1r+Z196*dq_2r+Z197*dq_3r+Z198*dq_4r];
dw8r = [[0 0 0]' [Z185 -Z170 Z192]' [Z186 -Z171 Z193]' [Z186 -Z171 Z193]' ...
    [Z187 -Z172 Z194]' zeros(3,7) [Z188 -Z173 Z195]' [Z189 -Z174 Z196]' ...
    [Z190 -Z175 Z197]' [Z191 0 Z198]' [0 -1 0]' zeros(3,2)];

% w9ri = Rot(f, '8r', '9r') * w8ri + f('9r').e*f('9r').dq
% w9re = collect(Rot(f, '8r', '9r') * w8re + f('9r').e*f('9r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r])
syms dq_6r Z199 Z200 Z201 Z202 Z203 Z204 Z205 Z206 Z207 Z208 Z209 Z210 Z211 Z212 Z213 Z214 Z215 Z216 Z217 real
w9ri = [Z199; Z200; Z201];
w9re = [(-Z185)*dpsi + (-Z186)*dq_imu + (-Z186)*dq_w + (-Z187)*dq_torso + (-Z188)*dq_1r + (-Z189)*dq_2r + (-Z190)*dq_3r + (-Z191)*dq_4r - dq_6r;
    Z202*dpsi+Z203*dq_imu+Z203*dq_w+Z204*dq_torso+Z205*dq_1r+Z206*dq_2r+Z207*dq_3r+Z208*dq_4r+Z209*dq_5r;
    Z210*dpsi+Z211*dq_imu+Z211*dq_w+Z212*dq_torso+Z213*dq_1r+Z214*dq_2r+Z215*dq_3r+Z216*dq_4r+Z217*dq_5r];
dw9r = [[0 0 0]' [-Z185 Z202 Z210]' [-Z186 Z203 Z211]' [-Z186 Z203 Z211]' ...
    [-Z187 Z204 Z212]' zeros(3,7) [-Z188 Z205 Z213]' [-Z189 Z206 Z214]'...
    [-Z190 Z207 Z215]' [-Z191 Z208 Z216]' [0 Z209 Z217]' [-1 0 0]'...
    zeros(3,1)];

% w10ri = Rot(f, '9r', '10r') * w9ri + f('10r').e*f('10r').dq
% w10re = collect(Rot(f, '9r', '10r') * w9re + f('10r').e*f('10r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r,dq_7r])
syms dq_7r Z218 Z219 Z220 Z221 Z222 Z223 Z224 Z225 Z226 Z227 Z228 Z229 Z230 Z231 Z232 Z233 Z234 Z235 Z236 Z237 Z238 real
w10ri = [Z218; Z219; Z220];
w10re = [(-Z202)*dpsi + (-Z203)*dq_imu + (-Z203)*dq_w + (-Z204)*dq_torso + (-Z205)*dq_1r + (-Z206)*dq_2r + (-Z207)*dq_3r + (-Z208)*dq_4r + (-Z209)*dq_5r - dq_7r;
    Z221*dpsi+Z222*dq_imu+Z222*dq_w+Z223*dq_torso+Z224*dq_1r+Z225*dq_2r+Z226*dq_3r+Z227*dq_4r+Z228*dq_5r+Z229*dq_6r;
    Z230*dpsi+Z231*dq_imu+Z231*dq_w+Z232*dq_torso+Z233*dq_1r+Z234*dq_2r+Z235*dq_3r+Z236*dq_4r+Z237*dq_5r+Z238*dq_6r];
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

syms Z239 Z240 Z241 real

vLi = [Z239; 0; 0];
vLe = [dx-Z241*dpsi; 0; 0];
dvL = [[1 0 0]' [-Z241 0 0]' zeros(3, 17)];

vRi = [Z240; 0; 0];
vRe = [dx+Z241*dpsi; 0; 0];
dvR = [[1 0 0]' [+Z241 0 0]' zeros(3, 17)];

% w0 = [0; 0; dpsi]; 
% v0 = [dx; 0; 0];
% v1 = Rot(f, '0', '1') * (v0 + cross(w0, f('1').P))   
syms dx Z242 Z243 Z244 Z245 real
v1i = [0; Z242; Z243];
v1e = [0; Z244*dx; Z245*dx];
dv1 = [[0 Z244 Z245]' zeros(3,18)];


% v2i = Rot(f, '1', '2') * (v1i + cross(w1i, f('2').P))
% v2e = collect(Rot(f, '1', '2') * (v1e + cross(w1e, f('2').P)),[dx,dpsi,dq_imu])
syms Z246 Z247 Z248 Z249 Z250 Z251 Z252 Z253 real
v2i = [Z246; Z247; Z248];
v2e = [Z249*dpsi; Z250*dx+Z251*dq_imu; Z252*dx+Z253*dq_imu];
dv2 = [[0 Z250 Z252]' [Z249 0 0]' [0 Z251 Z253]' zeros(3,16)];

% v3i = Rot(f, '2', '3') * (v2i + cross(w2i, f('3').P))
% v3e = collect(Rot(f, '2', '3') * (v2e + cross(w2e, f('3').P)),[dx,dpsi,dq_imu,dq_w])
syms Z254 Z255 Z256 Z257 Z258 Z259 Z260 Z261 Z262 Z263 Z264 Z265 L4 real
v3i = [Z254; Z255; Z256];
v3e = [Z257*dx+Z258*dpsi+Z259*dq_imu+Z260*dq_w; 
    Z250*dx+Z261*dq_imu+L4*dq_w; 
    Z262*dx+Z263*dpsi+Z264*dq_imu+Z265*dq_w];
dv3 = [[Z257 Z250 Z262]' [Z258 Z61 Z63]' [Z259 0 Z264]' [Z260 L4 Z265]' ...
    zeros(3,15)];

% v4li = Rot(f, '3', '4l') * (v3i + cross(w3i, f('4l').P))
% v4le = collect(Rot(f, '3', '4l') * (v3e + cross(w3e, f('4l').P)),[dx,dpsi,dq_imu,dq_w,dq_1l])
syms Z266 Z267 Z268 Z34 Z269 Z270 Z271 Z272 Z273 Z274 Z275 Z276 Z277 Z278 Z279 Z280 Z281 real
v4li = [Z266; Z267; Z268];
v4le = [Z269*dx+Z270*dpsi+Z271*dq_imu+Z272*dq_w+Z273*dq_torso; 
    Z257*dx+Z274*dpsi+Z275*dq_imu+Z276*dq_w; 
    Z277*dx+Z278*dpsi+Z279*dq_imu+Z280*dq_w+Z281*dq_torso]; 
dv4l = [[Z269 Z257 Z277]' [Z270 Z74 Z278]' [Z271 Z275 Z279]' ...
    [Z272 Z276 Z280]' [Z273 0 Z281]' zeros(3,14)];

% v5li = Rot(f, '4l', '5l') * (v4li + cross(w4li, f('5l').P))
% v5le = collect(Rot(f, '4l', '5l') * (v4le + cross(w4le, f('5l').P)),[dx,dpsi,dq_imu,dq_w,dq_1l])
syms Z282 Z283 Z284 Z285 Z286 Z287 Z288 Z289 Z290 Z291 Z292 Z293 real
v5li = [-Z266; Z282; Z283];
v5le = [(-Z269)*dx + (-Z270)*dpsi + (-Z271)*dq_imu + (-Z272)*dq_w - Z273*dq_torso;
    Z284*dx+Z285*dpsi+Z286*dq_imu+Z287*dq_w+Z288*dq_torso; 
    Z289*dx+Z290*dpsi+Z291*dq_imu+Z292*dq_w+Z293*dq_torso];
dv5l = [[-Z269 Z284 Z289]' [-Z270 Z85 Z290]' [-Z271 Z286 Z291]' ...
    [-Z272 Z287 Z292]' [-Z273 Z288 Z293]' zeros(3,14)];

% v6li = Rot(f, '5l', '6l') * (v5li + cross(w5li, f('6l').P))
% v6le = collect(Rot(f, '5l', '6l') * (v5le + cross(w5le, f('6l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l])
syms Z294 Z295 Z296 Z297 Z298 Z299 Z300 Z301 Z302 Z303 Z304 Z305 Z306 Z307 Z308 Z309 real
v6li = [Z294; -Z282; Z295];
v6le = [Z296*dx+Z297*dpsi+Z298*dq_imu+Z299*dq_w+Z300*dq_torso+Z301*dq_1l+Z302*dq_2l; 
    (-Z284)*dx + (-Z285)*dpsi + (-Z286)*dq_imu + (-Z287)*dq_w + (-Z288)*dq_torso;
    Z303*dx+Z304*dpsi+Z305*dq_imu+Z306*dq_w+Z307*dq_torso+Z308*dq_1l+Z309*dq_2l];
dv6l = [[Z296 -Z284 Z303]' [Z297 -Z85 Z304]' [Z298 -Z286 Z305]' ...
    [Z299 -Z287 Z306]' [Z300 -Z288 Z307]' [Z301 0 Z308]' [Z302 0 Z309]' ...
    zeros(3,12)];

% v7li = Rot(f, '6l', '7l') * (v6li + cross(w6li, f('7l').P))
% v7le = collect(Rot(f, '6l', '7l') * (v6le + cross(w6le, f('7l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l])
syms Z310 Z311 Z312 Z313 Z314 Z315 Z316 Z317 Z318 Z319 Z320 Z321 Z322 Z323 Z324 Z325 real
v7li = [-Z294; Z310; Z311];
v7le = [(-Z296)*dx + (-Z297)*dpsi + (-Z298)*dq_imu + (-Z299)*dq_w + (-Z300)*dq_torso + (-Z301)*dq_1l + (-Z302)*dq_2l;
    Z312*dx+Z313*dpsi+Z314*dq_imu+Z315*dq_w+Z316*dq_torso+Z317*dq_1l+Z318*dq_2l; 
    Z319*dx+Z320*dpsi+Z321*dq_imu+Z322*dq_w+Z323*dq_torso+Z324*dq_1l+Z325*dq_2l];
dv7l = [[-Z296 Z312 Z319]' [-Z297 Z313 Z320]' [-Z298 Z314 Z321]' ...
    [-Z299 Z315 Z322]' [-Z300 Z316 Z323]' [-Z301 Z317 Z324]' ...
    [-Z302 Z318 Z325]' zeros(3,12)];

% v8li = Rot(f, '7l', '8l') * (v7li + cross(w7li, f('8l').P))
% v8le = collect(Rot(f, '7l', '8l') * (v7le + cross(w7le, f('8l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l])
syms Z326 Z327 Z328 Z329 Z330 Z331 Z332 Z333 Z334 Z335 Z336 Z337 Z338 Z339 Z340 Z341 Z342 Z343 Z344 Z345 real
v8li = [Z326; -Z310; Z327];
v8le = [Z328*dx+Z329*dpsi+Z330*dq_imu+Z331*dq_w+Z332*dq_torso+Z333*dq_1l+Z334*dq_2l+Z335*dq_3l+Z336*dq_4l; 
    (-Z312)*dx + (-Z313)*dpsi + (-Z314)*dq_imu + (-Z315)*dq_w + (-Z316)*dq_torso + (-Z317)*dq_1l + (-Z318)*dq_2l
    Z337*dx+Z338*dpsi+Z339*dq_imu+Z340*dq_w+Z341*dq_torso+Z342*dq_1l+Z343*dq_2l+Z344*dq_3l+Z345*dq_4l];
dv8l = [[Z328 -Z312 Z337]' [Z329 -Z313 Z338]' [Z330 -Z314 Z339]' ...
    [Z331 -Z315 Z340]' [Z332 -Z316 Z341]' [Z333 -Z317 Z342]' ...
    [Z334 -Z318 Z343]' [Z335 0 Z344]' [Z336 0 Z345]' zeros(3,10)];

% v9li = Rot(f, '8l', '9l') * (v8li + cross(w8li, f('9l').P))
% v9le = collect(Rot(f, '8l', '9l') * (v8le + cross(w8le, f('9l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l])
syms Z346 Z347 Z348 Z349 Z350 Z351 Z352 Z353 Z354 Z355 Z356 Z357 Z358 Z359 Z360 Z361 Z362 Z363 Z364 Z365 real
v9li = [-Z326; Z346; Z347];
v9le = [(-Z328)*dx + (-Z329)*dpsi + (-Z330)*dq_imu + (-Z331)*dq_w + (-Z332)*dq_torso + (-Z333)*dq_1l + (-Z334)*dq_2l + (-Z335)*dq_3l + (-Z336)*dq_4l;
    Z348*dx+Z329*dpsi+Z350*dq_imu+Z351*dq_w+Z352*dq_torso+Z353*dq_1l+Z354*dq_2l+Z355*dq_3l+Z356*dq_4l; 
    Z357*dx+Z338*dpsi+Z359*dq_imu+Z360*dq_w+Z361*dq_torso+Z362*dq_1l+Z363*dq_2l+Z364*dq_3l+Z365*dq_4l];
dv9l = [[-Z328 Z348 Z357]' [-Z329 Z349 Z358]' [-Z330 Z350 Z359]' ...
    [-Z331 Z351 Z360]' [-Z332 Z352 Z361]' [-Z333 Z353 Z362]' ...
    [-Z334 Z354 Z363]' [-Z335 Z355 Z364]' [-Z336 Z356 Z365]' zeros(3,10)];

% v10li = Rot(f, '9l', '10l') * (v9li + cross(w9li, f('10l').P))
% v10le = collect(Rot(f, '9l', '10l') * (v9le + cross(w9le, f('10l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l])
syms Z366 Z367 Z368 Z369 Z370 Z371 Z372 Z373 Z374 Z375 Z376 Z377 Z378 Z379 Z380 Z381 Z382 Z383 Z384 Z385 Z386 Z387 Z388 Z389 real
v10li = [Z366; Z367; -Z346];
v10le = [Z368*dx+Z369*dpsi+Z370*dq_imu+Z371*dq_w+Z372*dq_torso+Z373*dq_1l+Z374*dq_2l+Z375*dq_3l+Z376*dq_4l+Z377*dq_5l+Z378*dq_6l; 
    Z379*dx+Z380*dpsi+Z381*dq_imu+Z382*dq_w+Z383*dq_torso+Z384*dq_1l+Z385*dq_2l+Z386*dq_3l+Z387*dq_4l+Z388*dq_5l+Z389*dq_6l; 
    (-Z348)*dx + (-Z349)*dpsi + (-Z350)*dq_imu + (-Z351)*dq_w + (-Z352)*dq_torso + (-Z353)*dq_1l + (-Z354)*dq_2l + (-Z355)*dq_3l + (-Z356)*dq_4l];
dv10l = [[Z368 Z379 -Z348]' [Z369 Z380 -Z349]' [Z370 Z381 -Z350]' ...
    [Z371 Z382 -Z351]' [Z372 Z383 -Z352]' [Z373 Z384 -Z353]' ...
    [Z374 Z385 -Z354]' [Z375 Z386 -Z355]' [Z376 Z387 -Z356]' ...
    [Z377 Z388 0]' [Z378 Z389 0]' zeros(3,8)];
dv10l = [[Z368 Z379 -Z348]' [Z369 Z380 -Z349]' [Z370 Z381 -Z350]' ...
    [Z371 Z382 -Z351]' [Z372 Z383 -Z352]' [Z373 Z384 -Z353]' ...
    [Z374 Z385 -Z354]' [Z375 Z386 -Z355]' [Z376 Z387 -Z356]' ...
    [Z377 Z388 0]' [Z378 Z389 0]' zeros(3,8)];

% v4ri = Rot(f, '3', '4r') * (v3i + cross(w3i, f('4r').P))
% v4re = collect(Rot(f, '3', '4r') * (v3e + cross(w3e, f('4r').P)),[dx,dpsi,dq_imu,dq_w,dq_1r])
syms Z390 Z391 Z392 Z393 Z394 Z395 Z396 Z397 Z398 Z399 Z400 Z401 Z402 Z403 Z404 Z405 real
v4ri = [Z390; Z391; Z392];
v4re = [Z393*dx+Z394*dpsi+Z395*dq_imu+Z396*dq_w+Z397*dq_torso; 
    -Z257*dx+Z398*dpsi+Z399*dq_imu+Z400*dq_w; 
    Z401*dx+Z402*dpsi+Z403*dq_imu+Z404*dq_w+Z405*dq_torso];
dv4r = [[Z393 -Z257 Z401]' [Z394 Z398 Z402]' [Z395 Z399 Z403]' ...
    [Z396 Z400 Z404]' [Z397 0 Z405]' zeros(3,14)];

% v5ri = Rot(f, '4r', '5r') * (v4ri + cross(w4ri, f('5r').P))
% v5re = collect(Rot(f, '4r', '5r') * (v4re + cross(w4re, f('5r').P)),[dx,dpsi,dq_imu,dq_w,dq_1r])
syms Z406 Z407 Z408 Z409 Z410 Z411 Z412 Z413 Z414 Z415 Z416 Z417 real
v5ri = [-Z390; Z406; Z407];
v5re = [(-Z393)*dx + (-Z394)*dpsi + (-Z395)*dq_imu + (-Z396)*dq_w - Z397*dq_torso;
    Z408*dx+Z409*dpsi+Z410*dq_imu+Z411*dq_w+Z412*dq_torso; 
    Z413*dx+Z414*dpsi+Z415*dq_imu+Z416*dq_w+Z417*dq_torso];
dv5r = [[-Z393 Z408 Z413]' [-Z394 Z190 Z414]' [-Z395 Z410 Z415]' ...
    [-Z396 Z411 Z416]' [-Z397 Z412 Z417]' zeros(3,14)];

% v6ri = Rot(f, '5r', '6r') * (v5ri + cross(w5ri, f('6r').P))
% v6re = collect(Rot(f, '5r', '6r') * (v5re + cross(w5re, f('6r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r])
syms Z418 Z419 Z420 Z421 Z422 Z423 Z424 Z425 Z426 Z427 Z428 Z429 Z430 Z431 Z432 Z433 real
v6ri = [Z418; -Z406; Z419];
v6re = [Z420*dx+Z421*dpsi+Z422*dq_imu+Z423*dq_w+Z424*dq_torso+Z425*dq_1r+Z426*dq_2r; 
    (-Z408)*dx + (-Z409)*dpsi + (-Z410)*dq_imu + (-Z411)*dq_w + (-Z412)*dq_torso;
    Z427*dx+Z428*dpsi+Z429*dq_imu+Z430*dq_w+Z431*dq_torso+Z432*dq_1r+Z433*dq_2r];
dv6r = [[Z420 -Z408 Z427]' [Z421 -Z190 Z428]' [Z422 -Z410 Z429]' ...
    [Z423 -Z411 Z430]' [Z424 -Z412 Z431]' zeros(3,7) [Z425 0 Z432]' ...
    [Z426 0 Z433]' zeros(3,5)];

% v7ri = Rot(f, '6r', '7r') * (v6ri + cross(w6ri, f('7r').P))
% v7re = collect(Rot(f, '6r', '7r') * (v6re + cross(w6re, f('7r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r])
syms Z434 Z435 Z436 Z437 Z438 Z439 Z440 Z441 Z442 Z443 Z444 Z445 Z446 Z447 Z448 Z449 real
v7ri = [-Z418; Z434; Z435];
v7re = [(-Z420)*dx + (-Z421)*dpsi + (-Z422)*dq_imu + (-Z423)*dq_w + (-Z424)*dq_torso + (-Z425)*dq_1r + (-Z426)*dq_2r;
    Z436*dx+Z437*dpsi+Z438*dq_imu+Z439*dq_w+Z440*dq_torso+Z441*dq_1r+Z442*dq_2r; 
    Z443*dx+Z444*dpsi+Z445*dq_imu+Z446*dq_w+Z447*dq_torso+Z448*dq_1r+Z449*dq_2r];
dv7r = [[-Z420 Z436 Z443]' [-Z421 Z437 Z444]' [-Z422 Z438 Z445]' ...
    [-Z423 Z439 Z446]' [-Z424 Z440 Z447]' zeros(3,7) [-Z425 Z441 Z448]' ...
    [-Z426 Z442 Z449]' zeros(3,5)];

% v8ri = Rot(f, '7r', '8r') * (v7ri + cross(w7ri, f('8r').P))
% v8re = collect(Rot(f, '7r', '8r') * (v7re + cross(w7re, f('8r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r])
syms Z450 Z451 Z452 Z453 Z454 Z455 Z456 Z457 Z458 Z459 Z460 Z461 Z462 Z463 Z464 Z465 Z466 Z467 Z468 Z469 real
v8ri = [Z450; -Z434; Z451];
v8re = [Z452*dx+Z453*dpsi+Z454*dq_imu+Z455*dq_w+Z456*dq_torso+Z457*dq_1r+Z458*dq_2r+Z459*dq_3r+Z460*dq_4r; 
    (-Z436)*dx + (-Z437)*dpsi + (-Z438)*dq_imu + (-Z439)*dq_w + (-Z440)*dq_torso + (-Z441)*dq_1r + (-Z442)*dq_2r
    Z461*dx+Z462*dpsi+Z463*dq_imu+Z464*dq_w+Z465*dq_torso+Z466*dq_1r+Z467*dq_2r+Z468*dq_3r+Z469*dq_4r];
dv8r = [[Z452 -Z436 Z461]' [Z453 -Z437 Z462]' [Z454 -Z438 Z463]' ...
    [Z455 -Z439 Z464]' [Z456 -Z440 Z465]' zeros(3,7) [Z457 -Z441 Z466]' ...
    [Z458 -Z442 Z467]' [Z459 0 Z468]' [Z460 0 Z469]' zeros(3,3)];

% v9ri = Rot(f, '8r', '9r') * (v8ri + cross(w8ri, f('9r').P))
% v9re = collect(Rot(f, '8r', '9r') * (v8re + cross(w8re, f('9r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r])
syms Z470 Z471 Z472 Z473 Z474 Z475 Z476 Z477 Z478 Z479 Z480 Z481 Z482 Z483 Z484 Z485 Z486 Z487 Z488 Z489 real
v9ri = [-Z450; Z470; Z471];
v9re = [(-Z452)*dx + (-Z453)*dpsi + (-Z454)*dq_imu + (-Z455)*dq_w + (-Z456)*dq_torso + (-Z457)*dq_1r + (-Z458)*dq_2r + (-Z459)*dq_3r + (-Z460)*dq_4r;
    Z472*dx+Z453*dpsi+Z474*dq_imu+Z475*dq_w+Z476*dq_torso+Z477*dq_1r+Z478*dq_2r+Z479*dq_3r+Z480*dq_4r; 
    Z481*dx+Z462*dpsi+Z483*dq_imu+Z484*dq_w+Z485*dq_torso+Z486*dq_1r+Z487*dq_2r+Z488*dq_3r+Z489*dq_4r];
dv9r = [[-Z452 Z472 Z481]' [-Z453 Z473 Z482]' [-Z454 Z474 Z483]' ...
    [-Z455 Z475 Z484]' [-Z456 Z476 Z485]' zeros(3,7) [-Z457 Z477 Z486]' ...
    [-Z458 Z478 Z487]' [-Z459 Z479 Z488]' [-Z460 Z480 Z489]' zeros(3,3)];

% v10ri = Rot(f, '9r', '10r') * (v9ri + cross(w9ri, f('10r').P))
% v10re = collect(Rot(f, '9r', '10r') * (v9re + cross(w9re, f('10r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r])
syms Z490 Z491 Z492 Z493 Z494 Z495 Z496 Z497 Z498 Z499 Z500 Z501 Z502 Z503 Z504 Z505 Z506 Z507 Z508 Z509 Z510 Z511 Z512 Z513 real
v10ri = [Z490; Z491; -Z470];
v10re = [Z492*dx+Z493*dpsi+Z494*dq_imu+Z495*dq_w+Z496*dq_torso+Z497*dq_1r+Z498*dq_2r+Z499*dq_3r+Z500*dq_4r+Z501*dq_5r+Z502*dq_6r; 
    Z503*dx+Z504*dpsi+Z505*dq_imu+Z506*dq_w+Z507*dq_torso+Z508*dq_1r+Z509*dq_2r+Z510*dq_3r+Z511*dq_4r+Z512*dq_5r+Z513*dq_6r; 
    (-Z472)*dx + (-Z473)*dpsi + (-Z474)*dq_imu + (-Z475)*dq_w + (-Z476)*dq_torso + (-Z477)*dq_1r + (-Z478)*dq_2r + (-Z479)*dq_3r + (-Z480)*dq_4r];
dv10r = [[Z492 Z503 -Z472]' [Z493 Z504 -Z473]' [Z494 Z505 -Z474]' ...
    [Z495 Z506 -Z475]' [Z496 Z507 -Z476]' [Z497 Z508 -Z477]' ...
    [Z498 Z509 -Z478]' [Z499 Z510 -Z479]' [Z500 Z511 -Z480]' ...
    [Z501 Z512 0]' [Z502 Z513 0]' zeros(3,8)];
dv10r = [[Z492 Z503 -Z472]' [Z493 Z504 -Z473]' [Z494 Z505 -Z474]' ...
    [Z495 Z506 -Z475]' [Z496 Z507 -Z476]' zeros(3,7) [Z497 Z508 -Z477]' ...
    [Z498 Z509 -Z478]' [Z499 Z510 -Z479]' [Z500 Z511 -Z480]' ...
    [Z501 Z512 0]' [Z502 Z513 0]' zeros(3,1)];

% %% Angular accelerations
% 
% % Wheels
% syms ddx ddpsi Z514 Z515 real
% ddthetaL = Z1*ddx - Z2*ddpsi;
% alpha0L = ddpsi*k0L;
% 
% % alphaL = collect(alpha0L + ddthetaL*j0L + wLi(2)*cross(w0L,j0L),[ddx,ddpsi])
% alphaL = [-Z3*ddpsi+Z514; Z1*ddx-Z2*ddpsi; Z4*ddpsi+Z515];
% 
% ddthetaR = Z1*ddx + Z2*ddpsi;
% alpha0R = ddpsi*k0R;
% 
% %alphaR = collect(alpha0R + ddthetaR*j0R + wRi(2)*cross(w0R,j0R),[ddx,ddpsi])
% syms Z516 Z517 real
% alphaR = [-Z8*ddpsi+Z516; Z1*ddx+Z2*ddpsi; Z4*ddpsi+Z517];
% 
% % Tree
% alpha0 = [0; 0; ddpsi]; 
% % this = '1'; w = w1i; prev = '0'; alphaLast = alpha0;
% % alpha1 = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu])
% syms ddq_imu Z518 Z519 Z520 Z521 real
% alpha1 = [-ddq_imu; Z13*ddpsi+Z518; Z14*ddpsi+Z519];
% 
% % this = '2'; w = w2i; prev = '1'; alphaLast = alpha1;
% % alpha2 = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w])
% syms ddq_w Z520 Z521 real
% alpha2 = [-ddq_imu-ddq_w; Z20*ddpsi+Z520; Z21*ddpsi+Z521];
% 
% % this = '3'; w = w3i; prev = '2'; alphaLast = alpha2;
% % alpha3 = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso])
% syms ddq_torso Z522 Z523 real
% alpha3 = [Z26*ddpsi+Z25*ddq_imu+Z25*ddq_w+Z522;
%     Z20*ddpsi-ddq_torso+Z520;
%     Z28*ddpsi+Z27*ddq_imu+Z27*ddq_w+Z523];
% 
% % this = '4l'; w = w4li; prev = '3'; alphaLast = alpha3;
% % alpha4l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l])
% syms ddq_1l Z524 Z525 real
% alpha4l = [Z32*ddpsi+Z33*ddq_imu+Z33*ddq_w+Z34*ddq_torso+Z524;
%     Z26*ddpsi + Z25*ddq_imu + Z25*ddq_w + Z522 - ddq_1l;
%     Z35*ddpsi+Z36*ddq_imu+Z36*ddq_w+Z37*ddq_torso+Z525];
% 
% % this = '5l'; w = w5li; prev = '4l'; alphaLast = alpha4l;
% % alpha5l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l])
% syms ddq_2l Z526 Z527 real
% alpha5l =[(-Z32)*ddpsi + (-Z33)*ddq_imu + (-Z33)*ddq_w + (-Z34)*ddq_torso - ddq_2l - Z524;
%     Z41*ddpsi+Z42*ddq_imu+Z42*ddq_w+Z43*ddq_torso+Z44*ddq_1l+Z526;
%     Z45*ddpsi+Z46*ddq_imu+Z46*ddq_w+Z47*ddq_torso+Z48*ddq_1l+Z527];
% 
% % this = '6l'; w = w6li; prev = '5l'; alphaLast = alpha5l;
% % alpha6l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l])
% syms ddq_3l Z528 Z529 real
% alpha6l = [Z52*ddpsi+Z53*ddq_imu+Z53*ddq_w+Z54*ddq_torso+Z55*ddq_1l+Z56*ddq_2l+Z528;
%     (-Z41)*ddpsi + (-Z42)*ddq_imu + (-Z42)*ddq_w + (-Z43)*ddq_torso + (-Z44)*ddq_1l - ddq_3l - Z526;
%     Z57*ddpsi+Z58*ddq_imu+Z58*ddq_w+Z59*ddq_torso+Z60*ddq_1l+Z61*ddq_2l+Z529];   
% 
% % this = '7l'; w = w7li; prev = '6l'; alphaLast = alpha6l;
% % alpha7l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l])
% syms ddq_4l Z530 Z531 real
% alpha7l = [ (-Z52)*ddpsi + (-Z53)*ddq_imu + (-Z53)*ddq_w + (-Z54)*ddq_torso + (-Z55)*ddq_1l + (-Z56)*ddq_2l - ddq_4l - Z528;
%     Z65*ddpsi+Z66*ddq_imu+Z66*ddq_w+Z67*ddq_torso+Z68*ddq_1l+Z69*ddq_2l+Z70*ddq_3l+Z530;
%     Z71*ddpsi+Z72*ddq_imu+Z72*ddq_w+Z73*ddq_torso+Z74*ddq_1l+Z75*ddq_2l+Z76*ddq_3l+Z531];
% 
% % this = '8l'; w = w8li; prev = '7l'; alphaLast = alpha7l;
% % alpha8l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l])
% syms ddq_5l Z532 Z533 real
% alpha8l = [Z80*ddpsi+Z81*ddq_imu+Z81*ddq_w+Z82*ddq_torso+Z83*ddq_1l+Z84*ddq_2l+Z85*ddq_3l+Z86*ddq_4l+Z532;
%     (-Z65)*ddpsi + (-Z66)*ddq_imu + (-Z66)*ddq_w + (-Z67)*ddq_torso + (-Z68)*ddq_1l + (-Z69)*ddq_2l + (-Z70)*ddq_3l - ddq_5l - Z530;
%     Z87*ddpsi+Z88*ddq_imu+Z88*ddq_w+Z89*ddq_torso+Z90*ddq_1l+Z91*ddq_2l+Z92*ddq_3l+Z93*ddq_4l+Z533];
% 
% % this = '9l'; w = w9li; prev = '8l'; alphaLast = alpha8l;
% % alpha9l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l])
% syms ddq_6l Z534 Z535 real
% alpha9l = [(-Z80)*ddpsi + (-Z81)*ddq_imu + (-Z81)*ddq_w + (-Z82)*ddq_torso + (-Z83)*ddq_1l + (-Z84)*ddq_2l + (-Z85)*ddq_3l + (-Z86)*ddq_4l - ddq_6l - Z532;
%     Z97*ddpsi+Z98*ddq_imu+Z98*ddq_w+Z99*ddq_torso+Z100*ddq_1l+Z101*ddq_2l+Z102*ddq_3l+Z103*ddq_4l+Z104*ddq_5l+Z534;
%     Z105*ddpsi+Z106*ddq_imu+Z106*ddq_w+Z107*ddq_torso+Z108*ddq_1l+Z109*ddq_2l+Z110*ddq_3l+Z111*ddq_4l+Z112*ddq_5l+Z535];
% 
% % this = '10l'; w = w10li; prev = '9l'; alphaLast = alpha9l;
% % alpha10l = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l,ddq_7l])
% syms ddq_7l Z536 Z537 real
% alpha10l = [Z116*ddpsi+Z117*ddq_imu+Z117*ddq_w+Z118*ddq_torso+Z119*ddq_1l+Z120*ddq_2l+Z121*ddq_3l+Z122*ddq_4l+Z123*ddq_5l+Z124*ddq_6l+Z536;
%     Z125*ddpsi+Z126*ddq_imu+Z126*ddq_w+Z127*ddq_torso+Z128*ddq_1l+Z129*ddq_2l+Z130*ddq_3l+Z131*ddq_4l+Z132*ddq_5l+Z133*ddq_6l+Z537;
%     (-Z97)*ddpsi + (-Z98)*ddq_imu + (-Z98)*ddq_w + (-Z99)*ddq_torso + (-Z100)*ddq_1l + (-Z101)*ddq_2l + (-Z102)*ddq_3l + (-Z103)*ddq_4l + (-Z104)*ddq_5l - ddq_7l - Z534];
% 
% % this = '4r'; w = w4ri; prev = '3'; alphaLast = alpha3;
% % alpha4r = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r])
% syms ddq_1r Z538 Z539 real
% alpha4r = [Z137*ddpsi+Z138*ddq_imu+Z138*ddq_w+Z139*ddq_torso+Z538;  
%         (-Z26)*ddpsi + (-Z25)*ddq_imu + (-Z25)*ddq_w - ddq_1r-Z522;
%         Z140*ddpsi+Z141*ddq_imu+Z141*ddq_w+Z142*ddq_torso+Z539];
%     
% % this = '5r'; w = w5ri; prev = '4r'; alphaLast = alpha4r;
% % alpha5r = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r])
% syms ddq_2r Z540 Z541 real    
% alpha5r = [(-Z137)*dpsi + (-Z138)*dq_imu + (-Z138)*dq_w + (-Z139)*dq_torso - dq_2r-Z538;
%     Z146*dpsi+Z147*dq_imu+Z147*dq_w+Z148*dq_torso+Z149*dq_1r+Z540;
%     Z150*dpsi+Z151*dq_imu+Z151*dq_w+Z152*dq_torso+Z153*dq_1r+Z541];
%  
% % this = '6r'; w = w6ri; prev = '5r'; alphaLast = alpha5r;
% % alpha6r = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r])
% syms ddq_3r Z542 Z543 real
% alpha6r = [Z157*ddpsi+Z158*ddq_imu+Z158*ddq_w+Z159*ddq_torso+Z160*ddq_1r+Z161*ddq_2r+Z542;
%     (-Z146)*ddpsi + (-Z147)*ddq_imu + (-Z147)*ddq_w + (-Z148)*ddq_torso + (-Z149)*ddq_1r - ddq_3r - Z540;
%     Z162*ddpsi+Z163*ddq_imu+Z163*ddq_w+Z164*ddq_torso+Z165*ddq_1r+Z166*ddq_2r+Z543];   
% 
% % this = '7r'; w = w7ri; prev = '6r'; alphaLast = alpha6r;
% % alpha7r = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r])
% syms ddq_4r Z544 Z545 real
% alpha7r = [ (-Z157)*ddpsi + (-Z158)*ddq_imu + (-Z158)*ddq_w + (-Z159)*ddq_torso + (-Z160)*ddq_1r + (-Z161)*ddq_2r - ddq_4r - Z542;
%     Z170*ddpsi+Z171*ddq_imu+Z171*ddq_w+Z172*ddq_torso+Z173*ddq_1r+Z174*ddq_2r+Z175*ddq_3r+Z544;
%     Z176*ddpsi+Z177*ddq_imu+Z177*ddq_w+Z178*ddq_torso+Z179*ddq_1r+Z180*ddq_2r+Z181*ddq_3r+Z545];
% 
% % this = '8r'; w = w8ri; prev = '7r'; alphaLast = alpha7r;
% % alpha8r = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r])
% syms ddq_5r Z546 Z547 real
% alpha8r = [Z185*ddpsi+Z186*ddq_imu+Z186*ddq_w+Z187*ddq_torso+Z188*ddq_1r+Z189*ddq_2r+Z190*ddq_3r+Z191*ddq_4r+Z546;
%     (-Z170)*ddpsi + (-Z171)*ddq_imu + (-Z171)*ddq_w + (-Z172)*ddq_torso + (-Z173)*ddq_1r + (-Z174)*ddq_2r + (-Z175)*ddq_3r - ddq_5r - Z544;
%     Z192*ddpsi+Z193*ddq_imu+Z193*ddq_w+Z194*ddq_torso+Z195*ddq_1r+Z196*ddq_2r+Z197*ddq_3r+Z198*ddq_4r+Z547];
% 
% % this = '9r'; w = w9ri; prev = '8r'; alphaLast = alpha8r;
% % alpha9r = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r])
% syms ddq_6r Z548 Z549 real
% alpha9r = [(-Z185)*ddpsi + (-Z186)*ddq_imu + (-Z186)*ddq_w + (-Z187)*ddq_torso + (-Z188)*ddq_1r + (-Z189)*ddq_2r + (-Z190)*ddq_3r + (-Z191)*ddq_4r - ddq_6r - Z546;
%     Z202*ddpsi+Z203*ddq_imu+Z203*ddq_w+Z204*ddq_torso+Z205*ddq_1r+Z206*ddq_2r+Z207*ddq_3r+Z208*ddq_4r+Z209*ddq_5r+Z548;
%     Z210*ddpsi+Z211*ddq_imu+Z211*ddq_w+Z212*ddq_torso+Z213*ddq_1r+Z214*ddq_2r+Z215*ddq_3r+Z216*ddq_4r+Z217*ddq_5r+Z549];
% 
% % this = '10r'; w = w10ri; prev = '9r'; alphaLast = alpha9r;
% % alpha10r = collect(Rot(f, prev, this)*alphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r])
% syms ddq_7r Z550 Z551 real
% alpha10r = [Z221*ddpsi+Z222*ddq_imu+Z222*ddq_w+Z223*ddq_torso+Z224*ddq_1r+Z225*ddq_2r+Z226*ddq_3r+Z227*ddq_4r+Z228*ddq_5r+Z229*ddq_6r+Z550;
%     Z230*ddpsi+Z231*ddq_imu+Z231*ddq_w+Z232*ddq_torso+Z233*ddq_1r+Z234*ddq_2r+Z235*ddq_3r+Z236*ddq_4r+Z237*ddq_5r+Z238*ddq_6r+Z551;
%     (-Z202)*ddpsi + (-Z203)*ddq_imu + (-Z203)*ddq_w + (-Z204)*ddq_torso + (-Z205)*ddq_1r + (-Z206)*ddq_2r + (-Z207)*ddq_3r + (-Z208)*ddq_4r + (-Z209)*ddq_5r - ddq_7r - Z548];
% 
% %% Linear Acceleration
% 
% % Wheels
% % rOL = Z552*j0L;
% % a0L = ddx*i0L + dx*(cross(dpsi*k0L,i0L));
% % aGL = collect(a0L + cross(alpha0L, rOL) + cross(w0L, cross(w0L, rOL)),[ddx,ddpsi])
% % aGL =
% %  
% %                                         Z4*ddx + (-Z4*Z552)*ddpsi
% %  dx*(dpsi*Z3^2 + dpsi*Z4^2) - Z3^2*Z552*dpsi^2 - Z4^2*Z552*dpsi^2
% %                                         Z3*ddx + (-Z3*Z552)*ddpsi
% syms Z552 Z553 Z554 Z555 real
% aGL = [Z4*ddx+Z553*ddpsi; Z554; Z3*ddx+Z555*ddpsi]; 
% 
% % rOR = -Z552*j0R;
% % a0R = ddx*i0R + dx*(cross(dpsi*k0R,i0R));
% % aGR = collect(a0R + cross(alpha0R, rOR) + cross(w0R, cross(w0R, rOR)),[ddx,ddpsi])
% % aGR =
% %  
% %                                          Z9*ddx + (Z9*Z552)*ddpsi
% %  dx*(dpsi*Z8^2 + dpsi*Z9^2) + Z8^2*Z552*dpsi^2 + Z9^2*Z552*dpsi^2
% %                                          Z8*ddx + (Z8*Z552)*ddpsi
% syms Z556 Z557 Z558 real
% aGR = [Z9*ddx+Z556*ddpsi; Z557; Z8*ddx+Z558*ddpsi];
% 
% % Tree
% % a0 = [ddx; 0; 0] + cross(w0, [1; 0; 0]); 
% % this = '1'; prev = '0'; aLast = a0; alphaLast = alpha0; wLast = w0;
% % a1 = Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P)))
% a1 = [-dpsi; Z14*ddx; -Z13*ddx];
% 
% % this = '2'; prev = '1'; aLast = a1; alphaLast = alpha1; wLast = w1i;
% % a2 = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu])
% syms Z559 Z560 Z561 real
% a2 = [Z249*ddpsi+Z559; Z250*ddx+Z251*ddq_imu+Z560; Z252*ddx+Z253*ddq_imu+Z561];
% 
% % this = '3'; prev = '2'; aLast = a2; alphaLast = alpha2; wLast = w2i;
% % a3 = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w])
% syms Z562 Z563 Z564 real
% a3 = [Z257*ddx+Z258*ddpsi+Z259*ddq_imu+Z260*ddq_w+Z562; 
%     Z250*ddx+Z261*ddq_imu+L4*ddq_w+Z563; 
%     Z262*ddx+Z263*ddpsi+Z264*ddq_imu+Z265*ddq_w+Z564];
% 
% % this = '4l'; prev = '3'; aLast = a3; alphaLast = alpha3; wLast = w3i;
% % a4l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso])
% syms Z565 Z566 Z567 real
% a4l = [Z269*ddx+Z270*ddpsi+Z271*ddq_imu+Z272*ddq_w+Z273*ddq_torso+Z565; 
%     Z257*ddx+Z274*ddpsi+Z275*ddq_imu+Z276*ddq_w+Z566; 
%     Z277*ddx+Z278*ddpsi+Z279*ddq_imu+Z280*ddq_w+Z281*ddq_torso+Z567];
% 
% % this = '5l'; prev = '4l'; aLast = a4l; alphaLast = alpha4l; wLast = w4li;
% % a5l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l])
% syms Z568 Z569 real
% a5l = [(-Z269)*ddx + (-Z270)*ddpsi + (-Z271)*ddq_imu + (-Z272)*ddq_w - Z273*ddq_torso - Z565;
%     Z284*ddx+Z285*ddpsi+Z286*ddq_imu+Z287*ddq_w+Z288*ddq_torso+Z568; 
%     Z289*ddx+Z290*ddpsi+Z291*ddq_imu+Z292*ddq_w+Z293*ddq_torso+Z569];
% 
% % this = '6l'; prev = '5l'; aLast = a5l; alphaLast = alpha5l; wLast = w5li;
% % a6l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l])
% syms Z570 Z571 Z572 real
% a6l = [Z296*ddx+Z297*ddpsi+Z298*ddq_imu+Z299*ddq_w+Z300*ddq_torso+Z301*ddq_1l+Z302*ddq_2l+Z570; 
%     (-Z284)*ddx + (-Z285)*ddpsi + (-Z286)*ddq_imu + (-Z287)*ddq_w + (-Z288)*ddq_torso+Z571;
%     Z303*ddx+Z304*ddpsi+Z305*ddq_imu+Z306*ddq_w+Z307*ddq_torso+Z308*ddq_1l+Z309*ddq_2l+Z572];
% 
% % this = '7l'; prev = '6l'; aLast = a6l; alphaLast = alpha6l; wLast = w6li;
% % a7l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l])
% syms Z573 Z574 real
% a7l = [(-Z296)*ddx + (-Z297)*ddpsi + (-Z298)*ddq_imu + (-Z299)*ddq_w + (-Z300)*ddq_torso + (-Z301)*ddq_1l + (-Z302)*ddq_2l- Z570;
%     Z312*ddx+Z313*ddpsi+Z314*ddq_imu+Z315*ddq_w+Z316*ddq_torso+Z317*ddq_1l+Z318*ddq_2l+Z573; 
%     Z319*ddx+Z320*ddpsi+Z321*ddq_imu+Z322*ddq_w+Z323*ddq_torso+Z324*ddq_1l+Z325*ddq_2l+Z574];
% 
% % this = '8l'; prev = '7l'; aLast = a7l; alphaLast = alpha7l; wLast = w7li;
% % a8l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l])
% syms Z575 Z576 Z577 real
% a8l = [Z328*ddx+Z329*ddpsi+Z330*ddq_imu+Z331*ddq_w+Z332*ddq_torso+Z333*ddq_1l+Z334*ddq_2l+Z335*ddq_3l+Z336*ddq_4l+Z575; 
%     (-Z312)*ddx + (-Z313)*ddpsi + (-Z314)*ddq_imu + (-Z315)*ddq_w + (-Z316)*ddq_torso + (-Z317)*ddq_1l + (-Z318)*ddq_2l+Z576;
%     Z337*ddx+Z338*ddpsi+Z339*ddq_imu+Z340*ddq_w+Z341*ddq_torso+Z342*ddq_1l+Z343*ddq_2l+Z344*ddq_3l+Z345*ddq_4l+Z577];
% 
% % this = '9l'; prev = '8l'; aLast = a8l; alphaLast = alpha8l; wLast = w8li;
% % a9l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l])
% syms Z578 Z579 real
% a9l = [(-Z328)*ddx + (-Z329)*ddpsi + (-Z330)*ddq_imu + (-Z331)*ddq_w + (-Z332)*ddq_torso + (-Z333)*ddq_1l + (-Z334)*ddq_2l + (-Z335)*ddq_3l + (-Z336)*ddq_4l- Z575;
%     Z348*ddx+Z349*ddpsi+Z350*ddq_imu+Z351*ddq_w+Z352*ddq_torso+Z353*ddq_1l+Z354*ddq_2l+Z355*ddq_3l+Z356*ddq_4l+Z578; 
%     Z357*ddx+Z358*ddpsi+Z359*ddq_imu+Z360*ddq_w+Z361*ddq_torso+Z362*ddq_1l+Z363*ddq_2l+Z364*ddq_3l+Z365*ddq_4l+Z579];
% 
% % this = '10l'; prev = '9l'; aLast = a9l; alphaLast = alpha9l; wLast = w9li;
% % a10l = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l])
% syms Z580 Z581 Z582 real
% a10l = [Z368*ddx+Z369*ddpsi+Z370*ddq_imu+Z371*ddq_w+Z372*ddq_torso+Z373*ddq_1l+Z374*ddq_2l+Z375*ddq_3l+Z376*ddq_4l+Z377*ddq_5l+Z378*ddq_6l+Z580; 
%     Z379*ddx+Z380*ddpsi+Z381*ddq_imu+Z382*ddq_w+Z383*ddq_torso+Z384*ddq_1l+Z385*ddq_2l+Z386*ddq_3l+Z387*ddq_4l+Z388*ddq_5l+Z389*ddq_6l+Z581; 
%     (-Z348)*ddx + (-Z349)*ddpsi + (-Z350)*ddq_imu + (-Z351)*ddq_w + (-Z352)*ddq_torso + (-Z353)*ddq_1l + (-Z354)*ddq_2l + (-Z355)*ddq_3l + (-Z356)*ddq_4l+Z582];
% 
% % this = '4r'; prev = '3'; aLast = a3; alphaLast = alpha3; wLast = w3i;
% % a4r = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso])
% syms Z583 Z584 Z585 real
% a4r = [Z393*ddx+Z394*ddpsi+Z395*ddq_imu+Z396*ddq_w+Z397*ddq_torso+Z583; 
%     -Z257*ddx+Z398*ddpsi+Z399*ddq_imu+Z400*ddq_w+Z584; 
%     Z401*ddx+Z402*ddpsi+Z403*ddq_imu+Z404*ddq_w+Z405*ddq_torso+Z585];
% % 
% % this = '5r'; prev = '4r'; aLast = a4r; alphaLast = alpha4r; wLast = w4ri;
% % a5r = collect(Rot(f, prev, this) * (aLast + cross(alphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso])
% syms Z586 Z587 real
% a5r = [(-Z393)*ddx + (-Z394)*ddpsi + (-Z395)*ddq_imu + (-Z396)*ddq_w - Z397*ddq_torso- Z583;
%     Z408*ddx+Z409*ddpsi+Z410*ddq_imu+Z411*ddq_w+Z412*ddq_torso+Z586; 
%     Z413*ddx+Z414*ddpsi+Z415*ddq_imu+Z416*ddq_w+Z417*ddq_torso+Z587];
% 
% % this = '6r'; prev = '5r'; aLast = a5r; arphaLast = arpha5r; wLast = w5ri;
% % a6r = collect(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r])
% syms Z588 Z589 Z590 real
% a6r = [Z420*ddx+Z421*ddpsi+Z422*ddq_imu+Z423*ddq_w+Z424*ddq_torso+Z425*ddq_1r+Z426*ddq_2r+Z588; 
%     (-Z408)*ddx + (-Z409)*ddpsi + (-Z410)*ddq_imu + (-Z411)*ddq_w + (-Z412)*ddq_torso+Z589;
%     Z427*ddx+Z428*ddpsi+Z429*ddq_imu+Z430*ddq_w+Z431*ddq_torso+Z432*ddq_1r+Z433*ddq_2r+Z590];
% 
% % this = '7r'; prev = '6r'; aLast = a6r; arphaLast = arpha6r; wLast = w6ri;
% % a7r = collect(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r])
% syms Z591 Z592 real
% a7r = [(-Z420)*ddx + (-Z421)*ddpsi + (-Z422)*ddq_imu + (-Z423)*ddq_w + (-Z424)*ddq_torso + (-Z425)*ddq_1r + (-Z426)*ddq_2r- Z588;
%     Z436*ddx+Z437*ddpsi+Z438*ddq_imu+Z439*ddq_w+Z440*ddq_torso+Z441*ddq_1r+Z442*ddq_2r+Z591; 
%     Z443*ddx+Z444*ddpsi+Z445*ddq_imu+Z446*ddq_w+Z447*ddq_torso+Z448*ddq_1r+Z449*ddq_2r+Z592];
% 
% % this = '8r'; prev = '7r'; aLast = a7r; arphaLast = arpha7r; wLast = w7ri;
% % a8r = collect(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r])
% syms Z593 Z594 Z595 real
% a8r = [Z452*ddx+Z453*ddpsi+Z454*ddq_imu+Z455*ddq_w+Z456*ddq_torso+Z457*ddq_1r+Z458*ddq_2r+Z459*ddq_3r+Z460*ddq_4r+Z593; 
%     (-Z436)*ddx + (-Z437)*ddpsi + (-Z438)*ddq_imu + (-Z439)*ddq_w + (-Z440)*ddq_torso + (-Z441)*ddq_1r + (-Z442)*ddq_2r+Z594;
%     Z461*ddx+Z462*ddpsi+Z463*ddq_imu+Z464*ddq_w+Z465*ddq_torso+Z466*ddq_1r+Z467*ddq_2r+Z468*ddq_3r+Z469*ddq_4r+Z595];
% 
% % this = '9r'; prev = '8r'; aLast = a8r; arphaLast = arpha8r; wLast = w8ri;
% % a9r = collect(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r])
% syms Z596 Z597 real
% a9r = [(-Z452)*ddx + (-Z453)*ddpsi + (-Z454)*ddq_imu + (-Z455)*ddq_w + (-Z456)*ddq_torso + (-Z457)*ddq_1r + (-Z458)*ddq_2r + (-Z459)*ddq_3r + (-Z460)*ddq_4r- Z593;
%     Z472*ddx+Z473*ddpsi+Z474*ddq_imu+Z475*ddq_w+Z476*ddq_torso+Z477*ddq_1r+Z478*ddq_2r+Z479*ddq_3r+Z480*ddq_4r+Z596; 
%     Z481*ddx+Z482*ddpsi+Z483*ddq_imu+Z484*ddq_w+Z485*ddq_torso+Z486*ddq_1r+Z487*ddq_2r+Z488*ddq_3r+Z489*ddq_4r+Z597];
% 
% % this = '10r'; prev = '9r'; aLast = a9r; arphaLast = arpha9r; wLast = w9ri;
% % a10r = collect(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
% %         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r])
% syms Z598 Z599 Z600 real
% a10r = [Z492*ddx+Z493*ddpsi+Z494*ddq_imu+Z495*ddq_w+Z496*ddq_torso+Z497*ddq_1r+Z498*ddq_2r+Z499*ddq_3r+Z500*ddq_4r+Z501*ddq_5r+Z502*ddq_6r+Z598; 
%     Z503*ddx+Z504*ddpsi+Z505*ddq_imu+Z506*ddq_w+Z507*ddq_torso+Z508*ddq_1r+Z509*ddq_2r+Z510*ddq_3r+Z511*ddq_4r+Z512*ddq_5r+Z513*ddq_6r+Z599; 
%     (-Z472)*ddx + (-Z473)*ddpsi + (-Z474)*ddq_imu + (-Z475)*ddq_w + (-Z476)*ddq_torso + (-Z477)*ddq_1r + (-Z478)*ddq_2r + (-Z479)*ddq_3r + (-Z480)*ddq_4r+Z600];
% 
% %% Inertial Forces
% 
% % Wheels
% % syms mw real
% % maGL = collect(mw*aGL,[ddx,ddpsi]);
% % maGR = collect(mw*aGR,[ddx,ddpsi]);
% % 
% % syms YYw ZZw real
% % Iw = [ZZw 0 0; 0 YYw 0; 0 0 ZZw];
% % dHGL = collect(Iw*alphaL + cross(wLi,Iw*wLi),[ddx,ddpsi]);
% % dHGR = collect(Iw*alphaR + cross(wRi,Iw*wRi),[ddx,ddpsi]);
% syms Z601 Z602 Z603 Z604 Z605 Z606 Z607 Z608 Z609 Z610 Z611 Z612 Z613 Z614 Z615 Z616 Z617 Z618 Z619 Z620 Z621 Z622 real 
% maGL = [Z601*ddx+Z602*ddpsi;Z603; Z604*ddx+Z605*ddpsi]; 
% maGR = [Z606*ddx+Z607*ddpsi;Z608; Z609*ddx+Z610*ddpsi]; 
%  
% dHGL = [Z611*ddpsi+Z612; Z613*ddx+Z614*ddpsi; Z615*ddpsi+Z616];
% dHGR = [Z617*ddpsi+Z618; Z619*ddx+Z620*ddpsi; Z621*ddpsi+Z622];
% 
% % % Tree
% % keys = {'1', '2', '3', '4l', '5l', '6l', '7l', '8l', '9l', '10l', ...
% %     '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% % aa = {a1, a2, a3, a4l, a5l, a6l, a7l, a8l, a9l, a10l, ...
% %     a4r, a5r, a6r, a7r, a8r, a9r, a10r};
% % alphaa = {alpha1, alpha2, alpha3, alpha4l, alpha5l, alpha6l, alpha7l, alpha8l, alpha9l, alpha10l, ...
% %     alpha4r, alpha5r, alpha6r, alpha7r, alpha8r, alpha9r, alpha10r};
% % ww = {w1i, w2i, w3i, w4li, w5li, w6li, w7li, w8li, w9li, w10li, ...
% %     w4ri, w5ri, w6ri, w7ri, w8ri, w9ri, w10ri};
% % n = 622;
% % ddq = ddqVec(f);
% % fid = fopen('inertialOut.m','w');
% % for i=1:17
% %     this=keys{i}; a=aa{i}; alpha=alphaa{i}; w=ww{i};
% %     m=mass(f,this); mS=mCOM(f,this); J=inertiaMat(f,this);
% %  
% %     maG = collect(m*a + cross(alpha,mS) + cross(w,cross(w,mS)),[ddx,ddpsi,ddq_imu,ddq_w,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l,ddq_7l,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r]);
% %     display(['% maG' this ' = ']); display('%'); display(['%      ' char(maG(1))]);display(['%      ' char(maG(2))]);display(['%      ' char(maG(3))]);
% %     for j=1:3
% %         maGrem = maG(j); str{j} = []; op = [];
% %         for k = 1:length(ddq)
% %             Z = diff(maG(j),ddq(k));
% %             if(~isequal(Z,0))
% %                 n = n + 1;
% %                 display(['Z' num2str(n) ' = ' char(Z) ';']);
% %                 str{j} = [str{j} op 'Z' num2str(n) '*' char(ddq(k))]; op ='+';
% %                 maGrem = simplify(maGrem - Z*ddq(k));
% %             end
% %         end
% %         n = n + 1;
% %         display(['Z' num2str(n) ' = ' char(maGrem) ';']); display(' ');
% %         str{j} = [str{j} op 'Z' num2str(n)];
% %     end
% %     display(['maG' this ' = [' str{1} ';']); 
% %     display(['    ' str{2} ';']);
% %     display(['    ' str{3} '];']); display(' ');
% %     fprintf(fid,'%s\n\r%s\n\r%s\n\r\n\r',['maG' this ' = [' str{1} ';'],['    ' str{2} ';'],['    ' str{3} '];']);
% %     
% %     dHnew = collect(cross(mS,a) + J*alpha + cross(w,J*w),[ddx,ddpsi,ddq_imu,ddq_w,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l,ddq_7l,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r]);
% %     display(['% dHnew' this ' = ']); display('%'); display(['%      ' char(maG(1))]);display(['%      ' char(maG(2))]);display(['%      ' char(maG(3))]);
% %     for j=1:3
% %         dHrem = dHnew(j); str{j} = []; op = [];
% %         for k = 1:length(ddq)
% %             Z = diff(dHnew(j),ddq(k));
% %             if(~isequal(Z,0))
% %                 n = n + 1;
% %                 display(['Z' num2str(n) ' = ' char(Z) ';']);
% %                 str{j} = [str{j} op 'Z' num2str(n) '*' char(ddq(k))]; op ='+';
% %                 dHrem = simplify(dHrem - Z*ddq(k));
% %             end
% %         end
% %         n = n + 1;
% %         display(['Z' num2str(n) ' = ' char(dHrem) ';']); display(' ');
% %         str{j} = [str{j} op 'Z' num2str(n)];
% %     end
% %     display(['dHnew' this ' = [' str{1} ';']); 
% %     display(['    ' str{2} ';']);
% %     display(['    ' str{3} '];']);display(' ');display(' ');
% %     fprintf(fid,'%s\n\r%s\n\r%s\n\r\n\r',['dHnew' this ' = [' str{1} ';'],['    ' str{2} ';'],['    ' str{3} '];']);
% % end
% % fclose(fid);
% 
% syms Z601 Z602 Z603 Z604 Z605 Z606 Z607 Z608 Z609 Z610 Z611 Z612 Z613 Z614 Z615 Z616 Z617 Z618 Z619 Z620 Z621 Z622 Z623 Z624 Z625 Z626 Z627 Z628 Z629 Z630 Z631 Z632 Z633 Z634 Z635 Z636 Z637 Z638 Z639 Z640 Z641 Z642 Z643 Z644 Z645 Z646 Z647 Z648 Z649 Z650  real
% syms Z651 Z652 Z653 Z654 Z655 Z656 Z657 Z658 Z659 Z660 Z661 Z662 Z663 Z664 Z665 Z666 Z667 Z668 Z669 Z670 Z671 Z672 Z673 Z674 Z675 Z676 Z677 Z678 Z679 Z680 Z681 Z682 Z683 Z684 Z685 Z686 Z687 Z688 Z689 Z690 Z691 Z692 Z693 Z694 Z695 Z696 Z697 Z698 Z699 Z700  real
% syms Z701 Z702 Z703 Z704 Z705 Z706 Z707 Z708 Z709 Z710 Z711 Z712 Z713 Z714 Z715 Z716 Z717 Z718 Z719 Z720 Z721 Z722 Z723 Z724 Z725 Z726 Z727 Z728 Z729 Z730 Z731 Z732 Z733 Z734 Z735 Z736 Z737 Z738 Z739 Z740 Z741 Z742 Z743 Z744 Z745 Z746 Z747 Z748 Z749 Z750  real
% syms Z751 Z752 Z753 Z754 Z755 Z756 Z757 Z758 Z759 Z760 Z761 Z762 Z763 Z764 Z765 Z766 Z767 Z768 Z769 Z770 Z771 Z772 Z773 Z774 Z775 Z776 Z777 Z778 Z779 Z780 Z781 Z782 Z783 Z784 Z785 Z786 Z787 Z788 Z789 Z790 Z791 Z792 Z793 Z794 Z795 Z796 Z797 Z798 Z799 Z800  real
% syms Z801 Z802 Z803 Z804 Z805 Z806 Z807 Z808 Z809 Z810 Z811 Z812 Z813 Z814 Z815 Z816 Z817 Z818 Z819 Z820 Z821 Z822 Z823 Z824 Z825 Z826 Z827 Z828 Z829 Z830 Z831 Z832 Z833 Z834 Z835 Z836 Z837 Z838 Z839 Z840 Z841 Z842 Z843 Z844 Z845 Z846 Z847 Z848 Z849 Z850  real
% syms Z851 Z852 Z853 Z854 Z855 Z856 Z857 Z858 Z859 Z860 Z861 Z862 Z863 Z864 Z865 Z866 Z867 Z868 Z869 Z870 Z871 Z872 Z873 Z874 Z875 Z876 Z877 Z878 Z879 Z880 Z881 Z882 Z883 Z884 Z885 Z886 Z887 Z888 Z889 Z890 Z891 Z892 Z893 Z894 Z895 Z896 Z897 Z898 Z899 Z900  real
% syms Z901 Z902 Z903 Z904 Z905 Z906 Z907 Z908 Z909 Z910 Z911 Z912 Z913 Z914 Z915 Z916 Z917 Z918 Z919 Z920 Z921 Z922 Z923 Z924 Z925 Z926 Z927 Z928 Z929 Z930 Z931 Z932 Z933 Z934 Z935 Z936 Z937 Z938 Z939 Z940 Z941 Z942 Z943 Z944 Z945 Z946 Z947 Z948 Z949 Z950  real
% syms Z951 Z952 Z953 Z954 Z955 Z956 Z957 Z958 Z959 Z960 Z961 Z962 Z963 Z964 Z965 Z966 Z967 Z968 Z969 Z970 Z971 Z972 Z973 Z974 Z975 Z976 Z977 Z978 Z979 Z980 Z981 Z982 Z983 Z984 Z985 Z986 Z987 Z988 Z989 Z990 Z991 Z992 Z993 Z994 Z995 Z996 Z997 Z998 Z999 Z1000  real
% syms Z1001 Z1002 Z1003 Z1004 Z1005 Z1006 Z1007 Z1008 Z1009 Z1010 Z1011 Z1012 Z1013 Z1014 Z1015 Z1016 Z1017 Z1018 Z1019 Z1020 Z1021 Z1022 Z1023 Z1024 Z1025 Z1026 Z1027 Z1028 Z1029 Z1030 Z1031 Z1032 Z1033 Z1034 Z1035 Z1036 Z1037 Z1038 Z1039 Z1040 Z1041 Z1042 Z1043 Z1044 Z1045 Z1046 Z1047 Z1048 Z1049 Z1050  real
% syms Z1051 Z1052 Z1053 Z1054 Z1055 Z1056 Z1057 Z1058 Z1059 Z1060 Z1061 Z1062 Z1063 Z1064 Z1065 Z1066 Z1067 Z1068 Z1069 Z1070 Z1071 Z1072 Z1073 Z1074 Z1075 Z1076 Z1077 Z1078 Z1079 Z1080 Z1081 Z1082 Z1083 Z1084 Z1085 Z1086 Z1087 Z1088 Z1089 Z1090 Z1091 Z1092 Z1093 Z1094 Z1095 Z1096 Z1097 Z1098 Z1099 Z1100  real
% syms Z1101 Z1102 Z1103 Z1104 Z1105 Z1106 Z1107 Z1108 Z1109 Z1110 Z1111 Z1112 Z1113 Z1114 Z1115 Z1116 Z1117 Z1118 Z1119 Z1120 Z1121 Z1122 Z1123 Z1124 Z1125 Z1126 Z1127 Z1128 Z1129 Z1130 Z1131 Z1132 Z1133 Z1134 Z1135 Z1136 Z1137 Z1138 Z1139 Z1140 Z1141 Z1142 Z1143 Z1144 Z1145 Z1146 Z1147 Z1148 Z1149 Z1150  real
% syms Z1151 Z1152 Z1153 Z1154 Z1155 Z1156 Z1157 Z1158 Z1159 Z1160 Z1161 Z1162 Z1163 Z1164 Z1165 Z1166 Z1167 Z1168 Z1169 Z1170 Z1171 Z1172 Z1173 Z1174 Z1175 Z1176 Z1177 Z1178 Z1179 Z1180 Z1181 Z1182 Z1183 Z1184 Z1185 Z1186 Z1187 Z1188 Z1189 Z1190 Z1191 Z1192 Z1193 Z1194 Z1195 Z1196 Z1197 Z1198 Z1199 Z1200  real
% syms Z1201 Z1202 Z1203 Z1204 Z1205 Z1206 Z1207 Z1208 Z1209 Z1210 Z1211 Z1212 Z1213 Z1214 Z1215 Z1216 Z1217 Z1218 Z1219 Z1220 Z1221 Z1222 Z1223 Z1224 Z1225 Z1226 Z1227 Z1228 Z1229 Z1230 Z1231 Z1232 Z1233 Z1234 Z1235 Z1236 Z1237 Z1238 Z1239 Z1240 Z1241 Z1242 Z1243 Z1244 Z1245 Z1246 Z1247 Z1248 Z1249 Z1250  real
% syms Z1251 Z1252 Z1253 Z1254 Z1255 Z1256 Z1257 Z1258 Z1259 Z1260 Z1261 Z1262 Z1263 Z1264 Z1265 Z1266 Z1267 Z1268 Z1269 Z1270 Z1271 Z1272 Z1273 Z1274 Z1275 Z1276 Z1277 Z1278 Z1279 Z1280 Z1281 Z1282 Z1283 Z1284 Z1285 Z1286 Z1287 Z1288 Z1289 Z1290 Z1291 Z1292 Z1293 Z1294 Z1295 Z1296 Z1297 Z1298 Z1299 Z1300  real
% syms Z1301 Z1302 Z1303 Z1304 Z1305 Z1306 Z1307 Z1308 Z1309 Z1310 Z1311 Z1312 Z1313 Z1314 Z1315 Z1316 Z1317 Z1318 Z1319 Z1320 Z1321 Z1322 Z1323 Z1324 Z1325 Z1326 Z1327 Z1328 Z1329 Z1330 Z1331 Z1332 Z1333 Z1334 Z1335 Z1336 Z1337 Z1338 Z1339 Z1340 Z1341 Z1342 Z1343 Z1344 Z1345 Z1346 Z1347 Z1348 Z1349 Z1350  real
% syms Z1351 Z1352 Z1353 Z1354 Z1355 Z1356 Z1357 Z1358 Z1359 Z1360 Z1361 Z1362 Z1363 Z1364 Z1365 Z1366 Z1367 Z1368 Z1369 Z1370 Z1371 Z1372 Z1373 Z1374 Z1375 Z1376 Z1377 Z1378 Z1379 Z1380 Z1381 Z1382 Z1383 Z1384 Z1385 Z1386 Z1387 Z1388 Z1389 Z1390 Z1391 Z1392 Z1393 Z1394 Z1395 Z1396 Z1397 Z1398 Z1399 Z1400  real
% syms Z1401 Z1402 Z1403 Z1404 Z1405 Z1406 Z1407 Z1408 Z1409 Z1410 Z1411 Z1412 Z1413 Z1414 Z1415 Z1416 Z1417 Z1418 Z1419 Z1420 Z1421 Z1422 Z1423 Z1424 Z1425 Z1426 Z1427 Z1428 Z1429 Z1430 Z1431 Z1432 Z1433 Z1434 Z1435 Z1436 Z1437 Z1438 Z1439 Z1440 Z1441 Z1442 Z1443 Z1444 Z1445 Z1446 Z1447 Z1448 Z1449 Z1450  real
% syms Z1451 Z1452 Z1453 Z1454 Z1455 Z1456 Z1457 Z1458 Z1459 Z1460 Z1461 Z1462 Z1463 Z1464 Z1465 Z1466 Z1467 Z1468 Z1469 Z1470 Z1471 Z1472 Z1473 Z1474 Z1475 Z1476 Z1477 Z1478 Z1479 Z1480 Z1481 Z1482 Z1483 Z1484 Z1485 Z1486 Z1487 Z1488 Z1489 Z1490 Z1491 Z1492 Z1493 Z1494 Z1495 Z1496 Z1497 Z1498 Z1499 Z1500  real
% syms Z1501 Z1502 Z1503 Z1504 Z1505 Z1506 Z1507 Z1508 Z1509 Z1510 Z1511 Z1512 Z1513 Z1514 Z1515 Z1516 Z1517 Z1518 Z1519 Z1520 Z1521  real
% 
% maG1 = [Z623*ddpsi+Z624;
%     Z625*ddx+Z626*ddpsi+Z627*ddq_imu+Z628;
%     Z629*ddx+Z630*ddpsi+Z631*ddq_imu+Z632];
% 
% dHnew1 = [Z633*ddx+Z634*ddpsi+Z635*ddq_imu+Z636;
%     Z637*ddx+Z638*ddpsi+Z639*ddq_imu+Z640;
%     Z641*ddx+Z642*ddpsi+Z643*ddq_imu+Z644];
% 
% maG2 = [Z645*ddpsi+Z646;
%     Z647*ddx+Z648*ddpsi+Z649*ddq_imu+Z650*ddq_w+Z651;
%     Z652*ddx+Z653*ddpsi+Z654*ddq_imu+Z655*ddq_w+Z656];
% 
% dHnew2 = [Z657*ddx+Z658*ddpsi+Z659*ddq_imu+Z660*ddq_w+Z661;
%     Z662*ddx+Z663*ddpsi+Z664*ddq_imu+Z665*ddq_w+Z666;
%     Z667*ddx+Z668*ddpsi+Z669*ddq_imu+Z670*ddq_w+Z671];
% 
% maG3 = [Z672*ddx+Z673*ddpsi+Z674*ddq_imu+Z675*ddq_w+Z676*ddq_torso+Z677;
%     Z678*ddx+Z679*ddpsi+Z680*ddq_imu+Z681*ddq_w+Z682;
%     Z683*ddx+Z684*ddpsi+Z685*ddq_imu+Z686*ddq_w+Z687*ddq_torso+Z688];
% 
% dHnew3 = [Z689*ddx+Z690*ddpsi+Z691*ddq_imu+Z692*ddq_w+Z693*ddq_torso+Z694;
%     Z695*ddx+Z696*ddpsi+Z697*ddq_imu+Z698*ddq_w+Z699*ddq_torso+Z700;
%     Z701*ddx+Z702*ddpsi+Z703*ddq_imu+Z704*ddq_w+Z705*ddq_torso+Z706];
% 
% maG4l = [Z707*ddx+Z708*ddpsi+Z709*ddq_imu+Z710*ddq_w+Z711*ddq_torso+Z712*ddq_1l+Z713;
%     Z714*ddx+Z715*ddpsi+Z716*ddq_imu+Z717*ddq_w+Z718*ddq_torso+Z719;
%     Z720*ddx+Z721*ddpsi+Z722*ddq_imu+Z723*ddq_w+Z724*ddq_torso+Z725*ddq_1l+Z726];
% 
% dHnew4l = [Z727*ddx+Z728*ddpsi+Z729*ddq_imu+Z730*ddq_w+Z731*ddq_torso+Z732*ddq_1l+Z733;
%     Z734*ddx+Z735*ddpsi+Z736*ddq_imu+Z737*ddq_w+Z738*ddq_torso+Z739*ddq_1l+Z740;
%     Z741*ddx+Z742*ddpsi+Z743*ddq_imu+Z744*ddq_w+Z745*ddq_torso+Z746*ddq_1l+Z747];
% 
% maG5l = [Z748*ddx+Z749*ddpsi+Z750*ddq_imu+Z751*ddq_w+Z752*ddq_torso+Z753*ddq_1l+Z754;
%     Z755*ddx+Z756*ddpsi+Z757*ddq_imu+Z758*ddq_w+Z759*ddq_torso+Z760*ddq_1l+Z761*ddq_2l+Z762;
%     Z763*ddx+Z764*ddpsi+Z765*ddq_imu+Z766*ddq_w+Z767*ddq_torso+Z768*ddq_1l+Z769*ddq_2l+Z770];
% 
% dHnew5l = [Z771*ddx+Z772*ddpsi+Z773*ddq_imu+Z774*ddq_w+Z775*ddq_torso+Z776*ddq_1l+Z777*ddq_2l+Z778;
%     Z779*ddx+Z780*ddpsi+Z781*ddq_imu+Z782*ddq_w+Z783*ddq_torso+Z784*ddq_1l+Z785*ddq_2l+Z786;
%     Z787*ddx+Z788*ddpsi+Z789*ddq_imu+Z790*ddq_w+Z791*ddq_torso+Z792*ddq_1l+Z793*ddq_2l+Z794];
% 
% maG6l = [Z795*ddx+Z796*ddpsi+Z797*ddq_imu+Z798*ddq_w+Z799*ddq_torso+Z800*ddq_1l+Z801*ddq_2l+Z802*ddq_3l+Z803;
%     Z804*ddx+Z805*ddpsi+Z806*ddq_imu+Z807*ddq_w+Z808*ddq_torso+Z809*ddq_1l+Z810*ddq_2l+Z811;
%     Z812*ddx+Z813*ddpsi+Z814*ddq_imu+Z815*ddq_w+Z816*ddq_torso+Z817*ddq_1l+Z818*ddq_2l+Z819*ddq_3l+Z820];
% 
% dHnew6l = [Z821*ddx+Z822*ddpsi+Z823*ddq_imu+Z824*ddq_w+Z825*ddq_torso+Z826*ddq_1l+Z827*ddq_2l+Z828*ddq_3l+Z829;
%     Z830*ddx+Z831*ddpsi+Z832*ddq_imu+Z833*ddq_w+Z834*ddq_torso+Z835*ddq_1l+Z836*ddq_2l+Z837*ddq_3l+Z838;
%     Z839*ddx+Z840*ddpsi+Z841*ddq_imu+Z842*ddq_w+Z843*ddq_torso+Z844*ddq_1l+Z845*ddq_2l+Z846*ddq_3l+Z847];
% 
% maG7l = [Z848*ddx+Z849*ddpsi+Z850*ddq_imu+Z851*ddq_w+Z852*ddq_torso+Z853*ddq_1l+Z854*ddq_2l+Z855*ddq_3l+Z856;
%     Z857*ddx+Z858*ddpsi+Z859*ddq_imu+Z860*ddq_w+Z861*ddq_torso+Z862*ddq_1l+Z863*ddq_2l+Z864*ddq_3l+Z865*ddq_4l+Z866;
%     Z867*ddx+Z868*ddpsi+Z869*ddq_imu+Z870*ddq_w+Z871*ddq_torso+Z872*ddq_1l+Z873*ddq_2l+Z874*ddq_3l+Z875*ddq_4l+Z876];
% 
% dHnew7l = [Z877*ddx+Z878*ddpsi+Z879*ddq_imu+Z880*ddq_w+Z881*ddq_torso+Z882*ddq_1l+Z883*ddq_2l+Z884*ddq_3l+Z885*ddq_4l+Z886;
%     Z887*ddx+Z888*ddpsi+Z889*ddq_imu+Z890*ddq_w+Z891*ddq_torso+Z892*ddq_1l+Z893*ddq_2l+Z894*ddq_3l+Z895*ddq_4l+Z896;
%     Z897*ddx+Z898*ddpsi+Z899*ddq_imu+Z900*ddq_w+Z901*ddq_torso+Z902*ddq_1l+Z903*ddq_2l+Z904*ddq_3l+Z905*ddq_4l+Z906];
% 
% maG8l = [Z907*ddx+Z908*ddpsi+Z909*ddq_imu+Z910*ddq_w+Z911*ddq_torso+Z912*ddq_1l+Z913*ddq_2l+Z914*ddq_3l+Z915*ddq_4l+Z916*ddq_5l+Z917;
%     Z918*ddx+Z919*ddpsi+Z920*ddq_imu+Z921*ddq_w+Z922*ddq_torso+Z923*ddq_1l+Z924*ddq_2l+Z925*ddq_3l+Z926*ddq_4l+Z927;
%     Z928*ddx+Z929*ddpsi+Z930*ddq_imu+Z931*ddq_w+Z932*ddq_torso+Z933*ddq_1l+Z934*ddq_2l+Z935*ddq_3l+Z936*ddq_4l+Z937*ddq_5l+Z938];
% 
% dHnew8l = [Z939*ddx+Z940*ddpsi+Z941*ddq_imu+Z942*ddq_w+Z943*ddq_torso+Z944*ddq_1l+Z945*ddq_2l+Z946*ddq_3l+Z947*ddq_4l+Z948*ddq_5l+Z949;
%     Z950*ddx+Z951*ddpsi+Z952*ddq_imu+Z953*ddq_w+Z954*ddq_torso+Z955*ddq_1l+Z956*ddq_2l+Z957*ddq_3l+Z958*ddq_4l+Z959*ddq_5l+Z960;
%     Z961*ddx+Z962*ddpsi+Z963*ddq_imu+Z964*ddq_w+Z965*ddq_torso+Z966*ddq_1l+Z967*ddq_2l+Z968*ddq_3l+Z969*ddq_4l+Z970*ddq_5l+Z971];
% 
% maG9l = [Z972*ddx+Z973*ddpsi+Z974*ddq_imu+Z975*ddq_w+Z976*ddq_torso+Z977*ddq_1l+Z978*ddq_2l+Z979*ddq_3l+Z980*ddq_4l+Z981*ddq_5l+Z982;
%     Z983*ddx+Z984*ddpsi+Z985*ddq_imu+Z986*ddq_w+Z987*ddq_torso+Z988*ddq_1l+Z989*ddq_2l+Z990*ddq_3l+Z991*ddq_4l+Z992*ddq_5l+Z993*ddq_6l+Z994;
%     Z995*ddx+Z996*ddpsi+Z997*ddq_imu+Z998*ddq_w+Z999*ddq_torso+Z1000*ddq_1l+Z1001*ddq_2l+Z1002*ddq_3l+Z1003*ddq_4l+Z1004*ddq_5l+Z1005*ddq_6l+Z1006];
% 
% dHnew9l = [Z1007*ddx+Z1008*ddpsi+Z1009*ddq_imu+Z1010*ddq_w+Z1011*ddq_torso+Z1012*ddq_1l+Z1013*ddq_2l+Z1014*ddq_3l+Z1015*ddq_4l+Z1016*ddq_5l+Z1017*ddq_6l+Z1018;
%     Z1019*ddx+Z1020*ddpsi+Z1021*ddq_imu+Z1022*ddq_w+Z1023*ddq_torso+Z1024*ddq_1l+Z1025*ddq_2l+Z1026*ddq_3l+Z1027*ddq_4l+Z1028*ddq_5l+Z1029*ddq_6l+Z1030;
%     Z1031*ddx+Z1032*ddpsi+Z1033*ddq_imu+Z1034*ddq_w+Z1035*ddq_torso+Z1036*ddq_1l+Z1037*ddq_2l+Z1038*ddq_3l+Z1039*ddq_4l+Z1040*ddq_5l+Z1041*ddq_6l+Z1042];
% 
% maG10l = [Z1043*ddx+Z1044*ddpsi+Z1045*ddq_imu+Z1046*ddq_w+Z1047*ddq_torso+Z1048*ddq_1l+Z1049*ddq_2l+Z1050*ddq_3l+Z1051*ddq_4l+Z1052*ddq_5l+Z1053*ddq_6l+Z1054*ddq_7l+Z1055;
%     Z1056*ddx+Z1057*ddpsi+Z1058*ddq_imu+Z1059*ddq_w+Z1060*ddq_torso+Z1061*ddq_1l+Z1062*ddq_2l+Z1063*ddq_3l+Z1064*ddq_4l+Z1065*ddq_5l+Z1066*ddq_6l+Z1067*ddq_7l+Z1068;
%     Z1069*ddx+Z1070*ddpsi+Z1071*ddq_imu+Z1072*ddq_w+Z1073*ddq_torso+Z1074*ddq_1l+Z1075*ddq_2l+Z1076*ddq_3l+Z1077*ddq_4l+Z1078*ddq_5l+Z1079*ddq_6l+Z1080];
% 
% dHnew10l = [Z1081*ddx+Z1082*ddpsi+Z1083*ddq_imu+Z1084*ddq_w+Z1085*ddq_torso+Z1086*ddq_1l+Z1087*ddq_2l+Z1088*ddq_3l+Z1089*ddq_4l+Z1090*ddq_5l+Z1091*ddq_6l+Z1092*ddq_7l+Z1093;
%     Z1094*ddx+Z1095*ddpsi+Z1096*ddq_imu+Z1097*ddq_w+Z1098*ddq_torso+Z1099*ddq_1l+Z1100*ddq_2l+Z1101*ddq_3l+Z1102*ddq_4l+Z1103*ddq_5l+Z1104*ddq_6l+Z1105*ddq_7l+Z1106;
%     Z1107*ddx+Z1108*ddpsi+Z1109*ddq_imu+Z1110*ddq_w+Z1111*ddq_torso+Z1112*ddq_1l+Z1113*ddq_2l+Z1114*ddq_3l+Z1115*ddq_4l+Z1116*ddq_5l+Z1117*ddq_6l+Z1118*ddq_7l+Z1119];
% 
% maG4r = [Z1120*ddx+Z1121*ddpsi+Z1122*ddq_imu+Z1123*ddq_w+Z1124*ddq_torso+Z1125*ddq_1r+Z1126;
%     Z1127*ddx+Z1128*ddpsi+Z1129*ddq_imu+Z1130*ddq_w+Z1131*ddq_torso+Z1132;
%     Z1133*ddx+Z1134*ddpsi+Z1135*ddq_imu+Z1136*ddq_w+Z1137*ddq_torso+Z1138*ddq_1r+Z1139];
% 
% dHnew4r = [Z1140*ddx+Z1141*ddpsi+Z1142*ddq_imu+Z1143*ddq_w+Z1144*ddq_torso+Z1145*ddq_1r+Z1146;
%     Z1147*ddx+Z1148*ddpsi+Z1149*ddq_imu+Z1150*ddq_w+Z1151*ddq_torso+Z1152*ddq_1r+Z1153;
%     Z1154*ddx+Z1155*ddpsi+Z1156*ddq_imu+Z1157*ddq_w+Z1158*ddq_torso+Z1159*ddq_1r+Z1160];
% 
% maG5r = [Z1161*ddx+Z1162*ddpsi+Z1163*ddq_imu+Z1164*ddq_w+Z1165*ddq_torso+Z1166;
%     Z1167*ddx+Z1168*ddpsi+Z1169*ddq_imu+Z1170*ddq_w+Z1171*ddq_torso+Z1172;
%     Z1173*ddx+Z1174*ddpsi+Z1175*ddq_imu+Z1176*ddq_w+Z1177*ddq_torso+Z1178];
% 
% dHnew5r = [Z1179*ddx+Z1180*ddpsi+Z1181*ddq_imu+Z1182*ddq_w+Z1183*ddq_torso+Z1184;
%     Z1185*ddx+Z1186*ddpsi+Z1187*ddq_imu+Z1188*ddq_w+Z1189*ddq_torso+Z1190;
%     Z1191*ddx+Z1192*ddpsi+Z1193*ddq_imu+Z1194*ddq_w+Z1195*ddq_torso+Z1196];
% 
% maG6r = [Z1197*ddx+Z1198*ddpsi+Z1199*ddq_imu+Z1200*ddq_w+Z1201*ddq_torso+Z1202*ddq_1r+Z1203*ddq_2r+Z1204*ddq_3r+Z1205;
%     Z1206*ddx+Z1207*ddpsi+Z1208*ddq_imu+Z1209*ddq_w+Z1210*ddq_torso+Z1211*ddq_1r+Z1212*ddq_2r+Z1213;
%     Z1214*ddx+Z1215*ddpsi+Z1216*ddq_imu+Z1217*ddq_w+Z1218*ddq_torso+Z1219*ddq_1r+Z1220*ddq_2r+Z1221*ddq_3r+Z1222];
% 
% dHnew6r = [Z1223*ddx+Z1224*ddpsi+Z1225*ddq_imu+Z1226*ddq_w+Z1227*ddq_torso+Z1228*ddq_1r+Z1229*ddq_2r+Z1230*ddq_3r+Z1231;
%     Z1232*ddx+Z1233*ddpsi+Z1234*ddq_imu+Z1235*ddq_w+Z1236*ddq_torso+Z1237*ddq_1r+Z1238*ddq_2r+Z1239*ddq_3r+Z1240;
%     Z1241*ddx+Z1242*ddpsi+Z1243*ddq_imu+Z1244*ddq_w+Z1245*ddq_torso+Z1246*ddq_1r+Z1247*ddq_2r+Z1248*ddq_3r+Z1249];
% 
% maG7r = [Z1250*ddx+Z1251*ddpsi+Z1252*ddq_imu+Z1253*ddq_w+Z1254*ddq_torso+Z1255*ddq_1r+Z1256*ddq_2r+Z1257*ddq_3r+Z1258;
%     Z1259*ddx+Z1260*ddpsi+Z1261*ddq_imu+Z1262*ddq_w+Z1263*ddq_torso+Z1264*ddq_1r+Z1265*ddq_2r+Z1266*ddq_3r+Z1267*ddq_4r+Z1268;
%     Z1269*ddx+Z1270*ddpsi+Z1271*ddq_imu+Z1272*ddq_w+Z1273*ddq_torso+Z1274*ddq_1r+Z1275*ddq_2r+Z1276*ddq_3r+Z1277*ddq_4r+Z1278];
% 
% dHnew7r = [Z1279*ddx+Z1280*ddpsi+Z1281*ddq_imu+Z1282*ddq_w+Z1283*ddq_torso+Z1284*ddq_1r+Z1285*ddq_2r+Z1286*ddq_3r+Z1287*ddq_4r+Z1288;
%     Z1289*ddx+Z1290*ddpsi+Z1291*ddq_imu+Z1292*ddq_w+Z1293*ddq_torso+Z1294*ddq_1r+Z1295*ddq_2r+Z1296*ddq_3r+Z1297*ddq_4r+Z1298;
%     Z1299*ddx+Z1300*ddpsi+Z1301*ddq_imu+Z1302*ddq_w+Z1303*ddq_torso+Z1304*ddq_1r+Z1305*ddq_2r+Z1306*ddq_3r+Z1307*ddq_4r+Z1308];
% 
% maG8r = [Z1309*ddx+Z1310*ddpsi+Z1311*ddq_imu+Z1312*ddq_w+Z1313*ddq_torso+Z1314*ddq_1r+Z1315*ddq_2r+Z1316*ddq_3r+Z1317*ddq_4r+Z1318*ddq_5r+Z1319;
%     Z1320*ddx+Z1321*ddpsi+Z1322*ddq_imu+Z1323*ddq_w+Z1324*ddq_torso+Z1325*ddq_1r+Z1326*ddq_2r+Z1327*ddq_3r+Z1328*ddq_4r+Z1329;
%     Z1330*ddx+Z1331*ddpsi+Z1332*ddq_imu+Z1333*ddq_w+Z1334*ddq_torso+Z1335*ddq_1r+Z1336*ddq_2r+Z1337*ddq_3r+Z1338*ddq_4r+Z1339*ddq_5r+Z1340];
% 
% dHnew8r = [Z1341*ddx+Z1342*ddpsi+Z1343*ddq_imu+Z1344*ddq_w+Z1345*ddq_torso+Z1346*ddq_1r+Z1347*ddq_2r+Z1348*ddq_3r+Z1349*ddq_4r+Z1350*ddq_5r+Z1351;
%     Z1352*ddx+Z1353*ddpsi+Z1354*ddq_imu+Z1355*ddq_w+Z1356*ddq_torso+Z1357*ddq_1r+Z1358*ddq_2r+Z1359*ddq_3r+Z1360*ddq_4r+Z1361*ddq_5r+Z1362;
%     Z1363*ddx+Z1364*ddpsi+Z1365*ddq_imu+Z1366*ddq_w+Z1367*ddq_torso+Z1368*ddq_1r+Z1369*ddq_2r+Z1370*ddq_3r+Z1371*ddq_4r+Z1372*ddq_5r+Z1373];
% 
% maG9r = [Z1374*ddx+Z1375*ddpsi+Z1376*ddq_imu+Z1377*ddq_w+Z1378*ddq_torso+Z1379*ddq_1r+Z1380*ddq_2r+Z1381*ddq_3r+Z1382*ddq_4r+Z1383*ddq_5r+Z1384;
%     Z1385*ddx+Z1386*ddpsi+Z1387*ddq_imu+Z1388*ddq_w+Z1389*ddq_torso+Z1390*ddq_1r+Z1391*ddq_2r+Z1392*ddq_3r+Z1393*ddq_4r+Z1394*ddq_5r+Z1395*ddq_6r+Z1396;
%     Z1397*ddx+Z1398*ddpsi+Z1399*ddq_imu+Z1400*ddq_w+Z1401*ddq_torso+Z1402*ddq_1r+Z1403*ddq_2r+Z1404*ddq_3r+Z1405*ddq_4r+Z1406*ddq_5r+Z1407*ddq_6r+Z1408];
% 
% dHnew9r = [Z1409*ddx+Z1410*ddpsi+Z1411*ddq_imu+Z1412*ddq_w+Z1413*ddq_torso+Z1414*ddq_1r+Z1415*ddq_2r+Z1416*ddq_3r+Z1417*ddq_4r+Z1418*ddq_5r+Z1419*ddq_6r+Z1420;
%     Z1421*ddx+Z1422*ddpsi+Z1423*ddq_imu+Z1424*ddq_w+Z1425*ddq_torso+Z1426*ddq_1r+Z1427*ddq_2r+Z1428*ddq_3r+Z1429*ddq_4r+Z1430*ddq_5r+Z1431*ddq_6r+Z1432;
%     Z1433*ddx+Z1434*ddpsi+Z1435*ddq_imu+Z1436*ddq_w+Z1437*ddq_torso+Z1438*ddq_1r+Z1439*ddq_2r+Z1440*ddq_3r+Z1441*ddq_4r+Z1442*ddq_5r+Z1443*ddq_6r+Z1444];
% 
% maG10r = [Z1445*ddx+Z1446*ddpsi+Z1447*ddq_imu+Z1448*ddq_w+Z1449*ddq_torso+Z1450*ddq_1r+Z1451*ddq_2r+Z1452*ddq_3r+Z1453*ddq_4r+Z1454*ddq_5r+Z1455*ddq_6r+Z1456*ddq_7r+Z1457;
%     Z1458*ddx+Z1459*ddpsi+Z1460*ddq_imu+Z1461*ddq_w+Z1462*ddq_torso+Z1463*ddq_1r+Z1464*ddq_2r+Z1465*ddq_3r+Z1466*ddq_4r+Z1467*ddq_5r+Z1468*ddq_6r+Z1469*ddq_7r+Z1470;
%     Z1471*ddx+Z1472*ddpsi+Z1473*ddq_imu+Z1474*ddq_w+Z1475*ddq_torso+Z1476*ddq_1r+Z1477*ddq_2r+Z1478*ddq_3r+Z1479*ddq_4r+Z1480*ddq_5r+Z1481*ddq_6r+Z1482];
% 
% dHnew10r = [Z1483*ddx+Z1484*ddpsi+Z1485*ddq_imu+Z1486*ddq_w+Z1487*ddq_torso+Z1488*ddq_1r+Z1489*ddq_2r+Z1490*ddq_3r+Z1491*ddq_4r+Z1492*ddq_5r+Z1493*ddq_6r+Z1494*ddq_7r+Z1495;
%     Z1496*ddx+Z1497*ddpsi+Z1498*ddq_imu+Z1499*ddq_w+Z1500*ddq_torso+Z1501*ddq_1r+Z1502*ddq_2r+Z1503*ddq_3r+Z1504*ddq_4r+Z1505*ddq_5r+Z1506*ddq_6r+Z1507*ddq_7r+Z1508;
%     Z1509*ddx+Z1510*ddpsi+Z1511*ddq_imu+Z1512*ddq_w+Z1513*ddq_torso+Z1514*ddq_1r+Z1515*ddq_2r+Z1516*ddq_3r+Z1517*ddq_4r+Z1518*ddq_5r+Z1519*ddq_6r+Z1520*ddq_7r+Z1521];
% 
% %% LHS terms
% % keysEq = {'x', 'psi', 'imu', 'w', 'torso', '4l', '5l', '6l', '7l', '8l', '9l', '10l', ...
% %      '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% % keysBody = {'L', 'R', '1', '2', '3', '4l', '5l', '6l', '7l', '8l', '9l', '10l', ...
% %      '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% % maGG = {maGL, maGR, maG1, maG2, maG3, maG4l, maG5l, maG6l, maG7l, maG8l, maG9l, maG10l, ...
% %     maG4r, maG5r, maG6r, maG7r, maG8r, maG9r, maG10r};
% % dvv = {dvL, dvR, dv1, dv2, dv3, dv4l, dv5l, dv6l, dv7l, dv8l, dv9l, dv10l, ...
% %     dv4r, dv5r, dv6r, dv7r, dv8r, dv9r, dv10r};
% % dHH = {dHGL, dHGR, dHnew1, dHnew2, dHnew3, dHnew4l, dHnew5l, dHnew6l, dHnew7l, dHnew8l, dHnew9l, dHnew10l, ...
% %     dHnew4r, dHnew5r, dHnew6r, dHnew7r, dHnew8r, dHnew9r, dHnew10r};
% % dww = {dwL, dwR, dw1, dw2, dw3, dw4l, dw5l, dw6l, dw7l, dw8l, dw9l, dw10l, ...
% %     dw4r, dw5r, dw6r, dw7r, dw8r, dw9r, dw10r};
% % ddq = ddqVec(f);
% % n = 1521;
% % fid = fopen('LHSout.m', 'w');
% % for i=1:19
% %     thisEq = keysEq{i};
% %     for j=1:19
% %         thisBody = keysBody{j};
% %         LHSTerm = collect(maGG{j}'*dvv{j}(:,i) + dHH{j}'*dww{j}(:,i),[ddx,ddpsi,ddq_imu,ddq_w,ddq_1l,ddq_2l,ddq_3l,ddq_4l,ddq_5l,ddq_6l,ddq_7l,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r]);
% %         display(['% LHS_' thisBody '_' thisEq ' = ']); display('%'); display(['%      ' char(LHSTerm)]);
% %         if(~isequal(LHSTerm,0))
% %             LHSTermRem = LHSTerm; str = []; op = [];
% %             for k = 1:length(ddq)
% %                 Z = diff(LHSTerm,ddq(k));
% %                 if(~isequal(Z,0))
% %                     if(length(symvar(Z)) == 1)
% %                         charZ = char(Z);
% %                         if(charZ(1) == '-') op = []; end
% %                         str = [str op char(Z) '*' char(ddq(k))]; op ='+';
% %                     else
% %                         n = n + 1;
% %                         display(['Z' num2str(n) ' = ' char(Z) ';']);
% %                         str = [str op 'Z' num2str(n) '*' char(ddq(k))]; op ='+';
% %                     end
% %                     LHSTermRem = simplify(LHSTermRem - Z*ddq(k));
% %                 end
% %             end
% %             if(~isequal(LHSTermRem,0))
% %                 if(length(symvar(LHSTermRem)) == 1)
% %                     charZ = char(Z);
% %                     if(charZ(1) == '-') op = []; end
% %                     str = [str op char(LHSTermRem)];
% %                 else
% %                     n = n + 1;
% %                     display(['Z' num2str(n) ' = ' char(LHSTermRem) ';']); display(' ');
% %                     str = [str op 'Z' num2str(n)];
% %                 end
% %             end
% %             strFull = ['LHS_' thisBody '_' thisEq ' = ' str ';']; 
% %             disp(strFull); display(' ');
% %             fprintf(fid,'%s\n\n',strFull);
% %         else
% %             fprintf(fid,'%s\n\n',['LHS_' thisBody '_' thisEq ' = 0;']); 
% %         end
% %     end
% % end
% % fclose(fid);
% 
% syms Z1522 Z1523 Z1524 Z1525 Z1526 Z1527 Z1528 Z1529 Z1530 Z1531 Z1532 Z1533 Z1534 Z1535 Z1536 Z1537 Z1538 Z1539 Z1540 Z1541 Z1542 Z1543 Z1544 Z1545 Z1546 Z1547 Z1548 Z1549 Z1550 Z1551 Z1552 Z1553 Z1554 Z1555 Z1556 Z1557 Z1558 Z1559 Z1560 Z1561 Z1562 Z1563 Z1564 Z1565 Z1566 Z1567 Z1568 Z1569 Z1570 Z1571  real
% syms Z1572 Z1573 Z1574 Z1575 Z1576 Z1577 Z1578 Z1579 Z1580 Z1581 Z1582 Z1583 Z1584 Z1585 Z1586 Z1587 Z1588 Z1589 Z1590 Z1591 Z1592 Z1593 Z1594 Z1595 Z1596 Z1597 Z1598 Z1599 Z1600 Z1601 Z1602 Z1603 Z1604 Z1605 Z1606 Z1607 Z1608 Z1609 Z1610 Z1611 Z1612 Z1613 Z1614 Z1615 Z1616 Z1617 Z1618 Z1619 Z1620 Z1621  real
% syms Z1622 Z1623 Z1624 Z1625 Z1626 Z1627 Z1628 Z1629 Z1630 Z1631 Z1632 Z1633 Z1634 Z1635 Z1636 Z1637 Z1638 Z1639 Z1640 Z1641 Z1642 Z1643 Z1644 Z1645 Z1646 Z1647 Z1648 Z1649 Z1650 Z1651 Z1652 Z1653 Z1654 Z1655 Z1656 Z1657 Z1658 Z1659 Z1660 Z1661 Z1662 Z1663 Z1664 Z1665 Z1666 Z1667 Z1668 Z1669 Z1670 Z1671  real
% syms Z1672 Z1673 Z1674 Z1675 Z1676 Z1677 Z1678 Z1679 Z1680 Z1681 Z1682 Z1683 Z1684 Z1685 Z1686 Z1687 Z1688 Z1689 Z1690 Z1691 Z1692 Z1693 Z1694 Z1695 Z1696 Z1697 Z1698 Z1699 Z1700 Z1701 Z1702 Z1703 Z1704 Z1705 Z1706 Z1707 Z1708 Z1709 Z1710 Z1711 Z1712 Z1713 Z1714 Z1715 Z1716 Z1717 Z1718 Z1719 Z1720 Z1721  real
% syms Z1722 Z1723 Z1724 Z1725 Z1726 Z1727 Z1728 Z1729 Z1730 Z1731 Z1732 Z1733 Z1734 Z1735 Z1736 Z1737 Z1738 Z1739 Z1740 Z1741 Z1742 Z1743 Z1744 Z1745 Z1746 Z1747 Z1748 Z1749 Z1750 Z1751 Z1752 Z1753 Z1754 Z1755 Z1756 Z1757 Z1758 Z1759 Z1760 Z1761 Z1762 Z1763 Z1764 Z1765 Z1766 Z1767 Z1768 Z1769 Z1770 Z1771  real
% syms Z1772 Z1773 Z1774 Z1775 Z1776 Z1777 Z1778 Z1779 Z1780 Z1781 Z1782 Z1783 Z1784 Z1785 Z1786 Z1787 Z1788 Z1789 Z1790 Z1791 Z1792 Z1793 Z1794 Z1795 Z1796 Z1797 Z1798 Z1799 Z1800 Z1801 Z1802 Z1803 Z1804 Z1805 Z1806 Z1807 Z1808 Z1809 Z1810 Z1811 Z1812 Z1813 Z1814 Z1815 Z1816 Z1817 Z1818 Z1819 Z1820 Z1821  real
% syms Z1822 Z1823 Z1824 Z1825 Z1826 Z1827 Z1828 Z1829 Z1830 Z1831 Z1832 Z1833 Z1834 Z1835 Z1836 Z1837 Z1838 Z1839 Z1840 Z1841 Z1842 Z1843 Z1844 Z1845 Z1846 Z1847 Z1848 Z1849 Z1850 Z1851 Z1852 Z1853 Z1854 Z1855 Z1856 Z1857 Z1858 Z1859 Z1860 Z1861 Z1862 Z1863 Z1864 Z1865 Z1866 Z1867 Z1868 Z1869 Z1870 Z1871  real
% syms Z1872 Z1873 Z1874 Z1875 Z1876 Z1877 Z1878 Z1879 Z1880 Z1881 Z1882 Z1883 Z1884 Z1885 Z1886 Z1887 Z1888 Z1889 Z1890 Z1891 Z1892 Z1893 Z1894 Z1895 Z1896 Z1897 Z1898 Z1899 Z1900 Z1901 Z1902 Z1903 Z1904 Z1905 Z1906 Z1907 Z1908 Z1909 Z1910 Z1911 Z1912 Z1913 Z1914 Z1915 Z1916 Z1917 Z1918 Z1919 Z1920 Z1921  real
% syms Z1922 Z1923 Z1924 Z1925 Z1926 Z1927 Z1928 Z1929 Z1930 Z1931 Z1932 Z1933 Z1934 Z1935 Z1936 Z1937 Z1938 Z1939 Z1940 Z1941 Z1942 Z1943 Z1944 Z1945 Z1946 Z1947 Z1948 Z1949 Z1950 Z1951 Z1952 Z1953 Z1954 Z1955 Z1956 Z1957 Z1958 Z1959 Z1960 Z1961 Z1962 Z1963 Z1964 Z1965 Z1966 Z1967 Z1968 Z1969 Z1970 Z1971  real
% syms Z1972 Z1973 Z1974 Z1975 Z1976 Z1977 Z1978 Z1979 Z1980 Z1981 Z1982 Z1983 Z1984 Z1985 Z1986 Z1987 Z1988 Z1989 Z1990 Z1991 Z1992 Z1993 Z1994 Z1995 Z1996 Z1997 Z1998 Z1999 Z2000 Z2001 Z2002 Z2003 Z2004 Z2005 Z2006 Z2007 Z2008 Z2009 Z2010 Z2011 Z2012 Z2013 Z2014 Z2015 Z2016 Z2017 Z2018 Z2019 Z2020 Z2021  real
% syms Z2022 Z2023 Z2024 Z2025 Z2026 Z2027 Z2028 Z2029 Z2030 Z2031 Z2032 Z2033 Z2034 Z2035 Z2036 Z2037 Z2038 Z2039 Z2040 Z2041 Z2042 Z2043 Z2044 Z2045 Z2046 Z2047 Z2048 Z2049 Z2050 Z2051 Z2052 Z2053 Z2054 Z2055 Z2056 Z2057 Z2058 Z2059 Z2060 Z2061 Z2062 Z2063 Z2064 Z2065 Z2066 Z2067 Z2068 Z2069 Z2070 Z2071  real
% syms Z2072 Z2073 Z2074 Z2075 Z2076 Z2077 Z2078 Z2079 Z2080 Z2081 Z2082 Z2083 Z2084 Z2085 Z2086 Z2087 Z2088 Z2089 Z2090 Z2091 Z2092 Z2093 Z2094 Z2095 Z2096 Z2097 Z2098 Z2099 Z2100 Z2101 Z2102 Z2103 Z2104 Z2105 Z2106 Z2107 Z2108 Z2109 Z2110 Z2111 Z2112 Z2113 Z2114 Z2115 Z2116 Z2117 Z2118 Z2119 Z2120 Z2121  real
% syms Z2122 Z2123 Z2124 Z2125 Z2126 Z2127 Z2128 Z2129 Z2130 Z2131 Z2132 Z2133 Z2134 Z2135 Z2136 Z2137 Z2138 Z2139 Z2140 Z2141 Z2142 Z2143 Z2144 Z2145 Z2146 Z2147 Z2148 Z2149 Z2150 Z2151 Z2152 Z2153 Z2154 Z2155 Z2156 Z2157 Z2158 Z2159 Z2160 Z2161 Z2162 Z2163 Z2164 Z2165 Z2166 Z2167 Z2168 Z2169 Z2170 Z2171  real
% syms Z2172 Z2173 Z2174 Z2175 Z2176 Z2177 Z2178 Z2179 Z2180 Z2181 Z2182 Z2183 Z2184 Z2185 Z2186 Z2187 Z2188 Z2189 Z2190 Z2191 Z2192 Z2193 Z2194 Z2195 Z2196 Z2197 Z2198 Z2199 Z2200 Z2201 Z2202 Z2203 Z2204 Z2205 Z2206 Z2207 Z2208 Z2209 Z2210 Z2211 Z2212 Z2213 Z2214 Z2215 Z2216 Z2217 Z2218 Z2219 Z2220 Z2221  real
% syms Z2222 Z2223 Z2224 Z2225 Z2226 Z2227 Z2228 Z2229 Z2230 Z2231 Z2232 Z2233 Z2234 Z2235 Z2236 Z2237 Z2238 Z2239 Z2240 Z2241 Z2242 Z2243 Z2244 Z2245 Z2246 Z2247 Z2248 Z2249 Z2250 Z2251 Z2252 Z2253 Z2254 Z2255 Z2256 Z2257 Z2258 Z2259 Z2260 Z2261 Z2262 Z2263 Z2264 Z2265 Z2266 Z2267 Z2268 Z2269 Z2270 Z2271  real
% syms Z2272 Z2273 Z2274 Z2275 Z2276 Z2277 Z2278 Z2279 Z2280 Z2281 Z2282 Z2283 Z2284 Z2285 Z2286 Z2287 Z2288 Z2289 Z2290 Z2291 Z2292 Z2293 Z2294 Z2295 Z2296 Z2297 Z2298 Z2299 Z2300 Z2301 Z2302 Z2303 Z2304 Z2305 Z2306 Z2307 Z2308 Z2309 Z2310 Z2311 Z2312 Z2313 Z2314 Z2315 Z2316 Z2317 Z2318 Z2319 Z2320 Z2321  real
% syms Z2322 Z2323 Z2324 Z2325 Z2326 Z2327 Z2328 Z2329 Z2330 Z2331 Z2332 Z2333 Z2334 Z2335 Z2336 Z2337 Z2338 Z2339 Z2340 Z2341 Z2342 Z2343 Z2344 Z2345 Z2346 Z2347 Z2348 Z2349 Z2350 Z2351 Z2352 Z2353 Z2354 Z2355 Z2356 Z2357 Z2358 Z2359 Z2360 Z2361 Z2362 Z2363 Z2364 Z2365 Z2366 Z2367 Z2368 Z2369 Z2370 Z2371  real
% syms Z2372 Z2373 Z2374 Z2375 Z2376 Z2377 Z2378 Z2379 Z2380 Z2381 Z2382 Z2383 Z2384 Z2385 Z2386 Z2387 Z2388 Z2389 Z2390 Z2391 Z2392 Z2393 Z2394 Z2395 Z2396 Z2397 Z2398 Z2399 Z2400 Z2401 Z2402 Z2403 Z2404 Z2405 Z2406 Z2407 Z2408 Z2409 Z2410 Z2411 Z2412 Z2413 Z2414 Z2415 Z2416 Z2417 Z2418 Z2419 Z2420 Z2421  real
% syms Z2422 Z2423 Z2424 Z2425 Z2426 Z2427 Z2428 Z2429 Z2430 Z2431 Z2432 Z2433 Z2434 Z2435 Z2436 Z2437 Z2438 Z2439 Z2440 Z2441 Z2442 Z2443 Z2444 Z2445 Z2446 Z2447 Z2448 Z2449 Z2450 Z2451 Z2452 Z2453 Z2454 Z2455 Z2456 Z2457 Z2458 Z2459 Z2460 Z2461 Z2462 Z2463 Z2464 Z2465 Z2466 Z2467 Z2468 Z2469 Z2470 Z2471  real
% syms Z2472 Z2473 Z2474 Z2475 Z2476 Z2477 Z2478 Z2479 Z2480 Z2481 Z2482 Z2483 Z2484 Z2485 Z2486 Z2487 Z2488 Z2489 Z2490 Z2491 Z2492 Z2493 Z2494 Z2495 Z2496 Z2497 Z2498 Z2499 Z2500 Z2501 Z2502 Z2503 Z2504 Z2505 Z2506 Z2507 Z2508 Z2509 Z2510 Z2511 Z2512 Z2513 Z2514 Z2515 Z2516 Z2517 Z2518 Z2519 Z2520 Z2521  real
% syms Z2522 Z2523 Z2524 Z2525 Z2526 Z2527 Z2528 Z2529 Z2530 Z2531 Z2532 Z2533 Z2534 Z2535 Z2536 Z2537 Z2538 Z2539 Z2540 Z2541 Z2542 Z2543 Z2544 Z2545 Z2546 Z2547 Z2548 Z2549 Z2550 Z2551 Z2552 Z2553 Z2554 Z2555 Z2556 Z2557 Z2558 Z2559 Z2560 Z2561 Z2562 Z2563 Z2564 Z2565 Z2566 Z2567 Z2568 Z2569 Z2570 Z2571  real
% syms Z2572 Z2573 Z2574 Z2575 Z2576 Z2577 Z2578 Z2579 Z2580 Z2581 Z2582 Z2583 Z2584 Z2585 Z2586 Z2587 Z2588 Z2589 Z2590 Z2591 Z2592 Z2593 Z2594 Z2595 Z2596 Z2597 Z2598 Z2599 Z2600 Z2601 Z2602 Z2603 Z2604 Z2605 Z2606 Z2607 Z2608 Z2609 Z2610 Z2611 Z2612 Z2613 Z2614 Z2615 Z2616 Z2617 Z2618 Z2619 Z2620 Z2621  real
% syms Z2622 Z2623 Z2624 Z2625 Z2626 Z2627 Z2628 Z2629 Z2630 Z2631 Z2632 Z2633 Z2634 Z2635 Z2636 Z2637 Z2638 Z2639 Z2640 Z2641 Z2642 Z2643 Z2644 Z2645 Z2646 Z2647 Z2648 Z2649 Z2650 Z2651 Z2652 Z2653 Z2654 Z2655 Z2656 Z2657 Z2658 Z2659 Z2660 Z2661 Z2662 Z2663 Z2664 Z2665 Z2666 Z2667 Z2668 Z2669 Z2670 Z2671  real
% syms Z2672 Z2673 Z2674 Z2675 Z2676 Z2677 Z2678 Z2679 Z2680 Z2681 Z2682 Z2683 Z2684 Z2685 Z2686 Z2687 Z2688 Z2689 Z2690 Z2691 Z2692 Z2693 Z2694 Z2695 Z2696 Z2697 Z2698 Z2699 Z2700 Z2701 Z2702 Z2703 Z2704 Z2705 Z2706 Z2707 Z2708 Z2709 Z2710 Z2711 Z2712 Z2713 Z2714 Z2715 Z2716 Z2717 Z2718 Z2719 Z2720 Z2721  real
% syms Z2722 Z2723 Z2724 Z2725 Z2726 Z2727 Z2728 Z2729 Z2730 Z2731 Z2732 Z2733 Z2734 Z2735 Z2736 Z2737 Z2738 Z2739 Z2740 Z2741 Z2742 real
% LHS_L_x = Z1522*ddx+Z1523*ddpsi;
% 
% LHS_R_x = Z1524*ddx+Z1525*ddpsi;
% 
% LHS_1_x = Z1526*ddx+Z1527*ddpsi+Z1528*ddq_imu+Z1529;
% 
% LHS_2_x = Z1530*ddx+Z1531*ddpsi+Z1532*ddq_imu+Z1533*ddq_w+Z1534;
% 
% LHS_3_x = Z1535*ddx+Z1536*ddpsi+Z1537*ddq_imu+Z1538*ddq_w+Z1539*ddq_torso+Z1540;
% 
% LHS_4l_x = Z1541*ddx+Z1542*ddpsi+Z1543*ddq_imu+Z1544*ddq_w+Z1545*ddq_torso+Z1546*ddq_1l+Z1547;
% 
% LHS_5l_x = Z1548*ddx+Z1549*ddpsi+Z1550*ddq_imu+Z1551*ddq_w+Z1552*ddq_torso+Z1553*ddq_1l+Z1554*ddq_2l+Z1555;
% 
% LHS_6l_x = Z1556*ddx+Z1557*ddpsi+Z1558*ddq_imu+Z1559*ddq_w+Z1560*ddq_torso+Z1561*ddq_1l+Z1562*ddq_2l+Z1563*ddq_3l+Z1564;
% 
% LHS_7l_x = Z1565*ddx+Z1566*ddpsi+Z1567*ddq_imu+Z1568*ddq_w+Z1569*ddq_torso+Z1570*ddq_1l+Z1571*ddq_2l+Z1572*ddq_3l+Z1573*ddq_4l+Z1574;
% 
% LHS_8l_x = Z1575*ddx+Z1576*ddpsi+Z1577*ddq_imu+Z1578*ddq_w+Z1579*ddq_torso+Z1580*ddq_1l+Z1581*ddq_2l+Z1582*ddq_3l+Z1583*ddq_4l+Z1584*ddq_5l+Z1585;
% 
% LHS_9l_x = Z1586*ddx+Z1587*ddpsi+Z1588*ddq_imu+Z1589*ddq_w+Z1590*ddq_torso+Z1591*ddq_1l+Z1592*ddq_2l+Z1593*ddq_3l+Z1594*ddq_4l+Z1595*ddq_5l+Z1596*ddq_6l+Z1597;
% 
% LHS_10l_x = Z1598*ddx+Z1599*ddpsi+Z1600*ddq_imu+Z1601*ddq_w+Z1602*ddq_torso+Z1603*ddq_1l+Z1604*ddq_2l+Z1605*ddq_3l+Z1606*ddq_4l+Z1607*ddq_5l+Z1608*ddq_6l+Z1609*ddq_7l+Z1610;
% 
% LHS_4r_x = Z1611*ddx+Z1612*ddpsi+Z1613*ddq_imu+Z1614*ddq_w+Z1615*ddq_torso+Z1616*ddq_1r+Z1617;
% 
% LHS_5r_x = Z1618*ddx+Z1619*ddpsi+Z1620*ddq_imu+Z1621*ddq_w+Z1622*ddq_torso+Z1623;
% 
% LHS_6r_x = Z1624*ddx+Z1625*ddpsi+Z1626*ddq_imu+Z1627*ddq_w+Z1628*ddq_torso+Z1629*ddq_1r+Z1630*ddq_2r+Z1631*ddq_3r+Z1632;
% 
% LHS_7r_x = Z1633*ddx+Z1634*ddpsi+Z1635*ddq_imu+Z1636*ddq_w+Z1637*ddq_torso+Z1638*ddq_1r+Z1639*ddq_2r+Z1640*ddq_3r+Z1641*ddq_4r+Z1642;
% 
% LHS_8r_x = Z1643*ddx+Z1644*ddpsi+Z1645*ddq_imu+Z1646*ddq_w+Z1647*ddq_torso+Z1648*ddq_1r+Z1649*ddq_2r+Z1650*ddq_3r+Z1651*ddq_4r+Z1652*ddq_5r+Z1653;
% 
% LHS_9r_x = Z1654*ddx+Z1655*ddpsi+Z1656*ddq_imu+Z1657*ddq_w+Z1658*ddq_torso+Z1659*ddq_1r+Z1660*ddq_2r+Z1661*ddq_3r+Z1662*ddq_4r+Z1663*ddq_5r+Z1664*ddq_6r+Z1665;
% 
% LHS_10r_x = Z1666*ddx+Z1667*ddpsi+Z1668*ddq_imu+Z1669*ddq_w+Z1670*ddq_torso+Z1671*ddq_1r+Z1672*ddq_2r+Z1673*ddq_3r+Z1674*ddq_4r+Z1675*ddq_5r+Z1676*ddq_6r+Z1677*ddq_7r+Z1678;
% 
% LHS_L_psi = Z1679*ddx+Z1680*ddpsi+Z1681;
% 
% LHS_R_psi = Z1682*ddx+Z1683*ddpsi+Z1684;
% 
% LHS_1_psi = Z1685*ddx+Z1686*ddpsi+Z1687*ddq_imu+Z1688;
% 
% LHS_2_psi = Z1689*ddx+Z1690*ddpsi+Z1691*ddq_imu+Z1692*ddq_w+Z1693;
% 
% LHS_3_psi = Z1694*ddx+Z1695*ddpsi+Z1696*ddq_imu+Z1697*ddq_w+Z1698*ddq_torso+Z1699;
% 
% LHS_4l_psi = Z1700*ddx+Z1701*ddpsi+Z1702*ddq_imu+Z1703*ddq_w+Z1704*ddq_torso+Z1705*ddq_1l+Z1706;
% 
% LHS_5l_psi = Z1707*ddx+Z1708*ddpsi+Z1709*ddq_imu+Z1710*ddq_w+Z1711*ddq_torso+Z1712*ddq_1l+Z1713*ddq_2l+Z1714;
% 
% LHS_6l_psi = Z1715*ddx+Z1716*ddpsi+Z1717*ddq_imu+Z1718*ddq_w+Z1719*ddq_torso+Z1720*ddq_1l+Z1721*ddq_2l+Z1722*ddq_3l+Z1723;
% 
% LHS_7l_psi = Z1724*ddx+Z1725*ddpsi+Z1726*ddq_imu+Z1727*ddq_w+Z1728*ddq_torso+Z1729*ddq_1l+Z1730*ddq_2l+Z1731*ddq_3l+Z1732*ddq_4l+Z1733;
% 
% LHS_8l_psi = Z1734*ddx+Z1735*ddpsi+Z1736*ddq_imu+Z1737*ddq_w+Z1738*ddq_torso+Z1739*ddq_1l+Z1740*ddq_2l+Z1741*ddq_3l+Z1742*ddq_4l+Z1743*ddq_5l+Z1744;
% 
% LHS_9l_psi = Z1745*ddx+Z1746*ddpsi+Z1747*ddq_imu+Z1748*ddq_w+Z1749*ddq_torso+Z1750*ddq_1l+Z1751*ddq_2l+Z1752*ddq_3l+Z1753*ddq_4l+Z1754*ddq_5l+Z1755*ddq_6l+Z1756;
% 
% LHS_10l_psi = Z1757*ddx+Z1758*ddpsi+Z1759*ddq_imu+Z1760*ddq_w+Z1761*ddq_torso+Z1762*ddq_1l+Z1763*ddq_2l+Z1764*ddq_3l+Z1765*ddq_4l+Z1766*ddq_5l+Z1767*ddq_6l+Z1768*ddq_7l+Z1769;
% 
% LHS_4r_psi = Z1770*ddx+Z1771*ddpsi+Z1772*ddq_imu+Z1773*ddq_w+Z1774*ddq_torso+Z1775*ddq_1r+Z1776;
% 
% LHS_5r_psi = Z1777*ddx+Z1778*ddpsi+Z1779*ddq_imu+Z1780*ddq_w+Z1781*ddq_torso+Z1782;
% 
% LHS_6r_psi = Z1783*ddx+Z1784*ddpsi+Z1785*ddq_imu+Z1786*ddq_w+Z1787*ddq_torso+Z1788*ddq_1r+Z1789*ddq_2r+Z1790*ddq_3r+Z1791;
% 
% LHS_7r_psi = Z1792*ddx+Z1793*ddpsi+Z1794*ddq_imu+Z1795*ddq_w+Z1796*ddq_torso+Z1797*ddq_1r+Z1798*ddq_2r+Z1799*ddq_3r+Z1800*ddq_4r+Z1801;
% 
% LHS_8r_psi = Z1802*ddx+Z1803*ddpsi+Z1804*ddq_imu+Z1805*ddq_w+Z1806*ddq_torso+Z1807*ddq_1r+Z1808*ddq_2r+Z1809*ddq_3r+Z1810*ddq_4r+Z1811*ddq_5r+Z1812;
% 
% LHS_9r_psi = Z1813*ddx+Z1814*ddpsi+Z1815*ddq_imu+Z1816*ddq_w+Z1817*ddq_torso+Z1818*ddq_1r+Z1819*ddq_2r+Z1820*ddq_3r+Z1821*ddq_4r+Z1822*ddq_5r+Z1823*ddq_6r+Z1824;
% 
% LHS_10r_psi = Z1825*ddx+Z1826*ddpsi+Z1827*ddq_imu+Z1828*ddq_w+Z1829*ddq_torso+Z1830*ddq_1r+Z1831*ddq_2r+Z1832*ddq_3r+Z1833*ddq_4r+Z1834*ddq_5r+Z1835*ddq_6r+Z1836*ddq_7r+Z1837;
% 
% LHS_L_imu = 0;
% 
% LHS_R_imu = 0;
% 
% LHS_1_imu = -Z633*ddx-Z634*ddpsi-Z635*ddq_imu+-Z636;
% 
% LHS_2_imu = Z1838*ddx+Z1839*ddpsi+Z1840*ddq_imu+Z1841*ddq_w+Z1842;
% 
% LHS_3_imu = Z1843*ddx+Z1844*ddpsi+Z1845*ddq_imu+Z1846*ddq_w+Z1847*ddq_torso+Z1848;
% 
% LHS_4l_imu = Z1849*ddx+Z1850*ddpsi+Z1851*ddq_imu+Z1852*ddq_w+Z1853*ddq_torso+Z1854*ddq_1l+Z1855;
% 
% LHS_5l_imu = Z1856*ddx+Z1857*ddpsi+Z1858*ddq_imu+Z1859*ddq_w+Z1860*ddq_torso+Z1861*ddq_1l+Z1862*ddq_2l+Z1863;
% 
% LHS_6l_imu = Z1864*ddx+Z1865*ddpsi+Z1866*ddq_imu+Z1867*ddq_w+Z1868*ddq_torso+Z1869*ddq_1l+Z1870*ddq_2l+Z1871*ddq_3l+Z1872;
% 
% LHS_7l_imu = Z1873*ddx+Z1874*ddpsi+Z1875*ddq_imu+Z1876*ddq_w+Z1877*ddq_torso+Z1878*ddq_1l+Z1879*ddq_2l+Z1880*ddq_3l+Z1881*ddq_4l+Z1882;
% 
% LHS_8l_imu = Z1883*ddx+Z1884*ddpsi+Z1885*ddq_imu+Z1886*ddq_w+Z1887*ddq_torso+Z1888*ddq_1l+Z1889*ddq_2l+Z1890*ddq_3l+Z1891*ddq_4l+Z1892*ddq_5l+Z1893;
% 
% LHS_9l_imu = Z1894*ddx+Z1895*ddpsi+Z1896*ddq_imu+Z1897*ddq_w+Z1898*ddq_torso+Z1899*ddq_1l+Z1900*ddq_2l+Z1901*ddq_3l+Z1902*ddq_4l+Z1903*ddq_5l+Z1904*ddq_6l+Z1905;
% 
% LHS_10l_imu = Z1906*ddx+Z1907*ddpsi+Z1908*ddq_imu+Z1909*ddq_w+Z1910*ddq_torso+Z1911*ddq_1l+Z1912*ddq_2l+Z1913*ddq_3l+Z1914*ddq_4l+Z1915*ddq_5l+Z1916*ddq_6l+Z1917*ddq_7l+Z1918;
% 
% LHS_4r_imu = Z1919*ddx+Z1920*ddpsi+Z1921*ddq_imu+Z1922*ddq_w+Z1923*ddq_torso+Z1924*ddq_1r+Z1925;
% 
% LHS_5r_imu = Z1926*ddx+Z1927*ddpsi+Z1928*ddq_imu+Z1929*ddq_w+Z1930*ddq_torso+Z1931;
% 
% LHS_6r_imu = Z1932*ddx+Z1933*ddpsi+Z1934*ddq_imu+Z1935*ddq_w+Z1936*ddq_torso+Z1937*ddq_1r+Z1938*ddq_2r+Z1939*ddq_3r+Z1940;
% 
% LHS_7r_imu = Z1941*ddx+Z1942*ddpsi+Z1943*ddq_imu+Z1944*ddq_w+Z1945*ddq_torso+Z1946*ddq_1r+Z1947*ddq_2r+Z1948*ddq_3r+Z1949*ddq_4r+Z1950;
% 
% LHS_8r_imu = Z1951*ddx+Z1952*ddpsi+Z1953*ddq_imu+Z1954*ddq_w+Z1955*ddq_torso+Z1956*ddq_1r+Z1957*ddq_2r+Z1958*ddq_3r+Z1959*ddq_4r+Z1960*ddq_5r+Z1961;
% 
% LHS_9r_imu = Z1962*ddx+Z1963*ddpsi+Z1964*ddq_imu+Z1965*ddq_w+Z1966*ddq_torso+Z1967*ddq_1r+Z1968*ddq_2r+Z1969*ddq_3r+Z1970*ddq_4r+Z1971*ddq_5r+Z1972*ddq_6r+Z1973;
% 
% LHS_10r_imu = Z1974*ddx+Z1975*ddpsi+Z1976*ddq_imu+Z1977*ddq_w+Z1978*ddq_torso+Z1979*ddq_1r+Z1980*ddq_2r+Z1981*ddq_3r+Z1982*ddq_4r+Z1983*ddq_5r+Z1984*ddq_6r+Z1985*ddq_7r+Z1986;
% 
% LHS_L_w = 0;
% 
% LHS_R_w = 0;
% 
% LHS_1_w = 0;
% 
% LHS_2_w = -Z657*ddx-Z658*ddpsi-Z659*ddq_imu-Z660*ddq_w+-Z661;
% 
% LHS_3_w = Z1987*ddx+Z1988*ddpsi+Z1989*ddq_imu+Z1990*ddq_w+Z1991*ddq_torso+Z1992;
% 
% LHS_4l_w = Z1993*ddx+Z1994*ddpsi+Z1995*ddq_imu+Z1996*ddq_w+Z1997*ddq_torso+Z1998*ddq_1l+Z1999;
% 
% LHS_5l_w = Z2000*ddx+Z2001*ddpsi+Z2002*ddq_imu+Z2003*ddq_w+Z2004*ddq_torso+Z2005*ddq_1l+Z2006*ddq_2l+Z2007;
% 
% LHS_6l_w = Z2008*ddx+Z2009*ddpsi+Z2010*ddq_imu+Z2011*ddq_w+Z2012*ddq_torso+Z2013*ddq_1l+Z2014*ddq_2l+Z2015*ddq_3l+Z2016;
% 
% LHS_7l_w = Z2017*ddx+Z2018*ddpsi+Z2019*ddq_imu+Z2020*ddq_w+Z2021*ddq_torso+Z2022*ddq_1l+Z2023*ddq_2l+Z2024*ddq_3l+Z2025*ddq_4l+Z2026;
% 
% LHS_8l_w = Z2027*ddx+Z2028*ddpsi+Z2029*ddq_imu+Z2030*ddq_w+Z2031*ddq_torso+Z2032*ddq_1l+Z2033*ddq_2l+Z2034*ddq_3l+Z2035*ddq_4l+Z2036*ddq_5l+Z2037;
% 
% LHS_9l_w = Z2038*ddx+Z2039*ddpsi+Z2040*ddq_imu+Z2041*ddq_w+Z2042*ddq_torso+Z2043*ddq_1l+Z2044*ddq_2l+Z2045*ddq_3l+Z2046*ddq_4l+Z2047*ddq_5l+Z2048*ddq_6l+Z2049;
% 
% LHS_10l_w = Z2050*ddx+Z2051*ddpsi+Z2052*ddq_imu+Z2053*ddq_w+Z2054*ddq_torso+Z2055*ddq_1l+Z2056*ddq_2l+Z2057*ddq_3l+Z2058*ddq_4l+Z2059*ddq_5l+Z2060*ddq_6l+Z2061*ddq_7l+Z2062;
% 
% LHS_4r_w = Z2063*ddx+Z2064*ddpsi+Z2065*ddq_imu+Z2066*ddq_w+Z2067*ddq_torso+Z2068*ddq_1r+Z2069;
% 
% LHS_5r_w = Z2070*ddx+Z2071*ddpsi+Z2072*ddq_imu+Z2073*ddq_w+Z2074*ddq_torso+Z2075;
% 
% LHS_6r_w = Z2076*ddx+Z2077*ddpsi+Z2078*ddq_imu+Z2079*ddq_w+Z2080*ddq_torso+Z2081*ddq_1r+Z2082*ddq_2r+Z2083*ddq_3r+Z2084;
% 
% LHS_7r_w = Z2085*ddx+Z2086*ddpsi+Z2087*ddq_imu+Z2088*ddq_w+Z2089*ddq_torso+Z2090*ddq_1r+Z2091*ddq_2r+Z2092*ddq_3r+Z2093*ddq_4r+Z2094;
% 
% LHS_8r_w = Z2095*ddx+Z2096*ddpsi+Z2097*ddq_imu+Z2098*ddq_w+Z2099*ddq_torso+Z2100*ddq_1r+Z2101*ddq_2r+Z2102*ddq_3r+Z2103*ddq_4r+Z2104*ddq_5r+Z2105;
% 
% LHS_9r_w = Z2106*ddx+Z2107*ddpsi+Z2108*ddq_imu+Z2109*ddq_w+Z2110*ddq_torso+Z2111*ddq_1r+Z2112*ddq_2r+Z2113*ddq_3r+Z2114*ddq_4r+Z2115*ddq_5r+Z2116*ddq_6r+Z2117;
% 
% LHS_10r_w = Z2118*ddx+Z2119*ddpsi+Z2120*ddq_imu+Z2121*ddq_w+Z2122*ddq_torso+Z2123*ddq_1r+Z2124*ddq_2r+Z2125*ddq_3r+Z2126*ddq_4r+Z2127*ddq_5r+Z2128*ddq_6r+Z2129*ddq_7r+Z2130;
% 
% LHS_L_torso = 0;
% 
% LHS_R_torso = 0;
% 
% LHS_1_torso = 0;
% 
% LHS_2_torso = 0;
% 
% LHS_3_torso = -Z695*ddx-Z696*ddpsi-Z697*ddq_imu-Z698*ddq_w-Z699*ddq_torso+-Z700;
% 
% LHS_4l_torso = Z2131*ddx+Z2132*ddpsi+Z2133*ddq_imu+Z2134*ddq_w+Z2135*ddq_torso+Z2136*ddq_1l+Z2137;
% 
% LHS_5l_torso = Z2138*ddx+Z2139*ddpsi+Z2140*ddq_imu+Z2141*ddq_w+Z2142*ddq_torso+Z2143*ddq_1l+Z2144*ddq_2l+Z2145;
% 
% LHS_6l_torso = Z2146*ddx+Z2147*ddpsi+Z2148*ddq_imu+Z2149*ddq_w+Z2150*ddq_torso+Z2151*ddq_1l+Z2152*ddq_2l+Z2153*ddq_3l+Z2154;
% 
% LHS_7l_torso = Z2155*ddx+Z2156*ddpsi+Z2157*ddq_imu+Z2158*ddq_w+Z2159*ddq_torso+Z2160*ddq_1l+Z2161*ddq_2l+Z2162*ddq_3l+Z2163*ddq_4l+Z2164;
% 
% LHS_8l_torso = Z2165*ddx+Z2166*ddpsi+Z2167*ddq_imu+Z2168*ddq_w+Z2169*ddq_torso+Z2170*ddq_1l+Z2171*ddq_2l+Z2172*ddq_3l+Z2173*ddq_4l+Z2174*ddq_5l+Z2175;
% 
% LHS_9l_torso = Z2176*ddx+Z2177*ddpsi+Z2178*ddq_imu+Z2179*ddq_w+Z2180*ddq_torso+Z2181*ddq_1l+Z2182*ddq_2l+Z2183*ddq_3l+Z2184*ddq_4l+Z2185*ddq_5l+Z2186*ddq_6l+Z2187;
% 
% LHS_10l_torso = Z2188*ddx+Z2189*ddpsi+Z2190*ddq_imu+Z2191*ddq_w+Z2192*ddq_torso+Z2193*ddq_1l+Z2194*ddq_2l+Z2195*ddq_3l+Z2196*ddq_4l+Z2197*ddq_5l+Z2198*ddq_6l+Z2199*ddq_7l+Z2200;
% 
% LHS_4r_torso = Z2201*ddx+Z2202*ddpsi+Z2203*ddq_imu+Z2204*ddq_w+Z2205*ddq_torso+Z2206*ddq_1r+Z2207;
% 
% LHS_5r_torso = Z2208*ddx+Z2209*ddpsi+Z2210*ddq_imu+Z2211*ddq_w+Z2212*ddq_torso+Z2213;
% 
% LHS_6r_torso = Z2214*ddx+Z2215*ddpsi+Z2216*ddq_imu+Z2217*ddq_w+Z2218*ddq_torso+Z2219*ddq_1r+Z2220*ddq_2r+Z2221*ddq_3r+Z2222;
% 
% LHS_7r_torso = Z2223*ddx+Z2224*ddpsi+Z2225*ddq_imu+Z2226*ddq_w+Z2227*ddq_torso+Z2228*ddq_1r+Z2229*ddq_2r+Z2230*ddq_3r+Z2231*ddq_4r+Z2232;
% 
% LHS_8r_torso = Z2233*ddx+Z2234*ddpsi+Z2235*ddq_imu+Z2236*ddq_w+Z2237*ddq_torso+Z2238*ddq_1r+Z2239*ddq_2r+Z2240*ddq_3r+Z2241*ddq_4r+Z2242*ddq_5r+Z2243;
% 
% LHS_9r_torso = Z2244*ddx+Z2245*ddpsi+Z2246*ddq_imu+Z2247*ddq_w+Z2248*ddq_torso+Z2249*ddq_1r+Z2250*ddq_2r+Z2251*ddq_3r+Z2252*ddq_4r+Z2253*ddq_5r+Z2254*ddq_6r+Z2255;
% 
% LHS_10r_torso = Z2256*ddx+Z2257*ddpsi+Z2258*ddq_imu+Z2259*ddq_w+Z2260*ddq_torso+Z2261*ddq_1r+Z2262*ddq_2r+Z2263*ddq_3r+Z2264*ddq_4r+Z2265*ddq_5r+Z2266*ddq_6r+Z2267*ddq_7r+Z2268;
% 
% LHS_L_4l = 0;
% 
% LHS_R_4l = 0;
% 
% LHS_1_4l = 0;
% 
% LHS_2_4l = 0;
% 
% LHS_3_4l = 0;
% 
% LHS_4l_4l = -Z734*ddx-Z735*ddpsi-Z736*ddq_imu-Z737*ddq_w-Z738*ddq_torso-Z739*ddq_1l+-Z740;
% 
% LHS_5l_4l = Z2269*ddx+Z2270*ddpsi+Z2271*ddq_imu+Z2272*ddq_w+Z2273*ddq_torso+Z2274*ddq_1l+Z2275*ddq_2l+Z2276;
% 
% LHS_6l_4l = Z2277*ddx+Z2278*ddpsi+Z2279*ddq_imu+Z2280*ddq_w+Z2281*ddq_torso+Z2282*ddq_1l+Z2283*ddq_2l+Z2284*ddq_3l+Z2285;
% 
% LHS_7l_4l = Z2286*ddx+Z2287*ddpsi+Z2288*ddq_imu+Z2289*ddq_w+Z2290*ddq_torso+Z2291*ddq_1l+Z2292*ddq_2l+Z2293*ddq_3l+Z2294*ddq_4l+Z2295;
% 
% LHS_8l_4l = Z2296*ddx+Z2297*ddpsi+Z2298*ddq_imu+Z2299*ddq_w+Z2300*ddq_torso+Z2301*ddq_1l+Z2302*ddq_2l+Z2303*ddq_3l+Z2304*ddq_4l+Z2305*ddq_5l+Z2306;
% 
% LHS_9l_4l = Z2307*ddx+Z2308*ddpsi+Z2309*ddq_imu+Z2310*ddq_w+Z2311*ddq_torso+Z2312*ddq_1l+Z2313*ddq_2l+Z2314*ddq_3l+Z2315*ddq_4l+Z2316*ddq_5l+Z2317*ddq_6l+Z2318;
% 
% LHS_10l_4l = Z2319*ddx+Z2320*ddpsi+Z2321*ddq_imu+Z2322*ddq_w+Z2323*ddq_torso+Z2324*ddq_1l+Z2325*ddq_2l+Z2326*ddq_3l+Z2327*ddq_4l+Z2328*ddq_5l+Z2329*ddq_6l+Z2330*ddq_7l+Z2331;
% 
% LHS_4r_4l = 0;
% 
% LHS_5r_4l = 0;
% 
% LHS_6r_4l = 0;
% 
% LHS_7r_4l = 0;
% 
% LHS_8r_4l = 0;
% 
% LHS_9r_4l = 0;
% 
% LHS_10r_4l = 0;
% 
% LHS_L_5l = 0;
% 
% LHS_R_5l = 0;
% 
% LHS_1_5l = 0;
% 
% LHS_2_5l = 0;
% 
% LHS_3_5l = 0;
% 
% LHS_4l_5l = 0;
% 
% LHS_5l_5l = -Z771*ddx-Z772*ddpsi-Z773*ddq_imu-Z774*ddq_w-Z775*ddq_torso-Z776*ddq_1l-Z777*ddq_2l+-Z778;
% 
% LHS_6l_5l = Z2332*ddx+Z2333*ddpsi+Z2334*ddq_imu+Z2335*ddq_w+Z2336*ddq_torso+Z2337*ddq_1l+Z2338*ddq_2l+Z2339*ddq_3l+Z2340;
% 
% LHS_7l_5l = Z2341*ddx+Z2342*ddpsi+Z2343*ddq_imu+Z2344*ddq_w+Z2345*ddq_torso+Z2346*ddq_1l+Z2347*ddq_2l+Z2348*ddq_3l+Z2349*ddq_4l+Z2350;
% 
% LHS_8l_5l = Z2351*ddx+Z2352*ddpsi+Z2353*ddq_imu+Z2354*ddq_w+Z2355*ddq_torso+Z2356*ddq_1l+Z2357*ddq_2l+Z2358*ddq_3l+Z2359*ddq_4l+Z2360*ddq_5l+Z2361;
% 
% LHS_9l_5l = Z2362*ddx+Z2363*ddpsi+Z2364*ddq_imu+Z2365*ddq_w+Z2366*ddq_torso+Z2367*ddq_1l+Z2368*ddq_2l+Z2369*ddq_3l+Z2370*ddq_4l+Z2371*ddq_5l+Z2372*ddq_6l+Z2373;
% 
% LHS_10l_5l = Z2374*ddx+Z2375*ddpsi+Z2376*ddq_imu+Z2377*ddq_w+Z2378*ddq_torso+Z2379*ddq_1l+Z2380*ddq_2l+Z2381*ddq_3l+Z2382*ddq_4l+Z2383*ddq_5l+Z2384*ddq_6l+Z2385*ddq_7l+Z2386;
% 
% LHS_4r_5l = 0;
% 
% LHS_5r_5l = 0;
% 
% LHS_6r_5l = 0;
% 
% LHS_7r_5l = 0;
% 
% LHS_8r_5l = 0;
% 
% LHS_9r_5l = 0;
% 
% LHS_10r_5l = 0;
% 
% LHS_L_6l = 0;
% 
% LHS_R_6l = 0;
% 
% LHS_1_6l = 0;
% 
% LHS_2_6l = 0;
% 
% LHS_3_6l = 0;
% 
% LHS_4l_6l = 0;
% 
% LHS_5l_6l = 0;
% 
% LHS_6l_6l = -Z830*ddx-Z831*ddpsi-Z832*ddq_imu-Z833*ddq_w-Z834*ddq_torso-Z835*ddq_1l-Z836*ddq_2l-Z837*ddq_3l+-Z838;
% 
% LHS_7l_6l = Z2387*ddx+Z2388*ddpsi+Z2389*ddq_imu+Z2390*ddq_w+Z2391*ddq_torso+Z2392*ddq_1l+Z2393*ddq_2l+Z2394*ddq_3l+Z2395*ddq_4l+Z2396;
% 
% LHS_8l_6l = Z2397*ddx+Z2398*ddpsi+Z2399*ddq_imu+Z2400*ddq_w+Z2401*ddq_torso+Z2402*ddq_1l+Z2403*ddq_2l+Z2404*ddq_3l+Z2405*ddq_4l+Z2406*ddq_5l+Z2407;
% 
% LHS_9l_6l = Z2408*ddx+Z2409*ddpsi+Z2410*ddq_imu+Z2411*ddq_w+Z2412*ddq_torso+Z2413*ddq_1l+Z2414*ddq_2l+Z2415*ddq_3l+Z2416*ddq_4l+Z2417*ddq_5l+Z2418*ddq_6l+Z2419;
% 
% LHS_10l_6l = Z2420*ddx+Z2421*ddpsi+Z2422*ddq_imu+Z2423*ddq_w+Z2424*ddq_torso+Z2425*ddq_1l+Z2426*ddq_2l+Z2427*ddq_3l+Z2428*ddq_4l+Z2429*ddq_5l+Z2430*ddq_6l+Z2431*ddq_7l+Z2432;
% 
% LHS_4r_6l = 0;
% 
% LHS_5r_6l = 0;
% 
% LHS_6r_6l = 0;
% 
% LHS_7r_6l = 0;
% 
% LHS_8r_6l = 0;
% 
% LHS_9r_6l = 0;
% 
% LHS_10r_6l = 0;
% 
% LHS_L_7l = 0;
% 
% LHS_R_7l = 0;
% 
% LHS_1_7l = 0;
% 
% LHS_2_7l = 0;
% 
% LHS_3_7l = 0;
% 
% LHS_4l_7l = 0;
% 
% LHS_5l_7l = 0;
% 
% LHS_6l_7l = 0;
% 
% LHS_7l_7l = -Z877*ddx-Z878*ddpsi-Z879*ddq_imu-Z880*ddq_w-Z881*ddq_torso-Z882*ddq_1l-Z883*ddq_2l-Z884*ddq_3l-Z885*ddq_4l+-Z886;
% 
% LHS_8l_7l = Z2433*ddx+Z2434*ddpsi+Z2435*ddq_imu+Z2436*ddq_w+Z2437*ddq_torso+Z2438*ddq_1l+Z2439*ddq_2l+Z2440*ddq_3l+Z2441*ddq_4l+Z2442*ddq_5l+Z2443;
% 
% LHS_9l_7l = Z2444*ddx+Z2445*ddpsi+Z2446*ddq_imu+Z2447*ddq_w+Z2448*ddq_torso+Z2449*ddq_1l+Z2450*ddq_2l+Z2451*ddq_3l+Z2452*ddq_4l+Z2453*ddq_5l+Z2454*ddq_6l+Z2455;
% 
% LHS_10l_7l = Z2456*ddx+Z2457*ddpsi+Z2458*ddq_imu+Z2459*ddq_w+Z2460*ddq_torso+Z2461*ddq_1l+Z2462*ddq_2l+Z2463*ddq_3l+Z2464*ddq_4l+Z2465*ddq_5l+Z2466*ddq_6l+Z2467*ddq_7l+Z2468;
% 
% LHS_4r_7l = 0;
% 
% LHS_5r_7l = 0;
% 
% LHS_6r_7l = 0;
% 
% LHS_7r_7l = 0;
% 
% LHS_8r_7l = 0;
% 
% LHS_9r_7l = 0;
% 
% LHS_10r_7l = 0;
% 
% LHS_L_8l = 0;
% 
% LHS_R_8l = 0;
% 
% LHS_1_8l = 0;
% 
% LHS_2_8l = 0;
% 
% LHS_3_8l = 0;
% 
% LHS_4l_8l = 0;
% 
% LHS_5l_8l = 0;
% 
% LHS_6l_8l = 0;
% 
% LHS_7l_8l = 0;
% 
% LHS_8l_8l = -Z950*ddx-Z951*ddpsi-Z952*ddq_imu-Z953*ddq_w-Z954*ddq_torso-Z955*ddq_1l-Z956*ddq_2l-Z957*ddq_3l-Z958*ddq_4l-Z959*ddq_5l+-Z960;
% 
% LHS_9l_8l = Z2469*ddx+Z2470*ddpsi+Z2471*ddq_imu+Z2472*ddq_w+Z2473*ddq_torso+Z2474*ddq_1l+Z2475*ddq_2l+Z2476*ddq_3l+Z2477*ddq_4l+Z2478*ddq_5l+Z2479*ddq_6l+Z2480;
% 
% LHS_10l_8l = Z2481*ddx+Z2482*ddpsi+Z2483*ddq_imu+Z2484*ddq_w+Z2485*ddq_torso+Z2486*ddq_1l+Z2487*ddq_2l+Z2488*ddq_3l+Z2489*ddq_4l+Z2490*ddq_5l+Z2491*ddq_6l+Z2492*ddq_7l+Z2493;
% 
% LHS_4r_8l = 0;
% 
% LHS_5r_8l = 0;
% 
% LHS_6r_8l = 0;
% 
% LHS_7r_8l = 0;
% 
% LHS_8r_8l = 0;
% 
% LHS_9r_8l = 0;
% 
% LHS_10r_8l = 0;
% 
% LHS_L_9l = 0;
% 
% LHS_R_9l = 0;
% 
% LHS_1_9l = 0;
% 
% LHS_2_9l = 0;
% 
% LHS_3_9l = 0;
% 
% LHS_4l_9l = 0;
% 
% LHS_5l_9l = 0;
% 
% LHS_6l_9l = 0;
% 
% LHS_7l_9l = 0;
% 
% LHS_8l_9l = 0;
% 
% LHS_9l_9l = -Z1007*ddx-Z1008*ddpsi-Z1009*ddq_imu-Z1010*ddq_w-Z1011*ddq_torso-Z1012*ddq_1l-Z1013*ddq_2l-Z1014*ddq_3l-Z1015*ddq_4l-Z1016*ddq_5l-Z1017*ddq_6l+-Z1018;
% 
% LHS_10l_9l = Z2494*ddx+Z2495*ddpsi+Z2496*ddq_imu+Z2497*ddq_w+Z2498*ddq_torso+Z2499*ddq_1l+Z2500*ddq_2l+Z2501*ddq_3l+Z2502*ddq_4l+Z2503*ddq_5l+Z2504*ddq_6l+Z2505*ddq_7l+Z2506;
% 
% LHS_4r_9l = 0;
% 
% LHS_5r_9l = 0;
% 
% LHS_6r_9l = 0;
% 
% LHS_7r_9l = 0;
% 
% LHS_8r_9l = 0;
% 
% LHS_9r_9l = 0;
% 
% LHS_10r_9l = 0;
% 
% LHS_L_10l = 0;
% 
% LHS_R_10l = 0;
% 
% LHS_1_10l = 0;
% 
% LHS_2_10l = 0;
% 
% LHS_3_10l = 0;
% 
% LHS_4l_10l = 0;
% 
% LHS_5l_10l = 0;
% 
% LHS_6l_10l = 0;
% 
% LHS_7l_10l = 0;
% 
% LHS_8l_10l = 0;
% 
% LHS_9l_10l = 0;
% 
% LHS_10l_10l = -Z1107*ddx-Z1108*ddpsi-Z1109*ddq_imu-Z1110*ddq_w-Z1111*ddq_torso-Z1112*ddq_1l-Z1113*ddq_2l-Z1114*ddq_3l-Z1115*ddq_4l-Z1116*ddq_5l-Z1117*ddq_6l-Z1118*ddq_7l+-Z1119;
% 
% LHS_4r_10l = 0;
% 
% LHS_5r_10l = 0;
% 
% LHS_6r_10l = 0;
% 
% LHS_7r_10l = 0;
% 
% LHS_8r_10l = 0;
% 
% LHS_9r_10l = 0;
% 
% LHS_10r_10l = 0;
% 
% LHS_L_4r = 0;
% 
% LHS_R_4r = 0;
% 
% LHS_1_4r = 0;
% 
% LHS_2_4r = 0;
% 
% LHS_3_4r = 0;
% 
% LHS_4l_4r = 0;
% 
% LHS_5l_4r = 0;
% 
% LHS_6l_4r = 0;
% 
% LHS_7l_4r = 0;
% 
% LHS_8l_4r = 0;
% 
% LHS_9l_4r = 0;
% 
% LHS_10l_4r = 0;
% 
% LHS_4r_4r = -Z1147*ddx-Z1148*ddpsi-Z1149*ddq_imu-Z1150*ddq_w-Z1151*ddq_torso-Z1152*ddq_1r+-Z1153;
% 
% LHS_5r_4r = Z2507*ddx+Z2508*ddpsi+Z2509*ddq_imu+Z2510*ddq_w+Z2511*ddq_torso+Z2512;
% 
% LHS_6r_4r = Z2513*ddx+Z2514*ddpsi+Z2515*ddq_imu+Z2516*ddq_w+Z2517*ddq_torso+Z2518*ddq_1r+Z2519*ddq_2r+Z2520*ddq_3r+Z2521;
% 
% LHS_7r_4r = Z2522*ddx+Z2523*ddpsi+Z2524*ddq_imu+Z2525*ddq_w+Z2526*ddq_torso+Z2527*ddq_1r+Z2528*ddq_2r+Z2529*ddq_3r+Z2530*ddq_4r+Z2531;
% 
% LHS_8r_4r = Z2532*ddx+Z2533*ddpsi+Z2534*ddq_imu+Z2535*ddq_w+Z2536*ddq_torso+Z2537*ddq_1r+Z2538*ddq_2r+Z2539*ddq_3r+Z2540*ddq_4r+Z2541*ddq_5r+Z2542;
% 
% LHS_9r_4r = Z2543*ddx+Z2544*ddpsi+Z2545*ddq_imu+Z2546*ddq_w+Z2547*ddq_torso+Z2548*ddq_1r+Z2549*ddq_2r+Z2550*ddq_3r+Z2551*ddq_4r+Z2552*ddq_5r+Z2553*ddq_6r+Z2554;
% 
% LHS_10r_4r = Z2555*ddx+Z2556*ddpsi+Z2557*ddq_imu+Z2558*ddq_w+Z2559*ddq_torso+Z2560*ddq_1r+Z2561*ddq_2r+Z2562*ddq_3r+Z2563*ddq_4r+Z2564*ddq_5r+Z2565*ddq_6r+Z2566*ddq_7r+Z2567;
% 
% LHS_L_5r = 0;
% 
% LHS_R_5r = 0;
% 
% LHS_1_5r = 0;
% 
% LHS_2_5r = 0;
% 
% LHS_3_5r = 0;
% 
% LHS_4l_5r = 0;
% 
% LHS_5l_5r = 0;
% 
% LHS_6l_5r = 0;
% 
% LHS_7l_5r = 0;
% 
% LHS_8l_5r = 0;
% 
% LHS_9l_5r = 0;
% 
% LHS_10l_5r = 0;
% 
% LHS_4r_5r = 0;
% 
% LHS_5r_5r = -Z1179*ddx-Z1180*ddpsi-Z1181*ddq_imu-Z1182*ddq_w-Z1183*ddq_torso+-Z1184;
% 
% LHS_6r_5r = Z2568*ddx+Z2569*ddpsi+Z2570*ddq_imu+Z2571*ddq_w+Z2572*ddq_torso+Z2573*ddq_1r+Z2574*ddq_2r+Z2575*ddq_3r+Z2576;
% 
% LHS_7r_5r = Z2577*ddx+Z2578*ddpsi+Z2579*ddq_imu+Z2580*ddq_w+Z2581*ddq_torso+Z2582*ddq_1r+Z2583*ddq_2r+Z2584*ddq_3r+Z2585*ddq_4r+Z2586;
% 
% LHS_8r_5r = Z2587*ddx+Z2588*ddpsi+Z2589*ddq_imu+Z2590*ddq_w+Z2591*ddq_torso+Z2592*ddq_1r+Z2593*ddq_2r+Z2594*ddq_3r+Z2595*ddq_4r+Z2596*ddq_5r+Z2597;
% 
% LHS_9r_5r = Z2598*ddx+Z2599*ddpsi+Z2600*ddq_imu+Z2601*ddq_w+Z2602*ddq_torso+Z2603*ddq_1r+Z2604*ddq_2r+Z2605*ddq_3r+Z2606*ddq_4r+Z2607*ddq_5r+Z2608*ddq_6r+Z2609;
% 
% LHS_10r_5r = Z2610*ddx+Z2611*ddpsi+Z2612*ddq_imu+Z2613*ddq_w+Z2614*ddq_torso+Z2615*ddq_1r+Z2616*ddq_2r+Z2617*ddq_3r+Z2618*ddq_4r+Z2619*ddq_5r+Z2620*ddq_6r+Z2621*ddq_7r+Z2622;
% 
% LHS_L_6r = 0;
% 
% LHS_R_6r = 0;
% 
% LHS_1_6r = 0;
% 
% LHS_2_6r = 0;
% 
% LHS_3_6r = 0;
% 
% LHS_4l_6r = 0;
% 
% LHS_5l_6r = 0;
% 
% LHS_6l_6r = 0;
% 
% LHS_7l_6r = 0;
% 
% LHS_8l_6r = 0;
% 
% LHS_9l_6r = 0;
% 
% LHS_10l_6r = 0;
% 
% LHS_4r_6r = 0;
% 
% LHS_5r_6r = 0;
% 
% LHS_6r_6r = -Z1232*ddx-Z1233*ddpsi-Z1234*ddq_imu-Z1235*ddq_w-Z1236*ddq_torso-Z1237*ddq_1r-Z1238*ddq_2r-Z1239*ddq_3r+-Z1240;
% 
% LHS_7r_6r = Z2623*ddx+Z2624*ddpsi+Z2625*ddq_imu+Z2626*ddq_w+Z2627*ddq_torso+Z2628*ddq_1r+Z2629*ddq_2r+Z2630*ddq_3r+Z2631*ddq_4r+Z2632;
% 
% LHS_8r_6r = Z2633*ddx+Z2634*ddpsi+Z2635*ddq_imu+Z2636*ddq_w+Z2637*ddq_torso+Z2638*ddq_1r+Z2639*ddq_2r+Z2640*ddq_3r+Z2641*ddq_4r+Z2642*ddq_5r+Z2643;
% 
% LHS_9r_6r = Z2644*ddx+Z2645*ddpsi+Z2646*ddq_imu+Z2647*ddq_w+Z2648*ddq_torso+Z2649*ddq_1r+Z2650*ddq_2r+Z2651*ddq_3r+Z2652*ddq_4r+Z2653*ddq_5r+Z2654*ddq_6r+Z2655;
% 
% LHS_10r_6r = Z2656*ddx+Z2657*ddpsi+Z2658*ddq_imu+Z2659*ddq_w+Z2660*ddq_torso+Z2661*ddq_1r+Z2662*ddq_2r+Z2663*ddq_3r+Z2664*ddq_4r+Z2665*ddq_5r+Z2666*ddq_6r+Z2667*ddq_7r+Z2668;
% 
% LHS_L_7r = 0;
% 
% LHS_R_7r = 0;
% 
% LHS_1_7r = 0;
% 
% LHS_2_7r = 0;
% 
% LHS_3_7r = 0;
% 
% LHS_4l_7r = 0;
% 
% LHS_5l_7r = 0;
% 
% LHS_6l_7r = 0;
% 
% LHS_7l_7r = 0;
% 
% LHS_8l_7r = 0;
% 
% LHS_9l_7r = 0;
% 
% LHS_10l_7r = 0;
% 
% LHS_4r_7r = 0;
% 
% LHS_5r_7r = 0;
% 
% LHS_6r_7r = 0;
% 
% LHS_7r_7r = -Z1279*ddx-Z1280*ddpsi-Z1281*ddq_imu-Z1282*ddq_w-Z1283*ddq_torso-Z1284*ddq_1r-Z1285*ddq_2r-Z1286*ddq_3r-Z1287*ddq_4r+-Z1288;
% 
% LHS_8r_7r = Z2669*ddx+Z2670*ddpsi+Z2671*ddq_imu+Z2672*ddq_w+Z2673*ddq_torso+Z2674*ddq_1r+Z2675*ddq_2r+Z2676*ddq_3r+Z2677*ddq_4r+Z2678*ddq_5r+Z2679;
% 
% LHS_9r_7r = Z2680*ddx+Z2681*ddpsi+Z2682*ddq_imu+Z2683*ddq_w+Z2684*ddq_torso+Z2685*ddq_1r+Z2686*ddq_2r+Z2687*ddq_3r+Z2688*ddq_4r+Z2689*ddq_5r+Z2690*ddq_6r+Z2691;
% 
% LHS_10r_7r = Z2692*ddx+Z2693*ddpsi+Z2694*ddq_imu+Z2695*ddq_w+Z2696*ddq_torso+Z2697*ddq_1r+Z2698*ddq_2r+Z2699*ddq_3r+Z2700*ddq_4r+Z2701*ddq_5r+Z2702*ddq_6r+Z2703*ddq_7r+Z2704;
% 
% LHS_L_8r = 0;
% 
% LHS_R_8r = 0;
% 
% LHS_1_8r = 0;
% 
% LHS_2_8r = 0;
% 
% LHS_3_8r = 0;
% 
% LHS_4l_8r = 0;
% 
% LHS_5l_8r = 0;
% 
% LHS_6l_8r = 0;
% 
% LHS_7l_8r = 0;
% 
% LHS_8l_8r = 0;
% 
% LHS_9l_8r = 0;
% 
% LHS_10l_8r = 0;
% 
% LHS_4r_8r = 0;
% 
% LHS_5r_8r = 0;
% 
% LHS_6r_8r = 0;
% 
% LHS_7r_8r = 0;
% 
% LHS_8r_8r = -Z1352*ddx-Z1353*ddpsi-Z1354*ddq_imu-Z1355*ddq_w-Z1356*ddq_torso-Z1357*ddq_1r-Z1358*ddq_2r-Z1359*ddq_3r-Z1360*ddq_4r-Z1361*ddq_5r+-Z1362;
% 
% LHS_9r_8r = Z2705*ddx+Z2706*ddpsi+Z2707*ddq_imu+Z2708*ddq_w+Z2709*ddq_torso+Z2710*ddq_1r+Z2711*ddq_2r+Z2712*ddq_3r+Z2713*ddq_4r+Z2714*ddq_5r+Z2715*ddq_6r+Z2716;
% 
% LHS_10r_8r = Z2717*ddx+Z2718*ddpsi+Z2719*ddq_imu+Z2720*ddq_w+Z2721*ddq_torso+Z2722*ddq_1r+Z2723*ddq_2r+Z2724*ddq_3r+Z2725*ddq_4r+Z2726*ddq_5r+Z2727*ddq_6r+Z2728*ddq_7r+Z2729;
% 
% LHS_L_9r = 0;
% 
% LHS_R_9r = 0;
% 
% LHS_1_9r = 0;
% 
% LHS_2_9r = 0;
% 
% LHS_3_9r = 0;
% 
% LHS_4l_9r = 0;
% 
% LHS_5l_9r = 0;
% 
% LHS_6l_9r = 0;
% 
% LHS_7l_9r = 0;
% 
% LHS_8l_9r = 0;
% 
% LHS_9l_9r = 0;
% 
% LHS_10l_9r = 0;
% 
% LHS_4r_9r = 0;
% 
% LHS_5r_9r = 0;
% 
% LHS_6r_9r = 0;
% 
% LHS_7r_9r = 0;
% 
% LHS_8r_9r = 0;
% 
% LHS_9r_9r = -Z1409*ddx-Z1410*ddpsi-Z1411*ddq_imu-Z1412*ddq_w-Z1413*ddq_torso-Z1414*ddq_1r-Z1415*ddq_2r-Z1416*ddq_3r-Z1417*ddq_4r-Z1418*ddq_5r-Z1419*ddq_6r+-Z1420;
% 
% LHS_10r_9r = Z2730*ddx+Z2731*ddpsi+Z2732*ddq_imu+Z2733*ddq_w+Z2734*ddq_torso+Z2735*ddq_1r+Z2736*ddq_2r+Z2737*ddq_3r+Z2738*ddq_4r+Z2739*ddq_5r+Z2740*ddq_6r+Z2741*ddq_7r+Z2742;
% 
% LHS_L_10r = 0;
% 
% LHS_R_10r = 0;
% 
% LHS_1_10r = 0;
% 
% LHS_2_10r = 0;
% 
% LHS_3_10r = 0;
% 
% LHS_4l_10r = 0;
% 
% LHS_5l_10r = 0;
% 
% LHS_6l_10r = 0;
% 
% LHS_7l_10r = 0;
% 
% LHS_8l_10r = 0;
% 
% LHS_9l_10r = 0;
% 
% LHS_10l_10r = 0;
% 
% LHS_4r_10r = 0;
% 
% LHS_5r_10r = 0;
% 
% LHS_6r_10r = 0;
% 
% LHS_7r_10r = 0;
% 
% LHS_8r_10r = 0;
% 
% LHS_9r_10r = 0;
% 
% LHS_10r_10r = -Z1509*ddx-Z1510*ddpsi-Z1511*ddq_imu-Z1512*ddq_w-Z1513*ddq_torso-Z1514*ddq_1r-Z1515*ddq_2r-Z1516*ddq_3r-Z1517*ddq_4r-Z1518*ddq_5r-Z1519*ddq_6r-Z1520*ddq_7r-Z1521;
% 
% %% LHS
% 
% % LHS_x = LHS_L_x + LHS_R_x + LHS_1_x + LHS_2_x + LHS_3_x + LHS_4l_x + LHS_5l_x + LHS_6l_x + LHS_7l_x + LHS_8l_x + LHS_9l_x + LHS_10l_x + LHS_4r_x + LHS_5r_x + LHS_6r_x + LHS_7r_x + LHS_8r_x + LHS_9r_x + LHS_10r_x;
% % LHS_psi = LHS_L_psi + LHS_R_psi + LHS_1_psi + LHS_2_psi + LHS_3_psi + LHS_4l_psi + LHS_5l_psi + LHS_6l_psi + LHS_7l_psi + LHS_8l_psi + LHS_9l_psi + LHS_10l_psi + LHS_4r_psi + LHS_5r_psi + LHS_6r_psi + LHS_7r_psi + LHS_8r_psi + LHS_9r_psi + LHS_10r_psi;
% % LHS_imu = LHS_L_imu + LHS_R_imu + LHS_1_imu + LHS_2_imu + LHS_3_imu + LHS_4l_imu + LHS_5l_imu + LHS_6l_imu + LHS_7l_imu + LHS_8l_imu + LHS_9l_imu + LHS_10l_imu + LHS_4r_imu + LHS_5r_imu + LHS_6r_imu + LHS_7r_imu + LHS_8r_imu + LHS_9r_imu + LHS_10r_imu;
% % LHS_w = LHS_L_w + LHS_R_w + LHS_1_w + LHS_2_w + LHS_3_w + LHS_4l_w + LHS_5l_w + LHS_6l_w + LHS_7l_w + LHS_8l_w + LHS_9l_w + LHS_10l_w + LHS_4r_w + LHS_5r_w + LHS_6r_w + LHS_7r_w + LHS_8r_w + LHS_9r_w + LHS_10r_w;
% % LHS_torso = LHS_L_torso + LHS_R_torso + LHS_1_torso + LHS_2_torso + LHS_3_torso + LHS_4l_torso + LHS_5l_torso + LHS_6l_torso + LHS_7l_torso + LHS_8l_torso + LHS_9l_torso + LHS_10l_torso + LHS_4r_torso + LHS_5r_torso + LHS_6r_torso + LHS_7r_torso + LHS_8r_torso + LHS_9r_torso + LHS_10r_torso;
% % LHS_4l = LHS_L_4l + LHS_R_4l + LHS_1_4l + LHS_2_4l + LHS_3_4l + LHS_4l_4l + LHS_5l_4l + LHS_6l_4l + LHS_7l_4l + LHS_8l_4l + LHS_9l_4l + LHS_10l_4l + LHS_4r_4l + LHS_5r_4l + LHS_6r_4l + LHS_7r_4l + LHS_8r_4l + LHS_9r_4l + LHS_10r_4l;
% % LHS_5l = LHS_L_5l + LHS_R_5l + LHS_1_5l + LHS_2_5l + LHS_3_5l + LHS_4l_5l + LHS_5l_5l + LHS_6l_5l + LHS_7l_5l + LHS_8l_5l + LHS_9l_5l + LHS_10l_5l + LHS_4r_5l + LHS_5r_5l + LHS_6r_5l + LHS_7r_5l + LHS_8r_5l + LHS_9r_5l + LHS_10r_5l;
% % LHS_6l = LHS_L_6l + LHS_R_6l + LHS_1_6l + LHS_2_6l + LHS_3_6l + LHS_4l_6l + LHS_5l_6l + LHS_6l_6l + LHS_7l_6l + LHS_8l_6l + LHS_9l_6l + LHS_10l_6l + LHS_4r_6l + LHS_5r_6l + LHS_6r_6l + LHS_7r_6l + LHS_8r_6l + LHS_9r_6l + LHS_10r_6l;
% % LHS_7l = LHS_L_7l + LHS_R_7l + LHS_1_7l + LHS_2_7l + LHS_3_7l + LHS_4l_7l + LHS_5l_7l + LHS_6l_7l + LHS_7l_7l + LHS_8l_7l + LHS_9l_7l + LHS_10l_7l + LHS_4r_7l + LHS_5r_7l + LHS_6r_7l + LHS_7r_7l + LHS_8r_7l + LHS_9r_7l + LHS_10r_7l;
% % LHS_8l = LHS_L_8l + LHS_R_8l + LHS_1_8l + LHS_2_8l + LHS_3_8l + LHS_4l_8l + LHS_5l_8l + LHS_6l_8l + LHS_7l_8l + LHS_8l_8l + LHS_9l_8l + LHS_10l_8l + LHS_4r_8l + LHS_5r_8l + LHS_6r_8l + LHS_7r_8l + LHS_8r_8l + LHS_9r_8l + LHS_10r_8l;
% % LHS_9l = LHS_L_9l + LHS_R_9l + LHS_1_9l + LHS_2_9l + LHS_3_9l + LHS_4l_9l + LHS_5l_9l + LHS_6l_9l + LHS_7l_9l + LHS_8l_9l + LHS_9l_9l + LHS_10l_9l + LHS_4r_9l + LHS_5r_9l + LHS_6r_9l + LHS_7r_9l + LHS_8r_9l + LHS_9r_9l + LHS_10r_9l;
% % LHS_10l = LHS_L_10l + LHS_R_10l + LHS_1_10l + LHS_2_10l + LHS_3_10l + LHS_4l_10l + LHS_5l_10l + LHS_6l_10l + LHS_7l_10l + LHS_8l_10l + LHS_9l_10l + LHS_10l_10l + LHS_4r_10l + LHS_5r_10l + LHS_6r_10l + LHS_7r_10l + LHS_8r_10l + LHS_9r_10l + LHS_10r_10l;
% % LHS_4r = LHS_L_4r + LHS_R_4r + LHS_1_4r + LHS_2_4r + LHS_3_4r + LHS_4l_4r + LHS_5l_4r + LHS_6l_4r + LHS_7l_4r + LHS_8l_4r + LHS_9l_4r + LHS_10l_4r + LHS_4r_4r + LHS_5r_4r + LHS_6r_4r + LHS_7r_4r + LHS_8r_4r + LHS_9r_4r + LHS_10r_4r;
% % LHS_5r = LHS_L_5r + LHS_R_5r + LHS_1_5r + LHS_2_5r + LHS_3_5r + LHS_4l_5r + LHS_5l_5r + LHS_6l_5r + LHS_7l_5r + LHS_8l_5r + LHS_9l_5r + LHS_10l_5r + LHS_4r_5r + LHS_5r_5r + LHS_6r_5r + LHS_7r_5r + LHS_8r_5r + LHS_9r_5r + LHS_10r_5r;
% % LHS_6r = LHS_L_6r + LHS_R_6r + LHS_1_6r + LHS_2_6r + LHS_3_6r + LHS_4l_6r + LHS_5l_6r + LHS_6l_6r + LHS_7l_6r + LHS_8l_6r + LHS_9l_6r + LHS_10l_6r + LHS_4r_6r + LHS_5r_6r + LHS_6r_6r + LHS_7r_6r + LHS_8r_6r + LHS_9r_6r + LHS_10r_6r;
% % LHS_7r = LHS_L_7r + LHS_R_7r + LHS_1_7r + LHS_2_7r + LHS_3_7r + LHS_4l_7r + LHS_5l_7r + LHS_6l_7r + LHS_7l_7r + LHS_8l_7r + LHS_9l_7r + LHS_10l_7r + LHS_4r_7r + LHS_5r_7r + LHS_6r_7r + LHS_7r_7r + LHS_8r_7r + LHS_9r_7r + LHS_10r_7r;
% % LHS_8r = LHS_L_8r + LHS_R_8r + LHS_1_8r + LHS_2_8r + LHS_3_8r + LHS_4l_8r + LHS_5l_8r + LHS_6l_8r + LHS_7l_8r + LHS_8l_8r + LHS_9l_8r + LHS_10l_8r + LHS_4r_8r + LHS_5r_8r + LHS_6r_8r + LHS_7r_8r + LHS_8r_8r + LHS_9r_8r + LHS_10r_8r;
% % LHS_9r = LHS_L_9r + LHS_R_9r + LHS_1_9r + LHS_2_9r + LHS_3_9r + LHS_4l_9r + LHS_5l_9r + LHS_6l_9r + LHS_7l_9r + LHS_8l_9r + LHS_9l_9r + LHS_10l_9r + LHS_4r_9r + LHS_5r_9r + LHS_6r_9r + LHS_7r_9r + LHS_8r_9r + LHS_9r_9r + LHS_10r_9r;
% % LHS_10r = LHS_L_10r + LHS_R_10r + LHS_1_10r + LHS_2_10r + LHS_3_10r + LHS_4l_10r + LHS_5l_10r + LHS_6l_10r + LHS_7l_10r + LHS_8l_10r + LHS_9l_10r + LHS_10l_10r + LHS_4r_10r + LHS_5r_10r + LHS_6r_10r + LHS_7r_10r + LHS_8r_10r + LHS_9r_10r + LHS_10r_10r;
% 
% % LHS = {LHS_x, LHS_psi, LHS_imu, LHS_w, LHS_torso, LHS_4l, LHS_5l, LHS_6l, LHS_7l, LHS_8l, LHS_9l, LHS_10l, LHS_4r, LHS_5r, LHS_6r, LHS_7r, LHS_8r, LHS_9r, LHS_10r};
% % keysEq = {'x', 'psi', 'imu', 'w', 'torso', '4l', '5l', '6l', '7l', '8l', '9l', '10l', '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% % ddq = ddqVec(f);
% % fid = fopen('LHSTotalOut.m','w');
% % n = 2742;
% % for i=1:19
% %     this = keysEq{i};
% %     thisLHS = LHS{i}; thisLHSRem = thisLHS; str = []; op = [];
% %     display(['% LHS_' this ' = ']); display('%'); display(['%    ' char(thisLHS)]);
% %     for k = 1:length(ddq)
% %         Z = diff(thisLHS,ddq(k));
% %         if(~isequal(Z,0))
% %             if(length(symvar(Z)) == 1)
% %                 charZ = char(Z);
% %                 if(charZ(1) == '-') op = []; end
% %                 str = [str op char(Z) '*' char(ddq(k))]; op ='+';
% %             else
% %                 n = n + 1;
% %                 display(['Z' num2str(n) ' = ' char(Z) ';']);
% %                 str = [str op 'Z' num2str(n) '*' char(ddq(k))]; op ='+';
% %             end
% %             thisLHSRem = simplify(thisLHSRem - Z*ddq(k));
% %         end
% %     end
% %     if(~isequal(thisLHSRem,0))
% %         if(length(symvar(thisLHSRem)) == 1)
% %             charZ = char(Z);
% %             if(charZ(1) == '-') op = []; end
% %             str = [str op char(thisLHSRem)];
% %         else
% %             n = n + 1;
% %             display(['Z' num2str(n) ' = ' char(thisLHSRem) ';']); display(' ');
% %             str = [str op 'Z' num2str(n)];
% %         end
% %     end
% %     strFull = ['LHS_' this ' = ' str ';']; 
% %     disp(strFull); display(' ');
% %     fprintf(fid,'%s\n\n',strFull);    
% % end
% % fclose(fid);
% syms Z2743 Z2744 Z2745 Z2746 Z2747 Z2748 Z2749 Z2750 Z2751 Z2752 Z2753 Z2754 Z2755 Z2756 Z2757 Z2758 Z2759 Z2760 Z2761 Z2762 Z2763 Z2764 Z2765 Z2766 Z2767 Z2768 Z2769 Z2770 Z2771 Z2772 Z2773 Z2774 Z2775 Z2776 Z2777 Z2778 Z2779 Z2780 Z2781 Z2782 Z2783 Z2784 Z2785 Z2786 Z2787 Z2788 Z2789 Z2790 Z2791 Z2792  real
% syms Z2793 Z2794 Z2795 Z2796 Z2797 Z2798 Z2799 Z2800 Z2801 Z2802 Z2803 Z2804 Z2805 Z2806 Z2807 Z2808 Z2809 Z2810 Z2811 Z2812 Z2813 Z2814 Z2815 Z2816 Z2817 Z2818 Z2819 Z2820 Z2821 Z2822 Z2823 Z2824 Z2825 Z2826 Z2827 Z2828 Z2829 Z2830 Z2831 Z2832 Z2833 Z2834 Z2835 Z2836 Z2837 Z2838 Z2839 Z2840 Z2841 Z2842  real
% syms Z2843 Z2844 Z2845 Z2846 Z2847 Z2848 Z2849 Z2850 Z2851 Z2852 Z2853 Z2854 Z2855 Z2856 Z2857 Z2858 Z2859 Z2860 Z2861 Z2862 Z2863 Z2864 Z2865 Z2866 Z2867 Z2868 Z2869 Z2870 Z2871 Z2872 Z2873 Z2874 Z2875 Z2876 Z2877 Z2878 Z2879 Z2880 Z2881 Z2882 Z2883 Z2884 Z2885 Z2886 Z2887 Z2888 Z2889 Z2890 Z2891 Z2892  real
% syms Z2893 Z2894 Z2895 Z2896 Z2897 Z2898 Z2899 Z2900 Z2901 Z2902 Z2903 Z2904 Z2905 Z2906 Z2907 Z2908 Z2909 Z2910 Z2911 Z2912 Z2913 Z2914 Z2915 Z2916 Z2917 Z2918 Z2919 Z2920 Z2921 Z2922 Z2923 Z2924 Z2925 Z2926 Z2927 Z2928 Z2929 Z2930 Z2931 Z2932 Z2933 Z2934 Z2935 Z2936 Z2937 Z2938 Z2939 Z2940 Z2941 Z2942  real
% syms Z2943 Z2944 Z2945 Z2946 Z2947 Z2948 Z2949 Z2950 Z2951 Z2952 Z2953 Z2954 Z2955 Z2956 Z2957 Z2958 Z2959 Z2960 Z2961 Z2962 Z2963 Z2964 Z2965 Z2966 Z2967 Z2968 Z2969 Z2970 Z2971 Z2972 Z2973 Z2974 Z2975 Z2976  real
% 
% LHS_x = Z2743*ddx+Z2744*ddpsi+Z2745*ddq_imu+Z2746*ddq_w+Z2747*ddq_torso+Z2748*ddq_1l+Z2749*ddq_2l+Z2750*ddq_3l+Z2751*ddq_4l+Z2752*ddq_5l+Z2753*ddq_6l+Z1609*ddq_7l+Z2754*ddq_1r+Z2755*ddq_2r+Z2756*ddq_3r+Z2757*ddq_4r+Z2758*ddq_5r+Z2759*ddq_6r+Z1677*ddq_7r+Z2760;
% 
% LHS_psi = Z2761*ddx+Z2762*ddpsi+Z2763*ddq_imu+Z2764*ddq_w+Z2765*ddq_torso+Z2766*ddq_1l+Z2767*ddq_2l+Z2768*ddq_3l+Z2769*ddq_4l+Z2770*ddq_5l+Z2771*ddq_6l+Z1768*ddq_7l+Z2772*ddq_1r+Z2773*ddq_2r+Z2774*ddq_3r+Z2775*ddq_4r+Z2776*ddq_5r+Z2777*ddq_6r+Z1836*ddq_7r+Z2778;
% 
% LHS_imu = Z2779*ddx+Z2780*ddpsi+Z2781*ddq_imu+Z2782*ddq_w+Z2783*ddq_torso+Z2784*ddq_1l+Z2785*ddq_2l+Z2786*ddq_3l+Z2787*ddq_4l+Z2788*ddq_5l+Z2789*ddq_6l+Z1917*ddq_7l+Z2790*ddq_1r+Z2791*ddq_2r+Z2792*ddq_3r+Z2793*ddq_4r+Z2794*ddq_5r+Z2795*ddq_6r+Z1985*ddq_7r+Z2796;
% 
% LHS_w = Z2797*ddx+Z2798*ddpsi+Z2799*ddq_imu+Z2800*ddq_w+Z2801*ddq_torso+Z2802*ddq_1l+Z2803*ddq_2l+Z2804*ddq_3l+Z2805*ddq_4l+Z2806*ddq_5l+Z2807*ddq_6l+Z2061*ddq_7l+Z2808*ddq_1r+Z2809*ddq_2r+Z2810*ddq_3r+Z2811*ddq_4r+Z2812*ddq_5r+Z2813*ddq_6r+Z2129*ddq_7r+Z2814;
% 
% LHS_torso = Z2815*ddx+Z2816*ddpsi+Z2817*ddq_imu+Z2818*ddq_w+Z2819*ddq_torso+Z2820*ddq_1l+Z2821*ddq_2l+Z2822*ddq_3l+Z2823*ddq_4l+Z2824*ddq_5l+Z2825*ddq_6l+Z2199*ddq_7l+Z2826*ddq_1r+Z2827*ddq_2r+Z2828*ddq_3r+Z2829*ddq_4r+Z2830*ddq_5r+Z2831*ddq_6r+Z2267*ddq_7r+Z2832;
% 
% LHS_4l = Z2833*ddx+Z2834*ddpsi+Z2835*ddq_imu+Z2836*ddq_w+Z2837*ddq_torso+Z2838*ddq_1l+Z2839*ddq_2l+Z2840*ddq_3l+Z2841*ddq_4l+Z2842*ddq_5l+Z2843*ddq_6l+Z2330*ddq_7l+Z2844;
% 
% LHS_5l = Z2845*ddx+Z2846*ddpsi+Z2847*ddq_imu+Z2848*ddq_w+Z2849*ddq_torso+Z2850*ddq_1l+Z2851*ddq_2l+Z2852*ddq_3l+Z2853*ddq_4l+Z2854*ddq_5l+Z2855*ddq_6l+Z2385*ddq_7l+Z2856;
% 
% LHS_6l = Z2857*ddx+Z2858*ddpsi+Z2859*ddq_imu+Z2860*ddq_w+Z2861*ddq_torso+Z2862*ddq_1l+Z2863*ddq_2l+Z2864*ddq_3l+Z2865*ddq_4l+Z2866*ddq_5l+Z2867*ddq_6l+Z2431*ddq_7l+Z2868;
% 
% LHS_7l = Z2869*ddx+Z2870*ddpsi+Z2871*ddq_imu+Z2872*ddq_w+Z2873*ddq_torso+Z2874*ddq_1l+Z2875*ddq_2l+Z2876*ddq_3l+Z2877*ddq_4l+Z2878*ddq_5l+Z2879*ddq_6l+Z2467*ddq_7l+Z2880;
% 
% LHS_8l = Z2881*ddx+Z2882*ddpsi+Z2883*ddq_imu+Z2884*ddq_w+Z2885*ddq_torso+Z2886*ddq_1l+Z2887*ddq_2l+Z2888*ddq_3l+Z2889*ddq_4l+Z2890*ddq_5l+Z2891*ddq_6l+Z2492*ddq_7l+Z2892;
% 
% LHS_9l = Z2893*ddx+Z2894*ddpsi+Z2895*ddq_imu+Z2896*ddq_w+Z2897*ddq_torso+Z2898*ddq_1l+Z2899*ddq_2l+Z2900*ddq_3l+Z2901*ddq_4l+Z2902*ddq_5l+Z2903*ddq_6l+Z2505*ddq_7l+Z2904;
% 
% LHS_10l = -Z1107*ddx-Z1108*ddpsi-Z1109*ddq_imu-Z1110*ddq_w-Z1111*ddq_torso-Z1112*ddq_1l-Z1113*ddq_2l-Z1114*ddq_3l-Z1115*ddq_4l-Z1116*ddq_5l-Z1117*ddq_6l-Z1118*ddq_7l+-Z1119;
% 
% LHS_4r = Z2905*ddx+Z2906*ddpsi+Z2907*ddq_imu+Z2908*ddq_w+Z2909*ddq_torso+Z2910*ddq_1r+Z2911*ddq_2r+Z2912*ddq_3r+Z2913*ddq_4r+Z2914*ddq_5r+Z2915*ddq_6r+Z2566*ddq_7r+Z2916;
% 
% LHS_5r = Z2917*ddx+Z2918*ddpsi+Z2919*ddq_imu+Z2920*ddq_w+Z2921*ddq_torso+Z2922*ddq_1r+Z2923*ddq_2r+Z2924*ddq_3r+Z2925*ddq_4r+Z2926*ddq_5r+Z2927*ddq_6r+Z2621*ddq_7r+Z2928;
% 
% LHS_6r = Z2929*ddx+Z2930*ddpsi+Z2931*ddq_imu+Z2932*ddq_w+Z2933*ddq_torso+Z2934*ddq_1r+Z2935*ddq_2r+Z2936*ddq_3r+Z2937*ddq_4r+Z2938*ddq_5r+Z2939*ddq_6r+Z2667*ddq_7r+Z2940;
% 
% LHS_7r = Z2941*ddx+Z2942*ddpsi+Z2943*ddq_imu+Z2944*ddq_w+Z2945*ddq_torso+Z2946*ddq_1r+Z2947*ddq_2r+Z2948*ddq_3r+Z2949*ddq_4r+Z2950*ddq_5r+Z2951*ddq_6r+Z2703*ddq_7r+Z2952;
% 
% LHS_8r = Z2953*ddx+Z2954*ddpsi+Z2955*ddq_imu+Z2956*ddq_w+Z2957*ddq_torso+Z2958*ddq_1r+Z2959*ddq_2r+Z2960*ddq_3r+Z2961*ddq_4r+Z2962*ddq_5r+Z2963*ddq_6r+Z2728*ddq_7r+Z2964;
% 
% LHS_9r = Z2965*ddx+Z2966*ddpsi+Z2967*ddq_imu+Z2968*ddq_w+Z2969*ddq_torso+Z2970*ddq_1r+Z2971*ddq_2r+Z2972*ddq_3r+Z2973*ddq_4r+Z2974*ddq_5r+Z2975*ddq_6r+Z2741*ddq_7r+Z2976;
% 
% LHS_10r = -Z1509*ddx-Z1510*ddpsi-Z1511*ddq_imu-Z1512*ddq_w-Z1513*ddq_torso-Z1514*ddq_1r-Z1515*ddq_2r-Z1516*ddq_3r-Z1517*ddq_4r-Z1518*ddq_5r-Z1519*ddq_6r-Z1520*ddq_7r-Z1521;
% 
% %% RHS
% 
% % End-effector forces and torques
% syms Flx Fly Flz Frx Fry Frz Tlx Tly Tlz Trx Try Trz real
% % Fl = [Flx Fly Flz]'; Tl = [Tlx Tly Tlz]'; % expressed in frame 10l
% % Fr = [Frx Fry Frz]'; Tr = [Trx Try Trz]'; % expressed in frame 10r
% % keysEq = {'x', 'psi', 'imu', 'w', 'torso', '4l', '5l', '6l', '7l', '8l', '9l', '10l', '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% % 
% % for i=1:19
% %     EEffTerm = collect(Fl'*dv10l(:,i) + Tl'*dw10l(:,i) + Fr'*dv10r(:,i) + Tr'*dw10r(:,i),[Flx, Fly, Flz, Tlx, Tly, Tlz, Frx, Fry, Frz, Trx, Try, Trz]);
% %     display(['EE_' keysEq{i} ' = ' char(EEffTerm) ';']);
% % end
% 
% EE_x = Z368*Flx + Z379*Fly + (-Z348)*Flz + Z492*Frx + Z503*Fry + (-Z472)*Frz;
% EE_psi = Z369*Flx + Z380*Fly + (-Z349)*Flz + Z116*Tlx + Z125*Tly + (-Z97)*Tlz + Z493*Frx + Z504*Fry + (-Z473)*Frz + Z221*Trx + Z230*Try + (-Z202)*Trz;
% EE_imu = Z370*Flx + Z381*Fly + (-Z350)*Flz + Z117*Tlx + Z126*Tly + (-Z98)*Tlz + Z494*Frx + Z505*Fry + (-Z474)*Frz + Z222*Trx + Z231*Try + (-Z203)*Trz;
% EE_w = Z371*Flx + Z382*Fly + (-Z351)*Flz + Z117*Tlx + Z126*Tly + (-Z98)*Tlz + Z495*Frx + Z506*Fry + (-Z475)*Frz + Z222*Trx + Z231*Try + (-Z203)*Trz;
% EE_torso = Z372*Flx + Z383*Fly + (-Z352)*Flz + Z118*Tlx + Z127*Tly + (-Z99)*Tlz + Z496*Frx + Z507*Fry + (-Z476)*Frz + Z223*Trx + Z232*Try + (-Z204)*Trz;
% EE_4l = Z373*Flx + Z384*Fly + (-Z353)*Flz + Z119*Tlx + Z128*Tly + (-Z100)*Tlz;
% EE_5l = Z374*Flx + Z385*Fly + (-Z354)*Flz + Z120*Tlx + Z129*Tly + (-Z101)*Tlz;
% EE_6l = Z375*Flx + Z386*Fly + (-Z355)*Flz + Z121*Tlx + Z130*Tly + (-Z102)*Tlz;
% EE_7l = Z376*Flx + Z387*Fly + (-Z356)*Flz + Z122*Tlx + Z131*Tly + (-Z103)*Tlz;
% EE_8l = Z377*Flx + Z388*Fly + Z123*Tlx + Z132*Tly + (-Z104)*Tlz;
% EE_9l = Z378*Flx + Z389*Fly + Z124*Tlx + Z133*Tly;
% EE_10l = (-1)*Tlz;
% EE_4r = Z497*Frx + Z508*Fry + (-Z477)*Frz + Z224*Trx + Z233*Try + (-Z205)*Trz;
% EE_5r = Z498*Frx + Z509*Fry + (-Z478)*Frz + Z225*Trx + Z234*Try + (-Z206)*Trz;
% EE_6r = Z499*Frx + Z510*Fry + (-Z479)*Frz + Z226*Trx + Z235*Try + (-Z207)*Trz;
% EE_7r = Z500*Frx + Z511*Fry + (-Z480)*Frz + Z227*Trx + Z236*Try + (-Z208)*Trz;
% EE_8r = Z501*Frx + Z512*Fry + Z228*Trx + Z237*Try + (-Z209)*Trz;
% EE_9r = Z502*Frx + Z513*Fry + Z229*Trx + Z238*Try;
% EE_10r = (-1)*Trz;

% Gravitational forces
syms g real
% g_1 = Rot(f, '0', '1')*[0 0 -g]'
g_1 = [0; -Z13*g; -Z14*g];

% g_2 = collect(Rot(f, '1', '2')*g_1,g)
g_2 = [0; -Z20*g; -Z21*g];

% g_3 = collect(Rot(f, '2', '3')*g_2,g)
g_3 = [-Z26*g; -Z20*g; -Z28*g];

% g_4l = collect(Rot(f, '3', '4l')*g_3,g)
% syms Z2977 Z2978 real
g_4l = [-Z32*g; -Z26*g; -Z35*g];
 
% g_5l = collect(Rot(f, '4l', '5l')*g_4l,g)
g_5l = [Z32*g; -Z41*g; -Z45*g];
 
% g_6l = collect(Rot(f, '5l', '6l')*g_5l,g)
g_6l = [-Z52*g; Z41*g; -Z57*g];

% g_7l = collect(Rot(f, '6l', '7l')*g_6l,g)
g_7l = [Z52*g; -Z65*g; -Z71*g];

% g_8l = collect(Rot(f, '7l', '8l')*g_7l,g)
g_8l = [-Z80*g; Z65*g; -Z87*g];

% g_9l = collect(Rot(f, '8l', '9l')*g_8l,g)
g_9l = [Z80*g; -Z97*g; -Z105*g];

% g_10l = collect(Rot(f, '9l', '10l')*g_9l,g)
g_10l = [-Z116*g; -Z125*g; Z97*g];
 
% g_4r = collect(Rot(f, '3', '4r')*g_3,g)
g_4r = [-Z137*g; Z26*g; -Z140*g];
 
%g_5r = collect(Rot(f, '4r', '5r')*g_4r,g)
% syms Z2993 Z2994 real
g_5r = [Z137*g; -Z146*g; -Z150*g];
 
% g_6r = correct(Rot(f, '5r', '6r')*g_5r,g)
g_6r = [-Z157*g; Z146*g; -Z162*g];


% g_7r = correct(Rot(f, '6r', '7r')*g_6r,g)
g_7r = [Z157*g; -Z170*g; -Z176*g];

% g_8r = correct(Rot(f, '7r', '8r')*g_7r,g)
g_8r = [-Z185*g; Z170*g; -Z192*g];

% g_9r = correct(Rot(f, '8r', '9r')*g_8r,g)
g_9r = [Z185*g; -Z202*g; -Z210*g];

% g_10r = correct(Rot(f, '9r', '10r')*g_9r,g)
g_10r = [-Z221*g; -Z230*g; Z202*g];

 
% gg = {g_1, g_2, g_3, g_4l, g_5l, g_6l, g_7l, g_8l, g_9l, g_10l, g_4r, g_5r, g_6r, g_7r, g_8r, g_9r, g_10r};
% keysBody = {'1', '2', '3', '4l', '5l', '6l', '7l', '8l', '9l', '10l', '4r', '5r', '6r', '7r', '8r', '9r', '10r'};
% n = 2976;
% for i=1:17
%     this = keysBody{i};
%     mS = mCOM(f, this);
%     mSxg = cross(mS, gg{i});
%     display(['% mSxg_' this ' = ']); display(['%    ' char(mSxg(1))]); display(['%    ' char(mSxg(2))]); display(['%    ' char(mSxg(3))]); 
%     str = ['mSxg_' this ' = ['];
%     for j = 1:3
%         Z = diff(mSxg(j), g);
%         if(~isequal(Z,0))
%             if(length(symvar(Z)) == 1)
%                 str = [str char(Z) '*g;'];
%             else
%                 n = n + 1;
%                 display(['Z' num2str(n) ' = ' char(Z) ';']);
%                 str = [str 'Z' num2str(n) '*g;'];
%             end
%         else
%             str = [str '0;'];
%         end
%     end
%     str(end) = ']'; str = [str ';'];
%     disp(str); display(' ');
% end

syms Z2977 Z2978 Z2979 Z2980 Z2981 Z2982 Z2983 Z2984 Z2985 Z2986 Z2987 Z2988 Z2989 Z2990 Z2991 Z2992 Z2993 Z2994 Z2995 Z2996 Z2997 Z2998 Z2999 Z3000 Z3001 Z3002 Z3003 Z3004 Z3005 Z3006 Z3007 Z3008 Z3009 Z3010 Z3011 Z3012 Z3013 Z3014 Z3015 Z3016 Z3017 Z3018 Z3019 Z3020 Z3021 Z3022 Z3023 Z3024 Z3025 Z3026  real
syms Z3027  real

mSxg_1 = [Z2977*g;Z2978*g;Z2979*g];
mSxg_2 = [Z2980*g;Z2981*g;Z2982*g];
mSxg_3 = [Z2983*g;Z2984*g;Z2985*g];
mSxg_4l = [Z2986*g;Z2987*g;Z2988*g];
mSxg_5l = [Z2989*g;Z2990*g;Z2991*g];
mSxg_6l = [Z2992*g;Z2993*g;Z2994*g];
mSxg_7l = [Z2995*g;Z2996*g;Z2997*g];
mSxg_8l = [Z2998*g;Z2999*g;Z3000*g];
mSxg_9l = [Z3001*g;Z3002*g;Z3003*g];
mSxg_10l = [Z3004*g;Z3005*g;Z3006*g];
mSxg_4r = [Z3007*g;Z3008*g;Z3009*g];
mSxg_5r = [Z3010*g;Z3011*g;Z3012*g];
mSxg_6r = [Z3013*g;Z3014*g;Z3015*g];
mSxg_7r = [Z3016*g;Z3017*g;Z3018*g];
mSxg_8r = [Z3019*g;Z3020*g;Z3021*g];
mSxg_9r = [Z3022*g;Z3023*g;Z3024*g];
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

G_x = Z3028*g;
G_psi = Z3029*g;
G_imu = Z3030*g;
G_w = Z3031*g;
G_torso = Z3032*g;
G_4l = Z3033*g;
G_5l = Z3034*g;
G_6l = Z3035*g;
G_7l = Z3036*g;
G_8l = Z3037*g;
G_9l = Z3038*g;
G_10l = (-Z3006)*g;
G_4r = Z3039*g;
G_5r = Z3040*g;
G_6r = Z3041*g;
G_7r = Z3042*g;
G_8r = Z3043*g;
G_9r = Z3044*g;
G_10r = (-Z3027)*g;