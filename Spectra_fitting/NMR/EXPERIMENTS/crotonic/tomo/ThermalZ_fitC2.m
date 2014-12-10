function [A,ff,ErrBar,pps]=ThermalZ_fitC2(vec,n)

pps = createstruc([vec]); %% ThermalZ1_1

 
[tran ff T2 opR opI] = transitions(7,5); %% C2, because C2 is the 5th qubit in the total 7 qubits. Here this function gives all 64 frenquencies of the peaks, which are saved in ff
% ff = ff-0.2;
pps{1} = fitespec(pps{1},ff,[0.2 1],T2,n,7);



for k = 1:64;
A_r(k) = pps{1}.ILP(2*k-1);
A_i(k) = pps{1}.ILP(2*k);
A(k) = A_r(k)+i*A_i(k);
ErrBar_r(k) =  pps{1}.ILPerr(2*k-1);
ErrBar_i(k) =  pps{1}.ILPerr(2*k);
ErrBar(k) = ErrBar_r(k) +i* ErrBar_i(k);
%fprintf(fn, '%10.4f \n',A_r(k)); fprintf(fn1, '%10.4f \n',A_i(k));
end
%fclose(fn);fclose(fn1);