% g_6r = correct(Rot(f, '5r', '6r')*g_5r,g)
% g_6r =
%  
%  (- Z137*cos(q_3r) - Z150*sin(q_3r))*g
%                                Z146*g
%    (Z137*sin(q_3r) - Z150*cos(q_3r))*g
g_6r = [-Z157*g; Z146*g; -Z162*g];


% g_7r = correct(Rot(f, '6r', '7r')*g_6r,g)
% g_7r =
%  
%                                Z157*g
%    (Z162*sin(q_4r) - Z146*cos(q_4r))*g
%  (- Z162*cos(q_4r) - Z146*sin(q_4r))*g
g_7r = [Z157*g; -Z170*g; -Z176*g];

% g_8r = correct(Rot(f, '7r', '8r')*g_7r,g)
% g_8r =
%  
%  (- Z157*cos(q_5r) - Z176*sin(q_5r))*g
%                                Z170*g
%    (Z157*sin(q_5r) - Z176*cos(q_5r))*g
g_8r = [-Z185*g; Z170*g; -Z192*g];

% g_9r = correct(Rot(f, '8r', '9r')*g_8r,g)
% g_9r =
%  
%                                Z185*g
%    (Z192*sin(q_6r) - Z170*cos(q_6r))*g
%  (- Z192*cos(q_6r) - Z170*sin(q_6r))*g
g_9r = [Z185*g; -Z202*g; -Z210*g];

% g_10r = correct(Rot(f, '9r', '10r')*g_9r,g)
% g_10r =
%  
%  (- Z185*cos(q_7r) - Z210*sin(q_7r))*g
%    (Z210*cos(q_7r) - Z185*sin(q_7r))*g
%                                 Z202*g
g_10r = [-Z221*g; -Z230*g; Z202*g];
