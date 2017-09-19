function [] = plotAxes(h, dim)
% plots an x,y,z axis on the figure, h

if(nargin<1)
    error('no input args');
end

if(nargin<2)
    dim=2;
end

figure(h);

hold on;
line([xmin xmax],0);
line(0,[ymin ymax]);

if(dim > 2)
    zlim = get(h,'ZLim');
    plot3(0,0,linspace(zlim(1),zlim(2),10000));
end

hold off;
end