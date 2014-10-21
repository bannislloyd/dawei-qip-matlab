function P = Create_all_Paulis(n)

clear P
for j = 1:4^n-1
    P(j) = {dec2base(j,4,n)}; % n-digits base 4 representation
    P(j) = strrep(P(j),'0','I'); % Replace 0 with I
    P(j) = strrep(P(j),'1','X'); % Replace 1 with X
    P(j) = strrep(P(j),'2','Y'); % Replace 2 with Y
    P(j) = strrep(P(j),'3','Z'); % Replace 3 with Z 
end


        
end

