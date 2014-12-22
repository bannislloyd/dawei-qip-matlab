clear;

%% Check all 90 rotations power
for spin_number = 1:7
Name1 = ['twqubit_C', num2str(spin_number), '180_C_25000.txt'];
Name2 = ['twqubit_C', num2str(spin_number), '180_H_25000.txt'];
Amplitude = 25000;
Time = 1e-3;
Length = 200;
dt = Time/Length;
FirstLine = 19; % the first line which contains the information of power and phase 

Output1 = 'test1';
Output2 = 'test2';

[power1,phase1]=dataout(Name1,Output1,FirstLine,Length);
[power2,phase2]=dataout(Name2,Output2,FirstLine,Length);

C_ratio(spin_number) = max(power1)
C_hertz(spin_number) = Amplitude * C_ratio(spin_number)/100
H_ratio(spin_number) = max(power2)
H_hertz(spin_number) = Amplitude * H_ratio(spin_number)/100

end
% rho_ini = KIz{1};
% rho_fin = U*rho_ini*U';
% rho_tar = Utar*rho_ini*Utar';
% Fidelity = trace(rho_fin*rho_tar)/32; % 
%Fidelity = abs(trace(U*U_grape'))/2^7

% save  U_encoding80ms.mat  U_encoding80ms
