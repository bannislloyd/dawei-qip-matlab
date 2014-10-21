% X = X
% V = -X
% Y = Y
% W = -Y

function U = find_unitary(A,B,n)

% Check the notation of A (e.g. '+1XXXX' vs 'XXXX')
if A{1}(1:2) == '+1' | A{1}(1:2) == '-1'
    A{1} = A{1}(3:end);
end
if B{1}(1:2) == '+1' | B{1}(1:2) == '-1'
    B{1} = B{1}(3:end);
end


for j = 1:n
    
    if A{1}(j) == B{1}(j)
        Rot(j) = 'I';
    elseif A{1}(j) == 'X' && B{1}(j) == 'Z'
        Rot(j) = 'W';
    elseif A{1}(j) == 'Z' && B{1}(j) == 'X'
        Rot(j) = 'Y';  
    elseif A{1}(j) == 'Y' && B{1}(j) == 'Z'
        Rot(j) = 'X';
    elseif A{1}(j) == 'Z' && B{1}(j) == 'Y'
        Rot(j) = 'V'; 
    end
    
end

U = {Rot};
end

