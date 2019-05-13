function [Z3, Z2, Z1, Z0] = py4dec(X4, Y3, Y2, Y1, Y0, h)
Z3 = Y3 + rowint(rowint(X4, 2*h)', 2*h)';
Z2 = Y2 + rowint(rowint(Z3, 2*h)', 2*h)';
Z1 = Y1 + rowint(rowint(Z2, 2*h)', 2*h)';
Z0 = Y0 + rowint(rowint(Z1, 2*h)', 2*h)';
draw(beside(Z0,beside(Z1,beside(Z2,Z3))))
return