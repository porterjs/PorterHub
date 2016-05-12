% GetTendon.m

function [tendon, tnum] = GetTendon(p, r, f)
     
     % tendon = [[x;y;z],[start,end],[tendon],[frame]]
     tendon = zeros(3,2,1,f);
     tnum   = 8;
     for j = 1:f
          
          % Fixed Location
          % tendon = [[start x,y,z],[end x,y,z]]
          
          % Deltoids
          %tendon(:,:,1,j) = [[-1;-1;1],[-0.1*r(:,2,j)]];
          tendon(:,:,2,j) = [[-1;-1;0],[0;0;0]];
          tendon(:,:,3,j) = [[1;1;0],[(1/6)*r(:,2,j)]];
          % Biceps
          tendon(:,:,4,j) = [[0;0;-(1/18)*r(3,2,j)],[p(:,2,j)+(1/6)*r(:,3,j)]]; 
          tendon(:,:,5,j) = [[0;0;0],[p(:,2,j)+(1/6)*r(:,3,j)]]; 
          % Triceps
          tendon(:,:,6,j) = [[(1/6)*r(:,2,j)],[p(:,2,j)-(1/18)*r(:,3,j)]]; 
          tendon(:,:,7,j) = [[(1/6)*r(:,2,j)],[p(:,2,j)-(1/18)*r(:,3,j)]]; 
          tendon(:,:,8,j) = [[0;0;-(1/18)*r(3,2,j)],[p(:,2,j)-(1/18)*r(:,3,j)]]; 
          % Wrist
          %tendon(:,:,1,j) = [[],[]]; 
          %tendon(:,:,1,j) = [[],[]]; 
          %tendon(:,:,1,j) = [[],[]]; 
          %tendon(:,:,1,j) = [[],[]]; 
                
     end
end