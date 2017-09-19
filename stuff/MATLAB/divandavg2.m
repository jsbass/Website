function [sqroot,err,count] = divandavg(a, err_margin, max_iter)
% divandavg:        divide and average method for sqaure roots
% x = divandavg:    uses the divide and average method to find the square
%                   root of an integer, a, such that it is within the
%                   error, err, of the actual square root.
% input:
%   a = integer to take the square root of
%   err_margin = error margin for the approxiation of the square root
%   max_iter = the max number of iterations to run
% output:
%   sqroot = the approximated square root
%   err = the error between sqroot and the actual square root

    switch nargin
        case 0
            error('No input - 2 inputs needed');
        case 1
            error('1 input - 2 inputs needed');
    end
    
    x = 1;
    err = 100;
    complex = 0;
    count = 1;
    
    if a < 0
        a = -1*a;
        complex = 1;
    end
    
    if a==0
        sqroot=0;
        err=0;
        count=0;
    	return
    end
    while (1)
        x_old = x;
        x = (x_old+(a/x_old))/2;
        if x ~= 0
            err = abs((x-x_old)/x)*100;
        end
        fprintf('For step %d, x = %f and error = %f\n',count,x,err);
        if err <= err_margin
            break
        end
        count = count + 1;
        if count>=max_iter
            break
        end
    end
    
    if complex
        sqroot = x*1i;
    else
        sqroot = x;
    end

end