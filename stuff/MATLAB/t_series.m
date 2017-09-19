function S = t_series(x, n)
% t_series:           a sine series to a finite step
% s = t_series(x,n):  compute and display the value for each step of the 
%                   taylor series for the sine function given a value, x,
%                   to evaluate the sine function at and a number of steps,
%                   n.
% input:
%   x = the sin value to be evaluated
%   n = the number of steps in the series to compute
% output
%   S = a table containing n in one column, the computed value in the
%   another, and the error between the estimated value and actual sine value
%   in the last.
%
    switch nargin
        case 0
            error('No input found - 2 input required')
        case 1
            error('1 Input found - 2 input required')
    end

    fprintf('sin(%3f) = %f\n',x,sin(x));
    fprintf('The series to %d terms:\n\n',n);
    k = -1;
    S = ones(n+1,3);
    S(1,:) = [0,x,err_calc(sin(x),x)];
    
    for i=1:n
        S(i+1,1) = i;
        S(i+1,2) = S(i,2)+k*(x^((2*i)+1))/fact(2*i+1);
        S(i+1,3) = err_calc(sin(x), S(i+1,2));
        k = k*(-1);
    end

    fprintf('n     sum     error\n');

    for i=1:n+1
        fprintf(' %-3.0f %-7.3f %-5.2f%%\n',S(i,1),S(i,2),S(i,3));
    end
return

function err = err_calc(true,calc)
% calculate the percent error between two values
    err = 100*(true-calc)/true;
return

function f = fact(a)
% calculate the factorial of an integer
    f=1;
    for i=2:a
        f = i*f;
    end
return