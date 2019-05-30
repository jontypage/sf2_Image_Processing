function bits = ent_to_bits(dwtent, N, m)
bits = 0;
for i = 1:N
    m = m/2;
    bits = bits + sum(dwtent(:, i))*m*m;
end
bits = bits + sum(dwtent(:, N+1))*m*m;
return