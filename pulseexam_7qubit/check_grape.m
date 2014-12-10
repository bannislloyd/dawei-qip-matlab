clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);

load Parameters_crotonic_plus.mat
Hint = H;

%the matrix Para contains all the chemical shifts and J-couplings of
%12-qubit sample
% [Para,H] = hamiltonian_7qubit;
% %% %%%%%%%%%%%%%%%%%% re-write the Hamilonian of the 7-qubit subsystem; set O1 %%%%%%%%%%%
% for ii = 1:7
%     w(ii) = Para(ii,ii);
% end
% for ii = 1:7
%     for jj = 1:7
%         J(ii,jj) = Para(ii,jj);
%     end
% end
% H = 0;
% O1 = 20696; % transmit frequency, the rotating frequency of the partially rotating frame
% 
% for ii = 1:7
%     H = H + (w(ii)-O1)*KIz{ii};
% end
% 
% for ii = 1:6
%     for jj = (ii+1):7
%         H = H + J(ii,jj)*(KIz{ii}*KIz{jj});
%     end
% end
% 
% Hint = 2*pi*H;
%% Parameters for the GRAPE pulse
Name = 'Crotonic_S2S_X4toZ4_NoZfree';
Amplitude = 25000;
Time = 500e-6;
Length = 250;
dt = Time/Length;
FirstLine = 21; % the first line which contains the information of power and phase 

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

% load Max_Us.mat
% Utar = Ut2t0;

rho_ini = KIx{4};
rho_fin = U*rho_ini*U';
rho_tar = KIz{4};
Fidelity = trace(rho_fin*rho_tar)/trace( rho_ini* rho_ini)
% Fidelity = abs(trace(U*Utar'))/2^4
