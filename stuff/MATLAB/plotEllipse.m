function [hout, x, y] = plotEllipse(r1, r2, c, h)
% Makes an ellipse centered on (c1,c2) with the horizontal axis
% as r1 and the vertical axis as r2

if(nargin<1)
    error('no inputs');
elseif(nargin<2)
    r2 = r1;
    c = [0 0];
    h = figure();
elseif(nargin<3)
    c = [0 0];
    h = figure();
elseif(nargin<4)
    h = figure();
end

x0=c(1);
y0=c(2);

t=-pi:0.01:pi;

x=x0+r1*cos(t);
y=y0+r2*sin(t);

figure(h);

hold on
plot(x,y);
hold off;

hout = h;
end