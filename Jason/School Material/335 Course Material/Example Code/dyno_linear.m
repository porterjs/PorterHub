M0 = 100;
J1 = 0.2;
J2 = 0.1;
b = 1;
k = 200;

A = [-b/J1 b/J1 0 0; b/J2 -b/J2 0 -k/J2; 1 0 0 0; 0 1 0 0];
B = M0*[1/J1; 0; 0; 0];
C = [1 0 0 0; 0 1 0 0; 0 0 0 1]*180/pi;
D = 0;

sys = ss(A,B,C,D);

figure(1); clf;
[y,t] = step(sys,1.2);

subplot(311);
plot(t,y(:,1));
title('Dyno Step Response');
ylabel('\Omega_1 (deg/s)');
subplot(312);
plot(t,y(:,2));
ylabel('\Omega_2 (deg/s)');
subplot(313);
plot(t,y(:,3));
ylabel('\theta_2 (deg)');
xlabel('time (sec)');




