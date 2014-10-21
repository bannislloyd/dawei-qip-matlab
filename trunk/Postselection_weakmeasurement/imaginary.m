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
measure_operator{jj} = cos(alpha)*2*Ix-sin(alpha)*2*Iy;
temp = measure_operator{jj};
u_weak = expm(-i*2*g*kron(temp,kron(I,I))*KIz{2});
rho_weak = u_weak*rho_ini*u_weak';

%% Post Selection
psi_f = [1;0]; % the post selection state of system is |0>

Toffoli = kron(I,kron(I,I))-kron(ST1,kron(I,ST1))+kron(ST1,kron(sigma_x,ST1));
 % projective measurement operator
rho_final = Toffoli*rho_weak*Toffoli'; % the final state after the projective measurement

weak_value(jj) = psi_f'*temp*psi_i/(psi_f'*psi_i); % weak value by theoretical definition
sigma_y_md = trace(rho_final*2*KIy{2});
sigma_z_md = trace(rho_final*2*KIz{2});
sigma_z_s = trace(rho_final*2*KIz{1});
Re_weak_value(jj) = sigma_y_md/(sigma_z_s+1)/g;% Re of the weak value by measuring sigma_y on the device
Im_weak_value(jj) = sigma_z_md/(sigma_z_s+1)/g;

jj = jj+1;
end

%subplot('Position',[0.1253 0.5527 0.775 0.35]);
alpha = 0:pi/40:pi/2;
plot(alpha,real(Re_weak_value),'Linewidth',2,'Color',[1 0.4 0.4])
hold on
plot(alpha,real(Im_weak_value),'Color',[0.4 0.4 1],'Linewidth',2)
hold on

A = cell(9,1);
A{1} = [1.0177 0.7947 1.0958 1.1131];
A{2} = [0.8570 0.9399 1.0312 1.0796];
A{3} = [0.7624 0.9276 0.8000 0.9168];
A{4} = [0.7255 0.7974 0.9054 0.6675];
A{5} = [0.6500 0.5479 0.7738 0.7962];
A{6} = [0.4426 0.6697 0.4353 0.4308];
A{7} = [0.3512 0.3395 0.3737 0.4921];
A{8} = [0.2891 0.2484 0.0859 0.1787];
A{9} = [0.0868 -0.1347 0.1313 0.0967];

for jj = 1:9
    exp_weak(jj) = mean(A{jj});
    bound(jj) = std(A{jj});
end
exp_alpha = 0:pi/16:pi/2;
errorbar(exp_alpha,exp_weak,bound,'MarkerSize',5.5,...
    'Marker','d',...
    'LineWidth',1.2,...
    'LineStyle','none','Color',[1 0.4 0.4]);
hold on
B = cell(9,1);
B{1} = [0.0791 0.0114 -0.0187 -0.0510];
B{2} = [0.0388 0.0773 0.1295 0.2149];
B{3} = [0.2421 0.4492 0.3267 0.2925];
B{4} = [0.4947 0.2968 0.5601 0.4947];
B{5} = [0.7414 0.6483 0.6295 0.5479];
B{6} = [0.8724 0.5544 0.8352 0.7352];
B{7} = [0.9126 1.0151 0.7266 0.8371];
B{8} = [0.9366 0.7588 1.0877 0.8644];
B{9} = [0.7860 0.9847 1.0958 1.0131];

for jj = 1:9
    exp_weak2(jj) = mean(B{jj});
    bound2(jj) = std(B{jj});
end
exp_alpha = 0:pi/16:pi/2;
errorbar(exp_alpha,exp_weak2,bound2,'MarkerSize',5.5,...
    'Marker','o',...
    'LineWidth',1.2,...
    'LineStyle','none','Color',[0.4 0.4 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set label and title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlabel({'\alpha (g=0.1)'},'FontWeight','normal','FontSize',24,...
    'FontName','Calibri');

ylabel({'weak value <cos\alpha\sigma_x-sin\alpha\sigma_y>'},'FontWeight','normal','FontSize',24,...
    'FontName','Calibri');

title({'Initial State cos(\pi/4)|0>+sin(\pi/4)|1>'},'FontWeight','normal','FontSize',24,...
   'FontName','Calibri',...
   'FontAngle','normal');

legend('Real','Imag');

set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',22);

set(gca,'xlim',[-0.1 1.67],'ylim',[-0.1 1.3],'FontName','Calibri','FontSize',24);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

