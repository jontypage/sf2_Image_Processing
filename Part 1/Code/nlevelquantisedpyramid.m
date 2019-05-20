function Z0 = nlevelquantisedpyramid(X, levels, h, step_size)
Y = {};
for i = 1:levels
    [X, Yx] = pyenc(X, h);
    Y{1, i} = Yx;
end
Xq = quantise(X, step_size);
Yq = {};
for i = 1:levels
    Yq{1, i} = quantise(Y{1, i}, step_size);
end
Z = {pydec(Yq{1, levels}, Xq, h)};
for i = 1:(levels-1)
    Z{1, i+1} = pydec(Yq{1, levels-i}, Z{1, i}, h);
end
Z0 = Z{1,levels};
return