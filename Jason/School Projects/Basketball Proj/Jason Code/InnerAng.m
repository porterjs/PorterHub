% InnerAng.m

function [alpha,dalpha] = InnerAng(u, v, m, f)
     % --- Initialize Vars --- %
     alpha = zeros(m,f);
     dalpha = zeros(m,f-1);
     
     % --- Get Angle --- %
     for j = 1:f
          for i = 1:m
               
               alpha(i,j) = acosd(-dot(u(:,i,j),v(:,i,j)));
          end
     end
     
     % --- Get Angle change --- %
     for j = 1:f-1
          dalpha(:,j) = alpha(:,j+1)-alpha(:,j);
     end
end