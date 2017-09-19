function [root,fval,err,iter] = fxdpoint(func,x0,err_min,max_iter,varargin)
% fixedpoint: fixed-point root locator
%
% input:
%   func=function that equals the independent variable (x=g(x))

%input checks
switch nargin
    case 0
        error('Input expected');
    case 1
        error('Please designate an initial root estimate');
    case 2
        err_min = 1e-3;
        max_iter=50;
        fprintf('No minimum error input, defaulting to %f\n',err_min);
        fprintf('No maximum iteration input, defaulting to %d\n',max_iter);
    case 3
        max_iter=50;
        fprintf('No maximum iteration input, defaulting to %d\n',max_iter);
end

iter=0; err=100; x=x0;
fprintf('iter     root        err       fval    err/err_old\n');
fprintf('%3d    %-8.4f   %-8.4f    %-8.4f\n'...
    ,iter,x,err,func(x,varargin{:})); 
while (1)
   x_old = x;
   x = func(x,varargin{:});
   err_old=err;
   if x~=0
       err=abs((x-x_old)/x)*100;
   end
   iter=iter+1;
   if func(x,varargin{:})==0
       err=0;
       break;
   end
   err_der=err/err_old;
   if err<err_min || iter>=max_iter,break,end
   fprintf('%3d    %-8.4f   %-8.4f    %-8.4f    %-8.4f\n'...
       ,iter,x,err,func(x,varargin{:}),err_der); 
end
fprintf('%3d    %-8.4f   %-8.4f    %-8.4f    %-8.4f\n'...
    ,iter,x,err,func(x,varargin{:}),err_der); 
root=x;fval=func(x,varargin{:});

end

