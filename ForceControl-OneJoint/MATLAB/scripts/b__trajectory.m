clear all

% define trajectory
% Parameters
ddq4_max = 1.6581;
dq4_min = 0.1745; % rad/s = 10 deg/s
q4_A = -pi/2;
q4_B = pi/2;
cycles = 10; 
T = 0.001; % sampling time

% Derived params
period = 2*round(((q4_B-q4_A)/dq4_min)/10)*10; % Hz
t = 0:T:cycles*period;
N_perCycle = length(t)/cycles;
N_total = length(t);
q4_traj = zeros(N_total,1); dq4_traj = zeros(N_total,1); ddq4_traj=zeros(N_total,1);
dt_bang = dq4_min/ddq4_max; N_bang = dt_bang/T;
dt_coast = period/2-2*dt_bang; N_coast = dt_coast/T;

% Acceleration
ddq4_traj(1:N_bang) = ddq4_max;
ddq4_traj(N_bang+1:N_bang+N_coast) = 0;
ddq4_traj(N_bang+N_coast+1:N_bang+N_coast+2*N_bang) = -ddq4_max;
ddq4_traj(N_bang+N_coast+2*N_bang+1:N_bang+N_coast+2*N_bang+N_coast) = 0;
ddq4_traj(N_bang+N_coast+2*N_bang+N_coast+1:N_bang+N_coast+2*N_bang+N_coast+N_bang) = ddq4_max;
for i=2:cycles
    ddq4_traj((i-1)*N_perCycle+1:i*N_perCycle) = ddq4_traj(1:N_perCycle);
end

% Speed
dq4_traj(1) = 0;
for i=2:N_total
    dq4_traj(i) = min(max(dq4_traj(i-1) + ddq4_traj(i)*T, -dq4_min), dq4_min);
end

% Position
q4_traj(1) = q4_A;
for i = 2:N_total
    q4_traj(i) = q4_traj(i-1) + dq4_traj(i-1)*T + 0.5*ddq4_traj(i-1)*T^2;
end

% Testing the identification method
MY1 = -0.15;
MZ1 = 0.02;
Ia1 = 1.2e-3;
XX1 = 4e-3;
Fc1 = 0.01;
Fv1 = 0.0056;
KKR = [ MY1, MZ1, Ia1+XX1, Fc1, Fv1]';


DD = [ -(49*q4_traj.*cos(q4_traj))/5, -(49*q4_traj.*sin(q4_traj))/5, ddq4_traj, sign(dq4_traj), dq4_traj];
Gamma = DD*KKR;

KKR_estimated = pinv(DD)*Gamma;