function [vlc, all_params] = optimise_lbt_params(X)
Xq = quantise(X, 17);
rms_diff_opt = 100000000;
possible_dims = [4, 8, 16];
all_params = [];
for i = 1:length(possible_dims)
    for j = 1:21
        s = 1 + ((j-1)/20);
        disp(s)
        bits = 45001;
        step = 0;
        while bits > 45000
            step = step + 1;
            dcbits = 8;
            dcbits_not_okay = true;
            while dcbits_not_okay
                try
                    disp(dcbits)
                    vlc = jpegenc_lbt(X, step, possible_dims(i), s, false, dcbits);
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
                    disp(dcbits)
                    vlc = jpegenc_lbt(X, step, possible_dims(i), s, false, dcbits);
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
                    vlc = jpegenc_lbt(X, step, possible_dims(i), s, false, dcbits);
                    dcbits_not_okay = false;
                catch
                    dcbits = dcbits + 1;
                end
            end
            bits = sum(vlc(:,2));
            disp(step)
            disp(bits)
        end
        vlc = jpegenc_lbt(X, step, possible_dims(i), s, false, dcbits);
        X_dec = jpegdec_lbt(vlc, step, possible_dims(i), s, dcbits);
        rms_diff = abs(std(X(:)- X_dec(:)) - std(X(:)- Xq(:)));
        all_params = [all_params; [possible_dims(i), step, dcbits, s, rms_diff]];
        disp(rms_diff)
        if rms_diff < rms_diff_opt
            rms_diff_opt = rms_diff;
            opt_step = step;
            N = possible_dims(i);
            opt_dcbits = dcbits;
            opt_s = s;
            figure(i)
            draw(X_dec);
        end
    end
end
vlc = jpegenc_lbt(X, opt_step, N, opt_s, false, opt_dcbits);
return