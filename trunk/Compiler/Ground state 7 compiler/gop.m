%% File: gop.m (generalized operator)
% Date: 2005/07/14
% Author: Xinhua Peng
%
% Usage: gop(s,U)
% In: single-qubit unitary operator U, qubit name s 
% Out: n-spin unitary operator which acts on qubit s with U and
% trivially on the remaining qubits
% Order: 1,2,3,4 from high to low bit
function gop=gop(s,U)

global nqubits
goplocal=U;

for position=1:(s-1)
    goplocal=kron(eye(2),goplocal);
end

for position=s+1:nqubits
    goplocal=kron(goplocal,eye(2));
end

gop=goplocal;