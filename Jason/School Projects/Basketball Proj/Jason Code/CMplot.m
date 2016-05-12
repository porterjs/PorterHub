% CMplot.m

function CMplot(cp,f1,f2)

     for j = f1:f2
          
          plot3(cp(1,:,j),cp(2,:,j),cp(3,:,j),'k+')
          hold on

     end
     
end