% v6ri = Rot(f, '5r', '6r') * (v5ri + cross(w5ri, f('6r').P))
% v6re = correct(Rot(f, '5r', '6r') * (v5re + cross(w5re, f('6r').P)),[dx,dpsi,dq_imu,dq_w,dq_1r,dq_2r])
% v6ri =
%  
%  sin(q_3r)*(Z399 - L7*Z135) + cos(q_3r)*(Z382 - L7*Z137)
%                                                  -Z398
%  cos(q_3r)*(Z399 - L7*Z135) - sin(q_3r)*(Z382 - L7*Z137)
%  
%  
% v6re =
%  
%  (Z385*cos(q_3r) + Z405*sin(q_3r))*dx + (sin(q_3r)*(Z406 + L7*Z129) + cos(q_3r)*(Z386 - L7*Z142))*dpsi + (sin(q_3r)*(Z407 + L7*Z130) + cos(q_3r)*(Z387 - L7*Z143))*dq_imu + (sin(q_3r)*(Z408 + L7*Z130) + cos(q_3r)*(Z388 - L7*Z143))*dq_w + (sin(q_3r)*(Z409 + L7*Z131) + cos(q_3r)*(Z389 - L7*Z144))*dq_torso + (-L7*Z145*cos(q_3r))*dq_1r + (L7*sin(q_3r))*dq_2r
%                                                                                                                                                                                                                                                                               (-Z400)*dx + (-Z401)*dpsi + (-Z402)*dq_imu + (-Z403)*dq_w + (-Z404)*dq_torso
%   (Z405*cos(q_3r) - Z385*sin(q_3r))*dx + (cos(q_3r)*(Z406 + L7*Z129) - sin(q_3r)*(Z386 - L7*Z142))*dpsi + (cos(q_3r)*(Z407 + L7*Z130) - sin(q_3r)*(Z387 - L7*Z143))*dq_imu + (cos(q_3r)*(Z408 + L7*Z130) - sin(q_3r)*(Z388 - L7*Z143))*dq_w + (cos(q_3r)*(Z409 + L7*Z131) - sin(q_3r)*(Z389 - L7*Z144))*dq_torso + (L7*Z145*sin(q_3r))*dq_1r + (L7*cos(q_3r))*dq_2r
 
Z410 = sin(q_3r)*(Z399 - L7*Z135) + cos(q_3r)*(Z382 - L7*Z137);
Z411 = cos(q_3r)*(Z399 - L7*Z135) - sin(q_3r)*(Z382 - L7*Z137);
Z412 = (Z385*cos(q_3r) + Z405*sin(q_3r));
Z413 = + (sin(q_3r)*(Z406 + L7*Z129) + cos(q_3r)*(Z386 - L7*Z142));
Z414 = + (sin(q_3r)*(Z407 + L7*Z130) + cos(q_3r)*(Z387 - L7*Z143));
Z415 = + (sin(q_3r)*(Z408 + L7*Z130) + cos(q_3r)*(Z388 - L7*Z143));
Z416 = + (sin(q_3r)*(Z409 + L7*Z131) + cos(q_3r)*(Z389 - L7*Z144));
Z417 = + (-L7*Z145*cos(q_3r));
Z418 = + (L7*sin(q_3r));
Z419 = (Z405*cos(q_3r) - Z385*sin(q_3r));
Z420 = + (cos(q_3r)*(Z406 + L7*Z129) - sin(q_3r)*(Z386 - L7*Z142));
Z421 = + (cos(q_3r)*(Z407 + L7*Z130) - sin(q_3r)*(Z387 - L7*Z143));
Z422 = + (cos(q_3r)*(Z408 + L7*Z130) - sin(q_3r)*(Z388 - L7*Z143));
Z423 = + (cos(q_3r)*(Z409 + L7*Z131) - sin(q_3r)*(Z389 - L7*Z144));
Z424 = + (L7*Z145*sin(q_3r));
Z425 = + (L7*cos(q_3r));

v6ri = [Z410; -Z398; Z411];
v6re = [Z412*dx+Z413*dpsi+Z414*dq_imu+Z415*dq_w+Z416*dq_torso+Z417*dq_1r+Z418*dq_2r; 
    (-Z400)*dx + (-Z401)*dpsi + (-Z402)*dq_imu + (-Z403)*dq_w + (-Z404)*dq_torso;
    Z419*dx+Z420*dpsi+Z421*dq_imu+Z422*dq_w+Z423*dq_torso+Z424*dq_1r+Z425*dq_2r];
dv6r = [[Z412 -Z400 Z419]' [Z413 -Z182 Z420]' [Z414 -Z402 Z421]' ...
    [Z415 -Z403 Z422]' [Z416 -Z404 Z423]' [Z417 0 Z424]' [Z418 0 Z425]' ...
    zeros(3,12)];

% v7ri = Rot(f, '6r', '7r') * (v6ri + cross(w6ri, f('7r').P))
% v7re = correct(Rot(f, '6r', '7r') * (v6re + cross(w6re, f('7r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r])
% v7ri =
%  
%                            -Z410
%  Z398*cos(q_4r) - Z411*sin(q_4r)
%  Z411*cos(q_4r) + Z398*sin(q_4r)
%  
%  
% v7re =
%  
%                                                                                                                                                        (-Z412)*dx + (-Z413)*dpsi + (-Z414)*dq_imu + (-Z415)*dq_w + (-Z416)*dq_torso + (-Z417)*dq_1r + (-Z418)*dq_2r
%  (Z400*cos(q_4r) - Z419*sin(q_4r))*dx + (Z401*cos(q_4r) - Z420*sin(q_4r))*dpsi + (Z402*cos(q_4r) - Z421*sin(q_4r))*dq_imu + (Z403*cos(q_4r) - Z422*sin(q_4r))*dq_w + (Z404*cos(q_4r) - Z423*sin(q_4r))*dq_torso + (-Z424*sin(q_4r))*dq_1r + (-Z425*sin(q_4r))*dq_2r
%    (Z419*cos(q_4r) + Z400*sin(q_4r))*dx + (Z420*cos(q_4r) + Z401*sin(q_4r))*dpsi + (Z421*cos(q_4r) + Z402*sin(q_4r))*dq_imu + (Z422*cos(q_4r) + Z403*sin(q_4r))*dq_w + (Z423*cos(q_4r) + Z404*sin(q_4r))*dq_torso + (Z424*cos(q_4r))*dq_1r + (Z425*cos(q_4r))*dq_2r
%  
% v7ri = Rot(f, '6r', '7r') * (v6ri + cross(w6ri, f('7r').P))
% v7re = correct(Rot(f, '6r', '7r') * (v6re + cross(w6re, f('7r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r])

Z426 = Z398*cos(q_4r) - Z411*sin(q_4r);
Z427 = Z411*cos(q_4r) + Z398*sin(q_4r);
Z428 = (Z400*cos(q_4r) - Z419*sin(q_4r));
Z429 = + (Z401*cos(q_4r) - Z420*sin(q_4r));
Z430 = + (Z402*cos(q_4r) - Z421*sin(q_4r));
Z431 = + (Z403*cos(q_4r) - Z422*sin(q_4r));
Z432 = + (Z404*cos(q_4r) - Z423*sin(q_4r));
Z433 = + (-Z424*sin(q_4r));
Z434 = + (-Z425*sin(q_4r));
Z435 = (Z419*cos(q_4r) + Z400*sin(q_4r));
Z436 = + (Z420*cos(q_4r) + Z401*sin(q_4r));
Z437 = + (Z421*cos(q_4r) + Z402*sin(q_4r));
Z438 = + (Z422*cos(q_4r) + Z403*sin(q_4r));
Z439 = + (Z423*cos(q_4r) + Z404*sin(q_4r));
Z440 = + (Z424*cos(q_4r)); 
Z441 = + (Z425*cos(q_4r));
 
v7ri = [-Z410; Z426; Z427];
v7re = [(-Z412)*dx + (-Z413)*dpsi + (-Z414)*dq_imu + (-Z415)*dq_w + (-Z416)*dq_torso + (-Z417)*dq_1r + (-Z418)*dq_2r;
    Z428*dx+Z429*dpsi+Z430*dq_imu+Z431*dq_w+Z432*dq_torso+Z433*dq_1r+Z434*dq_2r; 
    Z435*dx+Z436*dpsi+Z437*dq_imu+Z438*dq_w+Z439*dq_torso+Z440*dq_1r+Z441*dq_2r];
dv7r = [[-Z412 Z428 Z435]' [-Z413 Z429 Z436]' [-Z414 Z430 Z437]' ...
    [-Z415 Z431 Z438]' [-Z416 Z432 Z439]' [-Z417 Z433 Z440]' ...
    [-Z418 Z434 Z441]' zeros(3,12)];

% v8ri = Rot(f, '7r', '8r') * (v7ri + cross(w7ri, f('8r').P))
% v8re = correct(Rot(f, '7r', '8r') * (v7re + cross(w7re, f('8r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r])
% v8ri =
%  
%  sin(q_5r)*(Z427 - L8*Z159) + cos(q_5r)*(Z410 - L8*Z161)
%                                                  -Z426
%  cos(q_5r)*(Z427 - L8*Z159) - sin(q_5r)*(Z410 - L8*Z161)
%  
%  
% v8re =
%  
%  (Z412*cos(q_5r) + Z435*sin(q_5r))*dx + (sin(q_5r)*(Z436 + L8*Z149) + cos(q_5r)*(Z413 - L8*Z168))*dpsi + (sin(q_5r)*(Z437 + L8*Z150) + cos(q_5r)*(Z414 - L8*Z169))*dq_imu + (sin(q_5r)*(Z438 + L8*Z150) + cos(q_5r)*(Z415 - L8*Z169))*dq_w + (sin(q_5r)*(Z439 + L8*Z151) + cos(q_5r)*(Z416 - L8*Z170))*dq_torso + (sin(q_5r)*(Z440 + L8*Z152) + cos(q_5r)*(Z417 - L8*Z171))*dq_1r + (sin(q_5r)*(Z441 + L8*Z153) + cos(q_5r)*(Z418 - L8*Z172))*dq_2r + (-L8*Z173*cos(q_5r))*dq_3r + (L8*sin(q_5r))*dq_4r
%                                                                                                                                                                                                                                                                                                                                                                               (-Z428)*dx + (-Z429)*dpsi + (-Z430)*dq_imu + (-Z431)*dq_w + (-Z432)*dq_torso + (-Z433)*dq_1r + (-Z434)*dq_2r
%   (Z435*cos(q_5r) - Z412*sin(q_5r))*dx + (cos(q_5r)*(Z436 + L8*Z149) - sin(q_5r)*(Z413 - L8*Z168))*dpsi + (cos(q_5r)*(Z437 + L8*Z150) - sin(q_5r)*(Z414 - L8*Z169))*dq_imu + (cos(q_5r)*(Z438 + L8*Z150) - sin(q_5r)*(Z415 - L8*Z169))*dq_w + (cos(q_5r)*(Z439 + L8*Z151) - sin(q_5r)*(Z416 - L8*Z170))*dq_torso + (cos(q_5r)*(Z440 + L8*Z152) - sin(q_5r)*(Z417 - L8*Z171))*dq_1r + (cos(q_5r)*(Z441 + L8*Z153) - sin(q_5r)*(Z418 - L8*Z172))*dq_2r + (L8*Z173*sin(q_5r))*dq_3r + (L8*cos(q_5r))*dq_4r

Z442 = sin(q_5r)*(Z427 - L8*Z159) + cos(q_5r)*(Z410 - L8*Z161);
Z443 = cos(q_5r)*(Z427 - L8*Z159) - sin(q_5r)*(Z410 - L8*Z161);
Z444 = (Z412*cos(q_5r) + Z435*sin(q_5r));
Z445 = + (sin(q_5r)*(Z436 + L8*Z149) + cos(q_5r)*(Z413 - L8*Z168));
Z446 = + (sin(q_5r)*(Z437 + L8*Z150) + cos(q_5r)*(Z414 - L8*Z169));
Z447 = + (sin(q_5r)*(Z438 + L8*Z150) + cos(q_5r)*(Z415 - L8*Z169));
Z448 = + (sin(q_5r)*(Z439 + L8*Z151) + cos(q_5r)*(Z416 - L8*Z170));
Z449 = + (sin(q_5r)*(Z440 + L8*Z152) + cos(q_5r)*(Z417 - L8*Z171));
Z450 = + (sin(q_5r)*(Z441 + L8*Z153) + cos(q_5r)*(Z418 - L8*Z172));
Z451 = + (-L8*Z173*cos(q_5r));
Z452 = + (L8*sin(q_5r));
Z453 = (Z435*cos(q_5r) - Z412*sin(q_5r));
Z454 = + (cos(q_5r)*(Z436 + L8*Z149) - sin(q_5r)*(Z413 - L8*Z168));
Z455 = + (cos(q_5r)*(Z437 + L8*Z150) - sin(q_5r)*(Z414 - L8*Z169));
Z456 = + (cos(q_5r)*(Z438 + L8*Z150) - sin(q_5r)*(Z415 - L8*Z169));
Z457 = + (cos(q_5r)*(Z439 + L8*Z151) - sin(q_5r)*(Z416 - L8*Z170));
Z458 = + (cos(q_5r)*(Z440 + L8*Z152) - sin(q_5r)*(Z417 - L8*Z171));
Z459 = + (cos(q_5r)*(Z441 + L8*Z153) - sin(q_5r)*(Z418 - L8*Z172));
Z460 = + (L8*Z173*sin(q_5r));
Z461 = + (L8*cos(q_5r));

v8ri = [Z442; -Z426; Z443];
v8re = [Z444*dx+Z445*dpsi+Z446*dq_imu+Z447*dq_w+Z448*dq_torso+Z449*dq_1r+Z450*dq_2r+Z451*dq_3r+Z452*dq_4r; 
    (-Z428)*dx + (-Z429)*dpsi + (-Z430)*dq_imu + (-Z431)*dq_w + (-Z432)*dq_torso + (-Z433)*dq_1r + (-Z434)*dq_2r
    Z453*dx+Z454*dpsi+Z455*dq_imu+Z456*dq_w+Z457*dq_torso+Z458*dq_1r+Z459*dq_2r+Z460*dq_3r+Z461*dq_4r];
dv8r = [[Z444 -Z428 Z453]' [Z445 -Z429 Z454]' [Z446 -Z430 Z455]' ...
    [Z447 -Z431 Z456]' [Z448 -Z432 Z457]' [Z449 -Z433 Z458]' ...
    [Z450 -Z434 Z459]' [Z451 0 Z460]' [Z452 0 Z461]' zeros(3,10)];


% v9ri = Rot(f, '8r', '9r') * (v8ri + cross(w8ri, f('9r').P))
% v9re = correct(Rot(f, '8r', '9r') * (v8re + cross(w8re, f('9r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r])
% v9ri =
%  
%                            -Z442
%  Z426*cos(q_6r) - Z443*sin(q_6r)
%  Z443*cos(q_6r) + Z426*sin(q_6r)
%  
%  
% v9re =
%  
%                                                                                                                                                                                                            (-Z444)*dx + (-Z445)*dpsi + (-Z446)*dq_imu + (-Z447)*dq_w + (-Z448)*dq_torso + (-Z449)*dq_1r + (-Z450)*dq_2r + (-Z451)*dq_3r + (-Z452)*dq_4r
%  (Z428*cos(q_6r) - Z453*sin(q_6r))*dx + (Z429*cos(q_6r) - Z454*sin(q_6r))*dpsi + (Z430*cos(q_6r) - Z455*sin(q_6r))*dq_imu + (Z431*cos(q_6r) - Z456*sin(q_6r))*dq_w + (Z432*cos(q_6r) - Z457*sin(q_6r))*dq_torso + (Z433*cos(q_6r) - Z458*sin(q_6r))*dq_1r + (Z434*cos(q_6r) - Z459*sin(q_6r))*dq_2r + (-Z460*sin(q_6r))*dq_3r + (-Z461*sin(q_6r))*dq_4r
%    (Z453*cos(q_6r) + Z428*sin(q_6r))*dx + (Z454*cos(q_6r) + Z429*sin(q_6r))*dpsi + (Z455*cos(q_6r) + Z430*sin(q_6r))*dq_imu + (Z456*cos(q_6r) + Z431*sin(q_6r))*dq_w + (Z457*cos(q_6r) + Z432*sin(q_6r))*dq_torso + (Z458*cos(q_6r) + Z433*sin(q_6r))*dq_1r + (Z459*cos(q_6r) + Z434*sin(q_6r))*dq_2r + (Z460*cos(q_6r))*dq_3r + (Z461*cos(q_6r))*dq_4r

Z462 = Z426*cos(q_6r) - Z443*sin(q_6r);
Z463 = Z443*cos(q_6r) + Z426*sin(q_6r);
Z464 = (Z428*cos(q_6r) - Z453*sin(q_6r));
Z465 = + (Z429*cos(q_6r) - Z454*sin(q_6r));
Z466 = + (Z430*cos(q_6r) - Z455*sin(q_6r));
Z467 = + (Z431*cos(q_6r) - Z456*sin(q_6r));
Z468 = + (Z432*cos(q_6r) - Z457*sin(q_6r));
Z469 = + (Z433*cos(q_6r) - Z458*sin(q_6r));
Z470 = + (Z434*cos(q_6r) - Z459*sin(q_6r));
Z471 = + (-Z460*sin(q_6r));
Z472 = + (-Z461*sin(q_6r));
Z473 = (Z453*cos(q_6r) + Z428*sin(q_6r));
Z474 = + (Z454*cos(q_6r) + Z429*sin(q_6r));
Z475 = + (Z455*cos(q_6r) + Z430*sin(q_6r));
Z476 = + (Z456*cos(q_6r) + Z431*sin(q_6r));
Z477 = + (Z457*cos(q_6r) + Z432*sin(q_6r));
Z478 = + (Z458*cos(q_6r) + Z433*sin(q_6r));
Z479 = + (Z459*cos(q_6r) + Z434*sin(q_6r));
Z480 = + (Z460*cos(q_6r));
Z481 = + (Z461*cos(q_6r));

v9ri = [-Z442; Z462; Z463];
v9re = [(-Z444)*dx + (-Z445)*dpsi + (-Z446)*dq_imu + (-Z447)*dq_w + (-Z448)*dq_torso + (-Z449)*dq_1r + (-Z450)*dq_2r + (-Z451)*dq_3r + (-Z452)*dq_4r;
    Z464*dx+Z465*dpsi+Z466*dq_imu+Z467*dq_w+Z468*dq_torso+Z469*dq_1r+Z470*dq_2r+Z471*dq_3r+Z472*dq_4r; 
    Z473*dx+Z474*dpsi+Z475*dq_imu+Z476*dq_w+Z477*dq_torso+Z478*dq_1r+Z479*dq_2r+Z480*dq_3r+Z481*dq_4r];
dv9r = [[-Z444 Z464 Z473]' [-Z445 Z465 Z474]' [-Z446 Z466 Z475]' ...
    [-Z447 Z467 Z476]' [-Z448 Z468 Z477]' [-Z449 Z469 Z478]' ...
    [-Z450 Z470 Z479]' [-Z451 Z471 Z480]' [-Z452 Z472 Z481]' zeros(3,10)];


% v10ri = Rot(f, '9r', '10r') * (v9ri + cross(w9ri, f('10r').P))
% v10re = correct(Rot(f, '9r', '10r') * (v9re + cross(w9re, f('10r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r])
% v10ri =
%  
%  sin(q_7r)*(Z463 - L9*Z191) + cos(q_7r)*(Z442 - L9*Z193)
%  sin(q_7r)*(Z442 - L9*Z193) - cos(q_7r)*(Z463 - L9*Z191)
%                                                  -Z462
%  
%  
% v10re =
%  
%   (Z444*cos(q_7r) + Z473*sin(q_7r))*dx + (sin(q_7r)*(Z454 + L9*Z177) + cos(q_7r)*(Z445 - L9*Z202))*dpsi + (sin(q_7r)*(Z475 + L9*Z178) + cos(q_7r)*(Z446 - L9*Z203))*dq_imu + (sin(q_7r)*(Z476 + L9*Z178) + cos(q_7r)*(Z447 - L9*Z203))*dq_w + (sin(q_7r)*(Z477 + L9*Z179) + cos(q_7r)*(Z448 - L9*Z204))*dq_torso + (sin(q_7r)*(Z478 + L9*Z180) + cos(q_7r)*(Z449 - L9*Z205))*dq_1r + (sin(q_7r)*(Z479 + L9*Z181) + cos(q_7r)*(Z450 - L9*Z206))*dq_2r + (sin(q_7r)*(Z480 + L9*Z182) + cos(q_7r)*(Z451 - L9*Z207))*dq_3r + (sin(q_7r)*(Z481 + L9*Z183) + cos(q_7r)*(Z452 - L9*Z208))*dq_4r + (-L9*Z209*cos(q_7r))*dq_5r + (L9*sin(q_7r))*dq_6r
%  (Z444*sin(q_7r) - Z473*cos(q_7r))*dx + (sin(q_7r)*(Z445 - L9*Z202) - cos(q_7r)*(Z454 + L9*Z177))*dpsi + (sin(q_7r)*(Z446 - L9*Z203) - cos(q_7r)*(Z475 + L9*Z178))*dq_imu + (sin(q_7r)*(Z447 - L9*Z203) - cos(q_7r)*(Z476 + L9*Z178))*dq_w + (sin(q_7r)*(Z448 - L9*Z204) - cos(q_7r)*(Z477 + L9*Z179))*dq_torso + (sin(q_7r)*(Z449 - L9*Z205) - cos(q_7r)*(Z478 + L9*Z180))*dq_1r + (sin(q_7r)*(Z450 - L9*Z206) - cos(q_7r)*(Z479 + L9*Z181))*dq_2r + (sin(q_7r)*(Z451 - L9*Z207) - cos(q_7r)*(Z480 + L9*Z182))*dq_3r + (sin(q_7r)*(Z452 - L9*Z208) - cos(q_7r)*(Z481 + L9*Z183))*dq_4r + (-L9*Z209*sin(q_7r))*dq_5r + (-L9*cos(q_7r))*dq_6r
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     (-Z464)*dx + (-Z445)*dpsi + (-Z466)*dq_imu + (-Z467)*dq_w + (-Z468)*dq_torso + (-Z469)*dq_1r + (-Z470)*dq_2r + (-Z471)*dq_3r + (-Z472)*dq_4r

Z482 = sin(q_7r)*(Z463 - L9*Z191) + cos(q_7r)*(Z442 - L9*Z193);
Z483 = sin(q_7r)*(Z442 - L9*Z193) - cos(q_7r)*(Z463 - L9*Z191);
Z484 = (Z444*cos(q_7r) + Z473*sin(q_7r));
Z485 = + (sin(q_7r)*(Z474 + L9*Z177) + cos(q_7r)*(Z445 - L9*Z202));
Z486 = + (sin(q_7r)*(Z475 + L9*Z178) + cos(q_7r)*(Z446 - L9*Z203));
Z487 = + (sin(q_7r)*(Z476 + L9*Z178) + cos(q_7r)*(Z447 - L9*Z203));
Z488 = + (sin(q_7r)*(Z477 + L9*Z179) + cos(q_7r)*(Z448 - L9*Z204));
Z489 = + (sin(q_7r)*(Z478 + L9*Z180) + cos(q_7r)*(Z449 - L9*Z205));
Z490 = + (sin(q_7r)*(Z479 + L9*Z181) + cos(q_7r)*(Z450 - L9*Z206));
Z491 = + (sin(q_7r)*(Z480 + L9*Z182) + cos(q_7r)*(Z451 - L9*Z207));
Z492 = + (sin(q_7r)*(Z481 + L9*Z183) + cos(q_7r)*(Z452 - L9*Z208));
Z493 = + (-L9*Z209*cos(q_7r));
Z494 = + (L9*sin(q_7r));
Z495 = (Z444*sin(q_7r) - Z473*cos(q_7r));
Z496 = + (sin(q_7r)*(Z445 - L9*Z202) - cos(q_7r)*(Z474 + L9*Z177));
Z497 = + (sin(q_7r)*(Z446 - L9*Z203) - cos(q_7r)*(Z475 + L9*Z178));
Z498 = + (sin(q_7r)*(Z447 - L9*Z203) - cos(q_7r)*(Z476 + L9*Z178));
Z499 = + (sin(q_7r)*(Z448 - L9*Z204) - cos(q_7r)*(Z477 + L9*Z179));
Z500 = + (sin(q_7r)*(Z449 - L9*Z205) - cos(q_7r)*(Z478 + L9*Z180));
Z501 = + (sin(q_7r)*(Z450 - L9*Z206) - cos(q_7r)*(Z479 + L9*Z181));
Z502 = + (sin(q_7r)*(Z451 - L9*Z207) - cos(q_7r)*(Z480 + L9*Z182));
Z503 = + (sin(q_7r)*(Z452 - L9*Z208) - cos(q_7r)*(Z481 + L9*Z183));
Z504 = + (-L9*Z209*sin(q_7r));
Z505 = + (-L9*cos(q_7r));

v10ri = [Z482; Z483; -Z462];
v10re = [Z484*dx+Z485*dpsi+Z486*dq_imu+Z487*dq_w+Z488*dq_torso+Z489*dq_1r+Z490*dq_2r+Z491*dq_3r+Z492*dq_4r+Z493*dq_5r+Z494*dq_6r; 
    Z495*dx+Z496*dpsi+Z497*dq_imu+Z498*dq_w+Z499*dq_torso+Z500*dq_1r+Z501*dq_2r+Z502*dq_3r+Z503*dq_4r+Z504*dq_5r+Z505*dq_6r; 
    (-Z464)*dx + (-Z465)*dpsi + (-Z466)*dq_imu + (-Z467)*dq_w + (-Z468)*dq_torso + (-Z469)*dq_1r + (-Z470)*dq_2r + (-Z471)*dq_3r + (-Z472)*dq_4r];
dv10r = [[Z484 Z495 -Z464]' [Z485 Z496 -Z465]' [Z486 Z497 -Z466]' ...
    [Z487 Z498 -Z467]' [Z488 Z499 -Z468]' [Z489 Z500 -Z469]' ...
    [Z490 Z501 -Z470]' [Z491 Z502 -Z471]' [Z492 Z503 -Z472]' ...
    [Z493 Z504 0]' [Z494 Z505 0]' zeros(3,8)];

%%

% v6ri = Rot(f, '5r', '6r') * (v5ri + cross(w5ri, f('6r').P))
% v6re = correct(Rot(f, '5r', '6r') * (v5re + cross(w5re, f('6r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r])
syms Z410 Z411 Z412 Z413 Z414 Z415 Z416 Z417 Z418 Z419 Z420 Z421 Z422 Z423 Z424 Z425 rear
v6ri = [Z410; -Z398; Z411];
v6re = [Z412*dx+Z413*dpsi+Z414*dq_imu+Z415*dq_w+Z416*dq_torso+Z417*dq_1r+Z418*dq_2r; 
    (-Z400)*dx + (-Z401)*dpsi + (-Z402)*dq_imu + (-Z403)*dq_w + (-Z404)*dq_torso;
    Z419*dx+Z420*dpsi+Z421*dq_imu+Z422*dq_w+Z423*dq_torso+Z424*dq_1r+Z425*dq_2r];

% v7ri = Rot(f, '6r', '7r') * (v6ri + cross(w6ri, f('7r').P))
% v7re = correct(Rot(f, '6r', '7r') * (v6re + cross(w6re, f('7r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r])
syms Z426 Z427 Z428 Z429 Z430 Z431 Z432 Z433 Z434 Z435 Z436 Z437 Z438 Z439 Z440 Z441 rear
v7ri = [-Z410; Z426; Z427];
v7re = [(-Z412)*dx + (-Z413)*dpsi + (-Z414)*dq_imu + (-Z415)*dq_w + (-Z416)*dq_torso + (-Z417)*dq_1r + (-Z418)*dq_2r;
    Z428*dx+Z429*dpsi+Z430*dq_imu+Z431*dq_w+Z432*dq_torso+Z433*dq_1r+Z434*dq_2r; 
    Z435*dx+Z436*dpsi+Z437*dq_imu+Z438*dq_w+Z439*dq_torso+Z440*dq_1r+Z441*dq_2r];

% v8ri = Rot(f, '7r', '8r') * (v7ri + cross(w7ri, f('8r').P))
% v8re = correct(Rot(f, '7r', '8r') * (v7re + cross(w7re, f('8r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r])
syms Z442 Z443 Z444 Z445 Z446 Z447 Z448 Z449 Z450 Z451 Z452 Z453 Z454 Z455 Z456 Z457 Z458 Z459 Z460 Z461 rear
v8ri = [Z442; -Z426; Z443];
v8re = [Z444*dx+Z445*dpsi+Z446*dq_imu+Z447*dq_w+Z448*dq_torso+Z449*dq_1r+Z450*dq_2r+Z451*dq_3r+Z452*dq_4r; 
    (-Z428)*dx + (-Z429)*dpsi + (-Z430)*dq_imu + (-Z431)*dq_w + (-Z432)*dq_torso + (-Z433)*dq_1r + (-Z434)*dq_2r
    Z453*dx+Z454*dpsi+Z455*dq_imu+Z456*dq_w+Z457*dq_torso+Z458*dq_1r+Z459*dq_2r+Z460*dq_3r+Z461*dq_4r];

% v9ri = Rot(f, '8r', '9r') * (v8ri + cross(w8ri, f('9r').P))
% v9re = correct(Rot(f, '8r', '9r') * (v8re + cross(w8re, f('9r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r])
syms Z462 Z463 Z464 Z465 Z466 Z467 Z468 Z469 Z470 Z471 Z472 Z473 Z474 Z475 Z476 Z477 Z478 Z479 Z480 Z481 rear
v9ri = [-Z442; Z462; Z463];
v9re = [(-Z444)*dx + (-Z445)*dpsi + (-Z446)*dq_imu + (-Z447)*dq_w + (-Z448)*dq_torso + (-Z449)*dq_1r + (-Z450)*dq_2r + (-Z451)*dq_3r + (-Z452)*dq_4r;
    Z464*dx+Z445*dpsi+Z466*dq_imu+Z467*dq_w+Z468*dq_torso+Z469*dq_1r+Z470*dq_2r+Z471*dq_3r+Z472*dq_4r; 
    Z473*dx+Z454*dpsi+Z475*dq_imu+Z476*dq_w+Z477*dq_torso+Z478*dq_1r+Z479*dq_2r+Z480*dq_3r+Z481*dq_4r];

% v10ri = Rot(f, '9r', '10r') * (v9ri + cross(w9ri, f('10r').P))
% v10re = correct(Rot(f, '9r', '10r') * (v9re + cross(w9re, f('10r').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1r,dq_2r,dq_3r,dq_4r,dq_5r,dq_6r])
syms Z482 Z483 Z484 Z485 Z486 Z487 Z488 Z489 Z490 Z491 Z492 Z493 Z494 Z495 Z496 Z497 Z498 Z499 Z500 Z501 Z502 Z503 Z504 Z505 rear
v10ri = [Z482; Z483; -Z462];
v10re = [Z484*dx+Z485*dpsi+Z486*dq_imu+Z487*dq_w+Z488*dq_torso+Z489*dq_1r+Z490*dq_2r+Z491*dq_3r+Z492*dq_4r+Z493*dq_5r+Z494*dq_6r; 
    Z495*dx+Z496*dpsi+Z497*dq_imu+Z498*dq_w+Z499*dq_torso+Z500*dq_1r+Z501*dq_2r+Z502*dq_3r+Z503*dq_4r+Z504*dq_5r+Z505*dq_6r; 
    (-Z464)*dx + (-Z465)*dpsi + (-Z466)*dq_imu + (-Z467)*dq_w + (-Z468)*dq_torso + (-Z469)*dq_1r + (-Z470)*dq_2r + (-Z471)*dq_3r + (-Z472)*dq_4r];
dv10r = [[Z484 Z495 -Z464]' [Z485 Z496 -Z465]' [Z486 Z497 -Z466]' ...
    [Z487 Z498 -Z467]' [Z488 Z499 -Z468]' [Z489 Z500 -Z469]' ...
    [Z490 Z501 -Z470]' [Z491 Z502 -Z471]' [Z492 Z503 -Z472]' ...
    [Z493 Z504 0]' [Z494 Z505 0]' zeros(3,8)];
