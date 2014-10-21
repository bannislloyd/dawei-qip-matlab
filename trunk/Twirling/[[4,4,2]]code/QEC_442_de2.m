function [U]=QEC_442_de2;


%clear;
%clc;


%definition---
s0 = [1;0;];
s1 = [0;1;];

dx=[0 1
    1 0];
dy=[0 -i
    i 0];
dz=[1 0
    0 -1];
E2=eye(2,2);
E4=eye(4,4);

h = [1 1;
     1 -1]/sqrt(2);
 
H3 = kron(kron(E4,h),E2);

C_AB = [1 0 0 0;
        0 1 0 0;
        0 0 0 1;
        0 0 1 0];
    
C_BA = [1 0 0 0;
        0 0 0 1;
        0 0 1 0;
        0 1 0 0];        
 
S = [1 0 0 0;
     0 0 1 0;
     0 1 0 0;
     0 0 0 1];


S12 = kron(S,E4);
S34 = kron(E4,S);

U = eye(16,16);
P = S12*kron(kron(E2,C_AB),E2)*S12;     U = P*U;    %%% C, 1,3
P = kron(kron(E2,C_AB),E2);             U = P*U;    %%% C, 2,3
P = kron(kron(E2,C_BA),E2);             U = P*U;    %%% C, 3,2
P = S34*S12*kron(kron(E2,C_BA),E2)*S12*S34;             U = P*U;    %%% C, 4,1
P = kron(E4,C_AB);                      U = P*U;    %%% C, 3,4
P = kron(kron(E2,C_AB),E2);             U = P*U;    %%% C, 2,3
P = H3;                                 U = P*U;    %%% Hadmard for 3   

