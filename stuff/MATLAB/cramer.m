function [num,den,sys,cf_hertz] = cramer(A,I_n,RL,plots)
% Uses Cramer's rule to find the current across one path
% of the form:  [A]*[I1;I2;...;In]=[I]                   
% A =   function of impedance matrix:@(s)where s is the laplace transform
%       variable
% I_n = number of the current loop that the load is in
% RL = the resistance of the load
% plots = boolean value on whether or not to plot the system
%         (default=false)
switch nargin
    case 0
        error('No inputs detected. At least 3 inputs needed');
    case 1
        error('1 input detected. At least 3 inputs needed');
    case 2
        error('2 inputs detected. At least 3 inputs needed');
    case 3
        plots=false;
        fprintf('No input for plots, defaulting to false\n');
end
syms s
I=zeros(length(A(s)),1);
I(1)=1;
Asym=A(s);
Asym(:,I_n)=I;
num_sym=det(Asym);
den_sym=det(A(s));
while (1)
    try
        den=sym2poly(den_sym);
        num=sym2poly(num_sym);
    catch err
        den_sym=den_sym*s;
        num_sym=num_sym*s;
        continue
    end
    break
end
num=num*RL;
sys=tf(num,den);
cf_hertz = abs(roots(den))/(2*pi);
if plots
    figure(1)
    bode(sys)
    figure(2)
    subplot(3,1,1),pzmap(sys)
    subplot(3,1,2),impulse(sys)
    subplot(3,1,3),step(sys)
end
end

