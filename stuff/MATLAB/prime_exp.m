function [cust,list,diff] = prime_exp(N)
% takes the difference of sequentional primes and runs tests on them

plist = primes(10000);
list=plist(1:N);
diff=ones(1,N-1);
cust=ones(1,N-1);

for i=2:N
   diff(i-1)=plist(i)-plist(i-1);
   cust(i-1)=mod(plist(i),plist(i-1));
end