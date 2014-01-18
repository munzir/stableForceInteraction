load PE

% dq_j * eeta_j * K_j = a_j'*JJ_j*VV_j - 0.5*dq_j*a_j'*JJ_j*a_j
skew = @(v) [0 -v(3) v(2); v(3) 0 -v(1); -v(2) v(1) 0];

a1 = [0; 0; 0; 0; 0; -1];
a2 = [0; 0; 0; -1; 0; 0];
a3 = [0; 0; 0; -1; 0; 0];

JJ1 = [m1*eye(3) -skew(MS1); skew(MS1) J1];
JJ2 = [m2*eye(3) -skew(MS2); skew(MS2) J2];
JJ3 = [m3*eye(3) -skew(MS3); skew(MS3) J3];

syms V1_1 V1_2 V1_3 w1_1 w1_2 w1_3 real
syms V2_1 V2_2 V2_3 w2_1 w2_2 w2_3 real
syms V3_1 V3_2 V3_3 w3_1 w3_2 w3_3 real

VV1 = [V1_1 V1_2 V1_3 w1_1 w1_2 w1_3]';
VV2 = [V2_1 V2_2 V2_3 w2_1 w2_2 w2_3]';
VV3 = [V3_1 V3_2 V3_3 w3_1 w3_2 w3_3]';

eeta_times_K1 = a1'*JJ1*VV1 - 0.5*dq1*a1'*JJ1*a1;
eeta_times_K2 = a2'*JJ2*VV2 - 0.5*dq2*a2'*JJ2*a2;
eeta_times_K3 = a3'*JJ3*VV3 - 0.5*dq3*a3'*JJ3*a3;

eeta1 = findh(eeta_times_K1, JJ1);
eeta2 = findh(eeta_times_K2, JJ2);
eeta3 = findh(eeta_times_K3, JJ3);