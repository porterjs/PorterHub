% JointPos.m

function [r, p] = JointPos(theta, phi, length, n, f)
     % --- Initialize Vars --- %
     r = zeros(3, n, f);
     p = zeros(3, n, f);
     
     
     % --- Relative Postion --- %
     for j = 1:f
          for i = 1:n
               r(1,i,j) = length(i)*cosd(theta(j,i))*cosd(phi(j,i));   % x
               r(2,i,j) = length(i)*cosd(theta(j,i))*sind(phi(j,i));   % y
               r(3,i,j) = length(i)*sind(theta(j,i));                  % z
          end
     end
     % --- Actual Position --- %
     for j = 1:f
          for i = 2:n
               p(:,i,j) = r(:,i-1,j) + r(:,i,j);
          end
     end
end