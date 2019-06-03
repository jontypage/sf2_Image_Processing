function [vlc, bits_vector, huffval, all_params] = optimise_lbt_params(X)
ssim_value_opt = 0;
possible_dims = [8, 16];
possible_m = [8, 16];
all_params = [];
for i = 1:length(possible_dims)
    for m = 1:length(possible_m)
        for j = 1:14
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
                        [vlc, bits_vector, huffval] = jpegenc_lbt(X, step, possible_dims(i), possible_m(m), s, true, dcbits);
                        dcbits_not_okay = false;
                    catch
                        dcbits = dcbits + 1;
                    end
                end
                bits = sum(vlc(:,2));
                disp(step)
                disp(bits)
            end
            while bits > 40500
                step = step + 0.1;
                dcbits = 8;
                dcbits_not_okay = true;
                while dcbits_not_okay
                    try
                        disp(dcbits)
                        [vlc, bits_vector, huffval] = jpegenc_lbt(X, step, possible_dims(i), possible_m(m), s, true, dcbits);
                        dcbits_not_okay = false;
                    catch
                        dcbits = dcbits + 1;
                    end
                end
                bits = sum(vlc(:,2));
                disp(step)
                disp(bits)
            end
            while bits > 39516
                step = step + 0.01;
                dcbits = 8;
                dcbits_not_okay = true;
                while dcbits_not_okay
                    try
                        [vlc, bits_vector, huffval] = jpegenc_lbt(X, step, possible_dims(i), possible_m(m), s, true, dcbits);
                        dcbits_not_okay = false;
                    catch
                        dcbits = dcbits + 1;
                    end
                end
                bits = sum(vlc(:,2));
                disp(step)
                disp(bits)
            end
            [vlc, bits_vector, huffval] = jpegenc_lbt(X, step, possible_dims(i), possible_m(m), s, true, dcbits);
            X_dec = jpegdec_lbt(vlc, step, possible_dims(i), possible_m(m), s, dcbits, bits_vector, huffval);
            ssim_value = ssim(X, X_dec);
            all_params = [all_params; [possible_dims(i), step, dcbits, s, possible_m(m), ssim_value]];
            disp(ssim_value)
            if ssim_value > ssim_value_opt
                ssim_value_opt = ssim_value;
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
all_params = [all_params; [N, opt_step, dcbits, opt_s, M, ssim_value_opt]];
[vlc, bits_vector, huffval] = jpegenc_lbt(X, opt_step, N, M, opt_s, true, opt_dcbits);
return