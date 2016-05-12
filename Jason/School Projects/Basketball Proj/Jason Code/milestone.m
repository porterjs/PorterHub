% Milestone.m 
% Process for developing the DynMotion.m

%% first, cleanup code and make easier to accommodate next set of code %%
%% Milestone 1: Get correct muscle connections %%
%Completed

%% Milestone 2: Add Power restraints $$

%% Milestone 3: Correct arm mass and CM location %%
%Completed

%% Milestone 4: Friction at joints %%

%% Milestone 5: Dissipation for forces %%
%%%

function [on,q] = OnLine(tendon, active, p, u,tnum,m,f)
     % if pend is in line with u, then returns true 
     on = zeros(m,tnum,f);
     v = zeros(3,m,tnum);     
     vnorm = zeros(tnum);
     
     j = 1;
     
     % --- Get tend --- %
     tend = tendon(:,2,:,j);       % end points of tendons
     
     % --- Get pend --- %
     for i = 1:m
         pend(i) = p(:,m,j);
     end
 
     % --- Get v & vnorm --- %
     for i = 1:m
          for k = 1:tnum
               q(:,i,k) = dot(tend(:,k,j),pend(i));  % <----tend dim prob? 
               vnorm(i,tnum) = norm(v(:,i,k));
               v(:,i,k) = q(:,i,k)/vnorm(i,tnum);
          end
     end     
     
     % --- compare with u --- %
     % returns onlinetemp with tendons that affect joint movement
     for j = 1:f
     for i = 1:m
          for k = 1:tnum
               if ((abs(v(:,i,k)-u(:,i,1)) <= 10e-6) && (active(k,j) == 1))
                    on(i,k,j) = 1;
               else
                    on(i,k,j) = 0;
               end
          end
     end
     end
end

Count the number of active muscles for each member
Force Distribution


%% Milestone 6: Basketball setup %%

%% Milestone 7: Improve angle constriants %%

%% Milestone 8: Add 2 more frames $$

%% Milestone 9: Plot hoop/ Kinematic path of basketball%%

