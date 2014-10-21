function O = Create_all_Obs

P = Create_all_Paulis;

clear nbX nbY
ct = 1;
for j = 1:255
    nbX = sum(P{j} == 'XXXX');
    nbY = sum(P{j} == 'YYYY');
    
    if (nbX+nbY) == 1
        O(ct) = P(j);
        ct = ct + 1;
    end

end

