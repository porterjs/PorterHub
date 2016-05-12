% DynMotion.m

function J = DynMotion(x0, frames, nodes)
     
     % --- Initilize Vars --- %
     J = 0;
     n = nodes;
     m = nodes - 1;
     f = frames;
     theta = zeros(f,n);
     phi   = zeros(f,n);
     framespeed = 1;     % second
     
     % --- Unwrap Input Data --- %
     for j = 1:f
          for i = 1:n
               a = n*(j-1) + i;
               b = a + n*f;
               theta(j,i) = x0(a);
               phi(j,i)   = x0(b);
          end
     end
     
     % --- Physical Properties --- %
     % Length Ratios found at 
     % www.openlab.psu.edu/tools/proportionality_constants.htm
     h        = 79;      % in, average height of basketball player
     wingspan    = h*0.259; % in
     h_upperarm  = h*0.186; % in 
     h_forearm   = h*0.146; % in
     h_hand      = h*0.108; % in
     length = [0.0, h_upperarm, h_forearm, h_hand];
     % Weight Ratios found at 
     % http://www.strangequestions.com/question/1108/What-percentage-of-weight-does-each-body-part-comprise-Head-arms-legs-torso.html
     w           = 221.00;  % pounds
     w_upperarm  = w*0.027;
     w_forearm   = w*0.016;
     w_hand      = w*0.066;
     weight = [w_upperarm, w_forearm, w_hand];
     % Segmental Center of Gravity Locations
     % http://www.exrx.net/Kinesiology/Segments.html
     c = [0.44, 0.43, .468];
     g = 32.2*12;        % in/s^2, gravity
     I = zeros(m,1);     % Inertia 
     
     
     % --- Joint Position --- %
     [r, p] = JointPos(theta, phi, length, n, f);
     
     % --- Relative Angle Difference --- %
     % Relative angle determines muscle activity
     [dtheta, dphi] = RelAngDiff(theta, phi, n, f);
     
     % --- Center of Mass Positions --- %
     [cr,cp] = CMPos(c, r, p, length, m, f);
     
     % --- Rotational Inertia about Joint --- %
     I = RotInertia(weight,length, m);
     
     % --- Tendon Locations --- %
     [tendon, tnum] = GetTendon(p, r, j);
     
     % --- Muscle Activity --- %
     active = DetectActivity(tendon, tnum, f);
         
     % --- Plot --- %
     f1 = 2;
     f2 = 2;
     figure(1)
     skeletalplot(p,f1,f2)
     CMplot(cp,f1,f2)
     muscleplot(tendon,active,tnum,f1,f2)
     xlabel('x')
     ylabel('y')
     zlabel('z')
     title('')
     axis([-5 25 -5 25])
     
     
     % --- Unit Vectors of Arm Segments --- %
     [u,v] = UnitVec(r, n, f);
     
     % --- Inner Angle Change --- %
     [alpha,dalpha] = InnerAng(u, v, m, f);
     
     % --- Relative Angular Velocity of Member --- %
     omega = dalpha/framespeed;
     
     % --- Rotational Kinetic Engergy --- %
     [T, t] = RotEner(dalpha, I, omega, m, f);
     
     % --- Check if Tendon afffects member movement --- %
     % on is a matrix [m,tnum] 
     % R is a matrix [3,m,tnum], for t=FxR 
     [on,onsum,R] = OnLine(tendon, active, p, u,tnum,m,f);
     
     % --- Get Force Distribution --- %
     DForce = GetDynForce(t, on, onsum, tnum, R, m, f)
     %GetStaticForce()
     %TotForce = DynForce + StatForce;
     
     % --- Equality Constraints --- %
     C(1) = theta(1,1);
     C(2) = theta(2,1);
     C(3) = theta(3,1);
     C(4) = phi(1,1);
     C(5) = phi(2,1);
     C(6) = phi(3,1);
     
     % --- Inequality Constraints --- %
      % Elbow hyperextension constraint
     c(1) = alpha(1,1) - 180;  
     c(2) = 20-alpha(1,1);
     c(3) = alpha(1,2) - 180;
     c(4) = 20-alpha(1,2);
      %Shoulder joint constraints
     c(5) = theta(1,2)-20;  
     c(6) = -theta(1,2) -110;
     c(7) = theta(2,2)-20;
     c(8) = -theta(2,2) -110;
     c(9) = theta(3,2)-20;
     c(10) = -theta(3,2) -110;     
     
     % --- Calculate Desired Exit Velocity --- %
     % Note: Ideally this will be solved for though kinematics
     % but for the lack of time, it has been simplified with an estimated
     % exit velocity for the time being. Location of ball at release is 
     % ignored in this case. 
     _v = [50;50;30];       % in/s
     
     v = ExitVel(framespeed,_v,p,n,f);
     
     
     % --- Solve Objective --- %
     J = Objective(v,f);
     
     % --- Return Objective --- %

end
