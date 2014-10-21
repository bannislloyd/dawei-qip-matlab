clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);

%% Initialize
% system qubit
theta = 1.4;
psi_i = cos(theta)*[1;0]+sin(theta)*[0;1];
% measuring device
md_i = 1/sqrt(2)*([1;0]+[0;1]);
% ancilla
ancilla = 0.5*I;

rho_ini = kron(psi_i*psi_i',kron(md_i*md_i',ancilla));

%% Weak Measurement
ii = 1;

for g=0.01:0.01:0.8

%measure_operator = 2*(cos(pi/4)*Iz+sin(pi/4)*Ix);
measure_operator = 2*Ix;
u_weak = expm(-i*2*g*kron(measure_operator,kron(I,I))*KIz{2});
rho_weak = u_weak*rho_ini*u_weak';

%% Post Selection
psi_f = [1;0]; % the post selection state of system is |0>

Toffoli = kron(I,kron(I,I))-kron(ST1,kron(I,ST1))+kron(ST1,kron(sigma_z,ST1));
 % projective measurement operator
rho_final = Toffoli*rho_weak*Toffoli'; % the final state after the projective measurement

weak_value(ii) = psi_f'*measure_operator*psi_i/(psi_f'*psi_i); % weak value by theoretical definition
sigma_y_md = trace(rho_final*2*KIy{2});
sigma_z_s = trace(rho_final*2*KIz{1});
Re_weak_value(ii) = sigma_y_md/(sigma_z_s+1)/g; % Re of the weak value by measuring sigma_y on the device

ii = ii+1;
end


xx = 0.01:0.01:0.8;
plot(xx,Re_weak_value,'Color',[0.4667 0.7647 0.3882],'Linewidth',2);
hold on
exp_g = [0.05 0.1 0.15 0.2 0.3 0.4 0.5 0.6 0.7];


A = cell(9,1);
A{1}= [4.5025 4.7884 4.9047 5.3949];
A{2} = [3.5395 4.0858 4.4718 4.3399];
A{3} = [2.9055 2.9164 2.9685 3.5469];
A{4} = [1.9180 2.0049 2.1429 2.6475];
A{5} = [0.9985 1.0046 1.1530 1.4485];
A{6} = [0.4753 0.8450 0.9479 1.0619];
A{7} = [0.3630 0.3849 0.5116 0.5929];
A{8} = [0.2256 0.3141 0.3966 0.4197];
A{9} = [0.2181 0.2335 0.3211 0.4152];

for jj = 1:9
    exp_weak(jj) = mean(A{jj});
    bound(jj) = std(A{jj});
end


errorbar(exp_g,exp_weak,bound,'MarkerSize',5.5,...
    'Marker','^',...
    'LineWidth',1.2,...
    'LineStyle','none','Color',[0.8 0 0.8]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% theta = 1.2
%% Initialize
% system qubit
theta = 1.2;
psi_i = cos(theta)*[1;0]+sin(theta)*[0;1];
% measuring device
md_i = 1/sqrt(2)*([1;0]+[0;1]);
% ancilla
ancilla = 0.5*I;

rho_ini = kron(psi_i*psi_i',kron(md_i*md_i',ancilla));

%% Weak Measurement
ii = 1;

for g=0.01:0.01:0.8

%measure_operator = 2*(cos(pi/4)*Iz+sin(pi/4)*Ix);
measure_operator = 2*Ix;
u_weak = expm(-i*2*g*kron(measure_operator,kron(I,I))*KIz{2});
rho_weak = u_weak*rho_ini*u_weak';

%% Post Selection
psi_f = [1;0]; % the post selection state of system is |0>

Toffoli = kron(I,kron(I,I))-kron(ST1,kron(I,ST1))+kron(ST1,kron(sigma_z,ST1));
 % projective measurement operator
rho_final = Toffoli*rho_weak*Toffoli'; % the final state after the projective measurement

weak_value(ii) = psi_f'*measure_operator*psi_i/(psi_f'*psi_i); % weak value by theoretical definition
sigma_y_md = trace(rho_final*2*KIy{2});
sigma_z_s = trace(rho_final*2*KIz{1});
Re_weak_value(ii) = sigma_y_md/(sigma_z_s+1)/g; % Re of the weak value by measuring sigma_y on the device

ii = ii+1;
end


xx = 0.01:0.01:0.8;
plot(xx,Re_weak_value,'Color',[0.4 0.4 1],'Linewidth',2)
hold on


C = cell(9,1);
C{1} = [2.5017 2.7460 2.1292 1.9398];
C{2} = [2.6963 2.1570 1.8048 2.1642];
C{3} = [1.7926 2.3323 2.1250 1.9324];
C{4} = [2.0649 2.1326 1.7236 1.7221];
C{5} = [1.3463 1.3722 1.5774 1.7823];
C{6} = [1.0142 1.1584 1.4705 1.2875];
C{7} = [0.8181 0.8082 0.9415 0.5946];
C{8} = [0.6910 0.7300 0.5072 0.5501];
C{9} = [0.5439 0.4976 0.5792 0.6364];

for jj = 1:9
    exp_weak3(jj) = mean(C{jj});
    bound3(jj) = std(C{jj});
end


errorbar(exp_g,exp_weak3,bound3,'MarkerSize',5.5,...
    'Marker','x',...
    'LineWidth',1.2,...
    'LineStyle','none','Color',[1 0 0]);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% theta = 0.9
% %% Initialize
% % system qubit
% theta = 0.9;
% psi_i = cos(theta)*[1;0]+sin(theta)*[0;1];
% % measuring device
% md_i = 1/sqrt(2)*([1;0]+[0;1]);
% % ancilla
% ancilla = 0.5*I;
% 
% rho_ini = kron(psi_i*psi_i',kron(md_i*md_i',ancilla));
% 
% %% Weak Measurement
% ii = 1;
% 
% for g=0.01:0.02:0.9
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
% weak_value(ii) = psi_f'*measure_operator*psi_i/(psi_f'*psi_i); % weak value by theoretical definition
% sigma_y_md = trace(rho_final*2*KIy{2});
% sigma_z_s = trace(rho_final*2*KIz{1});
% Re_weak_value(ii) = sigma_y_md/(sigma_z_s+1)/g; % Re of the weak value by measuring sigma_y on the device
% 
% ii = ii+1;
% end
% 
% 
% xx = 0.01:0.02:0.9;
% plot(xx,Re_weak_value,'g*-')
% hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% theta = pi/4
%% Initialize
% system qubit
theta = pi/4;
psi_i = cos(theta)*[1;0]+sin(theta)*[0;1];
% measuring device
md_i = 1/sqrt(2)*([1;0]+[0;1]);
% ancilla
ancilla = 0.5*I;

rho_ini = kron(psi_i*psi_i',kron(md_i*md_i',ancilla));

%% Weak Measurement
ii = 1;

for g=0.01:0.01:0.8

%measure_operator = 2*(cos(pi/4)*Iz+sin(pi/4)*Ix);
measure_operator = 2*Ix;
u_weak = expm(-i*2*g*kron(measure_operator,kron(I,I))*KIz{2});
rho_weak = u_weak*rho_ini*u_weak';

%% Post Selection
psi_f = [1;0]; % the post selection state of system is |0>

Toffoli = kron(I,kron(I,I))-kron(ST1,kron(I,ST1))+kron(ST1,kron(sigma_z,ST1));
 % projective measurement operator
rho_final = Toffoli*rho_weak*Toffoli'; % the final state after the projective measurement

weak_value(ii) = psi_f'*measure_operator*psi_i/(psi_f'*psi_i); % weak value by theoretical definition
sigma_y_md = trace(rho_final*2*KIy{2});
sigma_z_s = trace(rho_final*2*KIz{1});
Re_weak_value(ii) = sigma_y_md/(sigma_z_s+1)/g; % Re of the weak value by measuring sigma_y on the device

ii = ii+1;
end


xx = 0.01:0.01:0.8;
plot(xx,Re_weak_value,'Linewidth',2,'Color',[1 0.8 0.4])

hold on

B = cell(9,1);
B{1}= [1.1747 0.7348 0.9516 1.3182];
B{2} = [1.0177 0.8947 1.1958 1.1131];
B{3} = [0.9482 1.1943 1.1079 0.9807];
B{4} = [1.0038 1.1362 0.8740 0.8770];
B{5} = [0.9519 0.9973 0.8222 1.0025];
B{6} = [1.0448 1.0572 0.7764 0.9151];
B{7} = [0.7915 0.9731 0.6772 0.7713];
B{8} = [0.7689 0.7381 0.9598 0.6783];
B{9} = [0.8044 0.8528 0.5013 0.6098];

for jj = 1:9
    exp_weak2(jj) = mean(B{jj});
    bound2(jj) = std(B{jj});
end


errorbar(exp_g,exp_weak2,bound2,'MarkerSize',5.5,...
    'Marker','d',...
    'LineWidth',1.2,...
    'LineStyle','none','Color',[0.3804 0.3804 0.3804]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set label and title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% legend('\theta = 1.5','\theta = 1.2','\theta = 0.9','\theta = 0.6');
% 
% set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal');
legend('\theta = 1.4 (Theo)','\theta = 1.4 (Exp)','\theta = 1.2 (Theo)','\theta = 1.2 (Exp)','\theta = \pi/4 (Theo)','\theta = \pi/4 (Exp)');

set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal');

xlabel({'g'},'FontWeight','normal','FontSize',14,...
    'FontName','Calibri');

ylabel({'weak value <\sigma_x>'},'FontWeight','normal','FontSize',14,...
    'FontName','Calibri');

title({'Initial State cos\theta|0>+sin\theta|1>'},'FontWeight','normal','FontSize',14,...
   'FontName','Calibri',...
   'FontAngle','normal');

set(gca,'FontName','Calibri');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%