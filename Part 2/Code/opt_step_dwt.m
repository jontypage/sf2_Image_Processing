function opt = opt_step_dwt(X, N, step)
Xq = quantise(X, step);
opt = 5;
Y = nleveldwt(X, N);
[Yq, ~] = quantdwt(Y, N, opt);
Zq = nlevelidwt(Yq, N);
while abs(std(X(:)- Zq(:)) - std(X(:)- Xq(:))) > 0.001
    opt = opt + 0.001;
    Y = nleveldwt(X, N);
    [Yq, ~] = quantdwt(Y, N, opt);
    Zq = nlevelidwt(Yq, N);
    disp(abs(std(X(:)- Zq(:)) - std(X(:)- Xq(:))))
end
return