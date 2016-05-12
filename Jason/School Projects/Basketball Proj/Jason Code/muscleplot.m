% muscleplot.m

function muscleplot(tendon,active,tnum,f1,f2)

     for j = f1:f2
          for i = 1:tnum
          
               if (active(i,j) == 1)
                    plot3(tendon(1,:,i,j),tendon(2,:,i,j),tendon(3,:,i,j),'-r')
               else
                    plot3(tendon(1,:,i,j),tendon(2,:,i,j),tendon(3,:,i,j),'-k')
               end
          
               hold on

          end
     end
     
end