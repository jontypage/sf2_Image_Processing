function Zp = lbt(X, N, s, step)
[m, ~] = size(X);
[Pf, Pr] = pot_ii(N, s);
C = dct_ii(N);
t = [(1+N/2):(m-N/2)];
Xp = X;
Xp(t,:) = colxfm(Xp(t,:), Pf );
Xp(:,t) = colxfm(Xp(:,t)', Pf )';
Y = colxfm(colxfm(Xp,C)',C)';
Yq = quantise(Y, step);
Z = colxfm(colxfm(Yq',C')',C');
Zp = Z;
Zp(:,t) = colxfm(Zp(:,t)', Pr')';
Zp(t,:)  = colxfm(Zp(t,:), Pr');
return