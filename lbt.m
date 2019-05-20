function Zp = lbt(X, N)
[m, ~] = size(X);
[Pf, Pr] = pot_ii(N);
C = dct_ii(N);
t = [(1+N/2):(m-N/2)];
Xp = X;
Xp(t,:) = colxfm(Xp(t,:), Pf );
Xp(:,t) = colxfm(Xp(:,t)', Pf )';
Y = colxfm(colxfm(Xp,C)',C)';
Z = colxfm(colxfm(Y',C')',C');
Zp = Z;
Zp(:,t) = colxfm(Zp(:,t)', Pr')';
Zp(t,:)  = colxfm(Zp(t,:), Pr');
return