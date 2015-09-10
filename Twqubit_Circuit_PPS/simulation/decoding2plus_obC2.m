clear

addpath H:\Matlab\Twqubit_Circuit_PPS

Z = [1,0;0,-1];
X = [0,1;1,0];

%% for 12 qubits
load Para_12qubit.mat
T2 = [1 0.31 1 1 1 1 0.42 1 1 1 1 1]; 

%% for 7 qubits
% load Para_7qubit.mat
% T2 = [1 0.6 1 1 1 1 0.42]; 

%% ob C7
load rho_step2.mat
tic
rho= rho_everystep;
%rho = gop(2,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,X);
toc
 [ peak_position,  peak_intensity] = spec_plot( Para, rho, [7], T2 );
 

%% ob C2
% tic
% rho= 2*gop(1,Z)*gop(2,X)*gop(7,Z)-2*gop(3,Z)*gop(2,X)*gop(7,Z)-gop(2,X)*gop(7,Z);
% toc
% [ peak_position,  peak_intensity] = spec_plot( Para, rho, [2], T2 );

% %% ob C7 decouple H
% [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7); 
% rho = KIz{2}*KIz{4}*KIz{5}*KIz{6}*KIx{7};
% 
%  [ peak_position,  peak_intensity] = spec_plot( Para, rho, [7], T2 );
 
 %% ob C2 decouple H
% [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7); 
% rho = 2*KIz{1}*KIx{2}*KIz{7}-2*KIz{3}*KIx{2}*KIz{7}-KIx{2}*KIz{7};
% 
%  [ peak_position,  peak_intensity] = spec_plot( Para, rho, [2], T2 );