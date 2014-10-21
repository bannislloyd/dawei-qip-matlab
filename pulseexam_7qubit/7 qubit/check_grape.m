clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);


%the matrix Para contains all the chemical shifts and J-couplings of
%12-qubit sample
[Para,H] = hamiltonian_7qubit_default;
%% %%%%%%%%%%%%%%%%%% re-write the Hamilonian of the 7-qubit subsystem; set O1 %%%%%%%%%%%
for ii = 1:7
    w(ii) = Para(ii,ii);
end
for ii = 1:7
    for jj = 1:7
        J(ii,jj) = Para(ii,jj);
    end
end
H = 0;
O1 = 20696; % transmit frequency, the rotating frequency of the partially rotating frame

for ii = 1:7
    H = H - (w(ii)-O1)*KIz{ii};
end

for ii = 1:6
    for jj = (ii+1):7
        H = H + J(ii,jj)*(KIz{ii}*KIz{jj});
    end
end

Hint = 2*pi*H;
%% Parameters for the GRAPE pulse
Name = 'I80ms';
Amplitude = 6000;
Time = 80000e-6;
Length = 4000;
dt = Time/Length;
FirstLine = 19; % the first line which contains the information of power and phase 

Output = 'test';

[power,phase]=dataout(Name,Output,FirstLine,Length);
%% Check
X = 0; Y = 0;
for jj = 1:7
    X = X + KIx{jj};
    Y = Y + KIy{jj};
end

% U_encoding80ms = cell(4000,1);

U = eye(2^7);
U = U*expm(-i*Hint*4e-6);
for ii = 1:Length
    Hext = 2*pi*(Amplitude*power(ii)/100)*(X*cos(phase(ii)/360*2*pi)+Y*sin(phase(ii)/360*2*pi));
% U_encoding80ms{ii} = expm(-i*(Hext+Hint)*dt);
    U = expm(-i*(Hext+Hint)*dt)*U;
   
end

 U = expm(-i*Hint*4e-6)*U;

% load U_encoding.mat
Utar = eye(2^7);

%%%% ground state %%%%%%%%%%
% U0=CNOT(4,7,7)*CNOT(7,4,7);
% U1=Hadamard(7,7)*Hadamard(2,7);
% U2=CNOT(7,4,7)*CNOT(7,6,7)*CNOT(7,5,7);
% U3=CNOT(2,7,7)*CNOT(2,1,7)*CNOT(2,3,7);
% U_total=U3*U2*U1*U0;
%%%%%%%%%%%%%%%%%%%%%


% Utar = rot(Y,pi/2);
%  rho_ini = KIx{1}*KIx{2}+0.2*KIx{3}+1.746*KIz{5};
%  rho_fin = U*rho_ini*U';
%  rho_tar = rho_ini;
%   AA = rho_fin-rho_ini;
%   Fidelity = trace(rho_fin*rho_tar)/trace( rho_ini* rho_ini)
Fidelity = abs(trace(U*Utar'))/2^7

% save crotonic_rho90.mat rho_tar

% Uencoding_grape_80Iterations = U;
% save  Uencoding_grape_80Iterations.mat  Uencoding_grape_80Iterations