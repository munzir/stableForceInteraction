syms L R d phi dx dpsi dphi ddx ddpsi ddphi real
syms m_S m_C I_1 I_2 I_3 Iw_1 Iw_2 Iw_3 real

u_1 = dx; u_2 = dpsi; u_3 = dphi;
du_1 = ddx; du_2 = ddpsi; du_3 = ddphi;

w_S  = [0; u_2; u_3];
w_C1 = [0; u_2; -(1/R)*u_1+(L/R)*u_2];
w_C2 = [0; u_2; -(1/R)*u_1-(L/R)*u_2];

v_S  = [u_1-u_3*d*cos(phi); -u_3*d*sin(phi); u_2*d*sin(phi)];
v_C1 = [u_1-u_2*L; 0; 0];
v_C2 = [u_1+u_2*L; 0; 0];

alpha_S  = [0; du_2; du_3];
alpha_C1 = [-(1/R)*u_1*u_2+(L/R)*u_2^2; du_2; -(1/R)*du_1+(L/R)*du_2];     
alpha_C2 = [-(1/R)*u_1*u_2-(L/R)*u_2^2; du_2; -(1/R)*du_1-(L/R)*du_2];

a_S = [du_1-du_3*d*cos(phi)+(u_2^2+u_3^2)*d*sin(phi); ...
    -du_3*d*sin(phi)-u_3^2*d*cos(phi); ...
    du_2*d*sin(phi)+u_2*u_3*d*cos(phi)];
a_C1 = [du_1-L*du_2; 0;  L*u_2^2];
a_C2 = [du_1+L*du_2; 0; -L*u_2^2];

I_S = [I_1 0 0; 0 I_2 0; 0 0 I_3];
I_C1 = [Iw_1 0 0; 0 Iw_2 0; 0 0 Iw_3];
I_C2 = I_C1;

T_S = -I_S*alpha_S-cross(w_S, I_S*w_S);
T_C1 = -I_C1*alpha_C1-cross(w_C1, I_C1*w_C1);
T_C2 = -I_C2*alpha_C2-cross(w_C2, I_C2*w_C2);

R_S = -m_S*a_S;
R_C1 = -m_C*a_C1;
R_C2 = -m_C*a_C2;


F_1 = diff(w_S,  u_1)'*T_S  + diff(v_S,  u_1)'*R_S ...
    + diff(w_C1, u_1)'*T_C1 + diff(v_C1, u_1)'*R_C1 ...
    + diff(w_C2, u_1)'*T_C2 + diff(v_C2, u_1)'*R_C2;
F_2 = diff(w_S,  u_2)'*T_S  + diff(v_S,  u_2)'*R_S ...
    + diff(w_C1, u_2)'*T_C1 + diff(v_C1, u_2)'*R_C1 ...
    + diff(w_C2, u_2)'*T_C2 + diff(v_C2, u_2)'*R_C2;
F_3 = diff(w_S,  u_3)'*T_S  + diff(v_S,  u_3)'*R_S ...
    + diff(w_C1, u_3)'*T_C1 + diff(v_C1, u_3)'*R_C1 ...
    + diff(w_C2, u_3)'*T_C2 + diff(v_C2, u_3)'*R_C2;

