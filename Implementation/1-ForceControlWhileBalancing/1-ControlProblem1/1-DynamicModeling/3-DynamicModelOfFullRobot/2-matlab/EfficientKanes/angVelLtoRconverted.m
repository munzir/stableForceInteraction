% w6ri = Rot(f, '6r', '7r') * w6ri + f('7r').e*f('7r').dq
% w6ri =
%  
%  Z137*sin(q_3r) - Z135*cos(q_3r)
%                  - Z136 - dq_3r
%  Z137*cos(q_3r) + Z135*sin(q_3r)
%  
%  
% w6re =
%  
%     (Z129*cos(q_3r) + Z142*sin(q_3r))*dpsi + (Z130*cos(q_3r) + Z143*sin(q_3r))*dq_imu + (Z130*cos(q_3r) + Z143*sin(q_3r))*dq_w + (Z131*cos(q_3r) + Z144*sin(q_3r))*dq_torso + (Z145*sin(q_3r))*dq_1r + cos(q_3r)*dq_2r
%                                                                                                                            (-Z138)*dpsi + (-Z139)*dq_imu + (-Z139)*dq_w + (-Z140)*dq_torso + (-Z141)*dq_1r - dq_3r
%  (Z142*cos(q_3r) - Z129*sin(q_3r))*dpsi + (Z143*cos(q_3r) - Z130*sin(q_3r))*dq_imu + (Z143*cos(q_3r) - Z130*sin(q_3r))*dq_w + (Z144*cos(q_3r) - Z131*sin(q_3r))*dq_torso + (Z145*cos(q_3r))*dq_1r + (-sin(q_3r))*dq_2r

Z146 = Z137*sin(q_3r) - Z135*cos(q_3r);
Z147 =                 - Z136 - dq_3r;
Z148 = Z137*cos(q_3r) + Z135*sin(q_3r);
Z149 = (Z129*cos(q_3r) + Z142*sin(q_3r));
Z150 = + (Z130*cos(q_3r) + Z143*sin(q_3r));
Z151 = + (Z131*cos(q_3r) + Z144*sin(q_3r));
Z152 = + (Z145*sin(q_3r)); 
Z153 = + cos(q_3r);
Z154 = (Z142*cos(q_3r) - Z129*sin(q_3r)); 
Z155 = + (Z143*cos(q_3r) - Z130*sin(q_3r));
Z156 = + (Z144*cos(q_3r) - Z131*sin(q_3r));
Z157 = + (Z145*cos(q_3r)); 
Z158 = + (-sin(q_3r));
 
w6ri = [Z146;Z147;Z148]; 
w6re = [Z149*dpsi+Z150*dq_imu+Z150*dq_w+Z151*dq_torso+Z152*dq_1r+Z153*dq_2r;
    (-Z138)*dpsi + (-Z139)*dq_imu + (-Z139)*dq_w + (-Z140)*dq_torso + (-Z141)*dq_1r - dq_3r;
    Z154*dpsi+Z155*dq_imu+Z155*dq_w+Z156*dq_torso+Z157*dq_1r+Z158*dq_2r;]; 
dw6r = [[0 0 0]' [Z149 -Z138 Z154]' [Z150 -Z139 Z155]' [Z150 -Z139 Z155]' ...
    [Z151 -Z140 Z156]' [Z152 -Z141 Z157]' [Z153 0 Z158]' [0 -1 0]' zeros(3,11)];

% w7r = Rot(f, '6r', '7r') * w6r + f('7r').e*f('7r').dq
% w7ri =
%  
%                    - Z146 - dq_4r
%  - Z147*cos(q_4r) - Z148*sin(q_4r)
%    Z148*cos(q_4r) - Z147*sin(q_4r)
%  
%  
% w7re =
%  
%                                                                                                                                                   (-Z149)*dpsi + (-Z150)*dq_imu + (-Z150)*dq_w + (-Z151)*dq_torso + (-Z152)*dq_1r + (-Z153)*dq_2r - dq_4r
%  (Z138*cos(q_4r) - Z154*sin(q_4r))*dpsi + (Z139*cos(q_4r) - Z155*sin(q_4r))*dq_imu + (Z139*cos(q_4r) - Z155*sin(q_4r))*dq_w + (Z140*cos(q_4r) - Z156*sin(q_4r))*dq_torso + (Z141*cos(q_4r) - Z157*sin(q_4r))*dq_1r + (-Z158*sin(q_4r))*dq_2r + cos(q_4r)*dq_3r
%   (Z154*cos(q_4r) + Z138*sin(q_4r))*dpsi + (Z155*cos(q_4r) + Z139*sin(q_4r))*dq_imu + (Z155*cos(q_4r) + Z139*sin(q_4r))*dq_w + (Z156*cos(q_4r) + Z140*sin(q_4r))*dq_torso + (Z157*cos(q_4r) + Z141*sin(q_4r))*dq_1r + (Z158*cos(q_4r))*dq_2r + sin(q_4r)*dq_3r

Z159 =                   - Z146 - dq_4r;
Z160 = - Z147*cos(q_4r) - Z148*sin(q_4r);
Z161 =   Z148*cos(q_4r) - Z147*sin(q_4r);
Z162 = (Z138*cos(q_4r) - Z154*sin(q_4r)); 
Z163 = + (Z139*cos(q_4r) - Z155*sin(q_4r));
Z164 = + (Z140*cos(q_4r) - Z156*sin(q_4r));
Z165 = + (Z141*cos(q_4r) - Z157*sin(q_4r));
Z166 = + (-Z158*sin(q_4r)); 
Z167 = + cos(q_4r);
Z168 = (Z154*cos(q_4r) + Z138*sin(q_4r));
Z169 = + (Z155*cos(q_4r) + Z139*sin(q_4r));
Z170 = + (Z156*cos(q_4r) + Z140*sin(q_4r));
Z171 = + (Z157*cos(q_4r) + Z141*sin(q_4r));
Z172 = + (Z158*cos(q_4r)); 
Z173 = + sin(q_4r);

w7ri = [Z159; Z160; Z161];
w7re = [(-Z149)*dpsi + (-Z150)*dq_imu + (-Z150)*dq_w + (-Z151)*dq_torso + (-Z152)*dq_1r + (-Z153)*dq_2r - dq_4r;
    Z162*dpsi+Z163*dq_imu+Z163*dq_w+Z164*dq_torso+Z165*dq_1r+Z166*dq_2r+Z167*dq_3r;
    Z168*dpsi+Z169*dq_imu+Z169*dq_w+Z170*dq_torso+Z171*dq_1r+Z172*dq_2r+Z173*dq_3r];
dw7r = [[0 0 0]' [-Z149 Z162 Z168]' [-Z150 Z163 Z169]' [-Z150 Z163 Z169]' ...
    [-Z151 Z164 Z170]' [-Z152 Z165 Z171]' [-Z153 Z166 Z172]' [0 Z167 Z173]' ...
    [-1 0 0]' zeros(3,10)];

% w8ri = Rot(f, '7r', '8r') * w7ri + f('8r').e*f('8r').dq
% w8re = correct(Rot(f, '7r', '8r') * w7re + f('8r').e*f('8r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r])
% w8ri =
%  
%  Z161*sin(q_5r) - Z159*cos(q_5r)
%                  - Z160 - dq_5r
%  Z161*cos(q_5r) + Z159*sin(q_5r)
%  
%  
% w8re =
%  
%     (Z149*cos(q_5r) + Z168*sin(q_5r))*dpsi + (Z150*cos(q_5r) + Z169*sin(q_5r))*dq_imu + (Z150*cos(q_5r) + Z169*sin(q_5r))*dq_w + (Z151*cos(q_5r) + Z170*sin(q_5r))*dq_torso + (Z152*cos(q_5r) + Z171*sin(q_5r))*dq_1r + (Z153*cos(q_5r) + Z172*sin(q_5r))*dq_2r + (Z173*sin(q_5r))*dq_3r + cos(q_5r)*dq_4r
%                                                                                                                                                                             (-Z162)*dpsi + (-Z163)*dq_imu + (-Z163)*dq_w + (-Z164)*dq_torso + (-Z165)*dq_1r + (-Z166)*dq_2r + (-Z167)*dq_3r - dq_5r
%  (Z168*cos(q_5r) - Z149*sin(q_5r))*dpsi + (Z169*cos(q_5r) - Z150*sin(q_5r))*dq_imu + (Z169*cos(q_5r) - Z150*sin(q_5r))*dq_w + (Z170*cos(q_5r) - Z151*sin(q_5r))*dq_torso + (Z171*cos(q_5r) - Z152*sin(q_5r))*dq_1r + (Z172*cos(q_5r) - Z153*sin(q_5r))*dq_2r + (Z173*cos(q_5r))*dq_3r + (-sin(q_5r))*dq_4r

Z174 =  Z161*sin(q_5r) - Z159*cos(q_5r);
Z175 =                 - Z160 - dq_5r;
Z176 = Z161*cos(q_5r) + Z159*sin(q_5r);
Z177 = (Z149*cos(q_5r) + Z168*sin(q_5r));
Z178 = + (Z150*cos(q_5r) + Z169*sin(q_5r));
Z179 = + (Z151*cos(q_5r) + Z170*sin(q_5r));
Z180 = + (Z152*cos(q_5r) + Z171*sin(q_5r));
Z181 = + (Z153*cos(q_5r) + Z172*sin(q_5r));
Z182 = + (Z173*sin(q_5r));
Z183 = + cos(q_5r);
Z184 = (Z168*cos(q_5r) - Z149*sin(q_5r));
Z185 = + (Z169*cos(q_5r) - Z150*sin(q_5r));
Z186 = + (Z170*cos(q_5r) - Z151*sin(q_5r));
Z187 = + (Z171*cos(q_5r) - Z152*sin(q_5r));
Z188 = + (Z172*cos(q_5r) - Z153*sin(q_5r));
Z189 = + (Z173*cos(q_5r));
Z190 = + (-sin(q_5r));

w8ri = [Z174; Z175; Z176];
w8re = [Z177*dpsi+Z178*dq_imu+Z178*dq_w+Z179*dq_torso+Z180*dq_1r+Z181*dq_2r+Z182*dq_3r+Z183*dq_4r;
    (-Z162)*dpsi + (-Z163)*dq_imu + (-Z163)*dq_w + (-Z164)*dq_torso + (-Z165)*dq_1r + (-Z166)*dq_2r + (-Z167)*dq_3r - dq_5r;
    Z184*dpsi+Z185*dq_imu+Z185*dq_w+Z186*dq_torso+Z187*dq_1r+Z188*dq_2r+Z189*dq_3r+Z190*dq_4r];
dw8r = [[0 0 0]' [Z177 -Z162 Z184]' [Z178 -Z163 Z185]' [Z178 -Z163 Z185]' ...
    [Z179 -Z164 Z186]' [Z180 -Z165 Z187]' [Z181 -Z166 Z188]' [Z182 -Z167 Z189]' ...
    [Z183 0 Z190]' [0 -1 0]' zeros(3,9)];

% w9ri = Rot(f, '8r', '9r') * w8ri + f('9r').e*f('9r').dq
% w9re = correct(Rot(f, '8r', '9r') * w8re + f('9r').e*f('9r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r])
% w9ri =
%  
%                    - Z174 - dq_6r
%  - Z175*cos(q_6r) - Z176*sin(q_6r)
%    Z176*cos(q_6r) - Z175*sin(q_6r)
%  
%  
% w9re =
%  
%                                                                                                                                                                                                     (-Z177)*dpsi + (-Z178)*dq_imu + (-Z178)*dq_w + (-Z179)*dq_torso + (-Z180)*dq_1r + (-Z181)*dq_2r + (-Z182)*dq_3r + (-Z183)*dq_4r - dq_6r
%  (Z162*cos(q_6r) - Z184*sin(q_6r))*dpsi + (Z163*cos(q_6r) - Z185*sin(q_6r))*dq_imu + (Z163*cos(q_6r) - Z185*sin(q_6r))*dq_w + (Z164*cos(q_6r) - Z186*sin(q_6r))*dq_torso + (Z165*cos(q_6r) - Z187*sin(q_6r))*dq_1r + (Z166*cos(q_6r) - Z188*sin(q_6r))*dq_2r + (Z167*cos(q_6r) - Z189*sin(q_6r))*dq_3r + (-Z190*sin(q_6r))*dq_4r + cos(q_6r)*dq_5r
%   (Z184*cos(q_6r) + Z162*sin(q_6r))*dpsi + (Z185*cos(q_6r) + Z163*sin(q_6r))*dq_imu + (Z185*cos(q_6r) + Z163*sin(q_6r))*dq_w + (Z186*cos(q_6r) + Z164*sin(q_6r))*dq_torso + (Z187*cos(q_6r) + Z165*sin(q_6r))*dq_1r + (Z188*cos(q_6r) + Z166*sin(q_6r))*dq_2r + (Z189*cos(q_6r) + Z167*sin(q_6r))*dq_3r + (Z190*cos(q_6r))*dq_4r + sin(q_6r)*dq_5r
  
Z191 =                   - Z174 - dq_6r;
Z192 = - Z175*cos(q_6r) - Z176*sin(q_6r);
Z193 =   Z176*cos(q_6r) - Z175*sin(q_6r);
Z194 = (Z162*cos(q_6r) - Z184*sin(q_6r));
Z195 = + (Z163*cos(q_6r) - Z185*sin(q_6r));
Z196 = + (Z164*cos(q_6r) - Z186*sin(q_6r));
Z197 = + (Z165*cos(q_6r) - Z187*sin(q_6r));
Z198 = + (Z166*cos(q_6r) - Z188*sin(q_6r)):
Z199 = + (Z167*cos(q_6r) - Z189*sin(q_6r));
Z200 = + (-Z190*sin(q_6r)); 
Z201 = + cos(q_6r);
Z202 = (Z184*cos(q_6r) + Z162*sin(q_6r));
Z203 = + (Z185*cos(q_6r) + Z163*sin(q_6r));
Z204 = + (Z186*cos(q_6r) + Z164*sin(q_6r));
Z205 = + (Z187*cos(q_6r) + Z165*sin(q_6r));
Z206 = + (Z188*cos(q_6r) + Z166*sin(q_6r));
Z207 = + (Z189*cos(q_6r) + Z167*sin(q_6r)):
Z208 = + (Z190*cos(q_6r));
Z209 = + sin(q_6r);

w9ri = [Z191; Z192; Z193];
w9re = [(-Z177)*dpsi + (-Z178)*dq_imu + (-Z178)*dq_w + (-Z179)*dq_torso + (-Z180)*dq_1r + (-Z181)*dq_2r + (-Z182)*dq_3r + (-Z183)*dq_4r - dq_6r;
    Z194*dpsi+Z195*dq_imu+Z195*dq_w+Z196*dq_torso+Z197*dq_1r+Z198*dq_2r+Z199*dq_3r+Z200*dq_4r+Z201*dq_5r;
    Z202*dpsi+Z203*dq_imu+Z203*dq_w+Z204*dq_torso+Z205*dq_1r+Z206*dq_2r+Z207*dq_3r+Z208*dq_4r+Z209*dq_5r];
dw9r = [[0 0 0]' [-Z177 Z194 Z202]' [-Z178 Z195 Z203]' [-Z178 Z195 Z203]' ...
    [-Z179 Z196 Z204]' [-Z180 Z197 Z205]' [-Z181 Z198 Z206]' [-Z182 Z199 Z207]' ...
    [-Z183 Z200 Z208]' [0 Z201 Z209]' [-1 0 0]' zeros(3,18)];


% w10ri = Rot(f, '9r', '10r') * w9ri + f('10r').e*f('10r').dq
% w10re = correct(Rot(f, '9r', '10r') * w9re + f('10r').e*f('10r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r,dq_7r])
% w10ri =
%  
%    Z193*sin(q_7r) - Z191*cos(q_7r)
%  - Z193*cos(q_7r) - Z191*sin(q_7r)
%                    - Z192 - dq_7r
%  
%  
% w10re =
%  
%   (Z177*cos(q_7r) + Z202*sin(q_7r))*dpsi + (Z178*cos(q_7r) + Z203*sin(q_7r))*dq_imu + (Z178*cos(q_7r) + Z203*sin(q_7r))*dq_w + (Z179*cos(q_7r) + Z204*sin(q_7r))*dq_torso + (Z180*cos(q_7r) + Z205*sin(q_7r))*dq_1r + (Z181*cos(q_7r) + Z206*sin(q_7r))*dq_2r + (Z182*cos(q_7r) + Z207*sin(q_7r))*dq_3r + (Z183*cos(q_7r) + Z208*sin(q_7r))*dq_4r + (Z209*sin(q_7r))*dq_5r + cos(q_7r)*dq_6r
%  (Z177*sin(q_7r) - Z202*cos(q_7r))*dpsi + (Z178*sin(q_7r) - Z203*cos(q_7r))*dq_imu + (Z178*sin(q_7r) - Z203*cos(q_7r))*dq_w + (Z179*sin(q_7r) - Z204*cos(q_7r))*dq_torso + (Z180*sin(q_7r) - Z205*cos(q_7r))*dq_1r + (Z181*sin(q_7r) - Z206*cos(q_7r))*dq_2r + (Z182*sin(q_7r) - Z207*cos(q_7r))*dq_3r + (Z183*sin(q_7r) - Z208*cos(q_7r))*dq_4r + (-Z209*cos(q_7r))*dq_5r + sin(q_7r)*dq_6r
%                                                                                                                                                                                                                                   (-Z194)*dpsi + (-Z195)*dq_imu + (-Z195)*dq_w + (-Z196)*dq_torso + (-Z197)*dq_1r + (-Z198)*dq_2r + (-Z199)*dq_3r + (-Z200)*dq_4r + (-Z201)*dq_5r - dq_7r

Z210 = Z193*sin(q_7r) - Z191*cos(q_7r);
Z211 = - Z193*cos(q_7r) - Z191*sin(q_7r);
Z212 =                   - Z192 - dq_7r;
Z213 = (Z177*cos(q_7r) + Z202*sin(q_7r));
Z214 = + (Z178*cos(q_7r) + Z203*sin(q_7r));
Z215 = + (Z179*cos(q_7r) + Z204*sin(q_7r)):
Z216 = + (Z180*cos(q_7r) + Z205*sin(q_7r));
Z217 = + (Z181*cos(q_7r) + Z206*sin(q_7r)):
Z218 = + (Z182*cos(q_7r) + Z207*sin(q_7r));
Z219 = + (Z183*cos(q_7r) + Z208*sin(q_7r));
Z220 = + (Z209*sin(q_7r));
Z221 = + cos(q_7r);
Z222 = (Z177*sin(q_7r) - Z202*cos(q_7r));
Z223 = + (Z178*sin(q_7r) - Z203*cos(q_7r));
Z224 = + (Z179*sin(q_7r) - Z204*cos(q_7r));
Z225 = + (Z180*sin(q_7r) - Z205*cos(q_7r));
Z226 = + (Z181*sin(q_7r) - Z206*cos(q_7r));
Z227 = + (Z182*sin(q_7r) - Z207*cos(q_7r));
Z228 = + (Z183*sin(q_7r) - Z208*cos(q_7r));
Z229 = + (-Z209*cos(q_7r));
Z230 = + sin(q_7r);

w10ri = [Z210; Z211; Z212];
w10re = [(-Z194)*dpsi + (-Z195)*dq_imu + (-Z195)*dq_w + (-Z196)*dq_torso + (-Z197)*dq_1r + (-Z198)*dq_2r + (-Z199)*dq_3r + (-Z200)*dq_4r + (-Z201)*dq_5r - dq_7r;
    Z213*dpsi+Z214*dq_imu+Z214*dq_w+Z215*dq_torso+Z216*dq_1r+Z217*dq_2r+Z218*dq_3r+Z219*dq_4r+Z220*dq_5r+Z221*dq_6r;
    Z222*dpsi+Z223*dq_imu+Z223*dq_w+Z224*dq_torso+Z225*dq_1r+Z226*dq_2r+Z227*dq_3r+Z228*dq_4r+Z229*dq_5r+Z230*dq_6r];
dw10r = [[0 0 0]' [-Z194 Z213 Z222]' [-Z195 Z214 Z223]' [-Z195 Z214 Z223]' ...
    [-Z196 Z215 Z224]' [-Z197 Z216 Z225]' [-Z198 Z217 Z226]' [-Z199 Z218 Z227]' ...
    [-Z200 Z219 Z228]' [-Z201 Z220 Z229]' [0 Z221 Z230]' [-1 0 0]' zeros(3,7)];


%%
% w5ri = Rot(f, '4r', '5r') * w4ri + f('5r').e*f('5r').dq
% w5re = correct(Rot(f, '4r', '5r') * w4re + f('5r').e*f('5r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r])
syms dq_2r Z135 Z136 Z137 Z138 Z139 Z140 Z141 Z142 Z143 Z144 Z145 rear
w5ri = [Z135; Z136; Z137];
w5re = [(-Z129)*dpsi+(-Z130)*dq_imu+(-Z130)*dq_w+(-Z131)*dq_torso-dq_2r;
    Z138*dpsi+Z139*dq_imu+Z139*dq_w+Z140*dq_torso+Z141*dq_1r;
    Z142*dpsi+Z143*dq_imu+Z143*dq_w+Z144*dq_torso+Z145*dq_1r];    

% w6ri = Rot(f, '5r', '6r') * w5ri + f('6r').e*f('6r').dq
% w6re = correct(Rot(f, '5r', '6r') * w5re + f('6r').e*f('6r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r])
syms dq_3r Z146 Z147 Z148 Z149 Z150 Z151 Z152 Z153 Z154 Z155 Z156 Z157 Z158 rear
w6ri = [Z146;Z147;Z148]; 
w6re = [Z149*dpsi+Z150*dq_imu+Z150*dq_w+Z151*dq_torso+Z152*dq_1r+Z153*dq_2r;
    (-Z138)*dpsi + (-Z139)*dq_imu + (-Z139)*dq_w + (-Z140)*dq_torso + (-Z141)*dq_1r - dq_3r;
    Z154*dpsi+Z155*dq_imu+Z155*dq_w+Z156*dq_torso+Z157*dq_1r+Z158*dq_2r;]; 

% w7ri = Rot(f, '6r', '7r') * w6ri + f('7r').e*f('7r').dq
% w7re = correct(Rot(f, '6r', '7r') * w6re + f('7r').e*f('7r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r])
syms dq_4r Z159 Z160 Z161 Z162 Z163 Z164 Z165 Z166 Z167 Z168 Z169 Z170 Z171 Z172 Z173 rear
w7ri = [Z159; Z160; Z161];
w7re = [(-Z149)*dpsi + (-Z150)*dq_imu + (-Z150)*dq_w + (-Z151)*dq_torso + (-Z152)*dq_1r + (-Z153)*dq_2r - dq_4r;
    Z162*dpsi+Z163*dq_imu+Z163*dq_w+Z164*dq_torso+Z165*dq_1r+Z166*dq_2r+Z167*dq_3r;
    Z168*dpsi+Z169*dq_imu+Z169*dq_w+Z170*dq_torso+Z171*dq_1r+Z172*dq_2r+Z173*dq_3r];

% w8ri = Rot(f, '7r', '8r') * w7ri + f('8r').e*f('8r').dq
% w8re = correct(Rot(f, '7r', '8r') * w7re + f('8r').e*f('8r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r])
syms dq_5r Z174 Z175 Z176 Z177 Z178 Z179 Z180 Z181 Z182 Z183 Z184 Z185 Z186 Z187 Z188 Z189 Z190 rear
w8ri = [Z174; Z175; Z176];
w8re = [Z177*dpsi+Z178*dq_imu+Z178*dq_w+Z179*dq_torso+Z180*dq_1r+Z181*dq_2r+Z182*dq_3r+Z183*dq_4r;
    (-Z162)*dpsi + (-Z163)*dq_imu + (-Z163)*dq_w + (-Z164)*dq_torso + (-Z165)*dq_1r + (-Z166)*dq_2r + (-Z167)*dq_3r - dq_5r;
    Z184*dpsi+Z185*dq_imu+Z185*dq_w+Z186*dq_torso+Z187*dq_1r+Z188*dq_2r+Z189*dq_3r+Z190*dq_4r];

% w9ri = Rot(f, '8r', '9r') * w8ri + f('9r').e*f('9r').dq
% w9re = correct(Rot(f, '8r', '9r') * w8re + f('9r').e*f('9r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r])
syms dq_6r Z191 Z192 Z193 Z194 Z195 Z196 Z197 Z198 Z199 Z200 Z201 Z202 Z203 Z204 Z205 Z206 Z207 Z208 Z209 rear
w9ri = [Z191; Z192; Z193];
w9re = [(-Z177)*dpsi + (-Z178)*dq_imu + (-Z178)*dq_w + (-Z179)*dq_torso + (-Z180)*dq_1r + (-Z181)*dq_2r + (-Z182)*dq_3r + (-Z183)*dq_4r - dq_6r;
    Z194*dpsi+Z195*dq_imu+Z195*dq_w+Z196*dq_torso+Z197*dq_1r+Z198*dq_2r+Z199*dq_3r+Z200*dq_4r+Z201*dq_5r;
    Z202*dpsi+Z203*dq_imu+Z203*dq_w+Z204*dq_torso+Z205*dq_1r+Z206*dq_2r+Z207*dq_3r+Z208*dq_4r+Z209*dq_5r];

% w10ri = Rot(f, '9r', '10r') * w9ri + f('10r').e*f('10r').dq
% w10re = correct(Rot(f, '9r', '10r') * w9re + f('10r').e*f('10r').dq,[dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r,dq_7r])
syms dq_7r Z210 Z211 Z212 Z213 Z214 Z215 Z216 Z217 Z218 Z219 Z220 Z221 Z222 Z223 Z224 Z225 Z226 Z227 Z228 Z229 Z230 rear
w10ri = [Z210; Z211; Z212];
w10re = [(-Z194)*dpsi + (-Z195)*dq_imu + (-Z195)*dq_w + (-Z196)*dq_torso + (-Z197)*dq_1r + (-Z198)*dq_2r + (-Z199)*dq_3r + (-Z200)*dq_4r + (-Z201)*dq_5r - dq_7r;
    Z213*dpsi+Z214*dq_imu+Z214*dq_w+Z215*dq_torso+Z216*dq_1r+Z217*dq_2r+Z218*dq_3r+Z219*dq_4r+Z220*dq_5r+Z221*dq_6r;
    Z222*dpsi+Z223*dq_imu+Z223*dq_w+Z224*dq_torso+Z225*dq_1r+Z226*dq_2r+Z227*dq_3r+Z228*dq_4r+Z229*dq_5r+Z230*dq_6r];
