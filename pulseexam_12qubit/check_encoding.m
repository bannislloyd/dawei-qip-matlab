clear;

addpath C_rotations

load twpauliX_full.mat
load twpauliY_full.mat
load twpauliZ_full.mat
load Para.mat
I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 
%initial state
rho_in = gop(7,Z);

% First step 
 load twqubit_C790_Ufid.mat
 U_encoding1 = expm(-i*pi/2*KIz{7})*U*expm(i*pi/2*KIz{7});
 %free evolution 1/4J27  6670.22us = 6670us
 U_encoding1 = F(H,6670*1e-6)*U_encoding1;
 %pi_pulse on C2
 load twqubit_C2180_Ufid.mat
 U_encoding1 = U*U_encoding1;
 %free evolution 1/4J67-1/4J27  561.48us = 560us
 U_encoding1 = F(H,560*1e-6)*U_encoding1;
 %pi_pulse on C6
 load twqubit_C6180_Ufid.mat
 U_encoding1 = U*U_encoding1;
 %free evolution 1/4J47-1/4J67 1383.04us = 1380us
 U_encoding1 = F(H,1380*1e-6)*U_encoding1;
 %pi_pulse on C4
 load twqubit_C4180_Ufid.mat
 U_encoding1 = U*U_encoding1;
 %free evolution 1/4J57-1/4J47 2879.50us = 2880us
 U_encoding1 = F(H,2880*1e-6)*U_encoding1;
 %pi_pulse on C5,C7
 load twqubit_C57180_Ufid.mat
 U_encoding1 = U*U_encoding1;
 %free evolution 1/4J57 11494.25us = 11490us
 U_encoding1 = F(H,11490*1e-6)*U_encoding1;
 %pi/2_pulse on C7
 load twqubit_C790_Ufid.mat
 U_encoding1 = expm(i*pi/2*KIz{7})*U*expm(-i*pi/2*KIz{7})*U_encoding1;
 
 rho_encoding1_grape = U_encoding1*rho_in*U_encoding1';
 rho_encoding1_grape = Gz(rho_encoding1_grape);
 
 U_encoding1_grape = U_encoding1;
 
 save  U_encoding1_grape.mat  U_encoding1_grape
 save rho_encoding1_grape.mat rho_encoding1_grape
 
 %Test value: IZIZZZZIIIII    fidelity = 0.9832
f1 =  trace(rho_encoding1_grape*(gop(2,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z)))/2^12
%% First Step Over and Checked %%%%%%%%%%%%%%%%%%%%%

% Second step 
 load rho_encoding1_grape.mat
 load twqubit_C290_Ufid.mat
 U_encoding2 = expm(-i*pi/2*KIz{2})*U*expm(i*pi/2*KIz{2});
 %free evolution 1/4J12 4341.79us = 4340us
 U_encoding2 = F(H,4340*1e-6)*U_encoding2;
 %pi_pulse on C1
 load twqubit_C1180_Ufid.mat
 U_encoding2 = U*U_encoding2;
 %free evolution 1/4J23-1/4J12 3303.47us = 3300us
 U_encoding2 = F(H,3300*1e-6)*U_encoding2;
 %pi_pulse on C23
 load twqubit_C23180_Ufid.mat
 U_encoding2 = U*U_encoding2;
 %free evolution 1/4J23 7645.26us = 7640us (4340+3300)
 U_encoding2 = F(H,7640*1e-6)*U_encoding2;
 %pi/2_pulse on C2
 load twqubit_C290_Ufid.mat
 U_encoding2 = expm(i*pi/2*KIz{2})*U*expm(-i*pi/2*KIz{2})*U_encoding2;

 rho_encoding2_grape = U_encoding2*rho_encoding1_grape*U_encoding2';
 rho_encoding2_grape = Gz(rho_encoding2_grape);

 U_encoding2_grape = U_encoding2;
 
 save  U_encoding2_grape.mat  U_encoding2_grape
 save rho_encoding2_grape.mat rho_encoding2_grape

% Test value: ZZZZZZZIIIII Here it is -1, fidelity -0.9692
f2 =  trace(rho_encoding2_grape*(gop(1,Z)*gop(2,Z)*gop(3,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z)))/2^12
%% Second Step Over and Checked %%%%%%%%%%%%%%%%%%%%%

%% Third step
load rho_encoding2_grape.mat
%pi/2_pulse on C2,C7, C3, C4
load twqubit_C234790_Ufid.mat
U_encoding3 = expm(-i*pi/2*(KIz{2}+KIz{3}+KIz{4}+KIz{7}))*U*expm(i*pi/2*(KIz{2}+KIz{3}+KIz{4}+KIz{7}));
%free evolution 1/4JC7H5 1683.50us = 1680us
U_encoding3 = F(H,1680*1e-6)*U_encoding3;
%pi_pulse on C1,C5,C6
load twqubit_C156180_Ufid.mat
U_encoding3 = U*U_encoding3;
%free evolution 1/4JC7H5
U_encoding3 = F(H,1680*1e-6)*U_encoding3;
%phase correction
load twqubit_C234790withPC_Ufid.mat
U_encoding3 = U*U_encoding3;

rho_encoding3_grape = U_encoding3*rho_encoding2_grape*U_encoding3';
rho_encoding3_grape = Gz(rho_encoding3_grape);

 U_encoding3_grape = U_encoding3;
 
 save  U_encoding3_grape.mat  U_encoding3_grape
 save rho_encoding3_grape.mat rho_encoding3_grape
%Test value: ZZZZZZZZZZZZ Here it is -0.95
f3 = trace(rho_encoding3_grape*(gop(1,Z)*gop(2,Z)*gop(3,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z)*gop(8,Z)*gop(9,Z)*gop(10,Z)*gop(11,Z)*gop(12,Z)))/2^12
%% %%% Third Step Over and Checked %%%%%%%%%%%%%%%%%%%%%