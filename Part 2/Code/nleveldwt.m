function Y = nleveldwt(X, N)
[m, ~] = size(X);
Y = dwt(X);
for i = 1:(N-1)
    m=m/2;
    t=1:m;
    Y(t,t)=dwt(Y(t,t));
end
return