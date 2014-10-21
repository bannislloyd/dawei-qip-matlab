function [Result ] = MultiKron( n_qubits,op1,op2,op3,op4,op5,op6,op7,op8,op9,op10,op11,op12 )

Result = 1;
for ii = 1:n_qubits
    Result = kron(Result, eval(['op',num2str(ii)]));
end