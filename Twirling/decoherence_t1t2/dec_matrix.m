% to produce the decoherence matrix for 7-qubit

clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

N_qubits = 7;
Dimension = 2^N_qubits;
% t2 = [1.611 0.877 1.122 0.792 1.143 1.912 0.531];
% t2 = [0.531 0.531 0.531 0.531 0.531 0.531 0.531];
 t1 = [8.02 3.61 1.83 3.72 12.95 8.16 3.64];
 t2 = [0.65 0.65 0.65 0.65 0.65 0.65 0.65];
% t2 = [0.9708 0.9708 0.9708 0.9708 0.9708 0.9708 0.9708];

decoherence_matrix = ones(Dimension);

for ii = 1:Dimension
    for jj = 1:Dimension
        row_state = dec2binvec(ii-1,7);
        column_state = dec2binvec(jj-1,7);
        for kk = 1:7
            if (row_state(7-kk+1)-column_state(7-kk+1))~=0
              decoherence_matrix(ii,jj) = decoherence_matrix(ii,jj)*exp(-20e-6/t2(kk))*sqrt(exp(-20e-6/t1(kk)));
            end
        end
    end
end

save decoherence_matrix_t1t2.mat decoherence_matrix
                
