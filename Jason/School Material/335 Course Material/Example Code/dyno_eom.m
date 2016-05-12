% dyno_eom.m
% Matlab function containing equations of motion for dynamometer system

function dx = dyno_eom(t,x)

dx = zeros(4,1);    % create a column vector to hold state derivatives

M0 = 100;
J1 = 0.2;
J2 = 0.1;
b = 1;
k = 200;

dx(1) = -b/J1*x(1) + b/J1*x(2) + 1/J1*M0; 
dx(2) =  b/J2*x(1) - b/J2*x(2) - k/J2*x(4); 
dx(3) = x(1);
dx(4) = x(2);
