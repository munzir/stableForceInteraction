% v6li = Rot(f, '5l', '6l') * (v5li + cross(w5li, f('6l').P))
% v6le = collect(Rot(f, '5l', '6l') * (v5le + cross(w5le, f('6l').P)),[dx,dpsi,dq_imu,dq_w,dq_1l,dq_2l])
% v6li =
%  
%  sin(q_3l)*(Z275 - L7*Z30) + cos(q_3l)*(Z258 - L7*Z32)
%                                                  -Z274
%  cos(q_3l)*(Z275 - L7*Z30) - sin(q_3l)*(Z258 - L7*Z32)
%  
%  
% v6le =
%  
%  (Z261*cos(q_3l) + Z281*sin(q_3l))*dx + (sin(q_3l)*(Z282 + L7*Z24) + cos(q_3l)*(Z262 - L7*Z37))*dpsi + (sin(q_3l)*(Z283 + L7*Z25) + cos(q_3l)*(Z263 - L7*Z38))*dq_imu + (sin(q_3l)*(Z284 + L7*Z25) + cos(q_3l)*(Z264 - L7*Z38))*dq_w + (sin(q_3l)*(Z285 + L7*Z26) + cos(q_3l)*(Z265 - L7*Z39))*dq_torso + (-L7*Z40*cos(q_3l))*dq_1l + (L7*sin(q_3l))*dq_2l
%                                                                                                                                                                                                                                                                               (-Z276)*dx + (-Z277)*dpsi + (-Z278)*dq_imu + (-Z279)*dq_w + (-Z280)*dq_torso
%   (Z281*cos(q_3l) - Z261*sin(q_3l))*dx + (cos(q_3l)*(Z282 + L7*Z24) - sin(q_3l)*(Z262 - L7*Z37))*dpsi + (cos(q_3l)*(Z283 + L7*Z25) - sin(q_3l)*(Z263 - L7*Z38))*dq_imu + (cos(q_3l)*(Z284 + L7*Z25) - sin(q_3l)*(Z264 - L7*Z38))*dq_w + (cos(q_3l)*(Z285 + L7*Z26) - sin(q_3l)*(Z265 - L7*Z39))*dq_torso + (L7*Z40*sin(q_3l))*dq_1l + (L7*cos(q_3l))*dq_2l
 
Z286 = sin(q_3l)*(Z275 - L7*Z30) + cos(q_3l)*(Z258 - L7*Z32);
Z287 = cos(q_3l)*(Z275 - L7*Z30) - sin(q_3l)*(Z258 - L7*Z32);
Z288 = (Z261*cos(q_3l) + Z281*sin(q_3l));
Z289 = + (sin(q_3l)*(Z282 + L7*Z24) + cos(q_3l)*(Z262 - L7*Z37));
Z290 = + (sin(q_3l)*(Z283 + L7*Z25) + cos(q_3l)*(Z263 - L7*Z38));
Z291 = + (sin(q_3l)*(Z284 + L7*Z25) + cos(q_3l)*(Z264 - L7*Z38));
Z292 = + (sin(q_3l)*(Z285 + L7*Z26) + cos(q_3l)*(Z265 - L7*Z39));
Z293 = + (-L7*Z40*cos(q_3l));
Z294 = + (L7*sin(q_3l));
Z295 = (Z281*cos(q_3l) - Z261*sin(q_3l));
Z296 = + (cos(q_3l)*(Z282 + L7*Z24) - sin(q_3l)*(Z262 - L7*Z37));
Z297 = + (cos(q_3l)*(Z283 + L7*Z25) - sin(q_3l)*(Z263 - L7*Z38));
Z298 = + (cos(q_3l)*(Z284 + L7*Z25) - sin(q_3l)*(Z264 - L7*Z38));
Z299 = + (cos(q_3l)*(Z285 + L7*Z26) - sin(q_3l)*(Z265 - L7*Z39));
Z300 = + (L7*Z40*sin(q_3l));
Z301 = + (L7*cos(q_3l));

v6li = [Z286; -Z274; Z287];
v6le = [Z288*dx+Z289*dpsi+Z290*dq_imu+Z291*dq_w+Z292*dq_torso+Z293*dq_1l+Z294*dq_2l; 
    (-Z276)*dx + (-Z277)*dpsi + (-Z278)*dq_imu + (-Z279)*dq_w + (-Z280)*dq_torso;
    Z295*dx+Z296*dpsi+Z297*dq_imu+Z298*dq_w+Z299*dq_torso+Z300*dq_1l+Z301*dq_2l];
dv6l = [[Z288 -Z276 Z295]' [Z289 -Z77 Z296]' [Z290 -Z278 Z297]' ...
    [Z291 -Z279 Z298]' [Z292 -Z280 Z299]' [Z293 0 Z300]' [Z294 0 Z301]' ...
    zeros(3,12)];

% v7li = Rot(f, '6l', '7l') * (v6li + cross(w6li, f('7l').P))
% v7le = collect(Rot(f, '6l', '7l') * (v6le + cross(w6le, f('7l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l])
% v7li =
%  
%                            -Z286
%  Z274*cos(q_4l) - Z287*sin(q_4l)
%  Z287*cos(q_4l) + Z274*sin(q_4l)
%  
%  
% v7le =
%  
%                                                                                                                                                        (-Z288)*dx + (-Z289)*dpsi + (-Z290)*dq_imu + (-Z291)*dq_w + (-Z292)*dq_torso + (-Z293)*dq_1l + (-Z294)*dq_2l
%  (Z276*cos(q_4l) - Z295*sin(q_4l))*dx + (Z277*cos(q_4l) - Z296*sin(q_4l))*dpsi + (Z278*cos(q_4l) - Z297*sin(q_4l))*dq_imu + (Z279*cos(q_4l) - Z298*sin(q_4l))*dq_w + (Z280*cos(q_4l) - Z299*sin(q_4l))*dq_torso + (-Z300*sin(q_4l))*dq_1l + (-Z301*sin(q_4l))*dq_2l
%    (Z295*cos(q_4l) + Z276*sin(q_4l))*dx + (Z296*cos(q_4l) + Z277*sin(q_4l))*dpsi + (Z297*cos(q_4l) + Z278*sin(q_4l))*dq_imu + (Z298*cos(q_4l) + Z279*sin(q_4l))*dq_w + (Z299*cos(q_4l) + Z280*sin(q_4l))*dq_torso + (Z300*cos(q_4l))*dq_1l + (Z301*cos(q_4l))*dq_2l
%  
% v7li = Rot(f, '6l', '7l') * (v6li + cross(w6li, f('7l').P))
% v7le = collect(Rot(f, '6l', '7l') * (v6le + cross(w6le, f('7l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l])

Z302 = Z274*cos(q_4l) - Z287*sin(q_4l);
Z303 = Z287*cos(q_4l) + Z274*sin(q_4l);
Z304 = (Z276*cos(q_4l) - Z295*sin(q_4l));
Z305 = + (Z277*cos(q_4l) - Z296*sin(q_4l));
Z306 = + (Z278*cos(q_4l) - Z297*sin(q_4l));
Z307 = + (Z279*cos(q_4l) - Z298*sin(q_4l));
Z308 = + (Z280*cos(q_4l) - Z299*sin(q_4l));
Z309 = + (-Z300*sin(q_4l));
Z310 = + (-Z301*sin(q_4l));
Z311 = (Z295*cos(q_4l) + Z276*sin(q_4l));
Z312 = + (Z296*cos(q_4l) + Z277*sin(q_4l));
Z313 = + (Z297*cos(q_4l) + Z278*sin(q_4l));
Z314 = + (Z298*cos(q_4l) + Z279*sin(q_4l));
Z315 = + (Z299*cos(q_4l) + Z280*sin(q_4l));
Z316 = + (Z300*cos(q_4l)); 
Z317 = + (Z301*cos(q_4l));
 
v7li = [-Z286; Z302; Z303];
v7le = [(-Z288)*dx + (-Z289)*dpsi + (-Z290)*dq_imu + (-Z291)*dq_w + (-Z292)*dq_torso + (-Z293)*dq_1l + (-Z294)*dq_2l;
    Z304*dx+Z305*dpsi+Z306*dq_imu+Z307*dq_w+Z308*dq_torso+Z309*dq_1l+Z310*dq_2l; 
    Z311*dx+Z312*dpsi+Z313*dq_imu+Z314*dq_w+Z315*dq_torso+Z316*dq_1l+Z317*dq_2l];
dv7l = [[-Z288 Z304 Z311]' [-Z289 Z305 Z312]' [-Z290 Z306 Z313]' ...
    [-Z291 Z307 Z314]' [-Z292 Z308 Z315]' [-Z293 Z309 Z316]' ...
    [-Z294 Z310 Z317]' zeros(3,12)];

% v8li = Rot(f, '7l', '8l') * (v7li + cross(w7li, f('8l').P))
% v8le = collect(Rot(f, '7l', '8l') * (v7le + cross(w7le, f('8l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l])
% v8li =
%  
%  sin(q_5l)*(Z303 - L8*Z54) + cos(q_5l)*(Z286 - L8*Z56)
%                                                  -Z302
%  cos(q_5l)*(Z303 - L8*Z54) - sin(q_5l)*(Z286 - L8*Z56)
%  
%  
% v8le =
%  
%  (Z288*cos(q_5l) + Z311*sin(q_5l))*dx + (sin(q_5l)*(Z312 + L8*Z44) + cos(q_5l)*(Z289 - L8*Z63))*dpsi + (sin(q_5l)*(Z313 + L8*Z45) + cos(q_5l)*(Z290 - L8*Z64))*dq_imu + (sin(q_5l)*(Z314 + L8*Z45) + cos(q_5l)*(Z291 - L8*Z64))*dq_w + (sin(q_5l)*(Z315 + L8*Z46) + cos(q_5l)*(Z292 - L8*Z65))*dq_torso + (sin(q_5l)*(Z316 + L8*Z47) + cos(q_5l)*(Z293 - L8*Z66))*dq_1l + (sin(q_5l)*(Z317 + L8*Z48) + cos(q_5l)*(Z294 - L8*Z67))*dq_2l + (-L8*Z68*cos(q_5l))*dq_3l + (L8*sin(q_5l))*dq_4l
%                                                                                                                                                                                                                                                                                                                                                                               (-Z304)*dx + (-Z305)*dpsi + (-Z306)*dq_imu + (-Z307)*dq_w + (-Z308)*dq_torso + (-Z309)*dq_1l + (-Z310)*dq_2l
%   (Z311*cos(q_5l) - Z288*sin(q_5l))*dx + (cos(q_5l)*(Z312 + L8*Z44) - sin(q_5l)*(Z289 - L8*Z63))*dpsi + (cos(q_5l)*(Z313 + L8*Z45) - sin(q_5l)*(Z290 - L8*Z64))*dq_imu + (cos(q_5l)*(Z314 + L8*Z45) - sin(q_5l)*(Z291 - L8*Z64))*dq_w + (cos(q_5l)*(Z315 + L8*Z46) - sin(q_5l)*(Z292 - L8*Z65))*dq_torso + (cos(q_5l)*(Z316 + L8*Z47) - sin(q_5l)*(Z293 - L8*Z66))*dq_1l + (cos(q_5l)*(Z317 + L8*Z48) - sin(q_5l)*(Z294 - L8*Z67))*dq_2l + (L8*Z68*sin(q_5l))*dq_3l + (L8*cos(q_5l))*dq_4l

Z318 = sin(q_5l)*(Z303 - L8*Z54) + cos(q_5l)*(Z286 - L8*Z56);
Z319 = cos(q_5l)*(Z303 - L8*Z54) - sin(q_5l)*(Z286 - L8*Z56);
Z320 = (Z288*cos(q_5l) + Z311*sin(q_5l));
Z321 = + (sin(q_5l)*(Z312 + L8*Z44) + cos(q_5l)*(Z289 - L8*Z63));
Z322 = + (sin(q_5l)*(Z313 + L8*Z45) + cos(q_5l)*(Z290 - L8*Z64));
Z323 = + (sin(q_5l)*(Z314 + L8*Z45) + cos(q_5l)*(Z291 - L8*Z64));
Z324 = + (sin(q_5l)*(Z315 + L8*Z46) + cos(q_5l)*(Z292 - L8*Z65));
Z325 = + (sin(q_5l)*(Z316 + L8*Z47) + cos(q_5l)*(Z293 - L8*Z66));
Z326 = + (sin(q_5l)*(Z317 + L8*Z48) + cos(q_5l)*(Z294 - L8*Z67));
Z327 = + (-L8*Z68*cos(q_5l));
Z328 = + (L8*sin(q_5l));
Z329 = (Z311*cos(q_5l) - Z288*sin(q_5l));
Z330 = + (cos(q_5l)*(Z312 + L8*Z44) - sin(q_5l)*(Z289 - L8*Z63));
Z331 = + (cos(q_5l)*(Z313 + L8*Z45) - sin(q_5l)*(Z290 - L8*Z64));
Z332 = + (cos(q_5l)*(Z314 + L8*Z45) - sin(q_5l)*(Z291 - L8*Z64));
Z333 = + (cos(q_5l)*(Z315 + L8*Z46) - sin(q_5l)*(Z292 - L8*Z65));
Z334 = + (cos(q_5l)*(Z316 + L8*Z47) - sin(q_5l)*(Z293 - L8*Z66));
Z335 = + (cos(q_5l)*(Z317 + L8*Z48) - sin(q_5l)*(Z294 - L8*Z67));
Z336 = + (L8*Z68*sin(q_5l));
Z337 = + (L8*cos(q_5l));

v8li = [Z318; -Z302; Z319];
v8le = [Z320*dx+Z321*dpsi+Z322*dq_imu+Z323*dq_w+Z324*dq_torso+Z325*dq_1l+Z326*dq_2l+Z327*dq_3l+Z328*dq_4l; 
    (-Z304)*dx + (-Z305)*dpsi + (-Z306)*dq_imu + (-Z307)*dq_w + (-Z308)*dq_torso + (-Z309)*dq_1l + (-Z310)*dq_2l
    Z329*dx+Z330*dpsi+Z331*dq_imu+Z332*dq_w+Z333*dq_torso+Z334*dq_1l+Z335*dq_2l+Z336*dq_3l+Z337*dq_4l];
dv8l = [[Z320 -Z304 Z329]' [Z321 -Z305 Z330]' [Z322 -Z306 Z331]' ...
    [Z323 -Z307 Z332]' [Z324 -Z308 Z333]' [Z325 -Z309 Z334]' ...
    [Z326 -Z310 Z335]' [Z327 0 Z336]' [Z328 0 Z337]' zeros(3,10)];


% v9li = Rot(f, '8l', '9l') * (v8li + cross(w8li, f('9l').P))
% v9le = collect(Rot(f, '8l', '9l') * (v8le + cross(w8le, f('9l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l])
% v9li =
%  
%                            -Z318
%  Z302*cos(q_6l) - Z319*sin(q_6l)
%  Z319*cos(q_6l) + Z302*sin(q_6l)
%  
%  
% v9le =
%  
%                                                                                                                                                                                                            (-Z320)*dx + (-Z321)*dpsi + (-Z322)*dq_imu + (-Z323)*dq_w + (-Z324)*dq_torso + (-Z325)*dq_1l + (-Z326)*dq_2l + (-Z327)*dq_3l + (-Z328)*dq_4l
%  (Z304*cos(q_6l) - Z329*sin(q_6l))*dx + (Z305*cos(q_6l) - Z330*sin(q_6l))*dpsi + (Z306*cos(q_6l) - Z331*sin(q_6l))*dq_imu + (Z307*cos(q_6l) - Z332*sin(q_6l))*dq_w + (Z308*cos(q_6l) - Z333*sin(q_6l))*dq_torso + (Z309*cos(q_6l) - Z334*sin(q_6l))*dq_1l + (Z310*cos(q_6l) - Z335*sin(q_6l))*dq_2l + (-Z336*sin(q_6l))*dq_3l + (-Z337*sin(q_6l))*dq_4l
%    (Z329*cos(q_6l) + Z304*sin(q_6l))*dx + (Z330*cos(q_6l) + Z305*sin(q_6l))*dpsi + (Z331*cos(q_6l) + Z306*sin(q_6l))*dq_imu + (Z332*cos(q_6l) + Z307*sin(q_6l))*dq_w + (Z333*cos(q_6l) + Z308*sin(q_6l))*dq_torso + (Z334*cos(q_6l) + Z309*sin(q_6l))*dq_1l + (Z335*cos(q_6l) + Z310*sin(q_6l))*dq_2l + (Z336*cos(q_6l))*dq_3l + (Z337*cos(q_6l))*dq_4l

Z338 = Z302*cos(q_6l) - Z319*sin(q_6l);
Z339 = Z319*cos(q_6l) + Z302*sin(q_6l);
Z340 = (Z304*cos(q_6l) - Z329*sin(q_6l));
Z341 = + (Z305*cos(q_6l) - Z330*sin(q_6l));
Z342 = + (Z306*cos(q_6l) - Z331*sin(q_6l));
Z343 = + (Z307*cos(q_6l) - Z332*sin(q_6l));
Z344 = + (Z308*cos(q_6l) - Z333*sin(q_6l));
Z345 = + (Z309*cos(q_6l) - Z334*sin(q_6l));
Z346 = + (Z310*cos(q_6l) - Z335*sin(q_6l));
Z347 = + (-Z336*sin(q_6l));
Z348 = + (-Z337*sin(q_6l));
Z349 = (Z329*cos(q_6l) + Z304*sin(q_6l));
Z350 = + (Z330*cos(q_6l) + Z305*sin(q_6l));
Z351 = + (Z331*cos(q_6l) + Z306*sin(q_6l));
Z352 = + (Z332*cos(q_6l) + Z307*sin(q_6l));
Z353 = + (Z333*cos(q_6l) + Z308*sin(q_6l));
Z354 = + (Z334*cos(q_6l) + Z309*sin(q_6l));
Z355 = + (Z335*cos(q_6l) + Z310*sin(q_6l));
Z356 = + (Z336*cos(q_6l));
Z357 = + (Z337*cos(q_6l));

v9li = [-Z318; Z338; Z339];
v9le = [(-Z320)*dx + (-Z321)*dpsi + (-Z322)*dq_imu + (-Z323)*dq_w + (-Z324)*dq_torso + (-Z325)*dq_1l + (-Z326)*dq_2l + (-Z327)*dq_3l + (-Z328)*dq_4l;
    Z340*dx+Z341*dpsi+Z342*dq_imu+Z343*dq_w+Z344*dq_torso+Z345*dq_1l+Z346*dq_2l+Z347*dq_3l+Z348*dq_4l; 
    Z349*dx+Z350*dpsi+Z351*dq_imu+Z352*dq_w+Z353*dq_torso+Z354*dq_1l+Z355*dq_2l+Z356*dq_3l+Z357*dq_4l];
dv9l = [[-Z320 Z340 Z349]' [-Z321 Z341 Z350]' [-Z322 Z342 Z351]' ...
    [-Z323 Z343 Z352]' [-Z324 Z344 Z353]' [-Z325 Z345 Z354]' ...
    [-Z326 Z346 Z355]' [-Z327 Z347 Z356]' [-Z328 Z348 Z357]' zeros(3,10)];


% v10li = Rot(f, '9l', '10l') * (v9li + cross(w9li, f('10l').P))
% v10le = collect(Rot(f, '9l', '10l') * (v9le + cross(w9le, f('10l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l])
% v10li =
%  
%  sin(q_7l)*(Z339 - L9*Z86) + cos(q_7l)*(Z318 - L9*Z88)
%  sin(q_7l)*(Z318 - L9*Z88) - cos(q_7l)*(Z339 - L9*Z86)
%                                                  -Z338
%  
%  
% v10le =
%  
%   (Z320*cos(q_7l) + Z349*sin(q_7l))*dx + (sin(q_7l)*(Z330 + L9*Z72) + cos(q_7l)*(Z321 - L9*Z97))*dpsi + (sin(q_7l)*(Z351 + L9*Z73) + cos(q_7l)*(Z322 - L9*Z98))*dq_imu + (sin(q_7l)*(Z352 + L9*Z73) + cos(q_7l)*(Z323 - L9*Z98))*dq_w + (sin(q_7l)*(Z353 + L9*Z74) + cos(q_7l)*(Z324 - L9*Z99))*dq_torso + (sin(q_7l)*(Z354 + L9*Z75) + cos(q_7l)*(Z325 - L9*Z100))*dq_1l + (sin(q_7l)*(Z355 + L9*Z76) + cos(q_7l)*(Z326 - L9*Z101))*dq_2l + (sin(q_7l)*(Z356 + L9*Z77) + cos(q_7l)*(Z327 - L9*Z102))*dq_3l + (sin(q_7l)*(Z357 + L9*Z78) + cos(q_7l)*(Z328 - L9*Z103))*dq_4l + (-L9*Z104*cos(q_7l))*dq_5l + (L9*sin(q_7l))*dq_6l
%  (Z320*sin(q_7l) - Z349*cos(q_7l))*dx + (sin(q_7l)*(Z321 - L9*Z97) - cos(q_7l)*(Z330 + L9*Z72))*dpsi + (sin(q_7l)*(Z322 - L9*Z98) - cos(q_7l)*(Z351 + L9*Z73))*dq_imu + (sin(q_7l)*(Z323 - L9*Z98) - cos(q_7l)*(Z352 + L9*Z73))*dq_w + (sin(q_7l)*(Z324 - L9*Z99) - cos(q_7l)*(Z353 + L9*Z74))*dq_torso + (sin(q_7l)*(Z325 - L9*Z100) - cos(q_7l)*(Z354 + L9*Z75))*dq_1l + (sin(q_7l)*(Z326 - L9*Z101) - cos(q_7l)*(Z355 + L9*Z76))*dq_2l + (sin(q_7l)*(Z327 - L9*Z102) - cos(q_7l)*(Z356 + L9*Z77))*dq_3l + (sin(q_7l)*(Z328 - L9*Z103) - cos(q_7l)*(Z357 + L9*Z78))*dq_4l + (-L9*Z104*sin(q_7l))*dq_5l + (-L9*cos(q_7l))*dq_6l
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     (-Z340)*dx + (-Z321)*dpsi + (-Z342)*dq_imu + (-Z343)*dq_w + (-Z344)*dq_torso + (-Z345)*dq_1l + (-Z346)*dq_2l + (-Z347)*dq_3l + (-Z348)*dq_4l

Z358 = sin(q_7l)*(Z339 - L9*Z86) + cos(q_7l)*(Z318 - L9*Z88);
Z359 = sin(q_7l)*(Z318 - L9*Z88) - cos(q_7l)*(Z339 - L9*Z86);
Z360 = (Z320*cos(q_7l) + Z349*sin(q_7l));
Z361 = + (sin(q_7l)*(Z350 + L9*Z72) + cos(q_7l)*(Z321 - L9*Z97));
Z362 = + (sin(q_7l)*(Z351 + L9*Z73) + cos(q_7l)*(Z322 - L9*Z98));
Z363 = + (sin(q_7l)*(Z352 + L9*Z73) + cos(q_7l)*(Z323 - L9*Z98));
Z364 = + (sin(q_7l)*(Z353 + L9*Z74) + cos(q_7l)*(Z324 - L9*Z99));
Z365 = + (sin(q_7l)*(Z354 + L9*Z75) + cos(q_7l)*(Z325 - L9*Z100));
Z366 = + (sin(q_7l)*(Z355 + L9*Z76) + cos(q_7l)*(Z326 - L9*Z101));
Z367 = + (sin(q_7l)*(Z356 + L9*Z77) + cos(q_7l)*(Z327 - L9*Z102));
Z368 = + (sin(q_7l)*(Z357 + L9*Z78) + cos(q_7l)*(Z328 - L9*Z103));
Z369 = + (-L9*Z104*cos(q_7l));
Z370 = + (L9*sin(q_7l));
Z371 = (Z320*sin(q_7l) - Z349*cos(q_7l));
Z372 = + (sin(q_7l)*(Z321 - L9*Z97) - cos(q_7l)*(Z350 + L9*Z72));
Z373 = + (sin(q_7l)*(Z322 - L9*Z98) - cos(q_7l)*(Z351 + L9*Z73));
Z374 = + (sin(q_7l)*(Z323 - L9*Z98) - cos(q_7l)*(Z352 + L9*Z73));
Z375 = + (sin(q_7l)*(Z324 - L9*Z99) - cos(q_7l)*(Z353 + L9*Z74));
Z376 = + (sin(q_7l)*(Z325 - L9*Z100) - cos(q_7l)*(Z354 + L9*Z75));
Z377 = + (sin(q_7l)*(Z326 - L9*Z101) - cos(q_7l)*(Z355 + L9*Z76));
Z378 = + (sin(q_7l)*(Z327 - L9*Z102) - cos(q_7l)*(Z356 + L9*Z77));
Z379 = + (sin(q_7l)*(Z328 - L9*Z103) - cos(q_7l)*(Z357 + L9*Z78));
Z380 = + (-L9*Z104*sin(q_7l));
Z381 = + (-L9*cos(q_7l));

v10li = [Z358; Z359; -Z338];
v10le = [Z360*dx+Z361*dpsi+Z362*dq_imu+Z363*dq_w+Z364*dq_torso+Z365*dq_1l+Z366*dq_2l+Z367*dq_3l+Z368*dq_4l+Z369*dq_5l+Z370*dq_6l; 
    Z371*dx+Z372*dpsi+Z373*dq_imu+Z374*dq_w+Z375*dq_torso+Z376*dq_1l+Z377*dq_2l+Z378*dq_3l+Z379*dq_4l+Z380*dq_5l+Z381*dq_6l; 
    (-Z340)*dx + (-Z341)*dpsi + (-Z342)*dq_imu + (-Z343)*dq_w + (-Z344)*dq_torso + (-Z345)*dq_1l + (-Z346)*dq_2l + (-Z347)*dq_3l + (-Z348)*dq_4l];
dv10l = [[Z360 Z371 -Z340]' [Z361 Z372 -Z341]' [Z362 Z373 -Z342]' ...
    [Z363 Z374 -Z343]' [Z364 Z375 -Z344]' [Z365 Z376 -Z345]' ...
    [Z366 Z377 -Z346]' [Z367 Z378 -Z347]' [Z368 Z379 -Z348]' ...
    [Z369 Z380 0]' [Z370 Z381 0]' zeros(3,8)];

%%

% v6li = Rot(f, '5l', '6l') * (v5li + cross(w5li, f('6l').P))
% v6le = collect(Rot(f, '5l', '6l') * (v5le + cross(w5le, f('6l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l])
syms Z286 Z287 Z288 Z289 Z290 Z291 Z292 Z293 Z294 Z295 Z296 Z297 Z298 Z299 Z300 Z301 real
v6li = [Z286; -Z274; Z287];
v6le = [Z288*dx+Z289*dpsi+Z290*dq_imu+Z291*dq_w+Z292*dq_torso+Z293*dq_1l+Z294*dq_2l; 
    (-Z276)*dx + (-Z277)*dpsi + (-Z278)*dq_imu + (-Z279)*dq_w + (-Z280)*dq_torso;
    Z295*dx+Z296*dpsi+Z297*dq_imu+Z298*dq_w+Z299*dq_torso+Z300*dq_1l+Z301*dq_2l];

% v7li = Rot(f, '6l', '7l') * (v6li + cross(w6li, f('7l').P))
% v7le = collect(Rot(f, '6l', '7l') * (v6le + cross(w6le, f('7l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l])
syms Z302 Z303 Z304 Z305 Z306 Z307 Z308 Z309 Z310 Z311 Z312 Z313 Z314 Z315 Z316 Z317 real
v7li = [-Z286; Z302; Z303];
v7le = [(-Z288)*dx + (-Z289)*dpsi + (-Z290)*dq_imu + (-Z291)*dq_w + (-Z292)*dq_torso + (-Z293)*dq_1l + (-Z294)*dq_2l;
    Z304*dx+Z305*dpsi+Z306*dq_imu+Z307*dq_w+Z308*dq_torso+Z309*dq_1l+Z310*dq_2l; 
    Z311*dx+Z312*dpsi+Z313*dq_imu+Z314*dq_w+Z315*dq_torso+Z316*dq_1l+Z317*dq_2l];

% v8li = Rot(f, '7l', '8l') * (v7li + cross(w7li, f('8l').P))
% v8le = collect(Rot(f, '7l', '8l') * (v7le + cross(w7le, f('8l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l])
syms Z318 Z319 Z320 Z321 Z322 Z323 Z324 Z325 Z326 Z327 Z328 Z329 Z330 Z331 Z332 Z333 Z334 Z335 Z336 Z337 real
v8li = [Z318; -Z302; Z319];
v8le = [Z320*dx+Z321*dpsi+Z322*dq_imu+Z323*dq_w+Z324*dq_torso+Z325*dq_1l+Z326*dq_2l+Z327*dq_3l+Z328*dq_4l; 
    (-Z304)*dx + (-Z305)*dpsi + (-Z306)*dq_imu + (-Z307)*dq_w + (-Z308)*dq_torso + (-Z309)*dq_1l + (-Z310)*dq_2l
    Z329*dx+Z330*dpsi+Z331*dq_imu+Z332*dq_w+Z333*dq_torso+Z334*dq_1l+Z335*dq_2l+Z336*dq_3l+Z337*dq_4l];

% v9li = Rot(f, '8l', '9l') * (v8li + cross(w8li, f('9l').P))
% v9le = collect(Rot(f, '8l', '9l') * (v8le + cross(w8le, f('9l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l])
syms Z338 Z339 Z340 Z341 Z342 Z343 Z344 Z345 Z346 Z347 Z348 Z349 Z350 Z351 Z352 Z353 Z354 Z355 Z356 Z357 real
v9li = [-Z318; Z338; Z339];
v9le = [(-Z320)*dx + (-Z321)*dpsi + (-Z322)*dq_imu + (-Z323)*dq_w + (-Z324)*dq_torso + (-Z325)*dq_1l + (-Z326)*dq_2l + (-Z327)*dq_3l + (-Z328)*dq_4l;
    Z340*dx+Z321*dpsi+Z342*dq_imu+Z343*dq_w+Z344*dq_torso+Z345*dq_1l+Z346*dq_2l+Z347*dq_3l+Z348*dq_4l; 
    Z349*dx+Z330*dpsi+Z351*dq_imu+Z352*dq_w+Z353*dq_torso+Z354*dq_1l+Z355*dq_2l+Z356*dq_3l+Z357*dq_4l];

% v10li = Rot(f, '9l', '10l') * (v9li + cross(w9li, f('10l').P))
% v10le = collect(Rot(f, '9l', '10l') * (v9le + cross(w9le, f('10l').P)),[dx,dpsi,dq_imu,dq_w,dq_torso,dq_1l,dq_2l,dq_3l,dq_4l,dq_5l,dq_6l])
syms Z358 Z359 Z360 Z361 Z362 Z363 Z364 Z365 Z366 Z367 Z368 Z369 Z370 Z371 Z372 Z373 Z374 Z375 Z376 Z377 Z378 Z379 Z380 Z381 real
v10li = [Z358; Z359; -Z338];
v10le = [Z360*dx+Z361*dpsi+Z362*dq_imu+Z363*dq_w+Z364*dq_torso+Z365*dq_1l+Z366*dq_2l+Z367*dq_3l+Z368*dq_4l+Z369*dq_5l+Z370*dq_6l; 
    Z371*dx+Z372*dpsi+Z373*dq_imu+Z374*dq_w+Z375*dq_torso+Z376*dq_1l+Z377*dq_2l+Z378*dq_3l+Z379*dq_4l+Z380*dq_5l+Z381*dq_6l; 
    (-Z340)*dx + (-Z341)*dpsi + (-Z342)*dq_imu + (-Z343)*dq_w + (-Z344)*dq_torso + (-Z345)*dq_1l + (-Z346)*dq_2l + (-Z347)*dq_3l + (-Z348)*dq_4l];
dv10l = [[Z360 Z371 -Z340]' [Z361 Z372 -Z341]' [Z362 Z373 -Z342]' ...
    [Z363 Z374 -Z343]' [Z364 Z375 -Z344]' [Z365 Z376 -Z345]' ...
    [Z366 Z377 -Z346]' [Z367 Z378 -Z347]' [Z368 Z379 -Z348]' ...
    [Z369 Z380 0]' [Z370 Z381 0]' zeros(3,8)];
