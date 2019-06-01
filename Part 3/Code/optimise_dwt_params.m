function [vlc, all_params] = optimise_dwt_params(X)
Xq = quantise(X, 17);
rms_diff_opt = 100000000;
possible_levels = [3, 4, 5, 6, 7];
all_params = [];
for i = 1:length(possible_levels)
    bits = 45001;
    step = 0;
    while bits > 45000
        step = step + 1;
        dcbits = 8;
        dcbits_not_okay = true;
        while dcbits_not_okay
            try
                vlc = jpegenc_dwt(X, step, possible_levels(i), false, dcbits);
                dcbits_not_okay = false;
            catch
                dcbits = dcbits + 1;
            end
        end
        bits = sum(vlc(:,2));
        disp(step)
        disp(bits)
    end
    while bits > 41500
        step = step + 0.1;
        dcbits = 8;
        dcbits_not_okay = true;
        while dcbits_not_okay
            try
                vlc = jpegenc_dwt(X, step, possible_levels(i), false, dcbits);
                dcbits_not_okay = false;
            catch
                dcbits = dcbits + 1;
            end
        end
        bits = sum(vlc(:,2));
        disp(step)
        disp(bits)
    end
    while bits > 40960
        step = step + 0.01;
        dcbits = 8;
        dcbits_not_okay = true;
        while dcbits_not_okay
            try
                vlc = jpegenc_dwt(X, step, possible_levels(i), false, dcbits);
                dcbits_not_okay = false;
            catch
                dcbits = dcbits + 1;
            end
        end
        bits = sum(vlc(:,2));
        disp(step)
        disp(bits)
    end
    vlc = jpegenc_dwt(X, step, possible_levels(i), false, dcbits);
    X_dec = jpegdec_dwt(vlc, step, possible_levels(i), dcbits);
    rms_diff = abs(std(X(:)- X_dec(:)) - std(X(:)- Xq(:)));
    all_params = [all_params; [possible_levels(i), step, dcbits, rms_diff]];
    disp(rms_diff)
    if rms_diff < rms_diff_opt
        rms_diff_opt = rms_diff;
        opt_step = step;
        N = possible_levels(i);
        opt_dcbits = dcbits;
        figure(i)
        draw(X_dec);
    end
end
vlc = jpegenc_dwt(X, opt_step, N, false, opt_dcbits);
return