data = csvread('../../data/04.csv');

t_m = data(:,1);
q_m = data(:,2); 
dq_m = data(:,3); for i=1:10; dq_m = smooth(dq_m, 'rlowess'); end
ddq_m = [0; (dq_m(2:end)-dq_m(1:end-1))./(t_m(2:end)-t_m(1:end-1))];
for i=1:2; ddq_m = smooth(ddq_m,'rlowess'); end;
DD_m = [ (49*cos(q_m))/5, (49*sin(q_m))/5, ddq_m, dq_m>0, dq_m.*(dq_m>0), dq_m<0, dq_m.*(dq_m<0)];
Gamma_m = data(:,4); for i=1:10; Gamma_m = smooth(Gamma_m, 'rlowess'); end
KKR_est = pinv(DD_m)*Gamma_m;
Gamma_est = DD_m*KKR_est;

plot(t_m, q_m, t_m, dq_m, t_m, ddq_m, t_m, Gamma_m, t_m, Gamma_est);
legend('position', 'velocity', 'acceleration', 'current', 'estimated current');