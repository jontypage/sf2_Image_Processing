function [X4, Y3, Y2, Y1, Y0] = py4enc(X, h)
X1 = rowdec(rowdec(X, h)', h)';
Y0 = X - rowint(rowint(X1, 2*h)', 2*h)';
X2 = rowdec(rowdec(X1, h)', h)';
Y1 = X1 - rowint(rowint(X2, 2*h)', 2*h)';
draw(Y1);
X3 = rowdec(rowdec(X2, h)', h)';
Y2 = X2 - rowint(rowint(X3, 2*h)', 2*h)';
X4 = rowdec(rowdec(X3, h)', h)';
Y3 = X3 - rowint(rowint(X4, 2*h)', 2*h)';
draw(beside(Y0,beside(Y1,beside(Y2,beside(Y3,X4)))));
return