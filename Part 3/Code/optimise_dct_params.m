function [opt_step, N, opt_dcbits, all_params] = optimise_dct_params(X)
Xq = quantise(X, 17);
rms_diff_opt = 100000000;
possible_dims = [8, 16, 32];
all_params = [];
for i = 1:length(possible_dims)
    step = 20;
    dcbits = 8;
    dcbits_not_okay = true;
    while dcbits_not_okay
        try
            vlc = jpegenc(X, step, possible_dims(i), possible_dims(i), false, dcbits);
            dcbits_not_okay = false;
        catch
            dcbits = dcbits + 1;
        end
    end
    vlc = jpegenc(X, step, possible_dims(i), possible_dims(i), false, dcbits);
    bits = sum(vlc(:,2));
    disp(bits)
    while bits > 40960
        step = step + 0.01;
        vlc = jpegenc(X, step, possible_dims(i), possible_dims(i), false, dcbits);
        bits = sum(vlc(:,2));
        disp(step)
        disp(bits)
    end
    [vlc, ~, ~] = jpegenc(X, step, possible_dims(i), possible_dims(i), false, dcbits);
    X_dec = jpegdec(vlc, step, possible_dims(i), possible_dims(i), false, dcbits);
    figure(i)
    draw(X_dec)
    rms_diff = abs(std(X(:)- X_dec(:)) - std(X(:)- Xq(:)));
    all_params = [all_params, [possible_dims(i), step, rms_diff]];
    disp(rms_diff)
    if rms_diff < rms_diff_opt
        rms_diff_opt = rms_diff;
        opt_step = step;
        N = possible_dims(i);
        opt_dcbits = dcbits;
    end
end
return