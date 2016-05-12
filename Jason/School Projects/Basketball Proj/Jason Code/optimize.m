function [xopt, fopt, exitflag, output] = optimize()

    % Using a nested function approach because fmincon requires obj and con
    % to be separate functions, but usually we compute them simultaneously.
    % We want to avoid redundant calculations to we will save the x we
    % used to compute obj(x) and if con(x) is the same locaiton we will
    % just use the value without recalling our function.


    % -------- starting point and bounds --------------
    % --- Initial Conditions --- %
theta = [[0 , -60 ,  20], ...        % Frame 1
         [0 , -40 ,  90],...     % Frame 2
         [0 , -05 , 110],...
         [0 ,  20 ,  45]];       % Frame 3
phi   = [[0 , 45,   45],...
         [0 , 45,   45],...
         [0 , 45,   45],...
         [0 , 45,   45]];
x0    = [theta,phi];
frames= 4;
nodes = 3;
    ub = [];
    lb = [];
    % -------------------------------------------------

    % ------ linear constraints -----------------
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    % --------------------------------------

    % ------- common variables ----------
    % these are variables used in both obj and con
    xcheck = 0*x0;
    c = [];
    %dcdx = [];
    % --------------------------------------

    % ------------------ optimize --------------------
    options = optimset(...
        'Algorithm', 'active-set', ...  % choose one of: 'interior-point', 'sqp', 'active-set', 'trust-region-reflective'
        'AlwaysHonorConstraints', 'bounds', ...  % forces interior point algorithm to always honor bounds
        'display', 'iter-detailed', ...  % display more information
        'MaxIter', 1000, ...  % maximum number of iterations
        'MaxFunEvals', 10000, ...  % maximum number of function calls
        'TolCon', 1e-6, ...  % convergence tolerance on constraints
        'TolFun', 1e-6, ...  % convergence tolerance on function value
        'GradObj', 'off', ...  % supply gradients of objective
        'GradConstr', 'off', ...  % supply gradients of constraints
        'Diagnostics', 'on');  % display diagnotic information

% other potentially useful options.  see documentation for others.
%         'FinDiffType', 'forward', ...  % if finite differencing, can also use central
%         'DerivativeCheck', 'on', ...  % on if you want to check your supplied gradients against finite differencing

    [xopt, fopt, exitflag, output] = fmincon(@obj, x0, A, b, Aeq, beq, lb, ub, @con, options);
    % ------------------ optimize --------------------


    % ---------- Objective Function ------------------
    function [J] = obj(x)

        [f, c] = DynMotion(x,frames,nodes);
        xcheck = x;  % we save the x we evaluated at so if con uses same x we don't need to call function again
        %g = gradient(@DynMotion,x)
        J = f * 10.0;  % scale to make objective of order(1)
%        g = g* 10.0;%dfdx / 30.0;
    end
    % -------------------------------------------------

    % ------------- Constraints ------------------------
    function [cin,ceq] = con(x)
        
        if any(x ~= xcheck)  % check if this is the x we just evaluated at in obj.  if not, reevaluate.
            [~, c] = DynMotion(x,frames,nodes);
            xcheck = x;
        end

        cin = c;  % of the form c(x) <= 0
        ceq = [];
        %dcin = [];%dcdx';  % dcin_ij = dc_j / dx_i (opposite of what we defined, hence transpose)
        %dceq = [];
        
    end
    % ------------------------------------------------


end