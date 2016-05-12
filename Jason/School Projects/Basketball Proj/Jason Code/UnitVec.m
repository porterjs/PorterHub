% UnitVec.m

function [u,v] = UnitVec(r, n, f)
     
     m = n - 1;
     unorm = zeros(m, f);
     u = zeros(3,m,f);
     v = zeros(3,m,f);
     
     % --- Create First Unit Vector --- %
     for j = 1:f
          for i = 2:n
               unorm(i-1,j) = sqrt(r(1,i,j)^2 + r(2,i,j)^2 + r(3,i,j)^2);
               u(1,i-1,j) = r(1,i,j)/unorm(i-1,j);
               u(2,i-1,j) = r(2,i,j)/unorm(i-1,j);
               u(3,i-1,j) = r(3,i,j)/unorm(i-1,j);
          end
     end

     % --- Create Second Unit Vector --- %
     for j = 1:f
          for i = 1:m-1
               v(:,i,j) = u(:,i+1,j);
               v(:,m,j) = [1/sqrt(2);1/sqrt(2);0];
          end
     end
end