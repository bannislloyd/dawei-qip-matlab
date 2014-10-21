function Bss = apply_clifford(As,U,n)

Am = mkstate(['+1' As{1}],0);
Am = U*Am*U';

clear Pb
ct = 1;
for j = 1:4^n-1
    Pb{ct,1} = {dec2base(j,4,n)}; % n-digits base 4 representation
    Pb{ct,1} = strrep(Pb{ct,1},'0','I'); % Replace 0 with I
    Pb{ct,1} = strrep(Pb{ct,1},'1','X'); % Replace 1 with X
    Pb{ct,1} = strrep(Pb{ct,1},'2','Y'); % Replace 2 with Y
    Pb{ct,1} = strrep(Pb{ct,1},'3','Z'); % Replace 3 with Z 
    Pb{ct,1} = ['+1' Pb{ct,1}{1}]; % +1 case
    Pb{ct,2} = full(mkstate(Pb{ct,1},0)); % matrix
    Pb{ct,3} = trace(Am*Pb{ct,2})/2^n;
    ct = ct + 1;
end

[a b] = max(abs([Pb{:,3}]));

Op = Pb{b,1};
Coeff = Pb{b,3};

if Coeff <0
    Bs = Op;
    Bs(1) = '-';
else 
    Bs = Op;
end
Bss = {Bs};

end

