function [h,fsum,farray] = seriesgrphr(func,xmin,xmax,nmax,varargin)
%
%
%
switch nargin
    case 0
        error('no input');
    case 1
        xmin=-10; xmax=10; nmax=10;
        fprintf('defaulting: xmin=%d, xmax=%d, nmax=%d\n',xmin,xmax,nmax);
end
syms x
n = 0:1:nmax;
farray = func(x,n,varargin{:});
if isnan(farray(1))
    n = 1:1:nmax;
    farray = func(x,n,varargin{:});
end
fsum = matlabFunction(sum(farray));
xval = linspace(xmin,xmax,5000);
pline = plot(xval,fsum(xval,varargin{:}));
xaxis = line(get(gca,'XLim'),[0 0],'Color','k');
yaxis = line([0 0], get(gca,'YLim'),'Color','k');
h = gca;
set(h,'Children',[pline xaxis yaxis]);
shg;
end