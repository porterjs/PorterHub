% Dynomometer example 
% State-space representation
% Response to 100 N-m step input with sinusoidal ripple
% Using lsim command

M0 = 100;
J1 = 0.2;
J2 = 0.1;
b = 1;
k = 200;

A = [-b/J1 b/J1 0 0; b/J2 -b/J2 0 -k/J2; 1 0 0 0; 0 1 0 0];
B = [1/J1; 0; 0; 0];
C = [1 0 0 0; 0 1 0 0; 0 0 0 1];
D = 0;

sys = ss(A,B,C,D);

% transfer functions for outputs omega1, omega2, and theta2
sys_tf = tf(sys)

M1 = 10;
om = 15;
t = 0:0.01:2.5;
u = M0 + M1*sin(om*t);
x0 = [20; 0; 0; -0.2];
figure(1); clf;
[y,t] = lsim(sys,u,t,x0);

subplot(311);
plot(t,y(:,1));
title('dyno response');
ylabel('\Omega_1 (deg/s)');
subplot(312);
plot(t,y(:,2));
ylabel('\Omega_2 (deg/s)');
subplot(313);
plot(t,y(:,3));
ylabel('\theta_2 (deg)');
xlabel('time (sec)');




