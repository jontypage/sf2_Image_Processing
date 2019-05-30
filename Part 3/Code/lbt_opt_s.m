function opt = lbt_opt_s(X, step, N)
s = 1;
for i = 1:10
    steps = lbt_opt_step(X, step, N, s);
    Yq = lbt_f(X, N, s, steps);
    Yr = regroup(Yq,N)/N;
    bits = dctbpp(Yr, N);
    if i == 1
        opt = s;
        opt_bits = bits;
    else
        if bits < opt_bits
            opt = s;
            opt_bits = bits;
        end
    end
    s = s + 0.1;
    disp(s)
    disp(opt_bits)
end
return