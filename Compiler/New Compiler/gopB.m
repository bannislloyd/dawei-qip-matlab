% File: gop.m (generalized operator)
% Date: 2005/07/14
% Author: Xinhua Peng
%
% Usage: gop(s,U)
% In: single-qubit unitary operator U, qubit name s 
% Out: n-spin unitary operator which acts on qubit s with U and
% trivially on the remaining qubits
% Order: 1,2,3,4 from high to low bit

function gop=gopB(s,U)
nqubits=4;

for position=1:(s-1)
    U=kron(eye(2),U);
end

for position=s+1:nqubits
    U=kron(U,eye(2));
end

gop=U;