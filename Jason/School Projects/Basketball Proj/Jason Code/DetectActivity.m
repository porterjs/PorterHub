% DetectActivity.m
% Determines if a muscle is contracting or not.

function active = DetectActivity(tendon, tnum, f)
     % --- Initialize Vars --- %
     active = zeros(tnum,f);
     dist   = zeros(tnum,f);
     
     % --- Determine Activity --- %
     for j = 1:f
          for i = 1:tnum
               % Get Length of Muscle
               dist(i,j) = sqrt((tendon(1,2,i,j)-tendon(1,1,i,j))^2 + ...
                    (tendon(2,2,i,j)-tendon(2,1,i,j))^2 + ...
                    (tendon(3,2,i,j)-tendon(3,1,i,j))^2);
               % See if length decreases
               if (j > 1)
                    if (dist(i,j)-dist(i,j-1) < 0)
                         active(i,j) = 1;
                    end
               end
          end
     end
end