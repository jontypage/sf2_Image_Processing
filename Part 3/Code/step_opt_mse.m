function step_opt = step_opt_mse(X, h, layers, step)
mse_ratios = findmseratios(layers+1, h);
step_set = [step];
for i = 1:(layers)
    step_set = [step_set, step_set(end)*mse_ratios(i)];
end
Xq = quantise(X, 17);
Z0q = nlevelquantisedpyramidmse(X, layers, h, step_set);
optimal = abs(std(X(:) - Z0q(:)) - std(X(:) - Xq(:)));
opt_step = step_set;
for i = 1:1000
    step = step + 0.01;
    step = step + 0.01;
    step_set = [step];
    for i = 1:(layers)
        step_set = [step_set, step_set(end)*mse_ratios(i)];
    end
    Z0q = nlevelquantisedpyramidmse(X, layers, h, step_set);
    if abs(std(X(:) - Z0q(:)) - std(X(:) - Xq(:)))<optimal
        optimal= abs(std(X(:) - Z0q(:)) - std(X(:) - Xq(:)));
        opt_step = step_set;
    end
end

step_opt = opt_step;

return