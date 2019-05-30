function ratios = findmseratios(levels, h)
X = zeros(256, 256);
Y = {};
for i = 1:levels
    [X, Yx] = pyenc(X, h);
    Y{1, i} = Yx;
end
Y_orig = Y;
E = [];
for i = 1:levels
    Y = Y_orig;
    [m, ~] = size(Y{1, i});
    Y{1, i}(m/2, m/2) = 100;    
    Z = {pydec(Y{1, levels}, X, h)};
    for k = 1:(levels-1)
        Z{1, k+1} = pydec(Y{1, levels-k}, Z{1, k}, h);
    end
    Z0 = Z{1,levels};
    E = [E, sum(Z0(:).^2)];
end
ratios = [];
for i = 1:(levels-1)
    ratios = [ratios, sqrt(E(i)/E(i+1))];
end
return 