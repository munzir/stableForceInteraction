load PE

% dq_j * eeta_j * K_j = a_j'*JJ_j*VV_j - 0.5*dq_j*a_j'*JJ_j*a_j
a1 = [0; 0; 0; 0; -1; 0];
a2 = [0; 0; 0; -1; 0; 0];
a3 = [0; 0; 0; 0; -1; 0];
a4 = [0; 0; 0; -1; 0; 0];
a5 = [0; 0; 0; 0; -1; 0];
a6 = [0; 0; 0; -1; 0; 0];
a7 = [0; 0; 0; 0; 0; -1];

JJ1 = [m1*eye(3) -skew(MS1); skew(MS1) J1];
JJ2 = [m2*eye(3) -skew(MS2); skew(MS2) J2];
JJ3 = [m3*eye(3) -skew(MS3); skew(MS3) J3];
JJ4 = [m4*eye(3) -skew(MS4); skew(MS4) J4];
JJ5 = [m5*eye(3) -skew(MS5); skew(MS5) J5];
JJ6 = [m6*eye(3) -skew(MS6); skew(MS6) J6];
JJ7 = [m7*eye(3) -skew(MS7); skew(MS7) J7];

syms V1_1 V1_2 V1_3 w1_1 w1_2 w1_3 real
syms V2_1 V2_2 V2_3 w2_1 w2_2 w2_3 real
syms V3_1 V3_2 V3_3 w3_1 w3_2 w3_3 real
syms V4_1 V4_2 V4_3 w4_1 w4_2 w4_3 real
syms V5_1 V5_2 V5_3 w5_1 w5_2 w5_3 real
syms V6_1 V6_2 V6_3 w6_1 w6_2 w6_3 real
syms V7_1 V7_2 V7_3 w7_1 w7_2 w7_3 real

VV1 = [V1_1 V1_2 V1_3 w1_1 w1_2 w1_3]';
VV2 = [V2_1 V2_2 V2_3 w2_1 w2_2 w2_3]';
VV3 = [V3_1 V3_2 V3_3 w3_1 w3_2 w3_3]';
VV4 = [V4_1 V4_2 V4_3 w4_1 w4_2 w4_3]';
VV5 = [V5_1 V5_2 V5_3 w5_1 w5_2 w5_3]';
VV6 = [V6_1 V6_2 V6_3 w6_1 w6_2 w6_3]';
VV7 = [V7_1 V7_2 V7_3 w7_1 w7_2 w7_3]';

eeta_times_K1 = a1'*JJ1*VV1 - 0.5*dq1*a1'*JJ1*a1;
eeta_times_K2 = a2'*JJ2*VV2 - 0.5*dq2*a2'*JJ2*a2;
eeta_times_K3 = a3'*JJ3*VV3 - 0.5*dq3*a3'*JJ3*a3;
eeta_times_K4 = a4'*JJ4*VV4 - 0.5*dq4*a4'*JJ4*a4;
eeta_times_K5 = a5'*JJ5*VV5 - 0.5*dq5*a5'*JJ5*a5;
eeta_times_K6 = a6'*JJ6*VV6 - 0.5*dq6*a6'*JJ6*a6;
eeta_times_K7 = a7'*JJ7*VV7 - 0.5*dq7*a7'*JJ7*a7;

eeta1 = findh(eeta_times_K1, JJ1);
eeta2 = findh(eeta_times_K2, JJ2);
eeta3 = findh(eeta_times_K3, JJ3);
eeta4 = findh(eeta_times_K4, JJ4);
eeta5 = findh(eeta_times_K5, JJ5);
eeta6 = findh(eeta_times_K6, JJ6);
eeta7 = findh(eeta_times_K7, JJ7);