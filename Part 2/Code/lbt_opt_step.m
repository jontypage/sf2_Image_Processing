function opt = lbt_opt_step(X, step, N, s)
Xq = quantise(X, step);
<<<<<<< HEAD
opt = 17;
=======
opt = 20;
>>>>>>> 89010d47ae9e4589b9746823f8a75e385723cfe0
Zq = lbt(X, N, s, step);
while abs(std(X(:)- Zq(:)) - std(X(:)- Xq(:))) > 0.01
    opt = opt + 0.01;
    Zq = lbt(X, N, s, opt);
    disp(abs(std(X(:)- Zq(:)) - std(X(:)- Xq(:))))
end
return