function p = dec_t1( rho )
%DEC_T1 Summary of this function goes here
%   Detailed explanation goes here

pauli = cell(1,2);
pauli{1}=[1,0;0,-1];  pauli{2}=eye(2);


temp = zeros(128);
  for j1=1:2
         for j2=1:2
            for j3=1:2
                for j4=1:2
                     for j5=1:2
                          for j6=1:2
                               for j7=1:2
                               pauliZ = kron(kron(kron(kron(kron(kron(pauli{j1},pauli{j2}),pauli{j3}),pauli{j4}),pauli{j5}),pauli{j6}),pauli{j7})*(sqrt(2)^7)/128;
                               projection = 0;
                               for ii  = 1:128
                                   projection = projection + pauliZ(ii,ii)*rho(ii,ii);
                               end
                                   projection = projection*
                                   temp = temp+projection*pauliZ;
                               end
                          end
                     end
                end
            end
         end
  end
 
  
  p = rho;
  for ii = 1:128
      p(ii,ii) = temp(ii,ii);
  end
