% to produce the decoherence matrix for 7-qubit

clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

N_qubits = 7;
Dimension = 2^N_qubits;
t2 = [1.611 0.877 1.122 0.792 1.143 1.912 0.531];


decoherence_matrix = ones(Dimension);

for ii = 1:Dimension
    for jj = 1:Dimension
        row_state = dec2binvec(ii-1,N_qubits);
        column_state = dec2binvec(jj-1,N_qubits);
        for kk = 1:N_qubits
            if (row_state(N_qubits-kk+1)-column_state(N_qubits-kk+1))~=0
              decoherence_matrix(ii,jj) = decoherence_matrix(ii,jj)*exp(-20e-6/t2(kk));
            end
        end
    end
end

save decoherence_matrix.mat decoherence_matrix
                
