% Author: Munzir Zafar
% Date: Nov 12, 2013
% Brief: Simulating the system in the paper "Trajectory tracking control 
% for navigation of the inverse pendulum type self-contained mobile robot"
% by Yun Su Ha et al. This time we are trying to see the outcome of
% doing feedback control using the gains in [Ha] but the controller the
% same as ours.

global Mb Mw Ib Iw IM r l mu_s mu_g tau_t eeta g K xref

Mb = 9.01;
Mw = 0.51;
Ib = 0.228;
Iw = 5.1e-4;
IM = 3.2e-6;
r = 0.062;
l = 0.138;
mu_s = 5.76e-3;
mu_g = 4.25e-3;
tau_t = 0.0235;
eeta = 39.5;
g = 9.8;

K = [-9.0 -1.58 0 -0.123];
xref = [0; 0; 0; 1];

% Simulate
tf=19; dt=0.005; t=0;
x0 = [0; 0; 0; 0];
X=[]; T=[]; U = [];
u=0;
[T,X] = ode45('systemHa',[0,tf],x0);
X(:,3:4) = r*X(:,3:4);

figure(1); subplot(221); plot(T,X(:,1)*180/pi); 
title('phi'); xlabel('time (sec)'); ylabel('phi (degrees)'); grid on;
figure(1); subplot(222); plot(T,X(:,2)*180/pi); 
title('phidot'); xlabel('time (sec)'); ylabel('phidot (deg/sec)'); grid on;
figure(1); subplot(223); plot(T,X(:,3)); 
title('x'); xlabel('time (sec)'); ylabel('x (m)'); grid on;
figure(1); subplot(224); plot(T,X(:,4));
title('xdot'); xlabel('time (sec)'); ylabel('xdot (m/s)'); grid on;


if(1) 
  axis_speed_gain=0.1; axis_center=0; plot_memory=20; plot_step=2;
  figure(2);
  clf;
  for j = 1 : plot_step : size(X,1)
      for c=1:plot_memory
          k=j-plot_step*(plot_memory-c);
          if(k>0)
              color=(1-c/plot_memory)*[0.5 0.5 0.5];
              plot([X(k,3);X(k,3)+l*sin(X(k,1))],[0; l * cos(X(k,1))] ...
              , '-', 'Color',color);  hold on;
              plot(X(k,3),0,'o','MarkerSize',5,'Color',color); hold on;
          end
      end
      axis_err=X(j,3)-axis_center;
      axis_speed=axis_speed_gain*axis_err;
      axis_center=axis_center+axis_speed;
      axis([axis_center-1 axis_center+1, -1 1]); 
      str=sprintf('time=%.3f sec',T(j));
      text(axis_center+0.5,0.9,str);
      grid on;
      pause;
      clf;
  end
end