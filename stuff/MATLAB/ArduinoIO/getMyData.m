function [v,r,d,temp] = getMyData(a,pin,vSource)
    res = 1024;
    r1 = 10000;
    r25 = 10000;
    A1=3.354016e-3;
    B1=2.569850e-4;
    C1=2.620131e-6;
    D1=6.383091e-8;
    d = a.analogRead(pin);
    v = vSource*d/(res-1);
    r = r1*v/(vSource-v);
    temp = (A1+B1*log(r/r25)+C1*log(r/r25)^2+D1*log(r/r25)^3)^(-1);
    temp = (temp-273)*9/5+32;
end