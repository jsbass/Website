function [h,X,Y,Z] = pointSurf(x,y,z,n)
% takes nonuniform sampled data and plots it on a surface

if(nargin<3)
    error('Data points for x, y, and z not found');
elseif(nargin<4)
    n=20;
end

xlin = linspace(min(x),max(x),n);
ylin = linspace(min(y),max(y),n);
[X,Y] = meshgrid(xlin,ylin);
f = scatteredInterpolant(x,y,z);
Z = f(X,Y);

h = surf(X,Y,Z);

end