function [root,fval,err,iter] = fbisectgraph(func,xl,xu,err_min,range)
% fbisect: bisection root locator with graphical input
%   [root,fval,err,iter] = fbisect(func,guesses,err_min,range):
%       
%

% Check input lengths
limits = 2;
switch nargin
    case 0
        error('No input detected. At least 3 inputs expected');
    case 1
        limits = 0;
        err_min = 1e-5;
        range = {-20,20};
        fprintf('No error minimum detected. Defaulted to %f\n',err_min);
        fprintf('Range set from %d to %d\n',range{1},range{2});
    case 2
        limits = 1;
        err_min = 1e-5;
        range = {-20,20};
        fprintf('No error minimum detected. Defaulted to %f\n',err_min);
        fprintf('Range set from %d to %d\n',range{1},range{2});
    case 3
        err_min = 1e-5;
        range = {-20,20};
        fprintf('No error minimum detected. Defaulted to %f\n',err_min);
        fprintf('Range set from %d to %d\n',range{1},range{2});
    case 4
        err_min = 1e-5;
        range = {-20,20};
        fprintf('No error minimum detected. Defaulted to %f\n',err_min);
        fprintf('Range set from %d to %d\n',range{1},range{2});
    case 5
        range = {-20,20};
        fprintf('Range set from %d to %d\n',range{1},range{2});
end

if nargin(func)>1
    fprintf('Please specify %d additional arguments for %s\n',...
        nargin(func)-1,func2str(func));
    fargin = input('Please specify additional arguements in an array\n');
else
    fargin = {};
end

x=range{1}:(range{2}-range{1})/100:range{2};

% User interface to select missing guesses
if limits==0
    fprintf('Please select an upper and lower bound for the root\n');
    plot(x,func(x,fargin{:}));
    hold on;
    plot(x,0,'Color','r');
    [xin,yin] = ginput(2);
    xl = min(xin(1),xin(2));
    xu = max(xin(1),xin(2));
    plot(xl,func(xl,fargin{:}),'Marker','o');
    plot(xu,func(xu,fargin{:}),'Marker','o');
elseif limits==1
    fprintf('Please select an upper bound for the root\n');
    plot(x,func(x,fargin{:}));
    hold on;
    plot(xl,func(xl,fargin{:}),'Marker','o');
    plot(x,0,'Color','r');
    xu = ginput(1);
    plot(xu,func(xu,fargin{:}),'Marker','o');
end
hold off;

% Check for sign change inside of interval
if func(xl,fargin{:})*func(xu,fargin{:})>0
    error('No sign change between %f and %f', xl,xu);
end

%find number of iterations needed
n = ceil(log2((xu-xl)/err_min));
iter = 0; xr = xl; err=100;
while (1)
    xr_old = xr;
    xr = (xu+xl)/2;
    iter = iter+1;
    if xr~=0,err = abs((xr-xr_old)/xr)*100;end
    if func(xr,fargin{:})==0
        err = 0;
        break;
    end
    if func(xl,fargin{:})*func(xr,fargin{:}) < 0
        xu=xr;
    else
        xl=xr;
    end
    if err<err_min || iter>=n,break,end
end
root = xr; fval = func(xr,fargin{:});
end