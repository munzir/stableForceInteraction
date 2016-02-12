syms mw YYw ZZw ddx ddpsi R L g x psii q_imu q_w q_torso q_1l q_2l q_3l q_4l q_5l q_6l q_7l real
syms q_1r q_2r q_3r q_4r q_5r q_6r q_7r L1 L2 L3 L4 L5 L6 L7 L8 L9 real
syms dx dpsi dq_imu dq_w dq_torso dq_1l dq_2l dq_3l dq_4l dq_5l dq_6l dq_7l real
syms dq_1r dq_2r dq_3r dq_4r dq_5r dq_6r dq_7r L1 L2 L3 L4 L5 L6 L7 L8 L9 real
syms ddx ddpsi ddq_imu ddq_w ddq_torso ddq_1l ddq_2l ddq_3l ddq_4l ddq_5l ddq_6l ddq_7l real
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
% \bar\omega_{1} &= {}^{1}A_{0} \bar\omega_{0} + \dot{q}_{1} \bar{e}_{1} 
% \nonumber \\ 
% \bar\omega_{1} &= \left[\begin{matrix} -dq_imu & dpsi*cos(q_imu) & dpsi*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
K1 = dpsi*cos(q_imu);
K2 = dpsi*sin(q_imu);
% \bar\omega_{1} &= \left[\begin{matrix} -dq_imu & K1 & K2 &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{1} &= \left[\begin{matrix} -dq_imu & dpsi*cos(q_imu) & dpsi*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{1} &= \left[\begin{matrix} -dq_imu & dpsi*cos(q_imu) & dpsi*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{1} &= {}^{1}A_{0} \left(\bar{v}_{0} + \bar\omega_{0} \times \bar{P}_{1}\right) 
% \nonumber \\ 
% \bar{v}_{1} &= \left[\begin{matrix} 0 & dx*sin(q_imu) & -dx*cos(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
K3 = dx*sin(q_imu);
K4 = -dx*cos(q_imu);
% \bar{v}_{1} &= \left[\begin{matrix} 0 & K3 & K4 &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{1} &= \left[\begin{matrix} 0 & dx*sin(q_imu) & -dx*cos(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{1} &= \left[\begin{matrix} 0 & dx*sin(q_imu) & -dx*cos(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{1} &= {}^{1}A_{0} \bar\alpha_{0} + \ddot{q}_{1} \bar{e}_{1} + \dot{q}_{1} \left(\bar\omega_{1} \times \bar{e}_{1}\right) 
% \nonumber \\ 
% \bar\alpha_{1} &= \left[\begin{matrix} -ddq_imu & ddpsi*cos(q_imu) - K2*dq_imu & K1*dq_imu + ddpsi*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
K5 = -K2*dq_imu;
K6 = K1*dq_imu;
% \bar\alpha_{1} &= \left[\begin{matrix} -ddq_imu & K5 + ddpsi*cos(q_imu) & K6 + ddpsi*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{1} &= {}^{1}A_{0} \left(\bar{a}_{0} + \bar\alpha_{0} \times \bar{P}_{1} + \bar\omega_{0} \times \left(\bar\omega_{0} \times \bar{P}_{1}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{1} &= \left[\begin{matrix} -dpsi & ddx*sin(q_imu) & -ddx*cos(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{1} &= \left[\begin{matrix} -dpsi & ddx*sin(q_imu) & -ddx*cos(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{1} &= {}^{1}A_{0} \bar{g}_{0} 
% \nonumber \\ 
% \bar{g}_{1} &= \left[\begin{matrix} 0 & -g*cos(q_imu) & -g*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{1} &= \left[\begin{matrix} 0 & -g*cos(q_imu) & -g*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
% m_{1}\bar{S}_{1}^{\times}\bar{g}_{1} &= \mathbf{MS}_{1} \times \bar{g}_{1} 
% \nonumber \\ 
% m_{1}\bar{S}_{1}^{\times}\bar{g}_{1} &= \left[\begin{matrix} MZ_1*g*cos(q_imu) - MY_1*g*sin(q_imu) & MX_1*g*sin(q_imu) & -MX_1*g*cos(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
D1 = MZ_1*cos(q_imu) - MY_1*sin(q_imu);
D2 = MX_1*sin(q_imu);
D3 = -MX_1*cos(q_imu);
% m_{1}\bar{S}_{1}^{\times}\bar{g}_{1} &= \left[\begin{matrix} D1*g & D2*g & D3*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{1}\bar{a}_{G(1)} &= m_{1}\bar{a}_{1} + \bar\alpha_{1} \times \mathbf{MS}_{1} + \bar\omega_{1} \times \left(\bar\omega_{1} \times \mathbf{MS}_{1}\right) 
% \nonumber \\ 
% m_{1}\bar{a}_{G(1)} &= \left[\begin{matrix} MZ_1*(K5 + ddpsi*cos(q_imu)) - K2*(MZ_1*dq_imu + K2*MX_1) - dpsi*m_1 - K1*(MY_1*dq_imu + K1*MX_1) - MY_1*(K6 + ddpsi*sin(q_imu)) & MZ_1*ddq_imu - dq_imu*(MY_1*dq_imu + K1*MX_1) - K2*(K2*MY_1 - K1*MZ_1) + MX_1*(K6 + ddpsi*sin(q_imu)) + ddx*m_1*sin(q_imu) & K1*(K2*MY_1 - K1*MZ_1) - dq_imu*(MZ_1*dq_imu + K2*MX_1) - MX_1*(K5 + ddpsi*cos(q_imu)) - MY_1*ddq_imu - ddx*m_1*cos(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
D4 = MZ_1*cos(q_imu) - MY_1*sin(q_imu);
D5 = K5*MZ_1 - K1^2*MX_1 - K2^2*MX_1 - K6*MY_1 - dpsi*m_1 - K1*MY_1*dq_imu - K2*MZ_1*dq_imu;
D6 = m_1*sin(q_imu);
D7 = MX_1*sin(q_imu);
D8 = K6*MX_1 - MY_1*dq_imu^2 - K2^2*MY_1 + K1*K2*MZ_1 - K1*MX_1*dq_imu;
D9 = -m_1*cos(q_imu);
D10 = -MX_1*cos(q_imu);
D11 = K1*K2*MY_1 - MZ_1*dq_imu^2 - K5*MX_1 - K1^2*MZ_1 - K2*MX_1*dq_imu;
% m_{1}\bar{a}_{G(1)} &= \left[\begin{matrix} D5 + D4*ddpsi & D8 + D7*ddpsi + D6*ddx + MZ_1*ddq_imu & D11 + D10*ddpsi + D9*ddx - MY_1*ddq_imu &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{1} &= \mathbf{MS}_{1} \times \bar{a}_{1} + J_{1}\bar{\alpha}_{1} + \bar\omega_{1} \times J_{1}\bar{\omega}_{1} 
% \nonumber \\ 
% \dot{\bar{H}}_{1} &= \left[\begin{matrix} XZ_1*(K6 + ddpsi*sin(q_imu)) - XX_1*ddq_imu - K2*(K1*YY_1 + K2*YZ_1 - XY_1*dq_imu) + K1*(K1*YZ_1 + K2*ZZ_1 - XZ_1*dq_imu) + XY_1*(K5 + ddpsi*cos(q_imu)) - MY_1*ddx*cos(q_imu) - MZ_1*ddx*sin(q_imu) & YZ_1*(K6 + ddpsi*sin(q_imu)) - MZ_1*dpsi - XY_1*ddq_imu + K2*(K1*XY_1 + K2*XZ_1 - XX_1*dq_imu) + dq_imu*(K1*YZ_1 + K2*ZZ_1 - XZ_1*dq_imu) + YY_1*(K5 + ddpsi*cos(q_imu)) + MX_1*ddx*cos(q_imu) & ZZ_1*(K6 + ddpsi*sin(q_imu)) + MY_1*dpsi - XZ_1*ddq_imu - K1*(K1*XY_1 + K2*XZ_1 - XX_1*dq_imu) - dq_imu*(K1*YY_1 + K2*YZ_1 - XY_1*dq_imu) + YZ_1*(K5 + ddpsi*cos(q_imu)) + MX_1*ddx*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
D12 = - MY_1*cos(q_imu) - MZ_1*sin(q_imu);
D13 = XY_1*cos(q_imu) + XZ_1*sin(q_imu);
D14 = K5*XY_1 + K6*XZ_1 + K1^2*YZ_1 - K2^2*YZ_1 - K1*K2*YY_1 + K1*K2*ZZ_1 + K2*XY_1*dq_imu - K1*XZ_1*dq_imu;
D15 = MX_1*cos(q_imu);
D16 = YY_1*cos(q_imu) + YZ_1*sin(q_imu);
D17 = K5*YY_1 + K6*YZ_1 - MZ_1*dpsi + K2^2*XZ_1 - XZ_1*dq_imu^2 + K1*K2*XY_1 - K2*XX_1*dq_imu + K1*YZ_1*dq_imu + K2*ZZ_1*dq_imu;
D18 = MX_1*sin(q_imu);
D19 = YZ_1*cos(q_imu) + ZZ_1*sin(q_imu);
D20 = K5*YZ_1 + K6*ZZ_1 + MY_1*dpsi - K1^2*XY_1 + XY_1*dq_imu^2 - K1*K2*XZ_1 + K1*XX_1*dq_imu - K1*YY_1*dq_imu - K2*YZ_1*dq_imu;
% \dot{\bar{H}}_{1} &= \left[\begin{matrix} D5 + D4*ddpsi & D8 + D7*ddpsi + D6*ddx + MZ_1*ddq_imu & D11 + D10*ddpsi + D9*ddx - MY_1*ddq_imu &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{2} &= {}^{2}A_{1} \bar\omega_{1} + \dot{q}_{2} \bar{e}_{2} 
% \nonumber \\ 
% \bar\omega_{2} &= \left[\begin{matrix} - dq_w - dq_imu & K1*cos(q_w) - K2*sin(q_w) & K2*cos(q_w) + K1*sin(q_w) &  \end{matrix}\right] 
% \nonumber \\ 
K7 = - dq_w - dq_imu;
K8 = K1*cos(q_w) - K2*sin(q_w);
K9 = K2*cos(q_w) + K1*sin(q_w);
% \bar\omega_{2} &= \left[\begin{matrix} K7 & K8 & K9 &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{2} &= \left[\begin{matrix} - dq_w - dq_imu & dpsi*cos(q_imu)*cos(q_w) - dpsi*sin(q_imu)*sin(q_w) & dpsi*cos(q_imu)*sin(q_w) + dpsi*cos(q_w)*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
K10 = cos(q_imu)*cos(q_w) - sin(q_imu)*sin(q_w);
K11 = cos(q_imu)*sin(q_w) + cos(q_w)*sin(q_imu);
% \bar\omega_{2} &= \left[\begin{matrix} - dq_w - dq_imu & K10*dpsi & K11*dpsi &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{2} &= {}^{2}A_{1} \left(\bar{v}_{1} + \bar\omega_{1} \times \bar{P}_{2}\right) 
% \nonumber \\ 
% \bar{v}_{2} &= \left[\begin{matrix} - K1*L2 - K2*L1 & cos(q_w)*(K3 - L2*dq_imu) - sin(q_w)*(K4 - L1*dq_imu) & cos(q_w)*(K4 - L1*dq_imu) + sin(q_w)*(K3 - L2*dq_imu) &  \end{matrix}\right] 
% \nonumber \\ 
K12 = - K1*L2 - K2*L1;
K13 = cos(q_w)*(K3 - L2*dq_imu) - sin(q_w)*(K4 - L1*dq_imu);
K14 = cos(q_w)*(K4 - L1*dq_imu) + sin(q_w)*(K3 - L2*dq_imu);
% \bar{v}_{2} &= \left[\begin{matrix} K12 & K13 & K14 &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{2} &= \left[\begin{matrix} - L2*dpsi*cos(q_imu) - L1*dpsi*sin(q_imu) & sin(q_w)*(L1*dq_imu + dx*cos(q_imu)) - cos(q_w)*(L2*dq_imu - dx*sin(q_imu)) & - cos(q_w)*(L1*dq_imu + dx*cos(q_imu)) - sin(q_w)*(L2*dq_imu - dx*sin(q_imu)) &  \end{matrix}\right] 
% \nonumber \\ 
K15 = - L2*cos(q_imu) - L1*sin(q_imu);
K16 = L1*sin(q_w) - L2*cos(q_w);
K17 = sin(q_imu)*sin(q_w) - cos(q_imu)*cos(q_w);
K18 = - L1*cos(q_w) - L2*sin(q_w);
% \bar{v}_{2} &= \left[\begin{matrix} K15*dpsi & K16*dq_imu + K11*dx & K18*dq_imu + K17*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{2} &= {}^{2}A_{1} \bar\alpha_{1} + \ddot{q}_{2} \bar{e}_{2} + \dot{q}_{2} \left(\bar\omega_{2} \times \bar{e}_{2}\right) 
% \nonumber \\ 
% \bar\alpha_{2} &= \left[\begin{matrix} - ddq_w - ddq_imu & cos(q_w)*(K5 + ddpsi*cos(q_imu)) - K9*dq_w - sin(q_w)*(K6 + ddpsi*sin(q_imu)) & K8*dq_w + sin(q_w)*(K5 + ddpsi*cos(q_imu)) + cos(q_w)*(K6 + ddpsi*sin(q_imu)) &  \end{matrix}\right] 
% \nonumber \\ 
K19 = K5*cos(q_w) - K9*dq_w - K6*sin(q_w);
K20 = K8*dq_w + K6*cos(q_w) + K5*sin(q_w);
% \bar\alpha_{2} &= \left[\begin{matrix} - ddq_w - ddq_imu & K19 + K10*ddpsi & K20 + K11*ddpsi &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{2} &= {}^{2}A_{1} \left(\bar{a}_{1} + \bar\alpha_{1} \times \bar{P}_{2} + \bar\omega_{1} \times \left(\bar\omega_{1} \times \bar{P}_{2}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{2} &= \left[\begin{matrix} K2*L2*dq_imu - L2*(K5 + ddpsi*cos(q_imu)) - L1*(K6 + ddpsi*sin(q_imu)) - K1*L1*dq_imu - dpsi & sin(q_w)*(L1*ddq_imu - L2*dq_imu^2 + ddx*cos(q_imu) - K1*(K1*L2 + K2*L1)) - cos(q_w)*(L2*ddq_imu + L1*dq_imu^2 - ddx*sin(q_imu) + K2*(K1*L2 + K2*L1)) & - cos(q_w)*(L1*ddq_imu - L2*dq_imu^2 + ddx*cos(q_imu) - K1*(K1*L2 + K2*L1)) - sin(q_w)*(L2*ddq_imu + L1*dq_imu^2 - ddx*sin(q_imu) + K2*(K1*L2 + K2*L1)) &  \end{matrix}\right] 
% \nonumber \\ 
K21 = K2*L2*dq_imu - K5*L2 - K6*L1 - K1*L1*dq_imu - dpsi;
K22 = - K2^2*L1*cos(q_w) - K1^2*L2*sin(q_w) - L1*dq_imu^2*cos(q_w) - L2*dq_imu^2*sin(q_w) - K1*K2*L2*cos(q_w) - K1*K2*L1*sin(q_w);
K23 = K1^2*L2*cos(q_w) - K2^2*L1*sin(q_w) + L2*dq_imu^2*cos(q_w) - L1*dq_imu^2*sin(q_w) + K1*K2*L1*cos(q_w) - K1*K2*L2*sin(q_w);
% \bar{a}_{2} &= \left[\begin{matrix} K21 + K15*ddpsi & K22 + K16*ddq_imu + K11*ddx & K23 + K18*ddq_imu + K17*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{2} &= {}^{2}A_{1} \bar{g}_{1} 
% \nonumber \\ 
% \bar{g}_{2} &= \left[\begin{matrix} 0 & g*sin(q_imu)*sin(q_w) - g*cos(q_imu)*cos(q_w) & - g*cos(q_imu)*sin(q_w) - g*cos(q_w)*sin(q_imu) &  \end{matrix}\right] 
% \nonumber \\ 
K24 = - cos(q_imu)*sin(q_w) - cos(q_w)*sin(q_imu);
% \bar{g}_{2} &= \left[\begin{matrix} 0 & K17*g & K24*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{2}\bar{S}_{2}^{\times}\bar{g}_{2} &= \mathbf{MS}_{2} \times \bar{g}_{2} 
% \nonumber \\ 
% m_{2}\bar{S}_{2}^{\times}\bar{g}_{2} &= \left[\begin{matrix} K24*MY_2*g - K17*MZ_2*g & -K24*MX_2*g & K17*MX_2*g &  \end{matrix}\right] 
% \nonumber \\ 
D21 = K24*MY_2 - K17*MZ_2;
D22 = -K24*MX_2;
D23 = K17*MX_2;
% m_{2}\bar{S}_{2}^{\times}\bar{g}_{2} &= \left[\begin{matrix} D21*g & D22*g & D23*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{2}\bar{a}_{G(2)} &= m_{2}\bar{a}_{2} + \bar\alpha_{2} \times \mathbf{MS}_{2} + \bar\omega_{2} \times \left(\bar\omega_{2} \times \mathbf{MS}_{2}\right) 
% \nonumber \\ 
% m_{2}\bar{a}_{G(2)} &= \left[\begin{matrix} MZ_2*(K19 + K10*ddpsi) - MY_2*(K20 + K11*ddpsi) + m_2*(K21 + K15*ddpsi) - K8*(K8*MX_2 - K7*MY_2) - K9*(K9*MX_2 - K7*MZ_2) & MX_2*(K20 + K11*ddpsi) + m_2*(K22 + K16*ddq_imu + K11*ddx) + MZ_2*(ddq_w + ddq_imu) + K7*(K8*MX_2 - K7*MY_2) - K9*(K9*MY_2 - K8*MZ_2) & m_2*(K23 + K18*ddq_imu + K17*ddx) - MX_2*(K19 + K10*ddpsi) - MY_2*(ddq_w + ddq_imu) + K7*(K9*MX_2 - K7*MZ_2) + K8*(K9*MY_2 - K8*MZ_2) &  \end{matrix}\right] 
% \nonumber \\ 
D24 = K15*m_2 - K11*MY_2 + K10*MZ_2;
D25 = K21*m_2 - K8^2*MX_2 - K9^2*MX_2 - K20*MY_2 + K19*MZ_2 + K7*K8*MY_2 + K7*K9*MZ_2;
D26 = K11*m_2;
D27 = K11*MX_2;
D28 = MZ_2 + K16*m_2;
D29 = K22*m_2 - K7^2*MY_2 - K9^2*MY_2 + K20*MX_2 + K7*K8*MX_2 + K8*K9*MZ_2;
D30 = K17*m_2;
D31 = -K10*MX_2;
D32 = K18*m_2 - MY_2;
D33 = K23*m_2 - K7^2*MZ_2 - K8^2*MZ_2 - K19*MX_2 + K7*K9*MX_2 + K8*K9*MY_2;
% m_{2}\bar{a}_{G(2)} &= \left[\begin{matrix} D25 + D24*ddpsi & D29 + D27*ddpsi + D28*ddq_imu + D26*ddx + MZ_2*ddq_w & D33 + D31*ddpsi + D32*ddq_imu + D30*ddx - MY_2*ddq_w &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{2} &= \mathbf{MS}_{2} \times \bar{a}_{2} + J_{2}\bar{\alpha}_{2} + \bar\omega_{2} \times J_{2}\bar{\omega}_{2} 
% \nonumber \\ 
% \dot{\bar{H}}_{2} &= \left[\begin{matrix} K8*(K7*XZ_2 + K8*YZ_2 + K9*ZZ_2) - K9*(K7*XY_2 + K8*YY_2 + K9*YZ_2) + XY_2*(K19 + K10*ddpsi) + XZ_2*(K20 + K11*ddpsi) + MY_2*(K23 + K18*ddq_imu + K17*ddx) - MZ_2*(K22 + K16*ddq_imu + K11*ddx) - XX_2*(ddq_w + ddq_imu) & K9*(K7*XX_2 + K8*XY_2 + K9*XZ_2) - K7*(K7*XZ_2 + K8*YZ_2 + K9*ZZ_2) + MZ_2*(K21 + K15*ddpsi) + YY_2*(K19 + K10*ddpsi) + YZ_2*(K20 + K11*ddpsi) - MX_2*(K23 + K18*ddq_imu + K17*ddx) - XY_2*(ddq_w + ddq_imu) & K7*(K7*XY_2 + K8*YY_2 + K9*YZ_2) - K8*(K7*XX_2 + K8*XY_2 + K9*XZ_2) - MY_2*(K21 + K15*ddpsi) + YZ_2*(K19 + K10*ddpsi) + ZZ_2*(K20 + K11*ddpsi) + MX_2*(K22 + K16*ddq_imu + K11*ddx) - XZ_2*(ddq_w + ddq_imu) &  \end{matrix}\right] 
% \nonumber \\ 
D34 = K17*MY_2 - K11*MZ_2;
D35 = K10*XY_2 + K11*XZ_2;
D36 = K18*MY_2 - XX_2 - K16*MZ_2;
D37 = K19*XY_2 + K20*XZ_2 + K8^2*YZ_2 - K9^2*YZ_2 + K23*MY_2 - K22*MZ_2 - K7*K9*XY_2 + K7*K8*XZ_2 - K8*K9*YY_2 + K8*K9*ZZ_2;
D38 = -K17*MX_2;
D39 = K10*YY_2 + K11*YZ_2 + K15*MZ_2;
D40 = - XY_2 - K18*MX_2;
D41 = K19*YY_2 + K20*YZ_2 - K7^2*XZ_2 + K9^2*XZ_2 - K23*MX_2 + K21*MZ_2 + K7*K9*XX_2 + K8*K9*XY_2 - K7*K8*YZ_2 - K7*K9*ZZ_2;
D42 = K11*MX_2;
D43 = K10*YZ_2 + K11*ZZ_2 - K15*MY_2;
D44 = K16*MX_2 - XZ_2;
D45 = K19*YZ_2 + K20*ZZ_2 + K7^2*XY_2 - K8^2*XY_2 + K22*MX_2 - K21*MY_2 - K7*K8*XX_2 - K8*K9*XZ_2 + K7*K8*YY_2 + K7*K9*YZ_2;
% \dot{\bar{H}}_{2} &= \left[\begin{matrix} D25 + D24*ddpsi & D29 + D27*ddpsi + D28*ddq_imu + D26*ddx + MZ_2*ddq_w & D33 + D31*ddpsi + D32*ddq_imu + D30*ddx - MY_2*ddq_w &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{3} &= {}^{3}A_{2} \bar\omega_{2} + \dot{q}_{3} \bar{e}_{3} 
% \nonumber \\ 
% \bar\omega_{3} &= \left[\begin{matrix} - K7*cos(q_torso) - K9*sin(q_torso) & K8 - dq_torso & K7*sin(q_torso) - K9*cos(q_torso) &  \end{matrix}\right] 
% \nonumber \\ 
K25 = - K7*cos(q_torso) - K9*sin(q_torso);
K26 = K8 - dq_torso;
K27 = K7*sin(q_torso) - K9*cos(q_torso);
% \bar\omega_{3} &= \left[\begin{matrix} K25 & K26 & K27 &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{3} &= \left[\begin{matrix} cos(q_torso)*(dq_w + dq_imu) - K11*dpsi*sin(q_torso) & K10*dpsi - dq_torso & - sin(q_torso)*(dq_w + dq_imu) - K11*dpsi*cos(q_torso) &  \end{matrix}\right] 
% \nonumber \\ 
K28 = -K11*sin(q_torso);
K29 = -K11*cos(q_torso);
% \bar\omega_{3} &= \left[\begin{matrix} K28*dpsi + dq_w*cos(q_torso) + dq_imu*cos(q_torso) & K10*dpsi - dq_torso & K29*dpsi - dq_w*sin(q_torso) - dq_imu*sin(q_torso) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{3} &= {}^{3}A_{2} \left(\bar{v}_{2} + \bar\omega_{2} \times \bar{P}_{3}\right) 
% \nonumber \\ 
% \bar{v}_{3} &= \left[\begin{matrix} - cos(q_torso)*(K12 + K8*L4 - K9*L3) - sin(q_torso)*(K14 + K7*L3) & K13 - K7*L4 & sin(q_torso)*(K12 + K8*L4 - K9*L3) - cos(q_torso)*(K14 + K7*L3) &  \end{matrix}\right] 
% \nonumber \\ 
K30 = - cos(q_torso)*(K12 + K8*L4 - K9*L3) - sin(q_torso)*(K14 + K7*L3);
K31 = K13 - K7*L4;
K32 = sin(q_torso)*(K12 + K8*L4 - K9*L3) - cos(q_torso)*(K14 + K7*L3);
% \bar{v}_{3} &= \left[\begin{matrix} K30 & K31 & K32 &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{3} &= \left[\begin{matrix} - cos(q_torso)*(K15*dpsi + K10*L4*dpsi - K11*L3*dpsi) - sin(q_torso)*(K18*dq_imu + K17*dx - L3*(dq_w + dq_imu)) & K16*dq_imu + K11*dx + L4*(dq_w + dq_imu) & sin(q_torso)*(K15*dpsi + K10*L4*dpsi - K11*L3*dpsi) - cos(q_torso)*(K18*dq_imu + K17*dx - L3*(dq_w + dq_imu)) &  \end{matrix}\right] 
% \nonumber \\ 
K33 = -K17*sin(q_torso);
K34 = -cos(q_torso)*(K15 + K10*L4 - K11*L3);
K35 = -sin(q_torso)*(K18 - L3);
K36 = L3*sin(q_torso);
K37 = K16 + L4;
K38 = -K17*cos(q_torso);
K39 = sin(q_torso)*(K15 + K10*L4 - K11*L3);
K40 = -cos(q_torso)*(K18 - L3);
K41 = L3*cos(q_torso);
% \bar{v}_{3} &= \left[\begin{matrix} K34*dpsi + K36*dq_w + K35*dq_imu + K33*dx & K37*dq_imu + K11*dx + L4*dq_w & K39*dpsi + K41*dq_w + K40*dq_imu + K38*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{3} &= {}^{3}A_{2} \bar\alpha_{2} + \ddot{q}_{3} \bar{e}_{3} + \dot{q}_{3} \left(\bar\omega_{3} \times \bar{e}_{3}\right) 
% \nonumber \\ 
% \bar\alpha_{3} &= \left[\begin{matrix} K27*dq_torso + cos(q_torso)*(ddq_w + ddq_imu) - sin(q_torso)*(K20 + K11*ddpsi) & K19 - ddq_torso + K10*ddpsi & - K25*dq_torso - sin(q_torso)*(ddq_w + ddq_imu) - cos(q_torso)*(K20 + K11*ddpsi) &  \end{matrix}\right] 
% \nonumber \\ 
K42 = K27*dq_torso - K20*sin(q_torso);
K43 = - K25*dq_torso - K20*cos(q_torso);
% \bar\alpha_{3} &= \left[\begin{matrix} K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso) & K19 - ddq_torso + K10*ddpsi & K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{3} &= {}^{3}A_{2} \left(\bar{a}_{2} + \bar\alpha_{2} \times \bar{P}_{3} + \bar\omega_{2} \times \left(\bar\omega_{2} \times \bar{P}_{3}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{3} &= \left[\begin{matrix} - sin(q_torso)*(K23 + K18*ddq_imu + K17*ddx - K7^2*L4 - L3*(ddq_w + ddq_imu) - K8*(K8*L4 - K9*L3)) - cos(q_torso)*(K21 + K15*ddpsi + L4*(K19 + K10*ddpsi) - L3*(K20 + K11*ddpsi) + K7*K8*L3 + K7*K9*L4) & K22 + K16*ddq_imu + K11*ddx - K7^2*L3 + L4*(ddq_w + ddq_imu) + K9*(K8*L4 - K9*L3) & sin(q_torso)*(K21 + K15*ddpsi + L4*(K19 + K10*ddpsi) - L3*(K20 + K11*ddpsi) + K7*K8*L3 + K7*K9*L4) - cos(q_torso)*(K23 + K18*ddq_imu + K17*ddx - K7^2*L4 - L3*(ddq_w + ddq_imu) - K8*(K8*L4 - K9*L3)) &  \end{matrix}\right] 
% \nonumber \\ 
K44 = K7^2*L4*sin(q_torso) - K23*sin(q_torso) - K21*cos(q_torso) + K8^2*L4*sin(q_torso) - K19*L4*cos(q_torso) + K20*L3*cos(q_torso) - K7*K8*L3*cos(q_torso) - K7*K9*L4*cos(q_torso) - K8*K9*L3*sin(q_torso);
K45 = K22 - K7^2*L3 - K9^2*L3 + K8*K9*L4;
K46 = K21*sin(q_torso) - K23*cos(q_torso) + K7^2*L4*cos(q_torso) + K8^2*L4*cos(q_torso) + K19*L4*sin(q_torso) - K20*L3*sin(q_torso) - K8*K9*L3*cos(q_torso) + K7*K8*L3*sin(q_torso) + K7*K9*L4*sin(q_torso);
% \bar{a}_{3} &= \left[\begin{matrix} K44 + K34*ddpsi + K36*ddq_w + K35*ddq_imu + K33*ddx & K45 + K37*ddq_imu + K11*ddx + L4*ddq_w & K46 + K39*ddpsi + K41*ddq_w + K40*ddq_imu + K38*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{3} &= {}^{3}A_{2} \bar{g}_{2} 
% \nonumber \\ 
% \bar{g}_{3} &= \left[\begin{matrix} -K24*g*sin(q_torso) & K17*g & -K24*g*cos(q_torso) &  \end{matrix}\right] 
% \nonumber \\ 
K47 = -K24*sin(q_torso);
K48 = -K24*cos(q_torso);
% \bar{g}_{3} &= \left[\begin{matrix} K47*g & K17*g & K48*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{3}\bar{S}_{3}^{\times}\bar{g}_{3} &= \mathbf{MS}_{3} \times \bar{g}_{3} 
% \nonumber \\ 
% m_{3}\bar{S}_{3}^{\times}\bar{g}_{3} &= \left[\begin{matrix} K48*MY_3*g - K17*MZ_3*g & K47*MZ_3*g - K48*MX_3*g & K17*MX_3*g - K47*MY_3*g &  \end{matrix}\right] 
% \nonumber \\ 
D46 = K48*MY_3 - K17*MZ_3;
D47 = K47*MZ_3 - K48*MX_3;
D48 = K17*MX_3 - K47*MY_3;
% m_{3}\bar{S}_{3}^{\times}\bar{g}_{3} &= \left[\begin{matrix} D46*g & D47*g & D48*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{3}\bar{a}_{G(3)} &= m_{3}\bar{a}_{3} + \bar\alpha_{3} \times \mathbf{MS}_{3} + \bar\omega_{3} \times \left(\bar\omega_{3} \times \mathbf{MS}_{3}\right) 
% \nonumber \\ 
% m_{3}\bar{a}_{G(3)} &= \left[\begin{matrix} MZ_3*(K19 - ddq_torso + K10*ddpsi) + m_3*(K44 + K34*ddpsi + K36*ddq_w + K35*ddq_imu + K33*ddx) - MY_3*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) - K26*(K26*MX_3 - K25*MY_3) - K27*(K27*MX_3 - K25*MZ_3) & m_3*(K45 + K37*ddq_imu + K11*ddx + L4*ddq_w) - MZ_3*(K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + MX_3*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) + K25*(K26*MX_3 - K25*MY_3) - K27*(K27*MY_3 - K26*MZ_3) & MY_3*(K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) - MX_3*(K19 - ddq_torso + K10*ddpsi) + m_3*(K46 + K39*ddpsi + K41*ddq_w + K40*ddq_imu + K38*ddx) + K25*(K27*MX_3 - K25*MZ_3) + K26*(K27*MY_3 - K26*MZ_3) &  \end{matrix}\right] 
% \nonumber \\ 
D49 = K33*m_3;
D50 = K34*m_3 - K29*MY_3 + K10*MZ_3;
D51 = K35*m_3 + MY_3*sin(q_torso);
D52 = K36*m_3 + MY_3*sin(q_torso);
D53 = K44*m_3 - K26^2*MX_3 - K27^2*MX_3 - K43*MY_3 + K19*MZ_3 + K25*K26*MY_3 + K25*K27*MZ_3;
D54 = K11*m_3;
D55 = K29*MX_3 - K28*MZ_3;
D56 = K37*m_3 - MZ_3*cos(q_torso) - MX_3*sin(q_torso);
D57 = L4*m_3 - MZ_3*cos(q_torso) - MX_3*sin(q_torso);
D58 = K45*m_3 - K25^2*MY_3 - K27^2*MY_3 + K43*MX_3 - K42*MZ_3 + K25*K26*MX_3 + K26*K27*MZ_3;
D59 = K38*m_3;
D60 = K39*m_3 - K10*MX_3 + K28*MY_3;
D61 = K40*m_3 + MY_3*cos(q_torso);
D62 = K41*m_3 + MY_3*cos(q_torso);
D63 = K46*m_3 - K25^2*MZ_3 - K26^2*MZ_3 - K19*MX_3 + K42*MY_3 + K25*K27*MX_3 + K26*K27*MY_3;
% m_{3}\bar{a}_{G(3)} &= \left[\begin{matrix} D53 + D50*ddpsi + D52*ddq_w + D51*ddq_imu + D49*ddx - MZ_3*ddq_torso & D58 + D55*ddpsi + D57*ddq_w + D56*ddq_imu + D54*ddx & D63 + D60*ddpsi + D62*ddq_w + D61*ddq_imu + D59*ddx + MX_3*ddq_torso &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{3} &= \mathbf{MS}_{3} \times \bar{a}_{3} + J_{3}\bar{\alpha}_{3} + \bar\omega_{3} \times J_{3}\bar{\omega}_{3} 
% \nonumber \\ 
% \dot{\bar{H}}_{3} &= \left[\begin{matrix} K26*(K25*XZ_3 + K26*YZ_3 + K27*ZZ_3) - K27*(K25*XY_3 + K26*YY_3 + K27*YZ_3) + XY_3*(K19 - ddq_torso + K10*ddpsi) - MZ_3*(K45 + K37*ddq_imu + K11*ddx + L4*ddq_w) + MY_3*(K46 + K39*ddpsi + K41*ddq_w + K40*ddq_imu + K38*ddx) + XX_3*(K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + XZ_3*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) & K27*(K25*XX_3 + K26*XY_3 + K27*XZ_3) - K25*(K25*XZ_3 + K26*YZ_3 + K27*ZZ_3) + YY_3*(K19 - ddq_torso + K10*ddpsi) - MX_3*(K46 + K39*ddpsi + K41*ddq_w + K40*ddq_imu + K38*ddx) + MZ_3*(K44 + K34*ddpsi + K36*ddq_w + K35*ddq_imu + K33*ddx) + XY_3*(K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + YZ_3*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) & K25*(K25*XY_3 + K26*YY_3 + K27*YZ_3) - K26*(K25*XX_3 + K26*XY_3 + K27*XZ_3) + YZ_3*(K19 - ddq_torso + K10*ddpsi) + MX_3*(K45 + K37*ddq_imu + K11*ddx + L4*ddq_w) - MY_3*(K44 + K34*ddpsi + K36*ddq_w + K35*ddq_imu + K33*ddx) + XZ_3*(K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + ZZ_3*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) &  \end{matrix}\right] 
% \nonumber \\ 
D64 = K38*MY_3 - K11*MZ_3;
D65 = K28*XX_3 + K10*XY_3 + K29*XZ_3 + K39*MY_3;
D66 = XX_3*cos(q_torso) - XZ_3*sin(q_torso) + K40*MY_3 - K37*MZ_3;
D67 = XX_3*cos(q_torso) - XZ_3*sin(q_torso) + K41*MY_3 - L4*MZ_3;
D68 = K42*XX_3 + K19*XY_3 + K43*XZ_3 + K26^2*YZ_3 - K27^2*YZ_3 + K46*MY_3 - K45*MZ_3 - K25*K27*XY_3 + K25*K26*XZ_3 - K26*K27*YY_3 + K26*K27*ZZ_3;
D69 = K33*MZ_3 - K38*MX_3;
D70 = K28*XY_3 + K10*YY_3 + K29*YZ_3 - K39*MX_3 + K34*MZ_3;
D71 = XY_3*cos(q_torso) - YZ_3*sin(q_torso) - K40*MX_3 + K35*MZ_3;
D72 = XY_3*cos(q_torso) - YZ_3*sin(q_torso) - K41*MX_3 + K36*MZ_3;
D73 = K42*XY_3 + K19*YY_3 + K43*YZ_3 - K25^2*XZ_3 + K27^2*XZ_3 - K46*MX_3 + K44*MZ_3 + K25*K27*XX_3 + K26*K27*XY_3 - K25*K26*YZ_3 - K25*K27*ZZ_3;
D74 = K11*MX_3 - K33*MY_3;
D75 = K28*XZ_3 + K10*YZ_3 + K29*ZZ_3 - K34*MY_3;
D76 = XZ_3*cos(q_torso) - ZZ_3*sin(q_torso) + K37*MX_3 - K35*MY_3;
D77 = XZ_3*cos(q_torso) - ZZ_3*sin(q_torso) - K36*MY_3 + L4*MX_3;
D78 = K42*XZ_3 + K19*YZ_3 + K43*ZZ_3 + K25^2*XY_3 - K26^2*XY_3 + K45*MX_3 - K44*MY_3 - K25*K26*XX_3 - K26*K27*XZ_3 + K25*K26*YY_3 + K25*K27*YZ_3;
% \dot{\bar{H}}_{3} &= \left[\begin{matrix} D53 + D50*ddpsi + D52*ddq_w + D51*ddq_imu + D49*ddx - MZ_3*ddq_torso & D58 + D55*ddpsi + D57*ddq_w + D56*ddq_imu + D54*ddx & D63 + D60*ddpsi + D62*ddq_w + D61*ddq_imu + D59*ddx + MX_3*ddq_torso &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{4l} &= {}^{4l}A_{3} \bar\omega_{3} + \dot{q}_{4l} \bar{e}_{4l} 
% \nonumber \\ 
% \bar\omega_{4l} &= \left[\begin{matrix} K26*cos(q_1l) - K27*sin(q_1l) & K25 - dq_1l & - K27*cos(q_1l) - K26*sin(q_1l) &  \end{matrix}\right] 
% \nonumber \\ 
K1l = K26*cos(q_1l) - K27*sin(q_1l);
K2l = K25 - dq_1l;
K3l = - K27*cos(q_1l) - K26*sin(q_1l);
% \bar\omega_{4l} &= \left[\begin{matrix} K1l & K2l & K3l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{4l} &= \left[\begin{matrix} sin(q_1l)*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso)) - cos(q_1l)*(dq_torso - K10*dpsi) & K28*dpsi - dq_1l + dq_w*cos(q_torso) + dq_imu*cos(q_torso) & sin(q_1l)*(dq_torso - K10*dpsi) + cos(q_1l)*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso)) &  \end{matrix}\right] 
% \nonumber \\ 
K4l = K10*cos(q_1l) - K29*sin(q_1l);
K5l = sin(q_1l)*sin(q_torso);
K6l = - K29*cos(q_1l) - K10*sin(q_1l);
K7l = cos(q_1l)*sin(q_torso);
% \bar\omega_{4l} &= \left[\begin{matrix} K4l*dpsi + K5l*dq_w + K5l*dq_imu - dq_torso*cos(q_1l) & K28*dpsi - dq_1l + dq_w*cos(q_torso) + dq_imu*cos(q_torso) & K6l*dpsi + K7l*dq_w + K7l*dq_imu + dq_torso*sin(q_1l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{4l} &= {}^{4l}A_{3} \left(\bar{v}_{3} + \bar\omega_{3} \times \bar{P}_{4l}\right) 
% \nonumber \\ 
% \bar{v}_{4l} &= \left[\begin{matrix} cos(q_1l)*(K31 + K27*L6) - sin(q_1l)*(K32 + K25*L5 - K26*L6) & K30 - K27*L5 & - cos(q_1l)*(K32 + K25*L5 - K26*L6) - sin(q_1l)*(K31 + K27*L6) &  \end{matrix}\right] 
% \nonumber \\ 
K8l = cos(q_1l)*(K31 + K27*L6) - sin(q_1l)*(K32 + K25*L5 - K26*L6);
K9l = K30 - K27*L5;
K10l = - cos(q_1l)*(K32 + K25*L5 - K26*L6) - sin(q_1l)*(K31 + K27*L6);
% \bar{v}_{4l} &= \left[\begin{matrix} K8l & K9l & K10l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{4l} &= \left[\begin{matrix} cos(q_1l)*(K37*dq_imu + K11*dx + L4*dq_w - L6*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso))) - sin(q_1l)*(K39*dpsi + K41*dq_w + K40*dq_imu + K38*dx + L5*(K28*dpsi + dq_w*cos(q_torso) + dq_imu*cos(q_torso)) + L6*(dq_torso - K10*dpsi)) & K34*dpsi + K36*dq_w + K35*dq_imu + K33*dx + L5*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso)) & - sin(q_1l)*(K37*dq_imu + K11*dx + L4*dq_w - L6*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso))) - cos(q_1l)*(K39*dpsi + K41*dq_w + K40*dq_imu + K38*dx + L5*(K28*dpsi + dq_w*cos(q_torso) + dq_imu*cos(q_torso)) + L6*(dq_torso - K10*dpsi)) &  \end{matrix}\right] 
% \nonumber \\ 
K11l = K11*cos(q_1l) - K38*sin(q_1l);
K12l = K29*L6*cos(q_1l) - sin(q_1l)*(K39 - K10*L6 + K28*L5);
K13l = cos(q_1l)*(K37 - L6*sin(q_torso)) - sin(q_1l)*(K40 + L5*cos(q_torso));
K14l = cos(q_1l)*(L4 - L6*sin(q_torso)) - sin(q_1l)*(K41 + L5*cos(q_torso));
K15l = -L6*sin(q_1l);
K16l = K34 - K29*L5;
K17l = K35 + L5*sin(q_torso);
K18l = K36 + L5*sin(q_torso);
K19l = - K38*cos(q_1l) - K11*sin(q_1l);
K20l = - cos(q_1l)*(K39 - K10*L6 + K28*L5) - K29*L6*sin(q_1l);
K21l = - cos(q_1l)*(K40 + L5*cos(q_torso)) - sin(q_1l)*(K37 - L6*sin(q_torso));
K22l = - cos(q_1l)*(K41 + L5*cos(q_torso)) - sin(q_1l)*(L4 - L6*sin(q_torso));
K23l = -L6*cos(q_1l);
% \bar{v}_{4l} &= \left[\begin{matrix} K12l*dpsi + K14l*dq_w + K13l*dq_imu + K15l*dq_torso + K11l*dx & K16l*dpsi + K18l*dq_w + K17l*dq_imu + K33*dx & K20l*dpsi + K22l*dq_w + K21l*dq_imu + K23l*dq_torso + K19l*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{4l} &= {}^{4l}A_{3} \bar\alpha_{3} + \ddot{q}_{4l} \bar{e}_{4l} + \dot{q}_{4l} \left(\bar\omega_{4l} \times \bar{e}_{4l}\right) 
% \nonumber \\ 
% \bar\alpha_{4l} &= \left[\begin{matrix} K3l*dq_1l - sin(q_1l)*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) + cos(q_1l)*(K19 - ddq_torso + K10*ddpsi) & K42 - ddq_1l + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso) & - K1l*dq_1l - cos(q_1l)*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) - sin(q_1l)*(K19 - ddq_torso + K10*ddpsi) &  \end{matrix}\right] 
% \nonumber \\ 
K24l = K3l*dq_1l + K19*cos(q_1l) - K43*sin(q_1l);
K25l = - K1l*dq_1l - K43*cos(q_1l) - K19*sin(q_1l);
% \bar\alpha_{4l} &= \left[\begin{matrix} K24l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l) & K42 - ddq_1l + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso) & K25l + K6l*ddpsi + K7l*ddq_w + K7l*ddq_imu + ddq_torso*sin(q_1l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{4l} &= {}^{4l}A_{3} \left(\bar{a}_{3} + \bar\alpha_{3} \times \bar{P}_{4l} + \bar\omega_{3} \times \left(\bar\omega_{3} \times \bar{P}_{4l}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{4l} &= \left[\begin{matrix} cos(q_1l)*(K45 + K37*ddq_imu + K11*ddx + L4*ddq_w - K27^2*L5 + L6*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) - K25*(K25*L5 - K26*L6)) - sin(q_1l)*(K46 + K39*ddpsi + K41*ddq_w + K40*ddq_imu + K38*ddx - L6*(K19 - ddq_torso + K10*ddpsi) + L5*(K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + K25*K27*L6 + K26*K27*L5) & K44 + K34*ddpsi + K36*ddq_w + K35*ddq_imu + K33*ddx - K27^2*L6 - L5*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) + K26*(K25*L5 - K26*L6) & - sin(q_1l)*(K45 + K37*ddq_imu + K11*ddx + L4*ddq_w - K27^2*L5 + L6*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) - K25*(K25*L5 - K26*L6)) - cos(q_1l)*(K46 + K39*ddpsi + K41*ddq_w + K40*ddq_imu + K38*ddx - L6*(K19 - ddq_torso + K10*ddpsi) + L5*(K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + K25*K27*L6 + K26*K27*L5) &  \end{matrix}\right] 
% \nonumber \\ 
K26l = K45*cos(q_1l) - K46*sin(q_1l) - K25^2*L5*cos(q_1l) - K27^2*L5*cos(q_1l) + K43*L6*cos(q_1l) + K19*L6*sin(q_1l) - K42*L5*sin(q_1l) + K25*K26*L6*cos(q_1l) - K25*K27*L6*sin(q_1l) - K26*K27*L5*sin(q_1l);
K27l = K44 - K26^2*L6 - K27^2*L6 - K43*L5 + K25*K26*L5;
K28l = K25^2*L5*sin(q_1l) - K45*sin(q_1l) - K46*cos(q_1l) + K27^2*L5*sin(q_1l) + K19*L6*cos(q_1l) - K42*L5*cos(q_1l) - K43*L6*sin(q_1l) - K25*K27*L6*cos(q_1l) - K26*K27*L5*cos(q_1l) - K25*K26*L6*sin(q_1l);
% \bar{a}_{4l} &= \left[\begin{matrix} K26l + K12l*ddpsi + K14l*ddq_w + K13l*ddq_imu + K15l*ddq_torso + K11l*ddx & K27l + K16l*ddpsi + K18l*ddq_w + K17l*ddq_imu + K33*ddx & K28l + K20l*ddpsi + K22l*ddq_w + K21l*ddq_imu + K23l*ddq_torso + K19l*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{4l} &= {}^{4l}A_{3} \bar{g}_{3} 
% \nonumber \\ 
% \bar{g}_{4l} &= \left[\begin{matrix} K17*g*cos(q_1l) - K48*g*sin(q_1l) & K47*g & - K48*g*cos(q_1l) - K17*g*sin(q_1l) &  \end{matrix}\right] 
% \nonumber \\ 
K29l = K17*cos(q_1l) - K48*sin(q_1l);
K30l = - K48*cos(q_1l) - K17*sin(q_1l);
% \bar{g}_{4l} &= \left[\begin{matrix} K29l*g & K47*g & K30l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{4l}\bar{S}_{4l}^{\times}\bar{g}_{4l} &= \mathbf{MS}_{4l} \times \bar{g}_{4l} 
% \nonumber \\ 
% m_{4l}\bar{S}_{4l}^{\times}\bar{g}_{4l} &= \left[\begin{matrix} K30l*MY_4l*g - K47*MZ_4l*g & K29l*MZ_4l*g - K30l*MX_4l*g & K47*MX_4l*g - K29l*MY_4l*g &  \end{matrix}\right] 
% \nonumber \\ 
D1l = K30l*MY_4l - K47*MZ_4l;
D2l = K29l*MZ_4l - K30l*MX_4l;
D3l = K47*MX_4l - K29l*MY_4l;
% m_{4l}\bar{S}_{4l}^{\times}\bar{g}_{4l} &= \left[\begin{matrix} D1l*g & D2l*g & D3l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{4l}\bar{a}_{G(4l)} &= m_{4l}\bar{a}_{4l} + \bar\alpha_{4l} \times \mathbf{MS}_{4l} + \bar\omega_{4l} \times \left(\bar\omega_{4l} \times \mathbf{MS}_{4l}\right) 
% \nonumber \\ 
% m_{4l}\bar{a}_{G(4l)} &= \left[\begin{matrix} MZ_4l*(K42 - ddq_1l + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) - MY_4l*(K25l + K6l*ddpsi + K7l*ddq_w + K7l*ddq_imu + ddq_torso*sin(q_1l)) + m_4l*(K26l + K12l*ddpsi + K14l*ddq_w + K13l*ddq_imu + K15l*ddq_torso + K11l*ddx) - K2l*(K2l*MX_4l - K1l*MY_4l) - K3l*(K3l*MX_4l - K1l*MZ_4l) & MX_4l*(K25l + K6l*ddpsi + K7l*ddq_w + K7l*ddq_imu + ddq_torso*sin(q_1l)) - MZ_4l*(K24l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) + m_4l*(K27l + K16l*ddpsi + K18l*ddq_w + K17l*ddq_imu + K33*ddx) + K1l*(K2l*MX_4l - K1l*MY_4l) - K3l*(K3l*MY_4l - K2l*MZ_4l) & MY_4l*(K24l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) - MX_4l*(K42 - ddq_1l + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + m_4l*(K28l + K20l*ddpsi + K22l*ddq_w + K21l*ddq_imu + K23l*ddq_torso + K19l*ddx) + K1l*(K3l*MX_4l - K1l*MZ_4l) + K2l*(K3l*MY_4l - K2l*MZ_4l) &  \end{matrix}\right] 
% \nonumber \\ 
D4l = K11l*m_4l;
D5l = K12l*m_4l - K6l*MY_4l + K28*MZ_4l;
D6l = K13l*m_4l + MZ_4l*cos(q_torso) - K7l*MY_4l;
D7l = K14l*m_4l + MZ_4l*cos(q_torso) - K7l*MY_4l;
D8l = K15l*m_4l - MY_4l*sin(q_1l);
D9l = K26l*m_4l - K2l^2*MX_4l - K3l^2*MX_4l - K25l*MY_4l + K42*MZ_4l + K1l*K2l*MY_4l + K1l*K3l*MZ_4l;
D10l = K33*m_4l;
D11l = K16l*m_4l + K6l*MX_4l - K4l*MZ_4l;
D12l = K17l*m_4l + K7l*MX_4l - K5l*MZ_4l;
D13l = K18l*m_4l + K7l*MX_4l - K5l*MZ_4l;
D14l = MZ_4l*cos(q_1l) + MX_4l*sin(q_1l);
D15l = K27l*m_4l - K1l^2*MY_4l - K3l^2*MY_4l + K25l*MX_4l - K24l*MZ_4l + K1l*K2l*MX_4l + K2l*K3l*MZ_4l;
D16l = K19l*m_4l;
D17l = K20l*m_4l - K28*MX_4l + K4l*MY_4l;
D18l = K21l*m_4l - MX_4l*cos(q_torso) + K5l*MY_4l;
D19l = K22l*m_4l - MX_4l*cos(q_torso) + K5l*MY_4l;
D20l = K23l*m_4l - MY_4l*cos(q_1l);
D21l = K28l*m_4l - K1l^2*MZ_4l - K2l^2*MZ_4l - K42*MX_4l + K24l*MY_4l + K1l*K3l*MX_4l + K2l*K3l*MY_4l;
% m_{4l}\bar{a}_{G(4l)} &= \left[\begin{matrix} D9l + D5l*ddpsi + D7l*ddq_w + D6l*ddq_imu + D8l*ddq_torso + D4l*ddx - MZ_4l*ddq_1l & D15l + D11l*ddpsi + D13l*ddq_w + D12l*ddq_imu + D14l*ddq_torso + D10l*ddx & D21l + D17l*ddpsi + D19l*ddq_w + D18l*ddq_imu + D20l*ddq_torso + D16l*ddx + MX_4l*ddq_1l &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{4l} &= \mathbf{MS}_{4l} \times \bar{a}_{4l} + J_{4l}\bar{\alpha}_{4l} + \bar\omega_{4l} \times J_{4l}\bar{\omega}_{4l} 
% \nonumber \\ 
% \dot{\bar{H}}_{4l} &= \left[\begin{matrix} K2l*(K1l*XZ_4l + K2l*YZ_4l + K3l*ZZ_4l) - K3l*(K1l*XY_4l + K2l*YY_4l + K3l*YZ_4l) + XX_4l*(K24l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) + XZ_4l*(K25l + K6l*ddpsi + K7l*ddq_w + K7l*ddq_imu + ddq_torso*sin(q_1l)) + XY_4l*(K42 - ddq_1l + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) - MZ_4l*(K27l + K16l*ddpsi + K18l*ddq_w + K17l*ddq_imu + K33*ddx) + MY_4l*(K28l + K20l*ddpsi + K22l*ddq_w + K21l*ddq_imu + K23l*ddq_torso + K19l*ddx) & K3l*(K1l*XX_4l + K2l*XY_4l + K3l*XZ_4l) - K1l*(K1l*XZ_4l + K2l*YZ_4l + K3l*ZZ_4l) + XY_4l*(K24l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) + YZ_4l*(K25l + K6l*ddpsi + K7l*ddq_w + K7l*ddq_imu + ddq_torso*sin(q_1l)) + YY_4l*(K42 - ddq_1l + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) - MX_4l*(K28l + K20l*ddpsi + K22l*ddq_w + K21l*ddq_imu + K23l*ddq_torso + K19l*ddx) + MZ_4l*(K26l + K12l*ddpsi + K14l*ddq_w + K13l*ddq_imu + K15l*ddq_torso + K11l*ddx) & K1l*(K1l*XY_4l + K2l*YY_4l + K3l*YZ_4l) - K2l*(K1l*XX_4l + K2l*XY_4l + K3l*XZ_4l) + XZ_4l*(K24l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) + ZZ_4l*(K25l + K6l*ddpsi + K7l*ddq_w + K7l*ddq_imu + ddq_torso*sin(q_1l)) + YZ_4l*(K42 - ddq_1l + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + MX_4l*(K27l + K16l*ddpsi + K18l*ddq_w + K17l*ddq_imu + K33*ddx) - MY_4l*(K26l + K12l*ddpsi + K14l*ddq_w + K13l*ddq_imu + K15l*ddq_torso + K11l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D22l = K19l*MY_4l - K33*MZ_4l;
D23l = K4l*XX_4l + K28*XY_4l + K6l*XZ_4l + K20l*MY_4l - K16l*MZ_4l;
D24l = K5l*XX_4l + K7l*XZ_4l + XY_4l*cos(q_torso) + K21l*MY_4l - K17l*MZ_4l;
D25l = K5l*XX_4l + K7l*XZ_4l + XY_4l*cos(q_torso) + K22l*MY_4l - K18l*MZ_4l;
D26l = XZ_4l*sin(q_1l) - XX_4l*cos(q_1l) + K23l*MY_4l;
D27l = K24l*XX_4l + K42*XY_4l + K25l*XZ_4l + K2l^2*YZ_4l - K3l^2*YZ_4l + K28l*MY_4l - K27l*MZ_4l - K1l*K3l*XY_4l + K1l*K2l*XZ_4l - K2l*K3l*YY_4l + K2l*K3l*ZZ_4l;
D28l = K11l*MZ_4l - K19l*MX_4l;
D29l = K4l*XY_4l + K28*YY_4l + K6l*YZ_4l - K20l*MX_4l + K12l*MZ_4l;
D30l = K5l*XY_4l + K7l*YZ_4l + YY_4l*cos(q_torso) - K21l*MX_4l + K13l*MZ_4l;
D31l = K5l*XY_4l + K7l*YZ_4l + YY_4l*cos(q_torso) - K22l*MX_4l + K14l*MZ_4l;
D32l = YZ_4l*sin(q_1l) - XY_4l*cos(q_1l) - K23l*MX_4l + K15l*MZ_4l;
D33l = K24l*XY_4l + K42*YY_4l + K25l*YZ_4l - K1l^2*XZ_4l + K3l^2*XZ_4l - K28l*MX_4l + K26l*MZ_4l + K1l*K3l*XX_4l + K2l*K3l*XY_4l - K1l*K2l*YZ_4l - K1l*K3l*ZZ_4l;
D34l = K33*MX_4l - K11l*MY_4l;
D35l = K4l*XZ_4l + K28*YZ_4l + K6l*ZZ_4l + K16l*MX_4l - K12l*MY_4l;
D36l = K5l*XZ_4l + K7l*ZZ_4l + YZ_4l*cos(q_torso) + K17l*MX_4l - K13l*MY_4l;
D37l = K5l*XZ_4l + K7l*ZZ_4l + YZ_4l*cos(q_torso) + K18l*MX_4l - K14l*MY_4l;
D38l = ZZ_4l*sin(q_1l) - XZ_4l*cos(q_1l) - K15l*MY_4l;
D39l = K24l*XZ_4l + K42*YZ_4l + K25l*ZZ_4l + K1l^2*XY_4l - K2l^2*XY_4l + K27l*MX_4l - K26l*MY_4l - K1l*K2l*XX_4l - K2l*K3l*XZ_4l + K1l*K2l*YY_4l + K1l*K3l*YZ_4l;
% \dot{\bar{H}}_{4l} &= \left[\begin{matrix} D9l + D5l*ddpsi + D7l*ddq_w + D6l*ddq_imu + D8l*ddq_torso + D4l*ddx - MZ_4l*ddq_1l & D15l + D11l*ddpsi + D13l*ddq_w + D12l*ddq_imu + D14l*ddq_torso + D10l*ddx & D21l + D17l*ddpsi + D19l*ddq_w + D18l*ddq_imu + D20l*ddq_torso + D16l*ddx + MX_4l*ddq_1l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{5l} &= {}^{5l}A_{4l} \bar\omega_{4l} + \dot{q}_{5l} \bar{e}_{5l} 
% \nonumber \\ 
% \bar\omega_{5l} &= \left[\begin{matrix} - K1l - dq_2l & - K2l*cos(q_2l) - K3l*sin(q_2l) & K3l*cos(q_2l) - K2l*sin(q_2l) &  \end{matrix}\right] 
% \nonumber \\ 
K31l = - K1l - dq_2l;
K32l = - K2l*cos(q_2l) - K3l*sin(q_2l);
K33l = K3l*cos(q_2l) - K2l*sin(q_2l);
% \bar\omega_{5l} &= \left[\begin{matrix} K31l & K32l & K33l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{5l} &= \left[\begin{matrix} dq_torso*cos(q_1l) - K4l*dpsi - K5l*dq_w - K5l*dq_imu - dq_2l & - sin(q_2l)*(K6l*dpsi + K7l*dq_w + K7l*dq_imu + dq_torso*sin(q_1l)) - cos(q_2l)*(K28*dpsi - dq_1l + dq_w*cos(q_torso) + dq_imu*cos(q_torso)) & cos(q_2l)*(K6l*dpsi + K7l*dq_w + K7l*dq_imu + dq_torso*sin(q_1l)) - sin(q_2l)*(K28*dpsi - dq_1l + dq_w*cos(q_torso) + dq_imu*cos(q_torso)) &  \end{matrix}\right] 
% \nonumber \\ 
K34l = - K28*cos(q_2l) - K6l*sin(q_2l);
K35l = - cos(q_2l)*cos(q_torso) - K7l*sin(q_2l);
K36l = -sin(q_1l)*sin(q_2l);
K37l = K6l*cos(q_2l) - K28*sin(q_2l);
K38l = K7l*cos(q_2l) - cos(q_torso)*sin(q_2l);
K39l = cos(q_2l)*sin(q_1l);
% \bar\omega_{5l} &= \left[\begin{matrix} dq_torso*cos(q_1l) - K4l*dpsi - K5l*dq_w - K5l*dq_imu - dq_2l & K34l*dpsi + K35l*dq_w + K35l*dq_imu + K36l*dq_torso + dq_1l*cos(q_2l) & K37l*dpsi + K38l*dq_w + K38l*dq_imu + K39l*dq_torso + dq_1l*sin(q_2l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{5l} &= {}^{5l}A_{4l} \left(\bar{v}_{4l} + \bar\omega_{4l} \times \bar{P}_{5l}\right) 
% \nonumber \\ 
% \bar{v}_{5l} &= \left[\begin{matrix} -K8l & - K9l*cos(q_2l) - K10l*sin(q_2l) & K10l*cos(q_2l) - K9l*sin(q_2l) &  \end{matrix}\right] 
% \nonumber \\ 
K40l = - K9l*cos(q_2l) - K10l*sin(q_2l);
K41l = K10l*cos(q_2l) - K9l*sin(q_2l);
% \bar{v}_{5l} &= \left[\begin{matrix} -K8l & K40l & K41l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{5l} &= \left[\begin{matrix} - K12l*dpsi - K14l*dq_w - K13l*dq_imu - K15l*dq_torso - K11l*dx & - cos(q_2l)*(K16l*dpsi + K18l*dq_w + K17l*dq_imu + K33*dx) - sin(q_2l)*(K20l*dpsi + K22l*dq_w + K21l*dq_imu + K23l*dq_torso + K19l*dx) & cos(q_2l)*(K20l*dpsi + K22l*dq_w + K21l*dq_imu + K23l*dq_torso + K19l*dx) - sin(q_2l)*(K16l*dpsi + K18l*dq_w + K17l*dq_imu + K33*dx) &  \end{matrix}\right] 
% \nonumber \\ 
K42l = - K33*cos(q_2l) - K19l*sin(q_2l);
K43l = - K16l*cos(q_2l) - K20l*sin(q_2l);
K44l = - K17l*cos(q_2l) - K21l*sin(q_2l);
K45l = - K18l*cos(q_2l) - K22l*sin(q_2l);
K46l = -K23l*sin(q_2l);
K47l = K19l*cos(q_2l) - K33*sin(q_2l);
K48l = K20l*cos(q_2l) - K16l*sin(q_2l);
K49l = K21l*cos(q_2l) - K17l*sin(q_2l);
K50l = K22l*cos(q_2l) - K18l*sin(q_2l);
K51l = K23l*cos(q_2l);
% \bar{v}_{5l} &= \left[\begin{matrix} - K12l*dpsi - K14l*dq_w - K13l*dq_imu - K15l*dq_torso - K11l*dx & K43l*dpsi + K45l*dq_w + K44l*dq_imu + K46l*dq_torso + K42l*dx & K48l*dpsi + K50l*dq_w + K49l*dq_imu + K51l*dq_torso + K47l*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{5l} &= {}^{5l}A_{4l} \bar\alpha_{4l} + \ddot{q}_{5l} \bar{e}_{5l} + \dot{q}_{5l} \left(\bar\omega_{5l} \times \bar{e}_{5l}\right) 
% \nonumber \\ 
% \bar\alpha_{5l} &= \left[\begin{matrix} ddq_torso*cos(q_1l) - ddq_2l - K4l*ddpsi - K5l*ddq_w - K5l*ddq_imu - K24l & - K33l*dq_2l - sin(q_2l)*(K25l + K6l*ddpsi + K7l*ddq_w + K7l*ddq_imu + ddq_torso*sin(q_1l)) - cos(q_2l)*(K42 - ddq_1l + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) & K32l*dq_2l + cos(q_2l)*(K25l + K6l*ddpsi + K7l*ddq_w + K7l*ddq_imu + ddq_torso*sin(q_1l)) - sin(q_2l)*(K42 - ddq_1l + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) &  \end{matrix}\right] 
% \nonumber \\ 
K52l = - K33l*dq_2l - K42*cos(q_2l) - K25l*sin(q_2l);
K53l = K32l*dq_2l + K25l*cos(q_2l) - K42*sin(q_2l);
% \bar\alpha_{5l} &= \left[\begin{matrix} ddq_torso*cos(q_1l) - ddq_2l - K4l*ddpsi - K5l*ddq_w - K5l*ddq_imu - K24l & K52l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l) & K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{5l} &= {}^{5l}A_{4l} \left(\bar{a}_{4l} + \bar\alpha_{4l} \times \bar{P}_{5l} + \bar\omega_{4l} \times \left(\bar\omega_{4l} \times \bar{P}_{5l}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{5l} &= \left[\begin{matrix} - K26l - K12l*ddpsi - K14l*ddq_w - K13l*ddq_imu - K15l*ddq_torso - K11l*ddx & - cos(q_2l)*(K27l + K16l*ddpsi + K18l*ddq_w + K17l*ddq_imu + K33*ddx) - sin(q_2l)*(K28l + K20l*ddpsi + K22l*ddq_w + K21l*ddq_imu + K23l*ddq_torso + K19l*ddx) & cos(q_2l)*(K28l + K20l*ddpsi + K22l*ddq_w + K21l*ddq_imu + K23l*ddq_torso + K19l*ddx) - sin(q_2l)*(K27l + K16l*ddpsi + K18l*ddq_w + K17l*ddq_imu + K33*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
K54l = - K27l*cos(q_2l) - K28l*sin(q_2l);
K55l = K28l*cos(q_2l) - K27l*sin(q_2l);
% \bar{a}_{5l} &= \left[\begin{matrix} - K26l - K12l*ddpsi - K14l*ddq_w - K13l*ddq_imu - K15l*ddq_torso - K11l*ddx & K54l + K43l*ddpsi + K45l*ddq_w + K44l*ddq_imu + K46l*ddq_torso + K42l*ddx & K55l + K48l*ddpsi + K50l*ddq_w + K49l*ddq_imu + K51l*ddq_torso + K47l*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{5l} &= {}^{5l}A_{4l} \bar{g}_{4l} 
% \nonumber \\ 
% \bar{g}_{5l} &= \left[\begin{matrix} -K29l*g & - K47*g*cos(q_2l) - K30l*g*sin(q_2l) & K30l*g*cos(q_2l) - K47*g*sin(q_2l) &  \end{matrix}\right] 
% \nonumber \\ 
K56l = - K47*cos(q_2l) - K30l*sin(q_2l);
K57l = K30l*cos(q_2l) - K47*sin(q_2l);
% \bar{g}_{5l} &= \left[\begin{matrix} -K29l*g & K56l*g & K57l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{5l}\bar{S}_{5l}^{\times}\bar{g}_{5l} &= \mathbf{MS}_{5l} \times \bar{g}_{5l} 
% \nonumber \\ 
% m_{5l}\bar{S}_{5l}^{\times}\bar{g}_{5l} &= \left[\begin{matrix} K57l*MY_5l*g - K56l*MZ_5l*g & - K57l*MX_5l*g - K29l*MZ_5l*g & K56l*MX_5l*g + K29l*MY_5l*g &  \end{matrix}\right] 
% \nonumber \\ 
D40l = K57l*MY_5l - K56l*MZ_5l;
D41l = - K57l*MX_5l - K29l*MZ_5l;
D42l = K56l*MX_5l + K29l*MY_5l;
% m_{5l}\bar{S}_{5l}^{\times}\bar{g}_{5l} &= \left[\begin{matrix} D40l*g & D41l*g & D42l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{5l}\bar{a}_{G(5l)} &= m_{5l}\bar{a}_{5l} + \bar\alpha_{5l} \times \mathbf{MS}_{5l} + \bar\omega_{5l} \times \left(\bar\omega_{5l} \times \mathbf{MS}_{5l}\right) 
% \nonumber \\ 
% m_{5l}\bar{a}_{G(5l)} &= \left[\begin{matrix} MZ_5l*(K52l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) - MY_5l*(K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l)) - m_5l*(K26l + K12l*ddpsi + K14l*ddq_w + K13l*ddq_imu + K15l*ddq_torso + K11l*ddx) - K32l*(K32l*MX_5l - K31l*MY_5l) - K33l*(K33l*MX_5l - K31l*MZ_5l) & MX_5l*(K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l)) + MZ_5l*(K24l + ddq_2l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) + m_5l*(K54l + K43l*ddpsi + K45l*ddq_w + K44l*ddq_imu + K46l*ddq_torso + K42l*ddx) + K31l*(K32l*MX_5l - K31l*MY_5l) - K33l*(K33l*MY_5l - K32l*MZ_5l) & m_5l*(K55l + K48l*ddpsi + K50l*ddq_w + K49l*ddq_imu + K51l*ddq_torso + K47l*ddx) - MY_5l*(K24l + ddq_2l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) - MX_5l*(K52l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) + K31l*(K33l*MX_5l - K31l*MZ_5l) + K32l*(K33l*MY_5l - K32l*MZ_5l) &  \end{matrix}\right] 
% \nonumber \\ 
D43l = -K11l*m_5l;
D44l = K34l*MZ_5l - K37l*MY_5l - K12l*m_5l;
D45l = K35l*MZ_5l - K38l*MY_5l - K13l*m_5l;
D46l = K35l*MZ_5l - K38l*MY_5l - K14l*m_5l;
D47l = K36l*MZ_5l - K39l*MY_5l - K15l*m_5l;
D48l = MZ_5l*cos(q_2l) - MY_5l*sin(q_2l);
D49l = K52l*MZ_5l - K32l^2*MX_5l - K33l^2*MX_5l - K53l*MY_5l - K26l*m_5l + K31l*K32l*MY_5l + K31l*K33l*MZ_5l;
D50l = K42l*m_5l;
D51l = K43l*m_5l + K37l*MX_5l + K4l*MZ_5l;
D52l = K44l*m_5l + K38l*MX_5l + K5l*MZ_5l;
D53l = K45l*m_5l + K38l*MX_5l + K5l*MZ_5l;
D54l = K46l*m_5l - MZ_5l*cos(q_1l) + K39l*MX_5l;
D55l = MX_5l*sin(q_2l);
D56l = K54l*m_5l - K31l^2*MY_5l - K33l^2*MY_5l + K53l*MX_5l + K24l*MZ_5l + K31l*K32l*MX_5l + K32l*K33l*MZ_5l;
D57l = K47l*m_5l;
D58l = K48l*m_5l - K34l*MX_5l - K4l*MY_5l;
D59l = K49l*m_5l - K35l*MX_5l - K5l*MY_5l;
D60l = K50l*m_5l - K35l*MX_5l - K5l*MY_5l;
D61l = K51l*m_5l + MY_5l*cos(q_1l) - K36l*MX_5l;
D62l = -MX_5l*cos(q_2l);
D63l = K55l*m_5l - K31l^2*MZ_5l - K32l^2*MZ_5l - K52l*MX_5l - K24l*MY_5l + K31l*K33l*MX_5l + K32l*K33l*MY_5l;
% m_{5l}\bar{a}_{G(5l)} &= \left[\begin{matrix} D49l + D44l*ddpsi + D48l*ddq_1l + D46l*ddq_w + D45l*ddq_imu + D47l*ddq_torso + D43l*ddx & D56l + D51l*ddpsi + D55l*ddq_1l + D53l*ddq_w + D52l*ddq_imu + D54l*ddq_torso + D50l*ddx + MZ_5l*ddq_2l & D63l + D58l*ddpsi + D62l*ddq_1l + D60l*ddq_w + D59l*ddq_imu + D61l*ddq_torso + D57l*ddx - MY_5l*ddq_2l &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{5l} &= \mathbf{MS}_{5l} \times \bar{a}_{5l} + J_{5l}\bar{\alpha}_{5l} + \bar\omega_{5l} \times J_{5l}\bar{\omega}_{5l} 
% \nonumber \\ 
% \dot{\bar{H}}_{5l} &= \left[\begin{matrix} K32l*(K31l*XZ_5l + K32l*YZ_5l + K33l*ZZ_5l) - K33l*(K31l*XY_5l + K32l*YY_5l + K33l*YZ_5l) + XY_5l*(K52l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) + XZ_5l*(K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l)) - XX_5l*(K24l + ddq_2l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) + MY_5l*(K55l + K48l*ddpsi + K50l*ddq_w + K49l*ddq_imu + K51l*ddq_torso + K47l*ddx) - MZ_5l*(K54l + K43l*ddpsi + K45l*ddq_w + K44l*ddq_imu + K46l*ddq_torso + K42l*ddx) & K33l*(K31l*XX_5l + K32l*XY_5l + K33l*XZ_5l) - K31l*(K31l*XZ_5l + K32l*YZ_5l + K33l*ZZ_5l) + YY_5l*(K52l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) + YZ_5l*(K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l)) - XY_5l*(K24l + ddq_2l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) - MX_5l*(K55l + K48l*ddpsi + K50l*ddq_w + K49l*ddq_imu + K51l*ddq_torso + K47l*ddx) - MZ_5l*(K26l + K12l*ddpsi + K14l*ddq_w + K13l*ddq_imu + K15l*ddq_torso + K11l*ddx) & K31l*(K31l*XY_5l + K32l*YY_5l + K33l*YZ_5l) - K32l*(K31l*XX_5l + K32l*XY_5l + K33l*XZ_5l) + YZ_5l*(K52l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) + ZZ_5l*(K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l)) - XZ_5l*(K24l + ddq_2l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) + MX_5l*(K54l + K43l*ddpsi + K45l*ddq_w + K44l*ddq_imu + K46l*ddq_torso + K42l*ddx) + MY_5l*(K26l + K12l*ddpsi + K14l*ddq_w + K13l*ddq_imu + K15l*ddq_torso + K11l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D64l = K47l*MY_5l - K42l*MZ_5l;
D65l = K34l*XY_5l - K4l*XX_5l + K37l*XZ_5l + K48l*MY_5l - K43l*MZ_5l;
D66l = K35l*XY_5l - K5l*XX_5l + K38l*XZ_5l + K49l*MY_5l - K44l*MZ_5l;
D67l = K35l*XY_5l - K5l*XX_5l + K38l*XZ_5l + K50l*MY_5l - K45l*MZ_5l;
D68l = K36l*XY_5l + K39l*XZ_5l + XX_5l*cos(q_1l) + K51l*MY_5l - K46l*MZ_5l;
D69l = XY_5l*cos(q_2l) + XZ_5l*sin(q_2l);
D70l = K52l*XY_5l - K24l*XX_5l + K53l*XZ_5l + K32l^2*YZ_5l - K33l^2*YZ_5l + K55l*MY_5l - K54l*MZ_5l - K31l*K33l*XY_5l + K31l*K32l*XZ_5l - K32l*K33l*YY_5l + K32l*K33l*ZZ_5l;
D71l = - K47l*MX_5l - K11l*MZ_5l;
D72l = K34l*YY_5l - K4l*XY_5l + K37l*YZ_5l - K48l*MX_5l - K12l*MZ_5l;
D73l = K35l*YY_5l - K5l*XY_5l + K38l*YZ_5l - K49l*MX_5l - K13l*MZ_5l;
D74l = K35l*YY_5l - K5l*XY_5l + K38l*YZ_5l - K50l*MX_5l - K14l*MZ_5l;
D75l = K36l*YY_5l + K39l*YZ_5l + XY_5l*cos(q_1l) - K51l*MX_5l - K15l*MZ_5l;
D76l = YY_5l*cos(q_2l) + YZ_5l*sin(q_2l);
D77l = K52l*YY_5l - K24l*XY_5l + K53l*YZ_5l - K31l^2*XZ_5l + K33l^2*XZ_5l - K55l*MX_5l - K26l*MZ_5l + K31l*K33l*XX_5l + K32l*K33l*XY_5l - K31l*K32l*YZ_5l - K31l*K33l*ZZ_5l;
D78l = K42l*MX_5l + K11l*MY_5l;
D79l = K34l*YZ_5l - K4l*XZ_5l + K37l*ZZ_5l + K43l*MX_5l + K12l*MY_5l;
D80l = K35l*YZ_5l - K5l*XZ_5l + K38l*ZZ_5l + K44l*MX_5l + K13l*MY_5l;
D81l = K35l*YZ_5l - K5l*XZ_5l + K38l*ZZ_5l + K45l*MX_5l + K14l*MY_5l;
D82l = K36l*YZ_5l + K39l*ZZ_5l + XZ_5l*cos(q_1l) + K46l*MX_5l + K15l*MY_5l;
D83l = YZ_5l*cos(q_2l) + ZZ_5l*sin(q_2l);
D84l = K52l*YZ_5l - K24l*XZ_5l + K53l*ZZ_5l + K31l^2*XY_5l - K32l^2*XY_5l + K54l*MX_5l + K26l*MY_5l - K31l*K32l*XX_5l - K32l*K33l*XZ_5l + K31l*K32l*YY_5l + K31l*K33l*YZ_5l;
% \dot{\bar{H}}_{5l} &= \left[\begin{matrix} D49l + D44l*ddpsi + D48l*ddq_1l + D46l*ddq_w + D45l*ddq_imu + D47l*ddq_torso + D43l*ddx & D56l + D51l*ddpsi + D55l*ddq_1l + D53l*ddq_w + D52l*ddq_imu + D54l*ddq_torso + D50l*ddx + MZ_5l*ddq_2l & D63l + D58l*ddpsi + D62l*ddq_1l + D60l*ddq_w + D59l*ddq_imu + D61l*ddq_torso + D57l*ddx - MY_5l*ddq_2l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{6l} &= {}^{6l}A_{5l} \bar\omega_{5l} + \dot{q}_{6l} \bar{e}_{6l} 
% \nonumber \\ 
% \bar\omega_{6l} &= \left[\begin{matrix} K33l*sin(q_3l) - K31l*cos(q_3l) & - K32l - dq_3l & K33l*cos(q_3l) + K31l*sin(q_3l) &  \end{matrix}\right] 
% \nonumber \\ 
K58l = K33l*sin(q_3l) - K31l*cos(q_3l);
K59l = - K32l - dq_3l;
K60l = K33l*cos(q_3l) + K31l*sin(q_3l);
% \bar\omega_{6l} &= \left[\begin{matrix} K58l & K59l & K60l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{6l} &= \left[\begin{matrix} sin(q_3l)*(K37l*dpsi + K38l*dq_w + K38l*dq_imu + K39l*dq_torso + dq_1l*sin(q_2l)) + cos(q_3l)*(dq_2l + K4l*dpsi + K5l*dq_w + K5l*dq_imu - dq_torso*cos(q_1l)) & - dq_3l - K34l*dpsi - K35l*dq_w - K35l*dq_imu - K36l*dq_torso - dq_1l*cos(q_2l) & cos(q_3l)*(K37l*dpsi + K38l*dq_w + K38l*dq_imu + K39l*dq_torso + dq_1l*sin(q_2l)) - sin(q_3l)*(dq_2l + K4l*dpsi + K5l*dq_w + K5l*dq_imu - dq_torso*cos(q_1l)) &  \end{matrix}\right] 
% \nonumber \\ 
K61l = K4l*cos(q_3l) + K37l*sin(q_3l);
K62l = K5l*cos(q_3l) + K38l*sin(q_3l);
K63l = K39l*sin(q_3l) - cos(q_1l)*cos(q_3l);
K64l = sin(q_2l)*sin(q_3l);
K65l = K37l*cos(q_3l) - K4l*sin(q_3l);
K66l = K38l*cos(q_3l) - K5l*sin(q_3l);
K67l = cos(q_1l)*sin(q_3l) + K39l*cos(q_3l);
K68l = cos(q_3l)*sin(q_2l);
% \bar\omega_{6l} &= \left[\begin{matrix} K61l*dpsi + K64l*dq_1l + K62l*dq_w + K62l*dq_imu + K63l*dq_torso + dq_2l*cos(q_3l) & - dq_3l - K34l*dpsi - K35l*dq_w - K35l*dq_imu - K36l*dq_torso - dq_1l*cos(q_2l) & K65l*dpsi + K68l*dq_1l + K66l*dq_w + K66l*dq_imu + K67l*dq_torso - dq_2l*sin(q_3l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{6l} &= {}^{6l}A_{5l} \left(\bar{v}_{5l} + \bar\omega_{5l} \times \bar{P}_{6l}\right) 
% \nonumber \\ 
% \bar{v}_{6l} &= \left[\begin{matrix} cos(q_3l)*(K8l - K33l*L7) + sin(q_3l)*(K41l - K31l*L7) & -K40l & cos(q_3l)*(K41l - K31l*L7) - sin(q_3l)*(K8l - K33l*L7) &  \end{matrix}\right] 
% \nonumber \\ 
K69l = cos(q_3l)*(K8l - K33l*L7) + sin(q_3l)*(K41l - K31l*L7);
K70l = cos(q_3l)*(K41l - K31l*L7) - sin(q_3l)*(K8l - K33l*L7);
% \bar{v}_{6l} &= \left[\begin{matrix} K69l & -K40l & K70l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{6l} &= \left[\begin{matrix} sin(q_3l)*(K48l*dpsi + K50l*dq_w + K49l*dq_imu + K51l*dq_torso + K47l*dx + L7*(dq_2l + K4l*dpsi + K5l*dq_w + K5l*dq_imu - dq_torso*cos(q_1l))) + cos(q_3l)*(K12l*dpsi + K14l*dq_w + K13l*dq_imu + K15l*dq_torso + K11l*dx - L7*(K37l*dpsi + K38l*dq_w + K38l*dq_imu + K39l*dq_torso + dq_1l*sin(q_2l))) & - K43l*dpsi - K45l*dq_w - K44l*dq_imu - K46l*dq_torso - K42l*dx & cos(q_3l)*(K48l*dpsi + K50l*dq_w + K49l*dq_imu + K51l*dq_torso + K47l*dx + L7*(dq_2l + K4l*dpsi + K5l*dq_w + K5l*dq_imu - dq_torso*cos(q_1l))) - sin(q_3l)*(K12l*dpsi + K14l*dq_w + K13l*dq_imu + K15l*dq_torso + K11l*dx - L7*(K37l*dpsi + K38l*dq_w + K38l*dq_imu + K39l*dq_torso + dq_1l*sin(q_2l))) &  \end{matrix}\right] 
% \nonumber \\ 
K71l = K11l*cos(q_3l) + K47l*sin(q_3l);
K72l = cos(q_3l)*(K12l - K37l*L7) + sin(q_3l)*(K48l + K4l*L7);
K73l = cos(q_3l)*(K13l - K38l*L7) + sin(q_3l)*(K49l + K5l*L7);
K74l = cos(q_3l)*(K14l - K38l*L7) + sin(q_3l)*(K50l + K5l*L7);
K75l = sin(q_3l)*(K51l - L7*cos(q_1l)) + cos(q_3l)*(K15l - K39l*L7);
K76l = -L7*cos(q_3l)*sin(q_2l);
K77l = L7*sin(q_3l);
K78l = K47l*cos(q_3l) - K11l*sin(q_3l);
K79l = cos(q_3l)*(K48l + K4l*L7) - sin(q_3l)*(K12l - K37l*L7);
K80l = cos(q_3l)*(K49l + K5l*L7) - sin(q_3l)*(K13l - K38l*L7);
K81l = cos(q_3l)*(K50l + K5l*L7) - sin(q_3l)*(K14l - K38l*L7);
K82l = cos(q_3l)*(K51l - L7*cos(q_1l)) - sin(q_3l)*(K15l - K39l*L7);
K83l = L7*sin(q_2l)*sin(q_3l);
K84l = L7*cos(q_3l);
% \bar{v}_{6l} &= \left[\begin{matrix} K72l*dpsi + K76l*dq_1l + K77l*dq_2l + K74l*dq_w + K73l*dq_imu + K75l*dq_torso + K71l*dx & - K43l*dpsi - K45l*dq_w - K44l*dq_imu - K46l*dq_torso - K42l*dx & K79l*dpsi + K83l*dq_1l + K84l*dq_2l + K81l*dq_w + K80l*dq_imu + K82l*dq_torso + K78l*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{6l} &= {}^{6l}A_{5l} \bar\alpha_{5l} + \ddot{q}_{6l} \bar{e}_{6l} + \dot{q}_{6l} \left(\bar\omega_{6l} \times \bar{e}_{6l}\right) 
% \nonumber \\ 
% \bar\alpha_{6l} &= \left[\begin{matrix} cos(q_3l)*(K24l + ddq_2l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) + K60l*dq_3l + sin(q_3l)*(K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l)) & - K52l - ddq_3l - K34l*ddpsi - K35l*ddq_w - K35l*ddq_imu - K36l*ddq_torso - ddq_1l*cos(q_2l) & cos(q_3l)*(K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l)) - sin(q_3l)*(K24l + ddq_2l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) - K58l*dq_3l &  \end{matrix}\right] 
% \nonumber \\ 
K85l = K60l*dq_3l + K24l*cos(q_3l) + K53l*sin(q_3l);
K86l = K53l*cos(q_3l) - K58l*dq_3l - K24l*sin(q_3l);
% \bar\alpha_{6l} &= \left[\begin{matrix} K85l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l) & - K52l - ddq_3l - K34l*ddpsi - K35l*ddq_w - K35l*ddq_imu - K36l*ddq_torso - ddq_1l*cos(q_2l) & K86l + K65l*ddpsi + K68l*ddq_1l + K66l*ddq_w + K66l*ddq_imu + K67l*ddq_torso - ddq_2l*sin(q_3l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{6l} &= {}^{6l}A_{5l} \left(\bar{a}_{5l} + \bar\alpha_{5l} \times \bar{P}_{6l} + \bar\omega_{5l} \times \left(\bar\omega_{5l} \times \bar{P}_{6l}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{6l} &= \left[\begin{matrix} cos(q_3l)*(K26l + K12l*ddpsi + K14l*ddq_w + K13l*ddq_imu + K15l*ddq_torso + K11l*ddx - L7*(K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l)) + K31l*K32l*L7) + sin(q_3l)*(K55l + K48l*ddpsi + K50l*ddq_w + K49l*ddq_imu + K51l*ddq_torso + K47l*ddx + L7*(K24l + ddq_2l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) - K32l*K33l*L7) & - K54l - K43l*ddpsi - K45l*ddq_w - K44l*ddq_imu - K46l*ddq_torso - K42l*ddx - K31l^2*L7 - K33l^2*L7 & cos(q_3l)*(K55l + K48l*ddpsi + K50l*ddq_w + K49l*ddq_imu + K51l*ddq_torso + K47l*ddx + L7*(K24l + ddq_2l + K4l*ddpsi + K5l*ddq_w + K5l*ddq_imu - ddq_torso*cos(q_1l)) - K32l*K33l*L7) - sin(q_3l)*(K26l + K12l*ddpsi + K14l*ddq_w + K13l*ddq_imu + K15l*ddq_torso + K11l*ddx - L7*(K53l + K37l*ddpsi + K38l*ddq_w + K38l*ddq_imu + K39l*ddq_torso + ddq_1l*sin(q_2l)) + K31l*K32l*L7) &  \end{matrix}\right] 
% \nonumber \\ 
K87l = K26l*cos(q_3l) + K55l*sin(q_3l) - K53l*L7*cos(q_3l) + K24l*L7*sin(q_3l) + K31l*K32l*L7*cos(q_3l) - K32l*K33l*L7*sin(q_3l);
K88l = - K54l - K31l^2*L7 - K33l^2*L7;
K89l = K55l*cos(q_3l) - K26l*sin(q_3l) + K24l*L7*cos(q_3l) + K53l*L7*sin(q_3l) - K32l*K33l*L7*cos(q_3l) - K31l*K32l*L7*sin(q_3l);
% \bar{a}_{6l} &= \left[\begin{matrix} K87l + K72l*ddpsi + K76l*ddq_1l + K77l*ddq_2l + K74l*ddq_w + K73l*ddq_imu + K75l*ddq_torso + K71l*ddx & K88l - K43l*ddpsi - K45l*ddq_w - K44l*ddq_imu - K46l*ddq_torso - K42l*ddx & K89l + K79l*ddpsi + K83l*ddq_1l + K84l*ddq_2l + K81l*ddq_w + K80l*ddq_imu + K82l*ddq_torso + K78l*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{6l} &= {}^{6l}A_{5l} \bar{g}_{5l} 
% \nonumber \\ 
% \bar{g}_{6l} &= \left[\begin{matrix} K29l*g*cos(q_3l) + K57l*g*sin(q_3l) & -K56l*g & K57l*g*cos(q_3l) - K29l*g*sin(q_3l) &  \end{matrix}\right] 
% \nonumber \\ 
K90l = K29l*cos(q_3l) + K57l*sin(q_3l);
K91l = K57l*cos(q_3l) - K29l*sin(q_3l);
% \bar{g}_{6l} &= \left[\begin{matrix} K90l*g & -K56l*g & K91l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{6l}\bar{S}_{6l}^{\times}\bar{g}_{6l} &= \mathbf{MS}_{6l} \times \bar{g}_{6l} 
% \nonumber \\ 
% m_{6l}\bar{S}_{6l}^{\times}\bar{g}_{6l} &= \left[\begin{matrix} K91l*MY_6l*g + K56l*MZ_6l*g & K90l*MZ_6l*g - K91l*MX_6l*g & - K56l*MX_6l*g - K90l*MY_6l*g &  \end{matrix}\right] 
% \nonumber \\ 
D85l = K91l*MY_6l + K56l*MZ_6l;
D86l = K90l*MZ_6l - K91l*MX_6l;
D87l = - K56l*MX_6l - K90l*MY_6l;
% m_{6l}\bar{S}_{6l}^{\times}\bar{g}_{6l} &= \left[\begin{matrix} D85l*g & D86l*g & D87l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{6l}\bar{a}_{G(6l)} &= m_{6l}\bar{a}_{6l} + \bar\alpha_{6l} \times \mathbf{MS}_{6l} + \bar\omega_{6l} \times \left(\bar\omega_{6l} \times \mathbf{MS}_{6l}\right) 
% \nonumber \\ 
% m_{6l}\bar{a}_{G(6l)} &= \left[\begin{matrix} m_6l*(K87l + K72l*ddpsi + K76l*ddq_1l + K77l*ddq_2l + K74l*ddq_w + K73l*ddq_imu + K75l*ddq_torso + K71l*ddx) - MZ_6l*(K52l + ddq_3l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) - MY_6l*(K86l + K65l*ddpsi + K68l*ddq_1l + K66l*ddq_w + K66l*ddq_imu + K67l*ddq_torso - ddq_2l*sin(q_3l)) - K59l*(K59l*MX_6l - K58l*MY_6l) - K60l*(K60l*MX_6l - K58l*MZ_6l) & MX_6l*(K86l + K65l*ddpsi + K68l*ddq_1l + K66l*ddq_w + K66l*ddq_imu + K67l*ddq_torso - ddq_2l*sin(q_3l)) - MZ_6l*(K85l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) - m_6l*(K43l*ddpsi - K88l + K45l*ddq_w + K44l*ddq_imu + K46l*ddq_torso + K42l*ddx) + K58l*(K59l*MX_6l - K58l*MY_6l) - K60l*(K60l*MY_6l - K59l*MZ_6l) & MY_6l*(K85l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) + MX_6l*(K52l + ddq_3l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) + m_6l*(K89l + K79l*ddpsi + K83l*ddq_1l + K84l*ddq_2l + K81l*ddq_w + K80l*ddq_imu + K82l*ddq_torso + K78l*ddx) + K58l*(K60l*MX_6l - K58l*MZ_6l) + K59l*(K60l*MY_6l - K59l*MZ_6l) &  \end{matrix}\right] 
% \nonumber \\ 
D88l = K71l*m_6l;
D89l = K72l*m_6l - K65l*MY_6l - K34l*MZ_6l;
D90l = K73l*m_6l - K66l*MY_6l - K35l*MZ_6l;
D91l = K74l*m_6l - K66l*MY_6l - K35l*MZ_6l;
D92l = K75l*m_6l - K67l*MY_6l - K36l*MZ_6l;
D93l = K76l*m_6l - MZ_6l*cos(q_2l) - K68l*MY_6l;
D94l = K77l*m_6l + MY_6l*sin(q_3l);
D95l = K87l*m_6l - K59l^2*MX_6l - K60l^2*MX_6l - K86l*MY_6l - K52l*MZ_6l + K58l*K59l*MY_6l + K58l*K60l*MZ_6l;
D96l = -K42l*m_6l;
D97l = K65l*MX_6l - K43l*m_6l - K61l*MZ_6l;
D98l = K66l*MX_6l - K44l*m_6l - K62l*MZ_6l;
D99l = K66l*MX_6l - K45l*m_6l - K62l*MZ_6l;
D100l = K67l*MX_6l - K46l*m_6l - K63l*MZ_6l;
D101l = K68l*MX_6l - K64l*MZ_6l;
D102l = - MZ_6l*cos(q_3l) - MX_6l*sin(q_3l);
D103l = K88l*m_6l - K58l^2*MY_6l - K60l^2*MY_6l + K86l*MX_6l - K85l*MZ_6l + K58l*K59l*MX_6l + K59l*K60l*MZ_6l;
D104l = K78l*m_6l;
D105l = K79l*m_6l + K34l*MX_6l + K61l*MY_6l;
D106l = K80l*m_6l + K35l*MX_6l + K62l*MY_6l;
D107l = K81l*m_6l + K35l*MX_6l + K62l*MY_6l;
D108l = K82l*m_6l + K36l*MX_6l + K63l*MY_6l;
D109l = K83l*m_6l + MX_6l*cos(q_2l) + K64l*MY_6l;
D110l = K84l*m_6l + MY_6l*cos(q_3l);
D111l = K89l*m_6l - K58l^2*MZ_6l - K59l^2*MZ_6l + K52l*MX_6l + K85l*MY_6l + K58l*K60l*MX_6l + K59l*K60l*MY_6l;
% m_{6l}\bar{a}_{G(6l)} &= \left[\begin{matrix} D95l + D89l*ddpsi + D93l*ddq_1l + D94l*ddq_2l + D91l*ddq_w + D90l*ddq_imu + D92l*ddq_torso + D88l*ddx - MZ_6l*ddq_3l & D103l + D97l*ddpsi + D101l*ddq_1l + D102l*ddq_2l + D99l*ddq_w + D98l*ddq_imu + D100l*ddq_torso + D96l*ddx & D111l + D105l*ddpsi + D109l*ddq_1l + D110l*ddq_2l + D107l*ddq_w + D106l*ddq_imu + D108l*ddq_torso + D104l*ddx + MX_6l*ddq_3l &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{6l} &= \mathbf{MS}_{6l} \times \bar{a}_{6l} + J_{6l}\bar{\alpha}_{6l} + \bar\omega_{6l} \times J_{6l}\bar{\omega}_{6l} 
% \nonumber \\ 
% \dot{\bar{H}}_{6l} &= \left[\begin{matrix} MZ_6l*(K43l*ddpsi - K88l + K45l*ddq_w + K44l*ddq_imu + K46l*ddq_torso + K42l*ddx) - K60l*(K58l*XY_6l + K59l*YY_6l + K60l*YZ_6l) + K59l*(K58l*XZ_6l + K59l*YZ_6l + K60l*ZZ_6l) + XX_6l*(K85l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) + XZ_6l*(K86l + K65l*ddpsi + K68l*ddq_1l + K66l*ddq_w + K66l*ddq_imu + K67l*ddq_torso - ddq_2l*sin(q_3l)) - XY_6l*(K52l + ddq_3l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) + MY_6l*(K89l + K79l*ddpsi + K83l*ddq_1l + K84l*ddq_2l + K81l*ddq_w + K80l*ddq_imu + K82l*ddq_torso + K78l*ddx) & K60l*(K58l*XX_6l + K59l*XY_6l + K60l*XZ_6l) - K58l*(K58l*XZ_6l + K59l*YZ_6l + K60l*ZZ_6l) + XY_6l*(K85l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) + YZ_6l*(K86l + K65l*ddpsi + K68l*ddq_1l + K66l*ddq_w + K66l*ddq_imu + K67l*ddq_torso - ddq_2l*sin(q_3l)) - YY_6l*(K52l + ddq_3l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) - MX_6l*(K89l + K79l*ddpsi + K83l*ddq_1l + K84l*ddq_2l + K81l*ddq_w + K80l*ddq_imu + K82l*ddq_torso + K78l*ddx) + MZ_6l*(K87l + K72l*ddpsi + K76l*ddq_1l + K77l*ddq_2l + K74l*ddq_w + K73l*ddq_imu + K75l*ddq_torso + K71l*ddx) & K58l*(K58l*XY_6l + K59l*YY_6l + K60l*YZ_6l) - K59l*(K58l*XX_6l + K59l*XY_6l + K60l*XZ_6l) - MX_6l*(K43l*ddpsi - K88l + K45l*ddq_w + K44l*ddq_imu + K46l*ddq_torso + K42l*ddx) + XZ_6l*(K85l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) + ZZ_6l*(K86l + K65l*ddpsi + K68l*ddq_1l + K66l*ddq_w + K66l*ddq_imu + K67l*ddq_torso - ddq_2l*sin(q_3l)) - YZ_6l*(K52l + ddq_3l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) - MY_6l*(K87l + K72l*ddpsi + K76l*ddq_1l + K77l*ddq_2l + K74l*ddq_w + K73l*ddq_imu + K75l*ddq_torso + K71l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D112l = K78l*MY_6l + K42l*MZ_6l;
D113l = K61l*XX_6l - K34l*XY_6l + K65l*XZ_6l + K79l*MY_6l + K43l*MZ_6l;
D114l = K62l*XX_6l - K35l*XY_6l + K66l*XZ_6l + K80l*MY_6l + K44l*MZ_6l;
D115l = K62l*XX_6l - K35l*XY_6l + K66l*XZ_6l + K81l*MY_6l + K45l*MZ_6l;
D116l = K63l*XX_6l - K36l*XY_6l + K67l*XZ_6l + K82l*MY_6l + K46l*MZ_6l;
D117l = K64l*XX_6l + K68l*XZ_6l - XY_6l*cos(q_2l) + K83l*MY_6l;
D118l = XX_6l*cos(q_3l) - XZ_6l*sin(q_3l) + K84l*MY_6l;
D119l = K85l*XX_6l - K52l*XY_6l + K86l*XZ_6l + K59l^2*YZ_6l - K60l^2*YZ_6l + K89l*MY_6l - K88l*MZ_6l - K58l*K60l*XY_6l + K58l*K59l*XZ_6l - K59l*K60l*YY_6l + K59l*K60l*ZZ_6l;
D120l = K71l*MZ_6l - K78l*MX_6l;
D121l = K61l*XY_6l - K34l*YY_6l + K65l*YZ_6l - K79l*MX_6l + K72l*MZ_6l;
D122l = K62l*XY_6l - K35l*YY_6l + K66l*YZ_6l - K80l*MX_6l + K73l*MZ_6l;
D123l = K62l*XY_6l - K35l*YY_6l + K66l*YZ_6l - K81l*MX_6l + K74l*MZ_6l;
D124l = K63l*XY_6l - K36l*YY_6l + K67l*YZ_6l - K82l*MX_6l + K75l*MZ_6l;
D125l = K64l*XY_6l + K68l*YZ_6l - YY_6l*cos(q_2l) - K83l*MX_6l + K76l*MZ_6l;
D126l = XY_6l*cos(q_3l) - YZ_6l*sin(q_3l) - K84l*MX_6l + K77l*MZ_6l;
D127l = K85l*XY_6l - K52l*YY_6l + K86l*YZ_6l - K58l^2*XZ_6l + K60l^2*XZ_6l - K89l*MX_6l + K87l*MZ_6l + K58l*K60l*XX_6l + K59l*K60l*XY_6l - K58l*K59l*YZ_6l - K58l*K60l*ZZ_6l;
D128l = - K42l*MX_6l - K71l*MY_6l;
D129l = K61l*XZ_6l - K34l*YZ_6l + K65l*ZZ_6l - K43l*MX_6l - K72l*MY_6l;
D130l = K62l*XZ_6l - K35l*YZ_6l + K66l*ZZ_6l - K44l*MX_6l - K73l*MY_6l;
D131l = K62l*XZ_6l - K35l*YZ_6l + K66l*ZZ_6l - K45l*MX_6l - K74l*MY_6l;
D132l = K63l*XZ_6l - K36l*YZ_6l + K67l*ZZ_6l - K46l*MX_6l - K75l*MY_6l;
D133l = K64l*XZ_6l + K68l*ZZ_6l - YZ_6l*cos(q_2l) - K76l*MY_6l;
D134l = XZ_6l*cos(q_3l) - ZZ_6l*sin(q_3l) - K77l*MY_6l;
D135l = K85l*XZ_6l - K52l*YZ_6l + K86l*ZZ_6l + K58l^2*XY_6l - K59l^2*XY_6l + K88l*MX_6l - K87l*MY_6l - K58l*K59l*XX_6l - K59l*K60l*XZ_6l + K58l*K59l*YY_6l + K58l*K60l*YZ_6l;
% \dot{\bar{H}}_{6l} &= \left[\begin{matrix} D95l + D89l*ddpsi + D93l*ddq_1l + D94l*ddq_2l + D91l*ddq_w + D90l*ddq_imu + D92l*ddq_torso + D88l*ddx - MZ_6l*ddq_3l & D103l + D97l*ddpsi + D101l*ddq_1l + D102l*ddq_2l + D99l*ddq_w + D98l*ddq_imu + D100l*ddq_torso + D96l*ddx & D111l + D105l*ddpsi + D109l*ddq_1l + D110l*ddq_2l + D107l*ddq_w + D106l*ddq_imu + D108l*ddq_torso + D104l*ddx + MX_6l*ddq_3l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{7l} &= {}^{7l}A_{6l} \bar\omega_{6l} + \dot{q}_{7l} \bar{e}_{7l} 
% \nonumber \\ 
% \bar\omega_{7l} &= \left[\begin{matrix} - K58l - dq_4l & - K59l*cos(q_4l) - K60l*sin(q_4l) & K60l*cos(q_4l) - K59l*sin(q_4l) &  \end{matrix}\right] 
% \nonumber \\ 
K92l = - K58l - dq_4l;
K93l = - K59l*cos(q_4l) - K60l*sin(q_4l);
K94l = K60l*cos(q_4l) - K59l*sin(q_4l);
% \bar\omega_{7l} &= \left[\begin{matrix} K92l & K93l & K94l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{7l} &= \left[\begin{matrix} - dq_4l - K61l*dpsi - K64l*dq_1l - K62l*dq_w - K62l*dq_imu - K63l*dq_torso - dq_2l*cos(q_3l) & cos(q_4l)*(dq_3l + K34l*dpsi + K35l*dq_w + K35l*dq_imu + K36l*dq_torso + dq_1l*cos(q_2l)) - sin(q_4l)*(K65l*dpsi + K68l*dq_1l + K66l*dq_w + K66l*dq_imu + K67l*dq_torso - dq_2l*sin(q_3l)) & cos(q_4l)*(K65l*dpsi + K68l*dq_1l + K66l*dq_w + K66l*dq_imu + K67l*dq_torso - dq_2l*sin(q_3l)) + sin(q_4l)*(dq_3l + K34l*dpsi + K35l*dq_w + K35l*dq_imu + K36l*dq_torso + dq_1l*cos(q_2l)) &  \end{matrix}\right] 
% \nonumber \\ 
K95l = K34l*cos(q_4l) - K65l*sin(q_4l);
K96l = K35l*cos(q_4l) - K66l*sin(q_4l);
K97l = K36l*cos(q_4l) - K67l*sin(q_4l);
K98l = cos(q_2l)*cos(q_4l) - K68l*sin(q_4l);
K99l = sin(q_3l)*sin(q_4l);
K100l = K65l*cos(q_4l) + K34l*sin(q_4l);
K101l = K66l*cos(q_4l) + K35l*sin(q_4l);
K102l = K67l*cos(q_4l) + K36l*sin(q_4l);
K103l = cos(q_2l)*sin(q_4l) + K68l*cos(q_4l);
K104l = -cos(q_4l)*sin(q_3l);
% \bar\omega_{7l} &= \left[\begin{matrix} - dq_4l - K61l*dpsi - K64l*dq_1l - K62l*dq_w - K62l*dq_imu - K63l*dq_torso - dq_2l*cos(q_3l) & K95l*dpsi + K98l*dq_1l + K99l*dq_2l + K96l*dq_w + K96l*dq_imu + K97l*dq_torso + dq_3l*cos(q_4l) & K100l*dpsi + K103l*dq_1l + K104l*dq_2l + K101l*dq_w + K101l*dq_imu + K102l*dq_torso + dq_3l*sin(q_4l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{7l} &= {}^{7l}A_{6l} \left(\bar{v}_{6l} + \bar\omega_{6l} \times \bar{P}_{7l}\right) 
% \nonumber \\ 
% \bar{v}_{7l} &= \left[\begin{matrix} -K69l & K40l*cos(q_4l) - K70l*sin(q_4l) & K70l*cos(q_4l) + K40l*sin(q_4l) &  \end{matrix}\right] 
% \nonumber \\ 
K105l = K40l*cos(q_4l) - K70l*sin(q_4l);
K106l = K70l*cos(q_4l) + K40l*sin(q_4l);
% \bar{v}_{7l} &= \left[\begin{matrix} -K69l & K105l & K106l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{7l} &= \left[\begin{matrix} - K72l*dpsi - K76l*dq_1l - K77l*dq_2l - K74l*dq_w - K73l*dq_imu - K75l*dq_torso - K71l*dx & cos(q_4l)*(K43l*dpsi + K45l*dq_w + K44l*dq_imu + K46l*dq_torso + K42l*dx) - sin(q_4l)*(K79l*dpsi + K83l*dq_1l + K84l*dq_2l + K81l*dq_w + K80l*dq_imu + K82l*dq_torso + K78l*dx) & sin(q_4l)*(K43l*dpsi + K45l*dq_w + K44l*dq_imu + K46l*dq_torso + K42l*dx) + cos(q_4l)*(K79l*dpsi + K83l*dq_1l + K84l*dq_2l + K81l*dq_w + K80l*dq_imu + K82l*dq_torso + K78l*dx) &  \end{matrix}\right] 
% \nonumber \\ 
K107l = K42l*cos(q_4l) - K78l*sin(q_4l);
K108l = K43l*cos(q_4l) - K79l*sin(q_4l);
K109l = K44l*cos(q_4l) - K80l*sin(q_4l);
K110l = K45l*cos(q_4l) - K81l*sin(q_4l);
K111l = K46l*cos(q_4l) - K82l*sin(q_4l);
K112l = -K83l*sin(q_4l);
K113l = -K84l*sin(q_4l);
K114l = K78l*cos(q_4l) + K42l*sin(q_4l);
K115l = K79l*cos(q_4l) + K43l*sin(q_4l);
K116l = K80l*cos(q_4l) + K44l*sin(q_4l);
K117l = K81l*cos(q_4l) + K45l*sin(q_4l);
K118l = K82l*cos(q_4l) + K46l*sin(q_4l);
K119l = K83l*cos(q_4l);
K120l = K84l*cos(q_4l);
% \bar{v}_{7l} &= \left[\begin{matrix} - K72l*dpsi - K76l*dq_1l - K77l*dq_2l - K74l*dq_w - K73l*dq_imu - K75l*dq_torso - K71l*dx & K108l*dpsi + K112l*dq_1l + K113l*dq_2l + K110l*dq_w + K109l*dq_imu + K111l*dq_torso + K107l*dx & K115l*dpsi + K119l*dq_1l + K120l*dq_2l + K117l*dq_w + K116l*dq_imu + K118l*dq_torso + K114l*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{7l} &= {}^{7l}A_{6l} \bar\alpha_{6l} + \ddot{q}_{7l} \bar{e}_{7l} + \dot{q}_{7l} \left(\bar\omega_{7l} \times \bar{e}_{7l}\right) 
% \nonumber \\ 
% \bar\alpha_{7l} &= \left[\begin{matrix} - K85l - ddq_4l - K61l*ddpsi - K64l*ddq_1l - K62l*ddq_w - K62l*ddq_imu - K63l*ddq_torso - ddq_2l*cos(q_3l) & cos(q_4l)*(K52l + ddq_3l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) - K94l*dq_4l - sin(q_4l)*(K86l + K65l*ddpsi + K68l*ddq_1l + K66l*ddq_w + K66l*ddq_imu + K67l*ddq_torso - ddq_2l*sin(q_3l)) & K93l*dq_4l + sin(q_4l)*(K52l + ddq_3l + K34l*ddpsi + K35l*ddq_w + K35l*ddq_imu + K36l*ddq_torso + ddq_1l*cos(q_2l)) + cos(q_4l)*(K86l + K65l*ddpsi + K68l*ddq_1l + K66l*ddq_w + K66l*ddq_imu + K67l*ddq_torso - ddq_2l*sin(q_3l)) &  \end{matrix}\right] 
% \nonumber \\ 
K121l = K52l*cos(q_4l) - K94l*dq_4l - K86l*sin(q_4l);
K122l = K93l*dq_4l + K86l*cos(q_4l) + K52l*sin(q_4l);
% \bar\alpha_{7l} &= \left[\begin{matrix} - K85l - ddq_4l - K61l*ddpsi - K64l*ddq_1l - K62l*ddq_w - K62l*ddq_imu - K63l*ddq_torso - ddq_2l*cos(q_3l) & K121l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l) & K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{7l} &= {}^{7l}A_{6l} \left(\bar{a}_{6l} + \bar\alpha_{6l} \times \bar{P}_{7l} + \bar\omega_{6l} \times \left(\bar\omega_{6l} \times \bar{P}_{7l}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{7l} &= \left[\begin{matrix} - K87l - K72l*ddpsi - K76l*ddq_1l - K77l*ddq_2l - K74l*ddq_w - K73l*ddq_imu - K75l*ddq_torso - K71l*ddx & cos(q_4l)*(K43l*ddpsi - K88l + K45l*ddq_w + K44l*ddq_imu + K46l*ddq_torso + K42l*ddx) - sin(q_4l)*(K89l + K79l*ddpsi + K83l*ddq_1l + K84l*ddq_2l + K81l*ddq_w + K80l*ddq_imu + K82l*ddq_torso + K78l*ddx) & cos(q_4l)*(K89l + K79l*ddpsi + K83l*ddq_1l + K84l*ddq_2l + K81l*ddq_w + K80l*ddq_imu + K82l*ddq_torso + K78l*ddx) + sin(q_4l)*(K43l*ddpsi - K88l + K45l*ddq_w + K44l*ddq_imu + K46l*ddq_torso + K42l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
K123l = - K88l*cos(q_4l) - K89l*sin(q_4l);
K124l = K89l*cos(q_4l) - K88l*sin(q_4l);
% \bar{a}_{7l} &= \left[\begin{matrix} - K87l - K72l*ddpsi - K76l*ddq_1l - K77l*ddq_2l - K74l*ddq_w - K73l*ddq_imu - K75l*ddq_torso - K71l*ddx & K123l + K108l*ddpsi + K112l*ddq_1l + K113l*ddq_2l + K110l*ddq_w + K109l*ddq_imu + K111l*ddq_torso + K107l*ddx & K124l + K115l*ddpsi + K119l*ddq_1l + K120l*ddq_2l + K117l*ddq_w + K116l*ddq_imu + K118l*ddq_torso + K114l*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{7l} &= {}^{7l}A_{6l} \bar{g}_{6l} 
% \nonumber \\ 
% \bar{g}_{7l} &= \left[\begin{matrix} -K90l*g & K56l*g*cos(q_4l) - K91l*g*sin(q_4l) & K91l*g*cos(q_4l) + K56l*g*sin(q_4l) &  \end{matrix}\right] 
% \nonumber \\ 
K125l = K56l*cos(q_4l) - K91l*sin(q_4l);
K126l = K91l*cos(q_4l) + K56l*sin(q_4l);
% \bar{g}_{7l} &= \left[\begin{matrix} -K90l*g & K125l*g & K126l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{7l}\bar{S}_{7l}^{\times}\bar{g}_{7l} &= \mathbf{MS}_{7l} \times \bar{g}_{7l} 
% \nonumber \\ 
% m_{7l}\bar{S}_{7l}^{\times}\bar{g}_{7l} &= \left[\begin{matrix} K126l*MY_7l*g - K125l*MZ_7l*g & - K126l*MX_7l*g - K90l*MZ_7l*g & K125l*MX_7l*g + K90l*MY_7l*g &  \end{matrix}\right] 
% \nonumber \\ 
D136l = K126l*MY_7l - K125l*MZ_7l;
D137l = - K126l*MX_7l - K90l*MZ_7l;
D138l = K125l*MX_7l + K90l*MY_7l;
% m_{7l}\bar{S}_{7l}^{\times}\bar{g}_{7l} &= \left[\begin{matrix} D136l*g & D137l*g & D138l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{7l}\bar{a}_{G(7l)} &= m_{7l}\bar{a}_{7l} + \bar\alpha_{7l} \times \mathbf{MS}_{7l} + \bar\omega_{7l} \times \left(\bar\omega_{7l} \times \mathbf{MS}_{7l}\right) 
% \nonumber \\ 
% m_{7l}\bar{a}_{G(7l)} &= \left[\begin{matrix} MZ_7l*(K121l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) - MY_7l*(K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l)) - m_7l*(K87l + K72l*ddpsi + K76l*ddq_1l + K77l*ddq_2l + K74l*ddq_w + K73l*ddq_imu + K75l*ddq_torso + K71l*ddx) - K93l*(K93l*MX_7l - K92l*MY_7l) - K94l*(K94l*MX_7l - K92l*MZ_7l) & MX_7l*(K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l)) + MZ_7l*(K85l + ddq_4l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) + m_7l*(K123l + K108l*ddpsi + K112l*ddq_1l + K113l*ddq_2l + K110l*ddq_w + K109l*ddq_imu + K111l*ddq_torso + K107l*ddx) + K92l*(K93l*MX_7l - K92l*MY_7l) - K94l*(K94l*MY_7l - K93l*MZ_7l) & m_7l*(K124l + K115l*ddpsi + K119l*ddq_1l + K120l*ddq_2l + K117l*ddq_w + K116l*ddq_imu + K118l*ddq_torso + K114l*ddx) - MY_7l*(K85l + ddq_4l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) - MX_7l*(K121l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) + K92l*(K94l*MX_7l - K92l*MZ_7l) + K93l*(K94l*MY_7l - K93l*MZ_7l) &  \end{matrix}\right] 
% \nonumber \\ 
D139l = -K71l*m_7l;
D140l = K95l*MZ_7l - K100l*MY_7l - K72l*m_7l;
D141l = K96l*MZ_7l - K101l*MY_7l - K73l*m_7l;
D142l = K96l*MZ_7l - K101l*MY_7l - K74l*m_7l;
D143l = K97l*MZ_7l - K102l*MY_7l - K75l*m_7l;
D144l = K98l*MZ_7l - K103l*MY_7l - K76l*m_7l;
D145l = K99l*MZ_7l - K104l*MY_7l - K77l*m_7l;
D146l = MZ_7l*cos(q_4l) - MY_7l*sin(q_4l);
D147l = K121l*MZ_7l - K93l^2*MX_7l - K94l^2*MX_7l - K122l*MY_7l - K87l*m_7l + K92l*K93l*MY_7l + K92l*K94l*MZ_7l;
D148l = K107l*m_7l;
D149l = K108l*m_7l + K100l*MX_7l + K61l*MZ_7l;
D150l = K109l*m_7l + K101l*MX_7l + K62l*MZ_7l;
D151l = K110l*m_7l + K101l*MX_7l + K62l*MZ_7l;
D152l = K111l*m_7l + K102l*MX_7l + K63l*MZ_7l;
D153l = K112l*m_7l + K103l*MX_7l + K64l*MZ_7l;
D154l = K113l*m_7l + MZ_7l*cos(q_3l) + K104l*MX_7l;
D155l = MX_7l*sin(q_4l);
D156l = K123l*m_7l - K92l^2*MY_7l - K94l^2*MY_7l + K122l*MX_7l + K85l*MZ_7l + K92l*K93l*MX_7l + K93l*K94l*MZ_7l;
D157l = K114l*m_7l;
D158l = K115l*m_7l - K95l*MX_7l - K61l*MY_7l;
D159l = K116l*m_7l - K96l*MX_7l - K62l*MY_7l;
D160l = K117l*m_7l - K96l*MX_7l - K62l*MY_7l;
D161l = K118l*m_7l - K97l*MX_7l - K63l*MY_7l;
D162l = K119l*m_7l - K98l*MX_7l - K64l*MY_7l;
D163l = K120l*m_7l - MY_7l*cos(q_3l) - K99l*MX_7l;
D164l = -MX_7l*cos(q_4l);
D165l = K124l*m_7l - K92l^2*MZ_7l - K93l^2*MZ_7l - K121l*MX_7l - K85l*MY_7l + K92l*K94l*MX_7l + K93l*K94l*MY_7l;
% m_{7l}\bar{a}_{G(7l)} &= \left[\begin{matrix} D147l + D140l*ddpsi + D144l*ddq_1l + D145l*ddq_2l + D146l*ddq_3l + D142l*ddq_w + D141l*ddq_imu + D143l*ddq_torso + D139l*ddx & D156l + D149l*ddpsi + D153l*ddq_1l + D154l*ddq_2l + D155l*ddq_3l + D151l*ddq_w + D150l*ddq_imu + D152l*ddq_torso + D148l*ddx + MZ_7l*ddq_4l & D165l + D158l*ddpsi + D162l*ddq_1l + D163l*ddq_2l + D164l*ddq_3l + D160l*ddq_w + D159l*ddq_imu + D161l*ddq_torso + D157l*ddx - MY_7l*ddq_4l &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{7l} &= \mathbf{MS}_{7l} \times \bar{a}_{7l} + J_{7l}\bar{\alpha}_{7l} + \bar\omega_{7l} \times J_{7l}\bar{\omega}_{7l} 
% \nonumber \\ 
% \dot{\bar{H}}_{7l} &= \left[\begin{matrix} K93l*(K92l*XZ_7l + K93l*YZ_7l + K94l*ZZ_7l) - K94l*(K92l*XY_7l + K93l*YY_7l + K94l*YZ_7l) + XY_7l*(K121l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) + XZ_7l*(K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l)) - XX_7l*(K85l + ddq_4l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) + MY_7l*(K124l + K115l*ddpsi + K119l*ddq_1l + K120l*ddq_2l + K117l*ddq_w + K116l*ddq_imu + K118l*ddq_torso + K114l*ddx) - MZ_7l*(K123l + K108l*ddpsi + K112l*ddq_1l + K113l*ddq_2l + K110l*ddq_w + K109l*ddq_imu + K111l*ddq_torso + K107l*ddx) & K94l*(K92l*XX_7l + K93l*XY_7l + K94l*XZ_7l) - K92l*(K92l*XZ_7l + K93l*YZ_7l + K94l*ZZ_7l) + YY_7l*(K121l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) + YZ_7l*(K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l)) - XY_7l*(K85l + ddq_4l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) - MX_7l*(K124l + K115l*ddpsi + K119l*ddq_1l + K120l*ddq_2l + K117l*ddq_w + K116l*ddq_imu + K118l*ddq_torso + K114l*ddx) - MZ_7l*(K87l + K72l*ddpsi + K76l*ddq_1l + K77l*ddq_2l + K74l*ddq_w + K73l*ddq_imu + K75l*ddq_torso + K71l*ddx) & K92l*(K92l*XY_7l + K93l*YY_7l + K94l*YZ_7l) - K93l*(K92l*XX_7l + K93l*XY_7l + K94l*XZ_7l) + YZ_7l*(K121l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) + ZZ_7l*(K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l)) - XZ_7l*(K85l + ddq_4l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) + MX_7l*(K123l + K108l*ddpsi + K112l*ddq_1l + K113l*ddq_2l + K110l*ddq_w + K109l*ddq_imu + K111l*ddq_torso + K107l*ddx) + MY_7l*(K87l + K72l*ddpsi + K76l*ddq_1l + K77l*ddq_2l + K74l*ddq_w + K73l*ddq_imu + K75l*ddq_torso + K71l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D166l = K114l*MY_7l - K107l*MZ_7l;
D167l = K95l*XY_7l - K61l*XX_7l + K100l*XZ_7l + K115l*MY_7l - K108l*MZ_7l;
D168l = K96l*XY_7l - K62l*XX_7l + K101l*XZ_7l + K116l*MY_7l - K109l*MZ_7l;
D169l = K96l*XY_7l - K62l*XX_7l + K101l*XZ_7l + K117l*MY_7l - K110l*MZ_7l;
D170l = K97l*XY_7l - K63l*XX_7l + K102l*XZ_7l + K118l*MY_7l - K111l*MZ_7l;
D171l = K98l*XY_7l - K64l*XX_7l + K103l*XZ_7l + K119l*MY_7l - K112l*MZ_7l;
D172l = K99l*XY_7l + K104l*XZ_7l - XX_7l*cos(q_3l) + K120l*MY_7l - K113l*MZ_7l;
D173l = XY_7l*cos(q_4l) + XZ_7l*sin(q_4l);
D174l = K121l*XY_7l - K85l*XX_7l + K122l*XZ_7l + K93l^2*YZ_7l - K94l^2*YZ_7l + K124l*MY_7l - K123l*MZ_7l - K92l*K94l*XY_7l + K92l*K93l*XZ_7l - K93l*K94l*YY_7l + K93l*K94l*ZZ_7l;
D175l = - K114l*MX_7l - K71l*MZ_7l;
D176l = K95l*YY_7l - K61l*XY_7l + K100l*YZ_7l - K115l*MX_7l - K72l*MZ_7l;
D177l = K96l*YY_7l - K62l*XY_7l + K101l*YZ_7l - K116l*MX_7l - K73l*MZ_7l;
D178l = K96l*YY_7l - K62l*XY_7l + K101l*YZ_7l - K117l*MX_7l - K74l*MZ_7l;
D179l = K97l*YY_7l - K63l*XY_7l + K102l*YZ_7l - K118l*MX_7l - K75l*MZ_7l;
D180l = K98l*YY_7l - K64l*XY_7l + K103l*YZ_7l - K119l*MX_7l - K76l*MZ_7l;
D181l = K99l*YY_7l + K104l*YZ_7l - XY_7l*cos(q_3l) - K120l*MX_7l - K77l*MZ_7l;
D182l = YY_7l*cos(q_4l) + YZ_7l*sin(q_4l);
D183l = K121l*YY_7l - K85l*XY_7l + K122l*YZ_7l - K92l^2*XZ_7l + K94l^2*XZ_7l - K124l*MX_7l - K87l*MZ_7l + K92l*K94l*XX_7l + K93l*K94l*XY_7l - K92l*K93l*YZ_7l - K92l*K94l*ZZ_7l;
D184l = K107l*MX_7l + K71l*MY_7l;
D185l = K95l*YZ_7l - K61l*XZ_7l + K100l*ZZ_7l + K108l*MX_7l + K72l*MY_7l;
D186l = K96l*YZ_7l - K62l*XZ_7l + K101l*ZZ_7l + K109l*MX_7l + K73l*MY_7l;
D187l = K96l*YZ_7l - K62l*XZ_7l + K101l*ZZ_7l + K110l*MX_7l + K74l*MY_7l;
D188l = K97l*YZ_7l - K63l*XZ_7l + K102l*ZZ_7l + K111l*MX_7l + K75l*MY_7l;
D189l = K98l*YZ_7l - K64l*XZ_7l + K103l*ZZ_7l + K112l*MX_7l + K76l*MY_7l;
D190l = K99l*YZ_7l + K104l*ZZ_7l - XZ_7l*cos(q_3l) + K113l*MX_7l + K77l*MY_7l;
D191l = YZ_7l*cos(q_4l) + ZZ_7l*sin(q_4l);
D192l = K121l*YZ_7l - K85l*XZ_7l + K122l*ZZ_7l + K92l^2*XY_7l - K93l^2*XY_7l + K123l*MX_7l + K87l*MY_7l - K92l*K93l*XX_7l - K93l*K94l*XZ_7l + K92l*K93l*YY_7l + K92l*K94l*YZ_7l;
% \dot{\bar{H}}_{7l} &= \left[\begin{matrix} D147l + D140l*ddpsi + D144l*ddq_1l + D145l*ddq_2l + D146l*ddq_3l + D142l*ddq_w + D141l*ddq_imu + D143l*ddq_torso + D139l*ddx & D156l + D149l*ddpsi + D153l*ddq_1l + D154l*ddq_2l + D155l*ddq_3l + D151l*ddq_w + D150l*ddq_imu + D152l*ddq_torso + D148l*ddx + MZ_7l*ddq_4l & D165l + D158l*ddpsi + D162l*ddq_1l + D163l*ddq_2l + D164l*ddq_3l + D160l*ddq_w + D159l*ddq_imu + D161l*ddq_torso + D157l*ddx - MY_7l*ddq_4l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{8l} &= {}^{8l}A_{7l} \bar\omega_{7l} + \dot{q}_{8l} \bar{e}_{8l} 
% \nonumber \\ 
% \bar\omega_{8l} &= \left[\begin{matrix} K94l*sin(q_5l) - K92l*cos(q_5l) & - K93l - dq_5l & K94l*cos(q_5l) + K92l*sin(q_5l) &  \end{matrix}\right] 
% \nonumber \\ 
K127l = K94l*sin(q_5l) - K92l*cos(q_5l);
K128l = - K93l - dq_5l;
K129l = K94l*cos(q_5l) + K92l*sin(q_5l);
% \bar\omega_{8l} &= \left[\begin{matrix} K127l & K128l & K129l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{8l} &= \left[\begin{matrix} sin(q_5l)*(K100l*dpsi + K103l*dq_1l + K104l*dq_2l + K101l*dq_w + K101l*dq_imu + K102l*dq_torso + dq_3l*sin(q_4l)) + cos(q_5l)*(dq_4l + K61l*dpsi + K64l*dq_1l + K62l*dq_w + K62l*dq_imu + K63l*dq_torso + dq_2l*cos(q_3l)) & - dq_5l - K95l*dpsi - K98l*dq_1l - K99l*dq_2l - K96l*dq_w - K96l*dq_imu - K97l*dq_torso - dq_3l*cos(q_4l) & cos(q_5l)*(K100l*dpsi + K103l*dq_1l + K104l*dq_2l + K101l*dq_w + K101l*dq_imu + K102l*dq_torso + dq_3l*sin(q_4l)) - sin(q_5l)*(dq_4l + K61l*dpsi + K64l*dq_1l + K62l*dq_w + K62l*dq_imu + K63l*dq_torso + dq_2l*cos(q_3l)) &  \end{matrix}\right] 
% \nonumber \\ 
K130l = K61l*cos(q_5l) + K100l*sin(q_5l);
K131l = K62l*cos(q_5l) + K101l*sin(q_5l);
K132l = K63l*cos(q_5l) + K102l*sin(q_5l);
K133l = K64l*cos(q_5l) + K103l*sin(q_5l);
K134l = cos(q_3l)*cos(q_5l) + K104l*sin(q_5l);
K135l = sin(q_4l)*sin(q_5l);
K136l = K100l*cos(q_5l) - K61l*sin(q_5l);
K137l = K101l*cos(q_5l) - K62l*sin(q_5l);
K138l = K102l*cos(q_5l) - K63l*sin(q_5l);
K139l = K103l*cos(q_5l) - K64l*sin(q_5l);
K140l = K104l*cos(q_5l) - cos(q_3l)*sin(q_5l);
K141l = cos(q_5l)*sin(q_4l);
% \bar\omega_{8l} &= \left[\begin{matrix} K130l*dpsi + K133l*dq_1l + K134l*dq_2l + K135l*dq_3l + K131l*dq_w + K131l*dq_imu + K132l*dq_torso + dq_4l*cos(q_5l) & - dq_5l - K95l*dpsi - K98l*dq_1l - K99l*dq_2l - K96l*dq_w - K96l*dq_imu - K97l*dq_torso - dq_3l*cos(q_4l) & K136l*dpsi + K139l*dq_1l + K140l*dq_2l + K141l*dq_3l + K137l*dq_w + K137l*dq_imu + K138l*dq_torso - dq_4l*sin(q_5l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{8l} &= {}^{8l}A_{7l} \left(\bar{v}_{7l} + \bar\omega_{7l} \times \bar{P}_{8l}\right) 
% \nonumber \\ 
% \bar{v}_{8l} &= \left[\begin{matrix} cos(q_5l)*(K69l - K94l*L8) + sin(q_5l)*(K106l - K92l*L8) & -K105l & cos(q_5l)*(K106l - K92l*L8) - sin(q_5l)*(K69l - K94l*L8) &  \end{matrix}\right] 
% \nonumber \\ 
K142l = cos(q_5l)*(K69l - K94l*L8) + sin(q_5l)*(K106l - K92l*L8);
K143l = cos(q_5l)*(K106l - K92l*L8) - sin(q_5l)*(K69l - K94l*L8);
% \bar{v}_{8l} &= \left[\begin{matrix} K142l & -K105l & K143l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{8l} &= \left[\begin{matrix} cos(q_5l)*(K72l*dpsi - L8*(K100l*dpsi + K103l*dq_1l + K104l*dq_2l + K101l*dq_w + K101l*dq_imu + K102l*dq_torso + dq_3l*sin(q_4l)) + K76l*dq_1l + K77l*dq_2l + K74l*dq_w + K73l*dq_imu + K75l*dq_torso + K71l*dx) + sin(q_5l)*(K115l*dpsi + K119l*dq_1l + K120l*dq_2l + K117l*dq_w + K116l*dq_imu + K118l*dq_torso + K114l*dx + L8*(dq_4l + K61l*dpsi + K64l*dq_1l + K62l*dq_w + K62l*dq_imu + K63l*dq_torso + dq_2l*cos(q_3l))) & - K108l*dpsi - K112l*dq_1l - K113l*dq_2l - K110l*dq_w - K109l*dq_imu - K111l*dq_torso - K107l*dx & cos(q_5l)*(K115l*dpsi + K119l*dq_1l + K120l*dq_2l + K117l*dq_w + K116l*dq_imu + K118l*dq_torso + K114l*dx + L8*(dq_4l + K61l*dpsi + K64l*dq_1l + K62l*dq_w + K62l*dq_imu + K63l*dq_torso + dq_2l*cos(q_3l))) - sin(q_5l)*(K72l*dpsi - L8*(K100l*dpsi + K103l*dq_1l + K104l*dq_2l + K101l*dq_w + K101l*dq_imu + K102l*dq_torso + dq_3l*sin(q_4l)) + K76l*dq_1l + K77l*dq_2l + K74l*dq_w + K73l*dq_imu + K75l*dq_torso + K71l*dx) &  \end{matrix}\right] 
% \nonumber \\ 
K144l = K71l*cos(q_5l) + K114l*sin(q_5l);
K145l = cos(q_5l)*(K72l - K100l*L8) + sin(q_5l)*(K115l + K61l*L8);
K146l = cos(q_5l)*(K73l - K101l*L8) + sin(q_5l)*(K116l + K62l*L8);
K147l = cos(q_5l)*(K74l - K101l*L8) + sin(q_5l)*(K117l + K62l*L8);
K148l = cos(q_5l)*(K75l - K102l*L8) + sin(q_5l)*(K118l + K63l*L8);
K149l = cos(q_5l)*(K76l - K103l*L8) + sin(q_5l)*(K119l + K64l*L8);
K150l = sin(q_5l)*(K120l + L8*cos(q_3l)) + cos(q_5l)*(K77l - K104l*L8);
K151l = -L8*cos(q_5l)*sin(q_4l);
K152l = L8*sin(q_5l);
K153l = K114l*cos(q_5l) - K71l*sin(q_5l);
K154l = cos(q_5l)*(K115l + K61l*L8) - sin(q_5l)*(K72l - K100l*L8);
K155l = cos(q_5l)*(K116l + K62l*L8) - sin(q_5l)*(K73l - K101l*L8);
K156l = cos(q_5l)*(K117l + K62l*L8) - sin(q_5l)*(K74l - K101l*L8);
K157l = cos(q_5l)*(K118l + K63l*L8) - sin(q_5l)*(K75l - K102l*L8);
K158l = cos(q_5l)*(K119l + K64l*L8) - sin(q_5l)*(K76l - K103l*L8);
K159l = cos(q_5l)*(K120l + L8*cos(q_3l)) - sin(q_5l)*(K77l - K104l*L8);
K160l = L8*sin(q_4l)*sin(q_5l);
K161l = L8*cos(q_5l);
% \bar{v}_{8l} &= \left[\begin{matrix} K145l*dpsi + K149l*dq_1l + K150l*dq_2l + K151l*dq_3l + K152l*dq_4l + K147l*dq_w + K146l*dq_imu + K148l*dq_torso + K144l*dx & - K108l*dpsi - K112l*dq_1l - K113l*dq_2l - K110l*dq_w - K109l*dq_imu - K111l*dq_torso - K107l*dx & K154l*dpsi + K158l*dq_1l + K159l*dq_2l + K160l*dq_3l + K161l*dq_4l + K156l*dq_w + K155l*dq_imu + K157l*dq_torso + K153l*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{8l} &= {}^{8l}A_{7l} \bar\alpha_{7l} + \ddot{q}_{8l} \bar{e}_{8l} + \dot{q}_{8l} \left(\bar\omega_{8l} \times \bar{e}_{8l}\right) 
% \nonumber \\ 
% \bar\alpha_{8l} &= \left[\begin{matrix} K129l*dq_5l + cos(q_5l)*(K85l + ddq_4l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) + sin(q_5l)*(K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l)) & - K121l - ddq_5l - K95l*ddpsi - K98l*ddq_1l - K99l*ddq_2l - K96l*ddq_w - K96l*ddq_imu - K97l*ddq_torso - ddq_3l*cos(q_4l) & cos(q_5l)*(K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l)) - sin(q_5l)*(K85l + ddq_4l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) - K127l*dq_5l &  \end{matrix}\right] 
% \nonumber \\ 
K162l = K129l*dq_5l + K85l*cos(q_5l) + K122l*sin(q_5l);
K163l = K122l*cos(q_5l) - K127l*dq_5l - K85l*sin(q_5l);
% \bar\alpha_{8l} &= \left[\begin{matrix} K162l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l) & - K121l - ddq_5l - K95l*ddpsi - K98l*ddq_1l - K99l*ddq_2l - K96l*ddq_w - K96l*ddq_imu - K97l*ddq_torso - ddq_3l*cos(q_4l) & K163l + K136l*ddpsi + K139l*ddq_1l + K140l*ddq_2l + K141l*ddq_3l + K137l*ddq_w + K137l*ddq_imu + K138l*ddq_torso - ddq_4l*sin(q_5l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{8l} &= {}^{8l}A_{7l} \left(\bar{a}_{7l} + \bar\alpha_{7l} \times \bar{P}_{8l} + \bar\omega_{7l} \times \left(\bar\omega_{7l} \times \bar{P}_{8l}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{8l} &= \left[\begin{matrix} sin(q_5l)*(K124l + K115l*ddpsi + K119l*ddq_1l + K120l*ddq_2l + K117l*ddq_w + K116l*ddq_imu + K118l*ddq_torso + K114l*ddx + L8*(K85l + ddq_4l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) - K93l*K94l*L8) + cos(q_5l)*(K87l + K72l*ddpsi + K76l*ddq_1l + K77l*ddq_2l + K74l*ddq_w + K73l*ddq_imu + K75l*ddq_torso + K71l*ddx - L8*(K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l)) + K92l*K93l*L8) & - K123l - K108l*ddpsi - K112l*ddq_1l - K113l*ddq_2l - K110l*ddq_w - K109l*ddq_imu - K111l*ddq_torso - K107l*ddx - K92l^2*L8 - K94l^2*L8 & cos(q_5l)*(K124l + K115l*ddpsi + K119l*ddq_1l + K120l*ddq_2l + K117l*ddq_w + K116l*ddq_imu + K118l*ddq_torso + K114l*ddx + L8*(K85l + ddq_4l + K61l*ddpsi + K64l*ddq_1l + K62l*ddq_w + K62l*ddq_imu + K63l*ddq_torso + ddq_2l*cos(q_3l)) - K93l*K94l*L8) - sin(q_5l)*(K87l + K72l*ddpsi + K76l*ddq_1l + K77l*ddq_2l + K74l*ddq_w + K73l*ddq_imu + K75l*ddq_torso + K71l*ddx - L8*(K122l + K100l*ddpsi + K103l*ddq_1l + K104l*ddq_2l + K101l*ddq_w + K101l*ddq_imu + K102l*ddq_torso + ddq_3l*sin(q_4l)) + K92l*K93l*L8) &  \end{matrix}\right] 
% \nonumber \\ 
K164l = K87l*cos(q_5l) + K124l*sin(q_5l) - K122l*L8*cos(q_5l) + K85l*L8*sin(q_5l) + K92l*K93l*L8*cos(q_5l) - K93l*K94l*L8*sin(q_5l);
K165l = - K123l - K92l^2*L8 - K94l^2*L8;
K166l = K124l*cos(q_5l) - K87l*sin(q_5l) + K85l*L8*cos(q_5l) + K122l*L8*sin(q_5l) - K93l*K94l*L8*cos(q_5l) - K92l*K93l*L8*sin(q_5l);
% \bar{a}_{8l} &= \left[\begin{matrix} K164l + K145l*ddpsi + K149l*ddq_1l + K150l*ddq_2l + K151l*ddq_3l + K152l*ddq_4l + K147l*ddq_w + K146l*ddq_imu + K148l*ddq_torso + K144l*ddx & K165l - K108l*ddpsi - K112l*ddq_1l - K113l*ddq_2l - K110l*ddq_w - K109l*ddq_imu - K111l*ddq_torso - K107l*ddx & K166l + K154l*ddpsi + K158l*ddq_1l + K159l*ddq_2l + K160l*ddq_3l + K161l*ddq_4l + K156l*ddq_w + K155l*ddq_imu + K157l*ddq_torso + K153l*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{8l} &= {}^{8l}A_{7l} \bar{g}_{7l} 
% \nonumber \\ 
% \bar{g}_{8l} &= \left[\begin{matrix} K90l*g*cos(q_5l) + K126l*g*sin(q_5l) & -K125l*g & K126l*g*cos(q_5l) - K90l*g*sin(q_5l) &  \end{matrix}\right] 
% \nonumber \\ 
K167l = K90l*cos(q_5l) + K126l*sin(q_5l);
K168l = K126l*cos(q_5l) - K90l*sin(q_5l);
% \bar{g}_{8l} &= \left[\begin{matrix} K167l*g & -K125l*g & K168l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{8l}\bar{S}_{8l}^{\times}\bar{g}_{8l} &= \mathbf{MS}_{8l} \times \bar{g}_{8l} 
% \nonumber \\ 
% m_{8l}\bar{S}_{8l}^{\times}\bar{g}_{8l} &= \left[\begin{matrix} K168l*MY_8l*g + K125l*MZ_8l*g & K167l*MZ_8l*g - K168l*MX_8l*g & - K125l*MX_8l*g - K167l*MY_8l*g &  \end{matrix}\right] 
% \nonumber \\ 
D193l = K168l*MY_8l + K125l*MZ_8l;
D194l = K167l*MZ_8l - K168l*MX_8l;
D195l = - K125l*MX_8l - K167l*MY_8l;
% m_{8l}\bar{S}_{8l}^{\times}\bar{g}_{8l} &= \left[\begin{matrix} D193l*g & D194l*g & D195l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{8l}\bar{a}_{G(8l)} &= m_{8l}\bar{a}_{8l} + \bar\alpha_{8l} \times \mathbf{MS}_{8l} + \bar\omega_{8l} \times \left(\bar\omega_{8l} \times \mathbf{MS}_{8l}\right) 
% \nonumber \\ 
% m_{8l}\bar{a}_{G(8l)} &= \left[\begin{matrix} m_8l*(K164l + K145l*ddpsi + K149l*ddq_1l + K150l*ddq_2l + K151l*ddq_3l + K152l*ddq_4l + K147l*ddq_w + K146l*ddq_imu + K148l*ddq_torso + K144l*ddx) - MZ_8l*(K121l + ddq_5l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) - K128l*(K128l*MX_8l - K127l*MY_8l) - K129l*(K129l*MX_8l - K127l*MZ_8l) - MY_8l*(K163l + K136l*ddpsi + K139l*ddq_1l + K140l*ddq_2l + K141l*ddq_3l + K137l*ddq_w + K137l*ddq_imu + K138l*ddq_torso - ddq_4l*sin(q_5l)) & MX_8l*(K163l + K136l*ddpsi + K139l*ddq_1l + K140l*ddq_2l + K141l*ddq_3l + K137l*ddq_w + K137l*ddq_imu + K138l*ddq_torso - ddq_4l*sin(q_5l)) - MZ_8l*(K162l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) - m_8l*(K108l*ddpsi - K165l + K112l*ddq_1l + K113l*ddq_2l + K110l*ddq_w + K109l*ddq_imu + K111l*ddq_torso + K107l*ddx) + K127l*(K128l*MX_8l - K127l*MY_8l) - K129l*(K129l*MY_8l - K128l*MZ_8l) & MY_8l*(K162l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) + MX_8l*(K121l + ddq_5l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) + K127l*(K129l*MX_8l - K127l*MZ_8l) + K128l*(K129l*MY_8l - K128l*MZ_8l) + m_8l*(K166l + K154l*ddpsi + K158l*ddq_1l + K159l*ddq_2l + K160l*ddq_3l + K161l*ddq_4l + K156l*ddq_w + K155l*ddq_imu + K157l*ddq_torso + K153l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D196l = K144l*m_8l;
D197l = K145l*m_8l - K136l*MY_8l - K95l*MZ_8l;
D198l = K146l*m_8l - K137l*MY_8l - K96l*MZ_8l;
D199l = K147l*m_8l - K137l*MY_8l - K96l*MZ_8l;
D200l = K148l*m_8l - K138l*MY_8l - K97l*MZ_8l;
D201l = K149l*m_8l - K139l*MY_8l - K98l*MZ_8l;
D202l = K150l*m_8l - K140l*MY_8l - K99l*MZ_8l;
D203l = K151l*m_8l - MZ_8l*cos(q_4l) - K141l*MY_8l;
D204l = K152l*m_8l + MY_8l*sin(q_5l);
D205l = K164l*m_8l - K128l^2*MX_8l - K129l^2*MX_8l - K163l*MY_8l - K121l*MZ_8l + K127l*K128l*MY_8l + K127l*K129l*MZ_8l;
D206l = -K107l*m_8l;
D207l = K136l*MX_8l - K108l*m_8l - K130l*MZ_8l;
D208l = K137l*MX_8l - K109l*m_8l - K131l*MZ_8l;
D209l = K137l*MX_8l - K110l*m_8l - K131l*MZ_8l;
D210l = K138l*MX_8l - K111l*m_8l - K132l*MZ_8l;
D211l = K139l*MX_8l - K112l*m_8l - K133l*MZ_8l;
D212l = K140l*MX_8l - K113l*m_8l - K134l*MZ_8l;
D213l = K141l*MX_8l - K135l*MZ_8l;
D214l = - MZ_8l*cos(q_5l) - MX_8l*sin(q_5l);
D215l = K165l*m_8l - K127l^2*MY_8l - K129l^2*MY_8l + K163l*MX_8l - K162l*MZ_8l + K127l*K128l*MX_8l + K128l*K129l*MZ_8l;
D216l = K153l*m_8l;
D217l = K154l*m_8l + K95l*MX_8l + K130l*MY_8l;
D218l = K155l*m_8l + K96l*MX_8l + K131l*MY_8l;
D219l = K156l*m_8l + K96l*MX_8l + K131l*MY_8l;
D220l = K157l*m_8l + K97l*MX_8l + K132l*MY_8l;
D221l = K158l*m_8l + K98l*MX_8l + K133l*MY_8l;
D222l = K159l*m_8l + K99l*MX_8l + K134l*MY_8l;
D223l = K160l*m_8l + MX_8l*cos(q_4l) + K135l*MY_8l;
D224l = K161l*m_8l + MY_8l*cos(q_5l);
D225l = K166l*m_8l - K127l^2*MZ_8l - K128l^2*MZ_8l + K121l*MX_8l + K162l*MY_8l + K127l*K129l*MX_8l + K128l*K129l*MY_8l;
% m_{8l}\bar{a}_{G(8l)} &= \left[\begin{matrix} D205l + D197l*ddpsi + D201l*ddq_1l + D202l*ddq_2l + D203l*ddq_3l + D204l*ddq_4l + D199l*ddq_w + D198l*ddq_imu + D200l*ddq_torso + D196l*ddx - MZ_8l*ddq_5l & D215l + D207l*ddpsi + D211l*ddq_1l + D212l*ddq_2l + D213l*ddq_3l + D214l*ddq_4l + D209l*ddq_w + D208l*ddq_imu + D210l*ddq_torso + D206l*ddx & D225l + D217l*ddpsi + D221l*ddq_1l + D222l*ddq_2l + D223l*ddq_3l + D224l*ddq_4l + D219l*ddq_w + D218l*ddq_imu + D220l*ddq_torso + D216l*ddx + MX_8l*ddq_5l &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{8l} &= \mathbf{MS}_{8l} \times \bar{a}_{8l} + J_{8l}\bar{\alpha}_{8l} + \bar\omega_{8l} \times J_{8l}\bar{\omega}_{8l} 
% \nonumber \\ 
% \dot{\bar{H}}_{8l} &= \left[\begin{matrix} K128l*(K127l*XZ_8l + K128l*YZ_8l + K129l*ZZ_8l) - K129l*(K127l*XY_8l + K128l*YY_8l + K129l*YZ_8l) + MZ_8l*(K108l*ddpsi - K165l + K112l*ddq_1l + K113l*ddq_2l + K110l*ddq_w + K109l*ddq_imu + K111l*ddq_torso + K107l*ddx) + XX_8l*(K162l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) + XZ_8l*(K163l + K136l*ddpsi + K139l*ddq_1l + K140l*ddq_2l + K141l*ddq_3l + K137l*ddq_w + K137l*ddq_imu + K138l*ddq_torso - ddq_4l*sin(q_5l)) - XY_8l*(K121l + ddq_5l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) + MY_8l*(K166l + K154l*ddpsi + K158l*ddq_1l + K159l*ddq_2l + K160l*ddq_3l + K161l*ddq_4l + K156l*ddq_w + K155l*ddq_imu + K157l*ddq_torso + K153l*ddx) & K129l*(K127l*XX_8l + K128l*XY_8l + K129l*XZ_8l) - K127l*(K127l*XZ_8l + K128l*YZ_8l + K129l*ZZ_8l) + XY_8l*(K162l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) + YZ_8l*(K163l + K136l*ddpsi + K139l*ddq_1l + K140l*ddq_2l + K141l*ddq_3l + K137l*ddq_w + K137l*ddq_imu + K138l*ddq_torso - ddq_4l*sin(q_5l)) - YY_8l*(K121l + ddq_5l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) - MX_8l*(K166l + K154l*ddpsi + K158l*ddq_1l + K159l*ddq_2l + K160l*ddq_3l + K161l*ddq_4l + K156l*ddq_w + K155l*ddq_imu + K157l*ddq_torso + K153l*ddx) + MZ_8l*(K164l + K145l*ddpsi + K149l*ddq_1l + K150l*ddq_2l + K151l*ddq_3l + K152l*ddq_4l + K147l*ddq_w + K146l*ddq_imu + K148l*ddq_torso + K144l*ddx) & K127l*(K127l*XY_8l + K128l*YY_8l + K129l*YZ_8l) - K128l*(K127l*XX_8l + K128l*XY_8l + K129l*XZ_8l) - MX_8l*(K108l*ddpsi - K165l + K112l*ddq_1l + K113l*ddq_2l + K110l*ddq_w + K109l*ddq_imu + K111l*ddq_torso + K107l*ddx) + XZ_8l*(K162l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) + ZZ_8l*(K163l + K136l*ddpsi + K139l*ddq_1l + K140l*ddq_2l + K141l*ddq_3l + K137l*ddq_w + K137l*ddq_imu + K138l*ddq_torso - ddq_4l*sin(q_5l)) - YZ_8l*(K121l + ddq_5l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) - MY_8l*(K164l + K145l*ddpsi + K149l*ddq_1l + K150l*ddq_2l + K151l*ddq_3l + K152l*ddq_4l + K147l*ddq_w + K146l*ddq_imu + K148l*ddq_torso + K144l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D226l = K153l*MY_8l + K107l*MZ_8l;
D227l = K130l*XX_8l - K95l*XY_8l + K136l*XZ_8l + K154l*MY_8l + K108l*MZ_8l;
D228l = K131l*XX_8l - K96l*XY_8l + K137l*XZ_8l + K155l*MY_8l + K109l*MZ_8l;
D229l = K131l*XX_8l - K96l*XY_8l + K137l*XZ_8l + K156l*MY_8l + K110l*MZ_8l;
D230l = K132l*XX_8l - K97l*XY_8l + K138l*XZ_8l + K157l*MY_8l + K111l*MZ_8l;
D231l = K133l*XX_8l - K98l*XY_8l + K139l*XZ_8l + K158l*MY_8l + K112l*MZ_8l;
D232l = K134l*XX_8l - K99l*XY_8l + K140l*XZ_8l + K159l*MY_8l + K113l*MZ_8l;
D233l = K135l*XX_8l + K141l*XZ_8l - XY_8l*cos(q_4l) + K160l*MY_8l;
D234l = XX_8l*cos(q_5l) - XZ_8l*sin(q_5l) + K161l*MY_8l;
D235l = K162l*XX_8l - K121l*XY_8l + K163l*XZ_8l + K128l^2*YZ_8l - K129l^2*YZ_8l + K166l*MY_8l - K165l*MZ_8l - K127l*K129l*XY_8l + K127l*K128l*XZ_8l - K128l*K129l*YY_8l + K128l*K129l*ZZ_8l;
D236l = K144l*MZ_8l - K153l*MX_8l;
D237l = K130l*XY_8l - K95l*YY_8l + K136l*YZ_8l - K154l*MX_8l + K145l*MZ_8l;
D238l = K131l*XY_8l - K96l*YY_8l + K137l*YZ_8l - K155l*MX_8l + K146l*MZ_8l;
D239l = K131l*XY_8l - K96l*YY_8l + K137l*YZ_8l - K156l*MX_8l + K147l*MZ_8l;
D240l = K132l*XY_8l - K97l*YY_8l + K138l*YZ_8l - K157l*MX_8l + K148l*MZ_8l;
D241l = K133l*XY_8l - K98l*YY_8l + K139l*YZ_8l - K158l*MX_8l + K149l*MZ_8l;
D242l = K134l*XY_8l - K99l*YY_8l + K140l*YZ_8l - K159l*MX_8l + K150l*MZ_8l;
D243l = K135l*XY_8l + K141l*YZ_8l - YY_8l*cos(q_4l) - K160l*MX_8l + K151l*MZ_8l;
D244l = XY_8l*cos(q_5l) - YZ_8l*sin(q_5l) - K161l*MX_8l + K152l*MZ_8l;
D245l = K162l*XY_8l - K121l*YY_8l + K163l*YZ_8l - K127l^2*XZ_8l + K129l^2*XZ_8l - K166l*MX_8l + K164l*MZ_8l + K127l*K129l*XX_8l + K128l*K129l*XY_8l - K127l*K128l*YZ_8l - K127l*K129l*ZZ_8l;
D246l = - K107l*MX_8l - K144l*MY_8l;
D247l = K130l*XZ_8l - K95l*YZ_8l + K136l*ZZ_8l - K108l*MX_8l - K145l*MY_8l;
D248l = K131l*XZ_8l - K96l*YZ_8l + K137l*ZZ_8l - K109l*MX_8l - K146l*MY_8l;
D249l = K131l*XZ_8l - K96l*YZ_8l + K137l*ZZ_8l - K110l*MX_8l - K147l*MY_8l;
D250l = K132l*XZ_8l - K97l*YZ_8l + K138l*ZZ_8l - K111l*MX_8l - K148l*MY_8l;
D251l = K133l*XZ_8l - K98l*YZ_8l + K139l*ZZ_8l - K112l*MX_8l - K149l*MY_8l;
D252l = K134l*XZ_8l - K99l*YZ_8l + K140l*ZZ_8l - K113l*MX_8l - K150l*MY_8l;
D253l = K135l*XZ_8l + K141l*ZZ_8l - YZ_8l*cos(q_4l) - K151l*MY_8l;
D254l = XZ_8l*cos(q_5l) - ZZ_8l*sin(q_5l) - K152l*MY_8l;
D255l = K162l*XZ_8l - K121l*YZ_8l + K163l*ZZ_8l + K127l^2*XY_8l - K128l^2*XY_8l + K165l*MX_8l - K164l*MY_8l - K127l*K128l*XX_8l - K128l*K129l*XZ_8l + K127l*K128l*YY_8l + K127l*K129l*YZ_8l;
% \dot{\bar{H}}_{8l} &= \left[\begin{matrix} D205l + D197l*ddpsi + D201l*ddq_1l + D202l*ddq_2l + D203l*ddq_3l + D204l*ddq_4l + D199l*ddq_w + D198l*ddq_imu + D200l*ddq_torso + D196l*ddx - MZ_8l*ddq_5l & D215l + D207l*ddpsi + D211l*ddq_1l + D212l*ddq_2l + D213l*ddq_3l + D214l*ddq_4l + D209l*ddq_w + D208l*ddq_imu + D210l*ddq_torso + D206l*ddx & D225l + D217l*ddpsi + D221l*ddq_1l + D222l*ddq_2l + D223l*ddq_3l + D224l*ddq_4l + D219l*ddq_w + D218l*ddq_imu + D220l*ddq_torso + D216l*ddx + MX_8l*ddq_5l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{9l} &= {}^{9l}A_{8l} \bar\omega_{8l} + \dot{q}_{9l} \bar{e}_{9l} 
% \nonumber \\ 
% \bar\omega_{9l} &= \left[\begin{matrix} - K127l - dq_6l & - K128l*cos(q_6l) - K129l*sin(q_6l) & K129l*cos(q_6l) - K128l*sin(q_6l) &  \end{matrix}\right] 
% \nonumber \\ 
K169l = - K127l - dq_6l;
K170l = - K128l*cos(q_6l) - K129l*sin(q_6l);
K171l = K129l*cos(q_6l) - K128l*sin(q_6l);
% \bar\omega_{9l} &= \left[\begin{matrix} K169l & K170l & K171l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{9l} &= \left[\begin{matrix} - dq_6l - K130l*dpsi - K133l*dq_1l - K134l*dq_2l - K135l*dq_3l - K131l*dq_w - K131l*dq_imu - K132l*dq_torso - dq_4l*cos(q_5l) & cos(q_6l)*(dq_5l + K95l*dpsi + K98l*dq_1l + K99l*dq_2l + K96l*dq_w + K96l*dq_imu + K97l*dq_torso + dq_3l*cos(q_4l)) - sin(q_6l)*(K136l*dpsi + K139l*dq_1l + K140l*dq_2l + K141l*dq_3l + K137l*dq_w + K137l*dq_imu + K138l*dq_torso - dq_4l*sin(q_5l)) & cos(q_6l)*(K136l*dpsi + K139l*dq_1l + K140l*dq_2l + K141l*dq_3l + K137l*dq_w + K137l*dq_imu + K138l*dq_torso - dq_4l*sin(q_5l)) + sin(q_6l)*(dq_5l + K95l*dpsi + K98l*dq_1l + K99l*dq_2l + K96l*dq_w + K96l*dq_imu + K97l*dq_torso + dq_3l*cos(q_4l)) &  \end{matrix}\right] 
% \nonumber \\ 
K172l = K95l*cos(q_6l) - K136l*sin(q_6l);
K173l = K96l*cos(q_6l) - K137l*sin(q_6l);
K174l = K97l*cos(q_6l) - K138l*sin(q_6l);
K175l = K98l*cos(q_6l) - K139l*sin(q_6l);
K176l = K99l*cos(q_6l) - K140l*sin(q_6l);
K177l = cos(q_4l)*cos(q_6l) - K141l*sin(q_6l);
K178l = sin(q_5l)*sin(q_6l);
K179l = K136l*cos(q_6l) + K95l*sin(q_6l);
K180l = K137l*cos(q_6l) + K96l*sin(q_6l);
K181l = K138l*cos(q_6l) + K97l*sin(q_6l);
K182l = K139l*cos(q_6l) + K98l*sin(q_6l);
K183l = K140l*cos(q_6l) + K99l*sin(q_6l);
K184l = cos(q_4l)*sin(q_6l) + K141l*cos(q_6l);
K185l = -cos(q_6l)*sin(q_5l);
% \bar\omega_{9l} &= \left[\begin{matrix} - dq_6l - K130l*dpsi - K133l*dq_1l - K134l*dq_2l - K135l*dq_3l - K131l*dq_w - K131l*dq_imu - K132l*dq_torso - dq_4l*cos(q_5l) & K172l*dpsi + K175l*dq_1l + K176l*dq_2l + K177l*dq_3l + K178l*dq_4l + K173l*dq_w + K173l*dq_imu + K174l*dq_torso + dq_5l*cos(q_6l) & K179l*dpsi + K182l*dq_1l + K183l*dq_2l + K184l*dq_3l + K185l*dq_4l + K180l*dq_w + K180l*dq_imu + K181l*dq_torso + dq_5l*sin(q_6l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{9l} &= {}^{9l}A_{8l} \left(\bar{v}_{8l} + \bar\omega_{8l} \times \bar{P}_{9l}\right) 
% \nonumber \\ 
% \bar{v}_{9l} &= \left[\begin{matrix} -K142l & K105l*cos(q_6l) - K143l*sin(q_6l) & K143l*cos(q_6l) + K105l*sin(q_6l) &  \end{matrix}\right] 
% \nonumber \\ 
K186l = K105l*cos(q_6l) - K143l*sin(q_6l);
K187l = K143l*cos(q_6l) + K105l*sin(q_6l);
% \bar{v}_{9l} &= \left[\begin{matrix} -K142l & K186l & K187l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{9l} &= \left[\begin{matrix} - K145l*dpsi - K149l*dq_1l - K150l*dq_2l - K151l*dq_3l - K152l*dq_4l - K147l*dq_w - K146l*dq_imu - K148l*dq_torso - K144l*dx & cos(q_6l)*(K108l*dpsi + K112l*dq_1l + K113l*dq_2l + K110l*dq_w + K109l*dq_imu + K111l*dq_torso + K107l*dx) - sin(q_6l)*(K154l*dpsi + K158l*dq_1l + K159l*dq_2l + K160l*dq_3l + K161l*dq_4l + K156l*dq_w + K155l*dq_imu + K157l*dq_torso + K153l*dx) & sin(q_6l)*(K108l*dpsi + K112l*dq_1l + K113l*dq_2l + K110l*dq_w + K109l*dq_imu + K111l*dq_torso + K107l*dx) + cos(q_6l)*(K154l*dpsi + K158l*dq_1l + K159l*dq_2l + K160l*dq_3l + K161l*dq_4l + K156l*dq_w + K155l*dq_imu + K157l*dq_torso + K153l*dx) &  \end{matrix}\right] 
% \nonumber \\ 
K188l = K107l*cos(q_6l) - K153l*sin(q_6l);
K189l = K108l*cos(q_6l) - K154l*sin(q_6l);
K190l = K109l*cos(q_6l) - K155l*sin(q_6l);
K191l = K110l*cos(q_6l) - K156l*sin(q_6l);
K192l = K111l*cos(q_6l) - K157l*sin(q_6l);
K193l = K112l*cos(q_6l) - K158l*sin(q_6l);
K194l = K113l*cos(q_6l) - K159l*sin(q_6l);
K195l = -K160l*sin(q_6l);
K196l = -K161l*sin(q_6l);
K197l = K153l*cos(q_6l) + K107l*sin(q_6l);
K198l = K154l*cos(q_6l) + K108l*sin(q_6l);
K199l = K155l*cos(q_6l) + K109l*sin(q_6l);
K200l = K156l*cos(q_6l) + K110l*sin(q_6l);
K201l = K157l*cos(q_6l) + K111l*sin(q_6l);
K202l = K158l*cos(q_6l) + K112l*sin(q_6l);
K203l = K159l*cos(q_6l) + K113l*sin(q_6l);
K204l = K160l*cos(q_6l);
K205l = K161l*cos(q_6l);
% \bar{v}_{9l} &= \left[\begin{matrix} - K145l*dpsi - K149l*dq_1l - K150l*dq_2l - K151l*dq_3l - K152l*dq_4l - K147l*dq_w - K146l*dq_imu - K148l*dq_torso - K144l*dx & K189l*dpsi + K193l*dq_1l + K194l*dq_2l + K195l*dq_3l + K196l*dq_4l + K191l*dq_w + K190l*dq_imu + K192l*dq_torso + K188l*dx & K198l*dpsi + K202l*dq_1l + K203l*dq_2l + K204l*dq_3l + K205l*dq_4l + K200l*dq_w + K199l*dq_imu + K201l*dq_torso + K197l*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{9l} &= {}^{9l}A_{8l} \bar\alpha_{8l} + \ddot{q}_{9l} \bar{e}_{9l} + \dot{q}_{9l} \left(\bar\omega_{9l} \times \bar{e}_{9l}\right) 
% \nonumber \\ 
% \bar\alpha_{9l} &= \left[\begin{matrix} - K162l - ddq_6l - K130l*ddpsi - K133l*ddq_1l - K134l*ddq_2l - K135l*ddq_3l - K131l*ddq_w - K131l*ddq_imu - K132l*ddq_torso - ddq_4l*cos(q_5l) & cos(q_6l)*(K121l + ddq_5l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) - K171l*dq_6l - sin(q_6l)*(K163l + K136l*ddpsi + K139l*ddq_1l + K140l*ddq_2l + K141l*ddq_3l + K137l*ddq_w + K137l*ddq_imu + K138l*ddq_torso - ddq_4l*sin(q_5l)) & K170l*dq_6l + sin(q_6l)*(K121l + ddq_5l + K95l*ddpsi + K98l*ddq_1l + K99l*ddq_2l + K96l*ddq_w + K96l*ddq_imu + K97l*ddq_torso + ddq_3l*cos(q_4l)) + cos(q_6l)*(K163l + K136l*ddpsi + K139l*ddq_1l + K140l*ddq_2l + K141l*ddq_3l + K137l*ddq_w + K137l*ddq_imu + K138l*ddq_torso - ddq_4l*sin(q_5l)) &  \end{matrix}\right] 
% \nonumber \\ 
K206l = K121l*cos(q_6l) - K171l*dq_6l - K163l*sin(q_6l);
K207l = K170l*dq_6l + K163l*cos(q_6l) + K121l*sin(q_6l);
% \bar\alpha_{9l} &= \left[\begin{matrix} - K162l - ddq_6l - K130l*ddpsi - K133l*ddq_1l - K134l*ddq_2l - K135l*ddq_3l - K131l*ddq_w - K131l*ddq_imu - K132l*ddq_torso - ddq_4l*cos(q_5l) & K206l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l) & K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{9l} &= {}^{9l}A_{8l} \left(\bar{a}_{8l} + \bar\alpha_{8l} \times \bar{P}_{9l} + \bar\omega_{8l} \times \left(\bar\omega_{8l} \times \bar{P}_{9l}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{9l} &= \left[\begin{matrix} - K164l - K145l*ddpsi - K149l*ddq_1l - K150l*ddq_2l - K151l*ddq_3l - K152l*ddq_4l - K147l*ddq_w - K146l*ddq_imu - K148l*ddq_torso - K144l*ddx & cos(q_6l)*(K108l*ddpsi - K165l + K112l*ddq_1l + K113l*ddq_2l + K110l*ddq_w + K109l*ddq_imu + K111l*ddq_torso + K107l*ddx) - sin(q_6l)*(K166l + K154l*ddpsi + K158l*ddq_1l + K159l*ddq_2l + K160l*ddq_3l + K161l*ddq_4l + K156l*ddq_w + K155l*ddq_imu + K157l*ddq_torso + K153l*ddx) & cos(q_6l)*(K166l + K154l*ddpsi + K158l*ddq_1l + K159l*ddq_2l + K160l*ddq_3l + K161l*ddq_4l + K156l*ddq_w + K155l*ddq_imu + K157l*ddq_torso + K153l*ddx) + sin(q_6l)*(K108l*ddpsi - K165l + K112l*ddq_1l + K113l*ddq_2l + K110l*ddq_w + K109l*ddq_imu + K111l*ddq_torso + K107l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
K208l = - K165l*cos(q_6l) - K166l*sin(q_6l);
K209l = K166l*cos(q_6l) - K165l*sin(q_6l);
% \bar{a}_{9l} &= \left[\begin{matrix} - K164l - K145l*ddpsi - K149l*ddq_1l - K150l*ddq_2l - K151l*ddq_3l - K152l*ddq_4l - K147l*ddq_w - K146l*ddq_imu - K148l*ddq_torso - K144l*ddx & K208l + K189l*ddpsi + K193l*ddq_1l + K194l*ddq_2l + K195l*ddq_3l + K196l*ddq_4l + K191l*ddq_w + K190l*ddq_imu + K192l*ddq_torso + K188l*ddx & K209l + K198l*ddpsi + K202l*ddq_1l + K203l*ddq_2l + K204l*ddq_3l + K205l*ddq_4l + K200l*ddq_w + K199l*ddq_imu + K201l*ddq_torso + K197l*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{9l} &= {}^{9l}A_{8l} \bar{g}_{8l} 
% \nonumber \\ 
% \bar{g}_{9l} &= \left[\begin{matrix} -K167l*g & K125l*g*cos(q_6l) - K168l*g*sin(q_6l) & K168l*g*cos(q_6l) + K125l*g*sin(q_6l) &  \end{matrix}\right] 
% \nonumber \\ 
K210l = K125l*cos(q_6l) - K168l*sin(q_6l);
K211l = K168l*cos(q_6l) + K125l*sin(q_6l);
% \bar{g}_{9l} &= \left[\begin{matrix} -K167l*g & K210l*g & K211l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{9l}\bar{S}_{9l}^{\times}\bar{g}_{9l} &= \mathbf{MS}_{9l} \times \bar{g}_{9l} 
% \nonumber \\ 
% m_{9l}\bar{S}_{9l}^{\times}\bar{g}_{9l} &= \left[\begin{matrix} K211l*MY_9l*g - K210l*MZ_9l*g & - K211l*MX_9l*g - K167l*MZ_9l*g & K210l*MX_9l*g + K167l*MY_9l*g &  \end{matrix}\right] 
% \nonumber \\ 
D256l = K211l*MY_9l - K210l*MZ_9l;
D257l = - K211l*MX_9l - K167l*MZ_9l;
D258l = K210l*MX_9l + K167l*MY_9l;
% m_{9l}\bar{S}_{9l}^{\times}\bar{g}_{9l} &= \left[\begin{matrix} D256l*g & D257l*g & D258l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{9l}\bar{a}_{G(9l)} &= m_{9l}\bar{a}_{9l} + \bar\alpha_{9l} \times \mathbf{MS}_{9l} + \bar\omega_{9l} \times \left(\bar\omega_{9l} \times \mathbf{MS}_{9l}\right) 
% \nonumber \\ 
% m_{9l}\bar{a}_{G(9l)} &= \left[\begin{matrix} MZ_9l*(K206l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) - MY_9l*(K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l)) - K170l*(K170l*MX_9l - K169l*MY_9l) - K171l*(K171l*MX_9l - K169l*MZ_9l) - m_9l*(K164l + K145l*ddpsi + K149l*ddq_1l + K150l*ddq_2l + K151l*ddq_3l + K152l*ddq_4l + K147l*ddq_w + K146l*ddq_imu + K148l*ddq_torso + K144l*ddx) & MX_9l*(K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l)) + MZ_9l*(K162l + ddq_6l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) + K169l*(K170l*MX_9l - K169l*MY_9l) - K171l*(K171l*MY_9l - K170l*MZ_9l) + m_9l*(K208l + K189l*ddpsi + K193l*ddq_1l + K194l*ddq_2l + K195l*ddq_3l + K196l*ddq_4l + K191l*ddq_w + K190l*ddq_imu + K192l*ddq_torso + K188l*ddx) & K169l*(K171l*MX_9l - K169l*MZ_9l) - MY_9l*(K162l + ddq_6l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) - MX_9l*(K206l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) + K170l*(K171l*MY_9l - K170l*MZ_9l) + m_9l*(K209l + K198l*ddpsi + K202l*ddq_1l + K203l*ddq_2l + K204l*ddq_3l + K205l*ddq_4l + K200l*ddq_w + K199l*ddq_imu + K201l*ddq_torso + K197l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D259l = -K144l*m_9l;
D260l = K172l*MZ_9l - K179l*MY_9l - K145l*m_9l;
D261l = K173l*MZ_9l - K180l*MY_9l - K146l*m_9l;
D262l = K173l*MZ_9l - K180l*MY_9l - K147l*m_9l;
D263l = K174l*MZ_9l - K181l*MY_9l - K148l*m_9l;
D264l = K175l*MZ_9l - K182l*MY_9l - K149l*m_9l;
D265l = K176l*MZ_9l - K183l*MY_9l - K150l*m_9l;
D266l = K177l*MZ_9l - K184l*MY_9l - K151l*m_9l;
D267l = K178l*MZ_9l - K185l*MY_9l - K152l*m_9l;
D268l = MZ_9l*cos(q_6l) - MY_9l*sin(q_6l);
D269l = K206l*MZ_9l - K170l^2*MX_9l - K171l^2*MX_9l - K207l*MY_9l - K164l*m_9l + K169l*K170l*MY_9l + K169l*K171l*MZ_9l;
D270l = K188l*m_9l;
D271l = K189l*m_9l + K179l*MX_9l + K130l*MZ_9l;
D272l = K190l*m_9l + K180l*MX_9l + K131l*MZ_9l;
D273l = K191l*m_9l + K180l*MX_9l + K131l*MZ_9l;
D274l = K192l*m_9l + K181l*MX_9l + K132l*MZ_9l;
D275l = K193l*m_9l + K182l*MX_9l + K133l*MZ_9l;
D276l = K194l*m_9l + K183l*MX_9l + K134l*MZ_9l;
D277l = K195l*m_9l + K184l*MX_9l + K135l*MZ_9l;
D278l = K196l*m_9l + MZ_9l*cos(q_5l) + K185l*MX_9l;
D279l = MX_9l*sin(q_6l);
D280l = K208l*m_9l - K169l^2*MY_9l - K171l^2*MY_9l + K207l*MX_9l + K162l*MZ_9l + K169l*K170l*MX_9l + K170l*K171l*MZ_9l;
D281l = K197l*m_9l;
D282l = K198l*m_9l - K172l*MX_9l - K130l*MY_9l;
D283l = K199l*m_9l - K173l*MX_9l - K131l*MY_9l;
D284l = K200l*m_9l - K173l*MX_9l - K131l*MY_9l;
D285l = K201l*m_9l - K174l*MX_9l - K132l*MY_9l;
D286l = K202l*m_9l - K175l*MX_9l - K133l*MY_9l;
D287l = K203l*m_9l - K176l*MX_9l - K134l*MY_9l;
D288l = K204l*m_9l - K177l*MX_9l - K135l*MY_9l;
D289l = K205l*m_9l - MY_9l*cos(q_5l) - K178l*MX_9l;
D290l = -MX_9l*cos(q_6l);
D291l = K209l*m_9l - K169l^2*MZ_9l - K170l^2*MZ_9l - K206l*MX_9l - K162l*MY_9l + K169l*K171l*MX_9l + K170l*K171l*MY_9l;
% m_{9l}\bar{a}_{G(9l)} &= \left[\begin{matrix} D269l + D260l*ddpsi + D264l*ddq_1l + D265l*ddq_2l + D266l*ddq_3l + D267l*ddq_4l + D262l*ddq_w + D268l*ddq_5l + D261l*ddq_imu + D263l*ddq_torso + D259l*ddx & D280l + D271l*ddpsi + D275l*ddq_1l + D276l*ddq_2l + D277l*ddq_3l + D278l*ddq_4l + D273l*ddq_w + D279l*ddq_5l + D272l*ddq_imu + D274l*ddq_torso + D270l*ddx + MZ_9l*ddq_6l & D291l + D282l*ddpsi + D286l*ddq_1l + D287l*ddq_2l + D288l*ddq_3l + D289l*ddq_4l + D284l*ddq_w + D290l*ddq_5l + D283l*ddq_imu + D285l*ddq_torso + D281l*ddx - MY_9l*ddq_6l &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{9l} &= \mathbf{MS}_{9l} \times \bar{a}_{9l} + J_{9l}\bar{\alpha}_{9l} + \bar\omega_{9l} \times J_{9l}\bar{\omega}_{9l} 
% \nonumber \\ 
% \dot{\bar{H}}_{9l} &= \left[\begin{matrix} K170l*(K169l*XZ_9l + K170l*YZ_9l + K171l*ZZ_9l) - K171l*(K169l*XY_9l + K170l*YY_9l + K171l*YZ_9l) + XY_9l*(K206l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) + XZ_9l*(K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l)) - XX_9l*(K162l + ddq_6l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) + MY_9l*(K209l + K198l*ddpsi + K202l*ddq_1l + K203l*ddq_2l + K204l*ddq_3l + K205l*ddq_4l + K200l*ddq_w + K199l*ddq_imu + K201l*ddq_torso + K197l*ddx) - MZ_9l*(K208l + K189l*ddpsi + K193l*ddq_1l + K194l*ddq_2l + K195l*ddq_3l + K196l*ddq_4l + K191l*ddq_w + K190l*ddq_imu + K192l*ddq_torso + K188l*ddx) & K171l*(K169l*XX_9l + K170l*XY_9l + K171l*XZ_9l) - K169l*(K169l*XZ_9l + K170l*YZ_9l + K171l*ZZ_9l) + YY_9l*(K206l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) + YZ_9l*(K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l)) - XY_9l*(K162l + ddq_6l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) - MX_9l*(K209l + K198l*ddpsi + K202l*ddq_1l + K203l*ddq_2l + K204l*ddq_3l + K205l*ddq_4l + K200l*ddq_w + K199l*ddq_imu + K201l*ddq_torso + K197l*ddx) - MZ_9l*(K164l + K145l*ddpsi + K149l*ddq_1l + K150l*ddq_2l + K151l*ddq_3l + K152l*ddq_4l + K147l*ddq_w + K146l*ddq_imu + K148l*ddq_torso + K144l*ddx) & K169l*(K169l*XY_9l + K170l*YY_9l + K171l*YZ_9l) - K170l*(K169l*XX_9l + K170l*XY_9l + K171l*XZ_9l) + YZ_9l*(K206l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) + ZZ_9l*(K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l)) - XZ_9l*(K162l + ddq_6l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) + MX_9l*(K208l + K189l*ddpsi + K193l*ddq_1l + K194l*ddq_2l + K195l*ddq_3l + K196l*ddq_4l + K191l*ddq_w + K190l*ddq_imu + K192l*ddq_torso + K188l*ddx) + MY_9l*(K164l + K145l*ddpsi + K149l*ddq_1l + K150l*ddq_2l + K151l*ddq_3l + K152l*ddq_4l + K147l*ddq_w + K146l*ddq_imu + K148l*ddq_torso + K144l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D292l = K197l*MY_9l - K188l*MZ_9l;
D293l = K172l*XY_9l - K130l*XX_9l + K179l*XZ_9l + K198l*MY_9l - K189l*MZ_9l;
D294l = K173l*XY_9l - K131l*XX_9l + K180l*XZ_9l + K199l*MY_9l - K190l*MZ_9l;
D295l = K173l*XY_9l - K131l*XX_9l + K180l*XZ_9l + K200l*MY_9l - K191l*MZ_9l;
D296l = K174l*XY_9l - K132l*XX_9l + K181l*XZ_9l + K201l*MY_9l - K192l*MZ_9l;
D297l = K175l*XY_9l - K133l*XX_9l + K182l*XZ_9l + K202l*MY_9l - K193l*MZ_9l;
D298l = K176l*XY_9l - K134l*XX_9l + K183l*XZ_9l + K203l*MY_9l - K194l*MZ_9l;
D299l = K177l*XY_9l - K135l*XX_9l + K184l*XZ_9l + K204l*MY_9l - K195l*MZ_9l;
D300l = K178l*XY_9l + K185l*XZ_9l - XX_9l*cos(q_5l) + K205l*MY_9l - K196l*MZ_9l;
D301l = XY_9l*cos(q_6l) + XZ_9l*sin(q_6l);
D302l = K206l*XY_9l - K162l*XX_9l + K207l*XZ_9l + K170l^2*YZ_9l - K171l^2*YZ_9l + K209l*MY_9l - K208l*MZ_9l - K169l*K171l*XY_9l + K169l*K170l*XZ_9l - K170l*K171l*YY_9l + K170l*K171l*ZZ_9l;
D303l = - K197l*MX_9l - K144l*MZ_9l;
D304l = K172l*YY_9l - K130l*XY_9l + K179l*YZ_9l - K198l*MX_9l - K145l*MZ_9l;
D305l = K173l*YY_9l - K131l*XY_9l + K180l*YZ_9l - K199l*MX_9l - K146l*MZ_9l;
D306l = K173l*YY_9l - K131l*XY_9l + K180l*YZ_9l - K200l*MX_9l - K147l*MZ_9l;
D307l = K174l*YY_9l - K132l*XY_9l + K181l*YZ_9l - K201l*MX_9l - K148l*MZ_9l;
D308l = K175l*YY_9l - K133l*XY_9l + K182l*YZ_9l - K202l*MX_9l - K149l*MZ_9l;
D309l = K176l*YY_9l - K134l*XY_9l + K183l*YZ_9l - K203l*MX_9l - K150l*MZ_9l;
D310l = K177l*YY_9l - K135l*XY_9l + K184l*YZ_9l - K204l*MX_9l - K151l*MZ_9l;
D311l = K178l*YY_9l + K185l*YZ_9l - XY_9l*cos(q_5l) - K205l*MX_9l - K152l*MZ_9l;
D312l = YY_9l*cos(q_6l) + YZ_9l*sin(q_6l);
D313l = K206l*YY_9l - K162l*XY_9l + K207l*YZ_9l - K169l^2*XZ_9l + K171l^2*XZ_9l - K209l*MX_9l - K164l*MZ_9l + K169l*K171l*XX_9l + K170l*K171l*XY_9l - K169l*K170l*YZ_9l - K169l*K171l*ZZ_9l;
D314l = K188l*MX_9l + K144l*MY_9l;
D315l = K172l*YZ_9l - K130l*XZ_9l + K179l*ZZ_9l + K189l*MX_9l + K145l*MY_9l;
D316l = K173l*YZ_9l - K131l*XZ_9l + K180l*ZZ_9l + K190l*MX_9l + K146l*MY_9l;
D317l = K173l*YZ_9l - K131l*XZ_9l + K180l*ZZ_9l + K191l*MX_9l + K147l*MY_9l;
D318l = K174l*YZ_9l - K132l*XZ_9l + K181l*ZZ_9l + K192l*MX_9l + K148l*MY_9l;
D319l = K175l*YZ_9l - K133l*XZ_9l + K182l*ZZ_9l + K193l*MX_9l + K149l*MY_9l;
D320l = K176l*YZ_9l - K134l*XZ_9l + K183l*ZZ_9l + K194l*MX_9l + K150l*MY_9l;
D321l = K177l*YZ_9l - K135l*XZ_9l + K184l*ZZ_9l + K195l*MX_9l + K151l*MY_9l;
D322l = K178l*YZ_9l + K185l*ZZ_9l - XZ_9l*cos(q_5l) + K196l*MX_9l + K152l*MY_9l;
D323l = YZ_9l*cos(q_6l) + ZZ_9l*sin(q_6l);
D324l = K206l*YZ_9l - K162l*XZ_9l + K207l*ZZ_9l + K169l^2*XY_9l - K170l^2*XY_9l + K208l*MX_9l + K164l*MY_9l - K169l*K170l*XX_9l - K170l*K171l*XZ_9l + K169l*K170l*YY_9l + K169l*K171l*YZ_9l;
% \dot{\bar{H}}_{9l} &= \left[\begin{matrix} D269l + D260l*ddpsi + D264l*ddq_1l + D265l*ddq_2l + D266l*ddq_3l + D267l*ddq_4l + D262l*ddq_w + D268l*ddq_5l + D261l*ddq_imu + D263l*ddq_torso + D259l*ddx & D280l + D271l*ddpsi + D275l*ddq_1l + D276l*ddq_2l + D277l*ddq_3l + D278l*ddq_4l + D273l*ddq_w + D279l*ddq_5l + D272l*ddq_imu + D274l*ddq_torso + D270l*ddx + MZ_9l*ddq_6l & D291l + D282l*ddpsi + D286l*ddq_1l + D287l*ddq_2l + D288l*ddq_3l + D289l*ddq_4l + D284l*ddq_w + D290l*ddq_5l + D283l*ddq_imu + D285l*ddq_torso + D281l*ddx - MY_9l*ddq_6l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{10l} &= {}^{10l}A_{9l} \bar\omega_{9l} + \dot{q}_{10l} \bar{e}_{10l} 
% \nonumber \\ 
% \bar\omega_{10l} &= \left[\begin{matrix} K171l*sin(q_7l) - K169l*cos(q_7l) & - K171l*cos(q_7l) - K169l*sin(q_7l) & - K170l - dq_7l &  \end{matrix}\right] 
% \nonumber \\ 
K212l = K171l*sin(q_7l) - K169l*cos(q_7l);
K213l = - K171l*cos(q_7l) - K169l*sin(q_7l);
K214l = - K170l - dq_7l;
% \bar\omega_{10l} &= \left[\begin{matrix} K212l & K213l & K214l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{10l} &= \left[\begin{matrix} sin(q_7l)*(K179l*dpsi + K182l*dq_1l + K183l*dq_2l + K184l*dq_3l + K185l*dq_4l + K180l*dq_w + K180l*dq_imu + K181l*dq_torso + dq_5l*sin(q_6l)) + cos(q_7l)*(dq_6l + K130l*dpsi + K133l*dq_1l + K134l*dq_2l + K135l*dq_3l + K131l*dq_w + K131l*dq_imu + K132l*dq_torso + dq_4l*cos(q_5l)) & sin(q_7l)*(dq_6l + K130l*dpsi + K133l*dq_1l + K134l*dq_2l + K135l*dq_3l + K131l*dq_w + K131l*dq_imu + K132l*dq_torso + dq_4l*cos(q_5l)) - cos(q_7l)*(K179l*dpsi + K182l*dq_1l + K183l*dq_2l + K184l*dq_3l + K185l*dq_4l + K180l*dq_w + K180l*dq_imu + K181l*dq_torso + dq_5l*sin(q_6l)) & - dq_7l - K172l*dpsi - K175l*dq_1l - K176l*dq_2l - K177l*dq_3l - K178l*dq_4l - K173l*dq_w - K173l*dq_imu - K174l*dq_torso - dq_5l*cos(q_6l) &  \end{matrix}\right] 
% \nonumber \\ 
K215l = K130l*cos(q_7l) + K179l*sin(q_7l);
K216l = K131l*cos(q_7l) + K180l*sin(q_7l);
K217l = K132l*cos(q_7l) + K181l*sin(q_7l);
K218l = K133l*cos(q_7l) + K182l*sin(q_7l);
K219l = K134l*cos(q_7l) + K183l*sin(q_7l);
K220l = K135l*cos(q_7l) + K184l*sin(q_7l);
K221l = cos(q_5l)*cos(q_7l) + K185l*sin(q_7l);
K222l = sin(q_6l)*sin(q_7l);
K223l = K130l*sin(q_7l) - K179l*cos(q_7l);
K224l = K131l*sin(q_7l) - K180l*cos(q_7l);
K225l = K132l*sin(q_7l) - K181l*cos(q_7l);
K226l = K133l*sin(q_7l) - K182l*cos(q_7l);
K227l = K134l*sin(q_7l) - K183l*cos(q_7l);
K228l = K135l*sin(q_7l) - K184l*cos(q_7l);
K229l = cos(q_5l)*sin(q_7l) - K185l*cos(q_7l);
K230l = -cos(q_7l)*sin(q_6l);
% \bar\omega_{10l} &= \left[\begin{matrix} K215l*dpsi + K218l*dq_1l + K219l*dq_2l + K220l*dq_3l + K221l*dq_4l + K216l*dq_w + K222l*dq_5l + K216l*dq_imu + K217l*dq_torso + dq_6l*cos(q_7l) & K223l*dpsi + K226l*dq_1l + K227l*dq_2l + K228l*dq_3l + K229l*dq_4l + K224l*dq_w + K230l*dq_5l + K224l*dq_imu + K225l*dq_torso + dq_6l*sin(q_7l) & - dq_7l - K172l*dpsi - K175l*dq_1l - K176l*dq_2l - K177l*dq_3l - K178l*dq_4l - K173l*dq_w - K173l*dq_imu - K174l*dq_torso - dq_5l*cos(q_6l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{10l} &= {}^{10l}A_{9l} \left(\bar{v}_{9l} + \bar\omega_{9l} \times \bar{P}_{10l}\right) 
% \nonumber \\ 
% \bar{v}_{10l} &= \left[\begin{matrix} cos(q_7l)*(K142l - K171l*L9) + sin(q_7l)*(K187l - K169l*L9) & sin(q_7l)*(K142l - K171l*L9) - cos(q_7l)*(K187l - K169l*L9) & -K186l &  \end{matrix}\right] 
% \nonumber \\ 
K231l = cos(q_7l)*(K142l - K171l*L9) + sin(q_7l)*(K187l - K169l*L9);
K232l = sin(q_7l)*(K142l - K171l*L9) - cos(q_7l)*(K187l - K169l*L9);
% \bar{v}_{10l} &= \left[\begin{matrix} K231l & K232l & -K186l &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{10l} &= \left[\begin{matrix} cos(q_7l)*(K145l*dpsi + K149l*dq_1l + K150l*dq_2l + K151l*dq_3l + K152l*dq_4l + K147l*dq_w + K146l*dq_imu + K148l*dq_torso + K144l*dx - L9*(K179l*dpsi + K182l*dq_1l + K183l*dq_2l + K184l*dq_3l + K185l*dq_4l + K180l*dq_w + K180l*dq_imu + K181l*dq_torso + dq_5l*sin(q_6l))) + sin(q_7l)*(K198l*dpsi + K202l*dq_1l + K203l*dq_2l + K204l*dq_3l + K205l*dq_4l + K200l*dq_w + K199l*dq_imu + K201l*dq_torso + K197l*dx + L9*(dq_6l + K130l*dpsi + K133l*dq_1l + K134l*dq_2l + K135l*dq_3l + K131l*dq_w + K131l*dq_imu + K132l*dq_torso + dq_4l*cos(q_5l))) & sin(q_7l)*(K145l*dpsi + K149l*dq_1l + K150l*dq_2l + K151l*dq_3l + K152l*dq_4l + K147l*dq_w + K146l*dq_imu + K148l*dq_torso + K144l*dx - L9*(K179l*dpsi + K182l*dq_1l + K183l*dq_2l + K184l*dq_3l + K185l*dq_4l + K180l*dq_w + K180l*dq_imu + K181l*dq_torso + dq_5l*sin(q_6l))) - cos(q_7l)*(K198l*dpsi + K202l*dq_1l + K203l*dq_2l + K204l*dq_3l + K205l*dq_4l + K200l*dq_w + K199l*dq_imu + K201l*dq_torso + K197l*dx + L9*(dq_6l + K130l*dpsi + K133l*dq_1l + K134l*dq_2l + K135l*dq_3l + K131l*dq_w + K131l*dq_imu + K132l*dq_torso + dq_4l*cos(q_5l))) & - K189l*dpsi - K193l*dq_1l - K194l*dq_2l - K195l*dq_3l - K196l*dq_4l - K191l*dq_w - K190l*dq_imu - K192l*dq_torso - K188l*dx &  \end{matrix}\right] 
% \nonumber \\ 
K233l = K144l*cos(q_7l) + K197l*sin(q_7l);
K234l = cos(q_7l)*(K145l - K179l*L9) + sin(q_7l)*(K198l + K130l*L9);
K235l = cos(q_7l)*(K146l - K180l*L9) + sin(q_7l)*(K199l + K131l*L9);
K236l = cos(q_7l)*(K147l - K180l*L9) + sin(q_7l)*(K200l + K131l*L9);
K237l = cos(q_7l)*(K148l - K181l*L9) + sin(q_7l)*(K201l + K132l*L9);
K238l = cos(q_7l)*(K149l - K182l*L9) + sin(q_7l)*(K202l + K133l*L9);
K239l = cos(q_7l)*(K150l - K183l*L9) + sin(q_7l)*(K203l + K134l*L9);
K240l = cos(q_7l)*(K151l - K184l*L9) + sin(q_7l)*(K204l + K135l*L9);
K241l = sin(q_7l)*(K205l + L9*cos(q_5l)) + cos(q_7l)*(K152l - K185l*L9);
K242l = -L9*cos(q_7l)*sin(q_6l);
K243l = L9*sin(q_7l);
K244l = K144l*sin(q_7l) - K197l*cos(q_7l);
K245l = sin(q_7l)*(K145l - K179l*L9) - cos(q_7l)*(K198l + K130l*L9);
K246l = sin(q_7l)*(K146l - K180l*L9) - cos(q_7l)*(K199l + K131l*L9);
K247l = sin(q_7l)*(K147l - K180l*L9) - cos(q_7l)*(K200l + K131l*L9);
K248l = sin(q_7l)*(K148l - K181l*L9) - cos(q_7l)*(K201l + K132l*L9);
K249l = sin(q_7l)*(K149l - K182l*L9) - cos(q_7l)*(K202l + K133l*L9);
K250l = sin(q_7l)*(K150l - K183l*L9) - cos(q_7l)*(K203l + K134l*L9);
K251l = sin(q_7l)*(K151l - K184l*L9) - cos(q_7l)*(K204l + K135l*L9);
K252l = sin(q_7l)*(K152l - K185l*L9) - cos(q_7l)*(K205l + L9*cos(q_5l));
K253l = -L9*sin(q_6l)*sin(q_7l);
K254l = -L9*cos(q_7l);
% \bar{v}_{10l} &= \left[\begin{matrix} K234l*dpsi + K238l*dq_1l + K239l*dq_2l + K240l*dq_3l + K241l*dq_4l + K236l*dq_w + K242l*dq_5l + K243l*dq_6l + K235l*dq_imu + K237l*dq_torso + K233l*dx & K245l*dpsi + K249l*dq_1l + K250l*dq_2l + K251l*dq_3l + K252l*dq_4l + K247l*dq_w + K253l*dq_5l + K254l*dq_6l + K246l*dq_imu + K248l*dq_torso + K244l*dx & - K189l*dpsi - K193l*dq_1l - K194l*dq_2l - K195l*dq_3l - K196l*dq_4l - K191l*dq_w - K190l*dq_imu - K192l*dq_torso - K188l*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{10l} &= {}^{10l}A_{9l} \bar\alpha_{9l} + \ddot{q}_{10l} \bar{e}_{10l} + \dot{q}_{10l} \left(\bar\omega_{10l} \times \bar{e}_{10l}\right) 
% \nonumber \\ 
% \bar\alpha_{10l} &= \left[\begin{matrix} sin(q_7l)*(K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l)) - K213l*dq_7l + cos(q_7l)*(K162l + ddq_6l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) & K212l*dq_7l + sin(q_7l)*(K162l + ddq_6l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) - cos(q_7l)*(K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l)) & - K206l - ddq_7l - K172l*ddpsi - K175l*ddq_1l - K176l*ddq_2l - K177l*ddq_3l - K178l*ddq_4l - K173l*ddq_w - K173l*ddq_imu - K174l*ddq_torso - ddq_5l*cos(q_6l) &  \end{matrix}\right] 
% \nonumber \\ 
K255l = K162l*cos(q_7l) - K213l*dq_7l + K207l*sin(q_7l);
K256l = K212l*dq_7l - K207l*cos(q_7l) + K162l*sin(q_7l);
% \bar\alpha_{10l} &= \left[\begin{matrix} K255l + K215l*ddpsi + K218l*ddq_1l + K219l*ddq_2l + K220l*ddq_3l + K221l*ddq_4l + K216l*ddq_w + K222l*ddq_5l + K216l*ddq_imu + K217l*ddq_torso + ddq_6l*cos(q_7l) & K256l + K223l*ddpsi + K226l*ddq_1l + K227l*ddq_2l + K228l*ddq_3l + K229l*ddq_4l + K224l*ddq_w + K230l*ddq_5l + K224l*ddq_imu + K225l*ddq_torso + ddq_6l*sin(q_7l) & - K206l - ddq_7l - K172l*ddpsi - K175l*ddq_1l - K176l*ddq_2l - K177l*ddq_3l - K178l*ddq_4l - K173l*ddq_w - K173l*ddq_imu - K174l*ddq_torso - ddq_5l*cos(q_6l) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{10l} &= {}^{10l}A_{9l} \left(\bar{a}_{9l} + \bar\alpha_{9l} \times \bar{P}_{10l} + \bar\omega_{9l} \times \left(\bar\omega_{9l} \times \bar{P}_{10l}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{10l} &= \left[\begin{matrix} cos(q_7l)*(K164l + K145l*ddpsi + K149l*ddq_1l + K150l*ddq_2l + K151l*ddq_3l + K152l*ddq_4l + K147l*ddq_w + K146l*ddq_imu + K148l*ddq_torso + K144l*ddx - L9*(K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l)) + K169l*K170l*L9) + sin(q_7l)*(K209l + K198l*ddpsi + K202l*ddq_1l + K203l*ddq_2l + K204l*ddq_3l + K205l*ddq_4l + K200l*ddq_w + K199l*ddq_imu + K201l*ddq_torso + K197l*ddx + L9*(K162l + ddq_6l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) - K170l*K171l*L9) & sin(q_7l)*(K164l + K145l*ddpsi + K149l*ddq_1l + K150l*ddq_2l + K151l*ddq_3l + K152l*ddq_4l + K147l*ddq_w + K146l*ddq_imu + K148l*ddq_torso + K144l*ddx - L9*(K207l + K179l*ddpsi + K182l*ddq_1l + K183l*ddq_2l + K184l*ddq_3l + K185l*ddq_4l + K180l*ddq_w + K180l*ddq_imu + K181l*ddq_torso + ddq_5l*sin(q_6l)) + K169l*K170l*L9) - cos(q_7l)*(K209l + K198l*ddpsi + K202l*ddq_1l + K203l*ddq_2l + K204l*ddq_3l + K205l*ddq_4l + K200l*ddq_w + K199l*ddq_imu + K201l*ddq_torso + K197l*ddx + L9*(K162l + ddq_6l + K130l*ddpsi + K133l*ddq_1l + K134l*ddq_2l + K135l*ddq_3l + K131l*ddq_w + K131l*ddq_imu + K132l*ddq_torso + ddq_4l*cos(q_5l)) - K170l*K171l*L9) & - K208l - K189l*ddpsi - K193l*ddq_1l - K194l*ddq_2l - K195l*ddq_3l - K196l*ddq_4l - K191l*ddq_w - K190l*ddq_imu - K192l*ddq_torso - K188l*ddx - K169l^2*L9 - K171l^2*L9 &  \end{matrix}\right] 
% \nonumber \\ 
K257l = K164l*cos(q_7l) + K209l*sin(q_7l) - K207l*L9*cos(q_7l) + K162l*L9*sin(q_7l) + K169l*K170l*L9*cos(q_7l) - K170l*K171l*L9*sin(q_7l);
K258l = K164l*sin(q_7l) - K209l*cos(q_7l) - K162l*L9*cos(q_7l) - K207l*L9*sin(q_7l) + K170l*K171l*L9*cos(q_7l) + K169l*K170l*L9*sin(q_7l);
K259l = - K208l - K169l^2*L9 - K171l^2*L9;
% \bar{a}_{10l} &= \left[\begin{matrix} K257l + K234l*ddpsi + K238l*ddq_1l + K239l*ddq_2l + K240l*ddq_3l + K241l*ddq_4l + K236l*ddq_w + K242l*ddq_5l + K243l*ddq_6l + K235l*ddq_imu + K237l*ddq_torso + K233l*ddx & K258l + K245l*ddpsi + K249l*ddq_1l + K250l*ddq_2l + K251l*ddq_3l + K252l*ddq_4l + K247l*ddq_w + K253l*ddq_5l + K254l*ddq_6l + K246l*ddq_imu + K248l*ddq_torso + K244l*ddx & K259l - K189l*ddpsi - K193l*ddq_1l - K194l*ddq_2l - K195l*ddq_3l - K196l*ddq_4l - K191l*ddq_w - K190l*ddq_imu - K192l*ddq_torso - K188l*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{10l} &= {}^{10l}A_{9l} \bar{g}_{9l} 
% \nonumber \\ 
% \bar{g}_{10l} &= \left[\begin{matrix} K167l*g*cos(q_7l) + K211l*g*sin(q_7l) & K167l*g*sin(q_7l) - K211l*g*cos(q_7l) & -K210l*g &  \end{matrix}\right] 
% \nonumber \\ 
K260l = K167l*cos(q_7l) + K211l*sin(q_7l);
K261l = K167l*sin(q_7l) - K211l*cos(q_7l);
% \bar{g}_{10l} &= \left[\begin{matrix} K260l*g & K261l*g & -K210l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{10l}\bar{S}_{10l}^{\times}\bar{g}_{10l} &= \mathbf{MS}_{10l} \times \bar{g}_{10l} 
% \nonumber \\ 
% m_{10l}\bar{S}_{10l}^{\times}\bar{g}_{10l} &= \left[\begin{matrix} - K210l*MY_10l*g - K261l*MZ_10l*g & K210l*MX_10l*g + K260l*MZ_10l*g & K261l*MX_10l*g - K260l*MY_10l*g &  \end{matrix}\right] 
% \nonumber \\ 
D325l = - K210l*MY_10l - K261l*MZ_10l;
D326l = K210l*MX_10l + K260l*MZ_10l;
D327l = K261l*MX_10l - K260l*MY_10l;
% m_{10l}\bar{S}_{10l}^{\times}\bar{g}_{10l} &= \left[\begin{matrix} D325l*g & D326l*g & D327l*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{10l}\bar{a}_{G(10l)} &= m_{10l}\bar{a}_{10l} + \bar\alpha_{10l} \times \mathbf{MS}_{10l} + \bar\omega_{10l} \times \left(\bar\omega_{10l} \times \mathbf{MS}_{10l}\right) 
% \nonumber \\ 
% m_{10l}\bar{a}_{G(10l)} &= \left[\begin{matrix} m_10l*(K257l + K234l*ddpsi + K238l*ddq_1l + K239l*ddq_2l + K240l*ddq_3l + K241l*ddq_4l + K236l*ddq_w + K242l*ddq_5l + K243l*ddq_6l + K235l*ddq_imu + K237l*ddq_torso + K233l*ddx) + MZ_10l*(K256l + K223l*ddpsi + K226l*ddq_1l + K227l*ddq_2l + K228l*ddq_3l + K229l*ddq_4l + K224l*ddq_w + K230l*ddq_5l + K224l*ddq_imu + K225l*ddq_torso + ddq_6l*sin(q_7l)) + MY_10l*(K206l + ddq_7l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) - K213l*(K213l*MX_10l - K212l*MY_10l) - K214l*(K214l*MX_10l - K212l*MZ_10l) & m_10l*(K258l + K245l*ddpsi + K249l*ddq_1l + K250l*ddq_2l + K251l*ddq_3l + K252l*ddq_4l + K247l*ddq_w + K253l*ddq_5l + K254l*ddq_6l + K246l*ddq_imu + K248l*ddq_torso + K244l*ddx) - MZ_10l*(K255l + K215l*ddpsi + K218l*ddq_1l + K219l*ddq_2l + K220l*ddq_3l + K221l*ddq_4l + K216l*ddq_w + K222l*ddq_5l + K216l*ddq_imu + K217l*ddq_torso + ddq_6l*cos(q_7l)) - MX_10l*(K206l + ddq_7l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) + K212l*(K213l*MX_10l - K212l*MY_10l) - K214l*(K214l*MY_10l - K213l*MZ_10l) & MY_10l*(K255l + K215l*ddpsi + K218l*ddq_1l + K219l*ddq_2l + K220l*ddq_3l + K221l*ddq_4l + K216l*ddq_w + K222l*ddq_5l + K216l*ddq_imu + K217l*ddq_torso + ddq_6l*cos(q_7l)) - m_10l*(K189l*ddpsi - K259l + K193l*ddq_1l + K194l*ddq_2l + K195l*ddq_3l + K196l*ddq_4l + K191l*ddq_w + K190l*ddq_imu + K192l*ddq_torso + K188l*ddx) - MX_10l*(K256l + K223l*ddpsi + K226l*ddq_1l + K227l*ddq_2l + K228l*ddq_3l + K229l*ddq_4l + K224l*ddq_w + K230l*ddq_5l + K224l*ddq_imu + K225l*ddq_torso + ddq_6l*sin(q_7l)) + K212l*(K214l*MX_10l - K212l*MZ_10l) + K213l*(K214l*MY_10l - K213l*MZ_10l) &  \end{matrix}\right] 
% \nonumber \\ 
D328l = K233l*m_10l;
D329l = K234l*m_10l + K172l*MY_10l + K223l*MZ_10l;
D330l = K235l*m_10l + K173l*MY_10l + K224l*MZ_10l;
D331l = K236l*m_10l + K173l*MY_10l + K224l*MZ_10l;
D332l = K237l*m_10l + K174l*MY_10l + K225l*MZ_10l;
D333l = K238l*m_10l + K175l*MY_10l + K226l*MZ_10l;
D334l = K239l*m_10l + K176l*MY_10l + K227l*MZ_10l;
D335l = K240l*m_10l + K177l*MY_10l + K228l*MZ_10l;
D336l = K241l*m_10l + K178l*MY_10l + K229l*MZ_10l;
D337l = K242l*m_10l + MY_10l*cos(q_6l) + K230l*MZ_10l;
D338l = K243l*m_10l + MZ_10l*sin(q_7l);
D339l = K257l*m_10l - K213l^2*MX_10l - K214l^2*MX_10l + K206l*MY_10l + K256l*MZ_10l + K212l*K213l*MY_10l + K212l*K214l*MZ_10l;
D340l = K244l*m_10l;
D341l = K245l*m_10l - K172l*MX_10l - K215l*MZ_10l;
D342l = K246l*m_10l - K173l*MX_10l - K216l*MZ_10l;
D343l = K247l*m_10l - K173l*MX_10l - K216l*MZ_10l;
D344l = K248l*m_10l - K174l*MX_10l - K217l*MZ_10l;
D345l = K249l*m_10l - K175l*MX_10l - K218l*MZ_10l;
D346l = K250l*m_10l - K176l*MX_10l - K219l*MZ_10l;
D347l = K251l*m_10l - K177l*MX_10l - K220l*MZ_10l;
D348l = K252l*m_10l - K178l*MX_10l - K221l*MZ_10l;
D349l = K253l*m_10l - MX_10l*cos(q_6l) - K222l*MZ_10l;
D350l = K254l*m_10l - MZ_10l*cos(q_7l);
D351l = K258l*m_10l - K212l^2*MY_10l - K214l^2*MY_10l - K206l*MX_10l - K255l*MZ_10l + K212l*K213l*MX_10l + K213l*K214l*MZ_10l;
D352l = -K188l*m_10l;
D353l = K215l*MY_10l - K223l*MX_10l - K189l*m_10l;
D354l = K216l*MY_10l - K224l*MX_10l - K190l*m_10l;
D355l = K216l*MY_10l - K224l*MX_10l - K191l*m_10l;
D356l = K217l*MY_10l - K225l*MX_10l - K192l*m_10l;
D357l = K218l*MY_10l - K226l*MX_10l - K193l*m_10l;
D358l = K219l*MY_10l - K227l*MX_10l - K194l*m_10l;
D359l = K220l*MY_10l - K228l*MX_10l - K195l*m_10l;
D360l = K221l*MY_10l - K229l*MX_10l - K196l*m_10l;
D361l = K222l*MY_10l - K230l*MX_10l;
D362l = MY_10l*cos(q_7l) - MX_10l*sin(q_7l);
D363l = K259l*m_10l - K212l^2*MZ_10l - K213l^2*MZ_10l - K256l*MX_10l + K255l*MY_10l + K212l*K214l*MX_10l + K213l*K214l*MY_10l;
% m_{10l}\bar{a}_{G(10l)} &= \left[\begin{matrix} D339l + D329l*ddpsi + D333l*ddq_1l + D334l*ddq_2l + D335l*ddq_3l + D336l*ddq_4l + D331l*ddq_w + D337l*ddq_5l + D338l*ddq_6l + D330l*ddq_imu + D332l*ddq_torso + D328l*ddx + MY_10l*ddq_7l & D351l + D341l*ddpsi + D345l*ddq_1l + D346l*ddq_2l + D347l*ddq_3l + D348l*ddq_4l + D343l*ddq_w + D349l*ddq_5l + D350l*ddq_6l + D342l*ddq_imu + D344l*ddq_torso + D340l*ddx - MX_10l*ddq_7l & D363l + D353l*ddpsi + D357l*ddq_1l + D358l*ddq_2l + D359l*ddq_3l + D360l*ddq_4l + D355l*ddq_w + D361l*ddq_5l + D362l*ddq_6l + D354l*ddq_imu + D356l*ddq_torso + D352l*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{10l} &= \mathbf{MS}_{10l} \times \bar{a}_{10l} + J_{10l}\bar{\alpha}_{10l} + \bar\omega_{10l} \times J_{10l}\bar{\omega}_{10l} 
% \nonumber \\ 
% \dot{\bar{H}}_{10l} &= \left[\begin{matrix} K213l*(K212l*XZ_10l + K213l*YZ_10l + K214l*ZZ_10l) - K214l*(K212l*XY_10l + K213l*YY_10l + K214l*YZ_10l) - MY_10l*(K189l*ddpsi - K259l + K193l*ddq_1l + K194l*ddq_2l + K195l*ddq_3l + K196l*ddq_4l + K191l*ddq_w + K190l*ddq_imu + K192l*ddq_torso + K188l*ddx) + XX_10l*(K255l + K215l*ddpsi + K218l*ddq_1l + K219l*ddq_2l + K220l*ddq_3l + K221l*ddq_4l + K216l*ddq_w + K222l*ddq_5l + K216l*ddq_imu + K217l*ddq_torso + ddq_6l*cos(q_7l)) + XY_10l*(K256l + K223l*ddpsi + K226l*ddq_1l + K227l*ddq_2l + K228l*ddq_3l + K229l*ddq_4l + K224l*ddq_w + K230l*ddq_5l + K224l*ddq_imu + K225l*ddq_torso + ddq_6l*sin(q_7l)) - XZ_10l*(K206l + ddq_7l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) - MZ_10l*(K258l + K245l*ddpsi + K249l*ddq_1l + K250l*ddq_2l + K251l*ddq_3l + K252l*ddq_4l + K247l*ddq_w + K253l*ddq_5l + K254l*ddq_6l + K246l*ddq_imu + K248l*ddq_torso + K244l*ddx) & K214l*(K212l*XX_10l + K213l*XY_10l + K214l*XZ_10l) - K212l*(K212l*XZ_10l + K213l*YZ_10l + K214l*ZZ_10l) + MX_10l*(K189l*ddpsi - K259l + K193l*ddq_1l + K194l*ddq_2l + K195l*ddq_3l + K196l*ddq_4l + K191l*ddq_w + K190l*ddq_imu + K192l*ddq_torso + K188l*ddx) + XY_10l*(K255l + K215l*ddpsi + K218l*ddq_1l + K219l*ddq_2l + K220l*ddq_3l + K221l*ddq_4l + K216l*ddq_w + K222l*ddq_5l + K216l*ddq_imu + K217l*ddq_torso + ddq_6l*cos(q_7l)) + YY_10l*(K256l + K223l*ddpsi + K226l*ddq_1l + K227l*ddq_2l + K228l*ddq_3l + K229l*ddq_4l + K224l*ddq_w + K230l*ddq_5l + K224l*ddq_imu + K225l*ddq_torso + ddq_6l*sin(q_7l)) - YZ_10l*(K206l + ddq_7l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) + MZ_10l*(K257l + K234l*ddpsi + K238l*ddq_1l + K239l*ddq_2l + K240l*ddq_3l + K241l*ddq_4l + K236l*ddq_w + K242l*ddq_5l + K243l*ddq_6l + K235l*ddq_imu + K237l*ddq_torso + K233l*ddx) & K212l*(K212l*XY_10l + K213l*YY_10l + K214l*YZ_10l) - K213l*(K212l*XX_10l + K213l*XY_10l + K214l*XZ_10l) + XZ_10l*(K255l + K215l*ddpsi + K218l*ddq_1l + K219l*ddq_2l + K220l*ddq_3l + K221l*ddq_4l + K216l*ddq_w + K222l*ddq_5l + K216l*ddq_imu + K217l*ddq_torso + ddq_6l*cos(q_7l)) + YZ_10l*(K256l + K223l*ddpsi + K226l*ddq_1l + K227l*ddq_2l + K228l*ddq_3l + K229l*ddq_4l + K224l*ddq_w + K230l*ddq_5l + K224l*ddq_imu + K225l*ddq_torso + ddq_6l*sin(q_7l)) - ZZ_10l*(K206l + ddq_7l + K172l*ddpsi + K175l*ddq_1l + K176l*ddq_2l + K177l*ddq_3l + K178l*ddq_4l + K173l*ddq_w + K173l*ddq_imu + K174l*ddq_torso + ddq_5l*cos(q_6l)) + MX_10l*(K258l + K245l*ddpsi + K249l*ddq_1l + K250l*ddq_2l + K251l*ddq_3l + K252l*ddq_4l + K247l*ddq_w + K253l*ddq_5l + K254l*ddq_6l + K246l*ddq_imu + K248l*ddq_torso + K244l*ddx) - MY_10l*(K257l + K234l*ddpsi + K238l*ddq_1l + K239l*ddq_2l + K240l*ddq_3l + K241l*ddq_4l + K236l*ddq_w + K242l*ddq_5l + K243l*ddq_6l + K235l*ddq_imu + K237l*ddq_torso + K233l*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D364l = - K188l*MY_10l - K244l*MZ_10l;
D365l = K215l*XX_10l + K223l*XY_10l - K172l*XZ_10l - K189l*MY_10l - K245l*MZ_10l;
D366l = K216l*XX_10l + K224l*XY_10l - K173l*XZ_10l - K190l*MY_10l - K246l*MZ_10l;
D367l = K216l*XX_10l + K224l*XY_10l - K173l*XZ_10l - K191l*MY_10l - K247l*MZ_10l;
D368l = K217l*XX_10l + K225l*XY_10l - K174l*XZ_10l - K192l*MY_10l - K248l*MZ_10l;
D369l = K218l*XX_10l + K226l*XY_10l - K175l*XZ_10l - K193l*MY_10l - K249l*MZ_10l;
D370l = K219l*XX_10l + K227l*XY_10l - K176l*XZ_10l - K194l*MY_10l - K250l*MZ_10l;
D371l = K220l*XX_10l + K228l*XY_10l - K177l*XZ_10l - K195l*MY_10l - K251l*MZ_10l;
D372l = K221l*XX_10l + K229l*XY_10l - K178l*XZ_10l - K196l*MY_10l - K252l*MZ_10l;
D373l = K222l*XX_10l + K230l*XY_10l - XZ_10l*cos(q_6l) - K253l*MZ_10l;
D374l = XX_10l*cos(q_7l) + XY_10l*sin(q_7l) - K254l*MZ_10l;
D375l = K255l*XX_10l + K256l*XY_10l - K206l*XZ_10l + K213l^2*YZ_10l - K214l^2*YZ_10l + K259l*MY_10l - K258l*MZ_10l - K212l*K214l*XY_10l + K212l*K213l*XZ_10l - K213l*K214l*YY_10l + K213l*K214l*ZZ_10l;
D376l = K188l*MX_10l + K233l*MZ_10l;
D377l = K215l*XY_10l + K223l*YY_10l - K172l*YZ_10l + K189l*MX_10l + K234l*MZ_10l;
D378l = K216l*XY_10l + K224l*YY_10l - K173l*YZ_10l + K190l*MX_10l + K235l*MZ_10l;
D379l = K216l*XY_10l + K224l*YY_10l - K173l*YZ_10l + K191l*MX_10l + K236l*MZ_10l;
D380l = K217l*XY_10l + K225l*YY_10l - K174l*YZ_10l + K192l*MX_10l + K237l*MZ_10l;
D381l = K218l*XY_10l + K226l*YY_10l - K175l*YZ_10l + K193l*MX_10l + K238l*MZ_10l;
D382l = K219l*XY_10l + K227l*YY_10l - K176l*YZ_10l + K194l*MX_10l + K239l*MZ_10l;
D383l = K220l*XY_10l + K228l*YY_10l - K177l*YZ_10l + K195l*MX_10l + K240l*MZ_10l;
D384l = K221l*XY_10l + K229l*YY_10l - K178l*YZ_10l + K196l*MX_10l + K241l*MZ_10l;
D385l = K222l*XY_10l + K230l*YY_10l - YZ_10l*cos(q_6l) + K242l*MZ_10l;
D386l = XY_10l*cos(q_7l) + YY_10l*sin(q_7l) + K243l*MZ_10l;
D387l = K255l*XY_10l + K256l*YY_10l - K206l*YZ_10l - K212l^2*XZ_10l + K214l^2*XZ_10l - K259l*MX_10l + K257l*MZ_10l + K212l*K214l*XX_10l + K213l*K214l*XY_10l - K212l*K213l*YZ_10l - K212l*K214l*ZZ_10l;
D388l = K244l*MX_10l - K233l*MY_10l;
D389l = K215l*XZ_10l + K223l*YZ_10l - K172l*ZZ_10l + K245l*MX_10l - K234l*MY_10l;
D390l = K216l*XZ_10l + K224l*YZ_10l - K173l*ZZ_10l + K246l*MX_10l - K235l*MY_10l;
D391l = K216l*XZ_10l + K224l*YZ_10l - K173l*ZZ_10l + K247l*MX_10l - K236l*MY_10l;
D392l = K217l*XZ_10l + K225l*YZ_10l - K174l*ZZ_10l + K248l*MX_10l - K237l*MY_10l;
D393l = K218l*XZ_10l + K226l*YZ_10l - K175l*ZZ_10l + K249l*MX_10l - K238l*MY_10l;
D394l = K219l*XZ_10l + K227l*YZ_10l - K176l*ZZ_10l + K250l*MX_10l - K239l*MY_10l;
D395l = K220l*XZ_10l + K228l*YZ_10l - K177l*ZZ_10l + K251l*MX_10l - K240l*MY_10l;
D396l = K221l*XZ_10l + K229l*YZ_10l - K178l*ZZ_10l + K252l*MX_10l - K241l*MY_10l;
D397l = K222l*XZ_10l + K230l*YZ_10l - ZZ_10l*cos(q_6l) + K253l*MX_10l - K242l*MY_10l;
D398l = XZ_10l*cos(q_7l) + YZ_10l*sin(q_7l) + K254l*MX_10l - K243l*MY_10l;
D399l = K255l*XZ_10l + K256l*YZ_10l - K206l*ZZ_10l + K212l^2*XY_10l - K213l^2*XY_10l + K258l*MX_10l - K257l*MY_10l - K212l*K213l*XX_10l - K213l*K214l*XZ_10l + K212l*K213l*YY_10l + K212l*K214l*YZ_10l;
% \dot{\bar{H}}_{10l} &= \left[\begin{matrix} D339l + D329l*ddpsi + D333l*ddq_1l + D334l*ddq_2l + D335l*ddq_3l + D336l*ddq_4l + D331l*ddq_w + D337l*ddq_5l + D338l*ddq_6l + D330l*ddq_imu + D332l*ddq_torso + D328l*ddx + MY_10l*ddq_7l & D351l + D341l*ddpsi + D345l*ddq_1l + D346l*ddq_2l + D347l*ddq_3l + D348l*ddq_4l + D343l*ddq_w + D349l*ddq_5l + D350l*ddq_6l + D342l*ddq_imu + D344l*ddq_torso + D340l*ddx - MX_10l*ddq_7l & D363l + D353l*ddpsi + D357l*ddq_1l + D358l*ddq_2l + D359l*ddq_3l + D360l*ddq_4l + D355l*ddq_w + D361l*ddq_5l + D362l*ddq_6l + D354l*ddq_imu + D356l*ddq_torso + D352l*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{4r} &= {}^{4r}A_{3} \bar\omega_{3} + \dot{q}_{4r} \bar{e}_{4r} 
% \nonumber \\ 
% \bar\omega_{4r} &= \left[\begin{matrix} K26*cos(q_1r) + K27*sin(q_1r) & - K25 - dq_1r & K27*cos(q_1r) - K26*sin(q_1r) &  \end{matrix}\right] 
% \nonumber \\ 
K1r = K26*cos(q_1r) + K27*sin(q_1r);
K2r = - K25 - dq_1r;
K3r = K27*cos(q_1r) - K26*sin(q_1r);
% \bar\omega_{4r} &= \left[\begin{matrix} K1r & K2r & K3r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{4r} &= \left[\begin{matrix} - sin(q_1r)*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso)) - cos(q_1r)*(dq_torso - K10*dpsi) & - dq_1r - K28*dpsi - dq_w*cos(q_torso) - dq_imu*cos(q_torso) & sin(q_1r)*(dq_torso - K10*dpsi) - cos(q_1r)*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso)) &  \end{matrix}\right] 
% \nonumber \\ 
K4r = K10*cos(q_1r) + K29*sin(q_1r);
K5r = -sin(q_1r)*sin(q_torso);
K6r = K29*cos(q_1r) - K10*sin(q_1r);
K7r = -cos(q_1r)*sin(q_torso);
% \bar\omega_{4r} &= \left[\begin{matrix} K4r*dpsi + K5r*dq_w + K5r*dq_imu - dq_torso*cos(q_1r) & - dq_1r - K28*dpsi - dq_w*cos(q_torso) - dq_imu*cos(q_torso) & K6r*dpsi + K7r*dq_w + K7r*dq_imu + dq_torso*sin(q_1r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{4r} &= {}^{4r}A_{3} \left(\bar{v}_{3} + \bar\omega_{3} \times \bar{P}_{4r}\right) 
% \nonumber \\ 
% \bar{v}_{4r} &= \left[\begin{matrix} cos(q_1r)*(K31 - K27*L6) + sin(q_1r)*(K32 + K25*L5 + K26*L6) & K27*L5 - K30 & cos(q_1r)*(K32 + K25*L5 + K26*L6) - sin(q_1r)*(K31 - K27*L6) &  \end{matrix}\right] 
% \nonumber \\ 
K8r = cos(q_1r)*(K31 - K27*L6) + sin(q_1r)*(K32 + K25*L5 + K26*L6);
K9r = K27*L5 - K30;
K10r = cos(q_1r)*(K32 + K25*L5 + K26*L6) - sin(q_1r)*(K31 - K27*L6);
% \bar{v}_{4r} &= \left[\begin{matrix} K8r & K9r & K10r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{4r} &= \left[\begin{matrix} cos(q_1r)*(K37*dq_imu + K11*dx + L4*dq_w + L6*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso))) + sin(q_1r)*(K39*dpsi + K41*dq_w + K40*dq_imu + K38*dx + L5*(K28*dpsi + dq_w*cos(q_torso) + dq_imu*cos(q_torso)) - L6*(dq_torso - K10*dpsi)) & - K34*dpsi - K36*dq_w - K35*dq_imu - K33*dx - L5*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso)) & cos(q_1r)*(K39*dpsi + K41*dq_w + K40*dq_imu + K38*dx + L5*(K28*dpsi + dq_w*cos(q_torso) + dq_imu*cos(q_torso)) - L6*(dq_torso - K10*dpsi)) - sin(q_1r)*(K37*dq_imu + K11*dx + L4*dq_w + L6*(dq_w*sin(q_torso) - K29*dpsi + dq_imu*sin(q_torso))) &  \end{matrix}\right] 
% \nonumber \\ 
K11r = K11*cos(q_1r) + K38*sin(q_1r);
K12r = sin(q_1r)*(K39 + K10*L6 + K28*L5) - K29*L6*cos(q_1r);
K13r = cos(q_1r)*(K37 + L6*sin(q_torso)) + sin(q_1r)*(K40 + L5*cos(q_torso));
K14r = sin(q_1r)*(K41 + L5*cos(q_torso)) + cos(q_1r)*(L4 + L6*sin(q_torso));
K15r = -L6*sin(q_1r);
K16r = K29*L5 - K34;
K17r = - K35 - L5*sin(q_torso);
K18r = - K36 - L5*sin(q_torso);
K19r = K38*cos(q_1r) - K11*sin(q_1r);
K20r = cos(q_1r)*(K39 + K10*L6 + K28*L5) + K29*L6*sin(q_1r);
K21r = cos(q_1r)*(K40 + L5*cos(q_torso)) - sin(q_1r)*(K37 + L6*sin(q_torso));
K22r = cos(q_1r)*(K41 + L5*cos(q_torso)) - sin(q_1r)*(L4 + L6*sin(q_torso));
K23r = -L6*cos(q_1r);
% \bar{v}_{4r} &= \left[\begin{matrix} K12r*dpsi + K14r*dq_w + K13r*dq_imu + K15r*dq_torso + K11r*dx & K16r*dpsi + K18r*dq_w + K17r*dq_imu - K33*dx & K20r*dpsi + K22r*dq_w + K21r*dq_imu + K23r*dq_torso + K19r*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{4r} &= {}^{4r}A_{3} \bar\alpha_{3} + \ddot{q}_{4r} \bar{e}_{4r} + \dot{q}_{4r} \left(\bar\omega_{4r} \times \bar{e}_{4r}\right) 
% \nonumber \\ 
% \bar\alpha_{4r} &= \left[\begin{matrix} K3r*dq_1r + sin(q_1r)*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) + cos(q_1r)*(K19 - ddq_torso + K10*ddpsi) & - K42 - ddq_1r - K28*ddpsi - ddq_w*cos(q_torso) - ddq_imu*cos(q_torso) & cos(q_1r)*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) - K1r*dq_1r - sin(q_1r)*(K19 - ddq_torso + K10*ddpsi) &  \end{matrix}\right] 
% \nonumber \\ 
K24r = K3r*dq_1r + K19*cos(q_1r) + K43*sin(q_1r);
K25r = K43*cos(q_1r) - K1r*dq_1r - K19*sin(q_1r);
% \bar\alpha_{4r} &= \left[\begin{matrix} K24r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r) & - K42 - ddq_1r - K28*ddpsi - ddq_w*cos(q_torso) - ddq_imu*cos(q_torso) & K25r + K6r*ddpsi + K7r*ddq_w + K7r*ddq_imu + ddq_torso*sin(q_1r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{4r} &= {}^{4r}A_{3} \left(\bar{a}_{3} + \bar\alpha_{3} \times \bar{P}_{4r} + \bar\omega_{3} \times \left(\bar\omega_{3} \times \bar{P}_{4r}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{4r} &= \left[\begin{matrix} cos(q_1r)*(K45 + K37*ddq_imu + K11*ddx + L4*ddq_w - K27^2*L5 - L6*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) - K25*(K25*L5 + K26*L6)) + sin(q_1r)*(K46 + K39*ddpsi + K41*ddq_w + K40*ddq_imu + K38*ddx + L6*(K19 - ddq_torso + K10*ddpsi) + L5*(K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) - K25*K27*L6 + K26*K27*L5) & L5*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) - K34*ddpsi - K36*ddq_w - K35*ddq_imu - K33*ddx - K27^2*L6 - K44 - K26*(K25*L5 + K26*L6) & cos(q_1r)*(K46 + K39*ddpsi + K41*ddq_w + K40*ddq_imu + K38*ddx + L6*(K19 - ddq_torso + K10*ddpsi) + L5*(K42 + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) - K25*K27*L6 + K26*K27*L5) - sin(q_1r)*(K45 + K37*ddq_imu + K11*ddx + L4*ddq_w - K27^2*L5 - L6*(K43 + K29*ddpsi - ddq_w*sin(q_torso) - ddq_imu*sin(q_torso)) - K25*(K25*L5 + K26*L6)) &  \end{matrix}\right] 
% \nonumber \\ 
K26r = K45*cos(q_1r) + K46*sin(q_1r) - K25^2*L5*cos(q_1r) - K27^2*L5*cos(q_1r) - K43*L6*cos(q_1r) + K19*L6*sin(q_1r) + K42*L5*sin(q_1r) - K25*K26*L6*cos(q_1r) - K25*K27*L6*sin(q_1r) + K26*K27*L5*sin(q_1r);
K27r = K43*L5 - K26^2*L6 - K27^2*L6 - K44 - K25*K26*L5;
K28r = K46*cos(q_1r) - K45*sin(q_1r) + K25^2*L5*sin(q_1r) + K27^2*L5*sin(q_1r) + K19*L6*cos(q_1r) + K42*L5*cos(q_1r) + K43*L6*sin(q_1r) - K25*K27*L6*cos(q_1r) + K26*K27*L5*cos(q_1r) + K25*K26*L6*sin(q_1r);
% \bar{a}_{4r} &= \left[\begin{matrix} K26r + K12r*ddpsi + K14r*ddq_w + K13r*ddq_imu + K15r*ddq_torso + K11r*ddx & K27r + K16r*ddpsi + K18r*ddq_w + K17r*ddq_imu - K33*ddx & K28r + K20r*ddpsi + K22r*ddq_w + K21r*ddq_imu + K23r*ddq_torso + K19r*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{4r} &= {}^{4r}A_{3} \bar{g}_{3} 
% \nonumber \\ 
% \bar{g}_{4r} &= \left[\begin{matrix} K17*g*cos(q_1r) + K48*g*sin(q_1r) & -K47*g & K48*g*cos(q_1r) - K17*g*sin(q_1r) &  \end{matrix}\right] 
% \nonumber \\ 
K29r = K17*cos(q_1r) + K48*sin(q_1r);
K30r = K48*cos(q_1r) - K17*sin(q_1r);
% \bar{g}_{4r} &= \left[\begin{matrix} K29r*g & -K47*g & K30r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{4r}\bar{S}_{4r}^{\times}\bar{g}_{4r} &= \mathbf{MS}_{4r} \times \bar{g}_{4r} 
% \nonumber \\ 
% m_{4r}\bar{S}_{4r}^{\times}\bar{g}_{4r} &= \left[\begin{matrix} K30r*MY_4r*g + K47*MZ_4r*g & K29r*MZ_4r*g - K30r*MX_4r*g & - K47*MX_4r*g - K29r*MY_4r*g &  \end{matrix}\right] 
% \nonumber \\ 
D1r = K30r*MY_4r + K47*MZ_4r;
D2r = K29r*MZ_4r - K30r*MX_4r;
D3r = - K47*MX_4r - K29r*MY_4r;
% m_{4r}\bar{S}_{4r}^{\times}\bar{g}_{4r} &= \left[\begin{matrix} D1r*g & D2r*g & D3r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{4r}\bar{a}_{G(4r)} &= m_{4r}\bar{a}_{4r} + \bar\alpha_{4r} \times \mathbf{MS}_{4r} + \bar\omega_{4r} \times \left(\bar\omega_{4r} \times \mathbf{MS}_{4r}\right) 
% \nonumber \\ 
% m_{4r}\bar{a}_{G(4r)} &= \left[\begin{matrix} m_4r*(K26r + K12r*ddpsi + K14r*ddq_w + K13r*ddq_imu + K15r*ddq_torso + K11r*ddx) - MY_4r*(K25r + K6r*ddpsi + K7r*ddq_w + K7r*ddq_imu + ddq_torso*sin(q_1r)) - K2r*(K2r*MX_4r - K1r*MY_4r) - K3r*(K3r*MX_4r - K1r*MZ_4r) - MZ_4r*(K42 + ddq_1r + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) & MX_4r*(K25r + K6r*ddpsi + K7r*ddq_w + K7r*ddq_imu + ddq_torso*sin(q_1r)) - MZ_4r*(K24r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) + m_4r*(K27r + K16r*ddpsi + K18r*ddq_w + K17r*ddq_imu - K33*ddx) + K1r*(K2r*MX_4r - K1r*MY_4r) - K3r*(K3r*MY_4r - K2r*MZ_4r) & MY_4r*(K24r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) + m_4r*(K28r + K20r*ddpsi + K22r*ddq_w + K21r*ddq_imu + K23r*ddq_torso + K19r*ddx) + K1r*(K3r*MX_4r - K1r*MZ_4r) + K2r*(K3r*MY_4r - K2r*MZ_4r) + MX_4r*(K42 + ddq_1r + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) &  \end{matrix}\right] 
% \nonumber \\ 
D4r = K11r*m_4r;
D5r = K12r*m_4r - K6r*MY_4r - K28*MZ_4r;
D6r = K13r*m_4r - MZ_4r*cos(q_torso) - K7r*MY_4r;
D7r = K14r*m_4r - MZ_4r*cos(q_torso) - K7r*MY_4r;
D8r = K15r*m_4r - MY_4r*sin(q_1r);
D9r = K26r*m_4r - K2r^2*MX_4r - K3r^2*MX_4r - K25r*MY_4r - K42*MZ_4r + K1r*K2r*MY_4r + K1r*K3r*MZ_4r;
D10r = -K33*m_4r;
D11r = K16r*m_4r + K6r*MX_4r - K4r*MZ_4r;
D12r = K17r*m_4r + K7r*MX_4r - K5r*MZ_4r;
D13r = K18r*m_4r + K7r*MX_4r - K5r*MZ_4r;
D14r = MZ_4r*cos(q_1r) + MX_4r*sin(q_1r);
D15r = K27r*m_4r - K1r^2*MY_4r - K3r^2*MY_4r + K25r*MX_4r - K24r*MZ_4r + K1r*K2r*MX_4r + K2r*K3r*MZ_4r;
D16r = K19r*m_4r;
D17r = K20r*m_4r + K28*MX_4r + K4r*MY_4r;
D18r = K21r*m_4r + MX_4r*cos(q_torso) + K5r*MY_4r;
D19r = K22r*m_4r + MX_4r*cos(q_torso) + K5r*MY_4r;
D20r = K23r*m_4r - MY_4r*cos(q_1r);
D21r = K28r*m_4r - K1r^2*MZ_4r - K2r^2*MZ_4r + K42*MX_4r + K24r*MY_4r + K1r*K3r*MX_4r + K2r*K3r*MY_4r;
% m_{4r}\bar{a}_{G(4r)} &= \left[\begin{matrix} D9r + D5r*ddpsi + D7r*ddq_w + D6r*ddq_imu + D8r*ddq_torso + D4r*ddx - MZ_4r*ddq_1r & D15r + D11r*ddpsi + D13r*ddq_w + D12r*ddq_imu + D14r*ddq_torso + D10r*ddx & D21r + D17r*ddpsi + D19r*ddq_w + D18r*ddq_imu + D20r*ddq_torso + D16r*ddx + MX_4r*ddq_1r &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{4r} &= \mathbf{MS}_{4r} \times \bar{a}_{4r} + J_{4r}\bar{\alpha}_{4r} + \bar\omega_{4r} \times J_{4r}\bar{\omega}_{4r} 
% \nonumber \\ 
% \dot{\bar{H}}_{4r} &= \left[\begin{matrix} K2r*(K1r*XZ_4r + K2r*YZ_4r + K3r*ZZ_4r) - K3r*(K1r*XY_4r + K2r*YY_4r + K3r*YZ_4r) - XY_4r*(K42 + ddq_1r + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + XX_4r*(K24r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) + XZ_4r*(K25r + K6r*ddpsi + K7r*ddq_w + K7r*ddq_imu + ddq_torso*sin(q_1r)) - MZ_4r*(K27r + K16r*ddpsi + K18r*ddq_w + K17r*ddq_imu - K33*ddx) + MY_4r*(K28r + K20r*ddpsi + K22r*ddq_w + K21r*ddq_imu + K23r*ddq_torso + K19r*ddx) & K3r*(K1r*XX_4r + K2r*XY_4r + K3r*XZ_4r) - YY_4r*(K42 + ddq_1r + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) - K1r*(K1r*XZ_4r + K2r*YZ_4r + K3r*ZZ_4r) + XY_4r*(K24r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) + YZ_4r*(K25r + K6r*ddpsi + K7r*ddq_w + K7r*ddq_imu + ddq_torso*sin(q_1r)) - MX_4r*(K28r + K20r*ddpsi + K22r*ddq_w + K21r*ddq_imu + K23r*ddq_torso + K19r*ddx) + MZ_4r*(K26r + K12r*ddpsi + K14r*ddq_w + K13r*ddq_imu + K15r*ddq_torso + K11r*ddx) & K1r*(K1r*XY_4r + K2r*YY_4r + K3r*YZ_4r) - K2r*(K1r*XX_4r + K2r*XY_4r + K3r*XZ_4r) - YZ_4r*(K42 + ddq_1r + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + XZ_4r*(K24r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) + ZZ_4r*(K25r + K6r*ddpsi + K7r*ddq_w + K7r*ddq_imu + ddq_torso*sin(q_1r)) + MX_4r*(K27r + K16r*ddpsi + K18r*ddq_w + K17r*ddq_imu - K33*ddx) - MY_4r*(K26r + K12r*ddpsi + K14r*ddq_w + K13r*ddq_imu + K15r*ddq_torso + K11r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D22r = K19r*MY_4r + K33*MZ_4r;
D23r = K4r*XX_4r - K28*XY_4r + K6r*XZ_4r + K20r*MY_4r - K16r*MZ_4r;
D24r = K5r*XX_4r + K7r*XZ_4r - XY_4r*cos(q_torso) + K21r*MY_4r - K17r*MZ_4r;
D25r = K5r*XX_4r + K7r*XZ_4r - XY_4r*cos(q_torso) + K22r*MY_4r - K18r*MZ_4r;
D26r = XZ_4r*sin(q_1r) - XX_4r*cos(q_1r) + K23r*MY_4r;
D27r = K24r*XX_4r - K42*XY_4r + K25r*XZ_4r + K2r^2*YZ_4r - K3r^2*YZ_4r + K28r*MY_4r - K27r*MZ_4r - K1r*K3r*XY_4r + K1r*K2r*XZ_4r - K2r*K3r*YY_4r + K2r*K3r*ZZ_4r;
D28r = K11r*MZ_4r - K19r*MX_4r;
D29r = K4r*XY_4r - K28*YY_4r + K6r*YZ_4r - K20r*MX_4r + K12r*MZ_4r;
D30r = K5r*XY_4r + K7r*YZ_4r - YY_4r*cos(q_torso) - K21r*MX_4r + K13r*MZ_4r;
D31r = K5r*XY_4r + K7r*YZ_4r - YY_4r*cos(q_torso) - K22r*MX_4r + K14r*MZ_4r;
D32r = YZ_4r*sin(q_1r) - XY_4r*cos(q_1r) - K23r*MX_4r + K15r*MZ_4r;
D33r = K24r*XY_4r - K42*YY_4r + K25r*YZ_4r - K1r^2*XZ_4r + K3r^2*XZ_4r - K28r*MX_4r + K26r*MZ_4r + K1r*K3r*XX_4r + K2r*K3r*XY_4r - K1r*K2r*YZ_4r - K1r*K3r*ZZ_4r;
D34r = - K33*MX_4r - K11r*MY_4r;
D35r = K4r*XZ_4r - K28*YZ_4r + K6r*ZZ_4r + K16r*MX_4r - K12r*MY_4r;
D36r = K5r*XZ_4r + K7r*ZZ_4r - YZ_4r*cos(q_torso) + K17r*MX_4r - K13r*MY_4r;
D37r = K5r*XZ_4r + K7r*ZZ_4r - YZ_4r*cos(q_torso) + K18r*MX_4r - K14r*MY_4r;
D38r = ZZ_4r*sin(q_1r) - XZ_4r*cos(q_1r) - K15r*MY_4r;
D39r = K24r*XZ_4r - K42*YZ_4r + K25r*ZZ_4r + K1r^2*XY_4r - K2r^2*XY_4r + K27r*MX_4r - K26r*MY_4r - K1r*K2r*XX_4r - K2r*K3r*XZ_4r + K1r*K2r*YY_4r + K1r*K3r*YZ_4r;
% \dot{\bar{H}}_{4r} &= \left[\begin{matrix} D9r + D5r*ddpsi + D7r*ddq_w + D6r*ddq_imu + D8r*ddq_torso + D4r*ddx - MZ_4r*ddq_1r & D15r + D11r*ddpsi + D13r*ddq_w + D12r*ddq_imu + D14r*ddq_torso + D10r*ddx & D21r + D17r*ddpsi + D19r*ddq_w + D18r*ddq_imu + D20r*ddq_torso + D16r*ddx + MX_4r*ddq_1r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{5r} &= {}^{5r}A_{4r} \bar\omega_{4r} + \dot{q}_{5r} \bar{e}_{5r} 
% \nonumber \\ 
% \bar\omega_{5r} &= \left[\begin{matrix} - K1r - dq_2r & - K2r*cos(q_2r) - K3r*sin(q_2r) & K3r*cos(q_2r) - K2r*sin(q_2r) &  \end{matrix}\right] 
% \nonumber \\ 
K31r = - K1r - dq_2r;
K32r = - K2r*cos(q_2r) - K3r*sin(q_2r);
K33r = K3r*cos(q_2r) - K2r*sin(q_2r);
% \bar\omega_{5r} &= \left[\begin{matrix} K31r & K32r & K33r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{5r} &= \left[\begin{matrix} dq_torso*cos(q_1r) - K4r*dpsi - K5r*dq_w - K5r*dq_imu - dq_2r & cos(q_2r)*(dq_1r + K28*dpsi + dq_w*cos(q_torso) + dq_imu*cos(q_torso)) - sin(q_2r)*(K6r*dpsi + K7r*dq_w + K7r*dq_imu + dq_torso*sin(q_1r)) & sin(q_2r)*(dq_1r + K28*dpsi + dq_w*cos(q_torso) + dq_imu*cos(q_torso)) + cos(q_2r)*(K6r*dpsi + K7r*dq_w + K7r*dq_imu + dq_torso*sin(q_1r)) &  \end{matrix}\right] 
% \nonumber \\ 
K34r = K28*cos(q_2r) - K6r*sin(q_2r);
K35r = cos(q_2r)*cos(q_torso) - K7r*sin(q_2r);
K36r = -sin(q_1r)*sin(q_2r);
K37r = K6r*cos(q_2r) + K28*sin(q_2r);
K38r = cos(q_torso)*sin(q_2r) + K7r*cos(q_2r);
K39r = cos(q_2r)*sin(q_1r);
% \bar\omega_{5r} &= \left[\begin{matrix} dq_torso*cos(q_1r) - K4r*dpsi - K5r*dq_w - K5r*dq_imu - dq_2r & K34r*dpsi + K35r*dq_w + K35r*dq_imu + K36r*dq_torso + dq_1r*cos(q_2r) & K37r*dpsi + K38r*dq_w + K38r*dq_imu + K39r*dq_torso + dq_1r*sin(q_2r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{5r} &= {}^{5r}A_{4r} \left(\bar{v}_{4r} + \bar\omega_{4r} \times \bar{P}_{5r}\right) 
% \nonumber \\ 
% \bar{v}_{5r} &= \left[\begin{matrix} -K8r & - K9r*cos(q_2r) - K10r*sin(q_2r) & K10r*cos(q_2r) - K9r*sin(q_2r) &  \end{matrix}\right] 
% \nonumber \\ 
K40r = - K9r*cos(q_2r) - K10r*sin(q_2r);
K41r = K10r*cos(q_2r) - K9r*sin(q_2r);
% \bar{v}_{5r} &= \left[\begin{matrix} -K8r & K40r & K41r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{5r} &= \left[\begin{matrix} - K12r*dpsi - K14r*dq_w - K13r*dq_imu - K15r*dq_torso - K11r*dx & - cos(q_2r)*(K16r*dpsi + K18r*dq_w + K17r*dq_imu - K33*dx) - sin(q_2r)*(K20r*dpsi + K22r*dq_w + K21r*dq_imu + K23r*dq_torso + K19r*dx) & cos(q_2r)*(K20r*dpsi + K22r*dq_w + K21r*dq_imu + K23r*dq_torso + K19r*dx) - sin(q_2r)*(K16r*dpsi + K18r*dq_w + K17r*dq_imu - K33*dx) &  \end{matrix}\right] 
% \nonumber \\ 
K42r = K33*cos(q_2r) - K19r*sin(q_2r);
K43r = - K16r*cos(q_2r) - K20r*sin(q_2r);
K44r = - K17r*cos(q_2r) - K21r*sin(q_2r);
K45r = - K18r*cos(q_2r) - K22r*sin(q_2r);
K46r = -K23r*sin(q_2r);
K47r = K19r*cos(q_2r) + K33*sin(q_2r);
K48r = K20r*cos(q_2r) - K16r*sin(q_2r);
K49r = K21r*cos(q_2r) - K17r*sin(q_2r);
K50r = K22r*cos(q_2r) - K18r*sin(q_2r);
K51r = K23r*cos(q_2r);
% \bar{v}_{5r} &= \left[\begin{matrix} - K12r*dpsi - K14r*dq_w - K13r*dq_imu - K15r*dq_torso - K11r*dx & K43r*dpsi + K45r*dq_w + K44r*dq_imu + K46r*dq_torso + K42r*dx & K48r*dpsi + K50r*dq_w + K49r*dq_imu + K51r*dq_torso + K47r*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{5r} &= {}^{5r}A_{4r} \bar\alpha_{4r} + \ddot{q}_{5r} \bar{e}_{5r} + \dot{q}_{5r} \left(\bar\omega_{5r} \times \bar{e}_{5r}\right) 
% \nonumber \\ 
% \bar\alpha_{5r} &= \left[\begin{matrix} ddq_torso*cos(q_1r) - ddq_2r - K4r*ddpsi - K5r*ddq_w - K5r*ddq_imu - K24r & cos(q_2r)*(K42 + ddq_1r + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) - K33r*dq_2r - sin(q_2r)*(K25r + K6r*ddpsi + K7r*ddq_w + K7r*ddq_imu + ddq_torso*sin(q_1r)) & K32r*dq_2r + sin(q_2r)*(K42 + ddq_1r + K28*ddpsi + ddq_w*cos(q_torso) + ddq_imu*cos(q_torso)) + cos(q_2r)*(K25r + K6r*ddpsi + K7r*ddq_w + K7r*ddq_imu + ddq_torso*sin(q_1r)) &  \end{matrix}\right] 
% \nonumber \\ 
K52r = K42*cos(q_2r) - K33r*dq_2r - K25r*sin(q_2r);
K53r = K32r*dq_2r + K25r*cos(q_2r) + K42*sin(q_2r);
% \bar\alpha_{5r} &= \left[\begin{matrix} ddq_torso*cos(q_1r) - ddq_2r - K4r*ddpsi - K5r*ddq_w - K5r*ddq_imu - K24r & K52r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r) & K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{5r} &= {}^{5r}A_{4r} \left(\bar{a}_{4r} + \bar\alpha_{4r} \times \bar{P}_{5r} + \bar\omega_{4r} \times \left(\bar\omega_{4r} \times \bar{P}_{5r}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{5r} &= \left[\begin{matrix} - K26r - K12r*ddpsi - K14r*ddq_w - K13r*ddq_imu - K15r*ddq_torso - K11r*ddx & - cos(q_2r)*(K27r + K16r*ddpsi + K18r*ddq_w + K17r*ddq_imu - K33*ddx) - sin(q_2r)*(K28r + K20r*ddpsi + K22r*ddq_w + K21r*ddq_imu + K23r*ddq_torso + K19r*ddx) & cos(q_2r)*(K28r + K20r*ddpsi + K22r*ddq_w + K21r*ddq_imu + K23r*ddq_torso + K19r*ddx) - sin(q_2r)*(K27r + K16r*ddpsi + K18r*ddq_w + K17r*ddq_imu - K33*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
K54r = - K27r*cos(q_2r) - K28r*sin(q_2r);
K55r = K28r*cos(q_2r) - K27r*sin(q_2r);
% \bar{a}_{5r} &= \left[\begin{matrix} - K26r - K12r*ddpsi - K14r*ddq_w - K13r*ddq_imu - K15r*ddq_torso - K11r*ddx & K54r + K43r*ddpsi + K45r*ddq_w + K44r*ddq_imu + K46r*ddq_torso + K42r*ddx & K55r + K48r*ddpsi + K50r*ddq_w + K49r*ddq_imu + K51r*ddq_torso + K47r*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{5r} &= {}^{5r}A_{4r} \bar{g}_{4r} 
% \nonumber \\ 
% \bar{g}_{5r} &= \left[\begin{matrix} -K29r*g & K47*g*cos(q_2r) - K30r*g*sin(q_2r) & K30r*g*cos(q_2r) + K47*g*sin(q_2r) &  \end{matrix}\right] 
% \nonumber \\ 
K56r = K47*cos(q_2r) - K30r*sin(q_2r);
K57r = K30r*cos(q_2r) + K47*sin(q_2r);
% \bar{g}_{5r} &= \left[\begin{matrix} -K29r*g & K56r*g & K57r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{5r}\bar{S}_{5r}^{\times}\bar{g}_{5r} &= \mathbf{MS}_{5r} \times \bar{g}_{5r} 
% \nonumber \\ 
% m_{5r}\bar{S}_{5r}^{\times}\bar{g}_{5r} &= \left[\begin{matrix} K57r*MY_5r*g - K56r*MZ_5r*g & - K57r*MX_5r*g - K29r*MZ_5r*g & K56r*MX_5r*g + K29r*MY_5r*g &  \end{matrix}\right] 
% \nonumber \\ 
D40r = K57r*MY_5r - K56r*MZ_5r;
D41r = - K57r*MX_5r - K29r*MZ_5r;
D42r = K56r*MX_5r + K29r*MY_5r;
% m_{5r}\bar{S}_{5r}^{\times}\bar{g}_{5r} &= \left[\begin{matrix} D40r*g & D41r*g & D42r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{5r}\bar{a}_{G(5r)} &= m_{5r}\bar{a}_{5r} + \bar\alpha_{5r} \times \mathbf{MS}_{5r} + \bar\omega_{5r} \times \left(\bar\omega_{5r} \times \mathbf{MS}_{5r}\right) 
% \nonumber \\ 
% m_{5r}\bar{a}_{G(5r)} &= \left[\begin{matrix} MZ_5r*(K52r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) - MY_5r*(K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r)) - m_5r*(K26r + K12r*ddpsi + K14r*ddq_w + K13r*ddq_imu + K15r*ddq_torso + K11r*ddx) - K32r*(K32r*MX_5r - K31r*MY_5r) - K33r*(K33r*MX_5r - K31r*MZ_5r) & MX_5r*(K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r)) + MZ_5r*(K24r + ddq_2r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) + m_5r*(K54r + K43r*ddpsi + K45r*ddq_w + K44r*ddq_imu + K46r*ddq_torso + K42r*ddx) + K31r*(K32r*MX_5r - K31r*MY_5r) - K33r*(K33r*MY_5r - K32r*MZ_5r) & m_5r*(K55r + K48r*ddpsi + K50r*ddq_w + K49r*ddq_imu + K51r*ddq_torso + K47r*ddx) - MY_5r*(K24r + ddq_2r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) - MX_5r*(K52r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) + K31r*(K33r*MX_5r - K31r*MZ_5r) + K32r*(K33r*MY_5r - K32r*MZ_5r) &  \end{matrix}\right] 
% \nonumber \\ 
D43r = -K11r*m_5r;
D44r = K34r*MZ_5r - K37r*MY_5r - K12r*m_5r;
D45r = K35r*MZ_5r - K38r*MY_5r - K13r*m_5r;
D46r = K35r*MZ_5r - K38r*MY_5r - K14r*m_5r;
D47r = K36r*MZ_5r - K39r*MY_5r - K15r*m_5r;
D48r = MZ_5r*cos(q_2r) - MY_5r*sin(q_2r);
D49r = K52r*MZ_5r - K32r^2*MX_5r - K33r^2*MX_5r - K53r*MY_5r - K26r*m_5r + K31r*K32r*MY_5r + K31r*K33r*MZ_5r;
D50r = K42r*m_5r;
D51r = K43r*m_5r + K37r*MX_5r + K4r*MZ_5r;
D52r = K44r*m_5r + K38r*MX_5r + K5r*MZ_5r;
D53r = K45r*m_5r + K38r*MX_5r + K5r*MZ_5r;
D54r = K46r*m_5r - MZ_5r*cos(q_1r) + K39r*MX_5r;
D55r = MX_5r*sin(q_2r);
D56r = K54r*m_5r - K31r^2*MY_5r - K33r^2*MY_5r + K53r*MX_5r + K24r*MZ_5r + K31r*K32r*MX_5r + K32r*K33r*MZ_5r;
D57r = K47r*m_5r;
D58r = K48r*m_5r - K34r*MX_5r - K4r*MY_5r;
D59r = K49r*m_5r - K35r*MX_5r - K5r*MY_5r;
D60r = K50r*m_5r - K35r*MX_5r - K5r*MY_5r;
D61r = K51r*m_5r + MY_5r*cos(q_1r) - K36r*MX_5r;
D62r = -MX_5r*cos(q_2r);
D63r = K55r*m_5r - K31r^2*MZ_5r - K32r^2*MZ_5r - K52r*MX_5r - K24r*MY_5r + K31r*K33r*MX_5r + K32r*K33r*MY_5r;
% m_{5r}\bar{a}_{G(5r)} &= \left[\begin{matrix} D49r + D44r*ddpsi + D48r*ddq_1r + D46r*ddq_w + D45r*ddq_imu + D47r*ddq_torso + D43r*ddx & D56r + D51r*ddpsi + D55r*ddq_1r + D53r*ddq_w + D52r*ddq_imu + D54r*ddq_torso + D50r*ddx + MZ_5r*ddq_2r & D63r + D58r*ddpsi + D62r*ddq_1r + D60r*ddq_w + D59r*ddq_imu + D61r*ddq_torso + D57r*ddx - MY_5r*ddq_2r &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{5r} &= \mathbf{MS}_{5r} \times \bar{a}_{5r} + J_{5r}\bar{\alpha}_{5r} + \bar\omega_{5r} \times J_{5r}\bar{\omega}_{5r} 
% \nonumber \\ 
% \dot{\bar{H}}_{5r} &= \left[\begin{matrix} K32r*(K31r*XZ_5r + K32r*YZ_5r + K33r*ZZ_5r) - K33r*(K31r*XY_5r + K32r*YY_5r + K33r*YZ_5r) + XY_5r*(K52r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) + XZ_5r*(K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r)) - XX_5r*(K24r + ddq_2r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) + MY_5r*(K55r + K48r*ddpsi + K50r*ddq_w + K49r*ddq_imu + K51r*ddq_torso + K47r*ddx) - MZ_5r*(K54r + K43r*ddpsi + K45r*ddq_w + K44r*ddq_imu + K46r*ddq_torso + K42r*ddx) & K33r*(K31r*XX_5r + K32r*XY_5r + K33r*XZ_5r) - K31r*(K31r*XZ_5r + K32r*YZ_5r + K33r*ZZ_5r) + YY_5r*(K52r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) + YZ_5r*(K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r)) - XY_5r*(K24r + ddq_2r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) - MX_5r*(K55r + K48r*ddpsi + K50r*ddq_w + K49r*ddq_imu + K51r*ddq_torso + K47r*ddx) - MZ_5r*(K26r + K12r*ddpsi + K14r*ddq_w + K13r*ddq_imu + K15r*ddq_torso + K11r*ddx) & K31r*(K31r*XY_5r + K32r*YY_5r + K33r*YZ_5r) - K32r*(K31r*XX_5r + K32r*XY_5r + K33r*XZ_5r) + YZ_5r*(K52r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) + ZZ_5r*(K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r)) - XZ_5r*(K24r + ddq_2r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) + MX_5r*(K54r + K43r*ddpsi + K45r*ddq_w + K44r*ddq_imu + K46r*ddq_torso + K42r*ddx) + MY_5r*(K26r + K12r*ddpsi + K14r*ddq_w + K13r*ddq_imu + K15r*ddq_torso + K11r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D64r = K47r*MY_5r - K42r*MZ_5r;
D65r = K34r*XY_5r - K4r*XX_5r + K37r*XZ_5r + K48r*MY_5r - K43r*MZ_5r;
D66r = K35r*XY_5r - K5r*XX_5r + K38r*XZ_5r + K49r*MY_5r - K44r*MZ_5r;
D67r = K35r*XY_5r - K5r*XX_5r + K38r*XZ_5r + K50r*MY_5r - K45r*MZ_5r;
D68r = K36r*XY_5r + K39r*XZ_5r + XX_5r*cos(q_1r) + K51r*MY_5r - K46r*MZ_5r;
D69r = XY_5r*cos(q_2r) + XZ_5r*sin(q_2r);
D70r = K52r*XY_5r - K24r*XX_5r + K53r*XZ_5r + K32r^2*YZ_5r - K33r^2*YZ_5r + K55r*MY_5r - K54r*MZ_5r - K31r*K33r*XY_5r + K31r*K32r*XZ_5r - K32r*K33r*YY_5r + K32r*K33r*ZZ_5r;
D71r = - K47r*MX_5r - K11r*MZ_5r;
D72r = K34r*YY_5r - K4r*XY_5r + K37r*YZ_5r - K48r*MX_5r - K12r*MZ_5r;
D73r = K35r*YY_5r - K5r*XY_5r + K38r*YZ_5r - K49r*MX_5r - K13r*MZ_5r;
D74r = K35r*YY_5r - K5r*XY_5r + K38r*YZ_5r - K50r*MX_5r - K14r*MZ_5r;
D75r = K36r*YY_5r + K39r*YZ_5r + XY_5r*cos(q_1r) - K51r*MX_5r - K15r*MZ_5r;
D76r = YY_5r*cos(q_2r) + YZ_5r*sin(q_2r);
D77r = K52r*YY_5r - K24r*XY_5r + K53r*YZ_5r - K31r^2*XZ_5r + K33r^2*XZ_5r - K55r*MX_5r - K26r*MZ_5r + K31r*K33r*XX_5r + K32r*K33r*XY_5r - K31r*K32r*YZ_5r - K31r*K33r*ZZ_5r;
D78r = K42r*MX_5r + K11r*MY_5r;
D79r = K34r*YZ_5r - K4r*XZ_5r + K37r*ZZ_5r + K43r*MX_5r + K12r*MY_5r;
D80r = K35r*YZ_5r - K5r*XZ_5r + K38r*ZZ_5r + K44r*MX_5r + K13r*MY_5r;
D81r = K35r*YZ_5r - K5r*XZ_5r + K38r*ZZ_5r + K45r*MX_5r + K14r*MY_5r;
D82r = K36r*YZ_5r + K39r*ZZ_5r + XZ_5r*cos(q_1r) + K46r*MX_5r + K15r*MY_5r;
D83r = YZ_5r*cos(q_2r) + ZZ_5r*sin(q_2r);
D84r = K52r*YZ_5r - K24r*XZ_5r + K53r*ZZ_5r + K31r^2*XY_5r - K32r^2*XY_5r + K54r*MX_5r + K26r*MY_5r - K31r*K32r*XX_5r - K32r*K33r*XZ_5r + K31r*K32r*YY_5r + K31r*K33r*YZ_5r;
% \dot{\bar{H}}_{5r} &= \left[\begin{matrix} D49r + D44r*ddpsi + D48r*ddq_1r + D46r*ddq_w + D45r*ddq_imu + D47r*ddq_torso + D43r*ddx & D56r + D51r*ddpsi + D55r*ddq_1r + D53r*ddq_w + D52r*ddq_imu + D54r*ddq_torso + D50r*ddx + MZ_5r*ddq_2r & D63r + D58r*ddpsi + D62r*ddq_1r + D60r*ddq_w + D59r*ddq_imu + D61r*ddq_torso + D57r*ddx - MY_5r*ddq_2r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{6r} &= {}^{6r}A_{5r} \bar\omega_{5r} + \dot{q}_{6r} \bar{e}_{6r} 
% \nonumber \\ 
% \bar\omega_{6r} &= \left[\begin{matrix} K33r*sin(q_3r) - K31r*cos(q_3r) & - K32r - dq_3r & K33r*cos(q_3r) + K31r*sin(q_3r) &  \end{matrix}\right] 
% \nonumber \\ 
K58r = K33r*sin(q_3r) - K31r*cos(q_3r);
K59r = - K32r - dq_3r;
K60r = K33r*cos(q_3r) + K31r*sin(q_3r);
% \bar\omega_{6r} &= \left[\begin{matrix} K58r & K59r & K60r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{6r} &= \left[\begin{matrix} sin(q_3r)*(K37r*dpsi + K38r*dq_w + K38r*dq_imu + K39r*dq_torso + dq_1r*sin(q_2r)) + cos(q_3r)*(dq_2r + K4r*dpsi + K5r*dq_w + K5r*dq_imu - dq_torso*cos(q_1r)) & - dq_3r - K34r*dpsi - K35r*dq_w - K35r*dq_imu - K36r*dq_torso - dq_1r*cos(q_2r) & cos(q_3r)*(K37r*dpsi + K38r*dq_w + K38r*dq_imu + K39r*dq_torso + dq_1r*sin(q_2r)) - sin(q_3r)*(dq_2r + K4r*dpsi + K5r*dq_w + K5r*dq_imu - dq_torso*cos(q_1r)) &  \end{matrix}\right] 
% \nonumber \\ 
K61r = K4r*cos(q_3r) + K37r*sin(q_3r);
K62r = K5r*cos(q_3r) + K38r*sin(q_3r);
K63r = K39r*sin(q_3r) - cos(q_1r)*cos(q_3r);
K64r = sin(q_2r)*sin(q_3r);
K65r = K37r*cos(q_3r) - K4r*sin(q_3r);
K66r = K38r*cos(q_3r) - K5r*sin(q_3r);
K67r = cos(q_1r)*sin(q_3r) + K39r*cos(q_3r);
K68r = cos(q_3r)*sin(q_2r);
% \bar\omega_{6r} &= \left[\begin{matrix} K61r*dpsi + K64r*dq_1r + K62r*dq_w + K62r*dq_imu + K63r*dq_torso + dq_2r*cos(q_3r) & - dq_3r - K34r*dpsi - K35r*dq_w - K35r*dq_imu - K36r*dq_torso - dq_1r*cos(q_2r) & K65r*dpsi + K68r*dq_1r + K66r*dq_w + K66r*dq_imu + K67r*dq_torso - dq_2r*sin(q_3r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{6r} &= {}^{6r}A_{5r} \left(\bar{v}_{5r} + \bar\omega_{5r} \times \bar{P}_{6r}\right) 
% \nonumber \\ 
% \bar{v}_{6r} &= \left[\begin{matrix} cos(q_3r)*(K8r - K33r*L7) + sin(q_3r)*(K41r - K31r*L7) & -K40r & cos(q_3r)*(K41r - K31r*L7) - sin(q_3r)*(K8r - K33r*L7) &  \end{matrix}\right] 
% \nonumber \\ 
K69r = cos(q_3r)*(K8r - K33r*L7) + sin(q_3r)*(K41r - K31r*L7);
K70r = cos(q_3r)*(K41r - K31r*L7) - sin(q_3r)*(K8r - K33r*L7);
% \bar{v}_{6r} &= \left[\begin{matrix} K69r & -K40r & K70r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{6r} &= \left[\begin{matrix} sin(q_3r)*(K48r*dpsi + K50r*dq_w + K49r*dq_imu + K51r*dq_torso + K47r*dx + L7*(dq_2r + K4r*dpsi + K5r*dq_w + K5r*dq_imu - dq_torso*cos(q_1r))) + cos(q_3r)*(K12r*dpsi + K14r*dq_w + K13r*dq_imu + K15r*dq_torso + K11r*dx - L7*(K37r*dpsi + K38r*dq_w + K38r*dq_imu + K39r*dq_torso + dq_1r*sin(q_2r))) & - K43r*dpsi - K45r*dq_w - K44r*dq_imu - K46r*dq_torso - K42r*dx & cos(q_3r)*(K48r*dpsi + K50r*dq_w + K49r*dq_imu + K51r*dq_torso + K47r*dx + L7*(dq_2r + K4r*dpsi + K5r*dq_w + K5r*dq_imu - dq_torso*cos(q_1r))) - sin(q_3r)*(K12r*dpsi + K14r*dq_w + K13r*dq_imu + K15r*dq_torso + K11r*dx - L7*(K37r*dpsi + K38r*dq_w + K38r*dq_imu + K39r*dq_torso + dq_1r*sin(q_2r))) &  \end{matrix}\right] 
% \nonumber \\ 
K71r = K11r*cos(q_3r) + K47r*sin(q_3r);
K72r = cos(q_3r)*(K12r - K37r*L7) + sin(q_3r)*(K48r + K4r*L7);
K73r = cos(q_3r)*(K13r - K38r*L7) + sin(q_3r)*(K49r + K5r*L7);
K74r = cos(q_3r)*(K14r - K38r*L7) + sin(q_3r)*(K50r + K5r*L7);
K75r = sin(q_3r)*(K51r - L7*cos(q_1r)) + cos(q_3r)*(K15r - K39r*L7);
K76r = -L7*cos(q_3r)*sin(q_2r);
K77r = L7*sin(q_3r);
K78r = K47r*cos(q_3r) - K11r*sin(q_3r);
K79r = cos(q_3r)*(K48r + K4r*L7) - sin(q_3r)*(K12r - K37r*L7);
K80r = cos(q_3r)*(K49r + K5r*L7) - sin(q_3r)*(K13r - K38r*L7);
K81r = cos(q_3r)*(K50r + K5r*L7) - sin(q_3r)*(K14r - K38r*L7);
K82r = cos(q_3r)*(K51r - L7*cos(q_1r)) - sin(q_3r)*(K15r - K39r*L7);
K83r = L7*sin(q_2r)*sin(q_3r);
K84r = L7*cos(q_3r);
% \bar{v}_{6r} &= \left[\begin{matrix} K72r*dpsi + K76r*dq_1r + K74r*dq_w + K77r*dq_2r + K73r*dq_imu + K75r*dq_torso + K71r*dx & - K43r*dpsi - K45r*dq_w - K44r*dq_imu - K46r*dq_torso - K42r*dx & K79r*dpsi + K83r*dq_1r + K81r*dq_w + K84r*dq_2r + K80r*dq_imu + K82r*dq_torso + K78r*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{6r} &= {}^{6r}A_{5r} \bar\alpha_{5r} + \ddot{q}_{6r} \bar{e}_{6r} + \dot{q}_{6r} \left(\bar\omega_{6r} \times \bar{e}_{6r}\right) 
% \nonumber \\ 
% \bar\alpha_{6r} &= \left[\begin{matrix} cos(q_3r)*(K24r + ddq_2r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) + K60r*dq_3r + sin(q_3r)*(K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r)) & - K52r - ddq_3r - K34r*ddpsi - K35r*ddq_w - K35r*ddq_imu - K36r*ddq_torso - ddq_1r*cos(q_2r) & cos(q_3r)*(K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r)) - sin(q_3r)*(K24r + ddq_2r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) - K58r*dq_3r &  \end{matrix}\right] 
% \nonumber \\ 
K85r = K60r*dq_3r + K24r*cos(q_3r) + K53r*sin(q_3r);
K86r = K53r*cos(q_3r) - K58r*dq_3r - K24r*sin(q_3r);
% \bar\alpha_{6r} &= \left[\begin{matrix} K85r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r) & - K52r - ddq_3r - K34r*ddpsi - K35r*ddq_w - K35r*ddq_imu - K36r*ddq_torso - ddq_1r*cos(q_2r) & K86r + K65r*ddpsi + K68r*ddq_1r + K66r*ddq_w + K66r*ddq_imu + K67r*ddq_torso - ddq_2r*sin(q_3r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{6r} &= {}^{6r}A_{5r} \left(\bar{a}_{5r} + \bar\alpha_{5r} \times \bar{P}_{6r} + \bar\omega_{5r} \times \left(\bar\omega_{5r} \times \bar{P}_{6r}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{6r} &= \left[\begin{matrix} cos(q_3r)*(K26r + K12r*ddpsi + K14r*ddq_w + K13r*ddq_imu + K15r*ddq_torso + K11r*ddx - L7*(K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r)) + K31r*K32r*L7) + sin(q_3r)*(K55r + K48r*ddpsi + K50r*ddq_w + K49r*ddq_imu + K51r*ddq_torso + K47r*ddx + L7*(K24r + ddq_2r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) - K32r*K33r*L7) & - K54r - K43r*ddpsi - K45r*ddq_w - K44r*ddq_imu - K46r*ddq_torso - K42r*ddx - K31r^2*L7 - K33r^2*L7 & cos(q_3r)*(K55r + K48r*ddpsi + K50r*ddq_w + K49r*ddq_imu + K51r*ddq_torso + K47r*ddx + L7*(K24r + ddq_2r + K4r*ddpsi + K5r*ddq_w + K5r*ddq_imu - ddq_torso*cos(q_1r)) - K32r*K33r*L7) - sin(q_3r)*(K26r + K12r*ddpsi + K14r*ddq_w + K13r*ddq_imu + K15r*ddq_torso + K11r*ddx - L7*(K53r + K37r*ddpsi + K38r*ddq_w + K38r*ddq_imu + K39r*ddq_torso + ddq_1r*sin(q_2r)) + K31r*K32r*L7) &  \end{matrix}\right] 
% \nonumber \\ 
K87r = K26r*cos(q_3r) + K55r*sin(q_3r) - K53r*L7*cos(q_3r) + K24r*L7*sin(q_3r) + K31r*K32r*L7*cos(q_3r) - K32r*K33r*L7*sin(q_3r);
K88r = - K54r - K31r^2*L7 - K33r^2*L7;
K89r = K55r*cos(q_3r) - K26r*sin(q_3r) + K24r*L7*cos(q_3r) + K53r*L7*sin(q_3r) - K32r*K33r*L7*cos(q_3r) - K31r*K32r*L7*sin(q_3r);
% \bar{a}_{6r} &= \left[\begin{matrix} K87r + K72r*ddpsi + K76r*ddq_1r + K74r*ddq_w + K77r*ddq_2r + K73r*ddq_imu + K75r*ddq_torso + K71r*ddx & K88r - K43r*ddpsi - K45r*ddq_w - K44r*ddq_imu - K46r*ddq_torso - K42r*ddx & K89r + K79r*ddpsi + K83r*ddq_1r + K81r*ddq_w + K84r*ddq_2r + K80r*ddq_imu + K82r*ddq_torso + K78r*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{6r} &= {}^{6r}A_{5r} \bar{g}_{5r} 
% \nonumber \\ 
% \bar{g}_{6r} &= \left[\begin{matrix} K29r*g*cos(q_3r) + K57r*g*sin(q_3r) & -K56r*g & K57r*g*cos(q_3r) - K29r*g*sin(q_3r) &  \end{matrix}\right] 
% \nonumber \\ 
K90r = K29r*cos(q_3r) + K57r*sin(q_3r);
K91r = K57r*cos(q_3r) - K29r*sin(q_3r);
% \bar{g}_{6r} &= \left[\begin{matrix} K90r*g & -K56r*g & K91r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{6r}\bar{S}_{6r}^{\times}\bar{g}_{6r} &= \mathbf{MS}_{6r} \times \bar{g}_{6r} 
% \nonumber \\ 
% m_{6r}\bar{S}_{6r}^{\times}\bar{g}_{6r} &= \left[\begin{matrix} K91r*MY_6r*g + K56r*MZ_6r*g & K90r*MZ_6r*g - K91r*MX_6r*g & - K56r*MX_6r*g - K90r*MY_6r*g &  \end{matrix}\right] 
% \nonumber \\ 
D85r = K91r*MY_6r + K56r*MZ_6r;
D86r = K90r*MZ_6r - K91r*MX_6r;
D87r = - K56r*MX_6r - K90r*MY_6r;
% m_{6r}\bar{S}_{6r}^{\times}\bar{g}_{6r} &= \left[\begin{matrix} D85r*g & D86r*g & D87r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{6r}\bar{a}_{G(6r)} &= m_{6r}\bar{a}_{6r} + \bar\alpha_{6r} \times \mathbf{MS}_{6r} + \bar\omega_{6r} \times \left(\bar\omega_{6r} \times \mathbf{MS}_{6r}\right) 
% \nonumber \\ 
% m_{6r}\bar{a}_{G(6r)} &= \left[\begin{matrix} m_6r*(K87r + K72r*ddpsi + K76r*ddq_1r + K74r*ddq_w + K77r*ddq_2r + K73r*ddq_imu + K75r*ddq_torso + K71r*ddx) - MZ_6r*(K52r + ddq_3r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) - MY_6r*(K86r + K65r*ddpsi + K68r*ddq_1r + K66r*ddq_w + K66r*ddq_imu + K67r*ddq_torso - ddq_2r*sin(q_3r)) - K59r*(K59r*MX_6r - K58r*MY_6r) - K60r*(K60r*MX_6r - K58r*MZ_6r) & MX_6r*(K86r + K65r*ddpsi + K68r*ddq_1r + K66r*ddq_w + K66r*ddq_imu + K67r*ddq_torso - ddq_2r*sin(q_3r)) - MZ_6r*(K85r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) - m_6r*(K43r*ddpsi - K88r + K45r*ddq_w + K44r*ddq_imu + K46r*ddq_torso + K42r*ddx) + K58r*(K59r*MX_6r - K58r*MY_6r) - K60r*(K60r*MY_6r - K59r*MZ_6r) & MY_6r*(K85r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) + MX_6r*(K52r + ddq_3r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) + m_6r*(K89r + K79r*ddpsi + K83r*ddq_1r + K81r*ddq_w + K84r*ddq_2r + K80r*ddq_imu + K82r*ddq_torso + K78r*ddx) + K58r*(K60r*MX_6r - K58r*MZ_6r) + K59r*(K60r*MY_6r - K59r*MZ_6r) &  \end{matrix}\right] 
% \nonumber \\ 
D88r = K71r*m_6r;
D89r = K72r*m_6r - K65r*MY_6r - K34r*MZ_6r;
D90r = K73r*m_6r - K66r*MY_6r - K35r*MZ_6r;
D91r = K74r*m_6r - K66r*MY_6r - K35r*MZ_6r;
D92r = K75r*m_6r - K67r*MY_6r - K36r*MZ_6r;
D93r = K76r*m_6r - MZ_6r*cos(q_2r) - K68r*MY_6r;
D94r = K77r*m_6r + MY_6r*sin(q_3r);
D95r = K87r*m_6r - K59r^2*MX_6r - K60r^2*MX_6r - K86r*MY_6r - K52r*MZ_6r + K58r*K59r*MY_6r + K58r*K60r*MZ_6r;
D96r = -K42r*m_6r;
D97r = K65r*MX_6r - K43r*m_6r - K61r*MZ_6r;
D98r = K66r*MX_6r - K44r*m_6r - K62r*MZ_6r;
D99r = K66r*MX_6r - K45r*m_6r - K62r*MZ_6r;
D100r = K67r*MX_6r - K46r*m_6r - K63r*MZ_6r;
D101r = K68r*MX_6r - K64r*MZ_6r;
D102r = - MZ_6r*cos(q_3r) - MX_6r*sin(q_3r);
D103r = K88r*m_6r - K58r^2*MY_6r - K60r^2*MY_6r + K86r*MX_6r - K85r*MZ_6r + K58r*K59r*MX_6r + K59r*K60r*MZ_6r;
D104r = K78r*m_6r;
D105r = K79r*m_6r + K34r*MX_6r + K61r*MY_6r;
D106r = K80r*m_6r + K35r*MX_6r + K62r*MY_6r;
D107r = K81r*m_6r + K35r*MX_6r + K62r*MY_6r;
D108r = K82r*m_6r + K36r*MX_6r + K63r*MY_6r;
D109r = K83r*m_6r + MX_6r*cos(q_2r) + K64r*MY_6r;
D110r = K84r*m_6r + MY_6r*cos(q_3r);
D111r = K89r*m_6r - K58r^2*MZ_6r - K59r^2*MZ_6r + K52r*MX_6r + K85r*MY_6r + K58r*K60r*MX_6r + K59r*K60r*MY_6r;
% m_{6r}\bar{a}_{G(6r)} &= \left[\begin{matrix} D95r + D89r*ddpsi + D93r*ddq_1r + D91r*ddq_w + D94r*ddq_2r + D90r*ddq_imu + D92r*ddq_torso + D88r*ddx - MZ_6r*ddq_3r & D103r + D97r*ddpsi + D101r*ddq_1r + D99r*ddq_w + D102r*ddq_2r + D98r*ddq_imu + D100r*ddq_torso + D96r*ddx & D111r + D105r*ddpsi + D109r*ddq_1r + D107r*ddq_w + D110r*ddq_2r + D106r*ddq_imu + D108r*ddq_torso + D104r*ddx + MX_6r*ddq_3r &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{6r} &= \mathbf{MS}_{6r} \times \bar{a}_{6r} + J_{6r}\bar{\alpha}_{6r} + \bar\omega_{6r} \times J_{6r}\bar{\omega}_{6r} 
% \nonumber \\ 
% \dot{\bar{H}}_{6r} &= \left[\begin{matrix} MZ_6r*(K43r*ddpsi - K88r + K45r*ddq_w + K44r*ddq_imu + K46r*ddq_torso + K42r*ddx) - K60r*(K58r*XY_6r + K59r*YY_6r + K60r*YZ_6r) + K59r*(K58r*XZ_6r + K59r*YZ_6r + K60r*ZZ_6r) + XX_6r*(K85r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) + XZ_6r*(K86r + K65r*ddpsi + K68r*ddq_1r + K66r*ddq_w + K66r*ddq_imu + K67r*ddq_torso - ddq_2r*sin(q_3r)) - XY_6r*(K52r + ddq_3r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) + MY_6r*(K89r + K79r*ddpsi + K83r*ddq_1r + K81r*ddq_w + K84r*ddq_2r + K80r*ddq_imu + K82r*ddq_torso + K78r*ddx) & K60r*(K58r*XX_6r + K59r*XY_6r + K60r*XZ_6r) - K58r*(K58r*XZ_6r + K59r*YZ_6r + K60r*ZZ_6r) + XY_6r*(K85r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) + YZ_6r*(K86r + K65r*ddpsi + K68r*ddq_1r + K66r*ddq_w + K66r*ddq_imu + K67r*ddq_torso - ddq_2r*sin(q_3r)) - YY_6r*(K52r + ddq_3r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) - MX_6r*(K89r + K79r*ddpsi + K83r*ddq_1r + K81r*ddq_w + K84r*ddq_2r + K80r*ddq_imu + K82r*ddq_torso + K78r*ddx) + MZ_6r*(K87r + K72r*ddpsi + K76r*ddq_1r + K74r*ddq_w + K77r*ddq_2r + K73r*ddq_imu + K75r*ddq_torso + K71r*ddx) & K58r*(K58r*XY_6r + K59r*YY_6r + K60r*YZ_6r) - K59r*(K58r*XX_6r + K59r*XY_6r + K60r*XZ_6r) - MX_6r*(K43r*ddpsi - K88r + K45r*ddq_w + K44r*ddq_imu + K46r*ddq_torso + K42r*ddx) + XZ_6r*(K85r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) + ZZ_6r*(K86r + K65r*ddpsi + K68r*ddq_1r + K66r*ddq_w + K66r*ddq_imu + K67r*ddq_torso - ddq_2r*sin(q_3r)) - YZ_6r*(K52r + ddq_3r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) - MY_6r*(K87r + K72r*ddpsi + K76r*ddq_1r + K74r*ddq_w + K77r*ddq_2r + K73r*ddq_imu + K75r*ddq_torso + K71r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D112r = K78r*MY_6r + K42r*MZ_6r;
D113r = K61r*XX_6r - K34r*XY_6r + K65r*XZ_6r + K79r*MY_6r + K43r*MZ_6r;
D114r = K62r*XX_6r - K35r*XY_6r + K66r*XZ_6r + K80r*MY_6r + K44r*MZ_6r;
D115r = K62r*XX_6r - K35r*XY_6r + K66r*XZ_6r + K81r*MY_6r + K45r*MZ_6r;
D116r = K63r*XX_6r - K36r*XY_6r + K67r*XZ_6r + K82r*MY_6r + K46r*MZ_6r;
D117r = K64r*XX_6r + K68r*XZ_6r - XY_6r*cos(q_2r) + K83r*MY_6r;
D118r = XX_6r*cos(q_3r) - XZ_6r*sin(q_3r) + K84r*MY_6r;
D119r = K85r*XX_6r - K52r*XY_6r + K86r*XZ_6r + K59r^2*YZ_6r - K60r^2*YZ_6r + K89r*MY_6r - K88r*MZ_6r - K58r*K60r*XY_6r + K58r*K59r*XZ_6r - K59r*K60r*YY_6r + K59r*K60r*ZZ_6r;
D120r = K71r*MZ_6r - K78r*MX_6r;
D121r = K61r*XY_6r - K34r*YY_6r + K65r*YZ_6r - K79r*MX_6r + K72r*MZ_6r;
D122r = K62r*XY_6r - K35r*YY_6r + K66r*YZ_6r - K80r*MX_6r + K73r*MZ_6r;
D123r = K62r*XY_6r - K35r*YY_6r + K66r*YZ_6r - K81r*MX_6r + K74r*MZ_6r;
D124r = K63r*XY_6r - K36r*YY_6r + K67r*YZ_6r - K82r*MX_6r + K75r*MZ_6r;
D125r = K64r*XY_6r + K68r*YZ_6r - YY_6r*cos(q_2r) - K83r*MX_6r + K76r*MZ_6r;
D126r = XY_6r*cos(q_3r) - YZ_6r*sin(q_3r) - K84r*MX_6r + K77r*MZ_6r;
D127r = K85r*XY_6r - K52r*YY_6r + K86r*YZ_6r - K58r^2*XZ_6r + K60r^2*XZ_6r - K89r*MX_6r + K87r*MZ_6r + K58r*K60r*XX_6r + K59r*K60r*XY_6r - K58r*K59r*YZ_6r - K58r*K60r*ZZ_6r;
D128r = - K42r*MX_6r - K71r*MY_6r;
D129r = K61r*XZ_6r - K34r*YZ_6r + K65r*ZZ_6r - K43r*MX_6r - K72r*MY_6r;
D130r = K62r*XZ_6r - K35r*YZ_6r + K66r*ZZ_6r - K44r*MX_6r - K73r*MY_6r;
D131r = K62r*XZ_6r - K35r*YZ_6r + K66r*ZZ_6r - K45r*MX_6r - K74r*MY_6r;
D132r = K63r*XZ_6r - K36r*YZ_6r + K67r*ZZ_6r - K46r*MX_6r - K75r*MY_6r;
D133r = K64r*XZ_6r + K68r*ZZ_6r - YZ_6r*cos(q_2r) - K76r*MY_6r;
D134r = XZ_6r*cos(q_3r) - ZZ_6r*sin(q_3r) - K77r*MY_6r;
D135r = K85r*XZ_6r - K52r*YZ_6r + K86r*ZZ_6r + K58r^2*XY_6r - K59r^2*XY_6r + K88r*MX_6r - K87r*MY_6r - K58r*K59r*XX_6r - K59r*K60r*XZ_6r + K58r*K59r*YY_6r + K58r*K60r*YZ_6r;
% \dot{\bar{H}}_{6r} &= \left[\begin{matrix} D95r + D89r*ddpsi + D93r*ddq_1r + D91r*ddq_w + D94r*ddq_2r + D90r*ddq_imu + D92r*ddq_torso + D88r*ddx - MZ_6r*ddq_3r & D103r + D97r*ddpsi + D101r*ddq_1r + D99r*ddq_w + D102r*ddq_2r + D98r*ddq_imu + D100r*ddq_torso + D96r*ddx & D111r + D105r*ddpsi + D109r*ddq_1r + D107r*ddq_w + D110r*ddq_2r + D106r*ddq_imu + D108r*ddq_torso + D104r*ddx + MX_6r*ddq_3r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{7r} &= {}^{7r}A_{6r} \bar\omega_{6r} + \dot{q}_{7r} \bar{e}_{7r} 
% \nonumber \\ 
% \bar\omega_{7r} &= \left[\begin{matrix} - K58r - dq_4r & - K59r*cos(q_4r) - K60r*sin(q_4r) & K60r*cos(q_4r) - K59r*sin(q_4r) &  \end{matrix}\right] 
% \nonumber \\ 
K92r = - K58r - dq_4r;
K93r = - K59r*cos(q_4r) - K60r*sin(q_4r);
K94r = K60r*cos(q_4r) - K59r*sin(q_4r);
% \bar\omega_{7r} &= \left[\begin{matrix} K92r & K93r & K94r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{7r} &= \left[\begin{matrix} - dq_4r - K61r*dpsi - K64r*dq_1r - K62r*dq_w - K62r*dq_imu - K63r*dq_torso - dq_2r*cos(q_3r) & cos(q_4r)*(dq_3r + K34r*dpsi + K35r*dq_w + K35r*dq_imu + K36r*dq_torso + dq_1r*cos(q_2r)) - sin(q_4r)*(K65r*dpsi + K68r*dq_1r + K66r*dq_w + K66r*dq_imu + K67r*dq_torso - dq_2r*sin(q_3r)) & cos(q_4r)*(K65r*dpsi + K68r*dq_1r + K66r*dq_w + K66r*dq_imu + K67r*dq_torso - dq_2r*sin(q_3r)) + sin(q_4r)*(dq_3r + K34r*dpsi + K35r*dq_w + K35r*dq_imu + K36r*dq_torso + dq_1r*cos(q_2r)) &  \end{matrix}\right] 
% \nonumber \\ 
K95r = K34r*cos(q_4r) - K65r*sin(q_4r);
K96r = K35r*cos(q_4r) - K66r*sin(q_4r);
K97r = K36r*cos(q_4r) - K67r*sin(q_4r);
K98r = cos(q_2r)*cos(q_4r) - K68r*sin(q_4r);
K99r = sin(q_3r)*sin(q_4r);
K100r = K65r*cos(q_4r) + K34r*sin(q_4r);
K101r = K66r*cos(q_4r) + K35r*sin(q_4r);
K102r = K67r*cos(q_4r) + K36r*sin(q_4r);
K103r = cos(q_2r)*sin(q_4r) + K68r*cos(q_4r);
K104r = -cos(q_4r)*sin(q_3r);
% \bar\omega_{7r} &= \left[\begin{matrix} - dq_4r - K61r*dpsi - K64r*dq_1r - K62r*dq_w - K62r*dq_imu - K63r*dq_torso - dq_2r*cos(q_3r) & K95r*dpsi + K98r*dq_1r + K96r*dq_w + K99r*dq_2r + K96r*dq_imu + K97r*dq_torso + dq_3r*cos(q_4r) & K100r*dpsi + K103r*dq_1r + K101r*dq_w + K104r*dq_2r + K101r*dq_imu + K102r*dq_torso + dq_3r*sin(q_4r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{7r} &= {}^{7r}A_{6r} \left(\bar{v}_{6r} + \bar\omega_{6r} \times \bar{P}_{7r}\right) 
% \nonumber \\ 
% \bar{v}_{7r} &= \left[\begin{matrix} -K69r & K40r*cos(q_4r) - K70r*sin(q_4r) & K70r*cos(q_4r) + K40r*sin(q_4r) &  \end{matrix}\right] 
% \nonumber \\ 
K105r = K40r*cos(q_4r) - K70r*sin(q_4r);
K106r = K70r*cos(q_4r) + K40r*sin(q_4r);
% \bar{v}_{7r} &= \left[\begin{matrix} -K69r & K105r & K106r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{7r} &= \left[\begin{matrix} - K72r*dpsi - K76r*dq_1r - K74r*dq_w - K77r*dq_2r - K73r*dq_imu - K75r*dq_torso - K71r*dx & cos(q_4r)*(K43r*dpsi + K45r*dq_w + K44r*dq_imu + K46r*dq_torso + K42r*dx) - sin(q_4r)*(K79r*dpsi + K83r*dq_1r + K81r*dq_w + K84r*dq_2r + K80r*dq_imu + K82r*dq_torso + K78r*dx) & sin(q_4r)*(K43r*dpsi + K45r*dq_w + K44r*dq_imu + K46r*dq_torso + K42r*dx) + cos(q_4r)*(K79r*dpsi + K83r*dq_1r + K81r*dq_w + K84r*dq_2r + K80r*dq_imu + K82r*dq_torso + K78r*dx) &  \end{matrix}\right] 
% \nonumber \\ 
K107r = K42r*cos(q_4r) - K78r*sin(q_4r);
K108r = K43r*cos(q_4r) - K79r*sin(q_4r);
K109r = K44r*cos(q_4r) - K80r*sin(q_4r);
K110r = K45r*cos(q_4r) - K81r*sin(q_4r);
K111r = K46r*cos(q_4r) - K82r*sin(q_4r);
K112r = -K83r*sin(q_4r);
K113r = -K84r*sin(q_4r);
K114r = K78r*cos(q_4r) + K42r*sin(q_4r);
K115r = K79r*cos(q_4r) + K43r*sin(q_4r);
K116r = K80r*cos(q_4r) + K44r*sin(q_4r);
K117r = K81r*cos(q_4r) + K45r*sin(q_4r);
K118r = K82r*cos(q_4r) + K46r*sin(q_4r);
K119r = K83r*cos(q_4r);
K120r = K84r*cos(q_4r);
% \bar{v}_{7r} &= \left[\begin{matrix} - K72r*dpsi - K76r*dq_1r - K74r*dq_w - K77r*dq_2r - K73r*dq_imu - K75r*dq_torso - K71r*dx & K108r*dpsi + K112r*dq_1r + K110r*dq_w + K113r*dq_2r + K109r*dq_imu + K111r*dq_torso + K107r*dx & K115r*dpsi + K119r*dq_1r + K117r*dq_w + K120r*dq_2r + K116r*dq_imu + K118r*dq_torso + K114r*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{7r} &= {}^{7r}A_{6r} \bar\alpha_{6r} + \ddot{q}_{7r} \bar{e}_{7r} + \dot{q}_{7r} \left(\bar\omega_{7r} \times \bar{e}_{7r}\right) 
% \nonumber \\ 
% \bar\alpha_{7r} &= \left[\begin{matrix} - K85r - ddq_4r - K61r*ddpsi - K64r*ddq_1r - K62r*ddq_w - K62r*ddq_imu - K63r*ddq_torso - ddq_2r*cos(q_3r) & cos(q_4r)*(K52r + ddq_3r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) - K94r*dq_4r - sin(q_4r)*(K86r + K65r*ddpsi + K68r*ddq_1r + K66r*ddq_w + K66r*ddq_imu + K67r*ddq_torso - ddq_2r*sin(q_3r)) & K93r*dq_4r + sin(q_4r)*(K52r + ddq_3r + K34r*ddpsi + K35r*ddq_w + K35r*ddq_imu + K36r*ddq_torso + ddq_1r*cos(q_2r)) + cos(q_4r)*(K86r + K65r*ddpsi + K68r*ddq_1r + K66r*ddq_w + K66r*ddq_imu + K67r*ddq_torso - ddq_2r*sin(q_3r)) &  \end{matrix}\right] 
% \nonumber \\ 
K121r = K52r*cos(q_4r) - K94r*dq_4r - K86r*sin(q_4r);
K122r = K93r*dq_4r + K86r*cos(q_4r) + K52r*sin(q_4r);
% \bar\alpha_{7r} &= \left[\begin{matrix} - K85r - ddq_4r - K61r*ddpsi - K64r*ddq_1r - K62r*ddq_w - K62r*ddq_imu - K63r*ddq_torso - ddq_2r*cos(q_3r) & K121r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r) & K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{7r} &= {}^{7r}A_{6r} \left(\bar{a}_{6r} + \bar\alpha_{6r} \times \bar{P}_{7r} + \bar\omega_{6r} \times \left(\bar\omega_{6r} \times \bar{P}_{7r}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{7r} &= \left[\begin{matrix} - K87r - K72r*ddpsi - K76r*ddq_1r - K74r*ddq_w - K77r*ddq_2r - K73r*ddq_imu - K75r*ddq_torso - K71r*ddx & cos(q_4r)*(K43r*ddpsi - K88r + K45r*ddq_w + K44r*ddq_imu + K46r*ddq_torso + K42r*ddx) - sin(q_4r)*(K89r + K79r*ddpsi + K83r*ddq_1r + K81r*ddq_w + K84r*ddq_2r + K80r*ddq_imu + K82r*ddq_torso + K78r*ddx) & cos(q_4r)*(K89r + K79r*ddpsi + K83r*ddq_1r + K81r*ddq_w + K84r*ddq_2r + K80r*ddq_imu + K82r*ddq_torso + K78r*ddx) + sin(q_4r)*(K43r*ddpsi - K88r + K45r*ddq_w + K44r*ddq_imu + K46r*ddq_torso + K42r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
K123r = - K88r*cos(q_4r) - K89r*sin(q_4r);
K124r = K89r*cos(q_4r) - K88r*sin(q_4r);
% \bar{a}_{7r} &= \left[\begin{matrix} - K87r - K72r*ddpsi - K76r*ddq_1r - K74r*ddq_w - K77r*ddq_2r - K73r*ddq_imu - K75r*ddq_torso - K71r*ddx & K123r + K108r*ddpsi + K112r*ddq_1r + K110r*ddq_w + K113r*ddq_2r + K109r*ddq_imu + K111r*ddq_torso + K107r*ddx & K124r + K115r*ddpsi + K119r*ddq_1r + K117r*ddq_w + K120r*ddq_2r + K116r*ddq_imu + K118r*ddq_torso + K114r*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{7r} &= {}^{7r}A_{6r} \bar{g}_{6r} 
% \nonumber \\ 
% \bar{g}_{7r} &= \left[\begin{matrix} -K90r*g & K56r*g*cos(q_4r) - K91r*g*sin(q_4r) & K91r*g*cos(q_4r) + K56r*g*sin(q_4r) &  \end{matrix}\right] 
% \nonumber \\ 
K125r = K56r*cos(q_4r) - K91r*sin(q_4r);
K126r = K91r*cos(q_4r) + K56r*sin(q_4r);
% \bar{g}_{7r} &= \left[\begin{matrix} -K90r*g & K125r*g & K126r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{7r}\bar{S}_{7r}^{\times}\bar{g}_{7r} &= \mathbf{MS}_{7r} \times \bar{g}_{7r} 
% \nonumber \\ 
% m_{7r}\bar{S}_{7r}^{\times}\bar{g}_{7r} &= \left[\begin{matrix} K126r*MY_7r*g - K125r*MZ_7r*g & - K126r*MX_7r*g - K90r*MZ_7r*g & K125r*MX_7r*g + K90r*MY_7r*g &  \end{matrix}\right] 
% \nonumber \\ 
D136r = K126r*MY_7r - K125r*MZ_7r;
D137r = - K126r*MX_7r - K90r*MZ_7r;
D138r = K125r*MX_7r + K90r*MY_7r;
% m_{7r}\bar{S}_{7r}^{\times}\bar{g}_{7r} &= \left[\begin{matrix} D136r*g & D137r*g & D138r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{7r}\bar{a}_{G(7r)} &= m_{7r}\bar{a}_{7r} + \bar\alpha_{7r} \times \mathbf{MS}_{7r} + \bar\omega_{7r} \times \left(\bar\omega_{7r} \times \mathbf{MS}_{7r}\right) 
% \nonumber \\ 
% m_{7r}\bar{a}_{G(7r)} &= \left[\begin{matrix} MZ_7r*(K121r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) - MY_7r*(K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r)) - m_7r*(K87r + K72r*ddpsi + K76r*ddq_1r + K74r*ddq_w + K77r*ddq_2r + K73r*ddq_imu + K75r*ddq_torso + K71r*ddx) - K93r*(K93r*MX_7r - K92r*MY_7r) - K94r*(K94r*MX_7r - K92r*MZ_7r) & MX_7r*(K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r)) + MZ_7r*(K85r + ddq_4r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) + m_7r*(K123r + K108r*ddpsi + K112r*ddq_1r + K110r*ddq_w + K113r*ddq_2r + K109r*ddq_imu + K111r*ddq_torso + K107r*ddx) + K92r*(K93r*MX_7r - K92r*MY_7r) - K94r*(K94r*MY_7r - K93r*MZ_7r) & m_7r*(K124r + K115r*ddpsi + K119r*ddq_1r + K117r*ddq_w + K120r*ddq_2r + K116r*ddq_imu + K118r*ddq_torso + K114r*ddx) - MY_7r*(K85r + ddq_4r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) - MX_7r*(K121r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) + K92r*(K94r*MX_7r - K92r*MZ_7r) + K93r*(K94r*MY_7r - K93r*MZ_7r) &  \end{matrix}\right] 
% \nonumber \\ 
D139r = -K71r*m_7r;
D140r = K95r*MZ_7r - K100r*MY_7r - K72r*m_7r;
D141r = K96r*MZ_7r - K101r*MY_7r - K73r*m_7r;
D142r = K96r*MZ_7r - K101r*MY_7r - K74r*m_7r;
D143r = K97r*MZ_7r - K102r*MY_7r - K75r*m_7r;
D144r = K98r*MZ_7r - K103r*MY_7r - K76r*m_7r;
D145r = K99r*MZ_7r - K104r*MY_7r - K77r*m_7r;
D146r = MZ_7r*cos(q_4r) - MY_7r*sin(q_4r);
D147r = K121r*MZ_7r - K93r^2*MX_7r - K94r^2*MX_7r - K122r*MY_7r - K87r*m_7r + K92r*K93r*MY_7r + K92r*K94r*MZ_7r;
D148r = K107r*m_7r;
D149r = K108r*m_7r + K100r*MX_7r + K61r*MZ_7r;
D150r = K109r*m_7r + K101r*MX_7r + K62r*MZ_7r;
D151r = K110r*m_7r + K101r*MX_7r + K62r*MZ_7r;
D152r = K111r*m_7r + K102r*MX_7r + K63r*MZ_7r;
D153r = K112r*m_7r + K103r*MX_7r + K64r*MZ_7r;
D154r = K113r*m_7r + MZ_7r*cos(q_3r) + K104r*MX_7r;
D155r = MX_7r*sin(q_4r);
D156r = K123r*m_7r - K92r^2*MY_7r - K94r^2*MY_7r + K122r*MX_7r + K85r*MZ_7r + K92r*K93r*MX_7r + K93r*K94r*MZ_7r;
D157r = K114r*m_7r;
D158r = K115r*m_7r - K95r*MX_7r - K61r*MY_7r;
D159r = K116r*m_7r - K96r*MX_7r - K62r*MY_7r;
D160r = K117r*m_7r - K96r*MX_7r - K62r*MY_7r;
D161r = K118r*m_7r - K97r*MX_7r - K63r*MY_7r;
D162r = K119r*m_7r - K98r*MX_7r - K64r*MY_7r;
D163r = K120r*m_7r - MY_7r*cos(q_3r) - K99r*MX_7r;
D164r = -MX_7r*cos(q_4r);
D165r = K124r*m_7r - K92r^2*MZ_7r - K93r^2*MZ_7r - K121r*MX_7r - K85r*MY_7r + K92r*K94r*MX_7r + K93r*K94r*MY_7r;
% m_{7r}\bar{a}_{G(7r)} &= \left[\begin{matrix} D147r + D140r*ddpsi + D144r*ddq_1r + D142r*ddq_w + D145r*ddq_2r + D146r*ddq_3r + D141r*ddq_imu + D143r*ddq_torso + D139r*ddx & D156r + D149r*ddpsi + D153r*ddq_1r + D151r*ddq_w + D154r*ddq_2r + D155r*ddq_3r + D150r*ddq_imu + D152r*ddq_torso + D148r*ddx + MZ_7r*ddq_4r & D165r + D158r*ddpsi + D162r*ddq_1r + D160r*ddq_w + D163r*ddq_2r + D164r*ddq_3r + D159r*ddq_imu + D161r*ddq_torso + D157r*ddx - MY_7r*ddq_4r &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{7r} &= \mathbf{MS}_{7r} \times \bar{a}_{7r} + J_{7r}\bar{\alpha}_{7r} + \bar\omega_{7r} \times J_{7r}\bar{\omega}_{7r} 
% \nonumber \\ 
% \dot{\bar{H}}_{7r} &= \left[\begin{matrix} K93r*(K92r*XZ_7r + K93r*YZ_7r + K94r*ZZ_7r) - K94r*(K92r*XY_7r + K93r*YY_7r + K94r*YZ_7r) + XY_7r*(K121r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) + XZ_7r*(K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r)) - XX_7r*(K85r + ddq_4r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) + MY_7r*(K124r + K115r*ddpsi + K119r*ddq_1r + K117r*ddq_w + K120r*ddq_2r + K116r*ddq_imu + K118r*ddq_torso + K114r*ddx) - MZ_7r*(K123r + K108r*ddpsi + K112r*ddq_1r + K110r*ddq_w + K113r*ddq_2r + K109r*ddq_imu + K111r*ddq_torso + K107r*ddx) & K94r*(K92r*XX_7r + K93r*XY_7r + K94r*XZ_7r) - K92r*(K92r*XZ_7r + K93r*YZ_7r + K94r*ZZ_7r) + YY_7r*(K121r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) + YZ_7r*(K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r)) - XY_7r*(K85r + ddq_4r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) - MX_7r*(K124r + K115r*ddpsi + K119r*ddq_1r + K117r*ddq_w + K120r*ddq_2r + K116r*ddq_imu + K118r*ddq_torso + K114r*ddx) - MZ_7r*(K87r + K72r*ddpsi + K76r*ddq_1r + K74r*ddq_w + K77r*ddq_2r + K73r*ddq_imu + K75r*ddq_torso + K71r*ddx) & K92r*(K92r*XY_7r + K93r*YY_7r + K94r*YZ_7r) - K93r*(K92r*XX_7r + K93r*XY_7r + K94r*XZ_7r) + YZ_7r*(K121r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) + ZZ_7r*(K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r)) - XZ_7r*(K85r + ddq_4r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) + MX_7r*(K123r + K108r*ddpsi + K112r*ddq_1r + K110r*ddq_w + K113r*ddq_2r + K109r*ddq_imu + K111r*ddq_torso + K107r*ddx) + MY_7r*(K87r + K72r*ddpsi + K76r*ddq_1r + K74r*ddq_w + K77r*ddq_2r + K73r*ddq_imu + K75r*ddq_torso + K71r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D166r = K114r*MY_7r - K107r*MZ_7r;
D167r = K95r*XY_7r - K61r*XX_7r + K100r*XZ_7r + K115r*MY_7r - K108r*MZ_7r;
D168r = K96r*XY_7r - K62r*XX_7r + K101r*XZ_7r + K116r*MY_7r - K109r*MZ_7r;
D169r = K96r*XY_7r - K62r*XX_7r + K101r*XZ_7r + K117r*MY_7r - K110r*MZ_7r;
D170r = K97r*XY_7r - K63r*XX_7r + K102r*XZ_7r + K118r*MY_7r - K111r*MZ_7r;
D171r = K98r*XY_7r - K64r*XX_7r + K103r*XZ_7r + K119r*MY_7r - K112r*MZ_7r;
D172r = K99r*XY_7r + K104r*XZ_7r - XX_7r*cos(q_3r) + K120r*MY_7r - K113r*MZ_7r;
D173r = XY_7r*cos(q_4r) + XZ_7r*sin(q_4r);
D174r = K121r*XY_7r - K85r*XX_7r + K122r*XZ_7r + K93r^2*YZ_7r - K94r^2*YZ_7r + K124r*MY_7r - K123r*MZ_7r - K92r*K94r*XY_7r + K92r*K93r*XZ_7r - K93r*K94r*YY_7r + K93r*K94r*ZZ_7r;
D175r = - K114r*MX_7r - K71r*MZ_7r;
D176r = K95r*YY_7r - K61r*XY_7r + K100r*YZ_7r - K115r*MX_7r - K72r*MZ_7r;
D177r = K96r*YY_7r - K62r*XY_7r + K101r*YZ_7r - K116r*MX_7r - K73r*MZ_7r;
D178r = K96r*YY_7r - K62r*XY_7r + K101r*YZ_7r - K117r*MX_7r - K74r*MZ_7r;
D179r = K97r*YY_7r - K63r*XY_7r + K102r*YZ_7r - K118r*MX_7r - K75r*MZ_7r;
D180r = K98r*YY_7r - K64r*XY_7r + K103r*YZ_7r - K119r*MX_7r - K76r*MZ_7r;
D181r = K99r*YY_7r + K104r*YZ_7r - XY_7r*cos(q_3r) - K120r*MX_7r - K77r*MZ_7r;
D182r = YY_7r*cos(q_4r) + YZ_7r*sin(q_4r);
D183r = K121r*YY_7r - K85r*XY_7r + K122r*YZ_7r - K92r^2*XZ_7r + K94r^2*XZ_7r - K124r*MX_7r - K87r*MZ_7r + K92r*K94r*XX_7r + K93r*K94r*XY_7r - K92r*K93r*YZ_7r - K92r*K94r*ZZ_7r;
D184r = K107r*MX_7r + K71r*MY_7r;
D185r = K95r*YZ_7r - K61r*XZ_7r + K100r*ZZ_7r + K108r*MX_7r + K72r*MY_7r;
D186r = K96r*YZ_7r - K62r*XZ_7r + K101r*ZZ_7r + K109r*MX_7r + K73r*MY_7r;
D187r = K96r*YZ_7r - K62r*XZ_7r + K101r*ZZ_7r + K110r*MX_7r + K74r*MY_7r;
D188r = K97r*YZ_7r - K63r*XZ_7r + K102r*ZZ_7r + K111r*MX_7r + K75r*MY_7r;
D189r = K98r*YZ_7r - K64r*XZ_7r + K103r*ZZ_7r + K112r*MX_7r + K76r*MY_7r;
D190r = K99r*YZ_7r + K104r*ZZ_7r - XZ_7r*cos(q_3r) + K113r*MX_7r + K77r*MY_7r;
D191r = YZ_7r*cos(q_4r) + ZZ_7r*sin(q_4r);
D192r = K121r*YZ_7r - K85r*XZ_7r + K122r*ZZ_7r + K92r^2*XY_7r - K93r^2*XY_7r + K123r*MX_7r + K87r*MY_7r - K92r*K93r*XX_7r - K93r*K94r*XZ_7r + K92r*K93r*YY_7r + K92r*K94r*YZ_7r;
% \dot{\bar{H}}_{7r} &= \left[\begin{matrix} D147r + D140r*ddpsi + D144r*ddq_1r + D142r*ddq_w + D145r*ddq_2r + D146r*ddq_3r + D141r*ddq_imu + D143r*ddq_torso + D139r*ddx & D156r + D149r*ddpsi + D153r*ddq_1r + D151r*ddq_w + D154r*ddq_2r + D155r*ddq_3r + D150r*ddq_imu + D152r*ddq_torso + D148r*ddx + MZ_7r*ddq_4r & D165r + D158r*ddpsi + D162r*ddq_1r + D160r*ddq_w + D163r*ddq_2r + D164r*ddq_3r + D159r*ddq_imu + D161r*ddq_torso + D157r*ddx - MY_7r*ddq_4r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{8r} &= {}^{8r}A_{7r} \bar\omega_{7r} + \dot{q}_{8r} \bar{e}_{8r} 
% \nonumber \\ 
% \bar\omega_{8r} &= \left[\begin{matrix} K94r*sin(q_5r) - K92r*cos(q_5r) & - K93r - dq_5r & K94r*cos(q_5r) + K92r*sin(q_5r) &  \end{matrix}\right] 
% \nonumber \\ 
K127r = K94r*sin(q_5r) - K92r*cos(q_5r);
K128r = - K93r - dq_5r;
K129r = K94r*cos(q_5r) + K92r*sin(q_5r);
% \bar\omega_{8r} &= \left[\begin{matrix} K127r & K128r & K129r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{8r} &= \left[\begin{matrix} sin(q_5r)*(K100r*dpsi + K103r*dq_1r + K101r*dq_w + K104r*dq_2r + K101r*dq_imu + K102r*dq_torso + dq_3r*sin(q_4r)) + cos(q_5r)*(dq_4r + K61r*dpsi + K64r*dq_1r + K62r*dq_w + K62r*dq_imu + K63r*dq_torso + dq_2r*cos(q_3r)) & - dq_5r - K95r*dpsi - K98r*dq_1r - K96r*dq_w - K99r*dq_2r - K96r*dq_imu - K97r*dq_torso - dq_3r*cos(q_4r) & cos(q_5r)*(K100r*dpsi + K103r*dq_1r + K101r*dq_w + K104r*dq_2r + K101r*dq_imu + K102r*dq_torso + dq_3r*sin(q_4r)) - sin(q_5r)*(dq_4r + K61r*dpsi + K64r*dq_1r + K62r*dq_w + K62r*dq_imu + K63r*dq_torso + dq_2r*cos(q_3r)) &  \end{matrix}\right] 
% \nonumber \\ 
K130r = K61r*cos(q_5r) + K100r*sin(q_5r);
K131r = K62r*cos(q_5r) + K101r*sin(q_5r);
K132r = K63r*cos(q_5r) + K102r*sin(q_5r);
K133r = K64r*cos(q_5r) + K103r*sin(q_5r);
K134r = cos(q_3r)*cos(q_5r) + K104r*sin(q_5r);
K135r = sin(q_4r)*sin(q_5r);
K136r = K100r*cos(q_5r) - K61r*sin(q_5r);
K137r = K101r*cos(q_5r) - K62r*sin(q_5r);
K138r = K102r*cos(q_5r) - K63r*sin(q_5r);
K139r = K103r*cos(q_5r) - K64r*sin(q_5r);
K140r = K104r*cos(q_5r) - cos(q_3r)*sin(q_5r);
K141r = cos(q_5r)*sin(q_4r);
% \bar\omega_{8r} &= \left[\begin{matrix} K130r*dpsi + K133r*dq_1r + K131r*dq_w + K134r*dq_2r + K135r*dq_3r + K131r*dq_imu + K132r*dq_torso + dq_4r*cos(q_5r) & - dq_5r - K95r*dpsi - K98r*dq_1r - K96r*dq_w - K99r*dq_2r - K96r*dq_imu - K97r*dq_torso - dq_3r*cos(q_4r) & K136r*dpsi + K139r*dq_1r + K137r*dq_w + K140r*dq_2r + K141r*dq_3r + K137r*dq_imu + K138r*dq_torso - dq_4r*sin(q_5r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{8r} &= {}^{8r}A_{7r} \left(\bar{v}_{7r} + \bar\omega_{7r} \times \bar{P}_{8r}\right) 
% \nonumber \\ 
% \bar{v}_{8r} &= \left[\begin{matrix} cos(q_5r)*(K69r - K94r*L8) + sin(q_5r)*(K106r - K92r*L8) & -K105r & cos(q_5r)*(K106r - K92r*L8) - sin(q_5r)*(K69r - K94r*L8) &  \end{matrix}\right] 
% \nonumber \\ 
K142r = cos(q_5r)*(K69r - K94r*L8) + sin(q_5r)*(K106r - K92r*L8);
K143r = cos(q_5r)*(K106r - K92r*L8) - sin(q_5r)*(K69r - K94r*L8);
% \bar{v}_{8r} &= \left[\begin{matrix} K142r & -K105r & K143r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{8r} &= \left[\begin{matrix} cos(q_5r)*(K72r*dpsi - L8*(K100r*dpsi + K103r*dq_1r + K101r*dq_w + K104r*dq_2r + K101r*dq_imu + K102r*dq_torso + dq_3r*sin(q_4r)) + K76r*dq_1r + K74r*dq_w + K77r*dq_2r + K73r*dq_imu + K75r*dq_torso + K71r*dx) + sin(q_5r)*(K115r*dpsi + K119r*dq_1r + K117r*dq_w + K120r*dq_2r + K116r*dq_imu + K118r*dq_torso + K114r*dx + L8*(dq_4r + K61r*dpsi + K64r*dq_1r + K62r*dq_w + K62r*dq_imu + K63r*dq_torso + dq_2r*cos(q_3r))) & - K108r*dpsi - K112r*dq_1r - K110r*dq_w - K113r*dq_2r - K109r*dq_imu - K111r*dq_torso - K107r*dx & cos(q_5r)*(K115r*dpsi + K119r*dq_1r + K117r*dq_w + K120r*dq_2r + K116r*dq_imu + K118r*dq_torso + K114r*dx + L8*(dq_4r + K61r*dpsi + K64r*dq_1r + K62r*dq_w + K62r*dq_imu + K63r*dq_torso + dq_2r*cos(q_3r))) - sin(q_5r)*(K72r*dpsi - L8*(K100r*dpsi + K103r*dq_1r + K101r*dq_w + K104r*dq_2r + K101r*dq_imu + K102r*dq_torso + dq_3r*sin(q_4r)) + K76r*dq_1r + K74r*dq_w + K77r*dq_2r + K73r*dq_imu + K75r*dq_torso + K71r*dx) &  \end{matrix}\right] 
% \nonumber \\ 
K144r = K71r*cos(q_5r) + K114r*sin(q_5r);
K145r = cos(q_5r)*(K72r - K100r*L8) + sin(q_5r)*(K115r + K61r*L8);
K146r = cos(q_5r)*(K73r - K101r*L8) + sin(q_5r)*(K116r + K62r*L8);
K147r = cos(q_5r)*(K74r - K101r*L8) + sin(q_5r)*(K117r + K62r*L8);
K148r = cos(q_5r)*(K75r - K102r*L8) + sin(q_5r)*(K118r + K63r*L8);
K149r = cos(q_5r)*(K76r - K103r*L8) + sin(q_5r)*(K119r + K64r*L8);
K150r = sin(q_5r)*(K120r + L8*cos(q_3r)) + cos(q_5r)*(K77r - K104r*L8);
K151r = -L8*cos(q_5r)*sin(q_4r);
K152r = L8*sin(q_5r);
K153r = K114r*cos(q_5r) - K71r*sin(q_5r);
K154r = cos(q_5r)*(K115r + K61r*L8) - sin(q_5r)*(K72r - K100r*L8);
K155r = cos(q_5r)*(K116r + K62r*L8) - sin(q_5r)*(K73r - K101r*L8);
K156r = cos(q_5r)*(K117r + K62r*L8) - sin(q_5r)*(K74r - K101r*L8);
K157r = cos(q_5r)*(K118r + K63r*L8) - sin(q_5r)*(K75r - K102r*L8);
K158r = cos(q_5r)*(K119r + K64r*L8) - sin(q_5r)*(K76r - K103r*L8);
K159r = cos(q_5r)*(K120r + L8*cos(q_3r)) - sin(q_5r)*(K77r - K104r*L8);
K160r = L8*sin(q_4r)*sin(q_5r);
K161r = L8*cos(q_5r);
% \bar{v}_{8r} &= \left[\begin{matrix} K145r*dpsi + K149r*dq_1r + K147r*dq_w + K150r*dq_2r + K151r*dq_3r + K152r*dq_4r + K146r*dq_imu + K148r*dq_torso + K144r*dx & - K108r*dpsi - K112r*dq_1r - K110r*dq_w - K113r*dq_2r - K109r*dq_imu - K111r*dq_torso - K107r*dx & K154r*dpsi + K158r*dq_1r + K156r*dq_w + K159r*dq_2r + K160r*dq_3r + K161r*dq_4r + K155r*dq_imu + K157r*dq_torso + K153r*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{8r} &= {}^{8r}A_{7r} \bar\alpha_{7r} + \ddot{q}_{8r} \bar{e}_{8r} + \dot{q}_{8r} \left(\bar\omega_{8r} \times \bar{e}_{8r}\right) 
% \nonumber \\ 
% \bar\alpha_{8r} &= \left[\begin{matrix} K129r*dq_5r + cos(q_5r)*(K85r + ddq_4r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) + sin(q_5r)*(K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r)) & - K121r - ddq_5r - K95r*ddpsi - K98r*ddq_1r - K96r*ddq_w - K99r*ddq_2r - K96r*ddq_imu - K97r*ddq_torso - ddq_3r*cos(q_4r) & cos(q_5r)*(K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r)) - sin(q_5r)*(K85r + ddq_4r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) - K127r*dq_5r &  \end{matrix}\right] 
% \nonumber \\ 
K162r = K129r*dq_5r + K85r*cos(q_5r) + K122r*sin(q_5r);
K163r = K122r*cos(q_5r) - K127r*dq_5r - K85r*sin(q_5r);
% \bar\alpha_{8r} &= \left[\begin{matrix} K162r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r) & - K121r - ddq_5r - K95r*ddpsi - K98r*ddq_1r - K96r*ddq_w - K99r*ddq_2r - K96r*ddq_imu - K97r*ddq_torso - ddq_3r*cos(q_4r) & K163r + K136r*ddpsi + K139r*ddq_1r + K137r*ddq_w + K140r*ddq_2r + K141r*ddq_3r + K137r*ddq_imu + K138r*ddq_torso - ddq_4r*sin(q_5r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{8r} &= {}^{8r}A_{7r} \left(\bar{a}_{7r} + \bar\alpha_{7r} \times \bar{P}_{8r} + \bar\omega_{7r} \times \left(\bar\omega_{7r} \times \bar{P}_{8r}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{8r} &= \left[\begin{matrix} sin(q_5r)*(K124r + K115r*ddpsi + K119r*ddq_1r + K117r*ddq_w + K120r*ddq_2r + K116r*ddq_imu + K118r*ddq_torso + K114r*ddx + L8*(K85r + ddq_4r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) - K93r*K94r*L8) + cos(q_5r)*(K87r + K72r*ddpsi + K76r*ddq_1r + K74r*ddq_w + K77r*ddq_2r + K73r*ddq_imu + K75r*ddq_torso + K71r*ddx - L8*(K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r)) + K92r*K93r*L8) & - K123r - K108r*ddpsi - K112r*ddq_1r - K110r*ddq_w - K113r*ddq_2r - K109r*ddq_imu - K111r*ddq_torso - K107r*ddx - K92r^2*L8 - K94r^2*L8 & cos(q_5r)*(K124r + K115r*ddpsi + K119r*ddq_1r + K117r*ddq_w + K120r*ddq_2r + K116r*ddq_imu + K118r*ddq_torso + K114r*ddx + L8*(K85r + ddq_4r + K61r*ddpsi + K64r*ddq_1r + K62r*ddq_w + K62r*ddq_imu + K63r*ddq_torso + ddq_2r*cos(q_3r)) - K93r*K94r*L8) - sin(q_5r)*(K87r + K72r*ddpsi + K76r*ddq_1r + K74r*ddq_w + K77r*ddq_2r + K73r*ddq_imu + K75r*ddq_torso + K71r*ddx - L8*(K122r + K100r*ddpsi + K103r*ddq_1r + K101r*ddq_w + K104r*ddq_2r + K101r*ddq_imu + K102r*ddq_torso + ddq_3r*sin(q_4r)) + K92r*K93r*L8) &  \end{matrix}\right] 
% \nonumber \\ 
K164r = K87r*cos(q_5r) + K124r*sin(q_5r) - K122r*L8*cos(q_5r) + K85r*L8*sin(q_5r) + K92r*K93r*L8*cos(q_5r) - K93r*K94r*L8*sin(q_5r);
K165r = - K123r - K92r^2*L8 - K94r^2*L8;
K166r = K124r*cos(q_5r) - K87r*sin(q_5r) + K85r*L8*cos(q_5r) + K122r*L8*sin(q_5r) - K93r*K94r*L8*cos(q_5r) - K92r*K93r*L8*sin(q_5r);
% \bar{a}_{8r} &= \left[\begin{matrix} K164r + K145r*ddpsi + K149r*ddq_1r + K147r*ddq_w + K150r*ddq_2r + K151r*ddq_3r + K152r*ddq_4r + K146r*ddq_imu + K148r*ddq_torso + K144r*ddx & K165r - K108r*ddpsi - K112r*ddq_1r - K110r*ddq_w - K113r*ddq_2r - K109r*ddq_imu - K111r*ddq_torso - K107r*ddx & K166r + K154r*ddpsi + K158r*ddq_1r + K156r*ddq_w + K159r*ddq_2r + K160r*ddq_3r + K161r*ddq_4r + K155r*ddq_imu + K157r*ddq_torso + K153r*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{8r} &= {}^{8r}A_{7r} \bar{g}_{7r} 
% \nonumber \\ 
% \bar{g}_{8r} &= \left[\begin{matrix} K90r*g*cos(q_5r) + K126r*g*sin(q_5r) & -K125r*g & K126r*g*cos(q_5r) - K90r*g*sin(q_5r) &  \end{matrix}\right] 
% \nonumber \\ 
K167r = K90r*cos(q_5r) + K126r*sin(q_5r);
K168r = K126r*cos(q_5r) - K90r*sin(q_5r);
% \bar{g}_{8r} &= \left[\begin{matrix} K167r*g & -K125r*g & K168r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{8r}\bar{S}_{8r}^{\times}\bar{g}_{8r} &= \mathbf{MS}_{8r} \times \bar{g}_{8r} 
% \nonumber \\ 
% m_{8r}\bar{S}_{8r}^{\times}\bar{g}_{8r} &= \left[\begin{matrix} K168r*MY_8r*g + K125r*MZ_8r*g & K167r*MZ_8r*g - K168r*MX_8r*g & - K125r*MX_8r*g - K167r*MY_8r*g &  \end{matrix}\right] 
% \nonumber \\ 
D193r = K168r*MY_8r + K125r*MZ_8r;
D194r = K167r*MZ_8r - K168r*MX_8r;
D195r = - K125r*MX_8r - K167r*MY_8r;
% m_{8r}\bar{S}_{8r}^{\times}\bar{g}_{8r} &= \left[\begin{matrix} D193r*g & D194r*g & D195r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{8r}\bar{a}_{G(8r)} &= m_{8r}\bar{a}_{8r} + \bar\alpha_{8r} \times \mathbf{MS}_{8r} + \bar\omega_{8r} \times \left(\bar\omega_{8r} \times \mathbf{MS}_{8r}\right) 
% \nonumber \\ 
% m_{8r}\bar{a}_{G(8r)} &= \left[\begin{matrix} m_8r*(K164r + K145r*ddpsi + K149r*ddq_1r + K147r*ddq_w + K150r*ddq_2r + K151r*ddq_3r + K152r*ddq_4r + K146r*ddq_imu + K148r*ddq_torso + K144r*ddx) - MZ_8r*(K121r + ddq_5r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) - K128r*(K128r*MX_8r - K127r*MY_8r) - K129r*(K129r*MX_8r - K127r*MZ_8r) - MY_8r*(K163r + K136r*ddpsi + K139r*ddq_1r + K137r*ddq_w + K140r*ddq_2r + K141r*ddq_3r + K137r*ddq_imu + K138r*ddq_torso - ddq_4r*sin(q_5r)) & MX_8r*(K163r + K136r*ddpsi + K139r*ddq_1r + K137r*ddq_w + K140r*ddq_2r + K141r*ddq_3r + K137r*ddq_imu + K138r*ddq_torso - ddq_4r*sin(q_5r)) - MZ_8r*(K162r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) - m_8r*(K108r*ddpsi - K165r + K112r*ddq_1r + K110r*ddq_w + K113r*ddq_2r + K109r*ddq_imu + K111r*ddq_torso + K107r*ddx) + K127r*(K128r*MX_8r - K127r*MY_8r) - K129r*(K129r*MY_8r - K128r*MZ_8r) & MY_8r*(K162r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) + MX_8r*(K121r + ddq_5r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) + K127r*(K129r*MX_8r - K127r*MZ_8r) + K128r*(K129r*MY_8r - K128r*MZ_8r) + m_8r*(K166r + K154r*ddpsi + K158r*ddq_1r + K156r*ddq_w + K159r*ddq_2r + K160r*ddq_3r + K161r*ddq_4r + K155r*ddq_imu + K157r*ddq_torso + K153r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D196r = K144r*m_8r;
D197r = K145r*m_8r - K136r*MY_8r - K95r*MZ_8r;
D198r = K146r*m_8r - K137r*MY_8r - K96r*MZ_8r;
D199r = K147r*m_8r - K137r*MY_8r - K96r*MZ_8r;
D200r = K148r*m_8r - K138r*MY_8r - K97r*MZ_8r;
D201r = K149r*m_8r - K139r*MY_8r - K98r*MZ_8r;
D202r = K150r*m_8r - K140r*MY_8r - K99r*MZ_8r;
D203r = K151r*m_8r - MZ_8r*cos(q_4r) - K141r*MY_8r;
D204r = K152r*m_8r + MY_8r*sin(q_5r);
D205r = K164r*m_8r - K128r^2*MX_8r - K129r^2*MX_8r - K163r*MY_8r - K121r*MZ_8r + K127r*K128r*MY_8r + K127r*K129r*MZ_8r;
D206r = -K107r*m_8r;
D207r = K136r*MX_8r - K108r*m_8r - K130r*MZ_8r;
D208r = K137r*MX_8r - K109r*m_8r - K131r*MZ_8r;
D209r = K137r*MX_8r - K110r*m_8r - K131r*MZ_8r;
D210r = K138r*MX_8r - K111r*m_8r - K132r*MZ_8r;
D211r = K139r*MX_8r - K112r*m_8r - K133r*MZ_8r;
D212r = K140r*MX_8r - K113r*m_8r - K134r*MZ_8r;
D213r = K141r*MX_8r - K135r*MZ_8r;
D214r = - MZ_8r*cos(q_5r) - MX_8r*sin(q_5r);
D215r = K165r*m_8r - K127r^2*MY_8r - K129r^2*MY_8r + K163r*MX_8r - K162r*MZ_8r + K127r*K128r*MX_8r + K128r*K129r*MZ_8r;
D216r = K153r*m_8r;
D217r = K154r*m_8r + K95r*MX_8r + K130r*MY_8r;
D218r = K155r*m_8r + K96r*MX_8r + K131r*MY_8r;
D219r = K156r*m_8r + K96r*MX_8r + K131r*MY_8r;
D220r = K157r*m_8r + K97r*MX_8r + K132r*MY_8r;
D221r = K158r*m_8r + K98r*MX_8r + K133r*MY_8r;
D222r = K159r*m_8r + K99r*MX_8r + K134r*MY_8r;
D223r = K160r*m_8r + MX_8r*cos(q_4r) + K135r*MY_8r;
D224r = K161r*m_8r + MY_8r*cos(q_5r);
D225r = K166r*m_8r - K127r^2*MZ_8r - K128r^2*MZ_8r + K121r*MX_8r + K162r*MY_8r + K127r*K129r*MX_8r + K128r*K129r*MY_8r;
% m_{8r}\bar{a}_{G(8r)} &= \left[\begin{matrix} D205r + D197r*ddpsi + D201r*ddq_1r + D199r*ddq_w + D202r*ddq_2r + D203r*ddq_3r + D204r*ddq_4r + D198r*ddq_imu + D200r*ddq_torso + D196r*ddx - MZ_8r*ddq_5r & D215r + D207r*ddpsi + D211r*ddq_1r + D209r*ddq_w + D212r*ddq_2r + D213r*ddq_3r + D214r*ddq_4r + D208r*ddq_imu + D210r*ddq_torso + D206r*ddx & D225r + D217r*ddpsi + D221r*ddq_1r + D219r*ddq_w + D222r*ddq_2r + D223r*ddq_3r + D224r*ddq_4r + D218r*ddq_imu + D220r*ddq_torso + D216r*ddx + MX_8r*ddq_5r &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{8r} &= \mathbf{MS}_{8r} \times \bar{a}_{8r} + J_{8r}\bar{\alpha}_{8r} + \bar\omega_{8r} \times J_{8r}\bar{\omega}_{8r} 
% \nonumber \\ 
% \dot{\bar{H}}_{8r} &= \left[\begin{matrix} K128r*(K127r*XZ_8r + K128r*YZ_8r + K129r*ZZ_8r) - K129r*(K127r*XY_8r + K128r*YY_8r + K129r*YZ_8r) + MZ_8r*(K108r*ddpsi - K165r + K112r*ddq_1r + K110r*ddq_w + K113r*ddq_2r + K109r*ddq_imu + K111r*ddq_torso + K107r*ddx) + XX_8r*(K162r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) + XZ_8r*(K163r + K136r*ddpsi + K139r*ddq_1r + K137r*ddq_w + K140r*ddq_2r + K141r*ddq_3r + K137r*ddq_imu + K138r*ddq_torso - ddq_4r*sin(q_5r)) - XY_8r*(K121r + ddq_5r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) + MY_8r*(K166r + K154r*ddpsi + K158r*ddq_1r + K156r*ddq_w + K159r*ddq_2r + K160r*ddq_3r + K161r*ddq_4r + K155r*ddq_imu + K157r*ddq_torso + K153r*ddx) & K129r*(K127r*XX_8r + K128r*XY_8r + K129r*XZ_8r) - K127r*(K127r*XZ_8r + K128r*YZ_8r + K129r*ZZ_8r) + XY_8r*(K162r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) + YZ_8r*(K163r + K136r*ddpsi + K139r*ddq_1r + K137r*ddq_w + K140r*ddq_2r + K141r*ddq_3r + K137r*ddq_imu + K138r*ddq_torso - ddq_4r*sin(q_5r)) - YY_8r*(K121r + ddq_5r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) - MX_8r*(K166r + K154r*ddpsi + K158r*ddq_1r + K156r*ddq_w + K159r*ddq_2r + K160r*ddq_3r + K161r*ddq_4r + K155r*ddq_imu + K157r*ddq_torso + K153r*ddx) + MZ_8r*(K164r + K145r*ddpsi + K149r*ddq_1r + K147r*ddq_w + K150r*ddq_2r + K151r*ddq_3r + K152r*ddq_4r + K146r*ddq_imu + K148r*ddq_torso + K144r*ddx) & K127r*(K127r*XY_8r + K128r*YY_8r + K129r*YZ_8r) - K128r*(K127r*XX_8r + K128r*XY_8r + K129r*XZ_8r) - MX_8r*(K108r*ddpsi - K165r + K112r*ddq_1r + K110r*ddq_w + K113r*ddq_2r + K109r*ddq_imu + K111r*ddq_torso + K107r*ddx) + XZ_8r*(K162r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) + ZZ_8r*(K163r + K136r*ddpsi + K139r*ddq_1r + K137r*ddq_w + K140r*ddq_2r + K141r*ddq_3r + K137r*ddq_imu + K138r*ddq_torso - ddq_4r*sin(q_5r)) - YZ_8r*(K121r + ddq_5r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) - MY_8r*(K164r + K145r*ddpsi + K149r*ddq_1r + K147r*ddq_w + K150r*ddq_2r + K151r*ddq_3r + K152r*ddq_4r + K146r*ddq_imu + K148r*ddq_torso + K144r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D226r = K153r*MY_8r + K107r*MZ_8r;
D227r = K130r*XX_8r - K95r*XY_8r + K136r*XZ_8r + K154r*MY_8r + K108r*MZ_8r;
D228r = K131r*XX_8r - K96r*XY_8r + K137r*XZ_8r + K155r*MY_8r + K109r*MZ_8r;
D229r = K131r*XX_8r - K96r*XY_8r + K137r*XZ_8r + K156r*MY_8r + K110r*MZ_8r;
D230r = K132r*XX_8r - K97r*XY_8r + K138r*XZ_8r + K157r*MY_8r + K111r*MZ_8r;
D231r = K133r*XX_8r - K98r*XY_8r + K139r*XZ_8r + K158r*MY_8r + K112r*MZ_8r;
D232r = K134r*XX_8r - K99r*XY_8r + K140r*XZ_8r + K159r*MY_8r + K113r*MZ_8r;
D233r = K135r*XX_8r + K141r*XZ_8r - XY_8r*cos(q_4r) + K160r*MY_8r;
D234r = XX_8r*cos(q_5r) - XZ_8r*sin(q_5r) + K161r*MY_8r;
D235r = K162r*XX_8r - K121r*XY_8r + K163r*XZ_8r + K128r^2*YZ_8r - K129r^2*YZ_8r + K166r*MY_8r - K165r*MZ_8r - K127r*K129r*XY_8r + K127r*K128r*XZ_8r - K128r*K129r*YY_8r + K128r*K129r*ZZ_8r;
D236r = K144r*MZ_8r - K153r*MX_8r;
D237r = K130r*XY_8r - K95r*YY_8r + K136r*YZ_8r - K154r*MX_8r + K145r*MZ_8r;
D238r = K131r*XY_8r - K96r*YY_8r + K137r*YZ_8r - K155r*MX_8r + K146r*MZ_8r;
D239r = K131r*XY_8r - K96r*YY_8r + K137r*YZ_8r - K156r*MX_8r + K147r*MZ_8r;
D240r = K132r*XY_8r - K97r*YY_8r + K138r*YZ_8r - K157r*MX_8r + K148r*MZ_8r;
D241r = K133r*XY_8r - K98r*YY_8r + K139r*YZ_8r - K158r*MX_8r + K149r*MZ_8r;
D242r = K134r*XY_8r - K99r*YY_8r + K140r*YZ_8r - K159r*MX_8r + K150r*MZ_8r;
D243r = K135r*XY_8r + K141r*YZ_8r - YY_8r*cos(q_4r) - K160r*MX_8r + K151r*MZ_8r;
D244r = XY_8r*cos(q_5r) - YZ_8r*sin(q_5r) - K161r*MX_8r + K152r*MZ_8r;
D245r = K162r*XY_8r - K121r*YY_8r + K163r*YZ_8r - K127r^2*XZ_8r + K129r^2*XZ_8r - K166r*MX_8r + K164r*MZ_8r + K127r*K129r*XX_8r + K128r*K129r*XY_8r - K127r*K128r*YZ_8r - K127r*K129r*ZZ_8r;
D246r = - K107r*MX_8r - K144r*MY_8r;
D247r = K130r*XZ_8r - K95r*YZ_8r + K136r*ZZ_8r - K108r*MX_8r - K145r*MY_8r;
D248r = K131r*XZ_8r - K96r*YZ_8r + K137r*ZZ_8r - K109r*MX_8r - K146r*MY_8r;
D249r = K131r*XZ_8r - K96r*YZ_8r + K137r*ZZ_8r - K110r*MX_8r - K147r*MY_8r;
D250r = K132r*XZ_8r - K97r*YZ_8r + K138r*ZZ_8r - K111r*MX_8r - K148r*MY_8r;
D251r = K133r*XZ_8r - K98r*YZ_8r + K139r*ZZ_8r - K112r*MX_8r - K149r*MY_8r;
D252r = K134r*XZ_8r - K99r*YZ_8r + K140r*ZZ_8r - K113r*MX_8r - K150r*MY_8r;
D253r = K135r*XZ_8r + K141r*ZZ_8r - YZ_8r*cos(q_4r) - K151r*MY_8r;
D254r = XZ_8r*cos(q_5r) - ZZ_8r*sin(q_5r) - K152r*MY_8r;
D255r = K162r*XZ_8r - K121r*YZ_8r + K163r*ZZ_8r + K127r^2*XY_8r - K128r^2*XY_8r + K165r*MX_8r - K164r*MY_8r - K127r*K128r*XX_8r - K128r*K129r*XZ_8r + K127r*K128r*YY_8r + K127r*K129r*YZ_8r;
% \dot{\bar{H}}_{8r} &= \left[\begin{matrix} D205r + D197r*ddpsi + D201r*ddq_1r + D199r*ddq_w + D202r*ddq_2r + D203r*ddq_3r + D204r*ddq_4r + D198r*ddq_imu + D200r*ddq_torso + D196r*ddx - MZ_8r*ddq_5r & D215r + D207r*ddpsi + D211r*ddq_1r + D209r*ddq_w + D212r*ddq_2r + D213r*ddq_3r + D214r*ddq_4r + D208r*ddq_imu + D210r*ddq_torso + D206r*ddx & D225r + D217r*ddpsi + D221r*ddq_1r + D219r*ddq_w + D222r*ddq_2r + D223r*ddq_3r + D224r*ddq_4r + D218r*ddq_imu + D220r*ddq_torso + D216r*ddx + MX_8r*ddq_5r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{9r} &= {}^{9r}A_{8r} \bar\omega_{8r} + \dot{q}_{9r} \bar{e}_{9r} 
% \nonumber \\ 
% \bar\omega_{9r} &= \left[\begin{matrix} - K127r - dq_6r & - K128r*cos(q_6r) - K129r*sin(q_6r) & K129r*cos(q_6r) - K128r*sin(q_6r) &  \end{matrix}\right] 
% \nonumber \\ 
K169r = - K127r - dq_6r;
K170r = - K128r*cos(q_6r) - K129r*sin(q_6r);
K171r = K129r*cos(q_6r) - K128r*sin(q_6r);
% \bar\omega_{9r} &= \left[\begin{matrix} K169r & K170r & K171r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{9r} &= \left[\begin{matrix} - dq_6r - K130r*dpsi - K133r*dq_1r - K131r*dq_w - K134r*dq_2r - K135r*dq_3r - K131r*dq_imu - K132r*dq_torso - dq_4r*cos(q_5r) & cos(q_6r)*(dq_5r + K95r*dpsi + K98r*dq_1r + K96r*dq_w + K99r*dq_2r + K96r*dq_imu + K97r*dq_torso + dq_3r*cos(q_4r)) - sin(q_6r)*(K136r*dpsi + K139r*dq_1r + K137r*dq_w + K140r*dq_2r + K141r*dq_3r + K137r*dq_imu + K138r*dq_torso - dq_4r*sin(q_5r)) & cos(q_6r)*(K136r*dpsi + K139r*dq_1r + K137r*dq_w + K140r*dq_2r + K141r*dq_3r + K137r*dq_imu + K138r*dq_torso - dq_4r*sin(q_5r)) + sin(q_6r)*(dq_5r + K95r*dpsi + K98r*dq_1r + K96r*dq_w + K99r*dq_2r + K96r*dq_imu + K97r*dq_torso + dq_3r*cos(q_4r)) &  \end{matrix}\right] 
% \nonumber \\ 
K172r = K95r*cos(q_6r) - K136r*sin(q_6r);
K173r = K96r*cos(q_6r) - K137r*sin(q_6r);
K174r = K97r*cos(q_6r) - K138r*sin(q_6r);
K175r = K98r*cos(q_6r) - K139r*sin(q_6r);
K176r = K99r*cos(q_6r) - K140r*sin(q_6r);
K177r = cos(q_4r)*cos(q_6r) - K141r*sin(q_6r);
K178r = sin(q_5r)*sin(q_6r);
K179r = K136r*cos(q_6r) + K95r*sin(q_6r);
K180r = K137r*cos(q_6r) + K96r*sin(q_6r);
K181r = K138r*cos(q_6r) + K97r*sin(q_6r);
K182r = K139r*cos(q_6r) + K98r*sin(q_6r);
K183r = K140r*cos(q_6r) + K99r*sin(q_6r);
K184r = cos(q_4r)*sin(q_6r) + K141r*cos(q_6r);
K185r = -cos(q_6r)*sin(q_5r);
% \bar\omega_{9r} &= \left[\begin{matrix} - dq_6r - K130r*dpsi - K133r*dq_1r - K131r*dq_w - K134r*dq_2r - K135r*dq_3r - K131r*dq_imu - K132r*dq_torso - dq_4r*cos(q_5r) & K172r*dpsi + K175r*dq_1r + K173r*dq_w + K176r*dq_2r + K177r*dq_3r + K178r*dq_4r + K173r*dq_imu + K174r*dq_torso + dq_5r*cos(q_6r) & K179r*dpsi + K182r*dq_1r + K180r*dq_w + K183r*dq_2r + K184r*dq_3r + K185r*dq_4r + K180r*dq_imu + K181r*dq_torso + dq_5r*sin(q_6r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{9r} &= {}^{9r}A_{8r} \left(\bar{v}_{8r} + \bar\omega_{8r} \times \bar{P}_{9r}\right) 
% \nonumber \\ 
% \bar{v}_{9r} &= \left[\begin{matrix} -K142r & K105r*cos(q_6r) - K143r*sin(q_6r) & K143r*cos(q_6r) + K105r*sin(q_6r) &  \end{matrix}\right] 
% \nonumber \\ 
K186r = K105r*cos(q_6r) - K143r*sin(q_6r);
K187r = K143r*cos(q_6r) + K105r*sin(q_6r);
% \bar{v}_{9r} &= \left[\begin{matrix} -K142r & K186r & K187r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{9r} &= \left[\begin{matrix} - K145r*dpsi - K149r*dq_1r - K147r*dq_w - K150r*dq_2r - K151r*dq_3r - K152r*dq_4r - K146r*dq_imu - K148r*dq_torso - K144r*dx & cos(q_6r)*(K108r*dpsi + K112r*dq_1r + K110r*dq_w + K113r*dq_2r + K109r*dq_imu + K111r*dq_torso + K107r*dx) - sin(q_6r)*(K154r*dpsi + K158r*dq_1r + K156r*dq_w + K159r*dq_2r + K160r*dq_3r + K161r*dq_4r + K155r*dq_imu + K157r*dq_torso + K153r*dx) & sin(q_6r)*(K108r*dpsi + K112r*dq_1r + K110r*dq_w + K113r*dq_2r + K109r*dq_imu + K111r*dq_torso + K107r*dx) + cos(q_6r)*(K154r*dpsi + K158r*dq_1r + K156r*dq_w + K159r*dq_2r + K160r*dq_3r + K161r*dq_4r + K155r*dq_imu + K157r*dq_torso + K153r*dx) &  \end{matrix}\right] 
% \nonumber \\ 
K188r = K107r*cos(q_6r) - K153r*sin(q_6r);
K189r = K108r*cos(q_6r) - K154r*sin(q_6r);
K190r = K109r*cos(q_6r) - K155r*sin(q_6r);
K191r = K110r*cos(q_6r) - K156r*sin(q_6r);
K192r = K111r*cos(q_6r) - K157r*sin(q_6r);
K193r = K112r*cos(q_6r) - K158r*sin(q_6r);
K194r = K113r*cos(q_6r) - K159r*sin(q_6r);
K195r = -K160r*sin(q_6r);
K196r = -K161r*sin(q_6r);
K197r = K153r*cos(q_6r) + K107r*sin(q_6r);
K198r = K154r*cos(q_6r) + K108r*sin(q_6r);
K199r = K155r*cos(q_6r) + K109r*sin(q_6r);
K200r = K156r*cos(q_6r) + K110r*sin(q_6r);
K201r = K157r*cos(q_6r) + K111r*sin(q_6r);
K202r = K158r*cos(q_6r) + K112r*sin(q_6r);
K203r = K159r*cos(q_6r) + K113r*sin(q_6r);
K204r = K160r*cos(q_6r);
K205r = K161r*cos(q_6r);
% \bar{v}_{9r} &= \left[\begin{matrix} - K145r*dpsi - K149r*dq_1r - K147r*dq_w - K150r*dq_2r - K151r*dq_3r - K152r*dq_4r - K146r*dq_imu - K148r*dq_torso - K144r*dx & K189r*dpsi + K193r*dq_1r + K191r*dq_w + K194r*dq_2r + K195r*dq_3r + K196r*dq_4r + K190r*dq_imu + K192r*dq_torso + K188r*dx & K198r*dpsi + K202r*dq_1r + K200r*dq_w + K203r*dq_2r + K204r*dq_3r + K205r*dq_4r + K199r*dq_imu + K201r*dq_torso + K197r*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{9r} &= {}^{9r}A_{8r} \bar\alpha_{8r} + \ddot{q}_{9r} \bar{e}_{9r} + \dot{q}_{9r} \left(\bar\omega_{9r} \times \bar{e}_{9r}\right) 
% \nonumber \\ 
% \bar\alpha_{9r} &= \left[\begin{matrix} - K162r - ddq_6r - K130r*ddpsi - K133r*ddq_1r - K131r*ddq_w - K134r*ddq_2r - K135r*ddq_3r - K131r*ddq_imu - K132r*ddq_torso - ddq_4r*cos(q_5r) & cos(q_6r)*(K121r + ddq_5r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) - K171r*dq_6r - sin(q_6r)*(K163r + K136r*ddpsi + K139r*ddq_1r + K137r*ddq_w + K140r*ddq_2r + K141r*ddq_3r + K137r*ddq_imu + K138r*ddq_torso - ddq_4r*sin(q_5r)) & K170r*dq_6r + sin(q_6r)*(K121r + ddq_5r + K95r*ddpsi + K98r*ddq_1r + K96r*ddq_w + K99r*ddq_2r + K96r*ddq_imu + K97r*ddq_torso + ddq_3r*cos(q_4r)) + cos(q_6r)*(K163r + K136r*ddpsi + K139r*ddq_1r + K137r*ddq_w + K140r*ddq_2r + K141r*ddq_3r + K137r*ddq_imu + K138r*ddq_torso - ddq_4r*sin(q_5r)) &  \end{matrix}\right] 
% \nonumber \\ 
K206r = K121r*cos(q_6r) - K171r*dq_6r - K163r*sin(q_6r);
K207r = K170r*dq_6r + K163r*cos(q_6r) + K121r*sin(q_6r);
% \bar\alpha_{9r} &= \left[\begin{matrix} - K162r - ddq_6r - K130r*ddpsi - K133r*ddq_1r - K131r*ddq_w - K134r*ddq_2r - K135r*ddq_3r - K131r*ddq_imu - K132r*ddq_torso - ddq_4r*cos(q_5r) & K206r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r) & K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{9r} &= {}^{9r}A_{8r} \left(\bar{a}_{8r} + \bar\alpha_{8r} \times \bar{P}_{9r} + \bar\omega_{8r} \times \left(\bar\omega_{8r} \times \bar{P}_{9r}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{9r} &= \left[\begin{matrix} - K164r - K145r*ddpsi - K149r*ddq_1r - K147r*ddq_w - K150r*ddq_2r - K151r*ddq_3r - K152r*ddq_4r - K146r*ddq_imu - K148r*ddq_torso - K144r*ddx & cos(q_6r)*(K108r*ddpsi - K165r + K112r*ddq_1r + K110r*ddq_w + K113r*ddq_2r + K109r*ddq_imu + K111r*ddq_torso + K107r*ddx) - sin(q_6r)*(K166r + K154r*ddpsi + K158r*ddq_1r + K156r*ddq_w + K159r*ddq_2r + K160r*ddq_3r + K161r*ddq_4r + K155r*ddq_imu + K157r*ddq_torso + K153r*ddx) & cos(q_6r)*(K166r + K154r*ddpsi + K158r*ddq_1r + K156r*ddq_w + K159r*ddq_2r + K160r*ddq_3r + K161r*ddq_4r + K155r*ddq_imu + K157r*ddq_torso + K153r*ddx) + sin(q_6r)*(K108r*ddpsi - K165r + K112r*ddq_1r + K110r*ddq_w + K113r*ddq_2r + K109r*ddq_imu + K111r*ddq_torso + K107r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
K208r = - K165r*cos(q_6r) - K166r*sin(q_6r);
K209r = K166r*cos(q_6r) - K165r*sin(q_6r);
% \bar{a}_{9r} &= \left[\begin{matrix} - K164r - K145r*ddpsi - K149r*ddq_1r - K147r*ddq_w - K150r*ddq_2r - K151r*ddq_3r - K152r*ddq_4r - K146r*ddq_imu - K148r*ddq_torso - K144r*ddx & K208r + K189r*ddpsi + K193r*ddq_1r + K191r*ddq_w + K194r*ddq_2r + K195r*ddq_3r + K196r*ddq_4r + K190r*ddq_imu + K192r*ddq_torso + K188r*ddx & K209r + K198r*ddpsi + K202r*ddq_1r + K200r*ddq_w + K203r*ddq_2r + K204r*ddq_3r + K205r*ddq_4r + K199r*ddq_imu + K201r*ddq_torso + K197r*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{9r} &= {}^{9r}A_{8r} \bar{g}_{8r} 
% \nonumber \\ 
% \bar{g}_{9r} &= \left[\begin{matrix} -K167r*g & K125r*g*cos(q_6r) - K168r*g*sin(q_6r) & K168r*g*cos(q_6r) + K125r*g*sin(q_6r) &  \end{matrix}\right] 
% \nonumber \\ 
K210r = K125r*cos(q_6r) - K168r*sin(q_6r);
K211r = K168r*cos(q_6r) + K125r*sin(q_6r);
% \bar{g}_{9r} &= \left[\begin{matrix} -K167r*g & K210r*g & K211r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{9r}\bar{S}_{9r}^{\times}\bar{g}_{9r} &= \mathbf{MS}_{9r} \times \bar{g}_{9r} 
% \nonumber \\ 
% m_{9r}\bar{S}_{9r}^{\times}\bar{g}_{9r} &= \left[\begin{matrix} K211r*MY_9r*g - K210r*MZ_9r*g & - K211r*MX_9r*g - K167r*MZ_9r*g & K210r*MX_9r*g + K167r*MY_9r*g &  \end{matrix}\right] 
% \nonumber \\ 
D256r = K211r*MY_9r - K210r*MZ_9r;
D257r = - K211r*MX_9r - K167r*MZ_9r;
D258r = K210r*MX_9r + K167r*MY_9r;
% m_{9r}\bar{S}_{9r}^{\times}\bar{g}_{9r} &= \left[\begin{matrix} D256r*g & D257r*g & D258r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{9r}\bar{a}_{G(9r)} &= m_{9r}\bar{a}_{9r} + \bar\alpha_{9r} \times \mathbf{MS}_{9r} + \bar\omega_{9r} \times \left(\bar\omega_{9r} \times \mathbf{MS}_{9r}\right) 
% \nonumber \\ 
% m_{9r}\bar{a}_{G(9r)} &= \left[\begin{matrix} MZ_9r*(K206r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) - MY_9r*(K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r)) - K170r*(K170r*MX_9r - K169r*MY_9r) - K171r*(K171r*MX_9r - K169r*MZ_9r) - m_9r*(K164r + K145r*ddpsi + K149r*ddq_1r + K147r*ddq_w + K150r*ddq_2r + K151r*ddq_3r + K152r*ddq_4r + K146r*ddq_imu + K148r*ddq_torso + K144r*ddx) & MX_9r*(K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r)) + MZ_9r*(K162r + ddq_6r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) + K169r*(K170r*MX_9r - K169r*MY_9r) - K171r*(K171r*MY_9r - K170r*MZ_9r) + m_9r*(K208r + K189r*ddpsi + K193r*ddq_1r + K191r*ddq_w + K194r*ddq_2r + K195r*ddq_3r + K196r*ddq_4r + K190r*ddq_imu + K192r*ddq_torso + K188r*ddx) & K169r*(K171r*MX_9r - K169r*MZ_9r) - MY_9r*(K162r + ddq_6r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) - MX_9r*(K206r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) + K170r*(K171r*MY_9r - K170r*MZ_9r) + m_9r*(K209r + K198r*ddpsi + K202r*ddq_1r + K200r*ddq_w + K203r*ddq_2r + K204r*ddq_3r + K205r*ddq_4r + K199r*ddq_imu + K201r*ddq_torso + K197r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D259r = -K144r*m_9r;
D260r = K172r*MZ_9r - K179r*MY_9r - K145r*m_9r;
D261r = K173r*MZ_9r - K180r*MY_9r - K146r*m_9r;
D262r = K173r*MZ_9r - K180r*MY_9r - K147r*m_9r;
D263r = K174r*MZ_9r - K181r*MY_9r - K148r*m_9r;
D264r = K175r*MZ_9r - K182r*MY_9r - K149r*m_9r;
D265r = K176r*MZ_9r - K183r*MY_9r - K150r*m_9r;
D266r = K177r*MZ_9r - K184r*MY_9r - K151r*m_9r;
D267r = K178r*MZ_9r - K185r*MY_9r - K152r*m_9r;
D268r = MZ_9r*cos(q_6r) - MY_9r*sin(q_6r);
D269r = K206r*MZ_9r - K170r^2*MX_9r - K171r^2*MX_9r - K207r*MY_9r - K164r*m_9r + K169r*K170r*MY_9r + K169r*K171r*MZ_9r;
D270r = K188r*m_9r;
D271r = K189r*m_9r + K179r*MX_9r + K130r*MZ_9r;
D272r = K190r*m_9r + K180r*MX_9r + K131r*MZ_9r;
D273r = K191r*m_9r + K180r*MX_9r + K131r*MZ_9r;
D274r = K192r*m_9r + K181r*MX_9r + K132r*MZ_9r;
D275r = K193r*m_9r + K182r*MX_9r + K133r*MZ_9r;
D276r = K194r*m_9r + K183r*MX_9r + K134r*MZ_9r;
D277r = K195r*m_9r + K184r*MX_9r + K135r*MZ_9r;
D278r = K196r*m_9r + MZ_9r*cos(q_5r) + K185r*MX_9r;
D279r = MX_9r*sin(q_6r);
D280r = K208r*m_9r - K169r^2*MY_9r - K171r^2*MY_9r + K207r*MX_9r + K162r*MZ_9r + K169r*K170r*MX_9r + K170r*K171r*MZ_9r;
D281r = K197r*m_9r;
D282r = K198r*m_9r - K172r*MX_9r - K130r*MY_9r;
D283r = K199r*m_9r - K173r*MX_9r - K131r*MY_9r;
D284r = K200r*m_9r - K173r*MX_9r - K131r*MY_9r;
D285r = K201r*m_9r - K174r*MX_9r - K132r*MY_9r;
D286r = K202r*m_9r - K175r*MX_9r - K133r*MY_9r;
D287r = K203r*m_9r - K176r*MX_9r - K134r*MY_9r;
D288r = K204r*m_9r - K177r*MX_9r - K135r*MY_9r;
D289r = K205r*m_9r - MY_9r*cos(q_5r) - K178r*MX_9r;
D290r = -MX_9r*cos(q_6r);
D291r = K209r*m_9r - K169r^2*MZ_9r - K170r^2*MZ_9r - K206r*MX_9r - K162r*MY_9r + K169r*K171r*MX_9r + K170r*K171r*MY_9r;
% m_{9r}\bar{a}_{G(9r)} &= \left[\begin{matrix} D269r + D260r*ddpsi + D264r*ddq_1r + D262r*ddq_w + D265r*ddq_2r + D266r*ddq_3r + D267r*ddq_4r + D268r*ddq_5r + D261r*ddq_imu + D263r*ddq_torso + D259r*ddx & D280r + D271r*ddpsi + D275r*ddq_1r + D273r*ddq_w + D276r*ddq_2r + D277r*ddq_3r + D278r*ddq_4r + D279r*ddq_5r + D272r*ddq_imu + D274r*ddq_torso + D270r*ddx + MZ_9r*ddq_6r & D291r + D282r*ddpsi + D286r*ddq_1r + D284r*ddq_w + D287r*ddq_2r + D288r*ddq_3r + D289r*ddq_4r + D290r*ddq_5r + D283r*ddq_imu + D285r*ddq_torso + D281r*ddx - MY_9r*ddq_6r &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{9r} &= \mathbf{MS}_{9r} \times \bar{a}_{9r} + J_{9r}\bar{\alpha}_{9r} + \bar\omega_{9r} \times J_{9r}\bar{\omega}_{9r} 
% \nonumber \\ 
% \dot{\bar{H}}_{9r} &= \left[\begin{matrix} K170r*(K169r*XZ_9r + K170r*YZ_9r + K171r*ZZ_9r) - K171r*(K169r*XY_9r + K170r*YY_9r + K171r*YZ_9r) + XY_9r*(K206r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) + XZ_9r*(K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r)) - XX_9r*(K162r + ddq_6r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) + MY_9r*(K209r + K198r*ddpsi + K202r*ddq_1r + K200r*ddq_w + K203r*ddq_2r + K204r*ddq_3r + K205r*ddq_4r + K199r*ddq_imu + K201r*ddq_torso + K197r*ddx) - MZ_9r*(K208r + K189r*ddpsi + K193r*ddq_1r + K191r*ddq_w + K194r*ddq_2r + K195r*ddq_3r + K196r*ddq_4r + K190r*ddq_imu + K192r*ddq_torso + K188r*ddx) & K171r*(K169r*XX_9r + K170r*XY_9r + K171r*XZ_9r) - K169r*(K169r*XZ_9r + K170r*YZ_9r + K171r*ZZ_9r) + YY_9r*(K206r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) + YZ_9r*(K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r)) - XY_9r*(K162r + ddq_6r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) - MX_9r*(K209r + K198r*ddpsi + K202r*ddq_1r + K200r*ddq_w + K203r*ddq_2r + K204r*ddq_3r + K205r*ddq_4r + K199r*ddq_imu + K201r*ddq_torso + K197r*ddx) - MZ_9r*(K164r + K145r*ddpsi + K149r*ddq_1r + K147r*ddq_w + K150r*ddq_2r + K151r*ddq_3r + K152r*ddq_4r + K146r*ddq_imu + K148r*ddq_torso + K144r*ddx) & K169r*(K169r*XY_9r + K170r*YY_9r + K171r*YZ_9r) - K170r*(K169r*XX_9r + K170r*XY_9r + K171r*XZ_9r) + YZ_9r*(K206r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) + ZZ_9r*(K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r)) - XZ_9r*(K162r + ddq_6r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) + MX_9r*(K208r + K189r*ddpsi + K193r*ddq_1r + K191r*ddq_w + K194r*ddq_2r + K195r*ddq_3r + K196r*ddq_4r + K190r*ddq_imu + K192r*ddq_torso + K188r*ddx) + MY_9r*(K164r + K145r*ddpsi + K149r*ddq_1r + K147r*ddq_w + K150r*ddq_2r + K151r*ddq_3r + K152r*ddq_4r + K146r*ddq_imu + K148r*ddq_torso + K144r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D292r = K197r*MY_9r - K188r*MZ_9r;
D293r = K172r*XY_9r - K130r*XX_9r + K179r*XZ_9r + K198r*MY_9r - K189r*MZ_9r;
D294r = K173r*XY_9r - K131r*XX_9r + K180r*XZ_9r + K199r*MY_9r - K190r*MZ_9r;
D295r = K173r*XY_9r - K131r*XX_9r + K180r*XZ_9r + K200r*MY_9r - K191r*MZ_9r;
D296r = K174r*XY_9r - K132r*XX_9r + K181r*XZ_9r + K201r*MY_9r - K192r*MZ_9r;
D297r = K175r*XY_9r - K133r*XX_9r + K182r*XZ_9r + K202r*MY_9r - K193r*MZ_9r;
D298r = K176r*XY_9r - K134r*XX_9r + K183r*XZ_9r + K203r*MY_9r - K194r*MZ_9r;
D299r = K177r*XY_9r - K135r*XX_9r + K184r*XZ_9r + K204r*MY_9r - K195r*MZ_9r;
D300r = K178r*XY_9r + K185r*XZ_9r - XX_9r*cos(q_5r) + K205r*MY_9r - K196r*MZ_9r;
D301r = XY_9r*cos(q_6r) + XZ_9r*sin(q_6r);
D302r = K206r*XY_9r - K162r*XX_9r + K207r*XZ_9r + K170r^2*YZ_9r - K171r^2*YZ_9r + K209r*MY_9r - K208r*MZ_9r - K169r*K171r*XY_9r + K169r*K170r*XZ_9r - K170r*K171r*YY_9r + K170r*K171r*ZZ_9r;
D303r = - K197r*MX_9r - K144r*MZ_9r;
D304r = K172r*YY_9r - K130r*XY_9r + K179r*YZ_9r - K198r*MX_9r - K145r*MZ_9r;
D305r = K173r*YY_9r - K131r*XY_9r + K180r*YZ_9r - K199r*MX_9r - K146r*MZ_9r;
D306r = K173r*YY_9r - K131r*XY_9r + K180r*YZ_9r - K200r*MX_9r - K147r*MZ_9r;
D307r = K174r*YY_9r - K132r*XY_9r + K181r*YZ_9r - K201r*MX_9r - K148r*MZ_9r;
D308r = K175r*YY_9r - K133r*XY_9r + K182r*YZ_9r - K202r*MX_9r - K149r*MZ_9r;
D309r = K176r*YY_9r - K134r*XY_9r + K183r*YZ_9r - K203r*MX_9r - K150r*MZ_9r;
D310r = K177r*YY_9r - K135r*XY_9r + K184r*YZ_9r - K204r*MX_9r - K151r*MZ_9r;
D311r = K178r*YY_9r + K185r*YZ_9r - XY_9r*cos(q_5r) - K205r*MX_9r - K152r*MZ_9r;
D312r = YY_9r*cos(q_6r) + YZ_9r*sin(q_6r);
D313r = K206r*YY_9r - K162r*XY_9r + K207r*YZ_9r - K169r^2*XZ_9r + K171r^2*XZ_9r - K209r*MX_9r - K164r*MZ_9r + K169r*K171r*XX_9r + K170r*K171r*XY_9r - K169r*K170r*YZ_9r - K169r*K171r*ZZ_9r;
D314r = K188r*MX_9r + K144r*MY_9r;
D315r = K172r*YZ_9r - K130r*XZ_9r + K179r*ZZ_9r + K189r*MX_9r + K145r*MY_9r;
D316r = K173r*YZ_9r - K131r*XZ_9r + K180r*ZZ_9r + K190r*MX_9r + K146r*MY_9r;
D317r = K173r*YZ_9r - K131r*XZ_9r + K180r*ZZ_9r + K191r*MX_9r + K147r*MY_9r;
D318r = K174r*YZ_9r - K132r*XZ_9r + K181r*ZZ_9r + K192r*MX_9r + K148r*MY_9r;
D319r = K175r*YZ_9r - K133r*XZ_9r + K182r*ZZ_9r + K193r*MX_9r + K149r*MY_9r;
D320r = K176r*YZ_9r - K134r*XZ_9r + K183r*ZZ_9r + K194r*MX_9r + K150r*MY_9r;
D321r = K177r*YZ_9r - K135r*XZ_9r + K184r*ZZ_9r + K195r*MX_9r + K151r*MY_9r;
D322r = K178r*YZ_9r + K185r*ZZ_9r - XZ_9r*cos(q_5r) + K196r*MX_9r + K152r*MY_9r;
D323r = YZ_9r*cos(q_6r) + ZZ_9r*sin(q_6r);
D324r = K206r*YZ_9r - K162r*XZ_9r + K207r*ZZ_9r + K169r^2*XY_9r - K170r^2*XY_9r + K208r*MX_9r + K164r*MY_9r - K169r*K170r*XX_9r - K170r*K171r*XZ_9r + K169r*K170r*YY_9r + K169r*K171r*YZ_9r;
% \dot{\bar{H}}_{9r} &= \left[\begin{matrix} D269r + D260r*ddpsi + D264r*ddq_1r + D262r*ddq_w + D265r*ddq_2r + D266r*ddq_3r + D267r*ddq_4r + D268r*ddq_5r + D261r*ddq_imu + D263r*ddq_torso + D259r*ddx & D280r + D271r*ddpsi + D275r*ddq_1r + D273r*ddq_w + D276r*ddq_2r + D277r*ddq_3r + D278r*ddq_4r + D279r*ddq_5r + D272r*ddq_imu + D274r*ddq_torso + D270r*ddx + MZ_9r*ddq_6r & D291r + D282r*ddpsi + D286r*ddq_1r + D284r*ddq_w + D287r*ddq_2r + D288r*ddq_3r + D289r*ddq_4r + D290r*ddq_5r + D283r*ddq_imu + D285r*ddq_torso + D281r*ddx - MY_9r*ddq_6r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{10r} &= {}^{10r}A_{9r} \bar\omega_{9r} + \dot{q}_{10r} \bar{e}_{10r} 
% \nonumber \\ 
% \bar\omega_{10r} &= \left[\begin{matrix} K171r*sin(q_7r) - K169r*cos(q_7r) & - K171r*cos(q_7r) - K169r*sin(q_7r) & - K170r - dq_7r &  \end{matrix}\right] 
% \nonumber \\ 
K212r = K171r*sin(q_7r) - K169r*cos(q_7r);
K213r = - K171r*cos(q_7r) - K169r*sin(q_7r);
K214r = - K170r - dq_7r;
% \bar\omega_{10r} &= \left[\begin{matrix} K212r & K213r & K214r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\omega_{10r} &= \left[\begin{matrix} sin(q_7r)*(K179r*dpsi + K182r*dq_1r + K180r*dq_w + K183r*dq_2r + K184r*dq_3r + K185r*dq_4r + K180r*dq_imu + K181r*dq_torso + dq_5r*sin(q_6r)) + cos(q_7r)*(dq_6r + K130r*dpsi + K133r*dq_1r + K131r*dq_w + K134r*dq_2r + K135r*dq_3r + K131r*dq_imu + K132r*dq_torso + dq_4r*cos(q_5r)) & sin(q_7r)*(dq_6r + K130r*dpsi + K133r*dq_1r + K131r*dq_w + K134r*dq_2r + K135r*dq_3r + K131r*dq_imu + K132r*dq_torso + dq_4r*cos(q_5r)) - cos(q_7r)*(K179r*dpsi + K182r*dq_1r + K180r*dq_w + K183r*dq_2r + K184r*dq_3r + K185r*dq_4r + K180r*dq_imu + K181r*dq_torso + dq_5r*sin(q_6r)) & - dq_7r - K172r*dpsi - K175r*dq_1r - K173r*dq_w - K176r*dq_2r - K177r*dq_3r - K178r*dq_4r - K173r*dq_imu - K174r*dq_torso - dq_5r*cos(q_6r) &  \end{matrix}\right] 
% \nonumber \\ 
K215r = K130r*cos(q_7r) + K179r*sin(q_7r);
K216r = K131r*cos(q_7r) + K180r*sin(q_7r);
K217r = K132r*cos(q_7r) + K181r*sin(q_7r);
K218r = K133r*cos(q_7r) + K182r*sin(q_7r);
K219r = K134r*cos(q_7r) + K183r*sin(q_7r);
K220r = K135r*cos(q_7r) + K184r*sin(q_7r);
K221r = cos(q_5r)*cos(q_7r) + K185r*sin(q_7r);
K222r = sin(q_6r)*sin(q_7r);
K223r = K130r*sin(q_7r) - K179r*cos(q_7r);
K224r = K131r*sin(q_7r) - K180r*cos(q_7r);
K225r = K132r*sin(q_7r) - K181r*cos(q_7r);
K226r = K133r*sin(q_7r) - K182r*cos(q_7r);
K227r = K134r*sin(q_7r) - K183r*cos(q_7r);
K228r = K135r*sin(q_7r) - K184r*cos(q_7r);
K229r = cos(q_5r)*sin(q_7r) - K185r*cos(q_7r);
K230r = -cos(q_7r)*sin(q_6r);
% \bar\omega_{10r} &= \left[\begin{matrix} K215r*dpsi + K218r*dq_1r + K216r*dq_w + K219r*dq_2r + K220r*dq_3r + K221r*dq_4r + K222r*dq_5r + K216r*dq_imu + K217r*dq_torso + dq_6r*cos(q_7r) & K223r*dpsi + K226r*dq_1r + K224r*dq_w + K227r*dq_2r + K228r*dq_3r + K229r*dq_4r + K230r*dq_5r + K224r*dq_imu + K225r*dq_torso + dq_6r*sin(q_7r) & - dq_7r - K172r*dpsi - K175r*dq_1r - K173r*dq_w - K176r*dq_2r - K177r*dq_3r - K178r*dq_4r - K173r*dq_imu - K174r*dq_torso - dq_5r*cos(q_6r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{10r} &= {}^{10r}A_{9r} \left(\bar{v}_{9r} + \bar\omega_{9r} \times \bar{P}_{10r}\right) 
% \nonumber \\ 
% \bar{v}_{10r} &= \left[\begin{matrix} cos(q_7r)*(K142r - K171r*L9) + sin(q_7r)*(K187r - K169r*L9) & sin(q_7r)*(K142r - K171r*L9) - cos(q_7r)*(K187r - K169r*L9) & -K186r &  \end{matrix}\right] 
% \nonumber \\ 
K231r = cos(q_7r)*(K142r - K171r*L9) + sin(q_7r)*(K187r - K169r*L9);
K232r = sin(q_7r)*(K142r - K171r*L9) - cos(q_7r)*(K187r - K169r*L9);
% \bar{v}_{10r} &= \left[\begin{matrix} K231r & K232r & -K186r &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{v}_{10r} &= \left[\begin{matrix} cos(q_7r)*(K145r*dpsi + K149r*dq_1r + K147r*dq_w + K150r*dq_2r + K151r*dq_3r + K152r*dq_4r + K146r*dq_imu + K148r*dq_torso + K144r*dx - L9*(K179r*dpsi + K182r*dq_1r + K180r*dq_w + K183r*dq_2r + K184r*dq_3r + K185r*dq_4r + K180r*dq_imu + K181r*dq_torso + dq_5r*sin(q_6r))) + sin(q_7r)*(K198r*dpsi + K202r*dq_1r + K200r*dq_w + K203r*dq_2r + K204r*dq_3r + K205r*dq_4r + K199r*dq_imu + K201r*dq_torso + K197r*dx + L9*(dq_6r + K130r*dpsi + K133r*dq_1r + K131r*dq_w + K134r*dq_2r + K135r*dq_3r + K131r*dq_imu + K132r*dq_torso + dq_4r*cos(q_5r))) & sin(q_7r)*(K145r*dpsi + K149r*dq_1r + K147r*dq_w + K150r*dq_2r + K151r*dq_3r + K152r*dq_4r + K146r*dq_imu + K148r*dq_torso + K144r*dx - L9*(K179r*dpsi + K182r*dq_1r + K180r*dq_w + K183r*dq_2r + K184r*dq_3r + K185r*dq_4r + K180r*dq_imu + K181r*dq_torso + dq_5r*sin(q_6r))) - cos(q_7r)*(K198r*dpsi + K202r*dq_1r + K200r*dq_w + K203r*dq_2r + K204r*dq_3r + K205r*dq_4r + K199r*dq_imu + K201r*dq_torso + K197r*dx + L9*(dq_6r + K130r*dpsi + K133r*dq_1r + K131r*dq_w + K134r*dq_2r + K135r*dq_3r + K131r*dq_imu + K132r*dq_torso + dq_4r*cos(q_5r))) & - K189r*dpsi - K193r*dq_1r - K191r*dq_w - K194r*dq_2r - K195r*dq_3r - K196r*dq_4r - K190r*dq_imu - K192r*dq_torso - K188r*dx &  \end{matrix}\right] 
% \nonumber \\ 
K233r = K144r*cos(q_7r) + K197r*sin(q_7r);
K234r = cos(q_7r)*(K145r - K179r*L9) + sin(q_7r)*(K198r + K130r*L9);
K235r = cos(q_7r)*(K146r - K180r*L9) + sin(q_7r)*(K199r + K131r*L9);
K236r = cos(q_7r)*(K147r - K180r*L9) + sin(q_7r)*(K200r + K131r*L9);
K237r = cos(q_7r)*(K148r - K181r*L9) + sin(q_7r)*(K201r + K132r*L9);
K238r = cos(q_7r)*(K149r - K182r*L9) + sin(q_7r)*(K202r + K133r*L9);
K239r = cos(q_7r)*(K150r - K183r*L9) + sin(q_7r)*(K203r + K134r*L9);
K240r = cos(q_7r)*(K151r - K184r*L9) + sin(q_7r)*(K204r + K135r*L9);
K241r = sin(q_7r)*(K205r + L9*cos(q_5r)) + cos(q_7r)*(K152r - K185r*L9);
K242r = -L9*cos(q_7r)*sin(q_6r);
K243r = L9*sin(q_7r);
K244r = K144r*sin(q_7r) - K197r*cos(q_7r);
K245r = sin(q_7r)*(K145r - K179r*L9) - cos(q_7r)*(K198r + K130r*L9);
K246r = sin(q_7r)*(K146r - K180r*L9) - cos(q_7r)*(K199r + K131r*L9);
K247r = sin(q_7r)*(K147r - K180r*L9) - cos(q_7r)*(K200r + K131r*L9);
K248r = sin(q_7r)*(K148r - K181r*L9) - cos(q_7r)*(K201r + K132r*L9);
K249r = sin(q_7r)*(K149r - K182r*L9) - cos(q_7r)*(K202r + K133r*L9);
K250r = sin(q_7r)*(K150r - K183r*L9) - cos(q_7r)*(K203r + K134r*L9);
K251r = sin(q_7r)*(K151r - K184r*L9) - cos(q_7r)*(K204r + K135r*L9);
K252r = sin(q_7r)*(K152r - K185r*L9) - cos(q_7r)*(K205r + L9*cos(q_5r));
K253r = -L9*sin(q_6r)*sin(q_7r);
K254r = -L9*cos(q_7r);
% \bar{v}_{10r} &= \left[\begin{matrix} K234r*dpsi + K238r*dq_1r + K236r*dq_w + K239r*dq_2r + K240r*dq_3r + K241r*dq_4r + K242r*dq_5r + K243r*dq_6r + K235r*dq_imu + K237r*dq_torso + K233r*dx & K245r*dpsi + K249r*dq_1r + K247r*dq_w + K250r*dq_2r + K251r*dq_3r + K252r*dq_4r + K253r*dq_5r + K254r*dq_6r + K246r*dq_imu + K248r*dq_torso + K244r*dx & - K189r*dpsi - K193r*dq_1r - K191r*dq_w - K194r*dq_2r - K195r*dq_3r - K196r*dq_4r - K190r*dq_imu - K192r*dq_torso - K188r*dx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar\alpha_{10r} &= {}^{10r}A_{9r} \bar\alpha_{9r} + \ddot{q}_{10r} \bar{e}_{10r} + \dot{q}_{10r} \left(\bar\omega_{10r} \times \bar{e}_{10r}\right) 
% \nonumber \\ 
% \bar\alpha_{10r} &= \left[\begin{matrix} sin(q_7r)*(K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r)) - K213r*dq_7r + cos(q_7r)*(K162r + ddq_6r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) & K212r*dq_7r + sin(q_7r)*(K162r + ddq_6r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) - cos(q_7r)*(K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r)) & - K206r - ddq_7r - K172r*ddpsi - K175r*ddq_1r - K173r*ddq_w - K176r*ddq_2r - K177r*ddq_3r - K178r*ddq_4r - K173r*ddq_imu - K174r*ddq_torso - ddq_5r*cos(q_6r) &  \end{matrix}\right] 
% \nonumber \\ 
K255r = K162r*cos(q_7r) - K213r*dq_7r + K207r*sin(q_7r);
K256r = K212r*dq_7r - K207r*cos(q_7r) + K162r*sin(q_7r);
% \bar\alpha_{10r} &= \left[\begin{matrix} K255r + K215r*ddpsi + K218r*ddq_1r + K216r*ddq_w + K219r*ddq_2r + K220r*ddq_3r + K221r*ddq_4r + K222r*ddq_5r + K216r*ddq_imu + K217r*ddq_torso + ddq_6r*cos(q_7r) & K256r + K223r*ddpsi + K226r*ddq_1r + K224r*ddq_w + K227r*ddq_2r + K228r*ddq_3r + K229r*ddq_4r + K230r*ddq_5r + K224r*ddq_imu + K225r*ddq_torso + ddq_6r*sin(q_7r) & - K206r - ddq_7r - K172r*ddpsi - K175r*ddq_1r - K173r*ddq_w - K176r*ddq_2r - K177r*ddq_3r - K178r*ddq_4r - K173r*ddq_imu - K174r*ddq_torso - ddq_5r*cos(q_6r) &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{a}_{10r} &= {}^{10r}A_{9r} \left(\bar{a}_{9r} + \bar\alpha_{9r} \times \bar{P}_{10r} + \bar\omega_{9r} \times \left(\bar\omega_{9r} \times \bar{P}_{10r}\right)\right) 
% \nonumber \\ 
% \bar\alpha_{10r} &= \left[\begin{matrix} cos(q_7r)*(K164r + K145r*ddpsi + K149r*ddq_1r + K147r*ddq_w + K150r*ddq_2r + K151r*ddq_3r + K152r*ddq_4r + K146r*ddq_imu + K148r*ddq_torso + K144r*ddx - L9*(K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r)) + K169r*K170r*L9) + sin(q_7r)*(K209r + K198r*ddpsi + K202r*ddq_1r + K200r*ddq_w + K203r*ddq_2r + K204r*ddq_3r + K205r*ddq_4r + K199r*ddq_imu + K201r*ddq_torso + K197r*ddx + L9*(K162r + ddq_6r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) - K170r*K171r*L9) & sin(q_7r)*(K164r + K145r*ddpsi + K149r*ddq_1r + K147r*ddq_w + K150r*ddq_2r + K151r*ddq_3r + K152r*ddq_4r + K146r*ddq_imu + K148r*ddq_torso + K144r*ddx - L9*(K207r + K179r*ddpsi + K182r*ddq_1r + K180r*ddq_w + K183r*ddq_2r + K184r*ddq_3r + K185r*ddq_4r + K180r*ddq_imu + K181r*ddq_torso + ddq_5r*sin(q_6r)) + K169r*K170r*L9) - cos(q_7r)*(K209r + K198r*ddpsi + K202r*ddq_1r + K200r*ddq_w + K203r*ddq_2r + K204r*ddq_3r + K205r*ddq_4r + K199r*ddq_imu + K201r*ddq_torso + K197r*ddx + L9*(K162r + ddq_6r + K130r*ddpsi + K133r*ddq_1r + K131r*ddq_w + K134r*ddq_2r + K135r*ddq_3r + K131r*ddq_imu + K132r*ddq_torso + ddq_4r*cos(q_5r)) - K170r*K171r*L9) & - K208r - K189r*ddpsi - K193r*ddq_1r - K191r*ddq_w - K194r*ddq_2r - K195r*ddq_3r - K196r*ddq_4r - K190r*ddq_imu - K192r*ddq_torso - K188r*ddx - K169r^2*L9 - K171r^2*L9 &  \end{matrix}\right] 
% \nonumber \\ 
K257r = K164r*cos(q_7r) + K209r*sin(q_7r) - K207r*L9*cos(q_7r) + K162r*L9*sin(q_7r) + K169r*K170r*L9*cos(q_7r) - K170r*K171r*L9*sin(q_7r);
K258r = K164r*sin(q_7r) - K209r*cos(q_7r) - K162r*L9*cos(q_7r) - K207r*L9*sin(q_7r) + K170r*K171r*L9*cos(q_7r) + K169r*K170r*L9*sin(q_7r);
K259r = - K208r - K169r^2*L9 - K171r^2*L9;
% \bar{a}_{10r} &= \left[\begin{matrix} K257r + K234r*ddpsi + K238r*ddq_1r + K236r*ddq_w + K239r*ddq_2r + K240r*ddq_3r + K241r*ddq_4r + K242r*ddq_5r + K243r*ddq_6r + K235r*ddq_imu + K237r*ddq_torso + K233r*ddx & K258r + K245r*ddpsi + K249r*ddq_1r + K247r*ddq_w + K250r*ddq_2r + K251r*ddq_3r + K252r*ddq_4r + K253r*ddq_5r + K254r*ddq_6r + K246r*ddq_imu + K248r*ddq_torso + K244r*ddx & K259r - K189r*ddpsi - K193r*ddq_1r - K191r*ddq_w - K194r*ddq_2r - K195r*ddq_3r - K196r*ddq_4r - K190r*ddq_imu - K192r*ddq_torso - K188r*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \bar{g}_{10r} &= {}^{10r}A_{9r} \bar{g}_{9r} 
% \nonumber \\ 
% \bar{g}_{10r} &= \left[\begin{matrix} K167r*g*cos(q_7r) + K211r*g*sin(q_7r) & K167r*g*sin(q_7r) - K211r*g*cos(q_7r) & -K210r*g &  \end{matrix}\right] 
% \nonumber \\ 
K260r = K167r*cos(q_7r) + K211r*sin(q_7r);
K261r = K167r*sin(q_7r) - K211r*cos(q_7r);
% \bar{g}_{10r} &= \left[\begin{matrix} K260r*g & K261r*g & -K210r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{10r}\bar{S}_{10r}^{\times}\bar{g}_{10r} &= \mathbf{MS}_{10r} \times \bar{g}_{10r} 
% \nonumber \\ 
% m_{10r}\bar{S}_{10r}^{\times}\bar{g}_{10r} &= \left[\begin{matrix} - K210r*MY_10r*g - K261r*MZ_10r*g & K210r*MX_10r*g + K260r*MZ_10r*g & K261r*MX_10r*g - K260r*MY_10r*g &  \end{matrix}\right] 
% \nonumber \\ 
D325r = - K210r*MY_10r - K261r*MZ_10r;
D326r = K210r*MX_10r + K260r*MZ_10r;
D327r = K261r*MX_10r - K260r*MY_10r;
% m_{10r}\bar{S}_{10r}^{\times}\bar{g}_{10r} &= \left[\begin{matrix} D325r*g & D326r*g & D327r*g &  \end{matrix}\right] 
% \nonumber \\ 
% m_{10r}\bar{a}_{G(10r)} &= m_{10r}\bar{a}_{10r} + \bar\alpha_{10r} \times \mathbf{MS}_{10r} + \bar\omega_{10r} \times \left(\bar\omega_{10r} \times \mathbf{MS}_{10r}\right) 
% \nonumber \\ 
% m_{10r}\bar{a}_{G(10r)} &= \left[\begin{matrix} m_10r*(K257r + K234r*ddpsi + K238r*ddq_1r + K236r*ddq_w + K239r*ddq_2r + K240r*ddq_3r + K241r*ddq_4r + K242r*ddq_5r + K243r*ddq_6r + K235r*ddq_imu + K237r*ddq_torso + K233r*ddx) + MZ_10r*(K256r + K223r*ddpsi + K226r*ddq_1r + K224r*ddq_w + K227r*ddq_2r + K228r*ddq_3r + K229r*ddq_4r + K230r*ddq_5r + K224r*ddq_imu + K225r*ddq_torso + ddq_6r*sin(q_7r)) + MY_10r*(K206r + ddq_7r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) - K213r*(K213r*MX_10r - K212r*MY_10r) - K214r*(K214r*MX_10r - K212r*MZ_10r) & m_10r*(K258r + K245r*ddpsi + K249r*ddq_1r + K247r*ddq_w + K250r*ddq_2r + K251r*ddq_3r + K252r*ddq_4r + K253r*ddq_5r + K254r*ddq_6r + K246r*ddq_imu + K248r*ddq_torso + K244r*ddx) - MZ_10r*(K255r + K215r*ddpsi + K218r*ddq_1r + K216r*ddq_w + K219r*ddq_2r + K220r*ddq_3r + K221r*ddq_4r + K222r*ddq_5r + K216r*ddq_imu + K217r*ddq_torso + ddq_6r*cos(q_7r)) - MX_10r*(K206r + ddq_7r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) + K212r*(K213r*MX_10r - K212r*MY_10r) - K214r*(K214r*MY_10r - K213r*MZ_10r) & MY_10r*(K255r + K215r*ddpsi + K218r*ddq_1r + K216r*ddq_w + K219r*ddq_2r + K220r*ddq_3r + K221r*ddq_4r + K222r*ddq_5r + K216r*ddq_imu + K217r*ddq_torso + ddq_6r*cos(q_7r)) - m_10r*(K189r*ddpsi - K259r + K193r*ddq_1r + K191r*ddq_w + K194r*ddq_2r + K195r*ddq_3r + K196r*ddq_4r + K190r*ddq_imu + K192r*ddq_torso + K188r*ddx) - MX_10r*(K256r + K223r*ddpsi + K226r*ddq_1r + K224r*ddq_w + K227r*ddq_2r + K228r*ddq_3r + K229r*ddq_4r + K230r*ddq_5r + K224r*ddq_imu + K225r*ddq_torso + ddq_6r*sin(q_7r)) + K212r*(K214r*MX_10r - K212r*MZ_10r) + K213r*(K214r*MY_10r - K213r*MZ_10r) &  \end{matrix}\right] 
% \nonumber \\ 
D328r = K233r*m_10r;
D329r = K234r*m_10r + K172r*MY_10r + K223r*MZ_10r;
D330r = K235r*m_10r + K173r*MY_10r + K224r*MZ_10r;
D331r = K236r*m_10r + K173r*MY_10r + K224r*MZ_10r;
D332r = K237r*m_10r + K174r*MY_10r + K225r*MZ_10r;
D333r = K238r*m_10r + K175r*MY_10r + K226r*MZ_10r;
D334r = K239r*m_10r + K176r*MY_10r + K227r*MZ_10r;
D335r = K240r*m_10r + K177r*MY_10r + K228r*MZ_10r;
D336r = K241r*m_10r + K178r*MY_10r + K229r*MZ_10r;
D337r = K242r*m_10r + MY_10r*cos(q_6r) + K230r*MZ_10r;
D338r = K243r*m_10r + MZ_10r*sin(q_7r);
D339r = K257r*m_10r - K213r^2*MX_10r - K214r^2*MX_10r + K206r*MY_10r + K256r*MZ_10r + K212r*K213r*MY_10r + K212r*K214r*MZ_10r;
D340r = K244r*m_10r;
D341r = K245r*m_10r - K172r*MX_10r - K215r*MZ_10r;
D342r = K246r*m_10r - K173r*MX_10r - K216r*MZ_10r;
D343r = K247r*m_10r - K173r*MX_10r - K216r*MZ_10r;
D344r = K248r*m_10r - K174r*MX_10r - K217r*MZ_10r;
D345r = K249r*m_10r - K175r*MX_10r - K218r*MZ_10r;
D346r = K250r*m_10r - K176r*MX_10r - K219r*MZ_10r;
D347r = K251r*m_10r - K177r*MX_10r - K220r*MZ_10r;
D348r = K252r*m_10r - K178r*MX_10r - K221r*MZ_10r;
D349r = K253r*m_10r - MX_10r*cos(q_6r) - K222r*MZ_10r;
D350r = K254r*m_10r - MZ_10r*cos(q_7r);
D351r = K258r*m_10r - K212r^2*MY_10r - K214r^2*MY_10r - K206r*MX_10r - K255r*MZ_10r + K212r*K213r*MX_10r + K213r*K214r*MZ_10r;
D352r = -K188r*m_10r;
D353r = K215r*MY_10r - K223r*MX_10r - K189r*m_10r;
D354r = K216r*MY_10r - K224r*MX_10r - K190r*m_10r;
D355r = K216r*MY_10r - K224r*MX_10r - K191r*m_10r;
D356r = K217r*MY_10r - K225r*MX_10r - K192r*m_10r;
D357r = K218r*MY_10r - K226r*MX_10r - K193r*m_10r;
D358r = K219r*MY_10r - K227r*MX_10r - K194r*m_10r;
D359r = K220r*MY_10r - K228r*MX_10r - K195r*m_10r;
D360r = K221r*MY_10r - K229r*MX_10r - K196r*m_10r;
D361r = K222r*MY_10r - K230r*MX_10r;
D362r = MY_10r*cos(q_7r) - MX_10r*sin(q_7r);
D363r = K259r*m_10r - K212r^2*MZ_10r - K213r^2*MZ_10r - K256r*MX_10r + K255r*MY_10r + K212r*K214r*MX_10r + K213r*K214r*MY_10r;
% m_{10r}\bar{a}_{G(10r)} &= \left[\begin{matrix} D339r + D329r*ddpsi + D333r*ddq_1r + D331r*ddq_w + D334r*ddq_2r + D335r*ddq_3r + D336r*ddq_4r + D337r*ddq_5r + D338r*ddq_6r + D330r*ddq_imu + D332r*ddq_torso + D328r*ddx + MY_10r*ddq_7r & D351r + D341r*ddpsi + D345r*ddq_1r + D343r*ddq_w + D346r*ddq_2r + D347r*ddq_3r + D348r*ddq_4r + D349r*ddq_5r + D350r*ddq_6r + D342r*ddq_imu + D344r*ddq_torso + D340r*ddx - MX_10r*ddq_7r & D363r + D353r*ddpsi + D357r*ddq_1r + D355r*ddq_w + D358r*ddq_2r + D359r*ddq_3r + D360r*ddq_4r + D361r*ddq_5r + D362r*ddq_6r + D354r*ddq_imu + D356r*ddq_torso + D352r*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \mathbf{MS}_{10r} \times \bar{a}_{10r} + J_{10r}\bar{\alpha}_{10r} + \bar\omega_{10r} \times J_{10r}\bar{\omega}_{10r} 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \left[\begin{matrix} K213r*(K212r*XZ_10r + K213r*YZ_10r + K214r*ZZ_10r) - K214r*(K212r*XY_10r + K213r*YY_10r + K214r*YZ_10r) - MY_10r*(K189r*ddpsi - K259r + K193r*ddq_1r + K191r*ddq_w + K194r*ddq_2r + K195r*ddq_3r + K196r*ddq_4r + K190r*ddq_imu + K192r*ddq_torso + K188r*ddx) + XX_10r*(K255r + K215r*ddpsi + K218r*ddq_1r + K216r*ddq_w + K219r*ddq_2r + K220r*ddq_3r + K221r*ddq_4r + K222r*ddq_5r + K216r*ddq_imu + K217r*ddq_torso + ddq_6r*cos(q_7r)) + XY_10r*(K256r + K223r*ddpsi + K226r*ddq_1r + K224r*ddq_w + K227r*ddq_2r + K228r*ddq_3r + K229r*ddq_4r + K230r*ddq_5r + K224r*ddq_imu + K225r*ddq_torso + ddq_6r*sin(q_7r)) - XZ_10r*(K206r + ddq_7r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) - MZ_10r*(K258r + K245r*ddpsi + K249r*ddq_1r + K247r*ddq_w + K250r*ddq_2r + K251r*ddq_3r + K252r*ddq_4r + K253r*ddq_5r + K254r*ddq_6r + K246r*ddq_imu + K248r*ddq_torso + K244r*ddx) & K214r*(K212r*XX_10r + K213r*XY_10r + K214r*XZ_10r) - K212r*(K212r*XZ_10r + K213r*YZ_10r + K214r*ZZ_10r) + MX_10r*(K189r*ddpsi - K259r + K193r*ddq_1r + K191r*ddq_w + K194r*ddq_2r + K195r*ddq_3r + K196r*ddq_4r + K190r*ddq_imu + K192r*ddq_torso + K188r*ddx) + XY_10r*(K255r + K215r*ddpsi + K218r*ddq_1r + K216r*ddq_w + K219r*ddq_2r + K220r*ddq_3r + K221r*ddq_4r + K222r*ddq_5r + K216r*ddq_imu + K217r*ddq_torso + ddq_6r*cos(q_7r)) + YY_10r*(K256r + K223r*ddpsi + K226r*ddq_1r + K224r*ddq_w + K227r*ddq_2r + K228r*ddq_3r + K229r*ddq_4r + K230r*ddq_5r + K224r*ddq_imu + K225r*ddq_torso + ddq_6r*sin(q_7r)) - YZ_10r*(K206r + ddq_7r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) + MZ_10r*(K257r + K234r*ddpsi + K238r*ddq_1r + K236r*ddq_w + K239r*ddq_2r + K240r*ddq_3r + K241r*ddq_4r + K242r*ddq_5r + K243r*ddq_6r + K235r*ddq_imu + K237r*ddq_torso + K233r*ddx) & K212r*(K212r*XY_10r + K213r*YY_10r + K214r*YZ_10r) - K213r*(K212r*XX_10r + K213r*XY_10r + K214r*XZ_10r) + XZ_10r*(K255r + K215r*ddpsi + K218r*ddq_1r + K216r*ddq_w + K219r*ddq_2r + K220r*ddq_3r + K221r*ddq_4r + K222r*ddq_5r + K216r*ddq_imu + K217r*ddq_torso + ddq_6r*cos(q_7r)) + YZ_10r*(K256r + K223r*ddpsi + K226r*ddq_1r + K224r*ddq_w + K227r*ddq_2r + K228r*ddq_3r + K229r*ddq_4r + K230r*ddq_5r + K224r*ddq_imu + K225r*ddq_torso + ddq_6r*sin(q_7r)) - ZZ_10r*(K206r + ddq_7r + K172r*ddpsi + K175r*ddq_1r + K173r*ddq_w + K176r*ddq_2r + K177r*ddq_3r + K178r*ddq_4r + K173r*ddq_imu + K174r*ddq_torso + ddq_5r*cos(q_6r)) + MX_10r*(K258r + K245r*ddpsi + K249r*ddq_1r + K247r*ddq_w + K250r*ddq_2r + K251r*ddq_3r + K252r*ddq_4r + K253r*ddq_5r + K254r*ddq_6r + K246r*ddq_imu + K248r*ddq_torso + K244r*ddx) - MY_10r*(K257r + K234r*ddpsi + K238r*ddq_1r + K236r*ddq_w + K239r*ddq_2r + K240r*ddq_3r + K241r*ddq_4r + K242r*ddq_5r + K243r*ddq_6r + K235r*ddq_imu + K237r*ddq_torso + K233r*ddx) &  \end{matrix}\right] 
% \nonumber \\ 
D364r = - K188r*MY_10r - K244r*MZ_10r;
D365r = K215r*XX_10r + K223r*XY_10r - K172r*XZ_10r - K189r*MY_10r - K245r*MZ_10r;
D366r = K216r*XX_10r + K224r*XY_10r - K173r*XZ_10r - K190r*MY_10r - K246r*MZ_10r;
D367r = K216r*XX_10r + K224r*XY_10r - K173r*XZ_10r - K191r*MY_10r - K247r*MZ_10r;
D368r = K217r*XX_10r + K225r*XY_10r - K174r*XZ_10r - K192r*MY_10r - K248r*MZ_10r;
D369r = K218r*XX_10r + K226r*XY_10r - K175r*XZ_10r - K193r*MY_10r - K249r*MZ_10r;
D370r = K219r*XX_10r + K227r*XY_10r - K176r*XZ_10r - K194r*MY_10r - K250r*MZ_10r;
D371r = K220r*XX_10r + K228r*XY_10r - K177r*XZ_10r - K195r*MY_10r - K251r*MZ_10r;
D372r = K221r*XX_10r + K229r*XY_10r - K178r*XZ_10r - K196r*MY_10r - K252r*MZ_10r;
D373r = K222r*XX_10r + K230r*XY_10r - XZ_10r*cos(q_6r) - K253r*MZ_10r;
D374r = XX_10r*cos(q_7r) + XY_10r*sin(q_7r) - K254r*MZ_10r;
D375r = K255r*XX_10r + K256r*XY_10r - K206r*XZ_10r + K213r^2*YZ_10r - K214r^2*YZ_10r + K259r*MY_10r - K258r*MZ_10r - K212r*K214r*XY_10r + K212r*K213r*XZ_10r - K213r*K214r*YY_10r + K213r*K214r*ZZ_10r;
D376r = K188r*MX_10r + K233r*MZ_10r;
D377r = K215r*XY_10r + K223r*YY_10r - K172r*YZ_10r + K189r*MX_10r + K234r*MZ_10r;
D378r = K216r*XY_10r + K224r*YY_10r - K173r*YZ_10r + K190r*MX_10r + K235r*MZ_10r;
D379r = K216r*XY_10r + K224r*YY_10r - K173r*YZ_10r + K191r*MX_10r + K236r*MZ_10r;
D380r = K217r*XY_10r + K225r*YY_10r - K174r*YZ_10r + K192r*MX_10r + K237r*MZ_10r;
D381r = K218r*XY_10r + K226r*YY_10r - K175r*YZ_10r + K193r*MX_10r + K238r*MZ_10r;
D382r = K219r*XY_10r + K227r*YY_10r - K176r*YZ_10r + K194r*MX_10r + K239r*MZ_10r;
D383r = K220r*XY_10r + K228r*YY_10r - K177r*YZ_10r + K195r*MX_10r + K240r*MZ_10r;
D384r = K221r*XY_10r + K229r*YY_10r - K178r*YZ_10r + K196r*MX_10r + K241r*MZ_10r;
D385r = K222r*XY_10r + K230r*YY_10r - YZ_10r*cos(q_6r) + K242r*MZ_10r;
D386r = XY_10r*cos(q_7r) + YY_10r*sin(q_7r) + K243r*MZ_10r;
D387r = K255r*XY_10r + K256r*YY_10r - K206r*YZ_10r - K212r^2*XZ_10r + K214r^2*XZ_10r - K259r*MX_10r + K257r*MZ_10r + K212r*K214r*XX_10r + K213r*K214r*XY_10r - K212r*K213r*YZ_10r - K212r*K214r*ZZ_10r;
D388r = K244r*MX_10r - K233r*MY_10r;
D389r = K215r*XZ_10r + K223r*YZ_10r - K172r*ZZ_10r + K245r*MX_10r - K234r*MY_10r;
D390r = K216r*XZ_10r + K224r*YZ_10r - K173r*ZZ_10r + K246r*MX_10r - K235r*MY_10r;
D391r = K216r*XZ_10r + K224r*YZ_10r - K173r*ZZ_10r + K247r*MX_10r - K236r*MY_10r;
D392r = K217r*XZ_10r + K225r*YZ_10r - K174r*ZZ_10r + K248r*MX_10r - K237r*MY_10r;
D393r = K218r*XZ_10r + K226r*YZ_10r - K175r*ZZ_10r + K249r*MX_10r - K238r*MY_10r;
D394r = K219r*XZ_10r + K227r*YZ_10r - K176r*ZZ_10r + K250r*MX_10r - K239r*MY_10r;
D395r = K220r*XZ_10r + K228r*YZ_10r - K177r*ZZ_10r + K251r*MX_10r - K240r*MY_10r;
D396r = K221r*XZ_10r + K229r*YZ_10r - K178r*ZZ_10r + K252r*MX_10r - K241r*MY_10r;
D397r = K222r*XZ_10r + K230r*YZ_10r - ZZ_10r*cos(q_6r) + K253r*MX_10r - K242r*MY_10r;
D398r = XZ_10r*cos(q_7r) + YZ_10r*sin(q_7r) + K254r*MX_10r - K243r*MY_10r;
D399r = K255r*XZ_10r + K256r*YZ_10r - K206r*ZZ_10r + K212r^2*XY_10r - K213r^2*XY_10r + K258r*MX_10r - K257r*MY_10r - K212r*K213r*XX_10r - K213r*K214r*XZ_10r + K212r*K213r*YY_10r + K212r*K214r*YZ_10r;
% \dot{\bar{H}}_{10r} &= \left[\begin{matrix} D339r + D329r*ddpsi + D333r*ddq_1r + D331r*ddq_w + D334r*ddq_2r + D335r*ddq_3r + D336r*ddq_4r + D337r*ddq_5r + D338r*ddq_6r + D330r*ddq_imu + D332r*ddq_torso + D328r*ddx + MY_10r*ddq_7r & D351r + D341r*ddpsi + D345r*ddq_1r + D343r*ddq_w + D346r*ddq_2r + D347r*ddq_3r + D348r*ddq_4r + D349r*ddq_5r + D350r*ddq_6r + D342r*ddq_imu + D344r*ddq_torso + D340r*ddx - MX_10r*ddq_7r & D363r + D353r*ddpsi + D357r*ddq_1r + D355r*ddq_w + D358r*ddq_2r + D359r*ddq_3r + D360r*ddq_4r + D361r*ddq_5r + D362r*ddq_6r + D354r*ddq_imu + D356r*ddq_torso + D352r*ddx &  \end{matrix}\right] 
% \nonumber \\ 
% LHS_{dx} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dx} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dx}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% LHS_{dx} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dx} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dx}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% LHS_{dx} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dx} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dx}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & (D6*sin(q_imu) - D9*cos(q_imu))*ddx + (D7*sin(q_imu) - D10*cos(q_imu))*ddpsi + (MY_1*cos(q_imu) + MZ_1*sin(q_imu))*ddq_imu + (D8*sin(q_imu) - D11*cos(q_imu)) 
% \nonumber \\ 
% &+(D26*K11 + D30*K17)*ddx + (D27*K11 + D31*K17)*ddpsi + (D28*K11 + D32*K17)*ddq_imu + (K11*MZ_2 - K17*MY_2)*ddq_w + (D29*K11 + D33*K17) 
% \nonumber \\ 
% &+(D54*K11 + D49*K33 + D59*K38)*ddx + (D55*K11 + D50*K33 + D60*K38)*ddpsi + (D56*K11 + D51*K33 + D61*K38)*ddq_imu + (D57*K11 + D52*K33 + D62*K38)*ddq_w + (K38*MX_3 - K33*MZ_3)*ddq_torso + (D58*K11 + D53*K33 + D63*K38) 
% \nonumber \\ 
% &+(D10l*K33 + D16l*K19l + D4l*K11l)*ddx + (D11l*K33 + D17l*K19l + D5l*K11l)*ddpsi + (D12l*K33 + D18l*K19l + D6l*K11l)*ddq_imu + (D13l*K33 + D19l*K19l + D7l*K11l)*ddq_w + (D14l*K33 + D20l*K19l + D8l*K11l)*ddq_torso + (K19l*MX_4l - K11l*MZ_4l)*ddq_1l + (D15l*K33 + D21l*K19l + D9l*K11l) 
% \nonumber \\ 
% &+(D50l*K42l - D43l*K11l + D57l*K47l)*ddx + (D51l*K42l - D44l*K11l + D58l*K47l)*ddpsi + (D52l*K42l - D45l*K11l + D59l*K47l)*ddq_imu + (D53l*K42l - D46l*K11l + D60l*K47l)*ddq_w + (D54l*K42l - D47l*K11l + D61l*K47l)*ddq_torso + (D55l*K42l - D48l*K11l + D62l*K47l)*ddq_1l + (K42l*MZ_5l - K47l*MY_5l)*ddq_2l + (D56l*K42l - D49l*K11l + D63l*K47l) 
% \nonumber \\ 
% &+(D88l*K71l - D96l*K42l + D104l*K78l)*ddx + (D89l*K71l - D97l*K42l + D105l*K78l)*ddpsi + (D90l*K71l - D98l*K42l + D106l*K78l)*ddq_imu + (D91l*K71l - D99l*K42l + D107l*K78l)*ddq_w + (D92l*K71l - D100l*K42l + D108l*K78l)*ddq_torso + (D93l*K71l - D101l*K42l + D109l*K78l)*ddq_1l + (D94l*K71l - D102l*K42l + D110l*K78l)*ddq_2l + (K78l*MX_6l - K71l*MZ_6l)*ddq_3l + (D95l*K71l - D103l*K42l + D111l*K78l) 
% \nonumber \\ 
% &+(D148l*K107l - D139l*K71l + D157l*K114l)*ddx + (D149l*K107l - D140l*K71l + D158l*K114l)*ddpsi + (D150l*K107l - D141l*K71l + D159l*K114l)*ddq_imu + (D151l*K107l - D142l*K71l + D160l*K114l)*ddq_w + (D152l*K107l - D143l*K71l + D161l*K114l)*ddq_torso + (D153l*K107l - D144l*K71l + D162l*K114l)*ddq_1l + (D154l*K107l - D145l*K71l + D163l*K114l)*ddq_2l + (D155l*K107l - D146l*K71l + D164l*K114l)*ddq_3l + (K107l*MZ_7l - K114l*MY_7l)*ddq_4l + (D156l*K107l - D147l*K71l + D165l*K114l) 
% \nonumber \\ 
% &+(D196l*K144l - D206l*K107l + D216l*K153l)*ddx + (D197l*K144l - D207l*K107l + D217l*K153l)*ddpsi + (D198l*K144l - D208l*K107l + D218l*K153l)*ddq_imu + (D199l*K144l - D209l*K107l + D219l*K153l)*ddq_w + (D200l*K144l - D210l*K107l + D220l*K153l)*ddq_torso + (D201l*K144l - D211l*K107l + D221l*K153l)*ddq_1l + (D202l*K144l - D212l*K107l + D222l*K153l)*ddq_2l + (D203l*K144l - D213l*K107l + D223l*K153l)*ddq_3l + (D204l*K144l - D214l*K107l + D224l*K153l)*ddq_4l + (K153l*MX_8l - K144l*MZ_8l)*ddq_5l + (D205l*K144l - D215l*K107l + D225l*K153l) 
% \nonumber \\ 
% &+(D270l*K188l - D259l*K144l + D281l*K197l)*ddx + (D271l*K188l - D260l*K144l + D282l*K197l)*ddpsi + (D272l*K188l - D261l*K144l + D283l*K197l)*ddq_imu + (D273l*K188l - D262l*K144l + D284l*K197l)*ddq_w + (D274l*K188l - D263l*K144l + D285l*K197l)*ddq_torso + (D275l*K188l - D264l*K144l + D286l*K197l)*ddq_1l + (D276l*K188l - D265l*K144l + D287l*K197l)*ddq_2l + (D277l*K188l - D266l*K144l + D288l*K197l)*ddq_3l + (D278l*K188l - D267l*K144l + D289l*K197l)*ddq_4l + (D279l*K188l - D268l*K144l + D290l*K197l)*ddq_5l + (K188l*MZ_9l - K197l*MY_9l)*ddq_6l + (D280l*K188l - D269l*K144l + D291l*K197l) 
% \nonumber \\ 
% &+(D328l*K233l - D352l*K188l + D340l*K244l)*ddx + (D329l*K233l - D353l*K188l + D341l*K244l)*ddpsi + (D330l*K233l - D354l*K188l + D342l*K244l)*ddq_imu + (D331l*K233l - D355l*K188l + D343l*K244l)*ddq_w + (D332l*K233l - D356l*K188l + D344l*K244l)*ddq_torso + (D333l*K233l - D357l*K188l + D345l*K244l)*ddq_1l + (D334l*K233l - D358l*K188l + D346l*K244l)*ddq_2l + (D335l*K233l - D359l*K188l + D347l*K244l)*ddq_3l + (D336l*K233l - D360l*K188l + D348l*K244l)*ddq_4l + (D337l*K233l - D361l*K188l + D349l*K244l)*ddq_5l + (D338l*K233l - D362l*K188l + D350l*K244l)*ddq_6l + (K233l*MY_10l - K244l*MX_10l)*ddq_7l + (D339l*K233l - D363l*K188l + D351l*K244l) 
% \nonumber \\ 
% &+(D16r*K19r - D10r*K33 + D4r*K11r)*ddx + (D17r*K19r - D11r*K33 + D5r*K11r)*ddpsi + (D18r*K19r - D12r*K33 + D6r*K11r)*ddq_imu + (D19r*K19r - D13r*K33 + D7r*K11r)*ddq_w + (D20r*K19r - D14r*K33 + D8r*K11r)*ddq_torso + (K19r*MX_4r - K11r*MZ_4r)*ddq_1r + (D21r*K19r - D15r*K33 + D9r*K11r) 
% \nonumber \\ 
% &+(D50r*K42r - D43r*K11r + D57r*K47r)*ddx + (D51r*K42r - D44r*K11r + D58r*K47r)*ddpsi + (D52r*K42r - D45r*K11r + D59r*K47r)*ddq_imu + (D53r*K42r - D46r*K11r + D60r*K47r)*ddq_w + (D54r*K42r - D47r*K11r + D61r*K47r)*ddq_torso + (D55r*K42r - D48r*K11r + D62r*K47r)*ddq_1r + (K42r*MZ_5r - K47r*MY_5r)*ddq_2r + (D56r*K42r - D49r*K11r + D63r*K47r) 
% \nonumber \\ 
% &+(D88r*K71r - D96r*K42r + D104r*K78r)*ddx + (D89r*K71r - D97r*K42r + D105r*K78r)*ddpsi + (D90r*K71r - D98r*K42r + D106r*K78r)*ddq_imu + (D91r*K71r - D99r*K42r + D107r*K78r)*ddq_w + (D92r*K71r - D100r*K42r + D108r*K78r)*ddq_torso + (D93r*K71r - D101r*K42r + D109r*K78r)*ddq_1r + (D94r*K71r - D102r*K42r + D110r*K78r)*ddq_2r + (K78r*MX_6r - K71r*MZ_6r)*ddq_3r + (D95r*K71r - D103r*K42r + D111r*K78r) 
% \nonumber \\ 
% &+(D148r*K107r - D139r*K71r + D157r*K114r)*ddx + (D149r*K107r - D140r*K71r + D158r*K114r)*ddpsi + (D150r*K107r - D141r*K71r + D159r*K114r)*ddq_imu + (D151r*K107r - D142r*K71r + D160r*K114r)*ddq_w + (D152r*K107r - D143r*K71r + D161r*K114r)*ddq_torso + (D153r*K107r - D144r*K71r + D162r*K114r)*ddq_1r + (D154r*K107r - D145r*K71r + D163r*K114r)*ddq_2r + (D155r*K107r - D146r*K71r + D164r*K114r)*ddq_3r + (K107r*MZ_7r - K114r*MY_7r)*ddq_4r + (D156r*K107r - D147r*K71r + D165r*K114r) 
% \nonumber \\ 
% &+(D196r*K144r - D206r*K107r + D216r*K153r)*ddx + (D197r*K144r - D207r*K107r + D217r*K153r)*ddpsi + (D198r*K144r - D208r*K107r + D218r*K153r)*ddq_imu + (D199r*K144r - D209r*K107r + D219r*K153r)*ddq_w + (D200r*K144r - D210r*K107r + D220r*K153r)*ddq_torso + (D201r*K144r - D211r*K107r + D221r*K153r)*ddq_1r + (D202r*K144r - D212r*K107r + D222r*K153r)*ddq_2r + (D203r*K144r - D213r*K107r + D223r*K153r)*ddq_3r + (D204r*K144r - D214r*K107r + D224r*K153r)*ddq_4r + (K153r*MX_8r - K144r*MZ_8r)*ddq_5r + (D205r*K144r - D215r*K107r + D225r*K153r) 
% \nonumber \\ 
% &+(D270r*K188r - D259r*K144r + D281r*K197r)*ddx + (D271r*K188r - D260r*K144r + D282r*K197r)*ddpsi + (D272r*K188r - D261r*K144r + D283r*K197r)*ddq_imu + (D273r*K188r - D262r*K144r + D284r*K197r)*ddq_w + (D274r*K188r - D263r*K144r + D285r*K197r)*ddq_torso + (D275r*K188r - D264r*K144r + D286r*K197r)*ddq_1r + (D276r*K188r - D265r*K144r + D287r*K197r)*ddq_2r + (D277r*K188r - D266r*K144r + D288r*K197r)*ddq_3r + (D278r*K188r - D267r*K144r + D289r*K197r)*ddq_4r + (D279r*K188r - D268r*K144r + D290r*K197r)*ddq_5r + (K188r*MZ_9r - K197r*MY_9r)*ddq_6r + (D280r*K188r - D269r*K144r + D291r*K197r) 
% \nonumber \\ 
% &+(D328r*K233r - D352r*K188r + D340r*K244r)*ddx + (D329r*K233r - D353r*K188r + D341r*K244r)*ddpsi + (D330r*K233r - D354r*K188r + D342r*K244r)*ddq_imu + (D331r*K233r - D355r*K188r + D343r*K244r)*ddq_w + (D332r*K233r - D356r*K188r + D344r*K244r)*ddq_torso + (D333r*K233r - D357r*K188r + D345r*K244r)*ddq_1r + (D334r*K233r - D358r*K188r + D346r*K244r)*ddq_2r + (D335r*K233r - D359r*K188r + D347r*K244r)*ddq_3r + (D336r*K233r - D360r*K188r + D348r*K244r)*ddq_4r + (D337r*K233r - D361r*K188r + D349r*K244r)*ddq_5r + (D338r*K233r - D362r*K188r + D350r*K244r)*ddq_6r + (K233r*MY_10r - K244r*MX_10r)*ddq_7r + (D339r*K233r - D363r*K188r + D351r*K244r) 
% \nonumber \\ 
X1 = 2*mw + (2*YYw)/R^2 - D9*cos(q_imu) + D6*sin(q_imu) + D26*K11 + D30*K17 + D54*K11 + D49*K33 + D59*K38 + D10l*K33 - D10r*K33 + D16l*K19l + D16r*K19r - D43l*K11l - D43r*K11r + D50l*K42l + D50r*K42r + D57l*K47l + D57r*K47r - D96l*K42l - D96r*K42r + D88l*K71l + D88r*K71r + D104l*K78l + D104r*K78r - D139l*K71l - D139r*K71r + D148l*K107l + D148r*K107r + D157l*K114l + D157r*K114r - D206l*K107l - D206r*K107r + D196l*K144l + D196r*K144r + D216l*K153l + D216r*K153r - D259l*K144l - D259r*K144r + D270l*K188l + D270r*K188r + D281l*K197l + D281r*K197r - D352l*K188l - D352r*K188r + D328l*K233l + D328r*K233r + D340l*K244l + D340r*K244r + D4l*K11l + D4r*K11r;
X2 = D7*sin(q_imu) - D10*cos(q_imu) + D27*K11 + D31*K17 + D55*K11 + D50*K33 + D60*K38 + D11l*K33 - D11r*K33 + D17l*K19l + D17r*K19r - D44l*K11l - D44r*K11r + D51l*K42l + D51r*K42r + D58l*K47l + D58r*K47r - D97l*K42l - D97r*K42r + D89l*K71l + D89r*K71r + D105l*K78l + D105r*K78r - D140l*K71l - D140r*K71r + D149l*K107l + D149r*K107r + D158l*K114l + D158r*K114r - D207l*K107l - D207r*K107r + D197l*K144l + D197r*K144r + D217l*K153l + D217r*K153r - D260l*K144l - D260r*K144r + D271l*K188l + D271r*K188r + D282l*K197l + D282r*K197r - D353l*K188l - D353r*K188r + D329l*K233l + D329r*K233r + D341l*K244l + D341r*K244r + D5l*K11l + D5r*K11r;
X3 = MY_1*cos(q_imu) + MZ_1*sin(q_imu) + D28*K11 + D32*K17 + D56*K11 + D51*K33 + D61*K38 + D12l*K33 - D12r*K33 + D18l*K19l + D18r*K19r - D45l*K11l - D45r*K11r + D52l*K42l + D52r*K42r + D59l*K47l + D59r*K47r - D98l*K42l - D98r*K42r + D90l*K71l + D90r*K71r + D106l*K78l + D106r*K78r - D141l*K71l - D141r*K71r + D150l*K107l + D150r*K107r + D159l*K114l + D159r*K114r - D208l*K107l - D208r*K107r + D198l*K144l + D198r*K144r + D218l*K153l + D218r*K153r - D261l*K144l - D261r*K144r + D272l*K188l + D272r*K188r + D283l*K197l + D283r*K197r - D354l*K188l - D354r*K188r + D330l*K233l + D330r*K233r + D342l*K244l + D342r*K244r + D6l*K11l + D6r*K11r;
X4 = D57*K11 + D52*K33 + D62*K38 + D13l*K33 - D13r*K33 + D19l*K19l + D19r*K19r - D46l*K11l - D46r*K11r + D53l*K42l + D53r*K42r + D60l*K47l + D60r*K47r - D99l*K42l - D99r*K42r + D91l*K71l + D91r*K71r + D107l*K78l + D107r*K78r - D142l*K71l - D142r*K71r + D151l*K107l + D151r*K107r + D160l*K114l + D160r*K114r - D209l*K107l - D209r*K107r + D199l*K144l + D199r*K144r + D219l*K153l + D219r*K153r - D262l*K144l - D262r*K144r + D273l*K188l + D273r*K188r + D284l*K197l + D284r*K197r - D355l*K188l - D355r*K188r + D331l*K233l + D331r*K233r + D343l*K244l + D343r*K244r + D7l*K11l + D7r*K11r - K17*MY_2 + K11*MZ_2;
X5 = D14l*K33 - D14r*K33 + D20l*K19l + D20r*K19r - D47l*K11l - D47r*K11r + D54l*K42l + D54r*K42r + D61l*K47l + D61r*K47r - D100l*K42l - D100r*K42r + D92l*K71l + D92r*K71r + D108l*K78l + D108r*K78r - D143l*K71l - D143r*K71r + D152l*K107l + D152r*K107r + D161l*K114l + D161r*K114r - D210l*K107l - D210r*K107r + D200l*K144l + D200r*K144r + D220l*K153l + D220r*K153r - D263l*K144l - D263r*K144r + D274l*K188l + D274r*K188r + D285l*K197l + D285r*K197r - D356l*K188l - D356r*K188r + D332l*K233l + D332r*K233r + D344l*K244l + D344r*K244r + D8l*K11l + D8r*K11r + K38*MX_3 - K33*MZ_3;
X6 = D55l*K42l - D48l*K11l + D62l*K47l - D101l*K42l + D93l*K71l + D109l*K78l - D144l*K71l + D153l*K107l + D162l*K114l - D211l*K107l + D201l*K144l + D221l*K153l - D264l*K144l + D275l*K188l + D286l*K197l - D357l*K188l + D333l*K233l + D345l*K244l + K19l*MX_4l - K11l*MZ_4l;
X7 = D94l*K71l - D102l*K42l + D110l*K78l - D145l*K71l + D154l*K107l + D163l*K114l - D212l*K107l + D202l*K144l + D222l*K153l - D265l*K144l + D276l*K188l + D287l*K197l - D358l*K188l + D334l*K233l + D346l*K244l - K47l*MY_5l + K42l*MZ_5l;
X8 = D155l*K107l - D146l*K71l + D164l*K114l - D213l*K107l + D203l*K144l + D223l*K153l - D266l*K144l + D277l*K188l + D288l*K197l - D359l*K188l + D335l*K233l + D347l*K244l + K78l*MX_6l - K71l*MZ_6l;
X9 = D204l*K144l - D214l*K107l + D224l*K153l - D267l*K144l + D278l*K188l + D289l*K197l - D360l*K188l + D336l*K233l + D348l*K244l - K114l*MY_7l + K107l*MZ_7l;
X10 = D279l*K188l - D268l*K144l + D290l*K197l - D361l*K188l + D337l*K233l + D349l*K244l + K153l*MX_8l - K144l*MZ_8l;
X11 = D338l*K233l - D362l*K188l + D350l*K244l - K197l*MY_9l + K188l*MZ_9l;
X12 = K233l*MY_10l - K244l*MX_10l;
X13 = D55r*K42r - D48r*K11r + D62r*K47r - D101r*K42r + D93r*K71r + D109r*K78r - D144r*K71r + D153r*K107r + D162r*K114r - D211r*K107r + D201r*K144r + D221r*K153r - D264r*K144r + D275r*K188r + D286r*K197r - D357r*K188r + D333r*K233r + D345r*K244r + K19r*MX_4r - K11r*MZ_4r;
X14 = D94r*K71r - D102r*K42r + D110r*K78r - D145r*K71r + D154r*K107r + D163r*K114r - D212r*K107r + D202r*K144r + D222r*K153r - D265r*K144r + D276r*K188r + D287r*K197r - D358r*K188r + D334r*K233r + D346r*K244r - K47r*MY_5r + K42r*MZ_5r;
X15 = D155r*K107r - D146r*K71r + D164r*K114r - D213r*K107r + D203r*K144r + D223r*K153r - D266r*K144r + D277r*K188r + D288r*K197r - D359r*K188r + D335r*K233r + D347r*K244r + K78r*MX_6r - K71r*MZ_6r;
X16 = D204r*K144r - D214r*K107r + D224r*K153r - D267r*K144r + D278r*K188r + D289r*K197r - D360r*K188r + D336r*K233r + D348r*K244r - K114r*MY_7r + K107r*MZ_7r;
X17 = D279r*K188r - D268r*K144r + D290r*K197r - D361r*K188r + D337r*K233r + D349r*K244r + K153r*MX_8r - K144r*MZ_8r;
X18 = D338r*K233r - D362r*K188r + D350r*K244r - K197r*MY_9r + K188r*MZ_9r;
X19 = K233r*MY_10r - K244r*MX_10r;
X20 = D8*sin(q_imu) - D11*cos(q_imu) + D29*K11 + D33*K17 + D58*K11 + D53*K33 + D63*K38 + D15l*K33 - D15r*K33 + D21l*K19l + D21r*K19r - D49l*K11l - D49r*K11r + D56l*K42l + D56r*K42r + D63l*K47l + D63r*K47r - D103l*K42l - D103r*K42r + D95l*K71l + D95r*K71r + D111l*K78l + D111r*K78r - D147l*K71l - D147r*K71r + D156l*K107l + D156r*K107r + D165l*K114l + D165r*K114r - D215l*K107l - D215r*K107r + D205l*K144l + D205r*K144r + D225l*K153l + D225r*K153r - D269l*K144l - D269r*K144r + D280l*K188l + D280r*K188r + D291l*K197l + D291r*K197r - D363l*K188l - D363r*K188r + D339l*K233l + D339r*K233r + D351l*K244l + D351r*K244r + D9l*K11l + D9r*K11r;
% LHS_{dx} &= (D328r*K233r - D352r*K188r + D340r*K244r)*ddx + (D329r*K233r - D353r*K188r + D341r*K244r)*ddpsi + (D330r*K233r - D354r*K188r + D342r*K244r)*ddq_imu + (D331r*K233r - D355r*K188r + D343r*K244r)*ddq_w + (D332r*K233r - D356r*K188r + D344r*K244r)*ddq_torso + (D333r*K233r - D357r*K188r + D345r*K244r)*ddq_1r + (D334r*K233r - D358r*K188r + D346r*K244r)*ddq_2r + (D335r*K233r - D359r*K188r + D347r*K244r)*ddq_3r + (D336r*K233r - D360r*K188r + D348r*K244r)*ddq_4r + (D337r*K233r - D361r*K188r + D349r*K244r)*ddq_5r + (D338r*K233r - D362r*K188r + D350r*K244r)*ddq_6r + (K233r*MY_10r - K244r*MX_10r)*ddq_7r + (D339r*K233r - D363r*K188r + D351r*K244r) 
% \nonumber \\ 
% LHS_{dpsi} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dpsi} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dpsi}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & (D15*cos(q_imu) + D18*sin(q_imu))*ddx + (D16*cos(q_imu) + D19*sin(q_imu))*ddpsi + (- XY_1*cos(q_imu) - XZ_1*sin(q_imu))*ddq_imu + (D17*cos(q_imu) + D20*sin(q_imu)) 
% \nonumber \\ 
% &+(D38*K10 + D42*K11)*ddx + (D24*K15 + D39*K10 + D43*K11)*ddpsi + (D40*K10 + D44*K11)*ddq_imu + (- K10*XY_2 - K11*XZ_2)*ddq_w + (D25*K15 + D41*K10 + D45*K11) 
% \nonumber \\ 
% &+(D69*K10 + D49*K34 + D64*K28 + D59*K39 + D74*K29)*ddx + (D70*K10 + D50*K34 + D65*K28 + D60*K39 + D75*K29)*ddpsi + (D71*K10 + D51*K34 + D66*K28 + D61*K39 + D76*K29)*ddq_imu + (D72*K10 + D52*K34 + D67*K28 + D62*K39 + D77*K29)*ddq_w + (K39*MX_3 - K10*YY_3 - K29*YZ_3 - K28*XY_3 - K34*MZ_3)*ddq_torso + (D73*K10 + D53*K34 + D68*K28 + D63*K39 + D78*K29) 
% \nonumber \\ 
% &+(D28l*K28 + D10l*K16l + D16l*K20l + D4l*K12l + D22l*K4l + D34l*K6l)*ddx + (D29l*K28 + D11l*K16l + D17l*K20l + D5l*K12l + D23l*K4l + D35l*K6l)*ddpsi + (D30l*K28 + D12l*K16l + D18l*K20l + D6l*K12l + D24l*K4l + D36l*K6l)*ddq_imu + (D31l*K28 + D13l*K16l + D19l*K20l + D7l*K12l + D25l*K4l + D37l*K6l)*ddq_w + (D32l*K28 + D14l*K16l + D20l*K20l + D8l*K12l + D26l*K4l + D38l*K6l)*ddq_torso + (K20l*MX_4l - K28*YY_4l - K6l*YZ_4l - K4l*XY_4l - K12l*MZ_4l)*ddq_1l + (D33l*K28 + D15l*K16l + D21l*K20l + D9l*K12l + D27l*K4l + D39l*K6l) 
% \nonumber \\ 
% &+(D50l*K43l - D43l*K12l + D57l*K48l + D71l*K34l + D78l*K37l - D64l*K4l)*ddx + (D51l*K43l - D44l*K12l + D58l*K48l + D72l*K34l + D79l*K37l - D65l*K4l)*ddpsi + (D52l*K43l - D45l*K12l + D59l*K48l + D73l*K34l + D80l*K37l - D66l*K4l)*ddq_imu + (D53l*K43l - D46l*K12l + D60l*K48l + D74l*K34l + D81l*K37l - D67l*K4l)*ddq_w + (D54l*K43l - D47l*K12l + D61l*K48l + D75l*K34l + D82l*K37l - D68l*K4l)*ddq_torso + (D55l*K43l - D48l*K12l + D62l*K48l + D76l*K34l + D83l*K37l - D69l*K4l)*ddq_1l + (K4l*XX_5l - K34l*XY_5l - K37l*XZ_5l - K48l*MY_5l + K43l*MZ_5l)*ddq_2l + (D56l*K43l - D49l*K12l + D63l*K48l + D77l*K34l + D84l*K37l - D70l*K4l) 
% \nonumber \\ 
% &+(D88l*K72l - D120l*K34l - D96l*K43l + D112l*K61l + D104l*K79l + D128l*K65l)*ddx + (D89l*K72l - D121l*K34l - D97l*K43l + D113l*K61l + D105l*K79l + D129l*K65l)*ddpsi + (D90l*K72l - D122l*K34l - D98l*K43l + D114l*K61l + D106l*K79l + D130l*K65l)*ddq_imu + (D91l*K72l - D123l*K34l - D99l*K43l + D115l*K61l + D107l*K79l + D131l*K65l)*ddq_w + (D92l*K72l - D124l*K34l - D100l*K43l + D116l*K61l + D108l*K79l + D132l*K65l)*ddq_torso + (D93l*K72l - D125l*K34l - D101l*K43l + D117l*K61l + D109l*K79l + D133l*K65l)*ddq_1l + (D94l*K72l - D126l*K34l - D102l*K43l + D118l*K61l + D110l*K79l + D134l*K65l)*ddq_2l + (K34l*YY_6l - K61l*XY_6l - K65l*YZ_6l + K79l*MX_6l - K72l*MZ_6l)*ddq_3l + (D95l*K72l - D127l*K34l - D103l*K43l + D119l*K61l + D111l*K79l + D135l*K65l) 
% \nonumber \\ 
% &+(D148l*K108l - D166l*K61l - D139l*K72l + D175l*K95l + D157l*K115l + D184l*K100l)*ddx + (D149l*K108l - D167l*K61l - D140l*K72l + D176l*K95l + D158l*K115l + D185l*K100l)*ddpsi + (D150l*K108l - D168l*K61l - D141l*K72l + D177l*K95l + D159l*K115l + D186l*K100l)*ddq_imu + (D151l*K108l - D169l*K61l - D142l*K72l + D178l*K95l + D160l*K115l + D187l*K100l)*ddq_w + (D152l*K108l - D170l*K61l - D143l*K72l + D179l*K95l + D161l*K115l + D188l*K100l)*ddq_torso + (D153l*K108l - D171l*K61l - D144l*K72l + D180l*K95l + D162l*K115l + D189l*K100l)*ddq_1l + (D154l*K108l - D172l*K61l - D145l*K72l + D181l*K95l + D163l*K115l + D190l*K100l)*ddq_2l + (D155l*K108l - D173l*K61l - D146l*K72l + D182l*K95l + D164l*K115l + D191l*K100l)*ddq_3l + (K61l*XX_7l - K95l*XY_7l - K100l*XZ_7l - K115l*MY_7l + K108l*MZ_7l)*ddq_4l + (D156l*K108l - D174l*K61l - D147l*K72l + D183l*K95l + D165l*K115l + D192l*K100l) 
% \nonumber \\ 
% &+(D196l*K145l - D236l*K95l - D206l*K108l + D226l*K130l + D216l*K154l + D246l*K136l)*ddx + (D197l*K145l - D237l*K95l - D207l*K108l + D227l*K130l + D217l*K154l + D247l*K136l)*ddpsi + (D198l*K145l - D238l*K95l - D208l*K108l + D228l*K130l + D218l*K154l + D248l*K136l)*ddq_imu + (D199l*K145l - D239l*K95l - D209l*K108l + D229l*K130l + D219l*K154l + D249l*K136l)*ddq_w + (D200l*K145l - D240l*K95l - D210l*K108l + D230l*K130l + D220l*K154l + D250l*K136l)*ddq_torso + (D201l*K145l - D241l*K95l - D211l*K108l + D231l*K130l + D221l*K154l + D251l*K136l)*ddq_1l + (D202l*K145l - D242l*K95l - D212l*K108l + D232l*K130l + D222l*K154l + D252l*K136l)*ddq_2l + (D203l*K145l - D243l*K95l - D213l*K108l + D233l*K130l + D223l*K154l + D253l*K136l)*ddq_3l + (D204l*K145l - D244l*K95l - D214l*K108l + D234l*K130l + D224l*K154l + D254l*K136l)*ddq_4l + (K95l*YY_8l - K130l*XY_8l - K136l*YZ_8l + K154l*MX_8l - K145l*MZ_8l)*ddq_5l + (D205l*K145l - D245l*K95l - D215l*K108l + D235l*K130l + D225l*K154l + D255l*K136l) 
% \nonumber \\ 
% &+(D270l*K189l - D292l*K130l - D259l*K145l + D303l*K172l + D281l*K198l + D314l*K179l)*ddx + (D271l*K189l - D293l*K130l - D260l*K145l + D304l*K172l + D282l*K198l + D315l*K179l)*ddpsi + (D272l*K189l - D294l*K130l - D261l*K145l + D305l*K172l + D283l*K198l + D316l*K179l)*ddq_imu + (D273l*K189l - D295l*K130l - D262l*K145l + D306l*K172l + D284l*K198l + D317l*K179l)*ddq_w + (D274l*K189l - D296l*K130l - D263l*K145l + D307l*K172l + D285l*K198l + D318l*K179l)*ddq_torso + (D275l*K189l - D297l*K130l - D264l*K145l + D308l*K172l + D286l*K198l + D319l*K179l)*ddq_1l + (D276l*K189l - D298l*K130l - D265l*K145l + D309l*K172l + D287l*K198l + D320l*K179l)*ddq_2l + (D277l*K189l - D299l*K130l - D266l*K145l + D310l*K172l + D288l*K198l + D321l*K179l)*ddq_3l + (D278l*K189l - D300l*K130l - D267l*K145l + D311l*K172l + D289l*K198l + D322l*K179l)*ddq_4l + (D279l*K189l - D301l*K130l - D268l*K145l + D312l*K172l + D290l*K198l + D323l*K179l)*ddq_5l + (K130l*XX_9l - K172l*XY_9l - K179l*XZ_9l - K198l*MY_9l + K189l*MZ_9l)*ddq_6l + (D280l*K189l - D302l*K130l - D269l*K145l + D313l*K172l + D291l*K198l + D324l*K179l) 
% \nonumber \\ 
% &+(D328l*K234l - D388l*K172l - D352l*K189l + D364l*K215l + D340l*K245l + D376l*K223l)*ddx + (D329l*K234l - D389l*K172l - D353l*K189l + D365l*K215l + D341l*K245l + D377l*K223l)*ddpsi + (D330l*K234l - D390l*K172l - D354l*K189l + D366l*K215l + D342l*K245l + D378l*K223l)*ddq_imu + (D331l*K234l - D391l*K172l - D355l*K189l + D367l*K215l + D343l*K245l + D379l*K223l)*ddq_w + (D332l*K234l - D392l*K172l - D356l*K189l + D368l*K215l + D344l*K245l + D380l*K223l)*ddq_torso + (D333l*K234l - D393l*K172l - D357l*K189l + D369l*K215l + D345l*K245l + D381l*K223l)*ddq_1l + (D334l*K234l - D394l*K172l - D358l*K189l + D370l*K215l + D346l*K245l + D382l*K223l)*ddq_2l + (D335l*K234l - D395l*K172l - D359l*K189l + D371l*K215l + D347l*K245l + D383l*K223l)*ddq_3l + (D336l*K234l - D396l*K172l - D360l*K189l + D372l*K215l + D348l*K245l + D384l*K223l)*ddq_4l + (D337l*K234l - D397l*K172l - D361l*K189l + D373l*K215l + D349l*K245l + D385l*K223l)*ddq_5l + (D338l*K234l - D398l*K172l - D362l*K189l + D374l*K215l + D350l*K245l + D386l*K223l)*ddq_6l + (K172l*ZZ_10l - K223l*YZ_10l - K215l*XZ_10l - K245l*MX_10l + K234l*MY_10l)*ddq_7l + (D339l*K234l - D399l*K172l - D363l*K189l + D375l*K215l + D351l*K245l + D387l*K223l) 
% \nonumber \\ 
% &+(D10r*K16r - D28r*K28 + D16r*K20r + D4r*K12r + D22r*K4r + D34r*K6r)*ddx + (D11r*K16r - D29r*K28 + D17r*K20r + D5r*K12r + D23r*K4r + D35r*K6r)*ddpsi + (D12r*K16r - D30r*K28 + D18r*K20r + D6r*K12r + D24r*K4r + D36r*K6r)*ddq_imu + (D13r*K16r - D31r*K28 + D19r*K20r + D7r*K12r + D25r*K4r + D37r*K6r)*ddq_w + (D14r*K16r - D32r*K28 + D20r*K20r + D8r*K12r + D26r*K4r + D38r*K6r)*ddq_torso + (K28*YY_4r - K4r*XY_4r - K6r*YZ_4r + K20r*MX_4r - K12r*MZ_4r)*ddq_1r + (D15r*K16r - D33r*K28 + D21r*K20r + D9r*K12r + D27r*K4r + D39r*K6r) 
% \nonumber \\ 
% &+(D50r*K43r - D43r*K12r + D57r*K48r + D71r*K34r + D78r*K37r - D64r*K4r)*ddx + (D51r*K43r - D44r*K12r + D58r*K48r + D72r*K34r + D79r*K37r - D65r*K4r)*ddpsi + (D52r*K43r - D45r*K12r + D59r*K48r + D73r*K34r + D80r*K37r - D66r*K4r)*ddq_imu + (D53r*K43r - D46r*K12r + D60r*K48r + D74r*K34r + D81r*K37r - D67r*K4r)*ddq_w + (D54r*K43r - D47r*K12r + D61r*K48r + D75r*K34r + D82r*K37r - D68r*K4r)*ddq_torso + (D55r*K43r - D48r*K12r + D62r*K48r + D76r*K34r + D83r*K37r - D69r*K4r)*ddq_1r + (K4r*XX_5r - K34r*XY_5r - K37r*XZ_5r - K48r*MY_5r + K43r*MZ_5r)*ddq_2r + (D56r*K43r - D49r*K12r + D63r*K48r + D77r*K34r + D84r*K37r - D70r*K4r) 
% \nonumber \\ 
% &+(D88r*K72r - D120r*K34r - D96r*K43r + D112r*K61r + D104r*K79r + D128r*K65r)*ddx + (D89r*K72r - D121r*K34r - D97r*K43r + D113r*K61r + D105r*K79r + D129r*K65r)*ddpsi + (D90r*K72r - D122r*K34r - D98r*K43r + D114r*K61r + D106r*K79r + D130r*K65r)*ddq_imu + (D91r*K72r - D123r*K34r - D99r*K43r + D115r*K61r + D107r*K79r + D131r*K65r)*ddq_w + (D92r*K72r - D124r*K34r - D100r*K43r + D116r*K61r + D108r*K79r + D132r*K65r)*ddq_torso + (D93r*K72r - D125r*K34r - D101r*K43r + D117r*K61r + D109r*K79r + D133r*K65r)*ddq_1r + (D94r*K72r - D126r*K34r - D102r*K43r + D118r*K61r + D110r*K79r + D134r*K65r)*ddq_2r + (K34r*YY_6r - K61r*XY_6r - K65r*YZ_6r + K79r*MX_6r - K72r*MZ_6r)*ddq_3r + (D95r*K72r - D127r*K34r - D103r*K43r + D119r*K61r + D111r*K79r + D135r*K65r) 
% \nonumber \\ 
% &+(D148r*K108r - D166r*K61r - D139r*K72r + D175r*K95r + D157r*K115r + D184r*K100r)*ddx + (D149r*K108r - D167r*K61r - D140r*K72r + D176r*K95r + D158r*K115r + D185r*K100r)*ddpsi + (D150r*K108r - D168r*K61r - D141r*K72r + D177r*K95r + D159r*K115r + D186r*K100r)*ddq_imu + (D151r*K108r - D169r*K61r - D142r*K72r + D178r*K95r + D160r*K115r + D187r*K100r)*ddq_w + (D152r*K108r - D170r*K61r - D143r*K72r + D179r*K95r + D161r*K115r + D188r*K100r)*ddq_torso + (D153r*K108r - D171r*K61r - D144r*K72r + D180r*K95r + D162r*K115r + D189r*K100r)*ddq_1r + (D154r*K108r - D172r*K61r - D145r*K72r + D181r*K95r + D163r*K115r + D190r*K100r)*ddq_2r + (D155r*K108r - D173r*K61r - D146r*K72r + D182r*K95r + D164r*K115r + D191r*K100r)*ddq_3r + (K61r*XX_7r - K95r*XY_7r - K100r*XZ_7r - K115r*MY_7r + K108r*MZ_7r)*ddq_4r + (D156r*K108r - D174r*K61r - D147r*K72r + D183r*K95r + D165r*K115r + D192r*K100r) 
% \nonumber \\ 
% &+(D196r*K145r - D236r*K95r - D206r*K108r + D226r*K130r + D216r*K154r + D246r*K136r)*ddx + (D197r*K145r - D237r*K95r - D207r*K108r + D227r*K130r + D217r*K154r + D247r*K136r)*ddpsi + (D198r*K145r - D238r*K95r - D208r*K108r + D228r*K130r + D218r*K154r + D248r*K136r)*ddq_imu + (D199r*K145r - D239r*K95r - D209r*K108r + D229r*K130r + D219r*K154r + D249r*K136r)*ddq_w + (D200r*K145r - D240r*K95r - D210r*K108r + D230r*K130r + D220r*K154r + D250r*K136r)*ddq_torso + (D201r*K145r - D241r*K95r - D211r*K108r + D231r*K130r + D221r*K154r + D251r*K136r)*ddq_1r + (D202r*K145r - D242r*K95r - D212r*K108r + D232r*K130r + D222r*K154r + D252r*K136r)*ddq_2r + (D203r*K145r - D243r*K95r - D213r*K108r + D233r*K130r + D223r*K154r + D253r*K136r)*ddq_3r + (D204r*K145r - D244r*K95r - D214r*K108r + D234r*K130r + D224r*K154r + D254r*K136r)*ddq_4r + (K95r*YY_8r - K130r*XY_8r - K136r*YZ_8r + K154r*MX_8r - K145r*MZ_8r)*ddq_5r + (D205r*K145r - D245r*K95r - D215r*K108r + D235r*K130r + D225r*K154r + D255r*K136r) 
% \nonumber \\ 
% &+(D270r*K189r - D292r*K130r - D259r*K145r + D303r*K172r + D281r*K198r + D314r*K179r)*ddx + (D271r*K189r - D293r*K130r - D260r*K145r + D304r*K172r + D282r*K198r + D315r*K179r)*ddpsi + (D272r*K189r - D294r*K130r - D261r*K145r + D305r*K172r + D283r*K198r + D316r*K179r)*ddq_imu + (D273r*K189r - D295r*K130r - D262r*K145r + D306r*K172r + D284r*K198r + D317r*K179r)*ddq_w + (D274r*K189r - D296r*K130r - D263r*K145r + D307r*K172r + D285r*K198r + D318r*K179r)*ddq_torso + (D275r*K189r - D297r*K130r - D264r*K145r + D308r*K172r + D286r*K198r + D319r*K179r)*ddq_1r + (D276r*K189r - D298r*K130r - D265r*K145r + D309r*K172r + D287r*K198r + D320r*K179r)*ddq_2r + (D277r*K189r - D299r*K130r - D266r*K145r + D310r*K172r + D288r*K198r + D321r*K179r)*ddq_3r + (D278r*K189r - D300r*K130r - D267r*K145r + D311r*K172r + D289r*K198r + D322r*K179r)*ddq_4r + (D279r*K189r - D301r*K130r - D268r*K145r + D312r*K172r + D290r*K198r + D323r*K179r)*ddq_5r + (K130r*XX_9r - K172r*XY_9r - K179r*XZ_9r - K198r*MY_9r + K189r*MZ_9r)*ddq_6r + (D280r*K189r - D302r*K130r - D269r*K145r + D313r*K172r + D291r*K198r + D324r*K179r) 
% \nonumber \\ 
% &+(D328r*K234r - D388r*K172r - D352r*K189r + D364r*K215r + D340r*K245r + D376r*K223r)*ddx + (D329r*K234r - D389r*K172r - D353r*K189r + D365r*K215r + D341r*K245r + D377r*K223r)*ddpsi + (D330r*K234r - D390r*K172r - D354r*K189r + D366r*K215r + D342r*K245r + D378r*K223r)*ddq_imu + (D331r*K234r - D391r*K172r - D355r*K189r + D367r*K215r + D343r*K245r + D379r*K223r)*ddq_w + (D332r*K234r - D392r*K172r - D356r*K189r + D368r*K215r + D344r*K245r + D380r*K223r)*ddq_torso + (D333r*K234r - D393r*K172r - D357r*K189r + D369r*K215r + D345r*K245r + D381r*K223r)*ddq_1r + (D334r*K234r - D394r*K172r - D358r*K189r + D370r*K215r + D346r*K245r + D382r*K223r)*ddq_2r + (D335r*K234r - D395r*K172r - D359r*K189r + D371r*K215r + D347r*K245r + D383r*K223r)*ddq_3r + (D336r*K234r - D396r*K172r - D360r*K189r + D372r*K215r + D348r*K245r + D384r*K223r)*ddq_4r + (D337r*K234r - D397r*K172r - D361r*K189r + D373r*K215r + D349r*K245r + D385r*K223r)*ddq_5r + (D338r*K234r - D398r*K172r - D362r*K189r + D374r*K215r + D350r*K245r + D386r*K223r)*ddq_6r + (K172r*ZZ_10r - K223r*YZ_10r - K215r*XZ_10r - K245r*MX_10r + K234r*MY_10r)*ddq_7r + (D339r*K234r - D399r*K172r - D363r*K189r + D375r*K215r + D351r*K245r + D387r*K223r) 
% \nonumber \\ 
X21 = D15*cos(q_imu) + D18*sin(q_imu) + D38*K10 + D42*K11 + D69*K10 + D49*K34 + D64*K28 + D59*K39 + D74*K29 + D28l*K28 - D28r*K28 + D10l*K16l + D16l*K20l + D10r*K16r + D16r*K20r - D43l*K12l - D43r*K12r + D50l*K43l + D50r*K43r + D57l*K48l + D71l*K34l + D78l*K37l + D57r*K48r + D71r*K34r + D78r*K37r - D96l*K43l - D96r*K43r - D120l*K34l + D88l*K72l - D120r*K34r + D88r*K72r + D112l*K61l + D104l*K79l + D112r*K61r + D128l*K65l + D104r*K79r + D128r*K65r - D139l*K72l - D139r*K72r - D166l*K61l - D166r*K61r + D148l*K108l + D148r*K108r + D175l*K95l + D157l*K115l + D175r*K95r + D157r*K115r + D184l*K100l + D184r*K100r - D206l*K108l - D206r*K108r - D236l*K95l + D196l*K145l - D236r*K95r + D196r*K145r + D226l*K130l + D226r*K130r + D216l*K154l + D216r*K154r + D246l*K136l + D246r*K136r - D259l*K145l - D259r*K145r - D292l*K130l - D292r*K130r + D270l*K189l + D270r*K189r + D303l*K172l + D281l*K198l + D303r*K172r + D281r*K198r + D314l*K179l + D314r*K179r - D352l*K189l - D352r*K189r - D388l*K172l + D328l*K234l - D388r*K172r + D328r*K234r + D364l*K215l + D340l*K245l + D364r*K215r + D340r*K245r + D376l*K223l + D376r*K223r + D4l*K12l + D22l*K4l + D34l*K6l - D64l*K4l + D4r*K12r + D22r*K4r + D34r*K6r - D64r*K4r;
X22 = 2*ZZw + D16*cos(q_imu) + (L^2*mw)/2 + D19*sin(q_imu) + D24*K15 + D39*K10 + D43*K11 + D70*K10 + D50*K34 + D65*K28 + D60*K39 + D75*K29 + D29l*K28 - D29r*K28 + D11l*K16l + D17l*K20l + D11r*K16r + D17r*K20r - D44l*K12l - D44r*K12r + D51l*K43l + D51r*K43r + D58l*K48l + D72l*K34l + D79l*K37l + D58r*K48r + D72r*K34r + D79r*K37r - D97l*K43l - D97r*K43r - D121l*K34l + D89l*K72l - D121r*K34r + D89r*K72r + D113l*K61l + D105l*K79l + D113r*K61r + D129l*K65l + D105r*K79r + D129r*K65r - D140l*K72l - D140r*K72r - D167l*K61l - D167r*K61r + D149l*K108l + D149r*K108r + D176l*K95l + D158l*K115l + D176r*K95r + D158r*K115r + D185l*K100l + D185r*K100r - D207l*K108l - D207r*K108r - D237l*K95l + D197l*K145l - D237r*K95r + D197r*K145r + D227l*K130l + D227r*K130r + D217l*K154l + D217r*K154r + D247l*K136l + D247r*K136r - D260l*K145l - D260r*K145r - D293l*K130l - D293r*K130r + D271l*K189l + D271r*K189r + D304l*K172l + D282l*K198l + D304r*K172r + D282r*K198r + D315l*K179l + D315r*K179r - D353l*K189l - D353r*K189r - D389l*K172l + D329l*K234l - D389r*K172r + D329r*K234r + D365l*K215l + D341l*K245l + D365r*K215r + D341r*K245r + D377l*K223l + D377r*K223r + D5l*K12l + D23l*K4l + D35l*K6l - D65l*K4l + D5r*K12r + D23r*K4r + D35r*K6r - D65r*K4r + (L^2*YYw)/(2*R^2);
X23 = D40*K10 - XZ_1*sin(q_imu) - XY_1*cos(q_imu) + D44*K11 + D71*K10 + D51*K34 + D66*K28 + D61*K39 + D76*K29 + D30l*K28 - D30r*K28 + D12l*K16l + D18l*K20l + D12r*K16r + D18r*K20r - D45l*K12l - D45r*K12r + D52l*K43l + D52r*K43r + D59l*K48l + D73l*K34l + D80l*K37l + D59r*K48r + D73r*K34r + D80r*K37r - D98l*K43l - D98r*K43r - D122l*K34l + D90l*K72l - D122r*K34r + D90r*K72r + D114l*K61l + D106l*K79l + D114r*K61r + D130l*K65l + D106r*K79r + D130r*K65r - D141l*K72l - D141r*K72r - D168l*K61l - D168r*K61r + D150l*K108l + D150r*K108r + D177l*K95l + D159l*K115l + D177r*K95r + D159r*K115r + D186l*K100l + D186r*K100r - D208l*K108l - D208r*K108r - D238l*K95l + D198l*K145l - D238r*K95r + D198r*K145r + D228l*K130l + D228r*K130r + D218l*K154l + D218r*K154r + D248l*K136l + D248r*K136r - D261l*K145l - D261r*K145r - D294l*K130l - D294r*K130r + D272l*K189l + D272r*K189r + D305l*K172l + D283l*K198l + D305r*K172r + D283r*K198r + D316l*K179l + D316r*K179r - D354l*K189l - D354r*K189r - D390l*K172l + D330l*K234l - D390r*K172r + D330r*K234r + D366l*K215l + D342l*K245l + D366r*K215r + D342r*K245r + D378l*K223l + D378r*K223r + D6l*K12l + D24l*K4l + D36l*K6l - D66l*K4l + D6r*K12r + D24r*K4r + D36r*K6r - D66r*K4r;
X24 = D72*K10 - K11*XZ_2 - K10*XY_2 + D52*K34 + D67*K28 + D62*K39 + D77*K29 + D31l*K28 - D31r*K28 + D13l*K16l + D19l*K20l + D13r*K16r + D19r*K20r - D46l*K12l - D46r*K12r + D53l*K43l + D53r*K43r + D60l*K48l + D74l*K34l + D81l*K37l + D60r*K48r + D74r*K34r + D81r*K37r - D99l*K43l - D99r*K43r - D123l*K34l + D91l*K72l - D123r*K34r + D91r*K72r + D115l*K61l + D107l*K79l + D115r*K61r + D131l*K65l + D107r*K79r + D131r*K65r - D142l*K72l - D142r*K72r - D169l*K61l - D169r*K61r + D151l*K108l + D151r*K108r + D178l*K95l + D160l*K115l + D178r*K95r + D160r*K115r + D187l*K100l + D187r*K100r - D209l*K108l - D209r*K108r - D239l*K95l + D199l*K145l - D239r*K95r + D199r*K145r + D229l*K130l + D229r*K130r + D219l*K154l + D219r*K154r + D249l*K136l + D249r*K136r - D262l*K145l - D262r*K145r - D295l*K130l - D295r*K130r + D273l*K189l + D273r*K189r + D306l*K172l + D284l*K198l + D306r*K172r + D284r*K198r + D317l*K179l + D317r*K179r - D355l*K189l - D355r*K189r - D391l*K172l + D331l*K234l - D391r*K172r + D331r*K234r + D367l*K215l + D343l*K245l + D367r*K215r + D343r*K245r + D379l*K223l + D379r*K223r + D7l*K12l + D25l*K4l + D37l*K6l - D67l*K4l + D7r*K12r + D25r*K4r + D37r*K6r - D67r*K4r;
X25 = D32l*K28 - K10*YY_3 - K29*YZ_3 - K28*XY_3 - D32r*K28 + D14l*K16l + D20l*K20l + D14r*K16r + D20r*K20r - D47l*K12l - D47r*K12r + D54l*K43l + D54r*K43r + D61l*K48l + D75l*K34l + D82l*K37l + D61r*K48r + D75r*K34r + D82r*K37r - D100l*K43l - D100r*K43r - D124l*K34l + D92l*K72l - D124r*K34r + D92r*K72r + D116l*K61l + D108l*K79l + D116r*K61r + D132l*K65l + D108r*K79r + D132r*K65r - D143l*K72l - D143r*K72r - D170l*K61l - D170r*K61r + D152l*K108l + D152r*K108r + D179l*K95l + D161l*K115l + D179r*K95r + D161r*K115r + D188l*K100l + D188r*K100r - D210l*K108l - D210r*K108r - D240l*K95l + D200l*K145l - D240r*K95r + D200r*K145r + D230l*K130l + D230r*K130r + D220l*K154l + D220r*K154r + D250l*K136l + D250r*K136r - D263l*K145l - D263r*K145r - D296l*K130l - D296r*K130r + D274l*K189l + D274r*K189r + D307l*K172l + D285l*K198l + D307r*K172r + D285r*K198r + D318l*K179l + D318r*K179r - D356l*K189l - D356r*K189r - D392l*K172l + D332l*K234l - D392r*K172r + D332r*K234r + D368l*K215l + D344l*K245l + D368r*K215r + D344r*K245r + D380l*K223l + D380r*K223r + D8l*K12l + D26l*K4l + D38l*K6l - D68l*K4l + D8r*K12r + D26r*K4r + D38r*K6r - D68r*K4r + K39*MX_3 - K34*MZ_3;
X26 = D55l*K43l - K28*YY_4l - K6l*YZ_4l - D48l*K12l - K4l*XY_4l + D62l*K48l + D76l*K34l + D83l*K37l - D101l*K43l - D125l*K34l + D93l*K72l + D117l*K61l + D109l*K79l + D133l*K65l - D144l*K72l - D171l*K61l + D153l*K108l + D180l*K95l + D162l*K115l + D189l*K100l - D211l*K108l - D241l*K95l + D201l*K145l + D231l*K130l + D221l*K154l + D251l*K136l - D264l*K145l - D297l*K130l + D275l*K189l + D308l*K172l + D286l*K198l + D319l*K179l - D357l*K189l - D393l*K172l + D333l*K234l + D369l*K215l + D345l*K245l + D381l*K223l - D69l*K4l + K20l*MX_4l - K12l*MZ_4l;
X27 = K4l*XX_5l - K34l*XY_5l - K37l*XZ_5l - D102l*K43l - D126l*K34l + D94l*K72l + D118l*K61l + D110l*K79l + D134l*K65l - D145l*K72l - D172l*K61l + D154l*K108l + D181l*K95l + D163l*K115l + D190l*K100l - D212l*K108l - D242l*K95l + D202l*K145l + D232l*K130l + D222l*K154l + D252l*K136l - D265l*K145l - D298l*K130l + D276l*K189l + D309l*K172l + D287l*K198l + D320l*K179l - D358l*K189l - D394l*K172l + D334l*K234l + D370l*K215l + D346l*K245l + D382l*K223l - K48l*MY_5l + K43l*MZ_5l;
X28 = K34l*YY_6l - K61l*XY_6l - K65l*YZ_6l - D146l*K72l - D173l*K61l + D155l*K108l + D182l*K95l + D164l*K115l + D191l*K100l - D213l*K108l - D243l*K95l + D203l*K145l + D233l*K130l + D223l*K154l + D253l*K136l - D266l*K145l - D299l*K130l + D277l*K189l + D310l*K172l + D288l*K198l + D321l*K179l - D359l*K189l - D395l*K172l + D335l*K234l + D371l*K215l + D347l*K245l + D383l*K223l + K79l*MX_6l - K72l*MZ_6l;
X29 = K61l*XX_7l - K95l*XY_7l - K100l*XZ_7l - D214l*K108l - D244l*K95l + D204l*K145l + D234l*K130l + D224l*K154l + D254l*K136l - D267l*K145l - D300l*K130l + D278l*K189l + D311l*K172l + D289l*K198l + D322l*K179l - D360l*K189l - D396l*K172l + D336l*K234l + D372l*K215l + D348l*K245l + D384l*K223l - K115l*MY_7l + K108l*MZ_7l;
X30 = K95l*YY_8l - K130l*XY_8l - K136l*YZ_8l - D268l*K145l - D301l*K130l + D279l*K189l + D312l*K172l + D290l*K198l + D323l*K179l - D361l*K189l - D397l*K172l + D337l*K234l + D373l*K215l + D349l*K245l + D385l*K223l + K154l*MX_8l - K145l*MZ_8l;
X31 = K130l*XX_9l - K172l*XY_9l - K179l*XZ_9l - D362l*K189l - D398l*K172l + D338l*K234l + D374l*K215l + D350l*K245l + D386l*K223l - K198l*MY_9l + K189l*MZ_9l;
X32 = K172l*ZZ_10l - K223l*YZ_10l - K215l*XZ_10l - K245l*MX_10l + K234l*MY_10l;
X33 = K28*YY_4r - K4r*XY_4r - K6r*YZ_4r - D48r*K12r + D55r*K43r + D62r*K48r + D76r*K34r + D83r*K37r - D101r*K43r - D125r*K34r + D93r*K72r + D117r*K61r + D109r*K79r + D133r*K65r - D144r*K72r - D171r*K61r + D153r*K108r + D180r*K95r + D162r*K115r + D189r*K100r - D211r*K108r - D241r*K95r + D201r*K145r + D231r*K130r + D221r*K154r + D251r*K136r - D264r*K145r - D297r*K130r + D275r*K189r + D308r*K172r + D286r*K198r + D319r*K179r - D357r*K189r - D393r*K172r + D333r*K234r + D369r*K215r + D345r*K245r + D381r*K223r - D69r*K4r + K20r*MX_4r - K12r*MZ_4r;
X34 = K4r*XX_5r - K34r*XY_5r - K37r*XZ_5r - D102r*K43r - D126r*K34r + D94r*K72r + D118r*K61r + D110r*K79r + D134r*K65r - D145r*K72r - D172r*K61r + D154r*K108r + D181r*K95r + D163r*K115r + D190r*K100r - D212r*K108r - D242r*K95r + D202r*K145r + D232r*K130r + D222r*K154r + D252r*K136r - D265r*K145r - D298r*K130r + D276r*K189r + D309r*K172r + D287r*K198r + D320r*K179r - D358r*K189r - D394r*K172r + D334r*K234r + D370r*K215r + D346r*K245r + D382r*K223r - K48r*MY_5r + K43r*MZ_5r;
X35 = K34r*YY_6r - K61r*XY_6r - K65r*YZ_6r - D146r*K72r - D173r*K61r + D155r*K108r + D182r*K95r + D164r*K115r + D191r*K100r - D213r*K108r - D243r*K95r + D203r*K145r + D233r*K130r + D223r*K154r + D253r*K136r - D266r*K145r - D299r*K130r + D277r*K189r + D310r*K172r + D288r*K198r + D321r*K179r - D359r*K189r - D395r*K172r + D335r*K234r + D371r*K215r + D347r*K245r + D383r*K223r + K79r*MX_6r - K72r*MZ_6r;
X36 = K61r*XX_7r - K95r*XY_7r - K100r*XZ_7r - D214r*K108r - D244r*K95r + D204r*K145r + D234r*K130r + D224r*K154r + D254r*K136r - D267r*K145r - D300r*K130r + D278r*K189r + D311r*K172r + D289r*K198r + D322r*K179r - D360r*K189r - D396r*K172r + D336r*K234r + D372r*K215r + D348r*K245r + D384r*K223r - K115r*MY_7r + K108r*MZ_7r;
X37 = K95r*YY_8r - K130r*XY_8r - K136r*YZ_8r - D268r*K145r - D301r*K130r + D279r*K189r + D312r*K172r + D290r*K198r + D323r*K179r - D361r*K189r - D397r*K172r + D337r*K234r + D373r*K215r + D349r*K245r + D385r*K223r + K154r*MX_8r - K145r*MZ_8r;
X38 = K130r*XX_9r - K172r*XY_9r - K179r*XZ_9r - D362r*K189r - D398r*K172r + D338r*K234r + D374r*K215r + D350r*K245r + D386r*K223r - K198r*MY_9r + K189r*MZ_9r;
X39 = K172r*ZZ_10r - K223r*YZ_10r - K215r*XZ_10r - K245r*MX_10r + K234r*MY_10r;
X40 = D17*cos(q_imu) + D20*sin(q_imu) + D25*K15 + D41*K10 + D45*K11 + D73*K10 + D53*K34 + D68*K28 + D63*K39 + D78*K29 + D33l*K28 - D33r*K28 + D15l*K16l + D21l*K20l + D15r*K16r + D21r*K20r - D49l*K12l - D49r*K12r + D56l*K43l + D56r*K43r + D63l*K48l + D77l*K34l + D84l*K37l + D63r*K48r + D77r*K34r + D84r*K37r - D103l*K43l - D103r*K43r - D127l*K34l + D95l*K72l - D127r*K34r + D95r*K72r + D119l*K61l + D111l*K79l + D119r*K61r + D135l*K65l + D111r*K79r + D135r*K65r - D147l*K72l - D147r*K72r - D174l*K61l - D174r*K61r + D156l*K108l + D156r*K108r + D183l*K95l + D165l*K115l + D183r*K95r + D165r*K115r + D192l*K100l + D192r*K100r - D215l*K108l - D215r*K108r - D245l*K95l + D205l*K145l - D245r*K95r + D205r*K145r + D235l*K130l + D235r*K130r + D225l*K154l + D225r*K154r + D255l*K136l + D255r*K136r - D269l*K145l - D269r*K145r - D302l*K130l - D302r*K130r + D280l*K189l + D280r*K189r + D313l*K172l + D291l*K198l + D313r*K172r + D291r*K198r + D324l*K179l + D324r*K179r - D363l*K189l - D363r*K189r - D399l*K172l + D339l*K234l - D399r*K172r + D339r*K234r + D375l*K215l + D351l*K245l + D375r*K215r + D351r*K245r + D387l*K223l + D387r*K223r + D9l*K12l + D27l*K4l + D39l*K6l - D70l*K4l + D9r*K12r + D27r*K4r + D39r*K6r - D70r*K4r;
% LHS_{dpsi} &= (D328r*K234r - D388r*K172r - D352r*K189r + D364r*K215r + D340r*K245r + D376r*K223r)*ddx + (D329r*K234r - D389r*K172r - D353r*K189r + D365r*K215r + D341r*K245r + D377r*K223r)*ddpsi + (D330r*K234r - D390r*K172r - D354r*K189r + D366r*K215r + D342r*K245r + D378r*K223r)*ddq_imu + (D331r*K234r - D391r*K172r - D355r*K189r + D367r*K215r + D343r*K245r + D379r*K223r)*ddq_w + (D332r*K234r - D392r*K172r - D356r*K189r + D368r*K215r + D344r*K245r + D380r*K223r)*ddq_torso + (D333r*K234r - D393r*K172r - D357r*K189r + D369r*K215r + D345r*K245r + D381r*K223r)*ddq_1r + (D334r*K234r - D394r*K172r - D358r*K189r + D370r*K215r + D346r*K245r + D382r*K223r)*ddq_2r + (D335r*K234r - D395r*K172r - D359r*K189r + D371r*K215r + D347r*K245r + D383r*K223r)*ddq_3r + (D336r*K234r - D396r*K172r - D360r*K189r + D372r*K215r + D348r*K245r + D384r*K223r)*ddq_4r + (D337r*K234r - D397r*K172r - D361r*K189r + D373r*K215r + D349r*K245r + D385r*K223r)*ddq_5r + (D338r*K234r - D398r*K172r - D362r*K189r + D374r*K215r + D350r*K245r + D386r*K223r)*ddq_6r + (K172r*ZZ_10r - K223r*YZ_10r - K215r*XZ_10r - K245r*MX_10r + K234r*MY_10r)*ddq_7r + (D339r*K234r - D399r*K172r - D363r*K189r + D375r*K215r + D351r*K245r + D387r*K223r) 
% \nonumber \\ 
% LHS_{dq_imu} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_imu} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_imu}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & (-D12)*ddx + (-D13)*ddpsi + XX_1*ddq_imu - D14 
% \nonumber \\ 
% &+(D26*K16 - D34 + D30*K18)*ddx + (D27*K16 - D35 + D31*K18)*ddpsi + (D28*K16 - D36 + D32*K18)*ddq_imu + (XX_2 - K18*MY_2 + K16*MZ_2)*ddq_w + (D29*K16 - D37 + D33*K18) 
% \nonumber \\ 
% &+(D64*cos(q_torso) - D74*sin(q_torso) + D49*K35 + D54*K37 + D59*K40)*ddx + (D65*cos(q_torso) - D75*sin(q_torso) + D50*K35 + D55*K37 + D60*K40)*ddpsi + (D66*cos(q_torso) - D76*sin(q_torso) + D51*K35 + D56*K37 + D61*K40)*ddq_imu + (D67*cos(q_torso) - D77*sin(q_torso) + D52*K35 + D57*K37 + D62*K40)*ddq_w + (YZ_3*sin(q_torso) - XY_3*cos(q_torso) + K40*MX_3 - K35*MZ_3)*ddq_torso + (D68*cos(q_torso) - D78*sin(q_torso) + D53*K35 + D58*K37 + D63*K40) 
% \nonumber \\ 
% &+(D28l*cos(q_torso) + D10l*K17l + D16l*K21l + D4l*K13l + D22l*K5l + D34l*K7l)*ddx + (D29l*cos(q_torso) + D11l*K17l + D17l*K21l + D5l*K13l + D23l*K5l + D35l*K7l)*ddpsi + (D30l*cos(q_torso) + D12l*K17l + D18l*K21l + D6l*K13l + D24l*K5l + D36l*K7l)*ddq_imu + (D31l*cos(q_torso) + D13l*K17l + D19l*K21l + D7l*K13l + D25l*K5l + D37l*K7l)*ddq_w + (D32l*cos(q_torso) + D14l*K17l + D20l*K21l + D8l*K13l + D26l*K5l + D38l*K7l)*ddq_torso + (K21l*MX_4l - K7l*YZ_4l - YY_4l*cos(q_torso) - K5l*XY_4l - K13l*MZ_4l)*ddq_1l + (D33l*cos(q_torso) + D15l*K17l + D21l*K21l + D9l*K13l + D27l*K5l + D39l*K7l) 
% \nonumber \\ 
% &+(D50l*K44l - D43l*K13l + D57l*K49l + D71l*K35l + D78l*K38l - D64l*K5l)*ddx + (D51l*K44l - D44l*K13l + D58l*K49l + D72l*K35l + D79l*K38l - D65l*K5l)*ddpsi + (D52l*K44l - D45l*K13l + D59l*K49l + D73l*K35l + D80l*K38l - D66l*K5l)*ddq_imu + (D53l*K44l - D46l*K13l + D60l*K49l + D74l*K35l + D81l*K38l - D67l*K5l)*ddq_w + (D54l*K44l - D47l*K13l + D61l*K49l + D75l*K35l + D82l*K38l - D68l*K5l)*ddq_torso + (D55l*K44l - D48l*K13l + D62l*K49l + D76l*K35l + D83l*K38l - D69l*K5l)*ddq_1l + (K5l*XX_5l - K35l*XY_5l - K38l*XZ_5l - K49l*MY_5l + K44l*MZ_5l)*ddq_2l + (D56l*K44l - D49l*K13l + D63l*K49l + D77l*K35l + D84l*K38l - D70l*K5l) 
% \nonumber \\ 
% &+(D88l*K73l - D120l*K35l - D96l*K44l + D112l*K62l + D104l*K80l + D128l*K66l)*ddx + (D89l*K73l - D121l*K35l - D97l*K44l + D113l*K62l + D105l*K80l + D129l*K66l)*ddpsi + (D90l*K73l - D122l*K35l - D98l*K44l + D114l*K62l + D106l*K80l + D130l*K66l)*ddq_imu + (D91l*K73l - D123l*K35l - D99l*K44l + D115l*K62l + D107l*K80l + D131l*K66l)*ddq_w + (D92l*K73l - D124l*K35l - D100l*K44l + D116l*K62l + D108l*K80l + D132l*K66l)*ddq_torso + (D93l*K73l - D125l*K35l - D101l*K44l + D117l*K62l + D109l*K80l + D133l*K66l)*ddq_1l + (D94l*K73l - D126l*K35l - D102l*K44l + D118l*K62l + D110l*K80l + D134l*K66l)*ddq_2l + (K35l*YY_6l - K62l*XY_6l - K66l*YZ_6l + K80l*MX_6l - K73l*MZ_6l)*ddq_3l + (D95l*K73l - D127l*K35l - D103l*K44l + D119l*K62l + D111l*K80l + D135l*K66l) 
% \nonumber \\ 
% &+(D148l*K109l - D166l*K62l - D139l*K73l + D175l*K96l + D157l*K116l + D184l*K101l)*ddx + (D149l*K109l - D167l*K62l - D140l*K73l + D176l*K96l + D158l*K116l + D185l*K101l)*ddpsi + (D150l*K109l - D168l*K62l - D141l*K73l + D177l*K96l + D159l*K116l + D186l*K101l)*ddq_imu + (D151l*K109l - D169l*K62l - D142l*K73l + D178l*K96l + D160l*K116l + D187l*K101l)*ddq_w + (D152l*K109l - D170l*K62l - D143l*K73l + D179l*K96l + D161l*K116l + D188l*K101l)*ddq_torso + (D153l*K109l - D171l*K62l - D144l*K73l + D180l*K96l + D162l*K116l + D189l*K101l)*ddq_1l + (D154l*K109l - D172l*K62l - D145l*K73l + D181l*K96l + D163l*K116l + D190l*K101l)*ddq_2l + (D155l*K109l - D173l*K62l - D146l*K73l + D182l*K96l + D164l*K116l + D191l*K101l)*ddq_3l + (K62l*XX_7l - K96l*XY_7l - K101l*XZ_7l - K116l*MY_7l + K109l*MZ_7l)*ddq_4l + (D156l*K109l - D174l*K62l - D147l*K73l + D183l*K96l + D165l*K116l + D192l*K101l) 
% \nonumber \\ 
% &+(D196l*K146l - D236l*K96l - D206l*K109l + D226l*K131l + D216l*K155l + D246l*K137l)*ddx + (D197l*K146l - D237l*K96l - D207l*K109l + D227l*K131l + D217l*K155l + D247l*K137l)*ddpsi + (D198l*K146l - D238l*K96l - D208l*K109l + D228l*K131l + D218l*K155l + D248l*K137l)*ddq_imu + (D199l*K146l - D239l*K96l - D209l*K109l + D229l*K131l + D219l*K155l + D249l*K137l)*ddq_w + (D200l*K146l - D240l*K96l - D210l*K109l + D230l*K131l + D220l*K155l + D250l*K137l)*ddq_torso + (D201l*K146l - D241l*K96l - D211l*K109l + D231l*K131l + D221l*K155l + D251l*K137l)*ddq_1l + (D202l*K146l - D242l*K96l - D212l*K109l + D232l*K131l + D222l*K155l + D252l*K137l)*ddq_2l + (D203l*K146l - D243l*K96l - D213l*K109l + D233l*K131l + D223l*K155l + D253l*K137l)*ddq_3l + (D204l*K146l - D244l*K96l - D214l*K109l + D234l*K131l + D224l*K155l + D254l*K137l)*ddq_4l + (K96l*YY_8l - K131l*XY_8l - K137l*YZ_8l + K155l*MX_8l - K146l*MZ_8l)*ddq_5l + (D205l*K146l - D245l*K96l - D215l*K109l + D235l*K131l + D225l*K155l + D255l*K137l) 
% \nonumber \\ 
% &+(D270l*K190l - D292l*K131l - D259l*K146l + D303l*K173l + D281l*K199l + D314l*K180l)*ddx + (D271l*K190l - D293l*K131l - D260l*K146l + D304l*K173l + D282l*K199l + D315l*K180l)*ddpsi + (D272l*K190l - D294l*K131l - D261l*K146l + D305l*K173l + D283l*K199l + D316l*K180l)*ddq_imu + (D273l*K190l - D295l*K131l - D262l*K146l + D306l*K173l + D284l*K199l + D317l*K180l)*ddq_w + (D274l*K190l - D296l*K131l - D263l*K146l + D307l*K173l + D285l*K199l + D318l*K180l)*ddq_torso + (D275l*K190l - D297l*K131l - D264l*K146l + D308l*K173l + D286l*K199l + D319l*K180l)*ddq_1l + (D276l*K190l - D298l*K131l - D265l*K146l + D309l*K173l + D287l*K199l + D320l*K180l)*ddq_2l + (D277l*K190l - D299l*K131l - D266l*K146l + D310l*K173l + D288l*K199l + D321l*K180l)*ddq_3l + (D278l*K190l - D300l*K131l - D267l*K146l + D311l*K173l + D289l*K199l + D322l*K180l)*ddq_4l + (D279l*K190l - D301l*K131l - D268l*K146l + D312l*K173l + D290l*K199l + D323l*K180l)*ddq_5l + (K131l*XX_9l - K173l*XY_9l - K180l*XZ_9l - K199l*MY_9l + K190l*MZ_9l)*ddq_6l + (D280l*K190l - D302l*K131l - D269l*K146l + D313l*K173l + D291l*K199l + D324l*K180l) 
% \nonumber \\ 
% &+(D328l*K235l - D388l*K173l - D352l*K190l + D364l*K216l + D340l*K246l + D376l*K224l)*ddx + (D329l*K235l - D389l*K173l - D353l*K190l + D365l*K216l + D341l*K246l + D377l*K224l)*ddpsi + (D330l*K235l - D390l*K173l - D354l*K190l + D366l*K216l + D342l*K246l + D378l*K224l)*ddq_imu + (D331l*K235l - D391l*K173l - D355l*K190l + D367l*K216l + D343l*K246l + D379l*K224l)*ddq_w + (D332l*K235l - D392l*K173l - D356l*K190l + D368l*K216l + D344l*K246l + D380l*K224l)*ddq_torso + (D333l*K235l - D393l*K173l - D357l*K190l + D369l*K216l + D345l*K246l + D381l*K224l)*ddq_1l + (D334l*K235l - D394l*K173l - D358l*K190l + D370l*K216l + D346l*K246l + D382l*K224l)*ddq_2l + (D335l*K235l - D395l*K173l - D359l*K190l + D371l*K216l + D347l*K246l + D383l*K224l)*ddq_3l + (D336l*K235l - D396l*K173l - D360l*K190l + D372l*K216l + D348l*K246l + D384l*K224l)*ddq_4l + (D337l*K235l - D397l*K173l - D361l*K190l + D373l*K216l + D349l*K246l + D385l*K224l)*ddq_5l + (D338l*K235l - D398l*K173l - D362l*K190l + D374l*K216l + D350l*K246l + D386l*K224l)*ddq_6l + (K173l*ZZ_10l - K224l*YZ_10l - K216l*XZ_10l - K246l*MX_10l + K235l*MY_10l)*ddq_7l + (D339l*K235l - D399l*K173l - D363l*K190l + D375l*K216l + D351l*K246l + D387l*K224l) 
% \nonumber \\ 
% &+(D10r*K17r - D28r*cos(q_torso) + D16r*K21r + D4r*K13r + D22r*K5r + D34r*K7r)*ddx + (D11r*K17r - D29r*cos(q_torso) + D17r*K21r + D5r*K13r + D23r*K5r + D35r*K7r)*ddpsi + (D12r*K17r - D30r*cos(q_torso) + D18r*K21r + D6r*K13r + D24r*K5r + D36r*K7r)*ddq_imu + (D13r*K17r - D31r*cos(q_torso) + D19r*K21r + D7r*K13r + D25r*K5r + D37r*K7r)*ddq_w + (D14r*K17r - D32r*cos(q_torso) + D20r*K21r + D8r*K13r + D26r*K5r + D38r*K7r)*ddq_torso + (YY_4r*cos(q_torso) - K7r*YZ_4r - K5r*XY_4r + K21r*MX_4r - K13r*MZ_4r)*ddq_1r + (D15r*K17r - D33r*cos(q_torso) + D21r*K21r + D9r*K13r + D27r*K5r + D39r*K7r) 
% \nonumber \\ 
% &+(D50r*K44r - D43r*K13r + D57r*K49r + D71r*K35r + D78r*K38r - D64r*K5r)*ddx + (D51r*K44r - D44r*K13r + D58r*K49r + D72r*K35r + D79r*K38r - D65r*K5r)*ddpsi + (D52r*K44r - D45r*K13r + D59r*K49r + D73r*K35r + D80r*K38r - D66r*K5r)*ddq_imu + (D53r*K44r - D46r*K13r + D60r*K49r + D74r*K35r + D81r*K38r - D67r*K5r)*ddq_w + (D54r*K44r - D47r*K13r + D61r*K49r + D75r*K35r + D82r*K38r - D68r*K5r)*ddq_torso + (D55r*K44r - D48r*K13r + D62r*K49r + D76r*K35r + D83r*K38r - D69r*K5r)*ddq_1r + (K5r*XX_5r - K35r*XY_5r - K38r*XZ_5r - K49r*MY_5r + K44r*MZ_5r)*ddq_2r + (D56r*K44r - D49r*K13r + D63r*K49r + D77r*K35r + D84r*K38r - D70r*K5r) 
% \nonumber \\ 
% &+(D88r*K73r - D120r*K35r - D96r*K44r + D112r*K62r + D104r*K80r + D128r*K66r)*ddx + (D89r*K73r - D121r*K35r - D97r*K44r + D113r*K62r + D105r*K80r + D129r*K66r)*ddpsi + (D90r*K73r - D122r*K35r - D98r*K44r + D114r*K62r + D106r*K80r + D130r*K66r)*ddq_imu + (D91r*K73r - D123r*K35r - D99r*K44r + D115r*K62r + D107r*K80r + D131r*K66r)*ddq_w + (D92r*K73r - D124r*K35r - D100r*K44r + D116r*K62r + D108r*K80r + D132r*K66r)*ddq_torso + (D93r*K73r - D125r*K35r - D101r*K44r + D117r*K62r + D109r*K80r + D133r*K66r)*ddq_1r + (D94r*K73r - D126r*K35r - D102r*K44r + D118r*K62r + D110r*K80r + D134r*K66r)*ddq_2r + (K35r*YY_6r - K62r*XY_6r - K66r*YZ_6r + K80r*MX_6r - K73r*MZ_6r)*ddq_3r + (D95r*K73r - D127r*K35r - D103r*K44r + D119r*K62r + D111r*K80r + D135r*K66r) 
% \nonumber \\ 
% &+(D148r*K109r - D166r*K62r - D139r*K73r + D175r*K96r + D157r*K116r + D184r*K101r)*ddx + (D149r*K109r - D167r*K62r - D140r*K73r + D176r*K96r + D158r*K116r + D185r*K101r)*ddpsi + (D150r*K109r - D168r*K62r - D141r*K73r + D177r*K96r + D159r*K116r + D186r*K101r)*ddq_imu + (D151r*K109r - D169r*K62r - D142r*K73r + D178r*K96r + D160r*K116r + D187r*K101r)*ddq_w + (D152r*K109r - D170r*K62r - D143r*K73r + D179r*K96r + D161r*K116r + D188r*K101r)*ddq_torso + (D153r*K109r - D171r*K62r - D144r*K73r + D180r*K96r + D162r*K116r + D189r*K101r)*ddq_1r + (D154r*K109r - D172r*K62r - D145r*K73r + D181r*K96r + D163r*K116r + D190r*K101r)*ddq_2r + (D155r*K109r - D173r*K62r - D146r*K73r + D182r*K96r + D164r*K116r + D191r*K101r)*ddq_3r + (K62r*XX_7r - K96r*XY_7r - K101r*XZ_7r - K116r*MY_7r + K109r*MZ_7r)*ddq_4r + (D156r*K109r - D174r*K62r - D147r*K73r + D183r*K96r + D165r*K116r + D192r*K101r) 
% \nonumber \\ 
% &+(D196r*K146r - D236r*K96r - D206r*K109r + D226r*K131r + D216r*K155r + D246r*K137r)*ddx + (D197r*K146r - D237r*K96r - D207r*K109r + D227r*K131r + D217r*K155r + D247r*K137r)*ddpsi + (D198r*K146r - D238r*K96r - D208r*K109r + D228r*K131r + D218r*K155r + D248r*K137r)*ddq_imu + (D199r*K146r - D239r*K96r - D209r*K109r + D229r*K131r + D219r*K155r + D249r*K137r)*ddq_w + (D200r*K146r - D240r*K96r - D210r*K109r + D230r*K131r + D220r*K155r + D250r*K137r)*ddq_torso + (D201r*K146r - D241r*K96r - D211r*K109r + D231r*K131r + D221r*K155r + D251r*K137r)*ddq_1r + (D202r*K146r - D242r*K96r - D212r*K109r + D232r*K131r + D222r*K155r + D252r*K137r)*ddq_2r + (D203r*K146r - D243r*K96r - D213r*K109r + D233r*K131r + D223r*K155r + D253r*K137r)*ddq_3r + (D204r*K146r - D244r*K96r - D214r*K109r + D234r*K131r + D224r*K155r + D254r*K137r)*ddq_4r + (K96r*YY_8r - K131r*XY_8r - K137r*YZ_8r + K155r*MX_8r - K146r*MZ_8r)*ddq_5r + (D205r*K146r - D245r*K96r - D215r*K109r + D235r*K131r + D225r*K155r + D255r*K137r) 
% \nonumber \\ 
% &+(D270r*K190r - D292r*K131r - D259r*K146r + D303r*K173r + D281r*K199r + D314r*K180r)*ddx + (D271r*K190r - D293r*K131r - D260r*K146r + D304r*K173r + D282r*K199r + D315r*K180r)*ddpsi + (D272r*K190r - D294r*K131r - D261r*K146r + D305r*K173r + D283r*K199r + D316r*K180r)*ddq_imu + (D273r*K190r - D295r*K131r - D262r*K146r + D306r*K173r + D284r*K199r + D317r*K180r)*ddq_w + (D274r*K190r - D296r*K131r - D263r*K146r + D307r*K173r + D285r*K199r + D318r*K180r)*ddq_torso + (D275r*K190r - D297r*K131r - D264r*K146r + D308r*K173r + D286r*K199r + D319r*K180r)*ddq_1r + (D276r*K190r - D298r*K131r - D265r*K146r + D309r*K173r + D287r*K199r + D320r*K180r)*ddq_2r + (D277r*K190r - D299r*K131r - D266r*K146r + D310r*K173r + D288r*K199r + D321r*K180r)*ddq_3r + (D278r*K190r - D300r*K131r - D267r*K146r + D311r*K173r + D289r*K199r + D322r*K180r)*ddq_4r + (D279r*K190r - D301r*K131r - D268r*K146r + D312r*K173r + D290r*K199r + D323r*K180r)*ddq_5r + (K131r*XX_9r - K173r*XY_9r - K180r*XZ_9r - K199r*MY_9r + K190r*MZ_9r)*ddq_6r + (D280r*K190r - D302r*K131r - D269r*K146r + D313r*K173r + D291r*K199r + D324r*K180r) 
% \nonumber \\ 
% &+(D328r*K235r - D388r*K173r - D352r*K190r + D364r*K216r + D340r*K246r + D376r*K224r)*ddx + (D329r*K235r - D389r*K173r - D353r*K190r + D365r*K216r + D341r*K246r + D377r*K224r)*ddpsi + (D330r*K235r - D390r*K173r - D354r*K190r + D366r*K216r + D342r*K246r + D378r*K224r)*ddq_imu + (D331r*K235r - D391r*K173r - D355r*K190r + D367r*K216r + D343r*K246r + D379r*K224r)*ddq_w + (D332r*K235r - D392r*K173r - D356r*K190r + D368r*K216r + D344r*K246r + D380r*K224r)*ddq_torso + (D333r*K235r - D393r*K173r - D357r*K190r + D369r*K216r + D345r*K246r + D381r*K224r)*ddq_1r + (D334r*K235r - D394r*K173r - D358r*K190r + D370r*K216r + D346r*K246r + D382r*K224r)*ddq_2r + (D335r*K235r - D395r*K173r - D359r*K190r + D371r*K216r + D347r*K246r + D383r*K224r)*ddq_3r + (D336r*K235r - D396r*K173r - D360r*K190r + D372r*K216r + D348r*K246r + D384r*K224r)*ddq_4r + (D337r*K235r - D397r*K173r - D361r*K190r + D373r*K216r + D349r*K246r + D385r*K224r)*ddq_5r + (D338r*K235r - D398r*K173r - D362r*K190r + D374r*K216r + D350r*K246r + D386r*K224r)*ddq_6r + (K173r*ZZ_10r - K224r*YZ_10r - K216r*XZ_10r - K246r*MX_10r + K235r*MY_10r)*ddq_7r + (D339r*K235r - D399r*K173r - D363r*K190r + D375r*K216r + D351r*K246r + D387r*K224r) 
% \nonumber \\ 
X41 = D64*cos(q_torso) - D34 - D12 + D28l*cos(q_torso) - D28r*cos(q_torso) - D74*sin(q_torso) + D26*K16 + D30*K18 + D49*K35 + D54*K37 + D59*K40 + D10l*K17l + D16l*K21l + D10r*K17r + D16r*K21r - D43l*K13l - D43r*K13r + D50l*K44l + D50r*K44r + D57l*K49l + D71l*K35l + D78l*K38l + D57r*K49r + D71r*K35r + D78r*K38r - D96l*K44l - D96r*K44r - D120l*K35l + D88l*K73l - D120r*K35r + D88r*K73r + D112l*K62l + D104l*K80l + D112r*K62r + D128l*K66l + D104r*K80r + D128r*K66r - D139l*K73l - D139r*K73r - D166l*K62l - D166r*K62r + D148l*K109l + D148r*K109r + D175l*K96l + D157l*K116l + D175r*K96r + D157r*K116r + D184l*K101l + D184r*K101r - D206l*K109l - D206r*K109r - D236l*K96l + D196l*K146l - D236r*K96r + D196r*K146r + D226l*K131l + D226r*K131r + D216l*K155l + D216r*K155r + D246l*K137l + D246r*K137r - D259l*K146l - D259r*K146r - D292l*K131l - D292r*K131r + D270l*K190l + D270r*K190r + D303l*K173l + D281l*K199l + D303r*K173r + D281r*K199r + D314l*K180l + D314r*K180r - D352l*K190l - D352r*K190r - D388l*K173l + D328l*K235l - D388r*K173r + D328r*K235r + D364l*K216l + D340l*K246l + D364r*K216r + D340r*K246r + D376l*K224l + D376r*K224r + D4l*K13l + D22l*K5l + D34l*K7l - D64l*K5l + D4r*K13r + D22r*K5r + D34r*K7r - D64r*K5r;
X42 = D65*cos(q_torso) - D35 - D13 + D29l*cos(q_torso) - D29r*cos(q_torso) - D75*sin(q_torso) + D27*K16 + D31*K18 + D50*K35 + D55*K37 + D60*K40 + D11l*K17l + D17l*K21l + D11r*K17r + D17r*K21r - D44l*K13l - D44r*K13r + D51l*K44l + D51r*K44r + D58l*K49l + D72l*K35l + D79l*K38l + D58r*K49r + D72r*K35r + D79r*K38r - D97l*K44l - D97r*K44r - D121l*K35l + D89l*K73l - D121r*K35r + D89r*K73r + D113l*K62l + D105l*K80l + D113r*K62r + D129l*K66l + D105r*K80r + D129r*K66r - D140l*K73l - D140r*K73r - D167l*K62l - D167r*K62r + D149l*K109l + D149r*K109r + D176l*K96l + D158l*K116l + D176r*K96r + D158r*K116r + D185l*K101l + D185r*K101r - D207l*K109l - D207r*K109r - D237l*K96l + D197l*K146l - D237r*K96r + D197r*K146r + D227l*K131l + D227r*K131r + D217l*K155l + D217r*K155r + D247l*K137l + D247r*K137r - D260l*K146l - D260r*K146r - D293l*K131l - D293r*K131r + D271l*K190l + D271r*K190r + D304l*K173l + D282l*K199l + D304r*K173r + D282r*K199r + D315l*K180l + D315r*K180r - D353l*K190l - D353r*K190r - D389l*K173l + D329l*K235l - D389r*K173r + D329r*K235r + D365l*K216l + D341l*K246l + D365r*K216r + D341r*K246r + D377l*K224l + D377r*K224r + D5l*K13l + D23l*K5l + D35l*K7l - D65l*K5l + D5r*K13r + D23r*K5r + D35r*K7r - D65r*K5r;
X43 = XX_1 - D36 + D66*cos(q_torso) + D30l*cos(q_torso) - D30r*cos(q_torso) - D76*sin(q_torso) + D28*K16 + D32*K18 + D51*K35 + D56*K37 + D61*K40 + D12l*K17l + D18l*K21l + D12r*K17r + D18r*K21r - D45l*K13l - D45r*K13r + D52l*K44l + D52r*K44r + D59l*K49l + D73l*K35l + D80l*K38l + D59r*K49r + D73r*K35r + D80r*K38r - D98l*K44l - D98r*K44r - D122l*K35l + D90l*K73l - D122r*K35r + D90r*K73r + D114l*K62l + D106l*K80l + D114r*K62r + D130l*K66l + D106r*K80r + D130r*K66r - D141l*K73l - D141r*K73r - D168l*K62l - D168r*K62r + D150l*K109l + D150r*K109r + D177l*K96l + D159l*K116l + D177r*K96r + D159r*K116r + D186l*K101l + D186r*K101r - D208l*K109l - D208r*K109r - D238l*K96l + D198l*K146l - D238r*K96r + D198r*K146r + D228l*K131l + D228r*K131r + D218l*K155l + D218r*K155r + D248l*K137l + D248r*K137r - D261l*K146l - D261r*K146r - D294l*K131l - D294r*K131r + D272l*K190l + D272r*K190r + D305l*K173l + D283l*K199l + D305r*K173r + D283r*K199r + D316l*K180l + D316r*K180r - D354l*K190l - D354r*K190r - D390l*K173l + D330l*K235l - D390r*K173r + D330r*K235r + D366l*K216l + D342l*K246l + D366r*K216r + D342r*K246r + D378l*K224l + D378r*K224r + D6l*K13l + D24l*K5l + D36l*K7l - D66l*K5l + D6r*K13r + D24r*K5r + D36r*K7r - D66r*K5r;
X44 = XX_2 + D67*cos(q_torso) + D31l*cos(q_torso) - D31r*cos(q_torso) - D77*sin(q_torso) + D52*K35 + D57*K37 + D62*K40 + D13l*K17l + D19l*K21l + D13r*K17r + D19r*K21r - D46l*K13l - D46r*K13r + D53l*K44l + D53r*K44r + D60l*K49l + D74l*K35l + D81l*K38l + D60r*K49r + D74r*K35r + D81r*K38r - D99l*K44l - D99r*K44r - D123l*K35l + D91l*K73l - D123r*K35r + D91r*K73r + D115l*K62l + D107l*K80l + D115r*K62r + D131l*K66l + D107r*K80r + D131r*K66r - D142l*K73l - D142r*K73r - D169l*K62l - D169r*K62r + D151l*K109l + D151r*K109r + D178l*K96l + D160l*K116l + D178r*K96r + D160r*K116r + D187l*K101l + D187r*K101r - D209l*K109l - D209r*K109r - D239l*K96l + D199l*K146l - D239r*K96r + D199r*K146r + D229l*K131l + D229r*K131r + D219l*K155l + D219r*K155r + D249l*K137l + D249r*K137r - D262l*K146l - D262r*K146r - D295l*K131l - D295r*K131r + D273l*K190l + D273r*K190r + D306l*K173l + D284l*K199l + D306r*K173r + D284r*K199r + D317l*K180l + D317r*K180r - D355l*K190l - D355r*K190r - D391l*K173l + D331l*K235l - D391r*K173r + D331r*K235r + D367l*K216l + D343l*K246l + D367r*K216r + D343r*K246r + D379l*K224l + D379r*K224r + D7l*K13l + D25l*K5l + D37l*K7l - D67l*K5l + D7r*K13r + D25r*K5r + D37r*K7r - D67r*K5r - K18*MY_2 + K16*MZ_2;
X45 = D32l*cos(q_torso) - D32r*cos(q_torso) - XY_3*cos(q_torso) + YZ_3*sin(q_torso) + D14l*K17l + D20l*K21l + D14r*K17r + D20r*K21r - D47l*K13l - D47r*K13r + D54l*K44l + D54r*K44r + D61l*K49l + D75l*K35l + D82l*K38l + D61r*K49r + D75r*K35r + D82r*K38r - D100l*K44l - D100r*K44r - D124l*K35l + D92l*K73l - D124r*K35r + D92r*K73r + D116l*K62l + D108l*K80l + D116r*K62r + D132l*K66l + D108r*K80r + D132r*K66r - D143l*K73l - D143r*K73r - D170l*K62l - D170r*K62r + D152l*K109l + D152r*K109r + D179l*K96l + D161l*K116l + D179r*K96r + D161r*K116r + D188l*K101l + D188r*K101r - D210l*K109l - D210r*K109r - D240l*K96l + D200l*K146l - D240r*K96r + D200r*K146r + D230l*K131l + D230r*K131r + D220l*K155l + D220r*K155r + D250l*K137l + D250r*K137r - D263l*K146l - D263r*K146r - D296l*K131l - D296r*K131r + D274l*K190l + D274r*K190r + D307l*K173l + D285l*K199l + D307r*K173r + D285r*K199r + D318l*K180l + D318r*K180r - D356l*K190l - D356r*K190r - D392l*K173l + D332l*K235l - D392r*K173r + D332r*K235r + D368l*K216l + D344l*K246l + D368r*K216r + D344r*K246r + D380l*K224l + D380r*K224r + D8l*K13l + D26l*K5l + D38l*K7l - D68l*K5l + D8r*K13r + D26r*K5r + D38r*K7r - D68r*K5r + K40*MX_3 - K35*MZ_3;
X46 = D55l*K44l - K7l*YZ_4l - YY_4l*cos(q_torso) - D48l*K13l - K5l*XY_4l + D62l*K49l + D76l*K35l + D83l*K38l - D101l*K44l - D125l*K35l + D93l*K73l + D117l*K62l + D109l*K80l + D133l*K66l - D144l*K73l - D171l*K62l + D153l*K109l + D180l*K96l + D162l*K116l + D189l*K101l - D211l*K109l - D241l*K96l + D201l*K146l + D231l*K131l + D221l*K155l + D251l*K137l - D264l*K146l - D297l*K131l + D275l*K190l + D308l*K173l + D286l*K199l + D319l*K180l - D357l*K190l - D393l*K173l + D333l*K235l + D369l*K216l + D345l*K246l + D381l*K224l - D69l*K5l + K21l*MX_4l - K13l*MZ_4l;
X47 = K5l*XX_5l - K35l*XY_5l - K38l*XZ_5l - D102l*K44l - D126l*K35l + D94l*K73l + D118l*K62l + D110l*K80l + D134l*K66l - D145l*K73l - D172l*K62l + D154l*K109l + D181l*K96l + D163l*K116l + D190l*K101l - D212l*K109l - D242l*K96l + D202l*K146l + D232l*K131l + D222l*K155l + D252l*K137l - D265l*K146l - D298l*K131l + D276l*K190l + D309l*K173l + D287l*K199l + D320l*K180l - D358l*K190l - D394l*K173l + D334l*K235l + D370l*K216l + D346l*K246l + D382l*K224l - K49l*MY_5l + K44l*MZ_5l;
X48 = K35l*YY_6l - K62l*XY_6l - K66l*YZ_6l - D146l*K73l - D173l*K62l + D155l*K109l + D182l*K96l + D164l*K116l + D191l*K101l - D213l*K109l - D243l*K96l + D203l*K146l + D233l*K131l + D223l*K155l + D253l*K137l - D266l*K146l - D299l*K131l + D277l*K190l + D310l*K173l + D288l*K199l + D321l*K180l - D359l*K190l - D395l*K173l + D335l*K235l + D371l*K216l + D347l*K246l + D383l*K224l + K80l*MX_6l - K73l*MZ_6l;
X49 = K62l*XX_7l - K96l*XY_7l - K101l*XZ_7l - D214l*K109l - D244l*K96l + D204l*K146l + D234l*K131l + D224l*K155l + D254l*K137l - D267l*K146l - D300l*K131l + D278l*K190l + D311l*K173l + D289l*K199l + D322l*K180l - D360l*K190l - D396l*K173l + D336l*K235l + D372l*K216l + D348l*K246l + D384l*K224l - K116l*MY_7l + K109l*MZ_7l;
X50 = K96l*YY_8l - K131l*XY_8l - K137l*YZ_8l - D268l*K146l - D301l*K131l + D279l*K190l + D312l*K173l + D290l*K199l + D323l*K180l - D361l*K190l - D397l*K173l + D337l*K235l + D373l*K216l + D349l*K246l + D385l*K224l + K155l*MX_8l - K146l*MZ_8l;
X51 = K131l*XX_9l - K173l*XY_9l - K180l*XZ_9l - D362l*K190l - D398l*K173l + D338l*K235l + D374l*K216l + D350l*K246l + D386l*K224l - K199l*MY_9l + K190l*MZ_9l;
X52 = K173l*ZZ_10l - K224l*YZ_10l - K216l*XZ_10l - K246l*MX_10l + K235l*MY_10l;
X53 = YY_4r*cos(q_torso) - K7r*YZ_4r - K5r*XY_4r - D48r*K13r + D55r*K44r + D62r*K49r + D76r*K35r + D83r*K38r - D101r*K44r - D125r*K35r + D93r*K73r + D117r*K62r + D109r*K80r + D133r*K66r - D144r*K73r - D171r*K62r + D153r*K109r + D180r*K96r + D162r*K116r + D189r*K101r - D211r*K109r - D241r*K96r + D201r*K146r + D231r*K131r + D221r*K155r + D251r*K137r - D264r*K146r - D297r*K131r + D275r*K190r + D308r*K173r + D286r*K199r + D319r*K180r - D357r*K190r - D393r*K173r + D333r*K235r + D369r*K216r + D345r*K246r + D381r*K224r - D69r*K5r + K21r*MX_4r - K13r*MZ_4r;
X54 = K5r*XX_5r - K35r*XY_5r - K38r*XZ_5r - D102r*K44r - D126r*K35r + D94r*K73r + D118r*K62r + D110r*K80r + D134r*K66r - D145r*K73r - D172r*K62r + D154r*K109r + D181r*K96r + D163r*K116r + D190r*K101r - D212r*K109r - D242r*K96r + D202r*K146r + D232r*K131r + D222r*K155r + D252r*K137r - D265r*K146r - D298r*K131r + D276r*K190r + D309r*K173r + D287r*K199r + D320r*K180r - D358r*K190r - D394r*K173r + D334r*K235r + D370r*K216r + D346r*K246r + D382r*K224r - K49r*MY_5r + K44r*MZ_5r;
X55 = K35r*YY_6r - K62r*XY_6r - K66r*YZ_6r - D146r*K73r - D173r*K62r + D155r*K109r + D182r*K96r + D164r*K116r + D191r*K101r - D213r*K109r - D243r*K96r + D203r*K146r + D233r*K131r + D223r*K155r + D253r*K137r - D266r*K146r - D299r*K131r + D277r*K190r + D310r*K173r + D288r*K199r + D321r*K180r - D359r*K190r - D395r*K173r + D335r*K235r + D371r*K216r + D347r*K246r + D383r*K224r + K80r*MX_6r - K73r*MZ_6r;
X56 = K62r*XX_7r - K96r*XY_7r - K101r*XZ_7r - D214r*K109r - D244r*K96r + D204r*K146r + D234r*K131r + D224r*K155r + D254r*K137r - D267r*K146r - D300r*K131r + D278r*K190r + D311r*K173r + D289r*K199r + D322r*K180r - D360r*K190r - D396r*K173r + D336r*K235r + D372r*K216r + D348r*K246r + D384r*K224r - K116r*MY_7r + K109r*MZ_7r;
X57 = K96r*YY_8r - K131r*XY_8r - K137r*YZ_8r - D268r*K146r - D301r*K131r + D279r*K190r + D312r*K173r + D290r*K199r + D323r*K180r - D361r*K190r - D397r*K173r + D337r*K235r + D373r*K216r + D349r*K246r + D385r*K224r + K155r*MX_8r - K146r*MZ_8r;
X58 = K131r*XX_9r - K173r*XY_9r - K180r*XZ_9r - D362r*K190r - D398r*K173r + D338r*K235r + D374r*K216r + D350r*K246r + D386r*K224r - K199r*MY_9r + K190r*MZ_9r;
X59 = K173r*ZZ_10r - K224r*YZ_10r - K216r*XZ_10r - K246r*MX_10r + K235r*MY_10r;
X60 = D68*cos(q_torso) - D37 - D14 + D33l*cos(q_torso) - D33r*cos(q_torso) - D78*sin(q_torso) + D29*K16 + D33*K18 + D53*K35 + D58*K37 + D63*K40 + D15l*K17l + D21l*K21l + D15r*K17r + D21r*K21r - D49l*K13l - D49r*K13r + D56l*K44l + D56r*K44r + D63l*K49l + D77l*K35l + D84l*K38l + D63r*K49r + D77r*K35r + D84r*K38r - D103l*K44l - D103r*K44r - D127l*K35l + D95l*K73l - D127r*K35r + D95r*K73r + D119l*K62l + D111l*K80l + D119r*K62r + D135l*K66l + D111r*K80r + D135r*K66r - D147l*K73l - D147r*K73r - D174l*K62l - D174r*K62r + D156l*K109l + D156r*K109r + D183l*K96l + D165l*K116l + D183r*K96r + D165r*K116r + D192l*K101l + D192r*K101r - D215l*K109l - D215r*K109r - D245l*K96l + D205l*K146l - D245r*K96r + D205r*K146r + D235l*K131l + D235r*K131r + D225l*K155l + D225r*K155r + D255l*K137l + D255r*K137r - D269l*K146l - D269r*K146r - D302l*K131l - D302r*K131r + D280l*K190l + D280r*K190r + D313l*K173l + D291l*K199l + D313r*K173r + D291r*K199r + D324l*K180l + D324r*K180r - D363l*K190l - D363r*K190r - D399l*K173l + D339l*K235l - D399r*K173r + D339r*K235r + D375l*K216l + D351l*K246l + D375r*K216r + D351r*K246r + D387l*K224l + D387r*K224r + D9l*K13l + D27l*K5l + D39l*K7l - D70l*K5l + D9r*K13r + D27r*K5r + D39r*K7r - D70r*K5r;
% LHS_{dq_imu} &= (D328r*K235r - D388r*K173r - D352r*K190r + D364r*K216r + D340r*K246r + D376r*K224r)*ddx + (D329r*K235r - D389r*K173r - D353r*K190r + D365r*K216r + D341r*K246r + D377r*K224r)*ddpsi + (D330r*K235r - D390r*K173r - D354r*K190r + D366r*K216r + D342r*K246r + D378r*K224r)*ddq_imu + (D331r*K235r - D391r*K173r - D355r*K190r + D367r*K216r + D343r*K246r + D379r*K224r)*ddq_w + (D332r*K235r - D392r*K173r - D356r*K190r + D368r*K216r + D344r*K246r + D380r*K224r)*ddq_torso + (D333r*K235r - D393r*K173r - D357r*K190r + D369r*K216r + D345r*K246r + D381r*K224r)*ddq_1r + (D334r*K235r - D394r*K173r - D358r*K190r + D370r*K216r + D346r*K246r + D382r*K224r)*ddq_2r + (D335r*K235r - D395r*K173r - D359r*K190r + D371r*K216r + D347r*K246r + D383r*K224r)*ddq_3r + (D336r*K235r - D396r*K173r - D360r*K190r + D372r*K216r + D348r*K246r + D384r*K224r)*ddq_4r + (D337r*K235r - D397r*K173r - D361r*K190r + D373r*K216r + D349r*K246r + D385r*K224r)*ddq_5r + (D338r*K235r - D398r*K173r - D362r*K190r + D374r*K216r + D350r*K246r + D386r*K224r)*ddq_6r + (K173r*ZZ_10r - K224r*YZ_10r - K216r*XZ_10r - K246r*MX_10r + K235r*MY_10r)*ddq_7r + (D339r*K235r - D399r*K173r - D363r*K190r + D375r*K216r + D351r*K246r + D387r*K224r) 
% \nonumber \\ 
% LHS_{dq_w} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_w} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_w}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+(-D34)*ddx + (-D35)*ddpsi + (-D36)*ddq_imu + XX_2*ddq_w - D37 
% \nonumber \\ 
% &+(D64*cos(q_torso) - D74*sin(q_torso) + D49*K36 + D59*K41 + D54*L4)*ddx + (D65*cos(q_torso) - D75*sin(q_torso) + D50*K36 + D60*K41 + D55*L4)*ddpsi + (D66*cos(q_torso) - D76*sin(q_torso) + D51*K36 + D61*K41 + D56*L4)*ddq_imu + (D67*cos(q_torso) - D77*sin(q_torso) + D52*K36 + D62*K41 + D57*L4)*ddq_w + (YZ_3*sin(q_torso) - XY_3*cos(q_torso) + K41*MX_3 - K36*MZ_3)*ddq_torso + (D68*cos(q_torso) - D78*sin(q_torso) + D53*K36 + D63*K41 + D58*L4) 
% \nonumber \\ 
% &+(D28l*cos(q_torso) + D10l*K18l + D16l*K22l + D4l*K14l + D22l*K5l + D34l*K7l)*ddx + (D29l*cos(q_torso) + D11l*K18l + D17l*K22l + D5l*K14l + D23l*K5l + D35l*K7l)*ddpsi + (D30l*cos(q_torso) + D12l*K18l + D18l*K22l + D6l*K14l + D24l*K5l + D36l*K7l)*ddq_imu + (D31l*cos(q_torso) + D13l*K18l + D19l*K22l + D7l*K14l + D25l*K5l + D37l*K7l)*ddq_w + (D32l*cos(q_torso) + D14l*K18l + D20l*K22l + D8l*K14l + D26l*K5l + D38l*K7l)*ddq_torso + (K22l*MX_4l - K7l*YZ_4l - YY_4l*cos(q_torso) - K5l*XY_4l - K14l*MZ_4l)*ddq_1l + (D33l*cos(q_torso) + D15l*K18l + D21l*K22l + D9l*K14l + D27l*K5l + D39l*K7l) 
% \nonumber \\ 
% &+(D50l*K45l - D43l*K14l + D71l*K35l + D57l*K50l + D78l*K38l - D64l*K5l)*ddx + (D51l*K45l - D44l*K14l + D72l*K35l + D58l*K50l + D79l*K38l - D65l*K5l)*ddpsi + (D52l*K45l - D45l*K14l + D73l*K35l + D59l*K50l + D80l*K38l - D66l*K5l)*ddq_imu + (D53l*K45l - D46l*K14l + D74l*K35l + D60l*K50l + D81l*K38l - D67l*K5l)*ddq_w + (D54l*K45l - D47l*K14l + D75l*K35l + D61l*K50l + D82l*K38l - D68l*K5l)*ddq_torso + (D55l*K45l - D48l*K14l + D76l*K35l + D62l*K50l + D83l*K38l - D69l*K5l)*ddq_1l + (K5l*XX_5l - K35l*XY_5l - K38l*XZ_5l - K50l*MY_5l + K45l*MZ_5l)*ddq_2l + (D56l*K45l - D49l*K14l + D77l*K35l + D63l*K50l + D84l*K38l - D70l*K5l) 
% \nonumber \\ 
% &+(D88l*K74l - D120l*K35l - D96l*K45l + D112l*K62l + D104l*K81l + D128l*K66l)*ddx + (D89l*K74l - D121l*K35l - D97l*K45l + D113l*K62l + D105l*K81l + D129l*K66l)*ddpsi + (D90l*K74l - D122l*K35l - D98l*K45l + D114l*K62l + D106l*K81l + D130l*K66l)*ddq_imu + (D91l*K74l - D123l*K35l - D99l*K45l + D115l*K62l + D107l*K81l + D131l*K66l)*ddq_w + (D92l*K74l - D124l*K35l - D100l*K45l + D116l*K62l + D108l*K81l + D132l*K66l)*ddq_torso + (D93l*K74l - D125l*K35l - D101l*K45l + D117l*K62l + D109l*K81l + D133l*K66l)*ddq_1l + (D94l*K74l - D126l*K35l - D102l*K45l + D118l*K62l + D110l*K81l + D134l*K66l)*ddq_2l + (K35l*YY_6l - K62l*XY_6l - K66l*YZ_6l + K81l*MX_6l - K74l*MZ_6l)*ddq_3l + (D95l*K74l - D127l*K35l - D103l*K45l + D119l*K62l + D111l*K81l + D135l*K66l) 
% \nonumber \\ 
% &+(D148l*K110l - D166l*K62l - D139l*K74l + D175l*K96l + D157l*K117l + D184l*K101l)*ddx + (D149l*K110l - D167l*K62l - D140l*K74l + D176l*K96l + D158l*K117l + D185l*K101l)*ddpsi + (D150l*K110l - D168l*K62l - D141l*K74l + D177l*K96l + D159l*K117l + D186l*K101l)*ddq_imu + (D151l*K110l - D169l*K62l - D142l*K74l + D178l*K96l + D160l*K117l + D187l*K101l)*ddq_w + (D152l*K110l - D170l*K62l - D143l*K74l + D179l*K96l + D161l*K117l + D188l*K101l)*ddq_torso + (D153l*K110l - D171l*K62l - D144l*K74l + D180l*K96l + D162l*K117l + D189l*K101l)*ddq_1l + (D154l*K110l - D172l*K62l - D145l*K74l + D181l*K96l + D163l*K117l + D190l*K101l)*ddq_2l + (D155l*K110l - D173l*K62l - D146l*K74l + D182l*K96l + D164l*K117l + D191l*K101l)*ddq_3l + (K62l*XX_7l - K96l*XY_7l - K101l*XZ_7l - K117l*MY_7l + K110l*MZ_7l)*ddq_4l + (D156l*K110l - D174l*K62l - D147l*K74l + D183l*K96l + D165l*K117l + D192l*K101l) 
% \nonumber \\ 
% &+(D196l*K147l - D236l*K96l - D206l*K110l + D226l*K131l + D216l*K156l + D246l*K137l)*ddx + (D197l*K147l - D237l*K96l - D207l*K110l + D227l*K131l + D217l*K156l + D247l*K137l)*ddpsi + (D198l*K147l - D238l*K96l - D208l*K110l + D228l*K131l + D218l*K156l + D248l*K137l)*ddq_imu + (D199l*K147l - D239l*K96l - D209l*K110l + D229l*K131l + D219l*K156l + D249l*K137l)*ddq_w + (D200l*K147l - D240l*K96l - D210l*K110l + D230l*K131l + D220l*K156l + D250l*K137l)*ddq_torso + (D201l*K147l - D241l*K96l - D211l*K110l + D231l*K131l + D221l*K156l + D251l*K137l)*ddq_1l + (D202l*K147l - D242l*K96l - D212l*K110l + D232l*K131l + D222l*K156l + D252l*K137l)*ddq_2l + (D203l*K147l - D243l*K96l - D213l*K110l + D233l*K131l + D223l*K156l + D253l*K137l)*ddq_3l + (D204l*K147l - D244l*K96l - D214l*K110l + D234l*K131l + D224l*K156l + D254l*K137l)*ddq_4l + (K96l*YY_8l - K131l*XY_8l - K137l*YZ_8l + K156l*MX_8l - K147l*MZ_8l)*ddq_5l + (D205l*K147l - D245l*K96l - D215l*K110l + D235l*K131l + D225l*K156l + D255l*K137l) 
% \nonumber \\ 
% &+(D270l*K191l - D292l*K131l - D259l*K147l + D303l*K173l + D281l*K200l + D314l*K180l)*ddx + (D271l*K191l - D293l*K131l - D260l*K147l + D304l*K173l + D282l*K200l + D315l*K180l)*ddpsi + (D272l*K191l - D294l*K131l - D261l*K147l + D305l*K173l + D283l*K200l + D316l*K180l)*ddq_imu + (D273l*K191l - D295l*K131l - D262l*K147l + D306l*K173l + D284l*K200l + D317l*K180l)*ddq_w + (D274l*K191l - D296l*K131l - D263l*K147l + D307l*K173l + D285l*K200l + D318l*K180l)*ddq_torso + (D275l*K191l - D297l*K131l - D264l*K147l + D308l*K173l + D286l*K200l + D319l*K180l)*ddq_1l + (D276l*K191l - D298l*K131l - D265l*K147l + D309l*K173l + D287l*K200l + D320l*K180l)*ddq_2l + (D277l*K191l - D299l*K131l - D266l*K147l + D310l*K173l + D288l*K200l + D321l*K180l)*ddq_3l + (D278l*K191l - D300l*K131l - D267l*K147l + D311l*K173l + D289l*K200l + D322l*K180l)*ddq_4l + (D279l*K191l - D301l*K131l - D268l*K147l + D312l*K173l + D290l*K200l + D323l*K180l)*ddq_5l + (K131l*XX_9l - K173l*XY_9l - K180l*XZ_9l - K200l*MY_9l + K191l*MZ_9l)*ddq_6l + (D280l*K191l - D302l*K131l - D269l*K147l + D313l*K173l + D291l*K200l + D324l*K180l) 
% \nonumber \\ 
% &+(D328l*K236l - D388l*K173l - D352l*K191l + D364l*K216l + D340l*K247l + D376l*K224l)*ddx + (D329l*K236l - D389l*K173l - D353l*K191l + D365l*K216l + D341l*K247l + D377l*K224l)*ddpsi + (D330l*K236l - D390l*K173l - D354l*K191l + D366l*K216l + D342l*K247l + D378l*K224l)*ddq_imu + (D331l*K236l - D391l*K173l - D355l*K191l + D367l*K216l + D343l*K247l + D379l*K224l)*ddq_w + (D332l*K236l - D392l*K173l - D356l*K191l + D368l*K216l + D344l*K247l + D380l*K224l)*ddq_torso + (D333l*K236l - D393l*K173l - D357l*K191l + D369l*K216l + D345l*K247l + D381l*K224l)*ddq_1l + (D334l*K236l - D394l*K173l - D358l*K191l + D370l*K216l + D346l*K247l + D382l*K224l)*ddq_2l + (D335l*K236l - D395l*K173l - D359l*K191l + D371l*K216l + D347l*K247l + D383l*K224l)*ddq_3l + (D336l*K236l - D396l*K173l - D360l*K191l + D372l*K216l + D348l*K247l + D384l*K224l)*ddq_4l + (D337l*K236l - D397l*K173l - D361l*K191l + D373l*K216l + D349l*K247l + D385l*K224l)*ddq_5l + (D338l*K236l - D398l*K173l - D362l*K191l + D374l*K216l + D350l*K247l + D386l*K224l)*ddq_6l + (K173l*ZZ_10l - K224l*YZ_10l - K216l*XZ_10l - K247l*MX_10l + K236l*MY_10l)*ddq_7l + (D339l*K236l - D399l*K173l - D363l*K191l + D375l*K216l + D351l*K247l + D387l*K224l) 
% \nonumber \\ 
% &+(D10r*K18r - D28r*cos(q_torso) + D16r*K22r + D4r*K14r + D22r*K5r + D34r*K7r)*ddx + (D11r*K18r - D29r*cos(q_torso) + D17r*K22r + D5r*K14r + D23r*K5r + D35r*K7r)*ddpsi + (D12r*K18r - D30r*cos(q_torso) + D18r*K22r + D6r*K14r + D24r*K5r + D36r*K7r)*ddq_imu + (D13r*K18r - D31r*cos(q_torso) + D19r*K22r + D7r*K14r + D25r*K5r + D37r*K7r)*ddq_w + (D14r*K18r - D32r*cos(q_torso) + D20r*K22r + D8r*K14r + D26r*K5r + D38r*K7r)*ddq_torso + (YY_4r*cos(q_torso) - K7r*YZ_4r - K5r*XY_4r + K22r*MX_4r - K14r*MZ_4r)*ddq_1r + (D15r*K18r - D33r*cos(q_torso) + D21r*K22r + D9r*K14r + D27r*K5r + D39r*K7r) 
% \nonumber \\ 
% &+(D50r*K45r - D43r*K14r + D71r*K35r + D57r*K50r + D78r*K38r - D64r*K5r)*ddx + (D51r*K45r - D44r*K14r + D72r*K35r + D58r*K50r + D79r*K38r - D65r*K5r)*ddpsi + (D52r*K45r - D45r*K14r + D73r*K35r + D59r*K50r + D80r*K38r - D66r*K5r)*ddq_imu + (D53r*K45r - D46r*K14r + D74r*K35r + D60r*K50r + D81r*K38r - D67r*K5r)*ddq_w + (D54r*K45r - D47r*K14r + D75r*K35r + D61r*K50r + D82r*K38r - D68r*K5r)*ddq_torso + (D55r*K45r - D48r*K14r + D76r*K35r + D62r*K50r + D83r*K38r - D69r*K5r)*ddq_1r + (K5r*XX_5r - K35r*XY_5r - K38r*XZ_5r - K50r*MY_5r + K45r*MZ_5r)*ddq_2r + (D56r*K45r - D49r*K14r + D77r*K35r + D63r*K50r + D84r*K38r - D70r*K5r) 
% \nonumber \\ 
% &+(D88r*K74r - D120r*K35r - D96r*K45r + D112r*K62r + D104r*K81r + D128r*K66r)*ddx + (D89r*K74r - D121r*K35r - D97r*K45r + D113r*K62r + D105r*K81r + D129r*K66r)*ddpsi + (D90r*K74r - D122r*K35r - D98r*K45r + D114r*K62r + D106r*K81r + D130r*K66r)*ddq_imu + (D91r*K74r - D123r*K35r - D99r*K45r + D115r*K62r + D107r*K81r + D131r*K66r)*ddq_w + (D92r*K74r - D124r*K35r - D100r*K45r + D116r*K62r + D108r*K81r + D132r*K66r)*ddq_torso + (D93r*K74r - D125r*K35r - D101r*K45r + D117r*K62r + D109r*K81r + D133r*K66r)*ddq_1r + (D94r*K74r - D126r*K35r - D102r*K45r + D118r*K62r + D110r*K81r + D134r*K66r)*ddq_2r + (K35r*YY_6r - K62r*XY_6r - K66r*YZ_6r + K81r*MX_6r - K74r*MZ_6r)*ddq_3r + (D95r*K74r - D127r*K35r - D103r*K45r + D119r*K62r + D111r*K81r + D135r*K66r) 
% \nonumber \\ 
% &+(D148r*K110r - D166r*K62r - D139r*K74r + D175r*K96r + D157r*K117r + D184r*K101r)*ddx + (D149r*K110r - D167r*K62r - D140r*K74r + D176r*K96r + D158r*K117r + D185r*K101r)*ddpsi + (D150r*K110r - D168r*K62r - D141r*K74r + D177r*K96r + D159r*K117r + D186r*K101r)*ddq_imu + (D151r*K110r - D169r*K62r - D142r*K74r + D178r*K96r + D160r*K117r + D187r*K101r)*ddq_w + (D152r*K110r - D170r*K62r - D143r*K74r + D179r*K96r + D161r*K117r + D188r*K101r)*ddq_torso + (D153r*K110r - D171r*K62r - D144r*K74r + D180r*K96r + D162r*K117r + D189r*K101r)*ddq_1r + (D154r*K110r - D172r*K62r - D145r*K74r + D181r*K96r + D163r*K117r + D190r*K101r)*ddq_2r + (D155r*K110r - D173r*K62r - D146r*K74r + D182r*K96r + D164r*K117r + D191r*K101r)*ddq_3r + (K62r*XX_7r - K96r*XY_7r - K101r*XZ_7r - K117r*MY_7r + K110r*MZ_7r)*ddq_4r + (D156r*K110r - D174r*K62r - D147r*K74r + D183r*K96r + D165r*K117r + D192r*K101r) 
% \nonumber \\ 
% &+(D196r*K147r - D236r*K96r - D206r*K110r + D226r*K131r + D216r*K156r + D246r*K137r)*ddx + (D197r*K147r - D237r*K96r - D207r*K110r + D227r*K131r + D217r*K156r + D247r*K137r)*ddpsi + (D198r*K147r - D238r*K96r - D208r*K110r + D228r*K131r + D218r*K156r + D248r*K137r)*ddq_imu + (D199r*K147r - D239r*K96r - D209r*K110r + D229r*K131r + D219r*K156r + D249r*K137r)*ddq_w + (D200r*K147r - D240r*K96r - D210r*K110r + D230r*K131r + D220r*K156r + D250r*K137r)*ddq_torso + (D201r*K147r - D241r*K96r - D211r*K110r + D231r*K131r + D221r*K156r + D251r*K137r)*ddq_1r + (D202r*K147r - D242r*K96r - D212r*K110r + D232r*K131r + D222r*K156r + D252r*K137r)*ddq_2r + (D203r*K147r - D243r*K96r - D213r*K110r + D233r*K131r + D223r*K156r + D253r*K137r)*ddq_3r + (D204r*K147r - D244r*K96r - D214r*K110r + D234r*K131r + D224r*K156r + D254r*K137r)*ddq_4r + (K96r*YY_8r - K131r*XY_8r - K137r*YZ_8r + K156r*MX_8r - K147r*MZ_8r)*ddq_5r + (D205r*K147r - D245r*K96r - D215r*K110r + D235r*K131r + D225r*K156r + D255r*K137r) 
% \nonumber \\ 
% &+(D270r*K191r - D292r*K131r - D259r*K147r + D303r*K173r + D281r*K200r + D314r*K180r)*ddx + (D271r*K191r - D293r*K131r - D260r*K147r + D304r*K173r + D282r*K200r + D315r*K180r)*ddpsi + (D272r*K191r - D294r*K131r - D261r*K147r + D305r*K173r + D283r*K200r + D316r*K180r)*ddq_imu + (D273r*K191r - D295r*K131r - D262r*K147r + D306r*K173r + D284r*K200r + D317r*K180r)*ddq_w + (D274r*K191r - D296r*K131r - D263r*K147r + D307r*K173r + D285r*K200r + D318r*K180r)*ddq_torso + (D275r*K191r - D297r*K131r - D264r*K147r + D308r*K173r + D286r*K200r + D319r*K180r)*ddq_1r + (D276r*K191r - D298r*K131r - D265r*K147r + D309r*K173r + D287r*K200r + D320r*K180r)*ddq_2r + (D277r*K191r - D299r*K131r - D266r*K147r + D310r*K173r + D288r*K200r + D321r*K180r)*ddq_3r + (D278r*K191r - D300r*K131r - D267r*K147r + D311r*K173r + D289r*K200r + D322r*K180r)*ddq_4r + (D279r*K191r - D301r*K131r - D268r*K147r + D312r*K173r + D290r*K200r + D323r*K180r)*ddq_5r + (K131r*XX_9r - K173r*XY_9r - K180r*XZ_9r - K200r*MY_9r + K191r*MZ_9r)*ddq_6r + (D280r*K191r - D302r*K131r - D269r*K147r + D313r*K173r + D291r*K200r + D324r*K180r) 
% \nonumber \\ 
% &+(D328r*K236r - D388r*K173r - D352r*K191r + D364r*K216r + D340r*K247r + D376r*K224r)*ddx + (D329r*K236r - D389r*K173r - D353r*K191r + D365r*K216r + D341r*K247r + D377r*K224r)*ddpsi + (D330r*K236r - D390r*K173r - D354r*K191r + D366r*K216r + D342r*K247r + D378r*K224r)*ddq_imu + (D331r*K236r - D391r*K173r - D355r*K191r + D367r*K216r + D343r*K247r + D379r*K224r)*ddq_w + (D332r*K236r - D392r*K173r - D356r*K191r + D368r*K216r + D344r*K247r + D380r*K224r)*ddq_torso + (D333r*K236r - D393r*K173r - D357r*K191r + D369r*K216r + D345r*K247r + D381r*K224r)*ddq_1r + (D334r*K236r - D394r*K173r - D358r*K191r + D370r*K216r + D346r*K247r + D382r*K224r)*ddq_2r + (D335r*K236r - D395r*K173r - D359r*K191r + D371r*K216r + D347r*K247r + D383r*K224r)*ddq_3r + (D336r*K236r - D396r*K173r - D360r*K191r + D372r*K216r + D348r*K247r + D384r*K224r)*ddq_4r + (D337r*K236r - D397r*K173r - D361r*K191r + D373r*K216r + D349r*K247r + D385r*K224r)*ddq_5r + (D338r*K236r - D398r*K173r - D362r*K191r + D374r*K216r + D350r*K247r + D386r*K224r)*ddq_6r + (K173r*ZZ_10r - K224r*YZ_10r - K216r*XZ_10r - K247r*MX_10r + K236r*MY_10r)*ddq_7r + (D339r*K236r - D399r*K173r - D363r*K191r + D375r*K216r + D351r*K247r + D387r*K224r) 
% \nonumber \\ 
X61 = D64*cos(q_torso) - D34 + D28l*cos(q_torso) - D28r*cos(q_torso) - D74*sin(q_torso) + D49*K36 + D59*K41 + D10l*K18l + D16l*K22l + D10r*K18r + D16r*K22r - D43l*K14l - D43r*K14r + D50l*K45l + D71l*K35l + D50r*K45r + D57l*K50l + D78l*K38l + D71r*K35r + D57r*K50r + D78r*K38r - D96l*K45l - D96r*K45r - D120l*K35l + D88l*K74l - D120r*K35r + D88r*K74r + D112l*K62l + D104l*K81l + D112r*K62r + D128l*K66l + D104r*K81r + D128r*K66r - D139l*K74l - D139r*K74r - D166l*K62l - D166r*K62r + D148l*K110l + D148r*K110r + D175l*K96l + D157l*K117l + D175r*K96r + D184l*K101l + D157r*K117r + D184r*K101r - D206l*K110l - D206r*K110r - D236l*K96l + D196l*K147l - D236r*K96r + D196r*K147r + D226l*K131l + D226r*K131r + D216l*K156l + D246l*K137l + D216r*K156r + D246r*K137r - D259l*K147l - D259r*K147r - D292l*K131l - D292r*K131r + D270l*K191l + D270r*K191r + D303l*K173l + D281l*K200l + D303r*K173r + D281r*K200r + D314l*K180l + D314r*K180r - D352l*K191l - D352r*K191r - D388l*K173l + D328l*K236l - D388r*K173r + D328r*K236r + D364l*K216l + D340l*K247l + D364r*K216r + D340r*K247r + D376l*K224l + D376r*K224r + D4l*K14l + D22l*K5l + D34l*K7l - D64l*K5l + D4r*K14r + D22r*K5r + D34r*K7r - D64r*K5r + D54*L4;
X62 = D65*cos(q_torso) - D35 + D29l*cos(q_torso) - D29r*cos(q_torso) - D75*sin(q_torso) + D50*K36 + D60*K41 + D11l*K18l + D17l*K22l + D11r*K18r + D17r*K22r - D44l*K14l - D44r*K14r + D51l*K45l + D72l*K35l + D51r*K45r + D58l*K50l + D79l*K38l + D72r*K35r + D58r*K50r + D79r*K38r - D97l*K45l - D97r*K45r - D121l*K35l + D89l*K74l - D121r*K35r + D89r*K74r + D113l*K62l + D105l*K81l + D113r*K62r + D129l*K66l + D105r*K81r + D129r*K66r - D140l*K74l - D140r*K74r - D167l*K62l - D167r*K62r + D149l*K110l + D149r*K110r + D176l*K96l + D158l*K117l + D176r*K96r + D185l*K101l + D158r*K117r + D185r*K101r - D207l*K110l - D207r*K110r - D237l*K96l + D197l*K147l - D237r*K96r + D197r*K147r + D227l*K131l + D227r*K131r + D217l*K156l + D247l*K137l + D217r*K156r + D247r*K137r - D260l*K147l - D260r*K147r - D293l*K131l - D293r*K131r + D271l*K191l + D271r*K191r + D304l*K173l + D282l*K200l + D304r*K173r + D282r*K200r + D315l*K180l + D315r*K180r - D353l*K191l - D353r*K191r - D389l*K173l + D329l*K236l - D389r*K173r + D329r*K236r + D365l*K216l + D341l*K247l + D365r*K216r + D341r*K247r + D377l*K224l + D377r*K224r + D5l*K14l + D23l*K5l + D35l*K7l - D65l*K5l + D5r*K14r + D23r*K5r + D35r*K7r - D65r*K5r + D55*L4;
X63 = D66*cos(q_torso) - D36 + D30l*cos(q_torso) - D30r*cos(q_torso) - D76*sin(q_torso) + D51*K36 + D61*K41 + D12l*K18l + D18l*K22l + D12r*K18r + D18r*K22r - D45l*K14l - D45r*K14r + D52l*K45l + D73l*K35l + D52r*K45r + D59l*K50l + D80l*K38l + D73r*K35r + D59r*K50r + D80r*K38r - D98l*K45l - D98r*K45r - D122l*K35l + D90l*K74l - D122r*K35r + D90r*K74r + D114l*K62l + D106l*K81l + D114r*K62r + D130l*K66l + D106r*K81r + D130r*K66r - D141l*K74l - D141r*K74r - D168l*K62l - D168r*K62r + D150l*K110l + D150r*K110r + D177l*K96l + D159l*K117l + D177r*K96r + D186l*K101l + D159r*K117r + D186r*K101r - D208l*K110l - D208r*K110r - D238l*K96l + D198l*K147l - D238r*K96r + D198r*K147r + D228l*K131l + D228r*K131r + D218l*K156l + D248l*K137l + D218r*K156r + D248r*K137r - D261l*K147l - D261r*K147r - D294l*K131l - D294r*K131r + D272l*K191l + D272r*K191r + D305l*K173l + D283l*K200l + D305r*K173r + D283r*K200r + D316l*K180l + D316r*K180r - D354l*K191l - D354r*K191r - D390l*K173l + D330l*K236l - D390r*K173r + D330r*K236r + D366l*K216l + D342l*K247l + D366r*K216r + D342r*K247r + D378l*K224l + D378r*K224r + D6l*K14l + D24l*K5l + D36l*K7l - D66l*K5l + D6r*K14r + D24r*K5r + D36r*K7r - D66r*K5r + D56*L4;
X64 = XX_2 + D67*cos(q_torso) + D31l*cos(q_torso) - D31r*cos(q_torso) - D77*sin(q_torso) + D52*K36 + D62*K41 + D13l*K18l + D19l*K22l + D13r*K18r + D19r*K22r - D46l*K14l - D46r*K14r + D53l*K45l + D74l*K35l + D53r*K45r + D60l*K50l + D81l*K38l + D74r*K35r + D60r*K50r + D81r*K38r - D99l*K45l - D99r*K45r - D123l*K35l + D91l*K74l - D123r*K35r + D91r*K74r + D115l*K62l + D107l*K81l + D115r*K62r + D131l*K66l + D107r*K81r + D131r*K66r - D142l*K74l - D142r*K74r - D169l*K62l - D169r*K62r + D151l*K110l + D151r*K110r + D178l*K96l + D160l*K117l + D178r*K96r + D187l*K101l + D160r*K117r + D187r*K101r - D209l*K110l - D209r*K110r - D239l*K96l + D199l*K147l - D239r*K96r + D199r*K147r + D229l*K131l + D229r*K131r + D219l*K156l + D249l*K137l + D219r*K156r + D249r*K137r - D262l*K147l - D262r*K147r - D295l*K131l - D295r*K131r + D273l*K191l + D273r*K191r + D306l*K173l + D284l*K200l + D306r*K173r + D284r*K200r + D317l*K180l + D317r*K180r - D355l*K191l - D355r*K191r - D391l*K173l + D331l*K236l - D391r*K173r + D331r*K236r + D367l*K216l + D343l*K247l + D367r*K216r + D343r*K247r + D379l*K224l + D379r*K224r + D7l*K14l + D25l*K5l + D37l*K7l - D67l*K5l + D7r*K14r + D25r*K5r + D37r*K7r - D67r*K5r + D57*L4;
X65 = D32l*cos(q_torso) - D32r*cos(q_torso) - XY_3*cos(q_torso) + YZ_3*sin(q_torso) + D14l*K18l + D20l*K22l + D14r*K18r + D20r*K22r - D47l*K14l - D47r*K14r + D54l*K45l + D75l*K35l + D54r*K45r + D61l*K50l + D82l*K38l + D75r*K35r + D61r*K50r + D82r*K38r - D100l*K45l - D100r*K45r - D124l*K35l + D92l*K74l - D124r*K35r + D92r*K74r + D116l*K62l + D108l*K81l + D116r*K62r + D132l*K66l + D108r*K81r + D132r*K66r - D143l*K74l - D143r*K74r - D170l*K62l - D170r*K62r + D152l*K110l + D152r*K110r + D179l*K96l + D161l*K117l + D179r*K96r + D188l*K101l + D161r*K117r + D188r*K101r - D210l*K110l - D210r*K110r - D240l*K96l + D200l*K147l - D240r*K96r + D200r*K147r + D230l*K131l + D230r*K131r + D220l*K156l + D250l*K137l + D220r*K156r + D250r*K137r - D263l*K147l - D263r*K147r - D296l*K131l - D296r*K131r + D274l*K191l + D274r*K191r + D307l*K173l + D285l*K200l + D307r*K173r + D285r*K200r + D318l*K180l + D318r*K180r - D356l*K191l - D356r*K191r - D392l*K173l + D332l*K236l - D392r*K173r + D332r*K236r + D368l*K216l + D344l*K247l + D368r*K216r + D344r*K247r + D380l*K224l + D380r*K224r + D8l*K14l + D26l*K5l + D38l*K7l - D68l*K5l + D8r*K14r + D26r*K5r + D38r*K7r - D68r*K5r + K41*MX_3 - K36*MZ_3;
X66 = D55l*K45l - K7l*YZ_4l - YY_4l*cos(q_torso) - D48l*K14l - K5l*XY_4l + D76l*K35l + D62l*K50l + D83l*K38l - D101l*K45l - D125l*K35l + D93l*K74l + D117l*K62l + D109l*K81l + D133l*K66l - D144l*K74l - D171l*K62l + D153l*K110l + D180l*K96l + D162l*K117l + D189l*K101l - D211l*K110l - D241l*K96l + D201l*K147l + D231l*K131l + D221l*K156l + D251l*K137l - D264l*K147l - D297l*K131l + D275l*K191l + D308l*K173l + D286l*K200l + D319l*K180l - D357l*K191l - D393l*K173l + D333l*K236l + D369l*K216l + D345l*K247l + D381l*K224l - D69l*K5l + K22l*MX_4l - K14l*MZ_4l;
X67 = K5l*XX_5l - K35l*XY_5l - K38l*XZ_5l - D102l*K45l - D126l*K35l + D94l*K74l + D118l*K62l + D110l*K81l + D134l*K66l - D145l*K74l - D172l*K62l + D154l*K110l + D181l*K96l + D163l*K117l + D190l*K101l - D212l*K110l - D242l*K96l + D202l*K147l + D232l*K131l + D222l*K156l + D252l*K137l - D265l*K147l - D298l*K131l + D276l*K191l + D309l*K173l + D287l*K200l + D320l*K180l - D358l*K191l - D394l*K173l + D334l*K236l + D370l*K216l + D346l*K247l + D382l*K224l - K50l*MY_5l + K45l*MZ_5l;
X68 = K35l*YY_6l - K62l*XY_6l - K66l*YZ_6l - D146l*K74l - D173l*K62l + D155l*K110l + D182l*K96l + D164l*K117l + D191l*K101l - D213l*K110l - D243l*K96l + D203l*K147l + D233l*K131l + D223l*K156l + D253l*K137l - D266l*K147l - D299l*K131l + D277l*K191l + D310l*K173l + D288l*K200l + D321l*K180l - D359l*K191l - D395l*K173l + D335l*K236l + D371l*K216l + D347l*K247l + D383l*K224l + K81l*MX_6l - K74l*MZ_6l;
X69 = K62l*XX_7l - K96l*XY_7l - K101l*XZ_7l - D214l*K110l - D244l*K96l + D204l*K147l + D234l*K131l + D224l*K156l + D254l*K137l - D267l*K147l - D300l*K131l + D278l*K191l + D311l*K173l + D289l*K200l + D322l*K180l - D360l*K191l - D396l*K173l + D336l*K236l + D372l*K216l + D348l*K247l + D384l*K224l - K117l*MY_7l + K110l*MZ_7l;
X70 = K96l*YY_8l - K131l*XY_8l - K137l*YZ_8l - D268l*K147l - D301l*K131l + D279l*K191l + D312l*K173l + D290l*K200l + D323l*K180l - D361l*K191l - D397l*K173l + D337l*K236l + D373l*K216l + D349l*K247l + D385l*K224l + K156l*MX_8l - K147l*MZ_8l;
X71 = K131l*XX_9l - K173l*XY_9l - K180l*XZ_9l - D362l*K191l - D398l*K173l + D338l*K236l + D374l*K216l + D350l*K247l + D386l*K224l - K200l*MY_9l + K191l*MZ_9l;
X72 = K173l*ZZ_10l - K224l*YZ_10l - K216l*XZ_10l - K247l*MX_10l + K236l*MY_10l;
X73 = YY_4r*cos(q_torso) - K7r*YZ_4r - K5r*XY_4r - D48r*K14r + D55r*K45r + D76r*K35r + D62r*K50r + D83r*K38r - D101r*K45r - D125r*K35r + D93r*K74r + D117r*K62r + D109r*K81r + D133r*K66r - D144r*K74r - D171r*K62r + D153r*K110r + D180r*K96r + D162r*K117r + D189r*K101r - D211r*K110r - D241r*K96r + D201r*K147r + D231r*K131r + D221r*K156r + D251r*K137r - D264r*K147r - D297r*K131r + D275r*K191r + D308r*K173r + D286r*K200r + D319r*K180r - D357r*K191r - D393r*K173r + D333r*K236r + D369r*K216r + D345r*K247r + D381r*K224r - D69r*K5r + K22r*MX_4r - K14r*MZ_4r;
X74 = K5r*XX_5r - K35r*XY_5r - K38r*XZ_5r - D102r*K45r - D126r*K35r + D94r*K74r + D118r*K62r + D110r*K81r + D134r*K66r - D145r*K74r - D172r*K62r + D154r*K110r + D181r*K96r + D163r*K117r + D190r*K101r - D212r*K110r - D242r*K96r + D202r*K147r + D232r*K131r + D222r*K156r + D252r*K137r - D265r*K147r - D298r*K131r + D276r*K191r + D309r*K173r + D287r*K200r + D320r*K180r - D358r*K191r - D394r*K173r + D334r*K236r + D370r*K216r + D346r*K247r + D382r*K224r - K50r*MY_5r + K45r*MZ_5r;
X75 = K35r*YY_6r - K62r*XY_6r - K66r*YZ_6r - D146r*K74r - D173r*K62r + D155r*K110r + D182r*K96r + D164r*K117r + D191r*K101r - D213r*K110r - D243r*K96r + D203r*K147r + D233r*K131r + D223r*K156r + D253r*K137r - D266r*K147r - D299r*K131r + D277r*K191r + D310r*K173r + D288r*K200r + D321r*K180r - D359r*K191r - D395r*K173r + D335r*K236r + D371r*K216r + D347r*K247r + D383r*K224r + K81r*MX_6r - K74r*MZ_6r;
X76 = K62r*XX_7r - K96r*XY_7r - K101r*XZ_7r - D214r*K110r - D244r*K96r + D204r*K147r + D234r*K131r + D224r*K156r + D254r*K137r - D267r*K147r - D300r*K131r + D278r*K191r + D311r*K173r + D289r*K200r + D322r*K180r - D360r*K191r - D396r*K173r + D336r*K236r + D372r*K216r + D348r*K247r + D384r*K224r - K117r*MY_7r + K110r*MZ_7r;
X77 = K96r*YY_8r - K131r*XY_8r - K137r*YZ_8r - D268r*K147r - D301r*K131r + D279r*K191r + D312r*K173r + D290r*K200r + D323r*K180r - D361r*K191r - D397r*K173r + D337r*K236r + D373r*K216r + D349r*K247r + D385r*K224r + K156r*MX_8r - K147r*MZ_8r;
X78 = K131r*XX_9r - K173r*XY_9r - K180r*XZ_9r - D362r*K191r - D398r*K173r + D338r*K236r + D374r*K216r + D350r*K247r + D386r*K224r - K200r*MY_9r + K191r*MZ_9r;
X79 = K173r*ZZ_10r - K224r*YZ_10r - K216r*XZ_10r - K247r*MX_10r + K236r*MY_10r;
X80 = D68*cos(q_torso) - D37 + D33l*cos(q_torso) - D33r*cos(q_torso) - D78*sin(q_torso) + D53*K36 + D63*K41 + D15l*K18l + D21l*K22l + D15r*K18r + D21r*K22r - D49l*K14l - D49r*K14r + D56l*K45l + D77l*K35l + D56r*K45r + D63l*K50l + D84l*K38l + D77r*K35r + D63r*K50r + D84r*K38r - D103l*K45l - D103r*K45r - D127l*K35l + D95l*K74l - D127r*K35r + D95r*K74r + D119l*K62l + D111l*K81l + D119r*K62r + D135l*K66l + D111r*K81r + D135r*K66r - D147l*K74l - D147r*K74r - D174l*K62l - D174r*K62r + D156l*K110l + D156r*K110r + D183l*K96l + D165l*K117l + D183r*K96r + D192l*K101l + D165r*K117r + D192r*K101r - D215l*K110l - D215r*K110r - D245l*K96l + D205l*K147l - D245r*K96r + D205r*K147r + D235l*K131l + D235r*K131r + D225l*K156l + D255l*K137l + D225r*K156r + D255r*K137r - D269l*K147l - D269r*K147r - D302l*K131l - D302r*K131r + D280l*K191l + D280r*K191r + D313l*K173l + D291l*K200l + D313r*K173r + D291r*K200r + D324l*K180l + D324r*K180r - D363l*K191l - D363r*K191r - D399l*K173l + D339l*K236l - D399r*K173r + D339r*K236r + D375l*K216l + D351l*K247l + D375r*K216r + D351r*K247r + D387l*K224l + D387r*K224r + D9l*K14l + D27l*K5l + D39l*K7l - D70l*K5l + D9r*K14r + D27r*K5r + D39r*K7r - D70r*K5r + D58*L4;
% LHS_{dq_w} &= (D328r*K236r - D388r*K173r - D352r*K191r + D364r*K216r + D340r*K247r + D376r*K224r)*ddx + (D329r*K236r - D389r*K173r - D353r*K191r + D365r*K216r + D341r*K247r + D377r*K224r)*ddpsi + (D330r*K236r - D390r*K173r - D354r*K191r + D366r*K216r + D342r*K247r + D378r*K224r)*ddq_imu + (D331r*K236r - D391r*K173r - D355r*K191r + D367r*K216r + D343r*K247r + D379r*K224r)*ddq_w + (D332r*K236r - D392r*K173r - D356r*K191r + D368r*K216r + D344r*K247r + D380r*K224r)*ddq_torso + (D333r*K236r - D393r*K173r - D357r*K191r + D369r*K216r + D345r*K247r + D381r*K224r)*ddq_1r + (D334r*K236r - D394r*K173r - D358r*K191r + D370r*K216r + D346r*K247r + D382r*K224r)*ddq_2r + (D335r*K236r - D395r*K173r - D359r*K191r + D371r*K216r + D347r*K247r + D383r*K224r)*ddq_3r + (D336r*K236r - D396r*K173r - D360r*K191r + D372r*K216r + D348r*K247r + D384r*K224r)*ddq_4r + (D337r*K236r - D397r*K173r - D361r*K191r + D373r*K216r + D349r*K247r + D385r*K224r)*ddq_5r + (D338r*K236r - D398r*K173r - D362r*K191r + D374r*K216r + D350r*K247r + D386r*K224r)*ddq_6r + (K173r*ZZ_10r - K224r*YZ_10r - K216r*XZ_10r - K247r*MX_10r + K236r*MY_10r)*ddq_7r + (D339r*K236r - D399r*K173r - D363r*K191r + D375r*K216r + D351r*K247r + D387r*K224r) 
% \nonumber \\ 
% LHS_{dq_torso} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_torso} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_torso}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D69)*ddx + (-D70)*ddpsi + (-D71)*ddq_imu + (-D72)*ddq_w + YY_3*ddq_torso - D73 
% \nonumber \\ 
% &+(D34l*sin(q_1l) - D22l*cos(q_1l) + D16l*K23l + D4l*K15l)*ddx + (D35l*sin(q_1l) - D23l*cos(q_1l) + D17l*K23l + D5l*K15l)*ddpsi + (D36l*sin(q_1l) - D24l*cos(q_1l) + D18l*K23l + D6l*K15l)*ddq_imu + (D37l*sin(q_1l) - D25l*cos(q_1l) + D19l*K23l + D7l*K15l)*ddq_w + (D38l*sin(q_1l) - D26l*cos(q_1l) + D20l*K23l + D8l*K15l)*ddq_torso + (XY_4l*cos(q_1l) - YZ_4l*sin(q_1l) + K23l*MX_4l - K15l*MZ_4l)*ddq_1l + (D39l*sin(q_1l) - D27l*cos(q_1l) + D21l*K23l + D9l*K15l) 
% \nonumber \\ 
% &+(D64l*cos(q_1l) - D43l*K15l + D50l*K46l + D71l*K36l + D57l*K51l + D78l*K39l)*ddx + (D65l*cos(q_1l) - D44l*K15l + D51l*K46l + D72l*K36l + D58l*K51l + D79l*K39l)*ddpsi + (D66l*cos(q_1l) - D45l*K15l + D52l*K46l + D73l*K36l + D59l*K51l + D80l*K39l)*ddq_imu + (D67l*cos(q_1l) - D46l*K15l + D53l*K46l + D74l*K36l + D60l*K51l + D81l*K39l)*ddq_w + (D68l*cos(q_1l) - D47l*K15l + D54l*K46l + D75l*K36l + D61l*K51l + D82l*K39l)*ddq_torso + (D69l*cos(q_1l) - D48l*K15l + D55l*K46l + D76l*K36l + D62l*K51l + D83l*K39l)*ddq_1l + (K46l*MZ_5l - K39l*XZ_5l - XX_5l*cos(q_1l) - K51l*MY_5l - K36l*XY_5l)*ddq_2l + (D70l*cos(q_1l) - D49l*K15l + D56l*K46l + D77l*K36l + D63l*K51l + D84l*K39l) 
% \nonumber \\ 
% &+(D88l*K75l - D120l*K36l - D96l*K46l + D112l*K63l + D104l*K82l + D128l*K67l)*ddx + (D89l*K75l - D121l*K36l - D97l*K46l + D113l*K63l + D105l*K82l + D129l*K67l)*ddpsi + (D90l*K75l - D122l*K36l - D98l*K46l + D114l*K63l + D106l*K82l + D130l*K67l)*ddq_imu + (D91l*K75l - D123l*K36l - D99l*K46l + D115l*K63l + D107l*K82l + D131l*K67l)*ddq_w + (D92l*K75l - D124l*K36l - D100l*K46l + D116l*K63l + D108l*K82l + D132l*K67l)*ddq_torso + (D93l*K75l - D125l*K36l - D101l*K46l + D117l*K63l + D109l*K82l + D133l*K67l)*ddq_1l + (D94l*K75l - D126l*K36l - D102l*K46l + D118l*K63l + D110l*K82l + D134l*K67l)*ddq_2l + (K36l*YY_6l - K63l*XY_6l - K67l*YZ_6l + K82l*MX_6l - K75l*MZ_6l)*ddq_3l + (D95l*K75l - D127l*K36l - D103l*K46l + D119l*K63l + D111l*K82l + D135l*K67l) 
% \nonumber \\ 
% &+(D148l*K111l - D166l*K63l - D139l*K75l + D175l*K97l + D157l*K118l + D184l*K102l)*ddx + (D149l*K111l - D167l*K63l - D140l*K75l + D176l*K97l + D158l*K118l + D185l*K102l)*ddpsi + (D150l*K111l - D168l*K63l - D141l*K75l + D177l*K97l + D159l*K118l + D186l*K102l)*ddq_imu + (D151l*K111l - D169l*K63l - D142l*K75l + D178l*K97l + D160l*K118l + D187l*K102l)*ddq_w + (D152l*K111l - D170l*K63l - D143l*K75l + D179l*K97l + D161l*K118l + D188l*K102l)*ddq_torso + (D153l*K111l - D171l*K63l - D144l*K75l + D180l*K97l + D162l*K118l + D189l*K102l)*ddq_1l + (D154l*K111l - D172l*K63l - D145l*K75l + D181l*K97l + D163l*K118l + D190l*K102l)*ddq_2l + (D155l*K111l - D173l*K63l - D146l*K75l + D182l*K97l + D164l*K118l + D191l*K102l)*ddq_3l + (K63l*XX_7l - K97l*XY_7l - K102l*XZ_7l - K118l*MY_7l + K111l*MZ_7l)*ddq_4l + (D156l*K111l - D174l*K63l - D147l*K75l + D183l*K97l + D165l*K118l + D192l*K102l) 
% \nonumber \\ 
% &+(D196l*K148l - D236l*K97l - D206l*K111l + D226l*K132l + D216l*K157l + D246l*K138l)*ddx + (D197l*K148l - D237l*K97l - D207l*K111l + D227l*K132l + D217l*K157l + D247l*K138l)*ddpsi + (D198l*K148l - D238l*K97l - D208l*K111l + D228l*K132l + D218l*K157l + D248l*K138l)*ddq_imu + (D199l*K148l - D239l*K97l - D209l*K111l + D229l*K132l + D219l*K157l + D249l*K138l)*ddq_w + (D200l*K148l - D240l*K97l - D210l*K111l + D230l*K132l + D220l*K157l + D250l*K138l)*ddq_torso + (D201l*K148l - D241l*K97l - D211l*K111l + D231l*K132l + D221l*K157l + D251l*K138l)*ddq_1l + (D202l*K148l - D242l*K97l - D212l*K111l + D232l*K132l + D222l*K157l + D252l*K138l)*ddq_2l + (D203l*K148l - D243l*K97l - D213l*K111l + D233l*K132l + D223l*K157l + D253l*K138l)*ddq_3l + (D204l*K148l - D244l*K97l - D214l*K111l + D234l*K132l + D224l*K157l + D254l*K138l)*ddq_4l + (K97l*YY_8l - K132l*XY_8l - K138l*YZ_8l + K157l*MX_8l - K148l*MZ_8l)*ddq_5l + (D205l*K148l - D245l*K97l - D215l*K111l + D235l*K132l + D225l*K157l + D255l*K138l) 
% \nonumber \\ 
% &+(D270l*K192l - D292l*K132l - D259l*K148l + D303l*K174l + D281l*K201l + D314l*K181l)*ddx + (D271l*K192l - D293l*K132l - D260l*K148l + D304l*K174l + D282l*K201l + D315l*K181l)*ddpsi + (D272l*K192l - D294l*K132l - D261l*K148l + D305l*K174l + D283l*K201l + D316l*K181l)*ddq_imu + (D273l*K192l - D295l*K132l - D262l*K148l + D306l*K174l + D284l*K201l + D317l*K181l)*ddq_w + (D274l*K192l - D296l*K132l - D263l*K148l + D307l*K174l + D285l*K201l + D318l*K181l)*ddq_torso + (D275l*K192l - D297l*K132l - D264l*K148l + D308l*K174l + D286l*K201l + D319l*K181l)*ddq_1l + (D276l*K192l - D298l*K132l - D265l*K148l + D309l*K174l + D287l*K201l + D320l*K181l)*ddq_2l + (D277l*K192l - D299l*K132l - D266l*K148l + D310l*K174l + D288l*K201l + D321l*K181l)*ddq_3l + (D278l*K192l - D300l*K132l - D267l*K148l + D311l*K174l + D289l*K201l + D322l*K181l)*ddq_4l + (D279l*K192l - D301l*K132l - D268l*K148l + D312l*K174l + D290l*K201l + D323l*K181l)*ddq_5l + (K132l*XX_9l - K174l*XY_9l - K181l*XZ_9l - K201l*MY_9l + K192l*MZ_9l)*ddq_6l + (D280l*K192l - D302l*K132l - D269l*K148l + D313l*K174l + D291l*K201l + D324l*K181l) 
% \nonumber \\ 
% &+(D328l*K237l - D388l*K174l - D352l*K192l + D364l*K217l + D340l*K248l + D376l*K225l)*ddx + (D329l*K237l - D389l*K174l - D353l*K192l + D365l*K217l + D341l*K248l + D377l*K225l)*ddpsi + (D330l*K237l - D390l*K174l - D354l*K192l + D366l*K217l + D342l*K248l + D378l*K225l)*ddq_imu + (D331l*K237l - D391l*K174l - D355l*K192l + D367l*K217l + D343l*K248l + D379l*K225l)*ddq_w + (D332l*K237l - D392l*K174l - D356l*K192l + D368l*K217l + D344l*K248l + D380l*K225l)*ddq_torso + (D333l*K237l - D393l*K174l - D357l*K192l + D369l*K217l + D345l*K248l + D381l*K225l)*ddq_1l + (D334l*K237l - D394l*K174l - D358l*K192l + D370l*K217l + D346l*K248l + D382l*K225l)*ddq_2l + (D335l*K237l - D395l*K174l - D359l*K192l + D371l*K217l + D347l*K248l + D383l*K225l)*ddq_3l + (D336l*K237l - D396l*K174l - D360l*K192l + D372l*K217l + D348l*K248l + D384l*K225l)*ddq_4l + (D337l*K237l - D397l*K174l - D361l*K192l + D373l*K217l + D349l*K248l + D385l*K225l)*ddq_5l + (D338l*K237l - D398l*K174l - D362l*K192l + D374l*K217l + D350l*K248l + D386l*K225l)*ddq_6l + (K174l*ZZ_10l - K225l*YZ_10l - K217l*XZ_10l - K248l*MX_10l + K237l*MY_10l)*ddq_7l + (D339l*K237l - D399l*K174l - D363l*K192l + D375l*K217l + D351l*K248l + D387l*K225l) 
% \nonumber \\ 
% &+(D34r*sin(q_1r) - D22r*cos(q_1r) + D16r*K23r + D4r*K15r)*ddx + (D35r*sin(q_1r) - D23r*cos(q_1r) + D17r*K23r + D5r*K15r)*ddpsi + (D36r*sin(q_1r) - D24r*cos(q_1r) + D18r*K23r + D6r*K15r)*ddq_imu + (D37r*sin(q_1r) - D25r*cos(q_1r) + D19r*K23r + D7r*K15r)*ddq_w + (D38r*sin(q_1r) - D26r*cos(q_1r) + D20r*K23r + D8r*K15r)*ddq_torso + (XY_4r*cos(q_1r) - YZ_4r*sin(q_1r) + K23r*MX_4r - K15r*MZ_4r)*ddq_1r + (D39r*sin(q_1r) - D27r*cos(q_1r) + D21r*K23r + D9r*K15r) 
% \nonumber \\ 
% &+(D64r*cos(q_1r) - D43r*K15r + D50r*K46r + D71r*K36r + D57r*K51r + D78r*K39r)*ddx + (D65r*cos(q_1r) - D44r*K15r + D51r*K46r + D72r*K36r + D58r*K51r + D79r*K39r)*ddpsi + (D66r*cos(q_1r) - D45r*K15r + D52r*K46r + D73r*K36r + D59r*K51r + D80r*K39r)*ddq_imu + (D67r*cos(q_1r) - D46r*K15r + D53r*K46r + D74r*K36r + D60r*K51r + D81r*K39r)*ddq_w + (D68r*cos(q_1r) - D47r*K15r + D54r*K46r + D75r*K36r + D61r*K51r + D82r*K39r)*ddq_torso + (D69r*cos(q_1r) - D48r*K15r + D55r*K46r + D76r*K36r + D62r*K51r + D83r*K39r)*ddq_1r + (K46r*MZ_5r - K39r*XZ_5r - XX_5r*cos(q_1r) - K51r*MY_5r - K36r*XY_5r)*ddq_2r + (D70r*cos(q_1r) - D49r*K15r + D56r*K46r + D77r*K36r + D63r*K51r + D84r*K39r) 
% \nonumber \\ 
% &+(D88r*K75r - D120r*K36r - D96r*K46r + D112r*K63r + D104r*K82r + D128r*K67r)*ddx + (D89r*K75r - D121r*K36r - D97r*K46r + D113r*K63r + D105r*K82r + D129r*K67r)*ddpsi + (D90r*K75r - D122r*K36r - D98r*K46r + D114r*K63r + D106r*K82r + D130r*K67r)*ddq_imu + (D91r*K75r - D123r*K36r - D99r*K46r + D115r*K63r + D107r*K82r + D131r*K67r)*ddq_w + (D92r*K75r - D124r*K36r - D100r*K46r + D116r*K63r + D108r*K82r + D132r*K67r)*ddq_torso + (D93r*K75r - D125r*K36r - D101r*K46r + D117r*K63r + D109r*K82r + D133r*K67r)*ddq_1r + (D94r*K75r - D126r*K36r - D102r*K46r + D118r*K63r + D110r*K82r + D134r*K67r)*ddq_2r + (K36r*YY_6r - K63r*XY_6r - K67r*YZ_6r + K82r*MX_6r - K75r*MZ_6r)*ddq_3r + (D95r*K75r - D127r*K36r - D103r*K46r + D119r*K63r + D111r*K82r + D135r*K67r) 
% \nonumber \\ 
% &+(D148r*K111r - D166r*K63r - D139r*K75r + D175r*K97r + D157r*K118r + D184r*K102r)*ddx + (D149r*K111r - D167r*K63r - D140r*K75r + D176r*K97r + D158r*K118r + D185r*K102r)*ddpsi + (D150r*K111r - D168r*K63r - D141r*K75r + D177r*K97r + D159r*K118r + D186r*K102r)*ddq_imu + (D151r*K111r - D169r*K63r - D142r*K75r + D178r*K97r + D160r*K118r + D187r*K102r)*ddq_w + (D152r*K111r - D170r*K63r - D143r*K75r + D179r*K97r + D161r*K118r + D188r*K102r)*ddq_torso + (D153r*K111r - D171r*K63r - D144r*K75r + D180r*K97r + D162r*K118r + D189r*K102r)*ddq_1r + (D154r*K111r - D172r*K63r - D145r*K75r + D181r*K97r + D163r*K118r + D190r*K102r)*ddq_2r + (D155r*K111r - D173r*K63r - D146r*K75r + D182r*K97r + D164r*K118r + D191r*K102r)*ddq_3r + (K63r*XX_7r - K97r*XY_7r - K102r*XZ_7r - K118r*MY_7r + K111r*MZ_7r)*ddq_4r + (D156r*K111r - D174r*K63r - D147r*K75r + D183r*K97r + D165r*K118r + D192r*K102r) 
% \nonumber \\ 
% &+(D196r*K148r - D236r*K97r - D206r*K111r + D226r*K132r + D216r*K157r + D246r*K138r)*ddx + (D197r*K148r - D237r*K97r - D207r*K111r + D227r*K132r + D217r*K157r + D247r*K138r)*ddpsi + (D198r*K148r - D238r*K97r - D208r*K111r + D228r*K132r + D218r*K157r + D248r*K138r)*ddq_imu + (D199r*K148r - D239r*K97r - D209r*K111r + D229r*K132r + D219r*K157r + D249r*K138r)*ddq_w + (D200r*K148r - D240r*K97r - D210r*K111r + D230r*K132r + D220r*K157r + D250r*K138r)*ddq_torso + (D201r*K148r - D241r*K97r - D211r*K111r + D231r*K132r + D221r*K157r + D251r*K138r)*ddq_1r + (D202r*K148r - D242r*K97r - D212r*K111r + D232r*K132r + D222r*K157r + D252r*K138r)*ddq_2r + (D203r*K148r - D243r*K97r - D213r*K111r + D233r*K132r + D223r*K157r + D253r*K138r)*ddq_3r + (D204r*K148r - D244r*K97r - D214r*K111r + D234r*K132r + D224r*K157r + D254r*K138r)*ddq_4r + (K97r*YY_8r - K132r*XY_8r - K138r*YZ_8r + K157r*MX_8r - K148r*MZ_8r)*ddq_5r + (D205r*K148r - D245r*K97r - D215r*K111r + D235r*K132r + D225r*K157r + D255r*K138r) 
% \nonumber \\ 
% &+(D270r*K192r - D292r*K132r - D259r*K148r + D303r*K174r + D281r*K201r + D314r*K181r)*ddx + (D271r*K192r - D293r*K132r - D260r*K148r + D304r*K174r + D282r*K201r + D315r*K181r)*ddpsi + (D272r*K192r - D294r*K132r - D261r*K148r + D305r*K174r + D283r*K201r + D316r*K181r)*ddq_imu + (D273r*K192r - D295r*K132r - D262r*K148r + D306r*K174r + D284r*K201r + D317r*K181r)*ddq_w + (D274r*K192r - D296r*K132r - D263r*K148r + D307r*K174r + D285r*K201r + D318r*K181r)*ddq_torso + (D275r*K192r - D297r*K132r - D264r*K148r + D308r*K174r + D286r*K201r + D319r*K181r)*ddq_1r + (D276r*K192r - D298r*K132r - D265r*K148r + D309r*K174r + D287r*K201r + D320r*K181r)*ddq_2r + (D277r*K192r - D299r*K132r - D266r*K148r + D310r*K174r + D288r*K201r + D321r*K181r)*ddq_3r + (D278r*K192r - D300r*K132r - D267r*K148r + D311r*K174r + D289r*K201r + D322r*K181r)*ddq_4r + (D279r*K192r - D301r*K132r - D268r*K148r + D312r*K174r + D290r*K201r + D323r*K181r)*ddq_5r + (K132r*XX_9r - K174r*XY_9r - K181r*XZ_9r - K201r*MY_9r + K192r*MZ_9r)*ddq_6r + (D280r*K192r - D302r*K132r - D269r*K148r + D313r*K174r + D291r*K201r + D324r*K181r) 
% \nonumber \\ 
% &+(D328r*K237r - D388r*K174r - D352r*K192r + D364r*K217r + D340r*K248r + D376r*K225r)*ddx + (D329r*K237r - D389r*K174r - D353r*K192r + D365r*K217r + D341r*K248r + D377r*K225r)*ddpsi + (D330r*K237r - D390r*K174r - D354r*K192r + D366r*K217r + D342r*K248r + D378r*K225r)*ddq_imu + (D331r*K237r - D391r*K174r - D355r*K192r + D367r*K217r + D343r*K248r + D379r*K225r)*ddq_w + (D332r*K237r - D392r*K174r - D356r*K192r + D368r*K217r + D344r*K248r + D380r*K225r)*ddq_torso + (D333r*K237r - D393r*K174r - D357r*K192r + D369r*K217r + D345r*K248r + D381r*K225r)*ddq_1r + (D334r*K237r - D394r*K174r - D358r*K192r + D370r*K217r + D346r*K248r + D382r*K225r)*ddq_2r + (D335r*K237r - D395r*K174r - D359r*K192r + D371r*K217r + D347r*K248r + D383r*K225r)*ddq_3r + (D336r*K237r - D396r*K174r - D360r*K192r + D372r*K217r + D348r*K248r + D384r*K225r)*ddq_4r + (D337r*K237r - D397r*K174r - D361r*K192r + D373r*K217r + D349r*K248r + D385r*K225r)*ddq_5r + (D338r*K237r - D398r*K174r - D362r*K192r + D374r*K217r + D350r*K248r + D386r*K225r)*ddq_6r + (K174r*ZZ_10r - K225r*YZ_10r - K217r*XZ_10r - K248r*MX_10r + K237r*MY_10r)*ddq_7r + (D339r*K237r - D399r*K174r - D363r*K192r + D375r*K217r + D351r*K248r + D387r*K225r) 
% \nonumber \\ 
X81 = D64l*cos(q_1l) - D22l*cos(q_1l) - D22r*cos(q_1r) - D69 + D64r*cos(q_1r) + D34l*sin(q_1l) + D34r*sin(q_1r) + D16l*K23l + D16r*K23r - D43l*K15l - D43r*K15r + D50l*K46l + D71l*K36l + D50r*K46r + D57l*K51l + D78l*K39l + D71r*K36r + D57r*K51r + D78r*K39r - D96l*K46l - D96r*K46r - D120l*K36l + D88l*K75l - D120r*K36r + D88r*K75r + D112l*K63l + D104l*K82l + D112r*K63r + D128l*K67l + D104r*K82r + D128r*K67r - D139l*K75l - D139r*K75r - D166l*K63l - D166r*K63r + D148l*K111l + D148r*K111r + D175l*K97l + D157l*K118l + D175r*K97r + D184l*K102l + D157r*K118r + D184r*K102r - D206l*K111l - D206r*K111r - D236l*K97l + D196l*K148l - D236r*K97r + D196r*K148r + D226l*K132l + D226r*K132r + D216l*K157l + D246l*K138l + D216r*K157r + D246r*K138r - D259l*K148l - D259r*K148r - D292l*K132l - D292r*K132r + D270l*K192l + D270r*K192r + D303l*K174l + D281l*K201l + D303r*K174r + D281r*K201r + D314l*K181l + D314r*K181r - D352l*K192l - D352r*K192r - D388l*K174l + D328l*K237l - D388r*K174r + D328r*K237r + D364l*K217l + D340l*K248l + D364r*K217r + D340r*K248r + D376l*K225l + D376r*K225r + D4l*K15l + D4r*K15r;
X82 = D65l*cos(q_1l) - D23l*cos(q_1l) - D23r*cos(q_1r) - D70 + D65r*cos(q_1r) + D35l*sin(q_1l) + D35r*sin(q_1r) + D17l*K23l + D17r*K23r - D44l*K15l - D44r*K15r + D51l*K46l + D72l*K36l + D51r*K46r + D58l*K51l + D79l*K39l + D72r*K36r + D58r*K51r + D79r*K39r - D97l*K46l - D97r*K46r - D121l*K36l + D89l*K75l - D121r*K36r + D89r*K75r + D113l*K63l + D105l*K82l + D113r*K63r + D129l*K67l + D105r*K82r + D129r*K67r - D140l*K75l - D140r*K75r - D167l*K63l - D167r*K63r + D149l*K111l + D149r*K111r + D176l*K97l + D158l*K118l + D176r*K97r + D185l*K102l + D158r*K118r + D185r*K102r - D207l*K111l - D207r*K111r - D237l*K97l + D197l*K148l - D237r*K97r + D197r*K148r + D227l*K132l + D227r*K132r + D217l*K157l + D247l*K138l + D217r*K157r + D247r*K138r - D260l*K148l - D260r*K148r - D293l*K132l - D293r*K132r + D271l*K192l + D271r*K192r + D304l*K174l + D282l*K201l + D304r*K174r + D282r*K201r + D315l*K181l + D315r*K181r - D353l*K192l - D353r*K192r - D389l*K174l + D329l*K237l - D389r*K174r + D329r*K237r + D365l*K217l + D341l*K248l + D365r*K217r + D341r*K248r + D377l*K225l + D377r*K225r + D5l*K15l + D5r*K15r;
X83 = D66l*cos(q_1l) - D24l*cos(q_1l) - D24r*cos(q_1r) - D71 + D66r*cos(q_1r) + D36l*sin(q_1l) + D36r*sin(q_1r) + D18l*K23l + D18r*K23r - D45l*K15l - D45r*K15r + D52l*K46l + D73l*K36l + D52r*K46r + D59l*K51l + D80l*K39l + D73r*K36r + D59r*K51r + D80r*K39r - D98l*K46l - D98r*K46r - D122l*K36l + D90l*K75l - D122r*K36r + D90r*K75r + D114l*K63l + D106l*K82l + D114r*K63r + D130l*K67l + D106r*K82r + D130r*K67r - D141l*K75l - D141r*K75r - D168l*K63l - D168r*K63r + D150l*K111l + D150r*K111r + D177l*K97l + D159l*K118l + D177r*K97r + D186l*K102l + D159r*K118r + D186r*K102r - D208l*K111l - D208r*K111r - D238l*K97l + D198l*K148l - D238r*K97r + D198r*K148r + D228l*K132l + D228r*K132r + D218l*K157l + D248l*K138l + D218r*K157r + D248r*K138r - D261l*K148l - D261r*K148r - D294l*K132l - D294r*K132r + D272l*K192l + D272r*K192r + D305l*K174l + D283l*K201l + D305r*K174r + D283r*K201r + D316l*K181l + D316r*K181r - D354l*K192l - D354r*K192r - D390l*K174l + D330l*K237l - D390r*K174r + D330r*K237r + D366l*K217l + D342l*K248l + D366r*K217r + D342r*K248r + D378l*K225l + D378r*K225r + D6l*K15l + D6r*K15r;
X84 = D67l*cos(q_1l) - D25l*cos(q_1l) - D25r*cos(q_1r) - D72 + D67r*cos(q_1r) + D37l*sin(q_1l) + D37r*sin(q_1r) + D19l*K23l + D19r*K23r - D46l*K15l - D46r*K15r + D53l*K46l + D74l*K36l + D53r*K46r + D60l*K51l + D81l*K39l + D74r*K36r + D60r*K51r + D81r*K39r - D99l*K46l - D99r*K46r - D123l*K36l + D91l*K75l - D123r*K36r + D91r*K75r + D115l*K63l + D107l*K82l + D115r*K63r + D131l*K67l + D107r*K82r + D131r*K67r - D142l*K75l - D142r*K75r - D169l*K63l - D169r*K63r + D151l*K111l + D151r*K111r + D178l*K97l + D160l*K118l + D178r*K97r + D187l*K102l + D160r*K118r + D187r*K102r - D209l*K111l - D209r*K111r - D239l*K97l + D199l*K148l - D239r*K97r + D199r*K148r + D229l*K132l + D229r*K132r + D219l*K157l + D249l*K138l + D219r*K157r + D249r*K138r - D262l*K148l - D262r*K148r - D295l*K132l - D295r*K132r + D273l*K192l + D273r*K192r + D306l*K174l + D284l*K201l + D306r*K174r + D284r*K201r + D317l*K181l + D317r*K181r - D355l*K192l - D355r*K192r - D391l*K174l + D331l*K237l - D391r*K174r + D331r*K237r + D367l*K217l + D343l*K248l + D367r*K217r + D343r*K248r + D379l*K225l + D379r*K225r + D7l*K15l + D7r*K15r;
X85 = YY_3 - D26l*cos(q_1l) - D26r*cos(q_1r) + D68l*cos(q_1l) + D68r*cos(q_1r) + D38l*sin(q_1l) + D38r*sin(q_1r) + D20l*K23l + D20r*K23r - D47l*K15l - D47r*K15r + D54l*K46l + D75l*K36l + D54r*K46r + D61l*K51l + D82l*K39l + D75r*K36r + D61r*K51r + D82r*K39r - D100l*K46l - D100r*K46r - D124l*K36l + D92l*K75l - D124r*K36r + D92r*K75r + D116l*K63l + D108l*K82l + D116r*K63r + D132l*K67l + D108r*K82r + D132r*K67r - D143l*K75l - D143r*K75r - D170l*K63l - D170r*K63r + D152l*K111l + D152r*K111r + D179l*K97l + D161l*K118l + D179r*K97r + D188l*K102l + D161r*K118r + D188r*K102r - D210l*K111l - D210r*K111r - D240l*K97l + D200l*K148l - D240r*K97r + D200r*K148r + D230l*K132l + D230r*K132r + D220l*K157l + D250l*K138l + D220r*K157r + D250r*K138r - D263l*K148l - D263r*K148r - D296l*K132l - D296r*K132r + D274l*K192l + D274r*K192r + D307l*K174l + D285l*K201l + D307r*K174r + D285r*K201r + D318l*K181l + D318r*K181r - D356l*K192l - D356r*K192r - D392l*K174l + D332l*K237l - D392r*K174r + D332r*K237r + D368l*K217l + D344l*K248l + D368r*K217r + D344r*K248r + D380l*K225l + D380r*K225r + D8l*K15l + D8r*K15r;
X86 = D69l*cos(q_1l) + XY_4l*cos(q_1l) - YZ_4l*sin(q_1l) - D48l*K15l + D55l*K46l + D76l*K36l + D62l*K51l + D83l*K39l - D101l*K46l - D125l*K36l + D93l*K75l + D117l*K63l + D109l*K82l + D133l*K67l - D144l*K75l - D171l*K63l + D153l*K111l + D180l*K97l + D162l*K118l + D189l*K102l - D211l*K111l - D241l*K97l + D201l*K148l + D231l*K132l + D221l*K157l + D251l*K138l - D264l*K148l - D297l*K132l + D275l*K192l + D308l*K174l + D286l*K201l + D319l*K181l - D357l*K192l - D393l*K174l + D333l*K237l + D369l*K217l + D345l*K248l + D381l*K225l + K23l*MX_4l - K15l*MZ_4l;
X87 = D94l*K75l - K39l*XZ_5l - XX_5l*cos(q_1l) - D102l*K46l - D126l*K36l - K36l*XY_5l + D118l*K63l + D110l*K82l + D134l*K67l - D145l*K75l - D172l*K63l + D154l*K111l + D181l*K97l + D163l*K118l + D190l*K102l - D212l*K111l - D242l*K97l + D202l*K148l + D232l*K132l + D222l*K157l + D252l*K138l - D265l*K148l - D298l*K132l + D276l*K192l + D309l*K174l + D287l*K201l + D320l*K181l - D358l*K192l - D394l*K174l + D334l*K237l + D370l*K217l + D346l*K248l + D382l*K225l - K51l*MY_5l + K46l*MZ_5l;
X88 = K36l*YY_6l - K63l*XY_6l - K67l*YZ_6l - D146l*K75l - D173l*K63l + D155l*K111l + D182l*K97l + D164l*K118l + D191l*K102l - D213l*K111l - D243l*K97l + D203l*K148l + D233l*K132l + D223l*K157l + D253l*K138l - D266l*K148l - D299l*K132l + D277l*K192l + D310l*K174l + D288l*K201l + D321l*K181l - D359l*K192l - D395l*K174l + D335l*K237l + D371l*K217l + D347l*K248l + D383l*K225l + K82l*MX_6l - K75l*MZ_6l;
X89 = K63l*XX_7l - K97l*XY_7l - K102l*XZ_7l - D214l*K111l - D244l*K97l + D204l*K148l + D234l*K132l + D224l*K157l + D254l*K138l - D267l*K148l - D300l*K132l + D278l*K192l + D311l*K174l + D289l*K201l + D322l*K181l - D360l*K192l - D396l*K174l + D336l*K237l + D372l*K217l + D348l*K248l + D384l*K225l - K118l*MY_7l + K111l*MZ_7l;
X90 = K97l*YY_8l - K132l*XY_8l - K138l*YZ_8l - D268l*K148l - D301l*K132l + D279l*K192l + D312l*K174l + D290l*K201l + D323l*K181l - D361l*K192l - D397l*K174l + D337l*K237l + D373l*K217l + D349l*K248l + D385l*K225l + K157l*MX_8l - K148l*MZ_8l;
X91 = K132l*XX_9l - K174l*XY_9l - K181l*XZ_9l - D362l*K192l - D398l*K174l + D338l*K237l + D374l*K217l + D350l*K248l + D386l*K225l - K201l*MY_9l + K192l*MZ_9l;
X92 = K174l*ZZ_10l - K225l*YZ_10l - K217l*XZ_10l - K248l*MX_10l + K237l*MY_10l;
X93 = D69r*cos(q_1r) + XY_4r*cos(q_1r) - YZ_4r*sin(q_1r) - D48r*K15r + D55r*K46r + D76r*K36r + D62r*K51r + D83r*K39r - D101r*K46r - D125r*K36r + D93r*K75r + D117r*K63r + D109r*K82r + D133r*K67r - D144r*K75r - D171r*K63r + D153r*K111r + D180r*K97r + D162r*K118r + D189r*K102r - D211r*K111r - D241r*K97r + D201r*K148r + D231r*K132r + D221r*K157r + D251r*K138r - D264r*K148r - D297r*K132r + D275r*K192r + D308r*K174r + D286r*K201r + D319r*K181r - D357r*K192r - D393r*K174r + D333r*K237r + D369r*K217r + D345r*K248r + D381r*K225r + K23r*MX_4r - K15r*MZ_4r;
X94 = D94r*K75r - K39r*XZ_5r - XX_5r*cos(q_1r) - D102r*K46r - D126r*K36r - K36r*XY_5r + D118r*K63r + D110r*K82r + D134r*K67r - D145r*K75r - D172r*K63r + D154r*K111r + D181r*K97r + D163r*K118r + D190r*K102r - D212r*K111r - D242r*K97r + D202r*K148r + D232r*K132r + D222r*K157r + D252r*K138r - D265r*K148r - D298r*K132r + D276r*K192r + D309r*K174r + D287r*K201r + D320r*K181r - D358r*K192r - D394r*K174r + D334r*K237r + D370r*K217r + D346r*K248r + D382r*K225r - K51r*MY_5r + K46r*MZ_5r;
X95 = K36r*YY_6r - K63r*XY_6r - K67r*YZ_6r - D146r*K75r - D173r*K63r + D155r*K111r + D182r*K97r + D164r*K118r + D191r*K102r - D213r*K111r - D243r*K97r + D203r*K148r + D233r*K132r + D223r*K157r + D253r*K138r - D266r*K148r - D299r*K132r + D277r*K192r + D310r*K174r + D288r*K201r + D321r*K181r - D359r*K192r - D395r*K174r + D335r*K237r + D371r*K217r + D347r*K248r + D383r*K225r + K82r*MX_6r - K75r*MZ_6r;
X96 = K63r*XX_7r - K97r*XY_7r - K102r*XZ_7r - D214r*K111r - D244r*K97r + D204r*K148r + D234r*K132r + D224r*K157r + D254r*K138r - D267r*K148r - D300r*K132r + D278r*K192r + D311r*K174r + D289r*K201r + D322r*K181r - D360r*K192r - D396r*K174r + D336r*K237r + D372r*K217r + D348r*K248r + D384r*K225r - K118r*MY_7r + K111r*MZ_7r;
X97 = K97r*YY_8r - K132r*XY_8r - K138r*YZ_8r - D268r*K148r - D301r*K132r + D279r*K192r + D312r*K174r + D290r*K201r + D323r*K181r - D361r*K192r - D397r*K174r + D337r*K237r + D373r*K217r + D349r*K248r + D385r*K225r + K157r*MX_8r - K148r*MZ_8r;
X98 = K132r*XX_9r - K174r*XY_9r - K181r*XZ_9r - D362r*K192r - D398r*K174r + D338r*K237r + D374r*K217r + D350r*K248r + D386r*K225r - K201r*MY_9r + K192r*MZ_9r;
X99 = K174r*ZZ_10r - K225r*YZ_10r - K217r*XZ_10r - K248r*MX_10r + K237r*MY_10r;
X100 = D70l*cos(q_1l) - D27l*cos(q_1l) - D27r*cos(q_1r) - D73 + D70r*cos(q_1r) + D39l*sin(q_1l) + D39r*sin(q_1r) + D21l*K23l + D21r*K23r - D49l*K15l - D49r*K15r + D56l*K46l + D77l*K36l + D56r*K46r + D63l*K51l + D84l*K39l + D77r*K36r + D63r*K51r + D84r*K39r - D103l*K46l - D103r*K46r - D127l*K36l + D95l*K75l - D127r*K36r + D95r*K75r + D119l*K63l + D111l*K82l + D119r*K63r + D135l*K67l + D111r*K82r + D135r*K67r - D147l*K75l - D147r*K75r - D174l*K63l - D174r*K63r + D156l*K111l + D156r*K111r + D183l*K97l + D165l*K118l + D183r*K97r + D192l*K102l + D165r*K118r + D192r*K102r - D215l*K111l - D215r*K111r - D245l*K97l + D205l*K148l - D245r*K97r + D205r*K148r + D235l*K132l + D235r*K132r + D225l*K157l + D255l*K138l + D225r*K157r + D255r*K138r - D269l*K148l - D269r*K148r - D302l*K132l - D302r*K132r + D280l*K192l + D280r*K192r + D313l*K174l + D291l*K201l + D313r*K174r + D291r*K201r + D324l*K181l + D324r*K181r - D363l*K192l - D363r*K192r - D399l*K174l + D339l*K237l - D399r*K174r + D339r*K237r + D375l*K217l + D351l*K248l + D375r*K217r + D351r*K248r + D387l*K225l + D387r*K225r + D9l*K15l + D9r*K15r;
% LHS_{dq_torso} &= (D328r*K237r - D388r*K174r - D352r*K192r + D364r*K217r + D340r*K248r + D376r*K225r)*ddx + (D329r*K237r - D389r*K174r - D353r*K192r + D365r*K217r + D341r*K248r + D377r*K225r)*ddpsi + (D330r*K237r - D390r*K174r - D354r*K192r + D366r*K217r + D342r*K248r + D378r*K225r)*ddq_imu + (D331r*K237r - D391r*K174r - D355r*K192r + D367r*K217r + D343r*K248r + D379r*K225r)*ddq_w + (D332r*K237r - D392r*K174r - D356r*K192r + D368r*K217r + D344r*K248r + D380r*K225r)*ddq_torso + (D333r*K237r - D393r*K174r - D357r*K192r + D369r*K217r + D345r*K248r + D381r*K225r)*ddq_1r + (D334r*K237r - D394r*K174r - D358r*K192r + D370r*K217r + D346r*K248r + D382r*K225r)*ddq_2r + (D335r*K237r - D395r*K174r - D359r*K192r + D371r*K217r + D347r*K248r + D383r*K225r)*ddq_3r + (D336r*K237r - D396r*K174r - D360r*K192r + D372r*K217r + D348r*K248r + D384r*K225r)*ddq_4r + (D337r*K237r - D397r*K174r - D361r*K192r + D373r*K217r + D349r*K248r + D385r*K225r)*ddq_5r + (D338r*K237r - D398r*K174r - D362r*K192r + D374r*K217r + D350r*K248r + D386r*K225r)*ddq_6r + (K174r*ZZ_10r - K225r*YZ_10r - K217r*XZ_10r - K248r*MX_10r + K237r*MY_10r)*ddq_7r + (D339r*K237r - D399r*K174r - D363r*K192r + D375r*K217r + D351r*K248r + D387r*K225r) 
% \nonumber \\ 
% LHS_{dq_1l} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_1l} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_1l}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D28l)*ddx + (-D29l)*ddpsi + (-D30l)*ddq_imu + (-D31l)*ddq_w + (-D32l)*ddq_torso + YY_4l*ddq_1l - D33l 
% \nonumber \\ 
% &+(D71l*cos(q_2l) + D78l*sin(q_2l))*ddx + (D72l*cos(q_2l) + D79l*sin(q_2l))*ddpsi + (D73l*cos(q_2l) + D80l*sin(q_2l))*ddq_imu + (D74l*cos(q_2l) + D81l*sin(q_2l))*ddq_w + (D75l*cos(q_2l) + D82l*sin(q_2l))*ddq_torso + (D76l*cos(q_2l) + D83l*sin(q_2l))*ddq_1l + (- XY_5l*cos(q_2l) - XZ_5l*sin(q_2l))*ddq_2l + (D77l*cos(q_2l) + D84l*sin(q_2l)) 
% \nonumber \\ 
% &+(D88l*K76l - D120l*cos(q_2l) + D112l*K64l + D104l*K83l + D128l*K68l)*ddx + (D89l*K76l - D121l*cos(q_2l) + D113l*K64l + D105l*K83l + D129l*K68l)*ddpsi + (D90l*K76l - D122l*cos(q_2l) + D114l*K64l + D106l*K83l + D130l*K68l)*ddq_imu + (D91l*K76l - D123l*cos(q_2l) + D115l*K64l + D107l*K83l + D131l*K68l)*ddq_w + (D92l*K76l - D124l*cos(q_2l) + D116l*K64l + D108l*K83l + D132l*K68l)*ddq_torso + (D93l*K76l - D125l*cos(q_2l) + D117l*K64l + D109l*K83l + D133l*K68l)*ddq_1l + (D94l*K76l - D126l*cos(q_2l) + D118l*K64l + D110l*K83l + D134l*K68l)*ddq_2l + (YY_6l*cos(q_2l) - K68l*YZ_6l - K64l*XY_6l + K83l*MX_6l - K76l*MZ_6l)*ddq_3l + (D95l*K76l - D127l*cos(q_2l) + D119l*K64l + D111l*K83l + D135l*K68l) 
% \nonumber \\ 
% &+(D148l*K112l - D166l*K64l - D139l*K76l + D175l*K98l + D157l*K119l + D184l*K103l)*ddx + (D149l*K112l - D167l*K64l - D140l*K76l + D176l*K98l + D158l*K119l + D185l*K103l)*ddpsi + (D150l*K112l - D168l*K64l - D141l*K76l + D177l*K98l + D159l*K119l + D186l*K103l)*ddq_imu + (D151l*K112l - D169l*K64l - D142l*K76l + D178l*K98l + D160l*K119l + D187l*K103l)*ddq_w + (D152l*K112l - D170l*K64l - D143l*K76l + D179l*K98l + D161l*K119l + D188l*K103l)*ddq_torso + (D153l*K112l - D171l*K64l - D144l*K76l + D180l*K98l + D162l*K119l + D189l*K103l)*ddq_1l + (D154l*K112l - D172l*K64l - D145l*K76l + D181l*K98l + D163l*K119l + D190l*K103l)*ddq_2l + (D155l*K112l - D173l*K64l - D146l*K76l + D182l*K98l + D164l*K119l + D191l*K103l)*ddq_3l + (K64l*XX_7l - K98l*XY_7l - K103l*XZ_7l - K119l*MY_7l + K112l*MZ_7l)*ddq_4l + (D156l*K112l - D174l*K64l - D147l*K76l + D183l*K98l + D165l*K119l + D192l*K103l) 
% \nonumber \\ 
% &+(D196l*K149l - D236l*K98l - D206l*K112l + D226l*K133l + D216l*K158l + D246l*K139l)*ddx + (D197l*K149l - D237l*K98l - D207l*K112l + D227l*K133l + D217l*K158l + D247l*K139l)*ddpsi + (D198l*K149l - D238l*K98l - D208l*K112l + D228l*K133l + D218l*K158l + D248l*K139l)*ddq_imu + (D199l*K149l - D239l*K98l - D209l*K112l + D229l*K133l + D219l*K158l + D249l*K139l)*ddq_w + (D200l*K149l - D240l*K98l - D210l*K112l + D230l*K133l + D220l*K158l + D250l*K139l)*ddq_torso + (D201l*K149l - D241l*K98l - D211l*K112l + D231l*K133l + D221l*K158l + D251l*K139l)*ddq_1l + (D202l*K149l - D242l*K98l - D212l*K112l + D232l*K133l + D222l*K158l + D252l*K139l)*ddq_2l + (D203l*K149l - D243l*K98l - D213l*K112l + D233l*K133l + D223l*K158l + D253l*K139l)*ddq_3l + (D204l*K149l - D244l*K98l - D214l*K112l + D234l*K133l + D224l*K158l + D254l*K139l)*ddq_4l + (K98l*YY_8l - K133l*XY_8l - K139l*YZ_8l + K158l*MX_8l - K149l*MZ_8l)*ddq_5l + (D205l*K149l - D245l*K98l - D215l*K112l + D235l*K133l + D225l*K158l + D255l*K139l) 
% \nonumber \\ 
% &+(D270l*K193l - D292l*K133l - D259l*K149l + D303l*K175l + D281l*K202l + D314l*K182l)*ddx + (D271l*K193l - D293l*K133l - D260l*K149l + D304l*K175l + D282l*K202l + D315l*K182l)*ddpsi + (D272l*K193l - D294l*K133l - D261l*K149l + D305l*K175l + D283l*K202l + D316l*K182l)*ddq_imu + (D273l*K193l - D295l*K133l - D262l*K149l + D306l*K175l + D284l*K202l + D317l*K182l)*ddq_w + (D274l*K193l - D296l*K133l - D263l*K149l + D307l*K175l + D285l*K202l + D318l*K182l)*ddq_torso + (D275l*K193l - D297l*K133l - D264l*K149l + D308l*K175l + D286l*K202l + D319l*K182l)*ddq_1l + (D276l*K193l - D298l*K133l - D265l*K149l + D309l*K175l + D287l*K202l + D320l*K182l)*ddq_2l + (D277l*K193l - D299l*K133l - D266l*K149l + D310l*K175l + D288l*K202l + D321l*K182l)*ddq_3l + (D278l*K193l - D300l*K133l - D267l*K149l + D311l*K175l + D289l*K202l + D322l*K182l)*ddq_4l + (D279l*K193l - D301l*K133l - D268l*K149l + D312l*K175l + D290l*K202l + D323l*K182l)*ddq_5l + (K133l*XX_9l - K175l*XY_9l - K182l*XZ_9l - K202l*MY_9l + K193l*MZ_9l)*ddq_6l + (D280l*K193l - D302l*K133l - D269l*K149l + D313l*K175l + D291l*K202l + D324l*K182l) 
% \nonumber \\ 
% &+(D328l*K238l - D388l*K175l - D352l*K193l + D364l*K218l + D340l*K249l + D376l*K226l)*ddx + (D329l*K238l - D389l*K175l - D353l*K193l + D365l*K218l + D341l*K249l + D377l*K226l)*ddpsi + (D330l*K238l - D390l*K175l - D354l*K193l + D366l*K218l + D342l*K249l + D378l*K226l)*ddq_imu + (D331l*K238l - D391l*K175l - D355l*K193l + D367l*K218l + D343l*K249l + D379l*K226l)*ddq_w + (D332l*K238l - D392l*K175l - D356l*K193l + D368l*K218l + D344l*K249l + D380l*K226l)*ddq_torso + (D333l*K238l - D393l*K175l - D357l*K193l + D369l*K218l + D345l*K249l + D381l*K226l)*ddq_1l + (D334l*K238l - D394l*K175l - D358l*K193l + D370l*K218l + D346l*K249l + D382l*K226l)*ddq_2l + (D335l*K238l - D395l*K175l - D359l*K193l + D371l*K218l + D347l*K249l + D383l*K226l)*ddq_3l + (D336l*K238l - D396l*K175l - D360l*K193l + D372l*K218l + D348l*K249l + D384l*K226l)*ddq_4l + (D337l*K238l - D397l*K175l - D361l*K193l + D373l*K218l + D349l*K249l + D385l*K226l)*ddq_5l + (D338l*K238l - D398l*K175l - D362l*K193l + D374l*K218l + D350l*K249l + D386l*K226l)*ddq_6l + (K175l*ZZ_10l - K226l*YZ_10l - K218l*XZ_10l - K249l*MX_10l + K238l*MY_10l)*ddq_7l + (D339l*K238l - D399l*K175l - D363l*K193l + D375l*K218l + D351l*K249l + D387l*K226l) 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
X1l = D71l*cos(q_2l) - D28l - D120l*cos(q_2l) + D78l*sin(q_2l) + D88l*K76l + D112l*K64l + D104l*K83l + D128l*K68l - D139l*K76l - D166l*K64l + D148l*K112l + D175l*K98l + D157l*K119l + D184l*K103l - D206l*K112l - D236l*K98l + D196l*K149l + D226l*K133l + D216l*K158l + D246l*K139l - D259l*K149l - D292l*K133l + D270l*K193l + D303l*K175l + D281l*K202l + D314l*K182l - D352l*K193l - D388l*K175l + D328l*K238l + D364l*K218l + D340l*K249l + D376l*K226l;
X2l = D72l*cos(q_2l) - D29l - D121l*cos(q_2l) + D79l*sin(q_2l) + D89l*K76l + D113l*K64l + D105l*K83l + D129l*K68l - D140l*K76l - D167l*K64l + D149l*K112l + D176l*K98l + D158l*K119l + D185l*K103l - D207l*K112l - D237l*K98l + D197l*K149l + D227l*K133l + D217l*K158l + D247l*K139l - D260l*K149l - D293l*K133l + D271l*K193l + D304l*K175l + D282l*K202l + D315l*K182l - D353l*K193l - D389l*K175l + D329l*K238l + D365l*K218l + D341l*K249l + D377l*K226l;
X3l = D73l*cos(q_2l) - D30l - D122l*cos(q_2l) + D80l*sin(q_2l) + D90l*K76l + D114l*K64l + D106l*K83l + D130l*K68l - D141l*K76l - D168l*K64l + D150l*K112l + D177l*K98l + D159l*K119l + D186l*K103l - D208l*K112l - D238l*K98l + D198l*K149l + D228l*K133l + D218l*K158l + D248l*K139l - D261l*K149l - D294l*K133l + D272l*K193l + D305l*K175l + D283l*K202l + D316l*K182l - D354l*K193l - D390l*K175l + D330l*K238l + D366l*K218l + D342l*K249l + D378l*K226l;
X4l = D74l*cos(q_2l) - D31l - D123l*cos(q_2l) + D81l*sin(q_2l) + D91l*K76l + D115l*K64l + D107l*K83l + D131l*K68l - D142l*K76l - D169l*K64l + D151l*K112l + D178l*K98l + D160l*K119l + D187l*K103l - D209l*K112l - D239l*K98l + D199l*K149l + D229l*K133l + D219l*K158l + D249l*K139l - D262l*K149l - D295l*K133l + D273l*K193l + D306l*K175l + D284l*K202l + D317l*K182l - D355l*K193l - D391l*K175l + D331l*K238l + D367l*K218l + D343l*K249l + D379l*K226l;
X5l = D75l*cos(q_2l) - D32l - D124l*cos(q_2l) + D82l*sin(q_2l) + D92l*K76l + D116l*K64l + D108l*K83l + D132l*K68l - D143l*K76l - D170l*K64l + D152l*K112l + D179l*K98l + D161l*K119l + D188l*K103l - D210l*K112l - D240l*K98l + D200l*K149l + D230l*K133l + D220l*K158l + D250l*K139l - D263l*K149l - D296l*K133l + D274l*K193l + D307l*K175l + D285l*K202l + D318l*K182l - D356l*K193l - D392l*K175l + D332l*K238l + D368l*K218l + D344l*K249l + D380l*K226l;
X6l = YY_4l + D76l*cos(q_2l) - D125l*cos(q_2l) + D83l*sin(q_2l) + D93l*K76l + D117l*K64l + D109l*K83l + D133l*K68l - D144l*K76l - D171l*K64l + D153l*K112l + D180l*K98l + D162l*K119l + D189l*K103l - D211l*K112l - D241l*K98l + D201l*K149l + D231l*K133l + D221l*K158l + D251l*K139l - D264l*K149l - D297l*K133l + D275l*K193l + D308l*K175l + D286l*K202l + D319l*K182l - D357l*K193l - D393l*K175l + D333l*K238l + D369l*K218l + D345l*K249l + D381l*K226l;
X7l = D94l*K76l - XY_5l*cos(q_2l) - XZ_5l*sin(q_2l) - D126l*cos(q_2l) + D118l*K64l + D110l*K83l + D134l*K68l - D145l*K76l - D172l*K64l + D154l*K112l + D181l*K98l + D163l*K119l + D190l*K103l - D212l*K112l - D242l*K98l + D202l*K149l + D232l*K133l + D222l*K158l + D252l*K139l - D265l*K149l - D298l*K133l + D276l*K193l + D309l*K175l + D287l*K202l + D320l*K182l - D358l*K193l - D394l*K175l + D334l*K238l + D370l*K218l + D346l*K249l + D382l*K226l;
X8l = YY_6l*cos(q_2l) - K68l*YZ_6l - K64l*XY_6l - D146l*K76l - D173l*K64l + D155l*K112l + D182l*K98l + D164l*K119l + D191l*K103l - D213l*K112l - D243l*K98l + D203l*K149l + D233l*K133l + D223l*K158l + D253l*K139l - D266l*K149l - D299l*K133l + D277l*K193l + D310l*K175l + D288l*K202l + D321l*K182l - D359l*K193l - D395l*K175l + D335l*K238l + D371l*K218l + D347l*K249l + D383l*K226l + K83l*MX_6l - K76l*MZ_6l;
X9l = K64l*XX_7l - K98l*XY_7l - K103l*XZ_7l - D214l*K112l - D244l*K98l + D204l*K149l + D234l*K133l + D224l*K158l + D254l*K139l - D267l*K149l - D300l*K133l + D278l*K193l + D311l*K175l + D289l*K202l + D322l*K182l - D360l*K193l - D396l*K175l + D336l*K238l + D372l*K218l + D348l*K249l + D384l*K226l - K119l*MY_7l + K112l*MZ_7l;
X10l = K98l*YY_8l - K133l*XY_8l - K139l*YZ_8l - D268l*K149l - D301l*K133l + D279l*K193l + D312l*K175l + D290l*K202l + D323l*K182l - D361l*K193l - D397l*K175l + D337l*K238l + D373l*K218l + D349l*K249l + D385l*K226l + K158l*MX_8l - K149l*MZ_8l;
X11l = K133l*XX_9l - K175l*XY_9l - K182l*XZ_9l - D362l*K193l - D398l*K175l + D338l*K238l + D374l*K218l + D350l*K249l + D386l*K226l - K202l*MY_9l + K193l*MZ_9l;
X12l = K175l*ZZ_10l - K226l*YZ_10l - K218l*XZ_10l - K249l*MX_10l + K238l*MY_10l;
X13l = D77l*cos(q_2l) - D33l - D127l*cos(q_2l) + D84l*sin(q_2l) + D95l*K76l + D119l*K64l + D111l*K83l + D135l*K68l - D147l*K76l - D174l*K64l + D156l*K112l + D183l*K98l + D165l*K119l + D192l*K103l - D215l*K112l - D245l*K98l + D205l*K149l + D235l*K133l + D225l*K158l + D255l*K139l - D269l*K149l - D302l*K133l + D280l*K193l + D313l*K175l + D291l*K202l + D324l*K182l - D363l*K193l - D399l*K175l + D339l*K238l + D375l*K218l + D351l*K249l + D387l*K226l;
% LHS_{dq_1l} &= 0 
% \nonumber \\ 
% LHS_{dq_2l} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_2l} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_2l}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D64l)*ddx + (-D65l)*ddpsi + (-D66l)*ddq_imu + (-D67l)*ddq_w + (-D68l)*ddq_torso + (-D69l)*ddq_1l + XX_5l*ddq_2l - D70l 
% \nonumber \\ 
% &+(D112l*cos(q_3l) - D128l*sin(q_3l) + D88l*K77l + D104l*K84l)*ddx + (D113l*cos(q_3l) - D129l*sin(q_3l) + D89l*K77l + D105l*K84l)*ddpsi + (D114l*cos(q_3l) - D130l*sin(q_3l) + D90l*K77l + D106l*K84l)*ddq_imu + (D115l*cos(q_3l) - D131l*sin(q_3l) + D91l*K77l + D107l*K84l)*ddq_w + (D116l*cos(q_3l) - D132l*sin(q_3l) + D92l*K77l + D108l*K84l)*ddq_torso + (D117l*cos(q_3l) - D133l*sin(q_3l) + D93l*K77l + D109l*K84l)*ddq_1l + (D118l*cos(q_3l) - D134l*sin(q_3l) + D94l*K77l + D110l*K84l)*ddq_2l + (YZ_6l*sin(q_3l) - XY_6l*cos(q_3l) + K84l*MX_6l - K77l*MZ_6l)*ddq_3l + (D119l*cos(q_3l) - D135l*sin(q_3l) + D95l*K77l + D111l*K84l) 
% \nonumber \\ 
% &+(D148l*K113l - D139l*K77l - D166l*cos(q_3l) + D175l*K99l + D157l*K120l + D184l*K104l)*ddx + (D149l*K113l - D140l*K77l - D167l*cos(q_3l) + D176l*K99l + D158l*K120l + D185l*K104l)*ddpsi + (D150l*K113l - D141l*K77l - D168l*cos(q_3l) + D177l*K99l + D159l*K120l + D186l*K104l)*ddq_imu + (D151l*K113l - D142l*K77l - D169l*cos(q_3l) + D178l*K99l + D160l*K120l + D187l*K104l)*ddq_w + (D152l*K113l - D143l*K77l - D170l*cos(q_3l) + D179l*K99l + D161l*K120l + D188l*K104l)*ddq_torso + (D153l*K113l - D144l*K77l - D171l*cos(q_3l) + D180l*K99l + D162l*K120l + D189l*K104l)*ddq_1l + (D154l*K113l - D145l*K77l - D172l*cos(q_3l) + D181l*K99l + D163l*K120l + D190l*K104l)*ddq_2l + (D155l*K113l - D146l*K77l - D173l*cos(q_3l) + D182l*K99l + D164l*K120l + D191l*K104l)*ddq_3l + (XX_7l*cos(q_3l) - K104l*XZ_7l - K99l*XY_7l - K120l*MY_7l + K113l*MZ_7l)*ddq_4l + (D156l*K113l - D147l*K77l - D174l*cos(q_3l) + D183l*K99l + D165l*K120l + D192l*K104l) 
% \nonumber \\ 
% &+(D196l*K150l - D236l*K99l - D206l*K113l + D226l*K134l + D216l*K159l + D246l*K140l)*ddx + (D197l*K150l - D237l*K99l - D207l*K113l + D227l*K134l + D217l*K159l + D247l*K140l)*ddpsi + (D198l*K150l - D238l*K99l - D208l*K113l + D228l*K134l + D218l*K159l + D248l*K140l)*ddq_imu + (D199l*K150l - D239l*K99l - D209l*K113l + D229l*K134l + D219l*K159l + D249l*K140l)*ddq_w + (D200l*K150l - D240l*K99l - D210l*K113l + D230l*K134l + D220l*K159l + D250l*K140l)*ddq_torso + (D201l*K150l - D241l*K99l - D211l*K113l + D231l*K134l + D221l*K159l + D251l*K140l)*ddq_1l + (D202l*K150l - D242l*K99l - D212l*K113l + D232l*K134l + D222l*K159l + D252l*K140l)*ddq_2l + (D203l*K150l - D243l*K99l - D213l*K113l + D233l*K134l + D223l*K159l + D253l*K140l)*ddq_3l + (D204l*K150l - D244l*K99l - D214l*K113l + D234l*K134l + D224l*K159l + D254l*K140l)*ddq_4l + (K99l*YY_8l - K134l*XY_8l - K140l*YZ_8l + K159l*MX_8l - K150l*MZ_8l)*ddq_5l + (D205l*K150l - D245l*K99l - D215l*K113l + D235l*K134l + D225l*K159l + D255l*K140l) 
% \nonumber \\ 
% &+(D270l*K194l - D292l*K134l - D259l*K150l + D303l*K176l + D281l*K203l + D314l*K183l)*ddx + (D271l*K194l - D293l*K134l - D260l*K150l + D304l*K176l + D282l*K203l + D315l*K183l)*ddpsi + (D272l*K194l - D294l*K134l - D261l*K150l + D305l*K176l + D283l*K203l + D316l*K183l)*ddq_imu + (D273l*K194l - D295l*K134l - D262l*K150l + D306l*K176l + D284l*K203l + D317l*K183l)*ddq_w + (D274l*K194l - D296l*K134l - D263l*K150l + D307l*K176l + D285l*K203l + D318l*K183l)*ddq_torso + (D275l*K194l - D297l*K134l - D264l*K150l + D308l*K176l + D286l*K203l + D319l*K183l)*ddq_1l + (D276l*K194l - D298l*K134l - D265l*K150l + D309l*K176l + D287l*K203l + D320l*K183l)*ddq_2l + (D277l*K194l - D299l*K134l - D266l*K150l + D310l*K176l + D288l*K203l + D321l*K183l)*ddq_3l + (D278l*K194l - D300l*K134l - D267l*K150l + D311l*K176l + D289l*K203l + D322l*K183l)*ddq_4l + (D279l*K194l - D301l*K134l - D268l*K150l + D312l*K176l + D290l*K203l + D323l*K183l)*ddq_5l + (K134l*XX_9l - K176l*XY_9l - K183l*XZ_9l - K203l*MY_9l + K194l*MZ_9l)*ddq_6l + (D280l*K194l - D302l*K134l - D269l*K150l + D313l*K176l + D291l*K203l + D324l*K183l) 
% \nonumber \\ 
% &+(D328l*K239l - D388l*K176l - D352l*K194l + D364l*K219l + D340l*K250l + D376l*K227l)*ddx + (D329l*K239l - D389l*K176l - D353l*K194l + D365l*K219l + D341l*K250l + D377l*K227l)*ddpsi + (D330l*K239l - D390l*K176l - D354l*K194l + D366l*K219l + D342l*K250l + D378l*K227l)*ddq_imu + (D331l*K239l - D391l*K176l - D355l*K194l + D367l*K219l + D343l*K250l + D379l*K227l)*ddq_w + (D332l*K239l - D392l*K176l - D356l*K194l + D368l*K219l + D344l*K250l + D380l*K227l)*ddq_torso + (D333l*K239l - D393l*K176l - D357l*K194l + D369l*K219l + D345l*K250l + D381l*K227l)*ddq_1l + (D334l*K239l - D394l*K176l - D358l*K194l + D370l*K219l + D346l*K250l + D382l*K227l)*ddq_2l + (D335l*K239l - D395l*K176l - D359l*K194l + D371l*K219l + D347l*K250l + D383l*K227l)*ddq_3l + (D336l*K239l - D396l*K176l - D360l*K194l + D372l*K219l + D348l*K250l + D384l*K227l)*ddq_4l + (D337l*K239l - D397l*K176l - D361l*K194l + D373l*K219l + D349l*K250l + D385l*K227l)*ddq_5l + (D338l*K239l - D398l*K176l - D362l*K194l + D374l*K219l + D350l*K250l + D386l*K227l)*ddq_6l + (K176l*ZZ_10l - K227l*YZ_10l - K219l*XZ_10l - K250l*MX_10l + K239l*MY_10l)*ddq_7l + (D339l*K239l - D399l*K176l - D363l*K194l + D375l*K219l + D351l*K250l + D387l*K227l) 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
X14l = D112l*cos(q_3l) - D64l - D166l*cos(q_3l) - D128l*sin(q_3l) + D88l*K77l + D104l*K84l - D139l*K77l + D148l*K113l + D175l*K99l + D157l*K120l + D184l*K104l - D206l*K113l - D236l*K99l + D196l*K150l + D226l*K134l + D216l*K159l + D246l*K140l - D259l*K150l - D292l*K134l + D270l*K194l + D303l*K176l + D281l*K203l + D314l*K183l - D352l*K194l - D388l*K176l + D328l*K239l + D364l*K219l + D340l*K250l + D376l*K227l;
X15l = D113l*cos(q_3l) - D65l - D167l*cos(q_3l) - D129l*sin(q_3l) + D89l*K77l + D105l*K84l - D140l*K77l + D149l*K113l + D176l*K99l + D158l*K120l + D185l*K104l - D207l*K113l - D237l*K99l + D197l*K150l + D227l*K134l + D217l*K159l + D247l*K140l - D260l*K150l - D293l*K134l + D271l*K194l + D304l*K176l + D282l*K203l + D315l*K183l - D353l*K194l - D389l*K176l + D329l*K239l + D365l*K219l + D341l*K250l + D377l*K227l;
X16l = D114l*cos(q_3l) - D66l - D168l*cos(q_3l) - D130l*sin(q_3l) + D90l*K77l + D106l*K84l - D141l*K77l + D150l*K113l + D177l*K99l + D159l*K120l + D186l*K104l - D208l*K113l - D238l*K99l + D198l*K150l + D228l*K134l + D218l*K159l + D248l*K140l - D261l*K150l - D294l*K134l + D272l*K194l + D305l*K176l + D283l*K203l + D316l*K183l - D354l*K194l - D390l*K176l + D330l*K239l + D366l*K219l + D342l*K250l + D378l*K227l;
X17l = D115l*cos(q_3l) - D67l - D169l*cos(q_3l) - D131l*sin(q_3l) + D91l*K77l + D107l*K84l - D142l*K77l + D151l*K113l + D178l*K99l + D160l*K120l + D187l*K104l - D209l*K113l - D239l*K99l + D199l*K150l + D229l*K134l + D219l*K159l + D249l*K140l - D262l*K150l - D295l*K134l + D273l*K194l + D306l*K176l + D284l*K203l + D317l*K183l - D355l*K194l - D391l*K176l + D331l*K239l + D367l*K219l + D343l*K250l + D379l*K227l;
X18l = D116l*cos(q_3l) - D68l - D170l*cos(q_3l) - D132l*sin(q_3l) + D92l*K77l + D108l*K84l - D143l*K77l + D152l*K113l + D179l*K99l + D161l*K120l + D188l*K104l - D210l*K113l - D240l*K99l + D200l*K150l + D230l*K134l + D220l*K159l + D250l*K140l - D263l*K150l - D296l*K134l + D274l*K194l + D307l*K176l + D285l*K203l + D318l*K183l - D356l*K194l - D392l*K176l + D332l*K239l + D368l*K219l + D344l*K250l + D380l*K227l;
X19l = D117l*cos(q_3l) - D69l - D171l*cos(q_3l) - D133l*sin(q_3l) + D93l*K77l + D109l*K84l - D144l*K77l + D153l*K113l + D180l*K99l + D162l*K120l + D189l*K104l - D211l*K113l - D241l*K99l + D201l*K150l + D231l*K134l + D221l*K159l + D251l*K140l - D264l*K150l - D297l*K134l + D275l*K194l + D308l*K176l + D286l*K203l + D319l*K183l - D357l*K194l - D393l*K176l + D333l*K239l + D369l*K219l + D345l*K250l + D381l*K227l;
X20l = XX_5l + D118l*cos(q_3l) - D172l*cos(q_3l) - D134l*sin(q_3l) + D94l*K77l + D110l*K84l - D145l*K77l + D154l*K113l + D181l*K99l + D163l*K120l + D190l*K104l - D212l*K113l - D242l*K99l + D202l*K150l + D232l*K134l + D222l*K159l + D252l*K140l - D265l*K150l - D298l*K134l + D276l*K194l + D309l*K176l + D287l*K203l + D320l*K183l - D358l*K194l - D394l*K176l + D334l*K239l + D370l*K219l + D346l*K250l + D382l*K227l;
X21l = YZ_6l*sin(q_3l) - XY_6l*cos(q_3l) - D173l*cos(q_3l) - D146l*K77l + D155l*K113l + D182l*K99l + D164l*K120l + D191l*K104l - D213l*K113l - D243l*K99l + D203l*K150l + D233l*K134l + D223l*K159l + D253l*K140l - D266l*K150l - D299l*K134l + D277l*K194l + D310l*K176l + D288l*K203l + D321l*K183l - D359l*K194l - D395l*K176l + D335l*K239l + D371l*K219l + D347l*K250l + D383l*K227l + K84l*MX_6l - K77l*MZ_6l;
X22l = XX_7l*cos(q_3l) - K104l*XZ_7l - K99l*XY_7l - D214l*K113l - D244l*K99l + D204l*K150l + D234l*K134l + D224l*K159l + D254l*K140l - D267l*K150l - D300l*K134l + D278l*K194l + D311l*K176l + D289l*K203l + D322l*K183l - D360l*K194l - D396l*K176l + D336l*K239l + D372l*K219l + D348l*K250l + D384l*K227l - K120l*MY_7l + K113l*MZ_7l;
X23l = K99l*YY_8l - K134l*XY_8l - K140l*YZ_8l - D268l*K150l - D301l*K134l + D279l*K194l + D312l*K176l + D290l*K203l + D323l*K183l - D361l*K194l - D397l*K176l + D337l*K239l + D373l*K219l + D349l*K250l + D385l*K227l + K159l*MX_8l - K150l*MZ_8l;
X24l = K134l*XX_9l - K176l*XY_9l - K183l*XZ_9l - D362l*K194l - D398l*K176l + D338l*K239l + D374l*K219l + D350l*K250l + D386l*K227l - K203l*MY_9l + K194l*MZ_9l;
X25l = K176l*ZZ_10l - K227l*YZ_10l - K219l*XZ_10l - K250l*MX_10l + K239l*MY_10l;
X26l = D119l*cos(q_3l) - D70l - D174l*cos(q_3l) - D135l*sin(q_3l) + D95l*K77l + D111l*K84l - D147l*K77l + D156l*K113l + D183l*K99l + D165l*K120l + D192l*K104l - D215l*K113l - D245l*K99l + D205l*K150l + D235l*K134l + D225l*K159l + D255l*K140l - D269l*K150l - D302l*K134l + D280l*K194l + D313l*K176l + D291l*K203l + D324l*K183l - D363l*K194l - D399l*K176l + D339l*K239l + D375l*K219l + D351l*K250l + D387l*K227l;
% LHS_{dq_2l} &= 0 
% \nonumber \\ 
% LHS_{dq_3l} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_3l} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_3l}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D120l)*ddx + (-D121l)*ddpsi + (-D122l)*ddq_imu + (-D123l)*ddq_w + (-D124l)*ddq_torso + (-D125l)*ddq_1l + (-D126l)*ddq_2l + YY_6l*ddq_3l - D127l 
% \nonumber \\ 
% &+(D175l*cos(q_4l) + D184l*sin(q_4l))*ddx + (D176l*cos(q_4l) + D185l*sin(q_4l))*ddpsi + (D177l*cos(q_4l) + D186l*sin(q_4l))*ddq_imu + (D178l*cos(q_4l) + D187l*sin(q_4l))*ddq_w + (D179l*cos(q_4l) + D188l*sin(q_4l))*ddq_torso + (D180l*cos(q_4l) + D189l*sin(q_4l))*ddq_1l + (D181l*cos(q_4l) + D190l*sin(q_4l))*ddq_2l + (D182l*cos(q_4l) + D191l*sin(q_4l))*ddq_3l + (- XY_7l*cos(q_4l) - XZ_7l*sin(q_4l))*ddq_4l + (D183l*cos(q_4l) + D192l*sin(q_4l)) 
% \nonumber \\ 
% &+(D196l*K151l - D236l*cos(q_4l) + D226l*K135l + D216l*K160l + D246l*K141l)*ddx + (D197l*K151l - D237l*cos(q_4l) + D227l*K135l + D217l*K160l + D247l*K141l)*ddpsi + (D198l*K151l - D238l*cos(q_4l) + D228l*K135l + D218l*K160l + D248l*K141l)*ddq_imu + (D199l*K151l - D239l*cos(q_4l) + D229l*K135l + D219l*K160l + D249l*K141l)*ddq_w + (D200l*K151l - D240l*cos(q_4l) + D230l*K135l + D220l*K160l + D250l*K141l)*ddq_torso + (D201l*K151l - D241l*cos(q_4l) + D231l*K135l + D221l*K160l + D251l*K141l)*ddq_1l + (D202l*K151l - D242l*cos(q_4l) + D232l*K135l + D222l*K160l + D252l*K141l)*ddq_2l + (D203l*K151l - D243l*cos(q_4l) + D233l*K135l + D223l*K160l + D253l*K141l)*ddq_3l + (D204l*K151l - D244l*cos(q_4l) + D234l*K135l + D224l*K160l + D254l*K141l)*ddq_4l + (YY_8l*cos(q_4l) - K141l*YZ_8l - K135l*XY_8l + K160l*MX_8l - K151l*MZ_8l)*ddq_5l + (D205l*K151l - D245l*cos(q_4l) + D235l*K135l + D225l*K160l + D255l*K141l) 
% \nonumber \\ 
% &+(D270l*K195l - D292l*K135l - D259l*K151l + D303l*K177l + D281l*K204l + D314l*K184l)*ddx + (D271l*K195l - D293l*K135l - D260l*K151l + D304l*K177l + D282l*K204l + D315l*K184l)*ddpsi + (D272l*K195l - D294l*K135l - D261l*K151l + D305l*K177l + D283l*K204l + D316l*K184l)*ddq_imu + (D273l*K195l - D295l*K135l - D262l*K151l + D306l*K177l + D284l*K204l + D317l*K184l)*ddq_w + (D274l*K195l - D296l*K135l - D263l*K151l + D307l*K177l + D285l*K204l + D318l*K184l)*ddq_torso + (D275l*K195l - D297l*K135l - D264l*K151l + D308l*K177l + D286l*K204l + D319l*K184l)*ddq_1l + (D276l*K195l - D298l*K135l - D265l*K151l + D309l*K177l + D287l*K204l + D320l*K184l)*ddq_2l + (D277l*K195l - D299l*K135l - D266l*K151l + D310l*K177l + D288l*K204l + D321l*K184l)*ddq_3l + (D278l*K195l - D300l*K135l - D267l*K151l + D311l*K177l + D289l*K204l + D322l*K184l)*ddq_4l + (D279l*K195l - D301l*K135l - D268l*K151l + D312l*K177l + D290l*K204l + D323l*K184l)*ddq_5l + (K135l*XX_9l - K177l*XY_9l - K184l*XZ_9l - K204l*MY_9l + K195l*MZ_9l)*ddq_6l + (D280l*K195l - D302l*K135l - D269l*K151l + D313l*K177l + D291l*K204l + D324l*K184l) 
% \nonumber \\ 
% &+(D328l*K240l - D388l*K177l - D352l*K195l + D364l*K220l + D340l*K251l + D376l*K228l)*ddx + (D329l*K240l - D389l*K177l - D353l*K195l + D365l*K220l + D341l*K251l + D377l*K228l)*ddpsi + (D330l*K240l - D390l*K177l - D354l*K195l + D366l*K220l + D342l*K251l + D378l*K228l)*ddq_imu + (D331l*K240l - D391l*K177l - D355l*K195l + D367l*K220l + D343l*K251l + D379l*K228l)*ddq_w + (D332l*K240l - D392l*K177l - D356l*K195l + D368l*K220l + D344l*K251l + D380l*K228l)*ddq_torso + (D333l*K240l - D393l*K177l - D357l*K195l + D369l*K220l + D345l*K251l + D381l*K228l)*ddq_1l + (D334l*K240l - D394l*K177l - D358l*K195l + D370l*K220l + D346l*K251l + D382l*K228l)*ddq_2l + (D335l*K240l - D395l*K177l - D359l*K195l + D371l*K220l + D347l*K251l + D383l*K228l)*ddq_3l + (D336l*K240l - D396l*K177l - D360l*K195l + D372l*K220l + D348l*K251l + D384l*K228l)*ddq_4l + (D337l*K240l - D397l*K177l - D361l*K195l + D373l*K220l + D349l*K251l + D385l*K228l)*ddq_5l + (D338l*K240l - D398l*K177l - D362l*K195l + D374l*K220l + D350l*K251l + D386l*K228l)*ddq_6l + (K177l*ZZ_10l - K228l*YZ_10l - K220l*XZ_10l - K251l*MX_10l + K240l*MY_10l)*ddq_7l + (D339l*K240l - D399l*K177l - D363l*K195l + D375l*K220l + D351l*K251l + D387l*K228l) 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
X27l = D175l*cos(q_4l) - D120l - D236l*cos(q_4l) + D184l*sin(q_4l) + D196l*K151l + D226l*K135l + D216l*K160l + D246l*K141l - D259l*K151l - D292l*K135l + D270l*K195l + D303l*K177l + D281l*K204l + D314l*K184l - D352l*K195l - D388l*K177l + D328l*K240l + D364l*K220l + D340l*K251l + D376l*K228l;
X28l = D176l*cos(q_4l) - D121l - D237l*cos(q_4l) + D185l*sin(q_4l) + D197l*K151l + D227l*K135l + D217l*K160l + D247l*K141l - D260l*K151l - D293l*K135l + D271l*K195l + D304l*K177l + D282l*K204l + D315l*K184l - D353l*K195l - D389l*K177l + D329l*K240l + D365l*K220l + D341l*K251l + D377l*K228l;
X29l = D177l*cos(q_4l) - D122l - D238l*cos(q_4l) + D186l*sin(q_4l) + D198l*K151l + D228l*K135l + D218l*K160l + D248l*K141l - D261l*K151l - D294l*K135l + D272l*K195l + D305l*K177l + D283l*K204l + D316l*K184l - D354l*K195l - D390l*K177l + D330l*K240l + D366l*K220l + D342l*K251l + D378l*K228l;
X30l = D178l*cos(q_4l) - D123l - D239l*cos(q_4l) + D187l*sin(q_4l) + D199l*K151l + D229l*K135l + D219l*K160l + D249l*K141l - D262l*K151l - D295l*K135l + D273l*K195l + D306l*K177l + D284l*K204l + D317l*K184l - D355l*K195l - D391l*K177l + D331l*K240l + D367l*K220l + D343l*K251l + D379l*K228l;
X31l = D179l*cos(q_4l) - D124l - D240l*cos(q_4l) + D188l*sin(q_4l) + D200l*K151l + D230l*K135l + D220l*K160l + D250l*K141l - D263l*K151l - D296l*K135l + D274l*K195l + D307l*K177l + D285l*K204l + D318l*K184l - D356l*K195l - D392l*K177l + D332l*K240l + D368l*K220l + D344l*K251l + D380l*K228l;
X32l = D180l*cos(q_4l) - D125l - D241l*cos(q_4l) + D189l*sin(q_4l) + D201l*K151l + D231l*K135l + D221l*K160l + D251l*K141l - D264l*K151l - D297l*K135l + D275l*K195l + D308l*K177l + D286l*K204l + D319l*K184l - D357l*K195l - D393l*K177l + D333l*K240l + D369l*K220l + D345l*K251l + D381l*K228l;
X33l = D181l*cos(q_4l) - D126l - D242l*cos(q_4l) + D190l*sin(q_4l) + D202l*K151l + D232l*K135l + D222l*K160l + D252l*K141l - D265l*K151l - D298l*K135l + D276l*K195l + D309l*K177l + D287l*K204l + D320l*K184l - D358l*K195l - D394l*K177l + D334l*K240l + D370l*K220l + D346l*K251l + D382l*K228l;
X34l = YY_6l + D182l*cos(q_4l) - D243l*cos(q_4l) + D191l*sin(q_4l) + D203l*K151l + D233l*K135l + D223l*K160l + D253l*K141l - D266l*K151l - D299l*K135l + D277l*K195l + D310l*K177l + D288l*K204l + D321l*K184l - D359l*K195l - D395l*K177l + D335l*K240l + D371l*K220l + D347l*K251l + D383l*K228l;
X35l = D204l*K151l - XY_7l*cos(q_4l) - XZ_7l*sin(q_4l) - D244l*cos(q_4l) + D234l*K135l + D224l*K160l + D254l*K141l - D267l*K151l - D300l*K135l + D278l*K195l + D311l*K177l + D289l*K204l + D322l*K184l - D360l*K195l - D396l*K177l + D336l*K240l + D372l*K220l + D348l*K251l + D384l*K228l;
X36l = YY_8l*cos(q_4l) - K141l*YZ_8l - K135l*XY_8l - D268l*K151l - D301l*K135l + D279l*K195l + D312l*K177l + D290l*K204l + D323l*K184l - D361l*K195l - D397l*K177l + D337l*K240l + D373l*K220l + D349l*K251l + D385l*K228l + K160l*MX_8l - K151l*MZ_8l;
X37l = K135l*XX_9l - K177l*XY_9l - K184l*XZ_9l - D362l*K195l - D398l*K177l + D338l*K240l + D374l*K220l + D350l*K251l + D386l*K228l - K204l*MY_9l + K195l*MZ_9l;
X38l = K177l*ZZ_10l - K228l*YZ_10l - K220l*XZ_10l - K251l*MX_10l + K240l*MY_10l;
X39l = D183l*cos(q_4l) - D127l - D245l*cos(q_4l) + D192l*sin(q_4l) + D205l*K151l + D235l*K135l + D225l*K160l + D255l*K141l - D269l*K151l - D302l*K135l + D280l*K195l + D313l*K177l + D291l*K204l + D324l*K184l - D363l*K195l - D399l*K177l + D339l*K240l + D375l*K220l + D351l*K251l + D387l*K228l;
% LHS_{dq_3l} &= 0 
% \nonumber \\ 
% LHS_{dq_4l} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_4l} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_4l}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D166l)*ddx + (-D167l)*ddpsi + (-D168l)*ddq_imu + (-D169l)*ddq_w + (-D170l)*ddq_torso + (-D171l)*ddq_1l + (-D172l)*ddq_2l + (-D173l)*ddq_3l + XX_7l*ddq_4l - D174l 
% \nonumber \\ 
% &+(D226l*cos(q_5l) - D246l*sin(q_5l) + D196l*K152l + D216l*K161l)*ddx + (D227l*cos(q_5l) - D247l*sin(q_5l) + D197l*K152l + D217l*K161l)*ddpsi + (D228l*cos(q_5l) - D248l*sin(q_5l) + D198l*K152l + D218l*K161l)*ddq_imu + (D229l*cos(q_5l) - D249l*sin(q_5l) + D199l*K152l + D219l*K161l)*ddq_w + (D230l*cos(q_5l) - D250l*sin(q_5l) + D200l*K152l + D220l*K161l)*ddq_torso + (D231l*cos(q_5l) - D251l*sin(q_5l) + D201l*K152l + D221l*K161l)*ddq_1l + (D232l*cos(q_5l) - D252l*sin(q_5l) + D202l*K152l + D222l*K161l)*ddq_2l + (D233l*cos(q_5l) - D253l*sin(q_5l) + D203l*K152l + D223l*K161l)*ddq_3l + (D234l*cos(q_5l) - D254l*sin(q_5l) + D204l*K152l + D224l*K161l)*ddq_4l + (YZ_8l*sin(q_5l) - XY_8l*cos(q_5l) + K161l*MX_8l - K152l*MZ_8l)*ddq_5l + (D235l*cos(q_5l) - D255l*sin(q_5l) + D205l*K152l + D225l*K161l) 
% \nonumber \\ 
% &+(D270l*K196l - D259l*K152l - D292l*cos(q_5l) + D303l*K178l + D281l*K205l + D314l*K185l)*ddx + (D271l*K196l - D260l*K152l - D293l*cos(q_5l) + D304l*K178l + D282l*K205l + D315l*K185l)*ddpsi + (D272l*K196l - D261l*K152l - D294l*cos(q_5l) + D305l*K178l + D283l*K205l + D316l*K185l)*ddq_imu + (D273l*K196l - D262l*K152l - D295l*cos(q_5l) + D306l*K178l + D284l*K205l + D317l*K185l)*ddq_w + (D274l*K196l - D263l*K152l - D296l*cos(q_5l) + D307l*K178l + D285l*K205l + D318l*K185l)*ddq_torso + (D275l*K196l - D264l*K152l - D297l*cos(q_5l) + D308l*K178l + D286l*K205l + D319l*K185l)*ddq_1l + (D276l*K196l - D265l*K152l - D298l*cos(q_5l) + D309l*K178l + D287l*K205l + D320l*K185l)*ddq_2l + (D277l*K196l - D266l*K152l - D299l*cos(q_5l) + D310l*K178l + D288l*K205l + D321l*K185l)*ddq_3l + (D278l*K196l - D267l*K152l - D300l*cos(q_5l) + D311l*K178l + D289l*K205l + D322l*K185l)*ddq_4l + (D279l*K196l - D268l*K152l - D301l*cos(q_5l) + D312l*K178l + D290l*K205l + D323l*K185l)*ddq_5l + (XX_9l*cos(q_5l) - K185l*XZ_9l - K178l*XY_9l - K205l*MY_9l + K196l*MZ_9l)*ddq_6l + (D280l*K196l - D269l*K152l - D302l*cos(q_5l) + D313l*K178l + D291l*K205l + D324l*K185l) 
% \nonumber \\ 
% &+(D328l*K241l - D388l*K178l - D352l*K196l + D364l*K221l + D340l*K252l + D376l*K229l)*ddx + (D329l*K241l - D389l*K178l - D353l*K196l + D365l*K221l + D341l*K252l + D377l*K229l)*ddpsi + (D330l*K241l - D390l*K178l - D354l*K196l + D366l*K221l + D342l*K252l + D378l*K229l)*ddq_imu + (D331l*K241l - D391l*K178l - D355l*K196l + D367l*K221l + D343l*K252l + D379l*K229l)*ddq_w + (D332l*K241l - D392l*K178l - D356l*K196l + D368l*K221l + D344l*K252l + D380l*K229l)*ddq_torso + (D333l*K241l - D393l*K178l - D357l*K196l + D369l*K221l + D345l*K252l + D381l*K229l)*ddq_1l + (D334l*K241l - D394l*K178l - D358l*K196l + D370l*K221l + D346l*K252l + D382l*K229l)*ddq_2l + (D335l*K241l - D395l*K178l - D359l*K196l + D371l*K221l + D347l*K252l + D383l*K229l)*ddq_3l + (D336l*K241l - D396l*K178l - D360l*K196l + D372l*K221l + D348l*K252l + D384l*K229l)*ddq_4l + (D337l*K241l - D397l*K178l - D361l*K196l + D373l*K221l + D349l*K252l + D385l*K229l)*ddq_5l + (D338l*K241l - D398l*K178l - D362l*K196l + D374l*K221l + D350l*K252l + D386l*K229l)*ddq_6l + (K178l*ZZ_10l - K229l*YZ_10l - K221l*XZ_10l - K252l*MX_10l + K241l*MY_10l)*ddq_7l + (D339l*K241l - D399l*K178l - D363l*K196l + D375l*K221l + D351l*K252l + D387l*K229l) 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
X40l = D226l*cos(q_5l) - D166l - D292l*cos(q_5l) - D246l*sin(q_5l) + D196l*K152l + D216l*K161l - D259l*K152l + D270l*K196l + D303l*K178l + D281l*K205l + D314l*K185l - D352l*K196l - D388l*K178l + D328l*K241l + D364l*K221l + D340l*K252l + D376l*K229l;
X41l = D227l*cos(q_5l) - D167l - D293l*cos(q_5l) - D247l*sin(q_5l) + D197l*K152l + D217l*K161l - D260l*K152l + D271l*K196l + D304l*K178l + D282l*K205l + D315l*K185l - D353l*K196l - D389l*K178l + D329l*K241l + D365l*K221l + D341l*K252l + D377l*K229l;
X42l = D228l*cos(q_5l) - D168l - D294l*cos(q_5l) - D248l*sin(q_5l) + D198l*K152l + D218l*K161l - D261l*K152l + D272l*K196l + D305l*K178l + D283l*K205l + D316l*K185l - D354l*K196l - D390l*K178l + D330l*K241l + D366l*K221l + D342l*K252l + D378l*K229l;
X43l = D229l*cos(q_5l) - D169l - D295l*cos(q_5l) - D249l*sin(q_5l) + D199l*K152l + D219l*K161l - D262l*K152l + D273l*K196l + D306l*K178l + D284l*K205l + D317l*K185l - D355l*K196l - D391l*K178l + D331l*K241l + D367l*K221l + D343l*K252l + D379l*K229l;
X44l = D230l*cos(q_5l) - D170l - D296l*cos(q_5l) - D250l*sin(q_5l) + D200l*K152l + D220l*K161l - D263l*K152l + D274l*K196l + D307l*K178l + D285l*K205l + D318l*K185l - D356l*K196l - D392l*K178l + D332l*K241l + D368l*K221l + D344l*K252l + D380l*K229l;
X45l = D231l*cos(q_5l) - D171l - D297l*cos(q_5l) - D251l*sin(q_5l) + D201l*K152l + D221l*K161l - D264l*K152l + D275l*K196l + D308l*K178l + D286l*K205l + D319l*K185l - D357l*K196l - D393l*K178l + D333l*K241l + D369l*K221l + D345l*K252l + D381l*K229l;
X46l = D232l*cos(q_5l) - D172l - D298l*cos(q_5l) - D252l*sin(q_5l) + D202l*K152l + D222l*K161l - D265l*K152l + D276l*K196l + D309l*K178l + D287l*K205l + D320l*K185l - D358l*K196l - D394l*K178l + D334l*K241l + D370l*K221l + D346l*K252l + D382l*K229l;
X47l = D233l*cos(q_5l) - D173l - D299l*cos(q_5l) - D253l*sin(q_5l) + D203l*K152l + D223l*K161l - D266l*K152l + D277l*K196l + D310l*K178l + D288l*K205l + D321l*K185l - D359l*K196l - D395l*K178l + D335l*K241l + D371l*K221l + D347l*K252l + D383l*K229l;
X48l = XX_7l + D234l*cos(q_5l) - D300l*cos(q_5l) - D254l*sin(q_5l) + D204l*K152l + D224l*K161l - D267l*K152l + D278l*K196l + D311l*K178l + D289l*K205l + D322l*K185l - D360l*K196l - D396l*K178l + D336l*K241l + D372l*K221l + D348l*K252l + D384l*K229l;
X49l = YZ_8l*sin(q_5l) - XY_8l*cos(q_5l) - D301l*cos(q_5l) - D268l*K152l + D279l*K196l + D312l*K178l + D290l*K205l + D323l*K185l - D361l*K196l - D397l*K178l + D337l*K241l + D373l*K221l + D349l*K252l + D385l*K229l + K161l*MX_8l - K152l*MZ_8l;
X50l = XX_9l*cos(q_5l) - K185l*XZ_9l - K178l*XY_9l - D362l*K196l - D398l*K178l + D338l*K241l + D374l*K221l + D350l*K252l + D386l*K229l - K205l*MY_9l + K196l*MZ_9l;
X51l = K178l*ZZ_10l - K229l*YZ_10l - K221l*XZ_10l - K252l*MX_10l + K241l*MY_10l;
X52l = D235l*cos(q_5l) - D174l - D302l*cos(q_5l) - D255l*sin(q_5l) + D205l*K152l + D225l*K161l - D269l*K152l + D280l*K196l + D313l*K178l + D291l*K205l + D324l*K185l - D363l*K196l - D399l*K178l + D339l*K241l + D375l*K221l + D351l*K252l + D387l*K229l;
% LHS_{dq_4l} &= 0 
% \nonumber \\ 
% LHS_{dq_5l} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_5l} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_5l}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D236l)*ddx + (-D237l)*ddpsi + (-D238l)*ddq_imu + (-D239l)*ddq_w + (-D240l)*ddq_torso + (-D241l)*ddq_1l + (-D242l)*ddq_2l + (-D243l)*ddq_3l + (-D244l)*ddq_4l + YY_8l*ddq_5l - D245l 
% \nonumber \\ 
% &+(D303l*cos(q_6l) + D314l*sin(q_6l))*ddx + (D304l*cos(q_6l) + D315l*sin(q_6l))*ddpsi + (D305l*cos(q_6l) + D316l*sin(q_6l))*ddq_imu + (D306l*cos(q_6l) + D317l*sin(q_6l))*ddq_w + (D307l*cos(q_6l) + D318l*sin(q_6l))*ddq_torso + (D308l*cos(q_6l) + D319l*sin(q_6l))*ddq_1l + (D309l*cos(q_6l) + D320l*sin(q_6l))*ddq_2l + (D310l*cos(q_6l) + D321l*sin(q_6l))*ddq_3l + (D311l*cos(q_6l) + D322l*sin(q_6l))*ddq_4l + (D312l*cos(q_6l) + D323l*sin(q_6l))*ddq_5l + (- XY_9l*cos(q_6l) - XZ_9l*sin(q_6l))*ddq_6l + (D313l*cos(q_6l) + D324l*sin(q_6l)) 
% \nonumber \\ 
% &+(D328l*K242l - D388l*cos(q_6l) + D364l*K222l + D340l*K253l + D376l*K230l)*ddx + (D329l*K242l - D389l*cos(q_6l) + D365l*K222l + D341l*K253l + D377l*K230l)*ddpsi + (D330l*K242l - D390l*cos(q_6l) + D366l*K222l + D342l*K253l + D378l*K230l)*ddq_imu + (D331l*K242l - D391l*cos(q_6l) + D367l*K222l + D343l*K253l + D379l*K230l)*ddq_w + (D332l*K242l - D392l*cos(q_6l) + D368l*K222l + D344l*K253l + D380l*K230l)*ddq_torso + (D333l*K242l - D393l*cos(q_6l) + D369l*K222l + D345l*K253l + D381l*K230l)*ddq_1l + (D334l*K242l - D394l*cos(q_6l) + D370l*K222l + D346l*K253l + D382l*K230l)*ddq_2l + (D335l*K242l - D395l*cos(q_6l) + D371l*K222l + D347l*K253l + D383l*K230l)*ddq_3l + (D336l*K242l - D396l*cos(q_6l) + D372l*K222l + D348l*K253l + D384l*K230l)*ddq_4l + (D337l*K242l - D397l*cos(q_6l) + D373l*K222l + D349l*K253l + D385l*K230l)*ddq_5l + (D338l*K242l - D398l*cos(q_6l) + D374l*K222l + D350l*K253l + D386l*K230l)*ddq_6l + (ZZ_10l*cos(q_6l) - K230l*YZ_10l - K222l*XZ_10l - K253l*MX_10l + K242l*MY_10l)*ddq_7l + (D339l*K242l - D399l*cos(q_6l) + D375l*K222l + D351l*K253l + D387l*K230l) 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
X53l = D303l*cos(q_6l) - D236l - D388l*cos(q_6l) + D314l*sin(q_6l) + D328l*K242l + D364l*K222l + D340l*K253l + D376l*K230l;
X54l = D304l*cos(q_6l) - D237l - D389l*cos(q_6l) + D315l*sin(q_6l) + D329l*K242l + D365l*K222l + D341l*K253l + D377l*K230l;
X55l = D305l*cos(q_6l) - D238l - D390l*cos(q_6l) + D316l*sin(q_6l) + D330l*K242l + D366l*K222l + D342l*K253l + D378l*K230l;
X56l = D306l*cos(q_6l) - D239l - D391l*cos(q_6l) + D317l*sin(q_6l) + D331l*K242l + D367l*K222l + D343l*K253l + D379l*K230l;
X57l = D307l*cos(q_6l) - D240l - D392l*cos(q_6l) + D318l*sin(q_6l) + D332l*K242l + D368l*K222l + D344l*K253l + D380l*K230l;
X58l = D308l*cos(q_6l) - D241l - D393l*cos(q_6l) + D319l*sin(q_6l) + D333l*K242l + D369l*K222l + D345l*K253l + D381l*K230l;
X59l = D309l*cos(q_6l) - D242l - D394l*cos(q_6l) + D320l*sin(q_6l) + D334l*K242l + D370l*K222l + D346l*K253l + D382l*K230l;
X60l = D310l*cos(q_6l) - D243l - D395l*cos(q_6l) + D321l*sin(q_6l) + D335l*K242l + D371l*K222l + D347l*K253l + D383l*K230l;
X61l = D311l*cos(q_6l) - D244l - D396l*cos(q_6l) + D322l*sin(q_6l) + D336l*K242l + D372l*K222l + D348l*K253l + D384l*K230l;
X62l = YY_8l + D312l*cos(q_6l) - D397l*cos(q_6l) + D323l*sin(q_6l) + D337l*K242l + D373l*K222l + D349l*K253l + D385l*K230l;
X63l = D338l*K242l - XY_9l*cos(q_6l) - XZ_9l*sin(q_6l) - D398l*cos(q_6l) + D374l*K222l + D350l*K253l + D386l*K230l;
X64l = ZZ_10l*cos(q_6l) - K230l*YZ_10l - K222l*XZ_10l - K253l*MX_10l + K242l*MY_10l;
X65l = D313l*cos(q_6l) - D245l - D399l*cos(q_6l) + D324l*sin(q_6l) + D339l*K242l + D375l*K222l + D351l*K253l + D387l*K230l;
% LHS_{dq_5l} &= 0 
% \nonumber \\ 
% LHS_{dq_6l} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_6l} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_6l}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D292l)*ddx + (-D293l)*ddpsi + (-D294l)*ddq_imu + (-D295l)*ddq_w + (-D296l)*ddq_torso + (-D297l)*ddq_1l + (-D298l)*ddq_2l + (-D299l)*ddq_3l + (-D300l)*ddq_4l + (-D301l)*ddq_5l + XX_9l*ddq_6l - D302l 
% \nonumber \\ 
% &+(D364l*cos(q_7l) + D376l*sin(q_7l) + D328l*K243l + D340l*K254l)*ddx + (D365l*cos(q_7l) + D377l*sin(q_7l) + D329l*K243l + D341l*K254l)*ddpsi + (D366l*cos(q_7l) + D378l*sin(q_7l) + D330l*K243l + D342l*K254l)*ddq_imu + (D367l*cos(q_7l) + D379l*sin(q_7l) + D331l*K243l + D343l*K254l)*ddq_w + (D368l*cos(q_7l) + D380l*sin(q_7l) + D332l*K243l + D344l*K254l)*ddq_torso + (D369l*cos(q_7l) + D381l*sin(q_7l) + D333l*K243l + D345l*K254l)*ddq_1l + (D370l*cos(q_7l) + D382l*sin(q_7l) + D334l*K243l + D346l*K254l)*ddq_2l + (D371l*cos(q_7l) + D383l*sin(q_7l) + D335l*K243l + D347l*K254l)*ddq_3l + (D372l*cos(q_7l) + D384l*sin(q_7l) + D336l*K243l + D348l*K254l)*ddq_4l + (D373l*cos(q_7l) + D385l*sin(q_7l) + D337l*K243l + D349l*K254l)*ddq_5l + (D374l*cos(q_7l) + D386l*sin(q_7l) + D338l*K243l + D350l*K254l)*ddq_6l + (K243l*MY_10l - YZ_10l*sin(q_7l) - K254l*MX_10l - XZ_10l*cos(q_7l))*ddq_7l + (D375l*cos(q_7l) + D387l*sin(q_7l) + D339l*K243l + D351l*K254l) 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
X66l = D364l*cos(q_7l) - D292l + D376l*sin(q_7l) + D328l*K243l + D340l*K254l;
X67l = D365l*cos(q_7l) - D293l + D377l*sin(q_7l) + D329l*K243l + D341l*K254l;
X68l = D366l*cos(q_7l) - D294l + D378l*sin(q_7l) + D330l*K243l + D342l*K254l;
X69l = D367l*cos(q_7l) - D295l + D379l*sin(q_7l) + D331l*K243l + D343l*K254l;
X70l = D368l*cos(q_7l) - D296l + D380l*sin(q_7l) + D332l*K243l + D344l*K254l;
X71l = D369l*cos(q_7l) - D297l + D381l*sin(q_7l) + D333l*K243l + D345l*K254l;
X72l = D370l*cos(q_7l) - D298l + D382l*sin(q_7l) + D334l*K243l + D346l*K254l;
X73l = D371l*cos(q_7l) - D299l + D383l*sin(q_7l) + D335l*K243l + D347l*K254l;
X74l = D372l*cos(q_7l) - D300l + D384l*sin(q_7l) + D336l*K243l + D348l*K254l;
X75l = D373l*cos(q_7l) - D301l + D385l*sin(q_7l) + D337l*K243l + D349l*K254l;
X76l = XX_9l + D374l*cos(q_7l) + D386l*sin(q_7l) + D338l*K243l + D350l*K254l;
X77l = K243l*MY_10l - YZ_10l*sin(q_7l) - K254l*MX_10l - XZ_10l*cos(q_7l);
X78l = D375l*cos(q_7l) - D302l + D387l*sin(q_7l) + D339l*K243l + D351l*K254l;
% LHS_{dq_6l} &= 0 
% \nonumber \\ 
% LHS_{dq_7l} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_7l} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_7l}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D388l)*ddx + (-D389l)*ddpsi + (-D390l)*ddq_imu + (-D391l)*ddq_w + (-D392l)*ddq_torso + (-D393l)*ddq_1l + (-D394l)*ddq_2l + (-D395l)*ddq_3l + (-D396l)*ddq_4l + (-D397l)*ddq_5l + (-D398l)*ddq_6l + ZZ_10l*ddq_7l - D399l 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% LHS_{dq_7l} &= 0 
% \nonumber \\ 
% LHS_{dq_1r} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_1r} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_1r}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D28r)*ddx + (-D29r)*ddpsi + (-D30r)*ddq_imu + (-D31r)*ddq_w + (-D32r)*ddq_torso + YY_4r*ddq_1r - D33r 
% \nonumber \\ 
% &+(D71r*cos(q_2r) + D78r*sin(q_2r))*ddx + (D72r*cos(q_2r) + D79r*sin(q_2r))*ddpsi + (D73r*cos(q_2r) + D80r*sin(q_2r))*ddq_imu + (D74r*cos(q_2r) + D81r*sin(q_2r))*ddq_w + (D75r*cos(q_2r) + D82r*sin(q_2r))*ddq_torso + (D76r*cos(q_2r) + D83r*sin(q_2r))*ddq_1r + (- XY_5r*cos(q_2r) - XZ_5r*sin(q_2r))*ddq_2r + (D77r*cos(q_2r) + D84r*sin(q_2r)) 
% \nonumber \\ 
% &+(D88r*K76r - D120r*cos(q_2r) + D112r*K64r + D104r*K83r + D128r*K68r)*ddx + (D89r*K76r - D121r*cos(q_2r) + D113r*K64r + D105r*K83r + D129r*K68r)*ddpsi + (D90r*K76r - D122r*cos(q_2r) + D114r*K64r + D106r*K83r + D130r*K68r)*ddq_imu + (D91r*K76r - D123r*cos(q_2r) + D115r*K64r + D107r*K83r + D131r*K68r)*ddq_w + (D92r*K76r - D124r*cos(q_2r) + D116r*K64r + D108r*K83r + D132r*K68r)*ddq_torso + (D93r*K76r - D125r*cos(q_2r) + D117r*K64r + D109r*K83r + D133r*K68r)*ddq_1r + (D94r*K76r - D126r*cos(q_2r) + D118r*K64r + D110r*K83r + D134r*K68r)*ddq_2r + (YY_6r*cos(q_2r) - K68r*YZ_6r - K64r*XY_6r + K83r*MX_6r - K76r*MZ_6r)*ddq_3r + (D95r*K76r - D127r*cos(q_2r) + D119r*K64r + D111r*K83r + D135r*K68r) 
% \nonumber \\ 
% &+(D148r*K112r - D166r*K64r - D139r*K76r + D175r*K98r + D157r*K119r + D184r*K103r)*ddx + (D149r*K112r - D167r*K64r - D140r*K76r + D176r*K98r + D158r*K119r + D185r*K103r)*ddpsi + (D150r*K112r - D168r*K64r - D141r*K76r + D177r*K98r + D159r*K119r + D186r*K103r)*ddq_imu + (D151r*K112r - D169r*K64r - D142r*K76r + D178r*K98r + D160r*K119r + D187r*K103r)*ddq_w + (D152r*K112r - D170r*K64r - D143r*K76r + D179r*K98r + D161r*K119r + D188r*K103r)*ddq_torso + (D153r*K112r - D171r*K64r - D144r*K76r + D180r*K98r + D162r*K119r + D189r*K103r)*ddq_1r + (D154r*K112r - D172r*K64r - D145r*K76r + D181r*K98r + D163r*K119r + D190r*K103r)*ddq_2r + (D155r*K112r - D173r*K64r - D146r*K76r + D182r*K98r + D164r*K119r + D191r*K103r)*ddq_3r + (K64r*XX_7r - K98r*XY_7r - K103r*XZ_7r - K119r*MY_7r + K112r*MZ_7r)*ddq_4r + (D156r*K112r - D174r*K64r - D147r*K76r + D183r*K98r + D165r*K119r + D192r*K103r) 
% \nonumber \\ 
% &+(D196r*K149r - D236r*K98r - D206r*K112r + D226r*K133r + D216r*K158r + D246r*K139r)*ddx + (D197r*K149r - D237r*K98r - D207r*K112r + D227r*K133r + D217r*K158r + D247r*K139r)*ddpsi + (D198r*K149r - D238r*K98r - D208r*K112r + D228r*K133r + D218r*K158r + D248r*K139r)*ddq_imu + (D199r*K149r - D239r*K98r - D209r*K112r + D229r*K133r + D219r*K158r + D249r*K139r)*ddq_w + (D200r*K149r - D240r*K98r - D210r*K112r + D230r*K133r + D220r*K158r + D250r*K139r)*ddq_torso + (D201r*K149r - D241r*K98r - D211r*K112r + D231r*K133r + D221r*K158r + D251r*K139r)*ddq_1r + (D202r*K149r - D242r*K98r - D212r*K112r + D232r*K133r + D222r*K158r + D252r*K139r)*ddq_2r + (D203r*K149r - D243r*K98r - D213r*K112r + D233r*K133r + D223r*K158r + D253r*K139r)*ddq_3r + (D204r*K149r - D244r*K98r - D214r*K112r + D234r*K133r + D224r*K158r + D254r*K139r)*ddq_4r + (K98r*YY_8r - K133r*XY_8r - K139r*YZ_8r + K158r*MX_8r - K149r*MZ_8r)*ddq_5r + (D205r*K149r - D245r*K98r - D215r*K112r + D235r*K133r + D225r*K158r + D255r*K139r) 
% \nonumber \\ 
% &+(D270r*K193r - D292r*K133r - D259r*K149r + D303r*K175r + D281r*K202r + D314r*K182r)*ddx + (D271r*K193r - D293r*K133r - D260r*K149r + D304r*K175r + D282r*K202r + D315r*K182r)*ddpsi + (D272r*K193r - D294r*K133r - D261r*K149r + D305r*K175r + D283r*K202r + D316r*K182r)*ddq_imu + (D273r*K193r - D295r*K133r - D262r*K149r + D306r*K175r + D284r*K202r + D317r*K182r)*ddq_w + (D274r*K193r - D296r*K133r - D263r*K149r + D307r*K175r + D285r*K202r + D318r*K182r)*ddq_torso + (D275r*K193r - D297r*K133r - D264r*K149r + D308r*K175r + D286r*K202r + D319r*K182r)*ddq_1r + (D276r*K193r - D298r*K133r - D265r*K149r + D309r*K175r + D287r*K202r + D320r*K182r)*ddq_2r + (D277r*K193r - D299r*K133r - D266r*K149r + D310r*K175r + D288r*K202r + D321r*K182r)*ddq_3r + (D278r*K193r - D300r*K133r - D267r*K149r + D311r*K175r + D289r*K202r + D322r*K182r)*ddq_4r + (D279r*K193r - D301r*K133r - D268r*K149r + D312r*K175r + D290r*K202r + D323r*K182r)*ddq_5r + (K133r*XX_9r - K175r*XY_9r - K182r*XZ_9r - K202r*MY_9r + K193r*MZ_9r)*ddq_6r + (D280r*K193r - D302r*K133r - D269r*K149r + D313r*K175r + D291r*K202r + D324r*K182r) 
% \nonumber \\ 
% &+(D328r*K238r - D388r*K175r - D352r*K193r + D364r*K218r + D340r*K249r + D376r*K226r)*ddx + (D329r*K238r - D389r*K175r - D353r*K193r + D365r*K218r + D341r*K249r + D377r*K226r)*ddpsi + (D330r*K238r - D390r*K175r - D354r*K193r + D366r*K218r + D342r*K249r + D378r*K226r)*ddq_imu + (D331r*K238r - D391r*K175r - D355r*K193r + D367r*K218r + D343r*K249r + D379r*K226r)*ddq_w + (D332r*K238r - D392r*K175r - D356r*K193r + D368r*K218r + D344r*K249r + D380r*K226r)*ddq_torso + (D333r*K238r - D393r*K175r - D357r*K193r + D369r*K218r + D345r*K249r + D381r*K226r)*ddq_1r + (D334r*K238r - D394r*K175r - D358r*K193r + D370r*K218r + D346r*K249r + D382r*K226r)*ddq_2r + (D335r*K238r - D395r*K175r - D359r*K193r + D371r*K218r + D347r*K249r + D383r*K226r)*ddq_3r + (D336r*K238r - D396r*K175r - D360r*K193r + D372r*K218r + D348r*K249r + D384r*K226r)*ddq_4r + (D337r*K238r - D397r*K175r - D361r*K193r + D373r*K218r + D349r*K249r + D385r*K226r)*ddq_5r + (D338r*K238r - D398r*K175r - D362r*K193r + D374r*K218r + D350r*K249r + D386r*K226r)*ddq_6r + (K175r*ZZ_10r - K226r*YZ_10r - K218r*XZ_10r - K249r*MX_10r + K238r*MY_10r)*ddq_7r + (D339r*K238r - D399r*K175r - D363r*K193r + D375r*K218r + D351r*K249r + D387r*K226r) 
% \nonumber \\ 
X1r = D71r*cos(q_2r) - D28r - D120r*cos(q_2r) + D78r*sin(q_2r) + D88r*K76r + D112r*K64r + D104r*K83r + D128r*K68r - D139r*K76r - D166r*K64r + D148r*K112r + D175r*K98r + D157r*K119r + D184r*K103r - D206r*K112r - D236r*K98r + D196r*K149r + D226r*K133r + D216r*K158r + D246r*K139r - D259r*K149r - D292r*K133r + D270r*K193r + D303r*K175r + D281r*K202r + D314r*K182r - D352r*K193r - D388r*K175r + D328r*K238r + D364r*K218r + D340r*K249r + D376r*K226r;
X2r = D72r*cos(q_2r) - D29r - D121r*cos(q_2r) + D79r*sin(q_2r) + D89r*K76r + D113r*K64r + D105r*K83r + D129r*K68r - D140r*K76r - D167r*K64r + D149r*K112r + D176r*K98r + D158r*K119r + D185r*K103r - D207r*K112r - D237r*K98r + D197r*K149r + D227r*K133r + D217r*K158r + D247r*K139r - D260r*K149r - D293r*K133r + D271r*K193r + D304r*K175r + D282r*K202r + D315r*K182r - D353r*K193r - D389r*K175r + D329r*K238r + D365r*K218r + D341r*K249r + D377r*K226r;
X3r = D73r*cos(q_2r) - D30r - D122r*cos(q_2r) + D80r*sin(q_2r) + D90r*K76r + D114r*K64r + D106r*K83r + D130r*K68r - D141r*K76r - D168r*K64r + D150r*K112r + D177r*K98r + D159r*K119r + D186r*K103r - D208r*K112r - D238r*K98r + D198r*K149r + D228r*K133r + D218r*K158r + D248r*K139r - D261r*K149r - D294r*K133r + D272r*K193r + D305r*K175r + D283r*K202r + D316r*K182r - D354r*K193r - D390r*K175r + D330r*K238r + D366r*K218r + D342r*K249r + D378r*K226r;
X4r = D74r*cos(q_2r) - D31r - D123r*cos(q_2r) + D81r*sin(q_2r) + D91r*K76r + D115r*K64r + D107r*K83r + D131r*K68r - D142r*K76r - D169r*K64r + D151r*K112r + D178r*K98r + D160r*K119r + D187r*K103r - D209r*K112r - D239r*K98r + D199r*K149r + D229r*K133r + D219r*K158r + D249r*K139r - D262r*K149r - D295r*K133r + D273r*K193r + D306r*K175r + D284r*K202r + D317r*K182r - D355r*K193r - D391r*K175r + D331r*K238r + D367r*K218r + D343r*K249r + D379r*K226r;
X5r = D75r*cos(q_2r) - D32r - D124r*cos(q_2r) + D82r*sin(q_2r) + D92r*K76r + D116r*K64r + D108r*K83r + D132r*K68r - D143r*K76r - D170r*K64r + D152r*K112r + D179r*K98r + D161r*K119r + D188r*K103r - D210r*K112r - D240r*K98r + D200r*K149r + D230r*K133r + D220r*K158r + D250r*K139r - D263r*K149r - D296r*K133r + D274r*K193r + D307r*K175r + D285r*K202r + D318r*K182r - D356r*K193r - D392r*K175r + D332r*K238r + D368r*K218r + D344r*K249r + D380r*K226r;
X6r = YY_4r + D76r*cos(q_2r) - D125r*cos(q_2r) + D83r*sin(q_2r) + D93r*K76r + D117r*K64r + D109r*K83r + D133r*K68r - D144r*K76r - D171r*K64r + D153r*K112r + D180r*K98r + D162r*K119r + D189r*K103r - D211r*K112r - D241r*K98r + D201r*K149r + D231r*K133r + D221r*K158r + D251r*K139r - D264r*K149r - D297r*K133r + D275r*K193r + D308r*K175r + D286r*K202r + D319r*K182r - D357r*K193r - D393r*K175r + D333r*K238r + D369r*K218r + D345r*K249r + D381r*K226r;
X7r = D94r*K76r - XY_5r*cos(q_2r) - XZ_5r*sin(q_2r) - D126r*cos(q_2r) + D118r*K64r + D110r*K83r + D134r*K68r - D145r*K76r - D172r*K64r + D154r*K112r + D181r*K98r + D163r*K119r + D190r*K103r - D212r*K112r - D242r*K98r + D202r*K149r + D232r*K133r + D222r*K158r + D252r*K139r - D265r*K149r - D298r*K133r + D276r*K193r + D309r*K175r + D287r*K202r + D320r*K182r - D358r*K193r - D394r*K175r + D334r*K238r + D370r*K218r + D346r*K249r + D382r*K226r;
X8r = YY_6r*cos(q_2r) - K68r*YZ_6r - K64r*XY_6r - D146r*K76r - D173r*K64r + D155r*K112r + D182r*K98r + D164r*K119r + D191r*K103r - D213r*K112r - D243r*K98r + D203r*K149r + D233r*K133r + D223r*K158r + D253r*K139r - D266r*K149r - D299r*K133r + D277r*K193r + D310r*K175r + D288r*K202r + D321r*K182r - D359r*K193r - D395r*K175r + D335r*K238r + D371r*K218r + D347r*K249r + D383r*K226r + K83r*MX_6r - K76r*MZ_6r;
X9r = K64r*XX_7r - K98r*XY_7r - K103r*XZ_7r - D214r*K112r - D244r*K98r + D204r*K149r + D234r*K133r + D224r*K158r + D254r*K139r - D267r*K149r - D300r*K133r + D278r*K193r + D311r*K175r + D289r*K202r + D322r*K182r - D360r*K193r - D396r*K175r + D336r*K238r + D372r*K218r + D348r*K249r + D384r*K226r - K119r*MY_7r + K112r*MZ_7r;
X10r = K98r*YY_8r - K133r*XY_8r - K139r*YZ_8r - D268r*K149r - D301r*K133r + D279r*K193r + D312r*K175r + D290r*K202r + D323r*K182r - D361r*K193r - D397r*K175r + D337r*K238r + D373r*K218r + D349r*K249r + D385r*K226r + K158r*MX_8r - K149r*MZ_8r;
X11r = K133r*XX_9r - K175r*XY_9r - K182r*XZ_9r - D362r*K193r - D398r*K175r + D338r*K238r + D374r*K218r + D350r*K249r + D386r*K226r - K202r*MY_9r + K193r*MZ_9r;
X12r = K175r*ZZ_10r - K226r*YZ_10r - K218r*XZ_10r - K249r*MX_10r + K238r*MY_10r;
X13r = D77r*cos(q_2r) - D33r - D127r*cos(q_2r) + D84r*sin(q_2r) + D95r*K76r + D119r*K64r + D111r*K83r + D135r*K68r - D147r*K76r - D174r*K64r + D156r*K112r + D183r*K98r + D165r*K119r + D192r*K103r - D215r*K112r - D245r*K98r + D205r*K149r + D235r*K133r + D225r*K158r + D255r*K139r - D269r*K149r - D302r*K133r + D280r*K193r + D313r*K175r + D291r*K202r + D324r*K182r - D363r*K193r - D399r*K175r + D339r*K238r + D375r*K218r + D351r*K249r + D387r*K226r;
% LHS_{dq_1r} &= (D328r*K238r - D388r*K175r - D352r*K193r + D364r*K218r + D340r*K249r + D376r*K226r)*ddx + (D329r*K238r - D389r*K175r - D353r*K193r + D365r*K218r + D341r*K249r + D377r*K226r)*ddpsi + (D330r*K238r - D390r*K175r - D354r*K193r + D366r*K218r + D342r*K249r + D378r*K226r)*ddq_imu + (D331r*K238r - D391r*K175r - D355r*K193r + D367r*K218r + D343r*K249r + D379r*K226r)*ddq_w + (D332r*K238r - D392r*K175r - D356r*K193r + D368r*K218r + D344r*K249r + D380r*K226r)*ddq_torso + (D333r*K238r - D393r*K175r - D357r*K193r + D369r*K218r + D345r*K249r + D381r*K226r)*ddq_1r + (D334r*K238r - D394r*K175r - D358r*K193r + D370r*K218r + D346r*K249r + D382r*K226r)*ddq_2r + (D335r*K238r - D395r*K175r - D359r*K193r + D371r*K218r + D347r*K249r + D383r*K226r)*ddq_3r + (D336r*K238r - D396r*K175r - D360r*K193r + D372r*K218r + D348r*K249r + D384r*K226r)*ddq_4r + (D337r*K238r - D397r*K175r - D361r*K193r + D373r*K218r + D349r*K249r + D385r*K226r)*ddq_5r + (D338r*K238r - D398r*K175r - D362r*K193r + D374r*K218r + D350r*K249r + D386r*K226r)*ddq_6r + (K175r*ZZ_10r - K226r*YZ_10r - K218r*XZ_10r - K249r*MX_10r + K238r*MY_10r)*ddq_7r + (D339r*K238r - D399r*K175r - D363r*K193r + D375r*K218r + D351r*K249r + D387r*K226r) 
% \nonumber \\ 
% LHS_{dq_2r} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_2r} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_2r}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D64r)*ddx + (-D65r)*ddpsi + (-D66r)*ddq_imu + (-D67r)*ddq_w + (-D68r)*ddq_torso + (-D69r)*ddq_1r + XX_5r*ddq_2r - D70r 
% \nonumber \\ 
% &+(D112r*cos(q_3r) - D128r*sin(q_3r) + D88r*K77r + D104r*K84r)*ddx + (D113r*cos(q_3r) - D129r*sin(q_3r) + D89r*K77r + D105r*K84r)*ddpsi + (D114r*cos(q_3r) - D130r*sin(q_3r) + D90r*K77r + D106r*K84r)*ddq_imu + (D115r*cos(q_3r) - D131r*sin(q_3r) + D91r*K77r + D107r*K84r)*ddq_w + (D116r*cos(q_3r) - D132r*sin(q_3r) + D92r*K77r + D108r*K84r)*ddq_torso + (D117r*cos(q_3r) - D133r*sin(q_3r) + D93r*K77r + D109r*K84r)*ddq_1r + (D118r*cos(q_3r) - D134r*sin(q_3r) + D94r*K77r + D110r*K84r)*ddq_2r + (YZ_6r*sin(q_3r) - XY_6r*cos(q_3r) + K84r*MX_6r - K77r*MZ_6r)*ddq_3r + (D119r*cos(q_3r) - D135r*sin(q_3r) + D95r*K77r + D111r*K84r) 
% \nonumber \\ 
% &+(D148r*K113r - D139r*K77r - D166r*cos(q_3r) + D175r*K99r + D157r*K120r + D184r*K104r)*ddx + (D149r*K113r - D140r*K77r - D167r*cos(q_3r) + D176r*K99r + D158r*K120r + D185r*K104r)*ddpsi + (D150r*K113r - D141r*K77r - D168r*cos(q_3r) + D177r*K99r + D159r*K120r + D186r*K104r)*ddq_imu + (D151r*K113r - D142r*K77r - D169r*cos(q_3r) + D178r*K99r + D160r*K120r + D187r*K104r)*ddq_w + (D152r*K113r - D143r*K77r - D170r*cos(q_3r) + D179r*K99r + D161r*K120r + D188r*K104r)*ddq_torso + (D153r*K113r - D144r*K77r - D171r*cos(q_3r) + D180r*K99r + D162r*K120r + D189r*K104r)*ddq_1r + (D154r*K113r - D145r*K77r - D172r*cos(q_3r) + D181r*K99r + D163r*K120r + D190r*K104r)*ddq_2r + (D155r*K113r - D146r*K77r - D173r*cos(q_3r) + D182r*K99r + D164r*K120r + D191r*K104r)*ddq_3r + (XX_7r*cos(q_3r) - K104r*XZ_7r - K99r*XY_7r - K120r*MY_7r + K113r*MZ_7r)*ddq_4r + (D156r*K113r - D147r*K77r - D174r*cos(q_3r) + D183r*K99r + D165r*K120r + D192r*K104r) 
% \nonumber \\ 
% &+(D196r*K150r - D236r*K99r - D206r*K113r + D226r*K134r + D216r*K159r + D246r*K140r)*ddx + (D197r*K150r - D237r*K99r - D207r*K113r + D227r*K134r + D217r*K159r + D247r*K140r)*ddpsi + (D198r*K150r - D238r*K99r - D208r*K113r + D228r*K134r + D218r*K159r + D248r*K140r)*ddq_imu + (D199r*K150r - D239r*K99r - D209r*K113r + D229r*K134r + D219r*K159r + D249r*K140r)*ddq_w + (D200r*K150r - D240r*K99r - D210r*K113r + D230r*K134r + D220r*K159r + D250r*K140r)*ddq_torso + (D201r*K150r - D241r*K99r - D211r*K113r + D231r*K134r + D221r*K159r + D251r*K140r)*ddq_1r + (D202r*K150r - D242r*K99r - D212r*K113r + D232r*K134r + D222r*K159r + D252r*K140r)*ddq_2r + (D203r*K150r - D243r*K99r - D213r*K113r + D233r*K134r + D223r*K159r + D253r*K140r)*ddq_3r + (D204r*K150r - D244r*K99r - D214r*K113r + D234r*K134r + D224r*K159r + D254r*K140r)*ddq_4r + (K99r*YY_8r - K134r*XY_8r - K140r*YZ_8r + K159r*MX_8r - K150r*MZ_8r)*ddq_5r + (D205r*K150r - D245r*K99r - D215r*K113r + D235r*K134r + D225r*K159r + D255r*K140r) 
% \nonumber \\ 
% &+(D270r*K194r - D292r*K134r - D259r*K150r + D303r*K176r + D281r*K203r + D314r*K183r)*ddx + (D271r*K194r - D293r*K134r - D260r*K150r + D304r*K176r + D282r*K203r + D315r*K183r)*ddpsi + (D272r*K194r - D294r*K134r - D261r*K150r + D305r*K176r + D283r*K203r + D316r*K183r)*ddq_imu + (D273r*K194r - D295r*K134r - D262r*K150r + D306r*K176r + D284r*K203r + D317r*K183r)*ddq_w + (D274r*K194r - D296r*K134r - D263r*K150r + D307r*K176r + D285r*K203r + D318r*K183r)*ddq_torso + (D275r*K194r - D297r*K134r - D264r*K150r + D308r*K176r + D286r*K203r + D319r*K183r)*ddq_1r + (D276r*K194r - D298r*K134r - D265r*K150r + D309r*K176r + D287r*K203r + D320r*K183r)*ddq_2r + (D277r*K194r - D299r*K134r - D266r*K150r + D310r*K176r + D288r*K203r + D321r*K183r)*ddq_3r + (D278r*K194r - D300r*K134r - D267r*K150r + D311r*K176r + D289r*K203r + D322r*K183r)*ddq_4r + (D279r*K194r - D301r*K134r - D268r*K150r + D312r*K176r + D290r*K203r + D323r*K183r)*ddq_5r + (K134r*XX_9r - K176r*XY_9r - K183r*XZ_9r - K203r*MY_9r + K194r*MZ_9r)*ddq_6r + (D280r*K194r - D302r*K134r - D269r*K150r + D313r*K176r + D291r*K203r + D324r*K183r) 
% \nonumber \\ 
% &+(D328r*K239r - D388r*K176r - D352r*K194r + D364r*K219r + D340r*K250r + D376r*K227r)*ddx + (D329r*K239r - D389r*K176r - D353r*K194r + D365r*K219r + D341r*K250r + D377r*K227r)*ddpsi + (D330r*K239r - D390r*K176r - D354r*K194r + D366r*K219r + D342r*K250r + D378r*K227r)*ddq_imu + (D331r*K239r - D391r*K176r - D355r*K194r + D367r*K219r + D343r*K250r + D379r*K227r)*ddq_w + (D332r*K239r - D392r*K176r - D356r*K194r + D368r*K219r + D344r*K250r + D380r*K227r)*ddq_torso + (D333r*K239r - D393r*K176r - D357r*K194r + D369r*K219r + D345r*K250r + D381r*K227r)*ddq_1r + (D334r*K239r - D394r*K176r - D358r*K194r + D370r*K219r + D346r*K250r + D382r*K227r)*ddq_2r + (D335r*K239r - D395r*K176r - D359r*K194r + D371r*K219r + D347r*K250r + D383r*K227r)*ddq_3r + (D336r*K239r - D396r*K176r - D360r*K194r + D372r*K219r + D348r*K250r + D384r*K227r)*ddq_4r + (D337r*K239r - D397r*K176r - D361r*K194r + D373r*K219r + D349r*K250r + D385r*K227r)*ddq_5r + (D338r*K239r - D398r*K176r - D362r*K194r + D374r*K219r + D350r*K250r + D386r*K227r)*ddq_6r + (K176r*ZZ_10r - K227r*YZ_10r - K219r*XZ_10r - K250r*MX_10r + K239r*MY_10r)*ddq_7r + (D339r*K239r - D399r*K176r - D363r*K194r + D375r*K219r + D351r*K250r + D387r*K227r) 
% \nonumber \\ 
X14r = D112r*cos(q_3r) - D64r - D166r*cos(q_3r) - D128r*sin(q_3r) + D88r*K77r + D104r*K84r - D139r*K77r + D148r*K113r + D175r*K99r + D157r*K120r + D184r*K104r - D206r*K113r - D236r*K99r + D196r*K150r + D226r*K134r + D216r*K159r + D246r*K140r - D259r*K150r - D292r*K134r + D270r*K194r + D303r*K176r + D281r*K203r + D314r*K183r - D352r*K194r - D388r*K176r + D328r*K239r + D364r*K219r + D340r*K250r + D376r*K227r;
X15r = D113r*cos(q_3r) - D65r - D167r*cos(q_3r) - D129r*sin(q_3r) + D89r*K77r + D105r*K84r - D140r*K77r + D149r*K113r + D176r*K99r + D158r*K120r + D185r*K104r - D207r*K113r - D237r*K99r + D197r*K150r + D227r*K134r + D217r*K159r + D247r*K140r - D260r*K150r - D293r*K134r + D271r*K194r + D304r*K176r + D282r*K203r + D315r*K183r - D353r*K194r - D389r*K176r + D329r*K239r + D365r*K219r + D341r*K250r + D377r*K227r;
X16r = D114r*cos(q_3r) - D66r - D168r*cos(q_3r) - D130r*sin(q_3r) + D90r*K77r + D106r*K84r - D141r*K77r + D150r*K113r + D177r*K99r + D159r*K120r + D186r*K104r - D208r*K113r - D238r*K99r + D198r*K150r + D228r*K134r + D218r*K159r + D248r*K140r - D261r*K150r - D294r*K134r + D272r*K194r + D305r*K176r + D283r*K203r + D316r*K183r - D354r*K194r - D390r*K176r + D330r*K239r + D366r*K219r + D342r*K250r + D378r*K227r;
X17r = D115r*cos(q_3r) - D67r - D169r*cos(q_3r) - D131r*sin(q_3r) + D91r*K77r + D107r*K84r - D142r*K77r + D151r*K113r + D178r*K99r + D160r*K120r + D187r*K104r - D209r*K113r - D239r*K99r + D199r*K150r + D229r*K134r + D219r*K159r + D249r*K140r - D262r*K150r - D295r*K134r + D273r*K194r + D306r*K176r + D284r*K203r + D317r*K183r - D355r*K194r - D391r*K176r + D331r*K239r + D367r*K219r + D343r*K250r + D379r*K227r;
X18r = D116r*cos(q_3r) - D68r - D170r*cos(q_3r) - D132r*sin(q_3r) + D92r*K77r + D108r*K84r - D143r*K77r + D152r*K113r + D179r*K99r + D161r*K120r + D188r*K104r - D210r*K113r - D240r*K99r + D200r*K150r + D230r*K134r + D220r*K159r + D250r*K140r - D263r*K150r - D296r*K134r + D274r*K194r + D307r*K176r + D285r*K203r + D318r*K183r - D356r*K194r - D392r*K176r + D332r*K239r + D368r*K219r + D344r*K250r + D380r*K227r;
X19r = D117r*cos(q_3r) - D69r - D171r*cos(q_3r) - D133r*sin(q_3r) + D93r*K77r + D109r*K84r - D144r*K77r + D153r*K113r + D180r*K99r + D162r*K120r + D189r*K104r - D211r*K113r - D241r*K99r + D201r*K150r + D231r*K134r + D221r*K159r + D251r*K140r - D264r*K150r - D297r*K134r + D275r*K194r + D308r*K176r + D286r*K203r + D319r*K183r - D357r*K194r - D393r*K176r + D333r*K239r + D369r*K219r + D345r*K250r + D381r*K227r;
X20r = XX_5r + D118r*cos(q_3r) - D172r*cos(q_3r) - D134r*sin(q_3r) + D94r*K77r + D110r*K84r - D145r*K77r + D154r*K113r + D181r*K99r + D163r*K120r + D190r*K104r - D212r*K113r - D242r*K99r + D202r*K150r + D232r*K134r + D222r*K159r + D252r*K140r - D265r*K150r - D298r*K134r + D276r*K194r + D309r*K176r + D287r*K203r + D320r*K183r - D358r*K194r - D394r*K176r + D334r*K239r + D370r*K219r + D346r*K250r + D382r*K227r;
X21r = YZ_6r*sin(q_3r) - XY_6r*cos(q_3r) - D173r*cos(q_3r) - D146r*K77r + D155r*K113r + D182r*K99r + D164r*K120r + D191r*K104r - D213r*K113r - D243r*K99r + D203r*K150r + D233r*K134r + D223r*K159r + D253r*K140r - D266r*K150r - D299r*K134r + D277r*K194r + D310r*K176r + D288r*K203r + D321r*K183r - D359r*K194r - D395r*K176r + D335r*K239r + D371r*K219r + D347r*K250r + D383r*K227r + K84r*MX_6r - K77r*MZ_6r;
X22r = XX_7r*cos(q_3r) - K104r*XZ_7r - K99r*XY_7r - D214r*K113r - D244r*K99r + D204r*K150r + D234r*K134r + D224r*K159r + D254r*K140r - D267r*K150r - D300r*K134r + D278r*K194r + D311r*K176r + D289r*K203r + D322r*K183r - D360r*K194r - D396r*K176r + D336r*K239r + D372r*K219r + D348r*K250r + D384r*K227r - K120r*MY_7r + K113r*MZ_7r;
X23r = K99r*YY_8r - K134r*XY_8r - K140r*YZ_8r - D268r*K150r - D301r*K134r + D279r*K194r + D312r*K176r + D290r*K203r + D323r*K183r - D361r*K194r - D397r*K176r + D337r*K239r + D373r*K219r + D349r*K250r + D385r*K227r + K159r*MX_8r - K150r*MZ_8r;
X24r = K134r*XX_9r - K176r*XY_9r - K183r*XZ_9r - D362r*K194r - D398r*K176r + D338r*K239r + D374r*K219r + D350r*K250r + D386r*K227r - K203r*MY_9r + K194r*MZ_9r;
X25r = K176r*ZZ_10r - K227r*YZ_10r - K219r*XZ_10r - K250r*MX_10r + K239r*MY_10r;
X26r = D119r*cos(q_3r) - D70r - D174r*cos(q_3r) - D135r*sin(q_3r) + D95r*K77r + D111r*K84r - D147r*K77r + D156r*K113r + D183r*K99r + D165r*K120r + D192r*K104r - D215r*K113r - D245r*K99r + D205r*K150r + D235r*K134r + D225r*K159r + D255r*K140r - D269r*K150r - D302r*K134r + D280r*K194r + D313r*K176r + D291r*K203r + D324r*K183r - D363r*K194r - D399r*K176r + D339r*K239r + D375r*K219r + D351r*K250r + D387r*K227r;
% LHS_{dq_2r} &= (D328r*K239r - D388r*K176r - D352r*K194r + D364r*K219r + D340r*K250r + D376r*K227r)*ddx + (D329r*K239r - D389r*K176r - D353r*K194r + D365r*K219r + D341r*K250r + D377r*K227r)*ddpsi + (D330r*K239r - D390r*K176r - D354r*K194r + D366r*K219r + D342r*K250r + D378r*K227r)*ddq_imu + (D331r*K239r - D391r*K176r - D355r*K194r + D367r*K219r + D343r*K250r + D379r*K227r)*ddq_w + (D332r*K239r - D392r*K176r - D356r*K194r + D368r*K219r + D344r*K250r + D380r*K227r)*ddq_torso + (D333r*K239r - D393r*K176r - D357r*K194r + D369r*K219r + D345r*K250r + D381r*K227r)*ddq_1r + (D334r*K239r - D394r*K176r - D358r*K194r + D370r*K219r + D346r*K250r + D382r*K227r)*ddq_2r + (D335r*K239r - D395r*K176r - D359r*K194r + D371r*K219r + D347r*K250r + D383r*K227r)*ddq_3r + (D336r*K239r - D396r*K176r - D360r*K194r + D372r*K219r + D348r*K250r + D384r*K227r)*ddq_4r + (D337r*K239r - D397r*K176r - D361r*K194r + D373r*K219r + D349r*K250r + D385r*K227r)*ddq_5r + (D338r*K239r - D398r*K176r - D362r*K194r + D374r*K219r + D350r*K250r + D386r*K227r)*ddq_6r + (K176r*ZZ_10r - K227r*YZ_10r - K219r*XZ_10r - K250r*MX_10r + K239r*MY_10r)*ddq_7r + (D339r*K239r - D399r*K176r - D363r*K194r + D375r*K219r + D351r*K250r + D387r*K227r) 
% \nonumber \\ 
% LHS_{dq_3r} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_3r} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_3r}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D120r)*ddx + (-D121r)*ddpsi + (-D122r)*ddq_imu + (-D123r)*ddq_w + (-D124r)*ddq_torso + (-D125r)*ddq_1r + (-D126r)*ddq_2r + YY_6r*ddq_3r - D127r 
% \nonumber \\ 
% &+(D175r*cos(q_4r) + D184r*sin(q_4r))*ddx + (D176r*cos(q_4r) + D185r*sin(q_4r))*ddpsi + (D177r*cos(q_4r) + D186r*sin(q_4r))*ddq_imu + (D178r*cos(q_4r) + D187r*sin(q_4r))*ddq_w + (D179r*cos(q_4r) + D188r*sin(q_4r))*ddq_torso + (D180r*cos(q_4r) + D189r*sin(q_4r))*ddq_1r + (D181r*cos(q_4r) + D190r*sin(q_4r))*ddq_2r + (D182r*cos(q_4r) + D191r*sin(q_4r))*ddq_3r + (- XY_7r*cos(q_4r) - XZ_7r*sin(q_4r))*ddq_4r + (D183r*cos(q_4r) + D192r*sin(q_4r)) 
% \nonumber \\ 
% &+(D196r*K151r - D236r*cos(q_4r) + D226r*K135r + D216r*K160r + D246r*K141r)*ddx + (D197r*K151r - D237r*cos(q_4r) + D227r*K135r + D217r*K160r + D247r*K141r)*ddpsi + (D198r*K151r - D238r*cos(q_4r) + D228r*K135r + D218r*K160r + D248r*K141r)*ddq_imu + (D199r*K151r - D239r*cos(q_4r) + D229r*K135r + D219r*K160r + D249r*K141r)*ddq_w + (D200r*K151r - D240r*cos(q_4r) + D230r*K135r + D220r*K160r + D250r*K141r)*ddq_torso + (D201r*K151r - D241r*cos(q_4r) + D231r*K135r + D221r*K160r + D251r*K141r)*ddq_1r + (D202r*K151r - D242r*cos(q_4r) + D232r*K135r + D222r*K160r + D252r*K141r)*ddq_2r + (D203r*K151r - D243r*cos(q_4r) + D233r*K135r + D223r*K160r + D253r*K141r)*ddq_3r + (D204r*K151r - D244r*cos(q_4r) + D234r*K135r + D224r*K160r + D254r*K141r)*ddq_4r + (YY_8r*cos(q_4r) - K141r*YZ_8r - K135r*XY_8r + K160r*MX_8r - K151r*MZ_8r)*ddq_5r + (D205r*K151r - D245r*cos(q_4r) + D235r*K135r + D225r*K160r + D255r*K141r) 
% \nonumber \\ 
% &+(D270r*K195r - D292r*K135r - D259r*K151r + D303r*K177r + D281r*K204r + D314r*K184r)*ddx + (D271r*K195r - D293r*K135r - D260r*K151r + D304r*K177r + D282r*K204r + D315r*K184r)*ddpsi + (D272r*K195r - D294r*K135r - D261r*K151r + D305r*K177r + D283r*K204r + D316r*K184r)*ddq_imu + (D273r*K195r - D295r*K135r - D262r*K151r + D306r*K177r + D284r*K204r + D317r*K184r)*ddq_w + (D274r*K195r - D296r*K135r - D263r*K151r + D307r*K177r + D285r*K204r + D318r*K184r)*ddq_torso + (D275r*K195r - D297r*K135r - D264r*K151r + D308r*K177r + D286r*K204r + D319r*K184r)*ddq_1r + (D276r*K195r - D298r*K135r - D265r*K151r + D309r*K177r + D287r*K204r + D320r*K184r)*ddq_2r + (D277r*K195r - D299r*K135r - D266r*K151r + D310r*K177r + D288r*K204r + D321r*K184r)*ddq_3r + (D278r*K195r - D300r*K135r - D267r*K151r + D311r*K177r + D289r*K204r + D322r*K184r)*ddq_4r + (D279r*K195r - D301r*K135r - D268r*K151r + D312r*K177r + D290r*K204r + D323r*K184r)*ddq_5r + (K135r*XX_9r - K177r*XY_9r - K184r*XZ_9r - K204r*MY_9r + K195r*MZ_9r)*ddq_6r + (D280r*K195r - D302r*K135r - D269r*K151r + D313r*K177r + D291r*K204r + D324r*K184r) 
% \nonumber \\ 
% &+(D328r*K240r - D388r*K177r - D352r*K195r + D364r*K220r + D340r*K251r + D376r*K228r)*ddx + (D329r*K240r - D389r*K177r - D353r*K195r + D365r*K220r + D341r*K251r + D377r*K228r)*ddpsi + (D330r*K240r - D390r*K177r - D354r*K195r + D366r*K220r + D342r*K251r + D378r*K228r)*ddq_imu + (D331r*K240r - D391r*K177r - D355r*K195r + D367r*K220r + D343r*K251r + D379r*K228r)*ddq_w + (D332r*K240r - D392r*K177r - D356r*K195r + D368r*K220r + D344r*K251r + D380r*K228r)*ddq_torso + (D333r*K240r - D393r*K177r - D357r*K195r + D369r*K220r + D345r*K251r + D381r*K228r)*ddq_1r + (D334r*K240r - D394r*K177r - D358r*K195r + D370r*K220r + D346r*K251r + D382r*K228r)*ddq_2r + (D335r*K240r - D395r*K177r - D359r*K195r + D371r*K220r + D347r*K251r + D383r*K228r)*ddq_3r + (D336r*K240r - D396r*K177r - D360r*K195r + D372r*K220r + D348r*K251r + D384r*K228r)*ddq_4r + (D337r*K240r - D397r*K177r - D361r*K195r + D373r*K220r + D349r*K251r + D385r*K228r)*ddq_5r + (D338r*K240r - D398r*K177r - D362r*K195r + D374r*K220r + D350r*K251r + D386r*K228r)*ddq_6r + (K177r*ZZ_10r - K228r*YZ_10r - K220r*XZ_10r - K251r*MX_10r + K240r*MY_10r)*ddq_7r + (D339r*K240r - D399r*K177r - D363r*K195r + D375r*K220r + D351r*K251r + D387r*K228r) 
% \nonumber \\ 
X27r = D175r*cos(q_4r) - D120r - D236r*cos(q_4r) + D184r*sin(q_4r) + D196r*K151r + D226r*K135r + D216r*K160r + D246r*K141r - D259r*K151r - D292r*K135r + D270r*K195r + D303r*K177r + D281r*K204r + D314r*K184r - D352r*K195r - D388r*K177r + D328r*K240r + D364r*K220r + D340r*K251r + D376r*K228r;
X28r = D176r*cos(q_4r) - D121r - D237r*cos(q_4r) + D185r*sin(q_4r) + D197r*K151r + D227r*K135r + D217r*K160r + D247r*K141r - D260r*K151r - D293r*K135r + D271r*K195r + D304r*K177r + D282r*K204r + D315r*K184r - D353r*K195r - D389r*K177r + D329r*K240r + D365r*K220r + D341r*K251r + D377r*K228r;
X29r = D177r*cos(q_4r) - D122r - D238r*cos(q_4r) + D186r*sin(q_4r) + D198r*K151r + D228r*K135r + D218r*K160r + D248r*K141r - D261r*K151r - D294r*K135r + D272r*K195r + D305r*K177r + D283r*K204r + D316r*K184r - D354r*K195r - D390r*K177r + D330r*K240r + D366r*K220r + D342r*K251r + D378r*K228r;
X30r = D178r*cos(q_4r) - D123r - D239r*cos(q_4r) + D187r*sin(q_4r) + D199r*K151r + D229r*K135r + D219r*K160r + D249r*K141r - D262r*K151r - D295r*K135r + D273r*K195r + D306r*K177r + D284r*K204r + D317r*K184r - D355r*K195r - D391r*K177r + D331r*K240r + D367r*K220r + D343r*K251r + D379r*K228r;
X31r = D179r*cos(q_4r) - D124r - D240r*cos(q_4r) + D188r*sin(q_4r) + D200r*K151r + D230r*K135r + D220r*K160r + D250r*K141r - D263r*K151r - D296r*K135r + D274r*K195r + D307r*K177r + D285r*K204r + D318r*K184r - D356r*K195r - D392r*K177r + D332r*K240r + D368r*K220r + D344r*K251r + D380r*K228r;
X32r = D180r*cos(q_4r) - D125r - D241r*cos(q_4r) + D189r*sin(q_4r) + D201r*K151r + D231r*K135r + D221r*K160r + D251r*K141r - D264r*K151r - D297r*K135r + D275r*K195r + D308r*K177r + D286r*K204r + D319r*K184r - D357r*K195r - D393r*K177r + D333r*K240r + D369r*K220r + D345r*K251r + D381r*K228r;
X33r = D181r*cos(q_4r) - D126r - D242r*cos(q_4r) + D190r*sin(q_4r) + D202r*K151r + D232r*K135r + D222r*K160r + D252r*K141r - D265r*K151r - D298r*K135r + D276r*K195r + D309r*K177r + D287r*K204r + D320r*K184r - D358r*K195r - D394r*K177r + D334r*K240r + D370r*K220r + D346r*K251r + D382r*K228r;
X34r = YY_6r + D182r*cos(q_4r) - D243r*cos(q_4r) + D191r*sin(q_4r) + D203r*K151r + D233r*K135r + D223r*K160r + D253r*K141r - D266r*K151r - D299r*K135r + D277r*K195r + D310r*K177r + D288r*K204r + D321r*K184r - D359r*K195r - D395r*K177r + D335r*K240r + D371r*K220r + D347r*K251r + D383r*K228r;
X35r = D204r*K151r - XY_7r*cos(q_4r) - XZ_7r*sin(q_4r) - D244r*cos(q_4r) + D234r*K135r + D224r*K160r + D254r*K141r - D267r*K151r - D300r*K135r + D278r*K195r + D311r*K177r + D289r*K204r + D322r*K184r - D360r*K195r - D396r*K177r + D336r*K240r + D372r*K220r + D348r*K251r + D384r*K228r;
X36r = YY_8r*cos(q_4r) - K141r*YZ_8r - K135r*XY_8r - D268r*K151r - D301r*K135r + D279r*K195r + D312r*K177r + D290r*K204r + D323r*K184r - D361r*K195r - D397r*K177r + D337r*K240r + D373r*K220r + D349r*K251r + D385r*K228r + K160r*MX_8r - K151r*MZ_8r;
X37r = K135r*XX_9r - K177r*XY_9r - K184r*XZ_9r - D362r*K195r - D398r*K177r + D338r*K240r + D374r*K220r + D350r*K251r + D386r*K228r - K204r*MY_9r + K195r*MZ_9r;
X38r = K177r*ZZ_10r - K228r*YZ_10r - K220r*XZ_10r - K251r*MX_10r + K240r*MY_10r;
X39r = D183r*cos(q_4r) - D127r - D245r*cos(q_4r) + D192r*sin(q_4r) + D205r*K151r + D235r*K135r + D225r*K160r + D255r*K141r - D269r*K151r - D302r*K135r + D280r*K195r + D313r*K177r + D291r*K204r + D324r*K184r - D363r*K195r - D399r*K177r + D339r*K240r + D375r*K220r + D351r*K251r + D387r*K228r;
% LHS_{dq_3r} &= (D328r*K240r - D388r*K177r - D352r*K195r + D364r*K220r + D340r*K251r + D376r*K228r)*ddx + (D329r*K240r - D389r*K177r - D353r*K195r + D365r*K220r + D341r*K251r + D377r*K228r)*ddpsi + (D330r*K240r - D390r*K177r - D354r*K195r + D366r*K220r + D342r*K251r + D378r*K228r)*ddq_imu + (D331r*K240r - D391r*K177r - D355r*K195r + D367r*K220r + D343r*K251r + D379r*K228r)*ddq_w + (D332r*K240r - D392r*K177r - D356r*K195r + D368r*K220r + D344r*K251r + D380r*K228r)*ddq_torso + (D333r*K240r - D393r*K177r - D357r*K195r + D369r*K220r + D345r*K251r + D381r*K228r)*ddq_1r + (D334r*K240r - D394r*K177r - D358r*K195r + D370r*K220r + D346r*K251r + D382r*K228r)*ddq_2r + (D335r*K240r - D395r*K177r - D359r*K195r + D371r*K220r + D347r*K251r + D383r*K228r)*ddq_3r + (D336r*K240r - D396r*K177r - D360r*K195r + D372r*K220r + D348r*K251r + D384r*K228r)*ddq_4r + (D337r*K240r - D397r*K177r - D361r*K195r + D373r*K220r + D349r*K251r + D385r*K228r)*ddq_5r + (D338r*K240r - D398r*K177r - D362r*K195r + D374r*K220r + D350r*K251r + D386r*K228r)*ddq_6r + (K177r*ZZ_10r - K228r*YZ_10r - K220r*XZ_10r - K251r*MX_10r + K240r*MY_10r)*ddq_7r + (D339r*K240r - D399r*K177r - D363r*K195r + D375r*K220r + D351r*K251r + D387r*K228r) 
% \nonumber \\ 
% LHS_{dq_4r} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_4r} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_4r}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D166r)*ddx + (-D167r)*ddpsi + (-D168r)*ddq_imu + (-D169r)*ddq_w + (-D170r)*ddq_torso + (-D171r)*ddq_1r + (-D172r)*ddq_2r + (-D173r)*ddq_3r + XX_7r*ddq_4r - D174r 
% \nonumber \\ 
% &+(D226r*cos(q_5r) - D246r*sin(q_5r) + D196r*K152r + D216r*K161r)*ddx + (D227r*cos(q_5r) - D247r*sin(q_5r) + D197r*K152r + D217r*K161r)*ddpsi + (D228r*cos(q_5r) - D248r*sin(q_5r) + D198r*K152r + D218r*K161r)*ddq_imu + (D229r*cos(q_5r) - D249r*sin(q_5r) + D199r*K152r + D219r*K161r)*ddq_w + (D230r*cos(q_5r) - D250r*sin(q_5r) + D200r*K152r + D220r*K161r)*ddq_torso + (D231r*cos(q_5r) - D251r*sin(q_5r) + D201r*K152r + D221r*K161r)*ddq_1r + (D232r*cos(q_5r) - D252r*sin(q_5r) + D202r*K152r + D222r*K161r)*ddq_2r + (D233r*cos(q_5r) - D253r*sin(q_5r) + D203r*K152r + D223r*K161r)*ddq_3r + (D234r*cos(q_5r) - D254r*sin(q_5r) + D204r*K152r + D224r*K161r)*ddq_4r + (YZ_8r*sin(q_5r) - XY_8r*cos(q_5r) + K161r*MX_8r - K152r*MZ_8r)*ddq_5r + (D235r*cos(q_5r) - D255r*sin(q_5r) + D205r*K152r + D225r*K161r) 
% \nonumber \\ 
% &+(D270r*K196r - D259r*K152r - D292r*cos(q_5r) + D303r*K178r + D281r*K205r + D314r*K185r)*ddx + (D271r*K196r - D260r*K152r - D293r*cos(q_5r) + D304r*K178r + D282r*K205r + D315r*K185r)*ddpsi + (D272r*K196r - D261r*K152r - D294r*cos(q_5r) + D305r*K178r + D283r*K205r + D316r*K185r)*ddq_imu + (D273r*K196r - D262r*K152r - D295r*cos(q_5r) + D306r*K178r + D284r*K205r + D317r*K185r)*ddq_w + (D274r*K196r - D263r*K152r - D296r*cos(q_5r) + D307r*K178r + D285r*K205r + D318r*K185r)*ddq_torso + (D275r*K196r - D264r*K152r - D297r*cos(q_5r) + D308r*K178r + D286r*K205r + D319r*K185r)*ddq_1r + (D276r*K196r - D265r*K152r - D298r*cos(q_5r) + D309r*K178r + D287r*K205r + D320r*K185r)*ddq_2r + (D277r*K196r - D266r*K152r - D299r*cos(q_5r) + D310r*K178r + D288r*K205r + D321r*K185r)*ddq_3r + (D278r*K196r - D267r*K152r - D300r*cos(q_5r) + D311r*K178r + D289r*K205r + D322r*K185r)*ddq_4r + (D279r*K196r - D268r*K152r - D301r*cos(q_5r) + D312r*K178r + D290r*K205r + D323r*K185r)*ddq_5r + (XX_9r*cos(q_5r) - K185r*XZ_9r - K178r*XY_9r - K205r*MY_9r + K196r*MZ_9r)*ddq_6r + (D280r*K196r - D269r*K152r - D302r*cos(q_5r) + D313r*K178r + D291r*K205r + D324r*K185r) 
% \nonumber \\ 
% &+(D328r*K241r - D388r*K178r - D352r*K196r + D364r*K221r + D340r*K252r + D376r*K229r)*ddx + (D329r*K241r - D389r*K178r - D353r*K196r + D365r*K221r + D341r*K252r + D377r*K229r)*ddpsi + (D330r*K241r - D390r*K178r - D354r*K196r + D366r*K221r + D342r*K252r + D378r*K229r)*ddq_imu + (D331r*K241r - D391r*K178r - D355r*K196r + D367r*K221r + D343r*K252r + D379r*K229r)*ddq_w + (D332r*K241r - D392r*K178r - D356r*K196r + D368r*K221r + D344r*K252r + D380r*K229r)*ddq_torso + (D333r*K241r - D393r*K178r - D357r*K196r + D369r*K221r + D345r*K252r + D381r*K229r)*ddq_1r + (D334r*K241r - D394r*K178r - D358r*K196r + D370r*K221r + D346r*K252r + D382r*K229r)*ddq_2r + (D335r*K241r - D395r*K178r - D359r*K196r + D371r*K221r + D347r*K252r + D383r*K229r)*ddq_3r + (D336r*K241r - D396r*K178r - D360r*K196r + D372r*K221r + D348r*K252r + D384r*K229r)*ddq_4r + (D337r*K241r - D397r*K178r - D361r*K196r + D373r*K221r + D349r*K252r + D385r*K229r)*ddq_5r + (D338r*K241r - D398r*K178r - D362r*K196r + D374r*K221r + D350r*K252r + D386r*K229r)*ddq_6r + (K178r*ZZ_10r - K229r*YZ_10r - K221r*XZ_10r - K252r*MX_10r + K241r*MY_10r)*ddq_7r + (D339r*K241r - D399r*K178r - D363r*K196r + D375r*K221r + D351r*K252r + D387r*K229r) 
% \nonumber \\ 
X40r = D226r*cos(q_5r) - D166r - D292r*cos(q_5r) - D246r*sin(q_5r) + D196r*K152r + D216r*K161r - D259r*K152r + D270r*K196r + D303r*K178r + D281r*K205r + D314r*K185r - D352r*K196r - D388r*K178r + D328r*K241r + D364r*K221r + D340r*K252r + D376r*K229r;
X41r = D227r*cos(q_5r) - D167r - D293r*cos(q_5r) - D247r*sin(q_5r) + D197r*K152r + D217r*K161r - D260r*K152r + D271r*K196r + D304r*K178r + D282r*K205r + D315r*K185r - D353r*K196r - D389r*K178r + D329r*K241r + D365r*K221r + D341r*K252r + D377r*K229r;
X42r = D228r*cos(q_5r) - D168r - D294r*cos(q_5r) - D248r*sin(q_5r) + D198r*K152r + D218r*K161r - D261r*K152r + D272r*K196r + D305r*K178r + D283r*K205r + D316r*K185r - D354r*K196r - D390r*K178r + D330r*K241r + D366r*K221r + D342r*K252r + D378r*K229r;
X43r = D229r*cos(q_5r) - D169r - D295r*cos(q_5r) - D249r*sin(q_5r) + D199r*K152r + D219r*K161r - D262r*K152r + D273r*K196r + D306r*K178r + D284r*K205r + D317r*K185r - D355r*K196r - D391r*K178r + D331r*K241r + D367r*K221r + D343r*K252r + D379r*K229r;
X44r = D230r*cos(q_5r) - D170r - D296r*cos(q_5r) - D250r*sin(q_5r) + D200r*K152r + D220r*K161r - D263r*K152r + D274r*K196r + D307r*K178r + D285r*K205r + D318r*K185r - D356r*K196r - D392r*K178r + D332r*K241r + D368r*K221r + D344r*K252r + D380r*K229r;
X45r = D231r*cos(q_5r) - D171r - D297r*cos(q_5r) - D251r*sin(q_5r) + D201r*K152r + D221r*K161r - D264r*K152r + D275r*K196r + D308r*K178r + D286r*K205r + D319r*K185r - D357r*K196r - D393r*K178r + D333r*K241r + D369r*K221r + D345r*K252r + D381r*K229r;
X46r = D232r*cos(q_5r) - D172r - D298r*cos(q_5r) - D252r*sin(q_5r) + D202r*K152r + D222r*K161r - D265r*K152r + D276r*K196r + D309r*K178r + D287r*K205r + D320r*K185r - D358r*K196r - D394r*K178r + D334r*K241r + D370r*K221r + D346r*K252r + D382r*K229r;
X47r = D233r*cos(q_5r) - D173r - D299r*cos(q_5r) - D253r*sin(q_5r) + D203r*K152r + D223r*K161r - D266r*K152r + D277r*K196r + D310r*K178r + D288r*K205r + D321r*K185r - D359r*K196r - D395r*K178r + D335r*K241r + D371r*K221r + D347r*K252r + D383r*K229r;
X48r = XX_7r + D234r*cos(q_5r) - D300r*cos(q_5r) - D254r*sin(q_5r) + D204r*K152r + D224r*K161r - D267r*K152r + D278r*K196r + D311r*K178r + D289r*K205r + D322r*K185r - D360r*K196r - D396r*K178r + D336r*K241r + D372r*K221r + D348r*K252r + D384r*K229r;
X49r = YZ_8r*sin(q_5r) - XY_8r*cos(q_5r) - D301r*cos(q_5r) - D268r*K152r + D279r*K196r + D312r*K178r + D290r*K205r + D323r*K185r - D361r*K196r - D397r*K178r + D337r*K241r + D373r*K221r + D349r*K252r + D385r*K229r + K161r*MX_8r - K152r*MZ_8r;
X50r = XX_9r*cos(q_5r) - K185r*XZ_9r - K178r*XY_9r - D362r*K196r - D398r*K178r + D338r*K241r + D374r*K221r + D350r*K252r + D386r*K229r - K205r*MY_9r + K196r*MZ_9r;
X51r = K178r*ZZ_10r - K229r*YZ_10r - K221r*XZ_10r - K252r*MX_10r + K241r*MY_10r;
X52r = D235r*cos(q_5r) - D174r - D302r*cos(q_5r) - D255r*sin(q_5r) + D205r*K152r + D225r*K161r - D269r*K152r + D280r*K196r + D313r*K178r + D291r*K205r + D324r*K185r - D363r*K196r - D399r*K178r + D339r*K241r + D375r*K221r + D351r*K252r + D387r*K229r;
% LHS_{dq_4r} &= (D328r*K241r - D388r*K178r - D352r*K196r + D364r*K221r + D340r*K252r + D376r*K229r)*ddx + (D329r*K241r - D389r*K178r - D353r*K196r + D365r*K221r + D341r*K252r + D377r*K229r)*ddpsi + (D330r*K241r - D390r*K178r - D354r*K196r + D366r*K221r + D342r*K252r + D378r*K229r)*ddq_imu + (D331r*K241r - D391r*K178r - D355r*K196r + D367r*K221r + D343r*K252r + D379r*K229r)*ddq_w + (D332r*K241r - D392r*K178r - D356r*K196r + D368r*K221r + D344r*K252r + D380r*K229r)*ddq_torso + (D333r*K241r - D393r*K178r - D357r*K196r + D369r*K221r + D345r*K252r + D381r*K229r)*ddq_1r + (D334r*K241r - D394r*K178r - D358r*K196r + D370r*K221r + D346r*K252r + D382r*K229r)*ddq_2r + (D335r*K241r - D395r*K178r - D359r*K196r + D371r*K221r + D347r*K252r + D383r*K229r)*ddq_3r + (D336r*K241r - D396r*K178r - D360r*K196r + D372r*K221r + D348r*K252r + D384r*K229r)*ddq_4r + (D337r*K241r - D397r*K178r - D361r*K196r + D373r*K221r + D349r*K252r + D385r*K229r)*ddq_5r + (D338r*K241r - D398r*K178r - D362r*K196r + D374r*K221r + D350r*K252r + D386r*K229r)*ddq_6r + (K178r*ZZ_10r - K229r*YZ_10r - K221r*XZ_10r - K252r*MX_10r + K241r*MY_10r)*ddq_7r + (D339r*K241r - D399r*K178r - D363r*K196r + D375r*K221r + D351r*K252r + D387r*K229r) 
% \nonumber \\ 
% LHS_{dq_5r} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_5r} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_5r}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D236r)*ddx + (-D237r)*ddpsi + (-D238r)*ddq_imu + (-D239r)*ddq_w + (-D240r)*ddq_torso + (-D241r)*ddq_1r + (-D242r)*ddq_2r + (-D243r)*ddq_3r + (-D244r)*ddq_4r + YY_8r*ddq_5r - D245r 
% \nonumber \\ 
% &+(D303r*cos(q_6r) + D314r*sin(q_6r))*ddx + (D304r*cos(q_6r) + D315r*sin(q_6r))*ddpsi + (D305r*cos(q_6r) + D316r*sin(q_6r))*ddq_imu + (D306r*cos(q_6r) + D317r*sin(q_6r))*ddq_w + (D307r*cos(q_6r) + D318r*sin(q_6r))*ddq_torso + (D308r*cos(q_6r) + D319r*sin(q_6r))*ddq_1r + (D309r*cos(q_6r) + D320r*sin(q_6r))*ddq_2r + (D310r*cos(q_6r) + D321r*sin(q_6r))*ddq_3r + (D311r*cos(q_6r) + D322r*sin(q_6r))*ddq_4r + (D312r*cos(q_6r) + D323r*sin(q_6r))*ddq_5r + (- XY_9r*cos(q_6r) - XZ_9r*sin(q_6r))*ddq_6r + (D313r*cos(q_6r) + D324r*sin(q_6r)) 
% \nonumber \\ 
% &+(D328r*K242r - D388r*cos(q_6r) + D364r*K222r + D340r*K253r + D376r*K230r)*ddx + (D329r*K242r - D389r*cos(q_6r) + D365r*K222r + D341r*K253r + D377r*K230r)*ddpsi + (D330r*K242r - D390r*cos(q_6r) + D366r*K222r + D342r*K253r + D378r*K230r)*ddq_imu + (D331r*K242r - D391r*cos(q_6r) + D367r*K222r + D343r*K253r + D379r*K230r)*ddq_w + (D332r*K242r - D392r*cos(q_6r) + D368r*K222r + D344r*K253r + D380r*K230r)*ddq_torso + (D333r*K242r - D393r*cos(q_6r) + D369r*K222r + D345r*K253r + D381r*K230r)*ddq_1r + (D334r*K242r - D394r*cos(q_6r) + D370r*K222r + D346r*K253r + D382r*K230r)*ddq_2r + (D335r*K242r - D395r*cos(q_6r) + D371r*K222r + D347r*K253r + D383r*K230r)*ddq_3r + (D336r*K242r - D396r*cos(q_6r) + D372r*K222r + D348r*K253r + D384r*K230r)*ddq_4r + (D337r*K242r - D397r*cos(q_6r) + D373r*K222r + D349r*K253r + D385r*K230r)*ddq_5r + (D338r*K242r - D398r*cos(q_6r) + D374r*K222r + D350r*K253r + D386r*K230r)*ddq_6r + (ZZ_10r*cos(q_6r) - K230r*YZ_10r - K222r*XZ_10r - K253r*MX_10r + K242r*MY_10r)*ddq_7r + (D339r*K242r - D399r*cos(q_6r) + D375r*K222r + D351r*K253r + D387r*K230r) 
% \nonumber \\ 
X53r = D303r*cos(q_6r) - D236r - D388r*cos(q_6r) + D314r*sin(q_6r) + D328r*K242r + D364r*K222r + D340r*K253r + D376r*K230r;
X54r = D304r*cos(q_6r) - D237r - D389r*cos(q_6r) + D315r*sin(q_6r) + D329r*K242r + D365r*K222r + D341r*K253r + D377r*K230r;
X55r = D305r*cos(q_6r) - D238r - D390r*cos(q_6r) + D316r*sin(q_6r) + D330r*K242r + D366r*K222r + D342r*K253r + D378r*K230r;
X56r = D306r*cos(q_6r) - D239r - D391r*cos(q_6r) + D317r*sin(q_6r) + D331r*K242r + D367r*K222r + D343r*K253r + D379r*K230r;
X57r = D307r*cos(q_6r) - D240r - D392r*cos(q_6r) + D318r*sin(q_6r) + D332r*K242r + D368r*K222r + D344r*K253r + D380r*K230r;
X58r = D308r*cos(q_6r) - D241r - D393r*cos(q_6r) + D319r*sin(q_6r) + D333r*K242r + D369r*K222r + D345r*K253r + D381r*K230r;
X59r = D309r*cos(q_6r) - D242r - D394r*cos(q_6r) + D320r*sin(q_6r) + D334r*K242r + D370r*K222r + D346r*K253r + D382r*K230r;
X60r = D310r*cos(q_6r) - D243r - D395r*cos(q_6r) + D321r*sin(q_6r) + D335r*K242r + D371r*K222r + D347r*K253r + D383r*K230r;
X61r = D311r*cos(q_6r) - D244r - D396r*cos(q_6r) + D322r*sin(q_6r) + D336r*K242r + D372r*K222r + D348r*K253r + D384r*K230r;
X62r = YY_8r + D312r*cos(q_6r) - D397r*cos(q_6r) + D323r*sin(q_6r) + D337r*K242r + D373r*K222r + D349r*K253r + D385r*K230r;
X63r = D338r*K242r - XY_9r*cos(q_6r) - XZ_9r*sin(q_6r) - D398r*cos(q_6r) + D374r*K222r + D350r*K253r + D386r*K230r;
X64r = ZZ_10r*cos(q_6r) - K230r*YZ_10r - K222r*XZ_10r - K253r*MX_10r + K242r*MY_10r;
X65r = D313r*cos(q_6r) - D245r - D399r*cos(q_6r) + D324r*sin(q_6r) + D339r*K242r + D375r*K222r + D351r*K253r + D387r*K230r;
% LHS_{dq_5r} &= (D328r*K242r - D388r*cos(q_6r) + D364r*K222r + D340r*K253r + D376r*K230r)*ddx + (D329r*K242r - D389r*cos(q_6r) + D365r*K222r + D341r*K253r + D377r*K230r)*ddpsi + (D330r*K242r - D390r*cos(q_6r) + D366r*K222r + D342r*K253r + D378r*K230r)*ddq_imu + (D331r*K242r - D391r*cos(q_6r) + D367r*K222r + D343r*K253r + D379r*K230r)*ddq_w + (D332r*K242r - D392r*cos(q_6r) + D368r*K222r + D344r*K253r + D380r*K230r)*ddq_torso + (D333r*K242r - D393r*cos(q_6r) + D369r*K222r + D345r*K253r + D381r*K230r)*ddq_1r + (D334r*K242r - D394r*cos(q_6r) + D370r*K222r + D346r*K253r + D382r*K230r)*ddq_2r + (D335r*K242r - D395r*cos(q_6r) + D371r*K222r + D347r*K253r + D383r*K230r)*ddq_3r + (D336r*K242r - D396r*cos(q_6r) + D372r*K222r + D348r*K253r + D384r*K230r)*ddq_4r + (D337r*K242r - D397r*cos(q_6r) + D373r*K222r + D349r*K253r + D385r*K230r)*ddq_5r + (D338r*K242r - D398r*cos(q_6r) + D374r*K222r + D350r*K253r + D386r*K230r)*ddq_6r + (ZZ_10r*cos(q_6r) - K230r*YZ_10r - K222r*XZ_10r - K253r*MX_10r + K242r*MY_10r)*ddq_7r + (D339r*K242r - D399r*cos(q_6r) + D375r*K222r + D351r*K253r + D387r*K230r) 
% \nonumber \\ 
% LHS_{dq_6r} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_6r} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_6r}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D292r)*ddx + (-D293r)*ddpsi + (-D294r)*ddq_imu + (-D295r)*ddq_w + (-D296r)*ddq_torso + (-D297r)*ddq_1r + (-D298r)*ddq_2r + (-D299r)*ddq_3r + (-D300r)*ddq_4r + (-D301r)*ddq_5r + XX_9r*ddq_6r - D302r 
% \nonumber \\ 
% &+(D364r*cos(q_7r) + D376r*sin(q_7r) + D328r*K243r + D340r*K254r)*ddx + (D365r*cos(q_7r) + D377r*sin(q_7r) + D329r*K243r + D341r*K254r)*ddpsi + (D366r*cos(q_7r) + D378r*sin(q_7r) + D330r*K243r + D342r*K254r)*ddq_imu + (D367r*cos(q_7r) + D379r*sin(q_7r) + D331r*K243r + D343r*K254r)*ddq_w + (D368r*cos(q_7r) + D380r*sin(q_7r) + D332r*K243r + D344r*K254r)*ddq_torso + (D369r*cos(q_7r) + D381r*sin(q_7r) + D333r*K243r + D345r*K254r)*ddq_1r + (D370r*cos(q_7r) + D382r*sin(q_7r) + D334r*K243r + D346r*K254r)*ddq_2r + (D371r*cos(q_7r) + D383r*sin(q_7r) + D335r*K243r + D347r*K254r)*ddq_3r + (D372r*cos(q_7r) + D384r*sin(q_7r) + D336r*K243r + D348r*K254r)*ddq_4r + (D373r*cos(q_7r) + D385r*sin(q_7r) + D337r*K243r + D349r*K254r)*ddq_5r + (D374r*cos(q_7r) + D386r*sin(q_7r) + D338r*K243r + D350r*K254r)*ddq_6r + (K243r*MY_10r - YZ_10r*sin(q_7r) - K254r*MX_10r - XZ_10r*cos(q_7r))*ddq_7r + (D375r*cos(q_7r) + D387r*sin(q_7r) + D339r*K243r + D351r*K254r) 
% \nonumber \\ 
X66r = D364r*cos(q_7r) - D292r + D376r*sin(q_7r) + D328r*K243r + D340r*K254r;
X67r = D365r*cos(q_7r) - D293r + D377r*sin(q_7r) + D329r*K243r + D341r*K254r;
X68r = D366r*cos(q_7r) - D294r + D378r*sin(q_7r) + D330r*K243r + D342r*K254r;
X69r = D367r*cos(q_7r) - D295r + D379r*sin(q_7r) + D331r*K243r + D343r*K254r;
X70r = D368r*cos(q_7r) - D296r + D380r*sin(q_7r) + D332r*K243r + D344r*K254r;
X71r = D369r*cos(q_7r) - D297r + D381r*sin(q_7r) + D333r*K243r + D345r*K254r;
X72r = D370r*cos(q_7r) - D298r + D382r*sin(q_7r) + D334r*K243r + D346r*K254r;
X73r = D371r*cos(q_7r) - D299r + D383r*sin(q_7r) + D335r*K243r + D347r*K254r;
X74r = D372r*cos(q_7r) - D300r + D384r*sin(q_7r) + D336r*K243r + D348r*K254r;
X75r = D373r*cos(q_7r) - D301r + D385r*sin(q_7r) + D337r*K243r + D349r*K254r;
X76r = XX_9r + D374r*cos(q_7r) + D386r*sin(q_7r) + D338r*K243r + D350r*K254r;
X77r = K243r*MY_10r - YZ_10r*sin(q_7r) - K254r*MX_10r - XZ_10r*cos(q_7r);
X78r = D375r*cos(q_7r) - D302r + D387r*sin(q_7r) + D339r*K243r + D351r*K254r;
% LHS_{dq_6r} &= (D364r*cos(q_7r) + D376r*sin(q_7r) + D328r*K243r + D340r*K254r)*ddx + (D365r*cos(q_7r) + D377r*sin(q_7r) + D329r*K243r + D341r*K254r)*ddpsi + (D366r*cos(q_7r) + D378r*sin(q_7r) + D330r*K243r + D342r*K254r)*ddq_imu + (D367r*cos(q_7r) + D379r*sin(q_7r) + D331r*K243r + D343r*K254r)*ddq_w + (D368r*cos(q_7r) + D380r*sin(q_7r) + D332r*K243r + D344r*K254r)*ddq_torso + (D369r*cos(q_7r) + D381r*sin(q_7r) + D333r*K243r + D345r*K254r)*ddq_1r + (D370r*cos(q_7r) + D382r*sin(q_7r) + D334r*K243r + D346r*K254r)*ddq_2r + (D371r*cos(q_7r) + D383r*sin(q_7r) + D335r*K243r + D347r*K254r)*ddq_3r + (D372r*cos(q_7r) + D384r*sin(q_7r) + D336r*K243r + D348r*K254r)*ddq_4r + (D373r*cos(q_7r) + D385r*sin(q_7r) + D337r*K243r + D349r*K254r)*ddq_5r + (D374r*cos(q_7r) + D386r*sin(q_7r) + D338r*K243r + D350r*K254r)*ddq_6r + (K243r*MY_10r - YZ_10r*sin(q_7r) - K254r*MX_10r - XZ_10r*cos(q_7r))*ddq_7r + (D375r*cos(q_7r) + D387r*sin(q_7r) + D339r*K243r + D351r*K254r) 
% \nonumber \\ 
% LHS_{dq_7r} &= \sum_k \left(m_k\bar{a}_{Gk}^T\frac{\partial \bar{v}_k}{\partial dq_7r} + \dot\bar{H}_{Gk}^T\frac{\partial \bar{\omega}_k}{\partial dq_7r}\right) 
% \nonumber \\ 
% \dot{\bar{H}}_{10r} &= \\ 
% \nonumber \\ 
% & 0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+0 
% \nonumber \\ 
% &+(-D388r)*ddx + (-D389r)*ddpsi + (-D390r)*ddq_imu + (-D391r)*ddq_w + (-D392r)*ddq_torso + (-D393r)*ddq_1r + (-D394r)*ddq_2r + (-D395r)*ddq_3r + (-D396r)*ddq_4r + (-D397r)*ddq_5r + (-D398r)*ddq_6r + ZZ_10r*ddq_7r - D399r 
% \nonumber \\ 
% LHS_{dq_7r} &= (-D388r)*ddx + (-D389r)*ddpsi + (-D390r)*ddq_imu + (-D391r)*ddq_w + (-D392r)*ddq_torso + (-D393r)*ddq_1r + (-D394r)*ddq_2r + (-D395r)*ddq_3r + (-D396r)*ddq_4r + (-D397r)*ddq_5r + (-D398r)*ddq_6r + ZZ_10r*ddq_7r - D399r 
% \nonumber \\ 