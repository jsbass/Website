function V = tank_volume(R, d)
% tank_volume: volume of cylindrical tank with conical base
% V = tank_volume(r,d)  determines the volume, at any height, d, of a 
%                       cylindrical tank with radius, R and height, 2R,
%                       that has a conical base with radius and height R. 
%
% input:
%   R = radius of tank
%   d = height of liquid in tank whose volume is to be determined
%
% output:
%   V = volume of liquid in tank

%IdiotProofing for input variables
switch nargin
    case 0
        error('No input-Please specify a radius and liquid height');
    case 1
        error('Only one input-Please specify a radius and liquid height');
end

fprintf('R = %f\n',R);
fprintf('d = %f\n',d);

%Idiotproofing to make sure liquid height does not exceed tank height
if d > (3*R)
    error('liquid height cannot be more than the tank height (3*radius)');
end

if d > R
    V = pi*(R^3)/3 + (d-R)*pi*(R^2);
else
    V = d*pi*(R^2)/3;
end
