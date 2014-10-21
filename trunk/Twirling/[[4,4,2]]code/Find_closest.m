% A: specific operator
% B: basis of operators

% C: closest operator to A in B
% D: new basis, with C removed from B

function [C D] = Find_closest(A,B)

% Check the notation of A (e.g. '+1XXXX' vs 'XXXX')
coeff = [];
flag = 0;
if A{1}(1:2) == '+1' | A{1}(1:2) == '-1'
    coeff = A{1}(1:2);
    flag = 1;
    A{1} = A{1}(3:end);
end

% Find the operators in B that are the closest to A
clear distance;
for j = 1:size(B,2)
    distance(j) = 0;
    d1 = (A{1} == B{j});
    d2 = mod(d1+1,2);
    distance(j) = distance(j) + sum(d2);
end
[a b] = sort(distance);

% Keep only those that have identities at the correct positions
posI = (A{1} == 'IIII'); % position of the identities
a2 = []; % vector containing the distances
b2 = []; % vector containing the indices
ct = 1;
for j = 1:length(a)
    ind = b(j);
    posI_B = (B{ind} == 'IIII');
    if sum(posI == posI_B) == 4
        a2(ct) = a(j); % New list of distances
        b2(ct) = b(j); % New list of indices
        ct = ct + 1;
    end    
end

% Keep only those that have the minimal distance
c = find(a2==min(a2));
a3 = a2(c);
b3 = b2(c);

% Put bonus for operators with X measurement and/or measurement on the first qubit
bonus = zeros(1,length(a3));
for j = 1:length(a3)
    ind = b3(j);
    if B{ind}(1) == 'X'| B{ind}(1) == 'Y'
        bonus(j) = bonus(j) + 1;
    end
    if sum(B{ind}(1:4) == 'XXXX') == 1
        bonus(j) = bonus(j) + 1;
    end
end
[f g] = max(bonus); % find max bonus
b4 = b3(g); % Select the indice of the max bonus

C = {B{b4}};
D = B;
D(b4) = [];

if flag == 1
    C = [coeff C{1}];
end

end
