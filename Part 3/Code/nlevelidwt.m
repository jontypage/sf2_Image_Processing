function Z = nlevelidwt(Y, N)
[m, ~] = size(Y);
m = m/(2^(N-1));
t=1:m; 
Y(t,t)=idwt(Y(t,t));
for i = 1:(N-1)
    m = 2*m;
    t=1:m;
    Y(t,t)=idwt(Y(t,t));
end
Z = Y;
return