function [root,fval,err,iter]=fsecant(func,x0,x1,err_min,max_iter,varargin)
% fsecant: secant method root locator
%
%

switch nargin
    case 0
        error('Input expected');
    case 1
        error('Need two initial guesses');
    case 2
        error('Need another initial guess');
    case 3
        err_min = 1e-3;
        max_iter=50;
        fprintf('No minimum error input, defaulting to %f\n',err_min);
        fprintf('No maximum iteration input, defaulting to %d\n',max_iter);
    case 4
        max_iter=50;
        fprintf('No maximum iteration input, defaulting to %d\n',max_iter);
end
iter=0; err=100;x=x1;x_old=x0;
format short;
fprintf('iter      root        err       f(x)     err/err_old\n');
fprintf('%3d    %-8.4f   %-8.4f    %-8.4f\n'...
    ,iter,x,err,func(x,varargin{:})); 
while (1)
    x_new = x-((func(x,varargin{:})*(x_old-x))/...
        (func(x_old,varargin{:})-func(x,varargin{:})));
    x_old=x;
    x=x_new;
    err_old=err;
    if x~=0
        err=abs((x-x_old)/x)*100;
    end
    iter=iter+1;
    if func(x,varargin{:})==0
        err=0;
        break
    end
    err_der=err/err_old;
    if (err<err_min) || (iter>=max_iter)
        break
    end
    fprintf('%3d    %-8.4f   %-8.4f    %-8.4f    %-8.4f\n'...
        ,iter,x,err,func(x,varargin{:}),err_der); 
end
fprintf('%3d    %-8.4f   %-8.4f    %-8.4f    %-8.4f\n'...
    ,iter,x,err,func(x,varargin{:}),err_der); 
root=x;fval=func(x,varargin{:});

end