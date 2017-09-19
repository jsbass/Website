function [x,y] = circlePoints(n,r)
%converts from polar coordinates to cartesian coordinates
%starting from deg=0 at the top of the y-axis and going clockwise
    deg = linspace(0,360,n+1);
    x = (r.*cos(deg2rad(-deg+90))+r)./(2*r)*100;
    y = (r.*sin(deg2rad(-deg+90))+r)./(2*r)*100;
    if ~nargout
        clear x y
    end
    fprintf('i |  deg  |   x   |   y   |\n');
    for i=1:n
        fprintf('%d | %3.2f | %.3f | %.3f |\n',i-1,deg(i),x(i),y(i));
    end
end