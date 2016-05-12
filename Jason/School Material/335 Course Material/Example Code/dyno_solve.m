% dyno_solve.m
% Matlab script to demonstrate solution of equations of motion using
% nonlinear solver ode45

tspan = [0 1.2];
x0 = [0; 0; 0; 0];
[t,x] = ode45(@dyno_eom,tspan,x0); 

omega1 = x(:,1);
omega2 = x(:,2);
theta1 = x(:,3);
theta2 = x(:,4);

subplot(311);
plot(t,omega1);
title('Dyno Step Response');
ylabel('\Omega_1 (deg/s)');
subplot(312);
plot(t,omega2);
ylabel('\Omega_2 (deg/s)');
subplot(313);
plot(t,theta2);
ylabel('\theta_2 (deg)');
xlabel('time (sec)');
