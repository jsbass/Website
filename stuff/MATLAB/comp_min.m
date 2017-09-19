function min = comp_min(max_iter)
% comp_min: determin the computer's minimum real number
% min = comp_min(max_iter): determines a computers minimum real number
%                           unless the iterations exceeds the limit
% input:
%   max_iter = maximum number of iterations
% output:
%   min = computers minimum real number

if nargin < 1 || isempty(max_iter)
    max_iter = 10000;
end
min=1;
count=1;
while (1)
    if count>=max_iter
        error('count exceeded maximum allowable iterations')
    end
    minold=min;
    min=min/2;
    if min==0,break,end
    count=count+1;
end
min = minold;
return
    