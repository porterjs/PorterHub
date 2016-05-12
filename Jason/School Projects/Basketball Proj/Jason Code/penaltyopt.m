% Part3
% Using a basic penalty algorithm, the optimum motion path of the DynMotion
% function was solved by incrementing the multiplier, m, by 100 until it
% reached a good optimum.
function [xopt, fopt, exitflag, output] = penaltyopt()
    
    % --- Initial Values --- %
    theta = [[0 , -60 ,  20], ...        % Frame 1
                 [0 , -40 ,  45],...     % Frame 2
                 [0 , -20 ,  20]];       % Frame 3
        phi   = [[0 , 45,   45],...
                 [0 , 45,   45],...
                 [0 , 45,   45]];

    x = [theta,phi];

    
    m = 1;      % multiplier

    options = optimset(...
            'Algorithm', 'active-set', ...  % choose one of: 'interior-point', 'sqp', 'active-set', 'trust-region-reflective'
            'display', 'iter-detailed', ...  % display more information
            'MaxIter', 1000, ...  % maximum number of iterations
            'MaxFunEvals', 10000, ...  % maximum number of function calls
            'TolFun', 1e-6, ...  % convergence tolerance on function value
            'GradObj', 'off', ...  % supply gradients of objective
            'Diagnostics', 'on');  % display diagnotic information

    while(1)
        
        % Unconstrained optimizer of the penalty function
        [xopt, fopt, exitflag, output] = fminunc(@penalty,x, options);
        
        % Grab optimized result to throw back into the optimizer
        x = xopt
        m = m + 10000
        
        if (m >= 2000)
            break
        end

         
    end
    
    % Create the penalty and add to DynMotion function
    function L = penalty(x)
            [f,c] = DynMotion(x);
            p = m*sum(c);
            L = f + p;
    end
end
