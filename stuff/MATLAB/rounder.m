function xr = rounder(x, n)
% rounder:              round to a specified value
% xr = rounder(x,n):    Rounds the specified value, x, to a specified
%                       number of decimals, n.
% inputs:
%   x = number or array/matrix to be rounded
%   n = number of decimals to round to
% outputs:
%   xr = x rounded to n decimals

    switch nargin
        case 0
            error('No inputs - At least 1 input needed');
        case 1
            n = 2;
            fprintf('No number of decimal digits specified\n');
            fprintf('Rounding %f to %d decimal places\n',x,n);
    end
    
    if (mod(n,1) ~= 0)
        error('n must be an integer');
    end
    
    xr = round(x.*(10^n))./(10^n);
    
return
    