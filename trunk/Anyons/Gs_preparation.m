clear;
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

% rho_ini = zeros(128);
% rho_ini(1,1) = 1;

% C4,6,5,7,1,3,2; C7=Z;
% rho_ini = zeros(8);
% rho_ini(1,1) = 1;
% rho_ini = kron(rho_ini,kron(Iz,rho_ini)); 

% rho_ini = zeros(64);
% rho_ini(1,1) = 1;
% rho_ini = kron(rho_ini,Iz); 

load U_PPS_rho

rho_ini  = rho_final;
rho_ini = expm(-i*pi*(KIx{1}+KIx{2}+KIx{3}+KIx{5}))*expm(-i*pi/2*KIy{7})*rho_ini*(expm(-i*pi*(KIx{1}+KIx{2}+KIx{3}+KIx{5}))*expm(-i*pi/2*KIy{7}))';

%% Circuit %%%%%%%%%%%%%%%%%%%
% SWAP C4,C7
% SWAP_C4C7 = CNOT(4,7,7)*CNOT(7,4,7);
% 
% U1 = Hadamard(2,7)*Hadamard(7,7);
% U2 = CNOT(7,4,7)*CNOT(7,5,7)*CNOT(7,6,7);
% U3 = CNOT(2,7,7)*CNOT(2,1,7)*CNOT(2,3,7);
% rho_fin = U3*U2*U1*SWAP_C4C7*rho_ini*(U3*U2*U1*SWAP_C4C7)';

% 
load check_grape_60ms_Gd.mat
rho_fin = U_grape60msGd*rho_ini*U_grape60msGd';

% braiding
% U_braiding = rot(KIy{4},pi)* rot(KIx{6},pi)* rot(KIx{5},pi)* rot(KIx{1},pi)* rot(KIx{3},pi)* rot(KIx{2},pi);
% rho_fin = U_braiding*rho_fin*U_braiding';


%% Final State Analysis %%%%%%
for ii = 1:128
    if abs(rho_fin(ii,ii))>0.05
        aa = dec2bin(ii-1,7);
        [aa(4),aa(6),aa(5),aa(7),aa(1),aa(3),aa(2)]
        rho_fin(ii,ii)
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Observation %%%%%%
 rho_obC4_pps = expm(-i*pi/2*KIy{4})*rho_fin*expm(-i*pi/2*KIy{4})';
% 
 save rho_obC4_pps.mat rho_obC4_pps

%rho_obC2 = expm(-i*pi/2*KIy{2})*rho_fin*expm(-i*pi/2*KIy{2})';

%save rho_obC2.mat rho_obC2