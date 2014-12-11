% clear;
% [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);
% %% Initialize
% % system qubit
% psi_i = cell(1,100);
% jj = 1;
% for theta = (0):(pi/40):(pi/2-pi/40)
% psi_i{jj} = cos(theta)*[1;0]+sin(theta)*[0;1];
% 
% 
% % measuring device
% md_i = 1/sqrt(2)*([1;0]+[0;1]);
% % ancilla
% ancilla = 0.5*I;
% 
% temp = psi_i{jj};
% 
% rho_ini = kron(temp*temp',kron(md_i*md_i',ancilla));
% 
% %% Weak Measurement
% 
% 
% g = 0.1;
% 
% %measure_operator = 2*(cos(pi/4)*Iz+sin(pi/4)*Ix);
% measure_operator = 2*Ix;
% u_weak = expm(-i*2*g*kron(measure_operator,kron(I,I))*KIz{2});
% rho_weak = u_weak*rho_ini*u_weak';
% 
% %% Post Selection
% psi_f = [1;0]; % the post selection state of system is |0>
% 
% Toffoli = kron(I,kron(I,I))-kron(ST1,kron(I,ST1))+kron(ST1,kron(sigma_z,ST1));
%  % projective measurement operator
% rho_final = Toffoli*rho_weak*Toffoli'; % the final state after the projective measurement
% 
% weak_value(jj) = psi_f'*measure_operator*temp/(psi_f'*temp); % weak value by theoretical definition
% sigma_y_md = trace(rho_final*2*KIy{2});
% sigma_z_s = trace(rho_final*2*KIz{1});
% Re_weak_value(jj) = sigma_y_md/(sigma_z_s+1)/g; % Re of the weak value by measuring sigma_y on the device
% 
% jj = jj+1;
% end
% 
% theta = (0):(pi/40):(pi/2-pi/40)
% plot(theta,Re_weak_value,'bd-')
% hold on

%% theta = pi/2~pi
clear;
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);
%% Initialize
% system qubit
measure_operator = cell(1,100);
jj = 1;
theta = pi/4;
psi_i = cos(theta)*[1;0]+sin(theta)*[0;1];


% measuring device
md_i = 1/sqrt(2)*([1;0]+[0;1]);
% ancilla
ancilla = 0.5*I;


rho_ini = kron(psi_i*psi_i',kron(md_i*md_i',ancilla));

%% Weak Measurement


g = 0.1;
for alpha = 0:pi/40:pi/2
%measure_operator = 2*(cos(pi/4)*Iz+sin(pi/4)*Ix);
measure_operator{jj} = cos(alpha)*2*Ix+sin(alpha)*2*Iy;
temp = measure_operator{jj};
u_weak = expm(-i*2*g*kron(temp,kron(I,I))*KIz{2});
rho_weak = u_weak*rho_ini*u_weak';

%% Post Selection
psi_f = [1;0]; % the post selection state of system is |0>

Toffoli = kron(I,kron(I,I))-kron(ST1,kron(I,ST1))+kron(ST1,kron(sigma_z,ST1));
 % projective measurement operator
rho_final = Toffoli*rho_weak*Toffoli'; % the final state after the projective measurement

weak_value(jj) = psi_f'*temp*psi_i/(psi_f'*psi_i); % weak value by theoretical definition
sigma_y_md = trace(rho_final*2*KIy{2});
sigma_z_s = trace(rho_final*2*KIz{1});
Re_weak_value(jj) = sigma_y_md/(sigma_z_s+1)/g;% Re of the weak value by measuring sigma_y on the device

jj = jj+1;
end

alpha = 0:pi/40:pi/2
plot(alpha,real(Re_weak_value),'r*-')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set label and title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlabel({'\alpha (g=0.1)'},'FontWeight','normal','FontSize',14,...
    'FontName','Calibri');

ylabel({'weak value <cos\alpha\sigma_x+sin\alpha\sigma_y>'},'FontWeight','normal','FontSize',14,...
    'FontName','Calibri');

title({'Initial State cos(\pi/4)|0>+sin(\pi/4)|1>'},'FontWeight','normal','FontSize',14,...
   'FontName','Calibri',...
   'FontAngle','normal');

set(gca,'FontName','Calibri');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
