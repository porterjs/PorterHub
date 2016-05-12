% Plots the load speed and armature current for a
% motor/gear/load system in response to a voltage step
% input

clear;
clc;

global Kt Kb c Ra La r1 r2 Ie cL va;

% Motor parameters
Kt = 0.75;		% Torque constant (N*m/A)
Kb = Kt;		% Back EMF constant (N*m/A)
c = 10e-4;		% Damping coefficient (N*m*s/rad)
Ra = 0.1;		% Armature resistance (ohms)
La = 0.01;		% Armature inductance (H)

% Gear radii
r1 = 1/100;		% Gear 1 radius (m)
r2 = 3/100;		% Gear 2 radius (m)

% Inertias
Im = 1;			% Motor inertia (kg*m^2)
I1 = 0.5;		% Gear 1 inertia
I2 = 0.75;		% Gear 2 inertia
IL = 5.25;		% Load inertia

% Equivalent inertia
Ie = Im + I1 + (r1/r2)^2*(I2 + IL)

% Load damping
cL = 3e-2;		% Damping coefficient (N*m*s/rad)

% Input
va = 15;		% Armature voltage (V)

% Simulate response
x0 = [0 0];
tspan = [0 5];
[t,x] = ode45('motor_step_function', tspan, x0);
ia = x(:,1);
wL = x(:,2);

% Plots
figure(1);
subplot(2,1,1);
plot(t,ia);
xlabel('t (s)');
ylabel('i_a (A)');
subplot(2,1,2);
plot(t,wL);
xlabel('t (s)');
ylabel('\Omega_L (rad/s)');
% figure(2);
% subplot(2,1,1);
% plot(t,Kt*ia);
% xlabel('t (s)');
% ylabel('T (N*m)');
% subplot(2,1,2);
% plot(t,Kb*r2/r1*wL);
% xlabel('t (s)');
% ylabel('V_b (V)');
