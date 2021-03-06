function [opt, bits] = depth_opt(X, h)
X_orig = X;
[m, ~] = size(X);
for j = 1:(log2(m)-1)
    Y = {};
    X = X_orig;
    opt_step = step_opt(X, h, j, 17);
    for i = 1:j
        [X, Yx] = pyenc(X, h);
        Y{1, i} = Yx;
    end
    Xq = quantise(X, opt_step);
    Yq = {};
    for i = 1:j
        Yq{1, i} = quantise(Y{1, i}, opt_step);
    end
    [a, ~] = size(Xq);
    sum = bpp(Xq)*(a^2);
    for i = 1:j
        [a, ~] = size(Yq{1, i});
        sum = sum + bpp(Yq{1, i})*(a^2);
    end
    disp(sum)
    if j == 1
        bits = sum;
        opt = 1;
    end
    if sum < bits
        bits = sum;
        opt = j;
    end
end
return     