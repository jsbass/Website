function [V err] = rectnumint(f,a,b,c,d,err_min,n_max,n0,m_max,varargin)
% numint:   finds the definite numerical intergral approxiamation of a two
%           variable function using Reimann middle sums on a rectangular
%           area.
%
%
% inputs:
%   f = function to be integrated f(x,y,...)
%   a = lower x-bound
%   b = upper x-bound
%   c = lower y-bound
%   d = upper y-bound
%   err_min = minimum error bound for answer (0 for default)
%   n_max = maximum number of subintervals on the interval I:[a b] 
%          (0 for default)
%   n0 = initial number of subintervals (0 for default)
%   varargin = additional arguments for f
%

switch nargin
    case 0
        error('No inputs: 5 inputs required');
    case 1
        error('1 input: 5 inputs required');
    case 2
        error('2 inputs: 5 inputs required');
    case 3
        error('3 inputs: 5 inputs required');
    case 4
        error('4 inputs: 5 inputs required');
    case 5
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
    case 6
        n_max=2147483647;
        n0=10;
        m_max=1e10;
        fprintf('No maximum number of subintervals specified,');
        fprintf(' defaulting to %d\n',n_max);
        fprintf('No starting number of subintervals specified,');
        fprintf(' defaulting to %d\n',n0);
        fprintf('No max slope specified, defaulting to %e\n',m_max);
    case 7
        n0=10;
        m_max=1e10;
        fprintf('No starting number of subintervals specified,');
        fprintf(' defaulting to %d\n',n0);
        fprintf('No max slope specified, defaulting to %e\n',m_max);
    case 8
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
rev=1;
if b<a
    temp=b;
    b=a;
    a=temp;
    rev=-1;
elseif a==b
    V=0;
    err=0;
    return
end
if d<c
    temp=d;
    d=c;
    c=temp;
    rev=-rev;
elseif a==b
    V=0;
    err=0;
    return
end
if n_max>2147483647
    n_max=2147483647;
    fprintf('The maximum number of subintervals is too large');
    fprintf(', changing to max index size (%d)\n',n_max);
end
%=========================================================================%

n=n0; err=1e99; V=0;
fprintf('|     n     |      nint    |       err    |\n');
while (err>err_min)&&(n<=n_max)
    Vold=V;
    V=0;
    dx=(b-a)/n;
    dy=(d-c)/n;
    x=a;
    y=c;
    for i=0:n
        for j=0:n
            V=V+f(x+(dx/2),y+(dy/2),varargin{:})*dx*dy;
            mx=(f(x+dx,y+(dy/2),varargin{:})-f(x,y+(dy/2),varargin{:}))/dx;
            my=(f(x+(dx/2),y+dy,varargin{:})-f(x+(dx/2),y,varargin{:}))/dy;
            if mx>m_max||my>m_max
                fprintf('The slope around (x,y)=(%f,%f)',...
                    (x+dx)/2,(y+dy)/2);
                fprintf(' indicates that the integral may diverge\n');
                V=Inf;
                err=0;
                return;
            end
        y=y+dy;
        end
        x=x+dx;
    end
    V=V*rev;
    err = abs(V-Vold);
    fprintf('|%10d | %12.4e | %12.4e |\n',n,V,err);
    n=n*2;
end