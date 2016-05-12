% gradient.m

function g = gradient(func,x)

    %% CENTRAL DIFFERENCE %%

    % INITIALIZE CONDITIONS
    h = 1e-6         ;     % step-size
    [~,n] = size(x)  ;              % vector length
    g = zeros(1,n)  ;     % gradient 
    ek= zeros(1,n) ;          % directional step component

    % SOLVE
    for i = 1:n
        % SET STEP DIRECTION
        ek    = ek * 0;
        ek(i) = h;
        %print("ek = ",ek)

        % SOLVE GRADIENT
        [J1, ~] = func(x + ek);
        [J2, ~] = func(x - ek);
        

        g(i)  = (J1 - J2) / (2 * h);
    end

end