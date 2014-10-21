function sevenbitpauli(rou)
     
  pauli = cell(1,4);
    %pauli{1}=0.5*[0,1;1,0];  pauli{2}=0.5*[0,-i;i,0];  pauli{3}=0.5*[1,0;0,-1];  pauli{4}=eye(2);
 pauli{1}=[0,1;1,0];  pauli{2}=[0,-i;i,0];  pauli{3}=[1,0;0,-1];  pauli{4}=eye(2);
   
    script=['X','Y','Z','I'];
   
    AAAA = 0;
    
      for j1=1:4
         for j2=1:4
            for j3=1:4
                for j4=1:4
                     for j5=1:4
                          for j6=1:4
                               for j7=1:4
                               value = trace(rou*kron(kron(kron(kron(kron(kron(pauli{j1},pauli{j2}),pauli{j3}),pauli{j4}),pauli{j5}),pauli{j6}),pauli{j7}))*(sqrt(2)^7)/2^7;
                               AAAA = AAAA+abs(value)^2;
                               if (abs(value)>0.5)
                               fprintf('%c%c%c%c%c%c%c , %g+%gi \n',script(j1),script(j2),script(j3),script(j4),script(j5),script(j6),script(j7),real(value),imag(value))
                               end
                               
                               end
                          end
                     end
                end
            end
        end
      end
 AAAA
 