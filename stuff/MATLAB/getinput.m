function [x,y] = getinput(n,func,trace,domain,range,varargin)
% getinput: gets input from figure

switch nargin
    case 0
        n = 1;
        func = @(x) 0;
        trace = true;
        range = [-10,10];
        domain = [-10,10];
    case 1
        func = @(x) 0;
        trace = true;
        domain = [-10,10];
        range = [-10,10];
    case 2
        trace = true;
        domain = [-10,10];
        range = [func(domain(1),varargin{:}),func(domain(2),varargin{:})];
    case 3
        domain = [-10,10];
        range = [func(domain(1),varargin{:}),func(domain(2),varargin{:})];
    case 4
        range = [func(domain(1),varargin{:}),func(domain(2),varargin{:})];
end

%makes empty arrays for x and y data
x=[];
y=[];
%sets the range and domain for the plot
xdata = linspace(domain(1),domain(2),1000);
if sym(func)==0
    ydata = linspace(range(1),range(2),1000);
else
    ydata = linspace(func(domain(1)),func(domain(2)),1000);
end
%decides whether to use callback functions to trace the function
if trace
    fig = figure('WindowButtonMotionFcn',@mousemove,...
        'WindowButtonDownFcn',@mouseclick);
else
    fig = figure;
end
%creates lines for the func,x axis, and yaxis
funcln = line(x,func(x,varargin{:}));
xaxis = line(xdata,0);
yaxis = line(0,ydata);
refreshdata;
       
%nested callback functions
        function mousemove(src,~)
            pos = get(gca,'CurrentPoint');
            traceln = line(pos(1),...
                linspace(pos(2),func(pos(1),varargin{:}),100));
        end

        function mouseclick(src,~)
            pos = get(gca,'CurrentPoint');
            xtemp = pos(1);
            ytemp = pos(2);
            x = [x pos(1)];
            y = [y pos(2)];
        end
end
