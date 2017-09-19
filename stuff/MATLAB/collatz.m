function [last_n,array] = collatz(n,max_iter)
array = n;
i=1;
while(i<max_iter)
    if(mod(n,2)==0)
        n=n/2;
    else
        n=n*3+1;
    end
    if(ismember(n,array))
        array = [array;n];
        last_n = n;
        break;
    else
        array = [array;n];
    end
    i=i+1;
end
end