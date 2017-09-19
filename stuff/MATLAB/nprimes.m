function p = nprimes(n)
%primes but with a certain number of primes
tic
i=3;
p=[];
p=primes(2*n);
while(length(p)<n)
   p=primes(n*i);
   i=i+1;
end
p=p(1:n);
t1=toc;
tic
primes(n);
t2=toc;
fprintf('time difference is %f\n',t1-t2);
a = input('stuff');
printf('%s\n',a);