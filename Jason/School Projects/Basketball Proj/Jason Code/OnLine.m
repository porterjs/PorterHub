function [on,onsum,R] = OnLine(tendon, active, p, u,tnum,m,f)
     
     % if tend is in line with u, then returns true 
     on = zeros(m,tnum,f-1);
     R = zeros(m,tnum,f-1);
     v = zeros(3,m,tnum,f-1);     
     vnorm = zeros(m,tnum,f-1);
     pend = zeros(3,m,f-1);
     tend = zeros(3,tnum,f-1);
     onsum = zeros(m,f-1);
     
         
     % --- Get tend --- %
     for j = 1:f-1
          for k = 1:tnum
               tend(:,k,j) = tendon(:,2,k,j);
          end
     end
     
     % --- Get pend --- %
     for j = 1:f-1
          for i = 1:m
              pend(:,i,j) = p(:,i+1,j);
          end
     end
     
     % --- Get v & vnorm --- %
     for j = 1:f-1
          for i = 1:m
               for k = 1:tnum
                    v(:,i,k,j) = (pend(:,i,j)-tend(:,k,j));   
                    vnorm(i,k,j) = norm(v(:,i,k,j));%sqrt(v(1,i,k)^2 + v(2,i,k)^2 + v(3,i,k)^2);
                    v(:,i,k,j) = v(:,i,k,j)/vnorm(i,k,j);
               end
          end 
     end
     
     % --- compare with u --- %
     % returns onlinetemp with tendons that affect joint movement
     for j = 2:f
          for i = 1:m
               for k = 1:tnum
                    if ((abs(v(:,i,k,1)-u(:,i,1)) <= 10e-6) && (active(k,j) == 1))
                         on(i,k,j-1) = 1;
                    else
                         on(i,k,j-1) = 0;
                    end
               end
          end
     end
     
     % --- Get the sum of muscles acting --- %
     for j = 1:f-1
          for i = 1:m
               onsum(i,j) = sum(on(i,:,j));
          end
     end
    
     % --- Get R --- %
     R = vnorm;
end
