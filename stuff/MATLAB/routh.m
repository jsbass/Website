function [T,RHP,LHP,jw] = routh(pol)
    l = length(pol);
    syms e;
    T=sym(zeros(l,ceil(l/2)));
    T(1,:) = pol(1:2:end);
    T(1,:)=T(1,:)/arrayGCD(T(1,:));
    if(mod(l,2)==0)
        T(2,:) = pol(2:2:end);
        T(2,:)=T(2,:)/arrayGCD(T(2,:));
    else
        T(2,:) = [pol(2:2:end),0];
        T(2,:)=T(2,:)/arrayGCD(T(2,:));
    end
    for i=3:1:l
       for j=1:1:ceil(l/2)-1
           T(i,j)=-det(...
               [T(i-2,1),T(i-2,j+1);T(i-1,1),T(i-1,j+1)])/T(i-1,1);
       end
       if(isequal(T(i,:),sym(zeros(1,ceil(l/2)))))
           fprintf('Replacing line %d (all zeros)\n',i);
           for j=1:1:ceil(l/2)
               T(i,j)=T(i-1,j)*((l-(i-1))-(j-1)*2);
           end
       end
       if(T(i,1)==0)
           T(i,1)=e;
       end
       try
           T(i,:)=T(i,:)/arrayGCD(T(i,:));
       catch err
           
       end
    end
    for i=1:l
        fprintf('| s^%2d',l-i);
        for j=1:ceil(l/2)
            fprintf(' | %10.10s',char(T(i,j)));
        end
        fprintf(' |\n');
    end
end

function nGCD = arrayGCD(A)
    if(sum(A)==A(1))
        nGCD=1;
        return
    end
    nGCD = A(1);
    for k = 2:length(A)
        nGCD = gcd(nGCD,A(k));
    end
end