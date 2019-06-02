function [vlc, all_params] = optimise_dct_params(X)
rms_error_opt = 100000000;
possible_dims = [8, 16, 32];
all_params = [];
for i = 1:length(possible_dims)
    bits = 45001;
    step = 0;
    while bits > 45000
        step = step + 1;
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
                vlc = jpegenc(X, step, possible_dims(i), possible_dims(i), false, dcbits);
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
                vlc = jpegenc(X, step, possible_dims(i), possible_dims(i), false, dcbits);
                dcbits_not_okay = false;
            catch
                dcbits = dcbits + 1;
            end
        end
        bits = sum(vlc(:,2));
        disp(step)
        disp(bits)
    end
    vlc = jpegenc(X, step, possible_dims(i), possible_dims(i), false, dcbits);
    X_dec = jpegdec(vlc, step, possible_dims(i), possible_dims(i), dcbits);
    figure(i)
    draw(X_dec)
    rms_error = std(X(:)- X_dec(:));
    all_params = [all_params; [possible_dims(i), step, dcbits, rms_error]];
    disp(rms_error)
    if rms_error < rms_error_opt
        rms_error_opt = rms_error;
        opt_step = step;
        N = possible_dims(i);
        opt_dcbits = dcbits;
    end
end
vlc = jpegenc(X, opt_step, N, N, false, opt_dcbits);
return