function grade = lettergrade(score)
%lettergrade: turn numerical grade to letter grade
% grade = lettergrade(score):   changes the input score that is between 100
%                               and 0 then changes it to a letter grade
% input:
%   score = numerical score
% output:
%   grade = letter grade

switch nargin
    case 0
        error('No score input');
end

if score>100 | score<0
    error('Score must be between 0 and 100');
end

if score>=90 & score<=100
    grade = 'A';
elseif score>=80
    grade = 'B';
elseif score>=70
    grade = 'C';
elseif score>=60
    grade = 'D';
else
    grade = 'F';
end

fprintf('A %f is an %s\n',score,grade);