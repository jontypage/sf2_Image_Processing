function matrix = finddwtmsematrix(N)
m = 256;
X = zeros(256, 256);
Y = nleveldwt(X, N);
matrix = zeros(3, N+1);
for level = 1:N
    A = Y;
    B = Y;
    C = Y;
    m = m/2;
    t=1:m;
    A(m/2,m+m/2)=100;
    Za = nlevelidwt(A, N);
    matrix(1, level) = sum(Za(:).^2);
    B(m+m/2,m/2)=100;
    Zb = nlevelidwt(B, N);
    matrix(2, level) = sum(Zb(:).^2);
    C(m+m/2,m+m/2)=100;
    Zc = nlevelidwt(C, N);
    matrix(3, level) = sum(Zc(:).^2);
end
Y(m/2,m/2)=100;
Z = nlevelidwt(Y, N);
matrix(1, N+1) = sum(Z(:).^2);
matrix = sqrt(matrix(3, 1)./matrix);
return