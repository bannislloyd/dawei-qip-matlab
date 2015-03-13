clear;

addpath C_rotations

load twpauliX_full.mat
load twpauliY_full.mat
load twpauliZ_full.mat
load Para.mat
I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 
%initial state
rho_in = gop(7,Z);

%% First step 
% load twqubit_C790_Ufid.mat
% U_encoding1 = expm(-i*pi/2*KIz{7})*U*expm(i*pi/2*KIz{7});
% %free evolution 1/4J27
% U_encoding1 = F(H,1/4/Para(2,7))*U_encoding1;
% %pi_pulse on C2
% load twqubit_C2180_Ufid.mat
% U_encoding1 = U*U_encoding1;
% %free evolution 1/4J67-1/4J27
% U_encoding1 = F(H,(1/4/Para(6,7)-1/4/Para(2,7)))*U_encoding1;
% %pi_pulse on C6
% load twqubit_C6180_Ufid.mat
% U_encoding1 = U*U_encoding1;
% %free evolution 1/4J47-1/4J67
% U_encoding1 = F(H,(1/4/Para(4,7)-1/4/Para(6,7)))*U_encoding1;
% %pi_pulse on C4
% load twqubit_C4180_Ufid.mat
% U_encoding1 = U*U_encoding1;
% %free evolution 1/4J57-1/4J47
% U_encoding1 = F(H,(1/4/Para(5,7)-1/4/Para(4,7)))*U_encoding1;
% %pi_pulse on C5,C7
% load twqubit_C57180_Ufid.mat
% U_encoding1 = U*U_encoding1;
% %free evolution 1/4J57
% U_encoding1 = F(H,(1/4/Para(5,7)))*U_encoding1;
% %pi/2_pulse on C7
% load twqubit_C790_Ufid.mat
% U_encoding1 = expm(i*pi/2*KIz{7})*U*expm(-i*pi/2*KIz{7})*U_encoding1;
% 
% rho_encoding1 = U_encoding1*rho_in*U_encoding1';
% rho_encoding1 = Gz(rho_encoding1);
% 
% save U_encoding1.mat U_encoding1
% save rho_encoding1.mat rho_encoding1
% 
% %Test value: IZIZZZZIIIII    fidelity = 0.9832
% trace(rho_encoding1*(gop(2,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z)))/2^12
% %%% First Step Over and Checked %%%%%%%%%%%%%%%%%%%%%

%% Second step 
% load rho_encoding1.mat
% load twqubit_C290_Ufid.mat
% U_encoding2 = expm(-i*pi/2*KIz{2})*U*expm(i*pi/2*KIz{2});
% %free evolution 1/4J12
% U_encoding2 = F(H,1/4/Para(1,2))*U_encoding2;
% %pi_pulse on C1
% load twqubit_C1180_Ufid.mat
% U_encoding2 = U*U_encoding2;
% %free evolution 1/4J23-1/4J12
% U_encoding2 = F(H,(1/4/Para(2,3)-1/4/Para(1,2)))*U_encoding2;
% %pi_pulse on C23
% load twqubit_C23180_Ufid.mat
% U_encoding2 = U*U_encoding2;
% %free evolution 1/4J23
% U_encoding2 = F(H,(1/4/Para(2,3)))*U_encoding2;
% %pi/2_pulse on C2
% load twqubit_C290_Ufid.mat
% U_encoding2 = expm(i*pi/2*KIz{2})*U*expm(-i*pi/2*KIz{2})*U_encoding2;

%rho_encoding2 = U_encoding2*rho_encoding1*U_encoding2';
% rho_encoding2 = Gz(rho_encoding2);

% save U_encoding2.mat U_encoding2
% save rho_encoding2.mat rho_encoding2

%Test value: ZXZZZZZIIIII Here it is -1, fidelity -0.9692
% trace(rho_encoding2*(gop(1,Z)*gop(2,Z)*gop(3,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z)))/2^12
%%% Second Step Over and Checked %%%%%%%%%%%%%%%%%%%%%

% %% Third step
% load rho_encoding2.mat
% %pi/2_pulse on C2,C7, C3, C4
% load twqubit_C234790_Ufid.mat
% U_encoding3 = expm(-i*pi/2*(KIz{2}+KIz{3}+KIz{4}+KIz{7}))*U*expm(i*pi/2*(KIz{2}+KIz{3}+KIz{4}+KIz{7}));
% %free evolution 1/4JC7H5
% U_encoding3 = F(H,1/4/148.5)*U_encoding3;
% %pi_pulse on C1,C5,C6
% load twqubit_C156180_Ufid.mat
% U_encoding3 = U*U_encoding3;
% %free evolution 1/4JC7H5
% U_encoding3 = F(H,1/4/148.5)*U_encoding3;
% %phase correction
% load twqubit_C234790withPC_Ufid.mat
% U_encoding3 = U*U_encoding3;
% 
% rho_encoding3 = U_encoding3*rho_encoding2*U_encoding3';

load rho_encoding3.mat
rho_encoding3 = Gz(rho_encoding3);

% save U_encoding3.mat U_encoding3
save rho_encoding3.mat rho_encoding3
%Test value: ZZZZZZZZZZZZ Here it is -0.95
trace(rho_encoding3*(gop(1,Z)*gop(2,Z)*gop(3,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z)*gop(8,Z)*gop(9,Z)*gop(10,Z)*gop(11,Z)*gop(12,Z)))/2^12
% %%% Third Step Over and Checked %%%%%%%%%%%%%%%%%%%%%