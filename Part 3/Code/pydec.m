function Z = pydec(Y, X, h)
Z = Y + rowint(rowint(X, 2*h)', 2*h)';
return