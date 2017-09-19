function [h,cVec] = colorScatter3(x,y,z,s,axis,dz)
% plots 3d data as a 3d scatter plot with the 3rd dimension represented
% by color
%
% input:
%     x = x data
%     y = y data
%     z = z data
%     s = size of points
%     dz = change from average that results in the most
%          extreme color (red/blue). Values outside this
%          range won't appear
%
% ouput:
%     h = plot handle
%     cVec = RGB color vector of points
%

if(nargin<3)
    error('must provide x, y, and z data');
elseif(nargin==3)
    s = 10;
    fprintf('defaulting to a calculated dz');
    axis=true;
    dz = (max(z)-min(z))/2;
elseif(nargin==4)
    dz = (max(z)-min(z))/2;
    axis=true;
elseif(nargin<=5)
    dz = (max(z)-min(z))/2;
end

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

h = scatter3(x,y,z,s,cVec,'fill');

if(axis)
    hold on;
    plot3(linspace(max(x),min(x),1000),0,0);
    plot3(0,linspace(max(y),min(y),1000),0);
    plot3(0,0,linspace(max(z),min(z),1000));
    hold off;
end

end