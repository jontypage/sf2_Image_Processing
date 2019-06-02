function [vlc, all_params] = image_compression(X)
rms_error_opt = 100000000;
N = 8;
M = 8;
all_params = [];
for j = 1:10
    s = 1.15 + ((j-1)/20);
    bits = 45001;
    step = 0;
    while bits > 40960
        step = step + 0.01;
        dcbits = 8;
        dcbits_not_okay = true;
        while dcbits_not_okay
            try
                disp(dcbits)
                vlc = jpegenc_lbt_v2(X, step, N, M, s, false, dcbits);
                dcbits_not_okay = false;
            catch
                dcbits = dcbits + 1;
            end
        end
        bits = sum(vlc(:,2));
        disp(step)
        disp(bits)
    end
    vlc = jpegenc_lbt_v2(X, step, N, M, s, false, dcbits);
    X_dec = jpegdec_lbt_v2(vlc, step, N, M, s, dcbits);
    rms_error = std(X(:)- X_dec(:));
    all_params = [all_params; [N, step, dcbits, s, M, rms_error]];
    if rms_error < rms_error_opt
        rms_error_opt = rms_error;
        opt_step = step;
        opt_dcbits = dcbits;
        opt_s = s;
        figure(1)
        draw(X_dec);
    end
end
vlc = jpegenc_lbt_v2(X, opt_step, N, M, opt_s, false, opt_dcbits);
return