function [cnot_gate] = CNOT(control_qubit,evolve_qubit,n_qubit)

sigma_x=[0,1;1,0];
I=[1,0;0,1];
ST0=[1,0;0,0];
ST1=[0,0;0,1];

control_part = 1;
evolve_part = 1;

for ii = 1:n_qubit
       if control_qubit==ii
          control_part = kron(control_part,ST0);
          evolve_part = kron(evolve_part,ST1);
       else if evolve_qubit==ii
               control_part = kron(control_part,I);
               evolve_part = kron(evolve_part,sigma_x);
       else 
          control_part = kron(control_part,I);
          evolve_part = kron(evolve_part,I);
           end
       end
end

cnot_gate = control_part + evolve_part;