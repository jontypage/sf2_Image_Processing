function opt = opt_step_mse_dwt(X, N, step)
ratios = finddwtmsematrix(N);
Xq = quantise(X, step);
opt = 5;
opt_matrix = opt*ratios;
Y = nleveldwt(X, N);
[Yq, ~] = quantdwt_matrix(Y, N, opt_matrix);
Zq = nlevelidwt(Yq, N);
while abs(std(X(:)- Zq(:)) - std(X(:)- Xq(:))) > 0.001
    opt = opt + 0.001;
    opt_matrix = opt*ratios;
    Y = nleveldwt(X, N);
    [Yq, ~] = quantdwt_matrix(Y, N, opt_matrix);
    Zq = nlevelidwt(Yq, N);
    disp(abs(std(X(:)- Zq(:)) - std(X(:)- Xq(:))))
end
return