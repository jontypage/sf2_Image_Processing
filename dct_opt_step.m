function opt = dct_opt_step(X, step, N)
Xq = quantise(X, step);
opt = step;
C = dct_ii(N);
Y = colxfm(colxfm(X,C)',C)';
Yq = quantise(Y, opt);
Zq = colxfm(colxfm(Yq',C')',C');
while abs(std(X(:)- Zq(:)) - std(X(:)- Xq(:))) > 0.1
    opt = opt + 0.1;
    Y = colxfm(colxfm(X,C)',C)';
    Yq = quantise(Y, opt);
    Zq = colxfm(colxfm(Yq',C')',C');
end
return