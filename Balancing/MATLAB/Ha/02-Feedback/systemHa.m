% Author: Munzir Zafar
% Date: Nov 13, 2013
% Brief: Simulating the system in the paper "Trajectory tracking control 
% for navigati2on of the inverse pendulum type self-contained mobile robot"
% by Yun Su Ha et al. 
function xdot = systemHa(t,x)

global Mb Mw Ib Iw IM r l mu_s mu_g tau_t eeta g K xref

u = -K*(x-xref); % the way we did it
x_s = [3.1345e-04*xref(4); 0; 0; xref(4)];
u = 0.0097068*xref(4) - K*(x-x_s); % the way Ha does it

A1 = ((Mw+Mb)*r^2 + Iw + IM*eeta^2);
B1 = (Mb*r*l*cos(x(1)) - IM*eeta^2);
C1 = Mb*r*l*sin(x(1))*x(2)^2 + eeta*tau_t*u - mu_g*x(4) - mu_s*(x(4)-x(2));

A2 = (Mb*r*l*cos(x(1)) - IM*eeta^2);
B2 = (Mb*l^2 + Ib + IM*eeta^2);
C2 = -eeta*tau_t*u + Mb*g*l*sin(x(1)) + mu_s*(x(4)-x(2));

del = A1*B2 - A2*B1;

xdot(1) = x(2);
xdot(3) = x(4);
xdot([2 4]) = (1/del)*[-A2 A1; B2 -B1]*[C1; C2];
xdot = xdot';
