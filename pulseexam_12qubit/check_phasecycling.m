clear;

addpath C_rotations

load twpauliX_full.mat
load twpauliY_full.mat
load twpauliZ_full.mat
load Para.mat
I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 
%initial state
load rho_encoding3_grape.mat
%load rho_phasecycling_grape_19.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Phase Cycling
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
 Phase = cell(1,24);
 
 load X_all.mat
 load Y_all.mat
 %Y_all = gop(1,Y)+gop(2,Y)+gop(3,Y)+gop(4,Y)+gop(5,Y)+gop(6,Y)+gop(7,Y)+gop(8,Y)+gop(9,Y)+gop(10,Y)+gop(11,Y)+gop(12,Y);
 %X_all = gop(1,X)+gop(2,X)+gop(3,X)+gop(4,X)+gop(5,X)+gop(6,X)+gop(7,X)+gop(8,X)+gop(9,X)+gop(10,X)+gop(11,X)+gop(12,X);

disp('Everything Loaded') 
tic
 
load twqubit_all90_Ufid.mat
sum_z = 0; % sum KIz from 1 to 12
for kk = 1:12
sum_z = sum_z+KIz{kk};
end
 %state after phase cycling: highest coherence
 rho_phasecycling_grape = 0;
 for ii = 1:24
    %  Phase{ii} = R(cos(pi/12*ii)*Y_all-sin(pi/12*ii)*X_all,90);
    Phase = expm(-i*(pi/2+pi/12*ii)*sum_z)*U*expm(i*(pi/2+pi/12*ii)*sum_z);
     rho_phasecycling_grape = Phase*(-1)^(ii+1)*rho_encoding3_grape*Phase'+rho_phasecycling_grape;
     save rho_phasecycling_grape.mat rho_phasecycling_grape
     fprintf('Finished Loop No. %g ,total time taken till this point is %g minutes \n \n',ii,toc/60)
 end
 rho_phasecycling_grape = rho_phasecycling_grape/24/sqrt(2);
 % check the highest order term is 0.5018-0.4057i (not sure why there is a phase)
 
 disp('Started saving.............')
 save rho_phasecycling_grape.mat rho_phasecycling_grape
 disp(['Saved and finished'])
%  
% 
%  % %%% Phase Cycling Finished %%%%%%%%%%%%%%%%%%%%%
%  
%  Test value: rho_phasecycling, Fidelity = 0.9511
rho_phasecycling_ideal = zeros(4096);
rho_phasecycling_ideal(1,4096) = 1/sqrt(2);
rho_phasecycling_ideal(4096,1) = 1/sqrt(2);

R1=rho_phasecycling_grape(1,4096)                     
R2=rho_phasecycling_grape(4096,1)

Fidelity = rho_phasecycling_grape(1,4096)*rho_phasecycling_ideal(4096,1) + rho_phasecycling_grape(4096,1)* rho_phasecycling_ideal(1,4096)
% 
% %% %%% Phase Cycling Over and Checked %%%%%%%%%%%%%%%%%%%%%
