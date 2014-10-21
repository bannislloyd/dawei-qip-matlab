% Decompose


function []=decompose(rho)


I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz;


Pauli1{1}=(Z+I)/sqrt(2);   Pauli1{2}=(Z-I)/sqrt(2);    Pauli_symbol1{1}='(Z+I)';   Pauli_symbol1{2}='(Z-I)';
Pauli2{1}=(Z+I)/sqrt(2); Pauli2{2}=(Z-I)/sqrt(2);  Pauli_symbol2{1}='(Z+I)'; Pauli_symbol2{2}='(Z-I)';
Pauli3{1}=(Z+I)/sqrt(2);   Pauli3{2}=(Z-I)/sqrt(2);    Pauli_symbol3{1}='(Z+I)';   Pauli_symbol3{2}='(Z-I)';
Pauli4{1}=(Z+I)/sqrt(2);   Pauli4{2}=(Z-I)/sqrt(2);    Pauli_symbol4{1}='(Z+I)';   Pauli_symbol4{2}='(Z-I)';
Pauli5{1}=(Z+I)/sqrt(2); Pauli5{2}=(Z-I)/sqrt(2);  Pauli_symbol5{1}='(Z+I)'; Pauli_symbol5{2}='(Z-I)';
Pauli6{1}=(Z+I)/sqrt(2);   Pauli6{2}=(Z-I)/sqrt(2);    Pauli_symbol6{1}='(Z+I)';   Pauli_symbol6{2}='(Z-I)';
Pauli7{1}=Z; Pauli7{2}=Z;  Pauli_symbol7{1}='Z'; Pauli_symbol7{2}='Z';
for k1=1:2
    for k2=1:2
        for k3=1:2
            for k4=1:2
                for k5=1:2
                    for k6=1:2
                        for k7=1:2
                            Pauli_Basis{k1,k2,k3,k4,k5,k6,k7}=kron(kron(kron(kron(kron(kron(Pauli1{k1},Pauli2{k2}),Pauli3{k3}),Pauli4{k4}),Pauli5{k5}),Pauli6{k6}),Pauli7{k7});
                            Pauli_Basis_symbol{k1,k2,k3,k4,k5,k6,k7}=[Pauli_symbol1{k1}, Pauli_symbol2{k2},Pauli_symbol3{k3},Pauli_symbol4{k4},Pauli_symbol5{k5},Pauli_symbol6{k6},Pauli_symbol7{k7}];
                            if abs(trace(Pauli_Basis{k1,k2,k3,k4,k5,k6,k7}*rho')/128)>0.02
                                disp({Pauli_Basis_symbol{k1,k2,k3,k4,k5,k6,k7}, trace(Pauli_Basis{k1,k2,k3,k4,k5,k6,k7}*rho')/128});
                            else ;
                            end
                        end
                    end
                end
            end
        end
    end
end 
