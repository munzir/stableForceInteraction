function f = getKrangFrames(nFrames)

% This function generates a map. The keys to the maps are string literals
% in {'1', '2', '3', '4l', '5l', ... '10l', '4r', '5r', ... '10r'}
% and the values are structs that have members associated with the 
% respective joints of the robot. 
% 'x', 'y', 'z', 'P' define the unit vectors and position of origin of the 
% frame represented in the antecedent frame
% 'e' is the local angular speed of the frame represented in the same frame
% 'a' contains the key to the antecedent frame
% 'param' contains the inertial parameters of the respective link 
% 'q','dq' and 'ddq' contain associated joint pos, vel and acc variables
% 'o' defines the row of inertia matrix A (in the dynamic equations) that 
% corresponds to the current joint.

syms q_imu q_w q_torso q_1l q_2l q_3l q_4l q_5l q_6l q_7l real
syms q_1r q_2r q_3r q_4r q_5r q_6r q_7r L1 L2 L3 L4 L5 L6 L7 L8 L9 real
syms dq_imu dq_w dq_torso dq_1l dq_2l dq_3l dq_4l dq_5l dq_6l dq_7l real
syms dq_1r dq_2r dq_3r dq_4r dq_5r dq_6r dq_7r L1 L2 L3 L4 L5 L6 L7 L8 L9 real
syms ddq_imu ddq_w ddq_torso ddq_1l ddq_2l ddq_3l ddq_4l ddq_5l ddq_6l ddq_7l real
syms ddq_1r ddq_2r ddq_3r ddq_4r ddq_5r ddq_6r ddq_7r real
syms m_1 MX_1 MY_1 MZ_1 XX_1 XY_1 XZ_1 YY_1 YZ_1 ZZ_1 real
syms m_2 MX_2 MY_2 MZ_2 XX_2 XY_2 XZ_2 YY_2 YZ_2 ZZ_2 real
syms m_3 MX_3 MY_3 MZ_3 XX_3 XY_3 XZ_3 YY_3 YZ_3 ZZ_3 real
syms m_4l MX_4l MY_4l MZ_4l XX_4l XY_4l XZ_4l YY_4l YZ_4l ZZ_4l real
syms m_5l MX_5l MY_5l MZ_5l XX_5l XY_5l XZ_5l YY_5l YZ_5l ZZ_5l real
syms m_6l MX_6l MY_6l MZ_6l XX_6l XY_6l XZ_6l YY_6l YZ_6l ZZ_6l real
syms m_7l MX_7l MY_7l MZ_7l XX_7l XY_7l XZ_7l YY_7l YZ_7l ZZ_7l real
syms m_8l MX_8l MY_8l MZ_8l XX_8l XY_8l XZ_8l YY_8l YZ_8l ZZ_8l real
syms m_9l MX_9l MY_9l MZ_9l XX_9l XY_9l XZ_9l YY_9l YZ_9l ZZ_9l real
syms m_10l MX_10l MY_10l MZ_10l XX_10l XY_10l XZ_10l YY_10l YZ_10l ZZ_10l real
syms m_4r MX_4r MY_4r MZ_4r XX_4r XY_4r XZ_4r YY_4r YZ_4r ZZ_4r real
syms m_5r MX_5r MY_5r MZ_5r XX_5r XY_5r XZ_5r YY_5r YZ_5r ZZ_5r real
syms m_6r MX_6r MY_6r MZ_6r XX_6r XY_6r XZ_6r YY_6r YZ_6r ZZ_6r real
syms m_7r MX_7r MY_7r MZ_7r XX_7r XY_7r XZ_7r YY_7r YZ_7r ZZ_7r real
syms m_8r MX_8r MY_8r MZ_8r XX_8r XY_8r XZ_8r YY_8r YZ_8r ZZ_8r real
syms m_9r MX_9r MY_9r MZ_9r XX_9r XY_9r XZ_9r YY_9r YZ_9r ZZ_9r real
syms m_10r MX_10r MY_10r MZ_10r XX_10r XY_10r XZ_10r YY_10r YZ_10r ZZ_10r real


nullSym = sym([0; 0; 0]); nullSymParam = sym(zeros(10,1));
frame.x = nullSym; frame.y = nullSym; frame.z = nullSym; frame.P = nullSym;
frame.e = nullSym; frame.a = ''; frame.param = nullSymParam;
frame.q = sym(0); frame.dq = sym(0); frame.o = 0;
frame.angVel = sym(0); frame.linVel = sym(0); 
frame.angAcc = sym(0); frame.linAcc = sym(0); 
frame.gotAngVel = false; frame.gotLinVel = false; 
frame.gotAngAcc = false; frame.gotLinAcc = false; 

frame.x = sym([1; 0; 0]); frame.y = sym([0; 1; 0]);
frame.z = sym([0; 0; 1]); frame.P = sym([0; 0; 0]);
frame.e = [0; 0; 0]; frame.a = '0';
frame.q = sym(0); frame.dq = sym(0); frame.o = 0;
frame.param = nullSymParam;
% f('0') = frame;
F{1} = frame;

frame.x = sym([0; -1; 0]); frame.y = [sin(q_imu); 0; cos(q_imu)];
frame.z = [-cos(q_imu); 0; sin(q_imu)]; frame.P = sym([0; 0; 0]);
frame.e = [-1; 0; 0]; frame.a = '0';
frame.q = q_imu; frame.dq = dq_imu; frame.ddq = ddq_imu; frame.o = 1;
frame.param = [m_1 MX_1 MY_1 MZ_1 XX_1 XY_1 XZ_1 YY_1 YZ_1 ZZ_1];
% f('1') = frame;
F{2} = frame;

frame.x = sym([1; 0; 0]); frame.y = [0; cos(q_w); -sin(q_w)];
frame.z = [0; sin(q_w); cos(q_w)]; frame.P = [0; L1; -L2];
frame.e = [-1; 0; 0];  frame.a = '1';
frame.q = q_w; frame.dq = dq_w; frame.ddq = ddq_w; frame.o = 2;
frame.param = [m_2 MX_2 MY_2 MZ_2 XX_2 XY_2 XZ_2 YY_2 YZ_2 ZZ_2];
% f('2') = frame;
F{3} = frame;

frame.x = [-cos(q_torso); 0; -sin(q_torso)]; frame.y = sym([0; 1; 0]);
frame.z = [sin(q_torso); 0; -cos(q_torso)]; frame.P = [0; L3; L4];
frame.e = [0; -1; 0];  frame.a = '2';
frame.q = q_torso; frame.dq = dq_torso; frame.ddq = ddq_torso; frame.o = 3;
frame.param = [m_3 MX_3 MY_3 MZ_3 XX_3 XY_3 XZ_3 YY_3 YZ_3 ZZ_3];
% f('3') = frame;
F{4} = frame;

frame.x = [0; cos(q_1l); -sin(q_1l)]; frame.y = sym([1; 0; 0]);
frame.z = [0; -sin(q_1l); -cos(q_1l)]; frame.P = sym([L6; L5; 0]);
frame.e = [0; -1; 0];  frame.a = '3';
frame.q = q_1l; frame.dq = dq_1l; frame.ddq = ddq_1l; frame.o = 4;
frame.param = [m_4l MX_4l MY_4l MZ_4l XX_4l XY_4l XZ_4l YY_4l YZ_4l ZZ_4l];
% f('4l') = frame;
F{5} = frame;

frame.x = sym([-1; 0; 0]); frame.y = [0; -cos(q_2l); -sin(q_2l)];
frame.z = [0; -sin(q_2l); cos(q_2l)]; frame.P = sym([0; 0; 0]);
frame.e = [-1; 0; 0];  frame.a = '4l';
frame.q = q_2l; frame.dq = dq_2l; frame.ddq = ddq_2l; frame.o = 5;
frame.param = [m_5l MX_5l MY_5l MZ_5l XX_5l XY_5l XZ_5l YY_5l YZ_5l ZZ_5l];
% f('5l') = frame;
F{6} = frame;

frame.x = [-cos(q_3l); 0; sin(q_3l)]; frame.y = sym([0; -1; 0]);
frame.z = [sin(q_3l); 0; cos(q_3l)]; frame.P = sym([0; -L7; 0]);
frame.e = [0; -1; 0];  frame.a = '5l'; frame.o = 6;
frame.q = q_3l; frame.dq = dq_3l; frame.ddq = ddq_3l;
frame.param = [m_6l MX_6l MY_6l MZ_6l XX_6l XY_6l XZ_6l YY_6l YZ_6l ZZ_6l];
% f('6l') = frame;
F{7} = frame;

frame.x = sym([-1; 0; 0]); frame.y = [0; -cos(q_4l); -sin(q_4l)];
frame.z = [0; -sin(q_4l); cos(q_4l)]; frame.P = sym([0; 0; 0]);
frame.e = [-1; 0; 0];  frame.a = '6l'; frame.o = 7;
frame.q = q_4l; frame.dq = dq_4l; frame.ddq = ddq_4l;
frame.param = [m_7l MX_7l MY_7l MZ_7l XX_7l XY_7l XZ_7l YY_7l YZ_7l ZZ_7l];
% f('7l') = frame;
F{8} = frame;

frame.x = [-cos(q_5l); 0; sin(q_5l)]; frame.y = sym([0; -1; 0]);
frame.z = [sin(q_5l); 0; cos(q_5l)]; frame.P = sym([0; -L8; 0]);
frame.e = [0; -1; 0];  frame.a = '7l'; frame.o = 8;
frame.q = q_5l; frame.dq = dq_5l; frame.ddq = ddq_5l;
frame.param = [m_8l MX_8l MY_8l MZ_8l XX_8l XY_8l XZ_8l YY_8l YZ_8l ZZ_8l];
% f('8l') = frame;
F{9} = frame;

frame.x = sym([-1; 0; 0]); frame.y = [0; -cos(q_6l); -sin(q_6l)];
frame.z = [0; -sin(q_6l); cos(q_6l)]; frame.P = sym([0; 0; 0]);
frame.e = [-1; 0; 0];  frame.a = '8l'; frame.o = 9;
frame.q = q_6l; frame.dq = dq_6l; frame.ddq = ddq_6l;
frame.param = [m_9l MX_9l MY_9l MZ_9l XX_9l XY_9l XZ_9l YY_9l YZ_9l ZZ_9l];
% f('9l') = frame;
F{10} = frame;

frame.x = [-cos(q_7l); 0; sin(q_7l)]; frame.y = [-sin(q_7l); 0; -cos(q_7l)];
frame.z = sym([0; -1; 0]); frame.P = [0; -L9; 0];
frame.e = [0; 0; -1];  frame.a = '9l';
frame.q = q_7l; frame.dq = dq_7l; frame.ddq = ddq_7l; frame.o = 10;
frame.param = [m_10l MX_10l MY_10l MZ_10l XX_10l XY_10l XZ_10l YY_10l YZ_10l ZZ_10l];
% f('10l') = frame;
F{11} = frame;

frame.x = [0; cos(q_1r); sin(q_1r)]; frame.y = sym([-1; 0; 0]);
frame.z = [0; -sin(q_1r); cos(q_1r)]; frame.P = [-L6; L5; 0];
frame.e = [0; -1; 0];  frame.a = '3';
frame.q = q_1r; frame.dq = dq_1r; frame.ddq = ddq_1r; frame.o = 11;
frame.param = [m_4r MX_4r MY_4r MZ_4r XX_4r XY_4r XZ_4r YY_4r YZ_4r ZZ_4r];
% f('4r') = frame;
F{12} = frame;

frame.x = sym([-1; 0; 0]); frame.y = [0; -cos(q_2r); -sin(q_2r)];
frame.z = [0; -sin(q_2r); cos(q_2r)]; frame.P = sym([0; 0; 0]);
frame.e = [-1; 0; 0];  frame.a = '4r';
frame.q = q_2r; frame.dq = dq_2r; frame.ddq = ddq_2r; frame.o = 12;
frame.param = [m_5r MX_5r MY_5r MZ_5r XX_5r XY_5r XZ_5r YY_5r YZ_5r ZZ_5r];
% f('5r') = frame;
F{13} = frame;

frame.x = [-cos(q_3r); 0; sin(q_3r)]; frame.y = sym([0; -1; 0]);
frame.z = [sin(q_3r); 0; cos(q_3r)]; frame.P = sym([0; -L7; 0]);
frame.e = [0; -1; 0];  frame.a = '5r'; 
frame.q = q_3r; frame.dq = dq_3r; frame.ddq = ddq_3r; frame.o = 13;
frame.param = [m_6r MX_6r MY_6r MZ_6r XX_6r XY_6r XZ_6r YY_6r YZ_6r ZZ_6r];
% f('6r') = frame;
F{14} = frame;

frame.x = sym([-1; 0; 0]); frame.y = [0; -cos(q_4r); -sin(q_4r)];
frame.z = [0; -sin(q_4r); cos(q_4r)]; frame.P = sym([0; 0; 0]);
frame.e = [-1; 0; 0];  frame.a = '6r'; frame.o = 14;
frame.q = q_4r; frame.dq = dq_4r; frame.ddq = ddq_4r; frame.o = 14;
frame.param = [m_7r MX_7r MY_7r MZ_7r XX_7r XY_7r XZ_7r YY_7r YZ_7r ZZ_7r];
% f('7r') = frame;
F{15} = frame;

frame.x = [-cos(q_5r); 0; sin(q_5r)]; frame.y = sym([0; -1; 0]);
frame.z = [sin(q_5r); 0; cos(q_5r)]; frame.P = sym([0; -L8; 0]);
frame.e = [0; -1; 0];  frame.a = '7r'; frame.o = 15;
frame.q = q_5r; frame.dq = dq_5r; frame.ddq = ddq_5r; frame.o = 15;
frame.param = [m_8r MX_8r MY_8r MZ_8r XX_8r XY_8r XZ_8r YY_8r YZ_8r ZZ_8r];
% f('8r') = frame;
F{16} = frame;

frame.x = sym([-1; 0; 0]); frame.y = [0; -cos(q_6r); -sin(q_6r)];
frame.z = [0; -sin(q_6r); cos(q_6r)]; frame.P = sym([0; 0; 0]);
frame.e = [-1; 0; 0];  frame.a = '8r'; frame.o = 16;
frame.q = q_6r; frame.dq = dq_6r; frame.ddq = ddq_6r; frame.o = 16;
frame.param = [m_9r MX_9r MY_9r MZ_9r XX_9r XY_9r XZ_9r YY_9r YZ_9r ZZ_9r];
% f('9r') = frame;
F{17} = frame;

frame.x = [-cos(q_7r); 0; sin(q_7r)]; frame.y = [-sin(q_7r); 0; -cos(q_7r)];
frame.z = sym([0; -1; 0]); frame.P = [0; -L9; 0];
frame.e = [0; 0; -1];  frame.a = '9r';
frame.q = q_7r; frame.dq = dq_7r; frame.ddq = ddq_7r; frame.o = 17;
frame.param = [m_10r MX_10r MY_10r MZ_10r XX_10r XY_10r XZ_10r YY_10r YZ_10r ZZ_10r];
% f('10r') = frame;
F{18} = frame;

keys = {'0', '1', '2', '3', '4l', '5l', '6l', '7l', '8l', ...
    '9l', '10l', '4r', '5r', '6r', '7r', '8r', '9r', '10r'};

for i=1:nFrames+1; keySet{i} = keys{i}; frames{i} = F{i}; end

f = containers.Map( keySet, frames );
