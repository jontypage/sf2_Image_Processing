function [vlc, all_params] = optimise_lbt_params_ssim(X)
rms_error_opt = 100000000;
possible_dims = [8, 16];
possible_m = [8, 16];
all_params = [];
for i = 1:length(possible_dims)
    for m = 1:length(possible_m)
        for j = 1:10
            s = 1.15 + ((j-1)/20);
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
                        vlc = jpegenc_lbt(X, step, possible_dims(i), possible_m(m), s, false, dcbits);
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
                        vlc = jpegenc_lbt(X, step, possible_dims(i), possible_m(m), s, false, dcbits);
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
                        vlc = jpegenc_lbt(X, step, possible_dims(i), possible_m(m), s, false, dcbits);
                        dcbits_not_okay = false;
                    catch
                        dcbits = dcbits + 1;
                    end
                end
                bits = sum(vlc(:,2));
                disp(step)
                disp(bits)
            end
            vlc = jpegenc_lbt(X, step, possible_dims(i), possible_m(m), s, false, dcbits);
            X_dec = jpegdec_lbt(vlc, step, possible_dims(i), possible_m(m), s, dcbits);
            rms_error = ssim(X_dec, X);
            %rms_error = std(X(:)- X_dec(:));
            all_params = [all_params; [possible_dims(i), step, dcbits, s, possible_m(m), rms_error]];
            disp(rms_error)
            if rms_error < rms_error_opt
                rms_error_opt = rms_error;
                opt_step = step;
                N = possible_dims(i);
                M = possible_m(m);
                opt_dcbits = dcbits;
                opt_s = s;
                figure(i)
                draw(X_dec);
            end
        end
    end
end
vlc = jpegenc_lbt(X, opt_step, N, M, opt_s, false, opt_dcbits);
return