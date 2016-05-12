% skeletalplot.m

function skeletalplot(p,f1,f2)

     for j = f1:f2
                    
               plot3(p(1,:,j),p(2,:,j),p(3,:,j),'-o')
               hold on

     end
     
end