% RotEner.m

function [T,t] = RotEner(dalpha, I, omega, m, f )
     % dalpha: change of inner joint angle in degrees
     % I:      inertia of arm segments
     % omega:  rotational speed of arm segment, degree/s
     T = zeros(m,f-1);
     t = zeros(m,f-1);

     for j = 1:f-1
          for i = 1:m
             T(i,j) = (1/2)*I(i)*omega(i,j)^2;
             
             t(i,j) = (T(1,j)/dalpha(1,j))-(T(2,j)/dalpha(2,j));
          end
     end
end