% main.m


% --- Initial Conditions --- %
theta = [[0 , -60 ,  20], ...        % Frame 1
         [0 , -50 ,  21],...     % Frame 2
         [0 , -05 , 110],...
         [0 ,  20 ,  45]];       % Frame 3
phi   = [[0 , 45,   45],...
         [0 , 45,   45],...
         [0 , 45,   45],...
         [0 , 45,   45]];
x0    = [theta,phi];
frames= 4;
nodes = 3;

% --- Objective Results --- %
[J,c] = DynMotion(x0, frames, nodes);

