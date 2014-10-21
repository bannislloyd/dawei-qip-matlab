clear;
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

% rho_ini = zeros(128);
% rho_ini(1,1) = 1;

% C4,6,5,7,1,3,2; C7=Z;
% rho_ini = zeros(8);
% rho_ini(1,1) = 1;
% rho_ini = kron(rho_ini,kron(Iz,rho_ini)); 

rho_ini = zeros(64);
rho_ini(1,1) = 1;
rho_ini = kron(rho_ini,ST0); 

%% Circuit %%%%%%%%%%%%%%%%%%%
% SWAP C4,C7
SWAP_C4C7 = CNOT(4,7,7)*CNOT(7,4,7)

U1 = Hadamard(2,7)*Hadamard(7,7);
U2 = CNOT(7,4,7)*CNOT(7,5,7)*CNOT(7,6,7);
U3 = CNOT(2,7,7)*CNOT(2,1,7)*CNOT(2,3,7);

rho_fin = U3*U2*U1*SWAP_C4C7*rho_ini*(U3*U2*U1*SWAP_C4C7)';

%% Final State Analysis %%%%%%
for ii = 1:128
    if abs(rho_fin(ii,ii))>0.001
        dec2bin(ii-1,7)
        rho_fin(ii,ii)
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%