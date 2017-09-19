%Example

M1 = 1;
M2 = 1;
M3 = 1;

D1 = 2;
D2 = 2;
D3 = 2;

K1 = 2;

F = 1;

syms s
X1 = [(M1*s^2+(D1+D2)*s+K1) -(D2*s) 0];
X2 = [-(D2*s) (M2*s^2+(D2+D3)*s) -(D3*s)];
X3 = [0 -(D3*s) (M3*s^2+D3*s)];
A = [X1; X2; X3];
    
C = [0; 0; 1];

%X1
num = [C A(:,2:3)]
num1_sym = det(num);
%Characteristic equation
den1_sym = det(A);
num1 = sym2poly(num1_sym);
den1 = sym2poly(den1_sym);

R = roots(den1)

% Or create transfer function
sys1 = tf(num1,den1)
% Find poles,zeros,residue
[r1,p1,k1] = residue(num1,den1)

%X2
num = [A(:,1) C A(:,3)]
num2_sym = det(num);
%Characteristic equation (denominator) is the same as from X1 above det(A)
den2_sym = den1_sym;
num2 = sym2poly(num2_sym);
den2 = sym2poly(den2_sym);
sys2 = tf(num2,den2);
[r2,p2,k2] = residue(num2,den2);

