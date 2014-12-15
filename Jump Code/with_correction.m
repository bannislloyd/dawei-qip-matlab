% simulation of the jump code model, with error correction
% 4 qubits, 1,4-ancilla, 2,3-system

clear;
theta = 0; % 0 to pi
phi = 0; % 0 to 2pi
r = 0.2; % 0 to 1

% steps for theta and phi
% number_theta = 10;
% number_phi = 20;
%% With Error Correction

% operators for 4 qubits
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);
STP = 1/sqrt(2)*[1;1]; STM = 1/sqrt(2)*[1;-1];

% initial state
System = (cos(theta/2)*kron(STP,STP)+exp(i*phi)*sin(theta/2)*kron(STM,STM))* (cos(theta/2)*kron(STP,STP)+exp(i*phi)*sin(theta/2)*kron(STM,STM))';
Input = MultiKron(3,ST0,System,ST0); 

% detected jump channel
A0 = [1,0;0,sqrt(1-r)]; A1 = [0,0;0,sqrt(r)];

% unitary operator
U12 = [1,0,0,0; 0, sqrt(1-r),0,sqrt(r);0,0,-1,0;0,sqrt(r),0,-sqrt(1-r)];
U34 = CNOT(1,2,2)*CNOT(2,1,2)*CNOT(1,2,2)*U12*CNOT(1,2,2)*CNOT(2,1,2)*CNOT(1,2,2);
U = kron(U12,U34);

% state
rho_channel = U*Input*U';

% check the U, cannot be 1
%  Input_Fidelity = trace((U*Input*U')*(MultiKron(3, ST0, kron(A0,A0)*System*kron(A0,A0)',ST0) + MultiKron(3, ST0, kron(A0,A1)*System*kron(A0,A1)',ST1) +...
%      MultiKron(3, ST1, kron(A1,A0)*System*kron(A1,A0)',ST0) + MultiKron(3, ST1, kron(A1,A1)*System*kron(A1,A1)',ST1)))
 
% projective measurement
M00 = MultiKron(4,ST0, I, I, ST0); M01 = MultiKron(4,ST0, I, I, ST1); M10 = MultiKron(4,ST1, I, I, ST0); M11 = MultiKron(4,ST1, I, I, ST1);
rho_projective = M00*rho_channel*M00'; % /trace(M0'*M0*rho_channel): normalization ignored.
% equal to  rho_echo = Gz_echo(rho_channel,2)

rho_sys = ptrace(rho_projective, [1 4], [2 2 2 2])

V1 = eye(4); V2 = eye(4); V3 = Hadamard(1,2); V4 = Hadamard(2,2);
rho_correction = (V4*V3*CNOT(2,1,2)*V2*V1)*rho_sys*(V4*V3*CNOT(2,1,2)*V2*V1)'
M0 = kron(I, ST0); M1 = kron(I, ST1);
rho_correction = M0*rho_correction*M0';
rho_correction = ptrace(rho_correction, 2, [2 2])

Fidelity_no =  trace(System*rho_sys)
Fidelity_yes = trace((cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM)* (cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM)'*rho_correction)
















% test1 = kron([1;0],cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM);
% test2 = kron(cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM,[1;0]);
% U12*test1
% kron([1;0],A0*(cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM))+kron([0;1],A1*(cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM))
% U34*test2
% kron(A0*(cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM),[1;0])+kron(A1*(cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM),[0;1])

