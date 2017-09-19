function [root,fval,err,iter] = fbisectabs(func,xl,xu,err_min,n,varargin)
% fbisectabs: bisection root locator with absolute error
%   [root,fval,err,iter] = fbisectabs(func,x1,xu,err_min,max_iter,fargin):
%       determines the roots between two point, xl and xu, of a function,
%       func, using the bisection method, to within an error, err_min.
%       varargin are aditional arguments on func beyond the main variable 
%       func(x, varargin{:})
% inputs:
%   func=function to find roots of
%   xl=lower guess
%   xu=upper guess
%   err_min=minimum relative error to achieve
%   varargin=additional arguments for func
%
% outputs:
%   root=function root estimate between guesses
%   fval=function value at the root estimate
%   err=relative error of iteration
%   iter=number of iterations taken

% Check input lengths
switch nargin
    case 0
        error('No input detected. At least 3 inputs expected');
    case 1
        error('1 input detected. At least 3 inputs expected');
    case 2
        error('2 input detected. At least 3 inputs expected');
    case 3
        err_min = 1e-5;
        fprintf('No error minimum detected. Defaulted to %f\n',err_min);
end

% Check for sign change inside of interval
if func(xl,varargin{:})*func(xu,varargin{:})>0
    error('No sign change between %f and %f', xl,xu);
end

%find number of iterations needed
iter = 0; xr = xl; err=100;
while (1)
    xr_old = xr;
    xr = (xu+xl)/2;
    iter = iter+1;
    err = abs(xr-xr_old);
    if func(xr,varargin{:})==0
        err = 0;
        break;
    end
    if func(xl,varargin{:})*func(xr,varargin{:}) < 0
        xu=xr;
    else
        xl=xr;
    end
    if err<err_min || iter>=n,break,end
end
root = xr; fval = func(xr,varargin{:});

end

