function coef = spline_c2 (x, y)
	% Remember that the indexes in Matlab start from 1, not 0

	% si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3
	% si'(x)  =      bi         + 2ci(x - xi)  + 3di(x - xi)^2
	% si''(x) =                   2ci          + 6di(x - xi)
	
	intervals = rows(x) - 1;
	% TOOD 1: si(xi) = yi, i = 0 : n - 1

	mat = zeros(intervals * 4, intervals * 4);
    b = zeros(intervals *4, 1);

    for i = 1:intervals
        b(i) = y(i);
        mat(i, (i - 1) * 4 + 1) = 1;
    endfor

	% TODO 2: s_n-1(xn) = yn

	mat(intervals + 1, (intervals - 1) * 4 + 1) = 1;
    b(intervals + 1) = y(intervals + 1);
    power = 1;
    for i = ((intervals - 1) * 4 + 2) : intervals * 4
        mat(intervals + 1, i) = (x(intervals + 1) - x(intervals)) .^ power;
        power = power + 1;
    endfor


	% TODO 3: si(x_i+1) = s_i+1(x_i+1), i = 0 : n - 1

	% TODO 4: si'(x_i+1) = s_i+1'(x_i+1), i = 0 : n - 1

	% TODO 5: si''(x_i+1) = s_i+1''(x_i+1), i = 0 : n - 1
	k = 2;
    for i = 1:(intervals - 1)
        dif = x(i + 1) - x(i);
        mat(i * 3 + intervals - 1, (4*(i - 1) + 1) : (4 * k)) = [1 dif dif*dif dif .^ 3 -1 0 0 0];
        mat(i * 3 + intervals, 4 * (i - 1) + 1:4 * k) = [0 1 2*dif 3 * dif *dif 0 -1 0 0];
        mat(i * 3 + intervals + 1, 4*(i - 1) + 1:4 * k) = [0 0 2 6 * dif 0 0 -2 0];
        k = k + 1;
    endfor

    mat(intervals + 1 + 3 * (intervals - 1) + 1, 1:4) = [0 0 2 0];
    dif2 = x(intervals + 1) - x(intervals);
    mat(intervals + 1 + 3 * (intervals - 1) + 2, 4 * (intervals - 1) + 1:4 * intervals) = [0 0 2 6 * dif2];


	% TODO 6: s0''(x0) = 0

	% TODO 7: s_n-1''(x_n) = 0

	% Solve the system of equations
	coef = inv(mat) * b;
end
