function [opt,fopt,err,iter,type,vars] = fminparaint...
    (func,x1,x2,x3,err_min,max_iter,varargin)
% fminparaint: parabolic interpolation method optima locator
% 
%
%

switch nargin
    case 0
        error('No inputs detected, 4 inputs expected');
    case 1
        error('1 input detected, 4 inputs expected');
    case 2
        error('2 inputs detected, 4 inputs expected');
    case 3
        error('3 inputs detected, 4 inputs expected');
    case 4
        err_min = 1e-4;
        max_iter = 50;
        fprintf('No minimum error specified, defaulting to %f\n',err_min);
        fprintf('No iteration limit specified, defaulting to %d\n,',...
            max_iter);
    case 5
        max_iter = 50;
        fprintf('No iteration limit specified, defaulting to %d\n,',...
            max_iter);
end

%Order inputs from lowest to highest
a = sort([x1 x2 x3]);
x1 = a(1);x2=a(2);x3=a(3);

iter = 0;err=100;x4=x2;
fprintf('n   | x         | f(x)     | err\n');
fprintf('%-3d |           |          | %-1.4f\n',iter,err);
if func(x1,varargin{:})>func(x2,varargin{:})
    type='Minimum';
elseif func(x1,varargin{:})<func(x2,varargin{:})
    type='Maximum';
elseif func(x2,varargin{:})<func(x3,varargin{:})
    type='Minimum';
elseif func(x2,varargin{:})>func(x3,varargin{:})
    type='Maximum';
else
    type='Undetermined Optima';
end
while (1)
    x4_old=x4;
    num = ((x2-x1)^2)*(func(x2,varargin{:})-func(x3,varargin{:}))...
        -((x2-x3)^2)*(func(x2,varargin{:})-func(x1,varargin{:}));
    den = (x2-x1)*(func(x2,varargin{:})-func(x3,varargin{:}))...
        -(x2-x3)*(func(x2,varargin{:})-func(x1,varargin{:}));
    if den~=0
        x4 = x2-(1/2)*(num/den);
    else 
        fprintf('Max computer precision for denominator reached\n');break
    end
    
    if x4~=0,err = abs((x4_old-x4)/x4)*100;end
    iter = iter+1;
    
    fprintf...
        ('%-3d | %-9.5f | %-8.5f | %-6.5f\n',iter,x4,...
        func(x4,varargin{:}),err);
    
    if x4>x2
        x1=x2;
        x2=x4;    
        %x3=x3;
    else
        x3=x2;
        x2=x4;
        %x1=x1;
    end
    
    if (err<err_min) || (iter>=max_iter)
        break
    end
end
vars=[x1,x2,x3];
opt=x4;fopt=func(opt,varargin{:});
fprintf('The function has a %s at %f with a value of %f\n'...
    ,type, opt,fopt);
end