function PROTO

clear Pb
ct = 1;
for j = 0:255
    Pb{ct,1} = {dec2base(j,4,4)}; % n-digits base 4 representation
    Pb{ct,1} = strrep(Pb{ct,1},'0','I'); % Replace 0 with I
    Pb{ct,1} = strrep(Pb{ct,1},'1','X'); % Replace 1 with X
    Pb{ct,1} = strrep(Pb{ct,1},'2','Y'); % Replace 2 with Y
    Pb{ct,1} = strrep(Pb{ct,1},'3','Z'); % Replace 3 with Z 
    Pb{ct,1} = ['+1' Pb{ct,1}{1}]; % +1 case
    Pb{ct,2} = full(mkstate(Pb{ct,1},0)); % matrix
    ct = ct + 1;
end

clear c
for j = 1:256
    for k = 1:256
        if sum(sum(Pb{j,2}*Pb{k,2} == Pb{k,2}*Pb{j,2})) == 256
            c(j,k) = 1;
          
        elseif sum(sum(Pb{j,2}*Pb{k,2} == -Pb{k,2}*Pb{j,2})) == 256
            c(j,k) = -1;
        end
    end
end

clear vec
for j = 1:256
    vec(j) = sum(c(j,:));
end
