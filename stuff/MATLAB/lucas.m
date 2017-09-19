function [arr] = lucas(n)
% outputs the numbers in the lucas series up to the nth element

arr = zeros(1,n);
arr(1)=1;
arr(2)=3;
for i=3:n
    arr(i)=arr(i-1)+arr(i-2);
end

end