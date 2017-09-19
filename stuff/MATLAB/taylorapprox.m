function approx = taylorapprox(f,x,h,max_order)

switch nargin
    case 0
        error('Please input a function');
    case 1
        h = .1;
        fprintf('h has been defaulted to %f\n',h);
        max_order = 5;
        fprintf('max_order has been defaulted to %d\n',max_order);
    case 2
        max_order = 5;
        fprintf('max_order has been defaulted to %d\n',max_order);
end

if mod(max_order,1)~=0
    error('orders must be integers')
end

terms = ones(max_order+1,1);
Der_Arr{1} = f;
terms(1) = f(x-h);
sum = f(x-h);
fprintf('n      derivative          term         sum        error\n');
    
for i=1:max_order
    Der_Arr{i+1} = matlabFunction(diff(sym(Der_Arr{i})));
    terms(i+1) = Der_Arr{i+1}(x-h)*h/factorial(i);
    sum = sum + terms(i+1);
    err = (log(2)-sum)/log(2);
    fprintf('%3d  %15s      ',i,prod_func(Der_Arr{i+1}));
    fprintf('%7.3f   %10.3f      %5.4f\n', terms(i+1), sum, err);
end

function func = prod_func(f)

str = func2str(f);
id = strfind(str,')');
func = str(id(1)+1:numel(str));
return
