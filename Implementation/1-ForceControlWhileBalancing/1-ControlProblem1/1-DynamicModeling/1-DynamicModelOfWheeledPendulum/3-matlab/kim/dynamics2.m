clear all
syms x0 y0 psii phi dx dpsi dphi real
x_1in0 = [1 0 0]'; y_1in0 = [0 1 0]'; z_1in0= [0 0 1]'; 
P_1in0 = [x0 y0 0]'; A_1in0 = [x_1in0 y_1in0 z_1in0]; A_0in1 = A_1in0';
T_1in0 = [A_1in0 P_1in0; 0 0 0 1];
x_2in1 = [cos(psii) sin(psii) 0]'; y_2in1 = [-sin(psii) cos(psii) 0]'; z_2in1= [0 0 1]'; 
P_2in1 = [0 0 0]'; A_2in1 = [x_2in1 y_2in1 z_2in1]; A_1in2 = A_2in1';
T_2in1 = [A_2in1 P_2in1; 0 0 0 1];
x_3in2 = [cos(phi) 0 sin(phi)]'; y_3in2 = [0 1 0]'; z_3in2= [-sin(phi) 0 cos(phi)]'; 
P_3in2 = [0 0 0]'; A_3in2 = [x_3in2 y_3in2 z_3in2]; A_2in3 = A_3in2';
T_3in2 = [A_3in2 P_3in2; 0 0 0 1];

V0 = [0 0 0]';
w0 = [0 0 0]';
dq1 = dx; dq2 = dpsi; dq3 = dphi;
e1 = [cos(psii) sin(psii) 0]';
e2 = [0 0 1]';
e3 = [0 -1 0]';
w1 = A_0in1*w0;
w2 = A_1in2*w1+dq2*e2;
w3 = A_2in3*w2+dq3*e3;
V1 = A_0in1*(V0+cross(w0,P_1in0))+dq1*e1;
V2 = A_1in2*(V1+cross(w1,P_2in1));
V3 = A_2in3*(V2+cross(w2,P_3in2));

