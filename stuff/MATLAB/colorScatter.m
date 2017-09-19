function [hout,cVec] = colorScatter(x,y,z,s,h,axis,dz)
% plots 3d data as a 2d plot with the 3rd dimension represented by color
%
% input:
%     x = x data
%     y = y data
%     z = z data
%     s = size of points
%     axis = boolean for whether to include x,y centered axis lines
%     dz = change from average that results in the most
%          extreme color (red/blue). Values outside this
%          range won't appear
%
% ouput:
%     h = plot handle
%     cVec = RGB color vector of points
%
hold on;
if(nargin<3)
    error('must provide x, y, and z data');
elseif(nargin==3)
    s = 10;
    fprintf('defaulting to a calculated dz');
    axis=true;
    dz = (max(z)-min(z))/2;
elseif(nargin==4)
    h = figure();
    dz = (max(z)-min(z))/2;
    axis=true;
elseif(nargin==5)
    dz = (max(z)-min(z))/2;
    axis=true;
elseif(nargin<7)
    dz = (max(z)-min(z))/2;
end

figure(h);
fprintf('dz = %f\n',dz);

maxz = (max(z)+min(z))/2+dz;
minz = (max(z)+min(z))/2-dz;
mid = (maxz-minz)/2;
m = 1/mid;
cVec = zeros(size(z,1),3);

for i=1:size(z)
    
    if((z(i)-minz)<mid)
        r = 0;
        g = round(10*((z(i)-minz)*m))/10;
        b = round(10*(1-(z(i)-minz)*(m)))/10;
    else
        b = 0;
        g = round(10*(1-abs((z(i)-minz-mid)*m)))/10;
        r = round(10*((z(i)-minz)*m-1))/10;
    end
    
    cVec(i,:) = [r;g;b];
end

scatter(x,y,s,cVec,'fill');

if(axis)
    plot(linspace(max(x),min(x),1000),0);
    plot(0,linspace(max(y),min(y),1000));
end

hold off;

hout = h;

end