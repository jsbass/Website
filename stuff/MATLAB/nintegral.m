function [nint err] = nintegral(f, a, b, err_min, varargin)
% nintegral: numerical integral using Riemann middle sum
% funciton [nint err] = nintegral(f, a, b, err_min):
%   Calculates numerically the integral from a to b of a function, f, using
%   the middle Riemann sum and an error bound, err_min
% input:
%   f = function to integrate
%   a = lower bound
%   b = upper bound
%   err_min = error bound nint
%   varargin = additional arguments for f
% output:
%   nint = numerical integral of f from a to b within err_min
%   err = error of nint

switch nargin
    case 0
        error('No inputs: 3 inputs required');
    case 1
        error('1 input: 3 inputs required');
    case 2
        error('2 inputs: 3 inputs required');
    case 3
        err_min = 10e-6;
        fprintf('No error bound input. Defaulting to %f\n',err_min);
end

if a>b
    temp=a;
    a=b;
    b=temp;
    rev=-1;
elseif a<b
    rev=1;
else
    nint=0;
    err=0;
    return
end

n=100; err=1; nint=0;
while err>err_min
    Sold=nint;
    h=(b-a)/n;
    x=a;
    nint=0;
    for i=0:n
        nint=nint+f((x+h)/2,varargin{:})*h;
        x=x+h;
    end
    nint=rev*nint;
    err_old=err;
    err = abs(Sold-nint);
    fprintf('%f    %f\n',err,err/err_old);
    n=n*2;
end