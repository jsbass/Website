function [t_table,eq_table] = truth(eq,n,varargin)

% truth | generates truth tables for the input compound statements
%
% input:
%    eq =       boolean for whether to determine eqaulity between two
%               compound statements
%    n =        number of variable statements in the compound statements
%               see below
%    varargin = all of the anonymous functions containing the compound
%               statements ie: A=@(a,b,c)(a&b)|c
%               Here there are three variable statements
%               All of the functions should have the same number of
%               variable statements and they should be ordered the same on
%               the function ie: A=@(a,b,c) a&b|c and B=@(a,b,c) not
%               B=@(b,c,a)
%               Only use & (and),| (or), ~ (not),and == (equals)
%               A->B should be of the form ~A|B
%               A<->B should be A==B
% output:
%     table =   A ((2^n)+1)x(n+length(varargin)) matrix containing the
%               a column header on the first row and the truth values in
%               the subsequent rows for each column for each input variable
%               and the consequent truth value for each compound statement
%     eq =      A (!length(varargin)+1)x(1+length(varargin)) matrix that
%               contains a column header in the first row and a combination
%               of each of the compound statements in the first two columns
%               for subsequent rows. The third column has the truth values
%               for the first two columns equivalency
%

nfunc = length(varargin);
t_table = [];
eq_table = [];
for x=1:nfunc
    if nargin(varargin{x})~=n
        error('Every function must have n number of arguments');
    end
end

end

