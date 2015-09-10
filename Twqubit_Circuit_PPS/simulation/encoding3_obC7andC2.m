clear

addpath H:\Matlab\Twqubit_Circuit_PPS

load twpauliZ_full.mat
load twpauliY_full.mat

Z = [1,0;0,-1];
X = [0,1;1,0];

%% for 12 qubits
load Para_12qubit.mat
T2 = [1 0.31 1 1 1 1 0.42 1 1 1 1 1]; 

%% for 7 qubits
% load Para_7qubit.mat
% T2 = [1 0.6 1 1 1 1 0.42]; 

rho_in = KIz{2};


% %% ob C7
% load U_encoding3_grape.mat
% tic
% rho= expm(-i*KIy{7}*pi/2)*U_encoding3_grape*rho_in*(expm(-i*KIy{7}*pi/2)*U_encoding3_grape)';
% %rho = gop(2,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,X);
% toc
%  [ peak_position,  peak_intensity] = spec_plot( Para, rho, [7], T2 );
 

%% ob C2
load U_encoding3_grape.mat
tic
rho= expm(-i*KIy{2}*pi/2)*U_encoding3_grape*rho_in*(expm(-i*KIy{2}*pi/2)*U_encoding3_grape)';
toc
[ peak_position,  peak_intensity] = spec_plot( Para, rho, [2], T2 );

% %% ob C7 decouple H
% [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7); 
% rho = KIz{2}*KIz{4}*KIz{5}*KIz{6}*KIx{7};
% 
%  [ peak_position,  peak_intensity] = spec_plot( Para, rho, [7], T2 );
 
 %% ob C2 decouple H
% [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7); 
% rho = KIx{2}*KIz{4}*KIz{5}*KIz{6}*KIz{7};
% 
%  [ peak_position,  peak_intensity] = spec_plot( Para, rho, [2], T2 );