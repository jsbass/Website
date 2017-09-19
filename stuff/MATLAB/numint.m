function [S err] = numint(f,a,b,err_min,n_max,n0,m_max,varargin)
% numint:   finds the definite numerical intergral approxiamation using
%           Reimann middle sums
%
%
% inputs:
%   f = function to be integrated f(x...)
%   a = lower bound
%   b = upper bound
%   err_min = minimum error bound for answer (0 for default)
%   n_max = maximum number of subintervals on the interval I:[a b] 
%          (0 for default)
%   n0 = initial number of subintervals (0 for default)
%   m_max = slope tolerance before assuming a discontinuity (0 for default)
%   varargin = additional arguments for f
%

switch nargin
    case 0
        error('No inputs: 3 inputs required');
    case 1
        error('1 input: 3 inputs required');
    case 2
        error('2 inputs: 3 inputs required');
    case 3
        err_min=1e-6;
        n_max=2147483647;
        n0=10;
        m_max=1e10;
        fprintf('No error bound specified, defaulting to %1.2e\n',err_min);
        fprintf('No maximum number of subintervals specified,');
        fprintf(' defaulting to %d\n',n_max);
        fprintf('No starting number of subintervals specified,');
        fprintf(' defaulting to %d\n',n0);
        fprintf('No max slope specified, defaulting to %e\n',m_max);
    case 4
        n_max=2147483647;
        n0=10;
        m_max=1e10;
        fprintf('No maximum number of subintervals specified,');
        fprintf(' defaulting to %d\n',n_max);
        fprintf('No starting number of subintervals specified,');
        fprintf(' defaulting to %d\n',n0);
        fprintf('No max slope specified, defaulting to %e\n',m_max);
    case 5
        n0=10;
        m_max=1e10;
        fprintf('No starting number of subintervals specified,');
        fprintf(' defaulting to %d\n',n0);
        fprintf('No max slope specified, defaulting to %e\n',m_max);
    case 6
        m_max=1e10;
        fprintf('No max slope specified, defaulting to %e\n',m_max);
end

%======================= Error Checking Inputs ===========================%

if err_min == 0
    err_min=1e-6;
    fprintf('Defaulting error bound to %1.2e\n',err_min);
end
if n_max == 0
    n_max=2147483647;
    fprintf('Defaulting maximum number of subintervals to %d\n',n_max);
end
if n0 == 0
    n0=10;
    fprintf('Defaulting initial number of subintervals to %d\n',err_min);
end
if mod(n0,1)~=0||n0<0
    error('n0 must be a positive integer');
end
if mod(n_max,1)~=0||n_max<0||n_max<n0
    error('n_max must be a positive integer and greater than n0');
end
if b<a
    temp=b;
    b=a;
    a=temp;
    rev=-1;
elseif a<b
    rev=1;
else
    S=0;
    err=0;
    return
end
if n_max>2147483647
    n_max=2147483647;
    fprintf('The maximum number of subintervals is too large');
    fprintf(', changing to max index size (%d)\n',n_max);
end
%=========================================================================%

n=n0; err=1e99; S=0;
fprintf('|     n     |      nint    |       err    |\n');
while (err>err_min)&&(n<=n_max)
    Sold=S;
    S=0;
    dx=(b-a)/n;
    x=a;
    for i=0:n
        S=S+f(x+(dx/2),varargin{:})*dx;
        m=(f(x+dx,varargin{:})-f(x,varargin{:}))/dx;
        if m > m_max
            fprintf('The slope around x=%f,',(x+dx)/2);
            fprintf(' indicates that the integral may diverge\n');
            S=Inf;
            err=0;
            return;
        end
        x=x+dx;
    end
    S=S*rev;
    err = abs(S-Sold);
    fprintf('|%10d | %12.4e | %12.4e |\n',n,S,err);
    n=n*2;
end