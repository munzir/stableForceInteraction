% Author: Munzir Zafar
% Date: 01-16-2014
% Brief: Deriving the dynamic equations of krang's full robot except that
% robot spin is not considered as a degree of freedom

% Frames:
% 0: fixed in the world at the initial location of frame 1
% 1: Base frame located at the center of the two wheels, z always up, x always forward
% 2: Fixed on the base
% 3: Fixed on the waist
% 4: Fixed on the torso
% 5-11: Fixed on the Left Arm
% 12-18: Fixed on the right arm
% All frames axes' directions are assumed to be the same as shown in CoM
% report

% Generalized coordinates
syms theta dtheta real
q = syms('q', [18 1], 'real');
dq = syms('dq', [18 1], 'real');
ddq = syms('ddq', [18 1], 'real');

% Geometric Parameters
syms r real

% Dynamic Parameters
% masses of links
m = syms('m', [18 1], 'real');

% mass times center of mass of the links
MX = syms('MX', [18 1], 'real');
MY = syms('MY', [18 1], 'real');
MZ = syms('MZ', [18 1], 'real');

% inertial parameters of the links
XX = syms('XX', [18 1], 'real');
XY = syms('XY', [18 1], 'real');
XZ = syms('XZ', [18 1], 'real');
YX = syms('YX', [18 1], 'real');
YY = syms('YY', [18 1], 'real');
YZ = syms('YZ', [18 1], 'real');
ZX = syms('ZX', [18 1], 'real');
ZY = syms('ZY', [18 1], 'real');
ZZ = syms('ZZ', [18 1], 'real');

% Transformations
Tf = cell(18,1);
Tf{1} =   [[1; 0; 0]'; [0; 1; 0]'; [0; 0; 1]'; [r*theta; 0; 0]'; 0 0 0 1]; % Pin1 = Tf{1}*Pin0
Tf{2} =   [[cos(q1); 0; -sin(q1)]'; [0; 1; 0]'; [sin(q1); 0; cos(q1)]'; [0; 0; 0]'; 0 0 0 1]; % Pin2 = Tf{2}*Pin1
Tf{3} =   [[cos(q2); 0; -sin(q2)]'; [0; 1; 0]'; [sin(q2); 0; cos(q2)]'; [0; 0; L]'; 0 0 0 1]; % Pin3 = Tf{3}*Pin2
Tf{4} =   [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin4 = Tf{4}*Pin3
Tf{5} =   [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin5 = Tf{5}*Pin4
Tf{6} =   [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin6 = Tf{6}*Pin5
Tf{7} =   [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin7 = Tf{7}*Pin6
Tf{8} =   [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin8 = Tf{8}*Pin7
Tf{9} =  [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin9 = Tf{9}*Pin8
Tf{10} = [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin10 = Tf{10}*Pin9
Tf{11} = [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin11 = Tf{11}*Pin10
Tf{12} =  [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin12 = Tf{12}*Pin11
Tf{13} = [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin13 = Tf{13}*Pin4
Tf{14} = [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin14 = Tf{14}*Pin13
Tf{15} = [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin15 = Tf{15}*Pin14
Tf{16} = [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin16 = Tf{16}*Pin15
Tf{17} = [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin17 = Tf{17}*Pin16
Tf{18} = [[; ; ]'; [; ; ]'; [; ; ]'; [; ; ]'; 0 0 0 1]; % Pin18 = Tf{18}*Pin17
