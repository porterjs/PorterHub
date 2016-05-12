% Objective.m

function J = Objective(v,f)

     J = cross(v(:,1),v(:,2));
     
     for j = 3:f
          J = cross(J,v(:,j));
     end
end