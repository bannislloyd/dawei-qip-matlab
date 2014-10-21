function threepauli(rou)
     
  pauli = cell(1,4);
    %pauli{1}=0.5*[0,1;1,0];  pauli{2}=0.5*[0,-i;i,0];  pauli{3}=0.5*[1,0;0,-1];  pauli{4}=eye(2);
 pauli{1}=[0,1;1,0];  pauli{2}=[0,-i;i,0];  pauli{3}=[1,0;0,-1];  pauli{4}=eye(2);
   
    script=['X','Y','Z','I'];
   
    
    
      for j1=1:4
         for j2=1:4
            for j3=1:4
                   value = trace(rou*kron(kron(pauli{j1},pauli{j2}),pauli{j3}))/4;
                              
                               if (abs(value)>0.01)
                               fprintf('%c%c%c , %g+%gi \n',script(j1),script(j2),script(j3),real(value),imag(value))
                               end
                               
                               
            end
         end
      end

 