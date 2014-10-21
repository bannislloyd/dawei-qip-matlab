function [Hadamard_matrix] = Hadamard(Hada_qubit,n_qubit)

Hadamard_single = 1/sqrt(2)*[1,1;1,-1];
I = eye(2);

Hadamard_matrix = 1;

for ii = 1:n_qubit
       if Hada_qubit==ii
          Hadamard_matrix = kron(Hadamard_matrix,Hadamard_single);
       else 
          Hadamard_matrix = kron(Hadamard_matrix,I);
       end
end