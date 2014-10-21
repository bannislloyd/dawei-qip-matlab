clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);

load Para.mat
Hint = H_int;

%% Parameters for the GRAPE pulse
Name = '90xH_2A';
Amplitude1 = 25000;
Time = 180e-6;
Length = 90;
dt = Time/Length;
FirstLine = 28; % the first line which contains the information of power and phase 

Output = 'test1';

[power1,phase1]=dataout(Name,Output,FirstLine,Length);

Name = '90xH_2B';
Amplitude2 = 1/4/12e-6;
Time = 180e-6;
Length = 90;
dt = Time/Length;
FirstLine = 28; % the first line which contains the information of power and phase 

Output = 'test2';

[power2,phase2]=dataout(Name,Output,FirstLine,Length);
%% Check
X = 0; Y = 0;
for jj = 1:2
    X = X + KIx{jj};
    Y = Y + KIy{jj};
end

% U_encoding80ms = cell(4000,1);

U = eye(2^3);
 U = U*expm(-i*Hint*5e-6);
for ii = 1:Length
    Hext = 2*pi*(Amplitude1*power1(ii)/100)*(X*cos(phase1(ii)/360*2*pi)-Y*sin(phase1(ii)/360*2*pi))+2*pi*(Amplitude2*power2(ii)/100)*(KIx{3}*cos(phase2(ii)/360*2*pi)-KIy{3}*sin(phase2(ii)/360*2*pi));
% U_encoding80ms{ii} = expm(-i*(Hext+Hint)*dt);
    U = expm(-i*(Hext+Hint)*dt)*U;
   
end

U = expm(-i*Hint*5e-6)*U;
Utar = rot(KIx{3},pi/2);
%%%% ground state %%%%%%%%%%
% U0=CNOT(4,7,7)*CNOT(7,4,7);
% U1=Hadamard(7,7)*Hadamard(2,7);
% U2=CNOT(7,4,7)*CNOT(7,6,7)*CNOT(7,5,7);
% U3=CNOT(2,7,7)*CNOT(2,1,7)*CNOT(2,3,7);
% U_total=U3*U2*U1*U0;
%%%%%%%%%%%%%%%%%%%%%


% Utar = rot(Y,pi/2);
%  rho_ini = KIz{1}+KIz{3};
%  rho_fin = U*rho_ini*U';
%  rho_tar = Utar*rho_ini*Utar';
%  Fidelity = trace(rho_fin*rho_tar)/trace( rho_ini* rho_ini)
Fidelity = abs(trace(U*Utar'))/2^3

% Uencoding_grape_80Iterations = U;
% save  Uencoding_grape_80Iterations.mat  Uencoding_grape_80Iterations