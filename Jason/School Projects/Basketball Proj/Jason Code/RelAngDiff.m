% RelAngDiff.m

function [dtheta, dphi] = RelAngDiff(theta, phi, n, f)
     % --- Initialize Variables --- %
     dtheta = zeros(f-1,n);
     dphi   = zeros(f-1,n);
     tsum = 0; % Sum of angle changes
     psum = 0;
     q1 = zeros(f-1,n);  % Middle-man Variables
     q2 = zeros(f-1,n);
     
     for j = 1:f-1
          for i = 1:n
               q1(j,i) = theta(j+1,i) - theta(j,i);
               q2(j,i)   = phi(j+1,i) - phi(j,i);
                        
               dtheta(j,i) = q1(j,i) - tsum;
               dphi(j,i)   = q2(j,i) - psum;
               
               tsum = tsum + q1(j,i);
               psum = psum + q2(j,i);
          end
          tsum = 0;
          psum = 0;
     end
end