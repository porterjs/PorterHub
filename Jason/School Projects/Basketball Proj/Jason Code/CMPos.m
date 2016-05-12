% CMPos.m

function [cr, cp] = CMPos(c, r, p, length, m, f)
     % --- Initialize Vars --- %
     cr = zeros(3,m,f);
     cp = zeros(3,m,f);
     
     % --- Relative Postion --- %
     for j = 1:f
          for i = 1:m
               n = i + 1;
               cr(:,i,j) = r(:,n,j)*c(i);
          end
     end
     % --- Actual Postion --- %
     for j = 1:f
          for i = 1:m
               n = i + 1;
               cp(:,i,j) = p(:,i,j) + cr(:,i,j);
          end
     end
end