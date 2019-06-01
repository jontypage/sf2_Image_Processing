function [Yq, dwtent] = quantdwt_matrix(Y, N, dwtstep)
dwtent = zeros(3, N+1);
[m, ~] = size(Y);
for level = 1:N
    m = m/2;
    t=1:m;
    Y(t,m+t)=quantise(Y(t,m+t), dwtstep(1, level));
    dwtent(1, level) = bpp(Y(t,m+t));
    Y(m+t,t)=quantise(Y(m+t,t), dwtstep(2, level));
    dwtent(2, level) = bpp(Y(m+t,t));
    Y(m+t,m+t)=quantise(Y(m+t,m+t), dwtstep(3, level));
    dwtent(3, level) = bpp(Y(m+t,m+t));
end
Y(t, t) = quantise(Y(t, t), dwtstep(1, N+1));
dwtent(1, N+1) = bpp(Y(t, t));
Yq = Y;
return