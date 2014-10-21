clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);

load Para.mat
Hint = H;

%% Parameters for the GRAPE pulse
Name = 'Cgate_ELGI.txt';
Amplitude = 6000;
Time = 55e-3;
Length = 5500;
dt = Time/Length;
FirstLine = 19; % the first line which contains the information of power and phase 

Output = 'test';

[power,phase]=dataout(Name,Output,FirstLine,Length);
%% Check
X = 0; Y = 0;
for jj = 1:4
    X = X + KIx{jj};
    Y = Y + KIy{jj};
end

U = eye(2^4);
 U = U*expm(-i*Hint*4e-6);
for ii = 1:Length
    Hext = 2*pi*(Amplitude*power(ii)/100)*(X*cos(phase(ii)/360*2*pi)-Y*sin(phase(ii)/360*2*pi));
    U = expm(-i*(Hext+Hint)*dt)*U;  
end

U = expm(-i*Hint*4e-6)*U;

load Cgate.mat
Utar = Cgate;

% Utar = rot(Y,pi/2);
%  rho_ini = KIz{1}+KIz{3};
%  rho_fin = U*rho_ini*U';
%  rho_tar = Utar*rho_ini*Utar';
%  Fidelity = trace(rho_fin*rho_tar)/trace( rho_ini* rho_ini)
Fidelity = abs(trace(U*Utar'))/2^4

plot(Amplitude*power/100)
% Uencoding_grape_80Iterations = U;
% save  Uencoding_grape_80Iterations.mat  Uencoding_grape_80Iterations