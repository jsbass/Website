function [sqroot, err] = divandavg(a, err_margin)
% divandavg:        divide and average method for sqaure roots
% x = divandavg:    uses the divide and average method to find the square
%                   root of an integer, a, such that it is within the
%                   error, err, of the actual square root.
% input:
%   a = integer to take the square root of
%   err_margin = error margin for the approxiation of the square root
% output:
%   sqroot = the approximated square root
%   err = the error between sqroot and the actual square root

    switch nargin
        case 0
            error('No input - 2 inputs needed');
        case 1
            error('1 input - 2 inputs needed');
    end
    
    x_new = 1;
    x_old = 0;
    err = 1;
    complex = 0;
    count = 1;
    
    if a == 0
        sqroot = 0;
        err = 0;
        return
    end
    
    if a < 0
        a = -1*a;
        complex = 1;
    end
    
    while (1)
        x_old = x_new;
        x_new = (x_old+(a/x_old))/2;
        err = abs((x_new-x_old)/x_new);
        fprintf('For step %d, x = %f and error = %f\n',count,x_new,err);
        if err <= err_margin
            break
        end
        count = count + 1;
    end
    
   if complex
       sqroot = x_new*1i;
   else
       sqroot = x_new;
   end

return