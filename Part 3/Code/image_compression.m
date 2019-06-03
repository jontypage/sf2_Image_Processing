function [vlc, all_params] = image_compression(X)
N = 8;
M = 8;
all_params = [];
bits = 45001;
step = 0;
while bits > 45000
    step = step + 0.1;
    dcbits = 8;
    dcbits_not_okay = true;
    while dcbits_not_okay
        try
            disp(dcbits)
            vlc = jpegenc_dct_v2(X, step, N, M, false, dcbits);
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
            disp(dcbits)
            vlc = jpegenc_dct_v2(X, step, N, M, false, dcbits);
            dcbits_not_okay = false;
        catch
            dcbits = dcbits + 1;
        end
    end
    bits = sum(vlc(:,2));
    disp(step)
    disp(bits)
end
vlc = jpegenc_dct_v2(X, step, N, M, false, dcbits);
X_dec = jpegdec_dct_v2(vlc, step, N, M, dcbits);
rms_error = std(X(:)- X_dec(:));
all_params = [all_params; [N, step, dcbits, M, rms_error]];
figure(1)
draw(X_dec);
return