function Zp = lbt_r(X, N, s)
[m, ~] = size(X);
[~, Pr] = pot_ii(N, s);
C = dct_ii(N);
t = [(1+N/2):(m-N/2)];
Z = colxfm(colxfm(X',C')',C');
Zp = Z;
Zp(:,t) = colxfm(Zp(:,t)', Pr')';
Zp(t,:)  = colxfm(Zp(t,:), Pr');
return