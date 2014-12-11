% simulation of the jump code model, without error correction
% 2 qubits, 1-ancilla, 2-system

clear;
theta = pi; % 0 to pi
phi = 0; % 0 to 2pi
% r = 0.2; % 0 to 1

% steps for theta and phi
number_theta = 0;
number_phi = 0;
%% Without Error Correction

% operators for 2 qubits
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(2);
STP = 1/sqrt(2)*[1;1]; STM = 1/sqrt(2)*[1;-1];

for ii = 1:41
    r = 1/40*(ii-1);

    Fidelity0 = 0;Fidelity1 = 0;
%     for theta = 0:pi/number_theta:pi
%         for phi = 0:2*pi/number_phi:2*pi
            
% initial state
System = (cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM)* (cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM)';
Input = MultiKron(2,ST0,System); 

% detected jump channel
A0 = [1,0;0,sqrt(1-r)]; A1 = [0,0;0,sqrt(r)];

% unitary operator
U = [1,0,0,0; 0, sqrt(1-r),0,sqrt(r);0,0,-1,0;0,sqrt(r),0,-sqrt(1-r)];

% state
rho_channel = U*Input*U';

% check the U, should be 1
% Input_Fidelity = trace((U*Input*U')*(kron(ST0,A0*System*A0') + kron(ST1,A1*System*A1')));

% projective measurement
M0 = kron(ST0, I); M1 = kron(ST1, I);
rho_projective0 = M0*rho_channel*M0'; % /trace(M0'*M0*rho_channel): normalization ignored.
% equal to  rho_echo = Gz_echo(rho_channel,2)

rho_sys0 = ptrace(rho_projective0, 1, [2 2]);

Fidelity0 = Fidelity0 + trace(System*rho_sys0); %/sqrt(trace(System*System)*trace(rho_sys*rho_sys));

rho_projective1 = M1*rho_channel*M1'; % /trace(M0'*M0*rho_channel): normalization ignored.
% equal to  rho_echo = Gz_echo(rho_channel,2)

rho_sys1 = ptrace(rho_projective1, 1, [2 2]);

Fidelity1 = Fidelity1 + trace(System*rho_sys1); %/sqrt(trace(System*System)*trace(rho_sys*rho_sys));
%         end
%     end
    Fidelity0 = Fidelity0/((number_phi+1)*(number_theta+1));
    Fidelity1 = Fidelity1/((number_phi+1)*(number_theta+1));

    Fid_no0(ii) = Fidelity0;
    Fid_no1(ii) = Fidelity1;
end


    
    Fid_no1+Fid_no0
