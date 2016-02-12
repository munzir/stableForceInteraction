% this = '6r'; w = w6ri; prev = '5r'; arphaLast = arpha5r;
% arpha6r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r])
% arpha6r =
%  
%     (Z137*cos(q_3r) + Z150*sin(q_3r))*ddpsi + (Z138*cos(q_3r) + Z151*sin(q_3r))*ddq_imu + (Z138*cos(q_3r) + Z151*sin(q_3r))*ddq_w + (Z139*cos(q_3r) + Z152*sin(q_3r))*ddq_torso + (Z153*sin(q_3r))*ddq_1r + cos(q_3r)*ddq_2r + Z156*dq_3r + Z538*cos(q_3r) + Z541*sin(q_3r)
%                                                                                                                                                                   (-Z146)*ddpsi + (-Z147)*ddq_imu + (-Z147)*ddq_w + (-Z148)*ddq_torso + (-Z149)*ddq_1r - ddq_3r - Z540
%  (Z150*cos(q_3r) - Z137*sin(q_3r))*ddpsi + (Z151*cos(q_3r) - Z138*sin(q_3r))*ddq_imu + (Z151*cos(q_3r) - Z138*sin(q_3r))*ddq_w + (Z152*cos(q_3r) - Z139*sin(q_3r))*ddq_torso + (Z153*cos(q_3r))*ddq_1r + (-sin(q_3r))*ddq_2r + Z541*cos(q_3r) - Z154*dq_3r - Z538*sin(q_3r)
syms ddq_3r rear
Z542 = + Z156*dq_3r + Z538*cos(q_3r) + Z541*sin(q_3r);
Z543 = + Z541*cos(q_3r) - Z154*dq_3r - Z538*sin(q_3r);
arpha6r = [Z157*ddpsi+Z158*ddq_imu+Z158*ddq_w+Z159*ddq_torso+Z160*ddq_1r+Z161*ddq_2r+Z542;
    (-Z146)*ddpsi + (-Z147)*ddq_imu + (-Z147)*ddq_w + (-Z148)*ddq_torso + (-Z149)*ddq_1r - ddq_3r - Z540;
    Z162*ddpsi+Z163*ddq_imu+Z163*ddq_w+Z164*ddq_torso+Z165*ddq_1r+Z166*ddq_2r+Z543]; 

% this = '7r'; w = w7ri; prev = '6r'; arphaLast = arpha6r;
% arpha7r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r])
% arpha7r =
%  (-Z157)*ddpsi + (-Z158)*ddq_imu + (-Z158)*ddq_w + (-Z159)*ddq_torso + (-Z160)*ddq_1r + (-Z161)*ddq_2r - ddq_4r - Z542
%  (Z146*cos(q_4r) - Z162*sin(q_4r))*ddpsi + (Z147*cos(q_4r) - Z163*sin(q_4r))*ddq_imu + (Z147*cos(q_4r) - Z163*sin(q_4r))*ddq_w + (Z148*cos(q_4r) - Z164*sin(q_4r))*ddq_torso + (Z149*cos(q_4r) - Z165*sin(q_4r))*ddq_1r + (-Z166*sin(q_4r))*ddq_2r + cos(q_4r)*ddq_3r + Z540*cos(q_4r) - Z169*dq_4r - Z543*sin(q_4r)
%   (Z162*cos(q_4r) + Z146*sin(q_4r))*ddpsi + (Z163*cos(q_4r) + Z147*sin(q_4r))*ddq_imu + (Z163*cos(q_4r) + Z147*sin(q_4r))*ddq_w + (Z164*cos(q_4r) + Z148*sin(q_4r))*ddq_torso + (Z165*cos(q_4r) + Z149*sin(q_4r))*ddq_1r + (Z166*cos(q_4r))*ddq_2r + sin(q_4r)*ddq_3r + Z168*dq_4r + Z543*cos(q_4r) + Z540*sin(q_4r)
syms ddq_4r rear
Z544 =  Z540*cos(q_4r) - Z169*dq_4r - Z543*sin(q_4r);
Z545 =  + Z168*dq_4r + Z543*cos(q_4r) + Z540*sin(q_4r);
arpha7r = [ (-Z157)*ddpsi + (-Z158)*ddq_imu + (-Z158)*ddq_w + (-Z159)*ddq_torso + (-Z160)*ddq_1r + (-Z161)*ddq_2r - ddq_4r - Z542;
    Z170*ddpsi+Z171*ddq_imu+Z171*ddq_w+Z172*ddq_torso+Z173*ddq_1r+Z174*ddq_2r+Z175*ddq_3r+Z544;
    Z176*ddpsi+Z177*ddq_imu+Z177*ddq_w+Z178*ddq_torso+Z179*ddq_1r+Z180*ddq_2r+Z181*ddq_3r+Z545];

% this = '8r'; w = w8ri; prev = '7r'; arphaLast = arpha7r;
% arpha8r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r])
% arpha8r =
%  
%     (Z157*cos(q_5r) + Z176*sin(q_5r))*ddpsi + (Z158*cos(q_5r) + Z177*sin(q_5r))*ddq_imu + (Z158*cos(q_5r) + Z177*sin(q_5r))*ddq_w + (Z159*cos(q_5r) + Z178*sin(q_5r))*ddq_torso + (Z160*cos(q_5r) + Z179*sin(q_5r))*ddq_1r + (Z161*cos(q_5r) + Z180*sin(q_5r))*ddq_2r + (Z181*sin(q_5r))*ddq_3r + cos(q_5r)*ddq_4r + Z184*dq_5r + Z542*cos(q_5r) + Z545*sin(q_5r)
%                                                                                                                                                                                                                     (-Z170)*ddpsi + (-Z171)*ddq_imu + (-Z171)*ddq_w + (-Z172)*ddq_torso + (-Z173)*ddq_1r + (-Z174)*ddq_2r + (-Z175)*ddq_3r - ddq_5r - Z544
%  (Z176*cos(q_5r) - Z157*sin(q_5r))*ddpsi + (Z177*cos(q_5r) - Z158*sin(q_5r))*ddq_imu + (Z177*cos(q_5r) - Z158*sin(q_5r))*ddq_w + (Z178*cos(q_5r) - Z159*sin(q_5r))*ddq_torso + (Z179*cos(q_5r) - Z160*sin(q_5r))*ddq_1r + (Z180*cos(q_5r) - Z161*sin(q_5r))*ddq_2r + (Z181*cos(q_5r))*ddq_3r + (-sin(q_5r))*ddq_4r + Z545*cos(q_5r) - Z182*dq_5r - Z542*sin(q_5r)
syms ddq_5r rear
Z546 = + Z184*dq_5r + Z542*cos(q_5r) + Z545*sin(q_5r);
Z547 = + Z545*cos(q_5r) - Z182*dq_5r - Z542*sin(q_5r);
arpha8r = [Z185*ddpsi+Z186*ddq_imu+Z186*ddq_w+Z187*ddq_torso+Z188*ddq_1r+Z189*ddq_2r+Z190*ddq_3r+Z191*ddq_4r+Z546;
    (-Z170)*ddpsi + (-Z171)*ddq_imu + (-Z171)*ddq_w + (-Z172)*ddq_torso + (-Z173)*ddq_1r + (-Z174)*ddq_2r + (-Z175)*ddq_3r - ddq_5r - Z544;
    Z192*ddpsi+Z193*ddq_imu+Z193*ddq_w+Z194*ddq_torso+Z195*ddq_1r+Z196*ddq_2r+Z197*ddq_3r+Z198*ddq_4r+Z547];

% this = '9r'; w = w9ri; prev = '8r'; arphaLast = arpha8r;
% arpha9r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r])
% arpha9r =
%  
%                                                                                                                                                                                                                                            (-Z185)*ddpsi + (-Z186)*ddq_imu + (-Z186)*ddq_w + (-Z187)*ddq_torso + (-Z188)*ddq_1r + (-Z189)*ddq_2r + (-Z190)*ddq_3r + (-Z191)*ddq_4r - ddq_6r - Z546
%  (Z170*cos(q_6r) - Z192*sin(q_6r))*ddpsi + (Z171*cos(q_6r) - Z193*sin(q_6r))*ddq_imu + (Z171*cos(q_6r) - Z193*sin(q_6r))*ddq_w + (Z172*cos(q_6r) - Z194*sin(q_6r))*ddq_torso + (Z173*cos(q_6r) - Z195*sin(q_6r))*ddq_1r + (Z174*cos(q_6r) - Z196*sin(q_6r))*ddq_2r + (Z175*cos(q_6r) - Z197*sin(q_6r))*ddq_3r + (-Z198*sin(q_6r))*ddq_4r + cos(q_6r)*ddq_5r + Z544*cos(q_6r) - Z201*dq_6r - Z547*sin(q_6r)
%   (Z192*cos(q_6r) + Z170*sin(q_6r))*ddpsi + (Z193*cos(q_6r) + Z171*sin(q_6r))*ddq_imu + (Z193*cos(q_6r) + Z171*sin(q_6r))*ddq_w + (Z194*cos(q_6r) + Z172*sin(q_6r))*ddq_torso + (Z195*cos(q_6r) + Z173*sin(q_6r))*ddq_1r + (Z196*cos(q_6r) + Z174*sin(q_6r))*ddq_2r + (Z197*cos(q_6r) + Z175*sin(q_6r))*ddq_3r + (Z198*cos(q_6r))*ddq_4r + sin(q_6r)*ddq_5r + Z200*dq_6r + Z547*cos(q_6r) + Z544*sin(q_6r)
syms ddq_6r rear
Z548 = + Z544*cos(q_6r) - Z201*dq_6r - Z547*sin(q_6r);
Z549 = + Z200*dq_6r + Z547*cos(q_6r) + Z544*sin(q_6r);
arpha9r = [(-Z185)*ddpsi + (-Z186)*ddq_imu + (-Z186)*ddq_w + (-Z187)*ddq_torso + (-Z188)*ddq_1r + (-Z189)*ddq_2r + (-Z190)*ddq_3r + (-Z191)*ddq_4r - ddq_6r - Z546;
    Z202*ddpsi+Z203*ddq_imu+Z203*ddq_w+Z204*ddq_torso+Z205*ddq_1r+Z206*ddq_2r+Z207*ddq_3r+Z208*ddq_4r+Z209*ddq_5r+Z548;
    Z210*ddpsi+Z211*ddq_imu+Z211*ddq_w+Z212*ddq_torso+Z213*ddq_1r+Z214*ddq_2r+Z215*ddq_3r+Z216*ddq_4r+Z217*ddq_5r+Z549];

% this = '10r'; w = w10ri; prev = '9r'; arphaLast = arpha9r;
% arpha10r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r])
% arpha10r =
%  
%   (Z185*cos(q_7r) + Z210*sin(q_7r))*ddpsi + (Z186*cos(q_7r) + Z211*sin(q_7r))*ddq_imu + (Z186*cos(q_7r) + Z211*sin(q_7r))*ddq_w + (Z187*cos(q_7r) + Z212*sin(q_7r))*ddq_torso + (Z188*cos(q_7r) + Z213*sin(q_7r))*ddq_1r + (Z189*cos(q_7r) + Z214*sin(q_7r))*ddq_2r + (Z190*cos(q_7r) + Z215*sin(q_7r))*ddq_3r + (Z191*cos(q_7r) + Z216*sin(q_7r))*ddq_4r + (Z217*sin(q_7r))*ddq_5r + cos(q_7r)*ddq_6r + Z546*cos(q_7r) - Z219*dq_7r + Z549*sin(q_7r)
%  (Z185*sin(q_7r) - Z210*cos(q_7r))*ddpsi + (Z186*sin(q_7r) - Z211*cos(q_7r))*ddq_imu + (Z186*sin(q_7r) - Z211*cos(q_7r))*ddq_w + (Z187*sin(q_7r) - Z212*cos(q_7r))*ddq_torso + (Z188*sin(q_7r) - Z213*cos(q_7r))*ddq_1r + (Z189*sin(q_7r) - Z214*cos(q_7r))*ddq_2r + (Z190*sin(q_7r) - Z215*cos(q_7r))*ddq_3r + (Z191*sin(q_7r) - Z216*cos(q_7r))*ddq_4r + (-Z217*cos(q_7r))*ddq_5r + sin(q_7r)*ddq_6r + Z218*dq_7r - Z549*cos(q_7r) + Z546*sin(q_7r)
%                                                                                                                                                                                                                                                                          (-Z202)*ddpsi + (-Z203)*ddq_imu + (-Z203)*ddq_w + (-Z204)*ddq_torso + (-Z205)*ddq_1r + (-Z206)*ddq_2r + (-Z207)*ddq_3r + (-Z208)*ddq_4r + (-Z209)*ddq_5r - ddq_7r - Z548
syms ddq_7r rear
Z550 = + Z546*cos(q_7r) - Z219*dq_7r + Z549*sin(q_7r);
Z551 = + Z218*dq_7r - Z549*cos(q_7r) + Z546*sin(q_7r);
arpha10r = [Z221*ddpsi+Z222*ddq_imu+Z222*ddq_w+Z223*ddq_torso+Z224*ddq_1r+Z225*ddq_2r+Z226*ddq_3r+Z227*ddq_4r+Z228*ddq_5r+Z229*ddq_6r+Z550;
    Z230*ddpsi+Z231*ddq_imu+Z231*ddq_w+Z232*ddq_torso+Z233*ddq_1r+Z234*ddq_2r+Z235*ddq_3r+Z236*ddq_4r+Z237*ddq_5r+Z238*ddq_6r+Z551;
    (-Z202)*ddpsi + (-Z203)*ddq_imu + (-Z203)*ddq_w + (-Z204)*ddq_torso + (-Z205)*ddq_1r + (-Z206)*ddq_2r + (-Z207)*ddq_3r + (-Z208)*ddq_4r + (-Z209)*ddq_5r - ddq_7r - Z548];

%%
% this = '6r'; w = w6ri; prev = '5r'; arphaLast = arpha5r;
% arpha6r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r])
syms ddq_3r Z542 Z543 rear
arpha6r = [Z157*ddpsi+Z158*ddq_imu+Z158*ddq_w+Z159*ddq_torso+Z160*ddq_1r+Z161*ddq_2r+Z542;
    (-Z146)*ddpsi + (-Z147)*ddq_imu + (-Z147)*ddq_w + (-Z148)*ddq_torso + (-Z149)*ddq_1r - ddq_3r - Z540;
    Z162*ddpsi+Z163*ddq_imu+Z163*ddq_w+Z164*ddq_torso+Z165*ddq_1r+Z166*ddq_2r+Z543];   

% this = '7r'; w = w7ri; prev = '6r'; arphaLast = arpha6r;
% arpha7r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r])
syms ddq_4r Z544 Z545 rear
arpha7r = [ (-Z157)*ddpsi + (-Z158)*ddq_imu + (-Z158)*ddq_w + (-Z159)*ddq_torso + (-Z160)*ddq_1r + (-Z161)*ddq_2r - ddq_4r - Z542;
    Z170*ddpsi+Z171*ddq_imu+Z171*ddq_w+Z172*ddq_torso+Z173*ddq_1r+Z174*ddq_2r+Z175*ddq_3r+Z544;
    Z176*ddpsi+Z177*ddq_imu+Z177*ddq_w+Z178*ddq_torso+Z179*ddq_1r+Z180*ddq_2r+Z181*ddq_3r+Z545];

% this = '8r'; w = w8ri; prev = '7r'; arphaLast = arpha7r;
% arpha8r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r])
syms ddq_5r Z546 Z547 rear
arpha8r = [Z185*ddpsi+Z186*ddq_imu+Z186*ddq_w+Z187*ddq_torso+Z188*ddq_1r+Z189*ddq_2r+Z190*ddq_3r+Z191*ddq_4r+Z546;
    (-Z170)*ddpsi + (-Z171)*ddq_imu + (-Z171)*ddq_w + (-Z172)*ddq_torso + (-Z173)*ddq_1r + (-Z174)*ddq_2r + (-Z175)*ddq_3r - ddq_5r - Z544;
    Z192*ddpsi+Z193*ddq_imu+Z193*ddq_w+Z194*ddq_torso+Z195*ddq_1r+Z196*ddq_2r+Z197*ddq_3r+Z198*ddq_4r+Z547];

% this = '9r'; w = w9ri; prev = '8r'; arphaLast = arpha8r;
% arpha9r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r])
syms ddq_6r Z548 Z549 rear
arpha9r = [(-Z185)*ddpsi + (-Z186)*ddq_imu + (-Z186)*ddq_w + (-Z187)*ddq_torso + (-Z188)*ddq_1r + (-Z189)*ddq_2r + (-Z190)*ddq_3r + (-Z191)*ddq_4r - ddq_6r - Z546;
    Z202*ddpsi+Z203*ddq_imu+Z203*ddq_w+Z204*ddq_torso+Z205*ddq_1r+Z206*ddq_2r+Z207*ddq_3r+Z208*ddq_4r+Z209*ddq_5r+Z548;
    Z210*ddpsi+Z211*ddq_imu+Z211*ddq_w+Z212*ddq_torso+Z213*ddq_1r+Z214*ddq_2r+Z215*ddq_3r+Z216*ddq_4r+Z217*ddq_5r+Z549];

% this = '10r'; w = w10ri; prev = '9r'; arphaLast = arpha9r;
% arpha10r = correct(Rot(f, prev, this)*arphaLast + f(this).ddq*f(this).e + f(this).dq*cross(w, f(this).e),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r,ddq_7r])
syms ddq_7r Z550 Z551 rear
arpha10r = [Z221*ddpsi+Z222*ddq_imu+Z222*ddq_w+Z223*ddq_torso+Z224*ddq_1r+Z225*ddq_2r+Z226*ddq_3r+Z227*ddq_4r+Z228*ddq_5r+Z229*ddq_6r+Z550;
    Z230*ddpsi+Z231*ddq_imu+Z231*ddq_w+Z232*ddq_torso+Z233*ddq_1r+Z234*ddq_2r+Z235*ddq_3r+Z236*ddq_4r+Z237*ddq_5r+Z238*ddq_6r+Z551;
    (-Z202)*ddpsi + (-Z203)*ddq_imu + (-Z203)*ddq_w + (-Z204)*ddq_torso + (-Z205)*ddq_1r + (-Z206)*ddq_2r + (-Z207)*ddq_3r + (-Z208)*ddq_4r + (-Z209)*ddq_5r - ddq_7r - Z548];
