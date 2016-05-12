% RotInertia.m

function I = RotInertia(weight, length, m)
     % --- Rotational Inertia about Joint --- %
     for i = 1:m
          I(i) = (1/3)*weight(i)*(length(i+1))^2;   % Stick about end: I = 1/3 * m * L^2
     end
end
