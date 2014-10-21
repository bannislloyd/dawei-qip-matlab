function x = PartialTrace(rho,subqubit)

n_qubit = abs(log2(length(rho)));
n_subqubit = length(subqubit);
subqubit(length(subqubit)+1) = 1000000;

ST0 = [1,0]; ST1 = [0,1]; I = [1,0;0,1];

x = 0;
for ii = 1:2^n_subqubit
    index = dec2bin(ii-1,n_subqubit);
    partial_operator = 1;
    m = 1;
    for jj = 1:n_qubit
        if jj == subqubit(m)
            partial_operator = kron(partial_operator, eval(['ST',num2str(index(m))]));
            m = m+1;
        else
            partial_operator = kron(partial_operator, I);
        end
    end
    x = x + partial_operator*rho*partial_operator';
end

%x = x/sqrt(abs(trace(x*x')))*sqrt(2^(n_qubit-n_subqubit));


