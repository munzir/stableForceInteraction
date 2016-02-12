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