function step_opt = step_opt(X, h, layers, step)
Xq = quantise(X, step);
Z0q = nlevelquantisedpyramid(X, layers, h, step);
while std(X(:) - Z0q(:)) - std(X(:) - Xq(:)) > 0.01
    step = step - 0.1;
    Z0q = nlevelquantisedpyramid(X, layers, h, step);
end
step_opt = step;
return