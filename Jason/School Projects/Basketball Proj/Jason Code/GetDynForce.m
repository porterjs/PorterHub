

function DForce = GetDynForce(t, on, onsum, tnum, R, m, f)
     
     % --- Initialize Vars --- %
     DForce = zeros(tnum,f-1);
     
     %onsum
     for j = 1:f-1
          for i = 1:m
               if (onsum(i,j) > 0)
                    tdiv(i,j) = abs(t(i,j))/onsum(i,j);
                    
                    for k = 1:tnum                    
                         DForce(k,j) = DForce(k,j) +...
                         on(i,k,j)*tdiv(i,j)/R(i,k,j);
                    end
               end
          end
     end
     
     
     

end