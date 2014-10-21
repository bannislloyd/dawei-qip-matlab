clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(2);

%% Initialize
% system qubit
theta = pi/4;
psi_i = cos(theta)*[1;0]+sin(theta)*[0;1];
% measuring device
md_i = 1/sqrt(2)*([1;0]+[0;1]);
% ancilla
%ancilla = I;

rho_ini = kron(psi_i*psi_i',md_i*md_i');
%rho_ini = kron(psi_i*psi_i',kron(md_i*md_i',ancilla));

%% Weak Measurement

g = 0.01;
measure_operator = 2*Ix;
u_weak = expm(-i*2*g*kron(measure_operator,I)*KIz{2});
rho_weak = u_weak*rho_ini*u_weak';

%% Post Selection
psi_f = [1;0]; % the post selection state of system is |0>

u_post = kron(psi_f*psi_f',I); % projective measurement operator
rho_final = u_post*rho_weak*u_post'/(trace(u_post*rho_weak*u_post')); % the final state after the projective measurement

weak_value = psi_f'*measure_operator*psi_i/(psi_f'*psi_i) % weak value by theoretical definition
sigma_y_md = trace(rho_final*2*KIy{2});
Re_weak_value = sigma_y_md/2/g % Re of the weak value by measuring sigma_y on the device