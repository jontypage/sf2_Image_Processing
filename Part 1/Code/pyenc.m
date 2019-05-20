function [X1, Y] = pyenc(X, h)
X1 = rowdec(rowdec(X, h)', h)';
Y = X - rowint(rowint(X1, 2*h)', 2*h)';
return