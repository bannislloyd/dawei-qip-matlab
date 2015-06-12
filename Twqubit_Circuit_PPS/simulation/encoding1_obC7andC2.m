clear

addpath H:\Matlab\Twqubit_Circuit_PPS

Z = [1,0;0,-1];
X = [0,1;1,0];

%% for 12 qubits
% load Para_12qubit.mat
% T2 = [1 0.31 1 1 1 1 0.42 1 1 1 1 1]; 

%% for 7 qubits
load Para_7qubit.mat
T2 = [1 0.6 1 1 1 1 0.42]; 

load rho_encoding1_grape.mat

% %% ob C7
% load twqubit_C790_Ufid.mat
% tic
% rho= R(gop(7,Z),90)*U*R(gop(7,Z),90)'*rho_encoding1_grape*(R(gop(7,Z),90)*U*R(gop(7,Z),90)')';
% %rho = gop(2,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,X);
% toc
%  [ peak_position,  peak_intensity] = spec_plot( Para, rho, [7], T2 );
 

% %% ob C2
% load twqubit_C290_Ufid.mat
% tic
% rho= R(gop(2,Z),90)*U*R(gop(2,Z),90)'*rho_encoding1_grape*(R(gop(2,Z),90)*U*R(gop(2,Z),90)')';
% toc
% [ peak_position,  peak_intensity] = spec_plot( Para, rho, [2], T2 );

% %% ob C7 decouple H
% [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7); 
% rho = KIz{2}*KIz{4}*KIz{5}*KIz{6}*KIx{7};
% 
%  [ peak_position,  peak_intensity] = spec_plot( Para, rho, [7], T2 );
 
 %% ob C2 decouple H
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7); 
rho = KIx{2}*KIz{4}*KIz{5}*KIz{6}*KIz{7};

 [ peak_position,  peak_intensity] = spec_plot( Para, rho, [2], T2 );