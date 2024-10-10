function coef = vandermonde(x, y)
    % x = [x0, x1, ..., xn]'
    % y = [y0, y1, ..., yn]'
    % coef = [a0, a1, a2, ..., an]'

    % TODO: Calculate the Vandermonde coefficients
    n = length(x);  % Length of input vector x
    
    % Initialize the Vandermonde matrix V
    V = zeros(n, n);
    
    % Fill the Vandermonde matrix
    for i = 1:n
        for j = 1:n
            V(i, j) = x(i)^(j-1);
        end
    end
    
    % Solve the linear system V * coef = y for the coefficients
    coef = V \ y;
endfunction
