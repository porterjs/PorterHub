% Dynomometer example 
% Transfer function representation
% Response to unit step input
% Using step command

J1 = 0.2;
J2 = 0.1;
b = 1;
k = 200;
tfinal = 1.2;

num1 = [J2 b k];
den = [J1*J2 (J1+J2)*b J1*k b*k];
num2 = b;

Om1_M = tf(num1,den)
th2_M = tf(num2,den)

figure(1); clf;
step(Om1_M,tfinal);

figure(2); clf;
[y,t] = step(th2_M,tfinal);
plot(t,y);
xlabel('time (s)');
ylabel('\theta_2 (rad)');
title('unit step response');








