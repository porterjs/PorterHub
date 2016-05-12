% ExitVel.m
% misnomer, really determines the velocity of the ball at each stage

function v = ExitVel(time,_v,p,n,f)

     v = zeros(3,f);
     
     for j = 1:f-1
          v(:,j) = (p(:,n,j+1)-p(:,n,j))/time;
     end
     
     v(:,f) = _v
          
end