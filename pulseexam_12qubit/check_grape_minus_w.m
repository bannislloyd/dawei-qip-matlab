clear;

load Para_minus_w.mat
load twpauliX_full.mat
load twpauliY_full.mat


%% Parameters for the GRAPE pulse
Name1 = 'twqubit_C690_C.txt';
Name2 = 'twqubit_C690_H.txt';
Amplitude = 6000;
Time = 1e-3;
Length = 100;
dt = Time/Length;
FirstLine = 19; % the first line which contains the information of power and phase 

Output1 = 'test1';
Output2 = 'test2';

[power1,phase1]=dataout(Name1,Output1,FirstLine,Length);
[power2,phase2]=dataout(Name2,Output2,FirstLine,Length);
%% Check
X_C = 0; Y_C = 0;
for jj = 1:7
    X_C = X_C + KIx{jj};
    Y_C = Y_C + KIy{jj};
end

X_H = 0; Y_H = 0;
for jj = 8:12
    X_H = X_H + KIx{jj};
    Y_H = Y_H + KIy{jj};
end


U = eye(2^12);
U = U*expm(-i*H*4e-6);
for ii = 1:Length
    Hext = 2*pi*(Amplitude*power1(ii)/100)*(X_C*cos(phase1(ii)/360*2*pi)+Y_C*sin(phase1(ii)/360*2*pi))+2*pi*(Amplitude*power2(ii)/100)*(X_H*cos(phase2(ii)/360*2*pi)+Y_H*sin(phase2(ii)/360*2*pi));
%     U_encoding80ms{ii} = expm(-i*(Hext+Hint)*dt);
    U = expm(-i*(Hext+H)*dt)*U;   
end
U = U*expm(-i*H*4e-6);

Utar = expm(-i*KIx{6}*pi/2);

Fidelity_C690 = abs(trace(U*Utar'))/2^12

save Fidelity_C690_minus_xplusy.mat Fidelity_C690
% rho_ini = KIz{1};
% rho_fin = U*rho_ini*U';
% rho_tar = Utar*rho_ini*Utar';
% Fidelity = trace(rho_fin*rho_tar)/32; % 
%Fidelity = abs(trace(U*U_grape'))/2^7

% save  U_encoding80ms.mat  U_encoding80ms