function O = Create_all_Obs(n)

P = Create_all_Paulis(n);

% X string
Xn = dec2base(0,2,n); % n-digits base 2 representation
Xn = strrep(Xn,'0','X'); % Replace 0 with Z

% Y string
Yn = dec2base(0,2,n); % n-digits base 2 representation
Yn = strrep(Yn,'0','Y'); % Replace 0 with Z

clear nbX nbY
ct = 1;
for j = 1:4^n-1
    nbX = sum(P{j} == Xn);
    nbY = sum(P{j} == Yn);
    
    if (nbX+nbY) == 1
        O(ct) = P(j);
        ct = ct + 1;
    end

end

