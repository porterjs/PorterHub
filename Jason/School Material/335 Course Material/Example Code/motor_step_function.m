function xdot = motor_step_function(t,x)

global Kt Kb c Ra La r1 r2 Ie cL va;

ia = x(1);
wL = x(2);

iadot = 1/La*(-Ra*ia - Kb*wL + va);
wLdot = r1/r2*1/Ie*(Kt*ia - (r2/r1*c + r1/r2*cL)*wL);
xdot = [iadot;wLdot];