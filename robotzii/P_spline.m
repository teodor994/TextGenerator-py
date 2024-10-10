function y_interp = P_spline(coef, x, x_interp)
    n = length(x) - 1;
    coef = reshape(coef, 4, n);
    y_interp = zeros(size(x_interp));
    for j = 1:length(x_interp)
        i = find(x_interp(j) >= x(1:end-1) & x_interp(j) <= x(2:end), 1, 'first');
        h = x_interp(j) - x(i);
        y_interp(j) = coef(1,i) + coef(2,i)*h + coef(3,i)*h^2 + coef(4,i)*h^3;
    endfor
end