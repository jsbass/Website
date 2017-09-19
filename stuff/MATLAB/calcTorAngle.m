function [angle] = calcTorAngle(t,l,g,j,n)

if(nargin~=5)
    error('wierd number of args');
end

angle=0;
for i=1:n
    angle=angle+(t(i)*l(i))/(g(i)*j(i));
end

end