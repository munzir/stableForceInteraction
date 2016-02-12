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

%%

% this = '6r'; prev = '5r'; aLast = a5r; arphaLast = arpha5r; wLast = w5ri;
% a6r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r])
syms Z588 Z589 Z590 rear
a6r = [Z420*ddx+Z421*ddpsi+Z422*ddq_imu+Z423*ddq_w+Z424*ddq_torso+Z425*ddq_1r+Z426*ddq_2r+Z588; 
    (-Z408)*ddx + (-Z409)*ddpsi + (-Z410)*ddq_imu + (-Z411)*ddq_w + (-Z412)*ddq_torso+Z589;
    Z427*ddx+Z428*ddpsi+Z429*ddq_imu+Z430*ddq_w+Z431*ddq_torso+Z432*ddq_1r+Z433*ddq_2r+Z590];

% this = '7r'; prev = '6r'; aLast = a6r; arphaLast = arpha6r; wLast = w6ri;
% a7r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r])
syms Z591 Z592 rear
a7r = [(-Z420)*ddx + (-Z421)*ddpsi + (-Z422)*ddq_imu + (-Z423)*ddq_w + (-Z424)*ddq_torso + (-Z425)*ddq_1r + (-Z426)*ddq_2r- Z588;
    Z436*ddx+Z437*ddpsi+Z438*ddq_imu+Z439*ddq_w+Z440*ddq_torso+Z441*ddq_1r+Z442*ddq_2r+Z591; 
    Z443*ddx+Z444*ddpsi+Z445*ddq_imu+Z446*ddq_w+Z447*ddq_torso+Z448*ddq_1r+Z449*ddq_2r+Z592];

% this = '8r'; prev = '7r'; aLast = a7r; arphaLast = arpha7r; wLast = w7ri;
% a8r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r])
syms Z593 Z594 Z595 rear
a8r = [Z452*ddx+Z453*ddpsi+Z454*ddq_imu+Z455*ddq_w+Z456*ddq_torso+Z457*ddq_1r+Z458*ddq_2r+Z459*ddq_3r+Z460*ddq_4r+Z593; 
    (-Z436)*ddx + (-Z437)*ddpsi + (-Z438)*ddq_imu + (-Z439)*ddq_w + (-Z440)*ddq_torso + (-Z441)*ddq_1r + (-Z442)*ddq_2r+Z594;
    Z461*ddx+Z462*ddpsi+Z463*ddq_imu+Z464*ddq_w+Z465*ddq_torso+Z466*ddq_1r+Z467*ddq_2r+Z468*ddq_3r+Z469*ddq_4r+Z595];

% this = '9r'; prev = '8r'; aLast = a8r; arphaLast = arpha8r; wLast = w8ri;
% a9r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r])
syms Z596 Z597 rear
a9r = [(-Z452)*ddx + (-Z453)*ddpsi + (-Z454)*ddq_imu + (-Z455)*ddq_w + (-Z456)*ddq_torso + (-Z457)*ddq_1r + (-Z458)*ddq_2r + (-Z459)*ddq_3r + (-Z460)*ddq_4r- Z593;
    Z472*ddx+Z473*ddpsi+Z474*ddq_imu+Z475*ddq_w+Z476*ddq_torso+Z477*ddq_1r+Z478*ddq_2r+Z479*ddq_3r+Z480*ddq_4r+Z596; 
    Z481*ddx+Z482*ddpsi+Z483*ddq_imu+Z484*ddq_w+Z485*ddq_torso+Z486*ddq_1r+Z487*ddq_2r+Z488*ddq_3r+Z489*ddq_4r+Z597];

% this = '10r'; prev = '9r'; aLast = a9r; arphaLast = arpha9r; wLast = w9ri;
% a10r = correct(Rot(f, prev, this) * (aLast + cross(arphaLast, f(this).P) ...    
%         + cross(wLast, cross(wLast, f(this).P))),[ddx,ddpsi,ddq_imu,ddq_w,ddq_torso,ddq_1r,ddq_2r,ddq_3r,ddq_4r,ddq_5r,ddq_6r])
syms Z598 Z599 Z600 rear
a10r = [Z492*ddx+Z493*ddpsi+Z494*ddq_imu+Z495*ddq_w+Z496*ddq_torso+Z497*ddq_1r+Z498*ddq_2r+Z499*ddq_3r+Z500*ddq_4r+Z501*ddq_5r+Z502*ddq_6r+Z598; 
    Z503*ddx+Z504*ddpsi+Z505*ddq_imu+Z506*ddq_w+Z507*ddq_torso+Z508*ddq_1r+Z509*ddq_2r+Z510*ddq_3r+Z511*ddq_4r+Z512*ddq_5r+Z513*ddq_6r+Z599; 
    (-Z472)*ddx + (-Z473)*ddpsi + (-Z474)*ddq_imu + (-Z475)*ddq_w + (-Z476)*ddq_torso + (-Z477)*ddq_1r + (-Z478)*ddq_2r + (-Z479)*ddq_3r + (-Z480)*ddq_4r+Z600];
