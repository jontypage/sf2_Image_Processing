function Z0 = nlevelquantisedpyramidmse(X, levels, h, step_set)
Y = {};
for i = 1:levels
    [X, Yx] = pyenc(X, h);
    Y{1, i} = Yx;
end
Xq = quantise(X, step_set(end));
Yq = {};
for i = 1:levels
    Yq{1, i} = quantise(Y{1, i}, step_set(i));
end
Z = {pydec(Yq{1, levels}, Xq, h)};
for i = 1:(levels-1)
    Z{1, i+1} = pydec(Yq{1, levels-i}, Z{1, i}, h);
end
Z0 = Z{1,levels};
return