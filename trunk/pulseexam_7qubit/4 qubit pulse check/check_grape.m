clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);

load Parameters_crotonic_plus.mat
Hint = H;

%% Parameters for the GRAPE pulse
Name = 'Croton_90x1.txt';
Amplitude = 6000;
Time = 1000e-6;
Length = 500;
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

phase = grape_phase(phase, 'X', '-Y');

U = eye(2^4);

U = U*expm(-i*Hint*4e-6);
for ii = 1:Length
    Hext = 2*pi*(Amplitude*power(ii)/100)*(X*cos(phase(ii)/360*2*pi)-Y*sin(phase(ii)/360*2*pi));
    U = expm(-i*(Hext+Hint)*dt)*U;  
end
U = expm(-i*Hint*4e-6)*U;

% load Max_Us.mat
 Utar = expm(i*pi/2*KIz{1})*expm(-i*pi/2*KIx{1})*expm(-i*pi/2*KIz{1});

% rho_ini = KIx{4};
% rho_fin = U*rho_ini*U';
% rho_tar = KIz{4};
% Fidelity = trace(rho_fin*rho_tar)/trace( rho_ini* rho_ini)
 Fidelity = abs(trace(U*Utar'))/2^4
