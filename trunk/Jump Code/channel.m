function [unitary] = channel(A0, A1)
% produce the unitary operator for the depolarizing channel with an ancilla

A0 = [1,0;0,0]; A1 = [0,0;0,1];
unitary = kron(A0,[1,0;0,0])+kron(A1,[0,0;0,1]);

r = 0.1;

A0 = [1,0;0,sqrt(1-r)]; A1 = [0, 0;0,sqrt(r)];
unitary = [1,0,0,0; 0, sqrt(1-r),0,sqrt(r);0,0,-1,0;0,sqrt(r),0,-sqrt(1-r)];

a = 0.2;
phi = cos(a)*[1;0]+sin(a)*[0;1];
input = kron([1;0],phi);

unitary*input

theory =  kron([1;0],A0*phi) + kron([0;1],A1*phi)