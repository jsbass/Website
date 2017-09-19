function F = comp_interest(P, i, n)
% comp_interest: compound interest of and account
%
% F = comp_interest(P, i, n):   Computes the future worth, F, yielded at
%                               interest rate, i, yielded after n periods
%                               given that the intitial investment was P
%                               amount
% 
% input:
%   P = initial investment
%   i = interest rate
%   n = number of compund periods
%
% outputs:
%   F = future worth of the account
%

%Idiotproofing for input values
switch nargin
    case 0
        error('No inputs - 3 inputs needed');
    case 1
        error('1 input - 3 inputs needed');
    case 2
        error('2 inputs - 3 inputs needed');
end

fprintf('Initial Investment = %10.2f\n',P);
fprintf('Interest Rate = %1.5f\n',i);
fprintf('Number of Compund Periods = %5.0f\n',n);

    fprintf('    n         f\n');
for count=0:n
    fprintf('  %3.0f    %10.2f \n',count,F_calc(P,i,count));
end

return

function F = F_calc(P,i,n)
F=P*(1+i)^n;
return
