function opt = lbt_opt_step(X, step, N, s)
Xq = quantise(X, step);
opt = 20;
Zq = lbt(X, N, s, step);
while abs(std(X(:)- Zq(:)) - std(X(:)- Xq(:))) > 0.001
    opt = opt + 0.001;
    Zq = lbt(X, N, s, opt);
    disp(abs(std(X(:)- Zq(:)) - std(X(:)- Xq(:))))
end
return