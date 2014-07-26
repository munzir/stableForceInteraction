% According to schunk datasheet the max accelerations are (in deg/s^2)
% taken from /doc/krang/3rdParty/schunk/PRL/PRL60-120_en.pdf:
% 100   100    95    95   100   100   200
% In rad/s^2 it will be:
% 1.7453    1.7453    1.6581    1.6581    1.7453    1.7453    3.4907
 

% Parameters
ddq7_max = 3.4907;
dq7_min = 0.1745; % rad/s = 10 deg/s
q7_A = -pi/2;
q7_B = pi/2;
cycles = 10; 
T = 0.001; % sampling time

% Derived params
period = 2*round(((q7_B-q7_A)/dq7_min)/10)*10; % Hz
t = 0:T:cycles*period;
N_perCycle = length(t)/cycles;
N_total = length(t);
q7_traj = zeros(N_total,1); dq7_traj = zeros(N_total,1); ddq7_traj=zeros(N_total,1);
dt_bang = dq7_min/ddq7_max; N_bang = dt_bang/T;
dt_coast = period/2-2*dt_bang; N_coast = dt_coast/T;

% Acceleration
ddq7_traj(1:N_bang) = ddq7_max;
ddq7_traj(N_bang+1:N_bang+N_coast) = 0;
ddq7_traj(N_bang+N_coast+1:N_bang+N_coast+2*N_bang) = -ddq7_max;
ddq7_traj(N_bang+N_coast+2*N_bang+1:N_bang+N_coast+2*N_bang+N_coast) = 0;
ddq7_traj(N_bang+N_coast+2*N_bang+N_coast+1:N_bang+N_coast+2*N_bang+N_coast+N_bang) = ddq7_max;
for i=2:cycles
    ddq7_traj((i-1)*N_perCycle+1:i*N_perCycle) = ddq7_traj(1:N_perCycle);
end

% Speed
dq7_traj(1) = 0;
for i=2:N_total
    dq7_traj(i) = min(max(dq7_traj(i-1) + ddq7_traj(i)*T, -dq7_min), dq7_min);
end

% Position
q7_traj(1) = q7_A;
for i = 2:N_total
    q7_traj(i) = q7_traj(i-1) + dq7_traj(i-1)*T + 0.5*ddq7_traj(i-1)*T^2;
end

% plot(t, q7_traj, t, dq7_traj, t, ddq7_traj);
% legend('q7', 'dq7', 'ddq7');

q1 = zeros(N_total,1); q2 = zeros(N_total,1); q3 = zeros(N_total,1); 
q4 = zeros(N_total,1); q5 = zeros(N_total,1); q6 = zeros(N_total,1); 

t5 = cos(q1).*sin(q3) + cos(q2).*cos(q3).*sin(q1);
t4 = cos(q1).*cos(q3) - cos(q2).*sin(q1).*sin(q3);
t3 = cos(q4).*t5 - sin(q1).*sin(q2).*sin(q4);
t2 = sin(q5).*t3 - cos(q5).*t4;
t1 = sin(q6).*(sin(q4).*t5 + cos(q4).*sin(q1).*sin(q2)) - ...
    cos(q6).*(cos(q5).*t3 + sin(q5).*t4);

D_L7T1_evaluated = [ddq7_traj, 49*cos(q7_traj).*t1/5 + ...
    49*sin(q7_traj).*t2/5, 49*sin(q7_traj).*t1/5-49*cos(q7_traj).*t2/5,...
    zeros(N_total,2), ddq7_traj, sign(dq7_traj), dq7_traj];

[amp_ddq, pha_ddq] = cdft(ddq7_traj, 1/period, T, 'wy'); 

l=size(D_L7T1_evaluated,2); 
amp_D = zeros(1,l); pha_D = zeros(1,l); spec_D = zeros(1, l);
for i=1:l
    [amp_D(i), pha_D(i)] = cdft(D_L7T1_evaluated(:,i), 1/period, T, 'wy');
    spec_D(i) = amp_D(i)*(cos(pha_D(i)-pha_ddq))/amp_ddq;
end
plot(spec_D);