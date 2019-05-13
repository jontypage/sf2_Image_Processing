function step_opt = step_opt(X4, Y3, Y2, Y1, Y0, X, h, step)
Xq = quantise(X, step);
X4q = quantise(X4, step);
Y3q = quantise(Y3, step);
Y2q = quantise(Y2, step);
Y1q = quantise(Y1, step);
Y0q = quantise(Y0, step);
[~, ~, ~, Z0q] = py4dec(X4q, Y3q, Y2q, Y1q, Y0q, h);
while std(X(:) - Z0q(:)) - std(X(:) - Xq(:)) > 0.01
    step = step - 0.01;
    disp(std(X(:) - Z0q(:)) - std(X(:) - Xq(:)))
    X4q = quantise(X4, step);
    Y3q = quantise(Y3, step);
    Y2q = quantise(Y2, step);
    Y1q = quantise(Y1, step);
    Y0q = quantise(Y0, step);
    [~, ~, ~, Z0q] = py4dec(X4q, Y3q, Y2q, Y1q, Y0q, h);
end
step_opt = step;
return