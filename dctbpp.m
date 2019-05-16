function bits = dctbpp(Yr, N)
bits = 0;
for i = 1:N
    for j = 1:N
        bits_per_pixel = bpp(Yr(((j-1)*(256/N))+1:(j)*(256/N), ((i-1)*(256/N))+1:(i)*(256/N)));
        bits = bits + bits_per_pixel*((256/N)^2);
    end
end
return