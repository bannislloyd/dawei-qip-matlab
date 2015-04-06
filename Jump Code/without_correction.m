% simulation of the jump code model, without error correction
% 2 qubits, 1-ancilla, 2-system
% 
% clear;
% theta = 0; % 0 to pi
% phi = 0; % 0 to 2pi
% % r = 0.2; % 0 to 1
% 
% % steps for theta and phi
% number_theta = 0;
% number_phi = 0;
% %% Without Error Correction
% 
% % operators for 2 qubits
% [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(2);
% STP = 1/sqrt(2)*[1;1]; STM = 1/sqrt(2)*[1;-1];
% 
% for ii = 1:41
%     r = 1/40*(ii-1);
%     r_para(ii) = 1/40*(ii-1);
% 
%     Fidelity0 = 0; Fidelity1 = 0;
% %     for theta = 0:pi/number_theta:pi
% %         for phi = 0:2*pi/number_phi:2*pi
%             
% % initial state
% System = (cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM)* (cos(theta/2)*STP+exp(i*phi)*sin(theta/2)*STM)';
% Input = MultiKron(2,ST0,System); 
% 
% % detected jump channel
% A0 = [1,0;0,sqrt(1-r)]; A1 = [0,0;0,sqrt(r)];
% 
% % unitary operator
% U = [1,0,0,0; 0, sqrt(1-r),0,sqrt(r);0,0,1,0;0,sqrt(r),0,sqrt(1-r)];
% 
% % state
% rho_channel = U*Input*U';
% 
% % check the U, should be 1
% % Input_Fidelity = trace((U*Input*U')*(kron(ST0,A0*System*A0') + kron(ST1,A1*System*A1')));
% 
% % projective measurement
% M0 = kron(ST0, I); M1 = kron(ST1, I);
% rho_projective0 = M0*rho_channel*M0'; % /trace(M0'*M0*rho_channel): normalization ignored.
% % equal to  rho_echo = Gz_echo(rho_channel,2)
% 
% rho_sys0 = ptrace(rho_projective0, 1, [2 2]);
% 
% Fidelity0 = Fidelity0 + trace(System*rho_sys0); %/sqrt(trace(System*System)*trace(rho_sys*rho_sys));
% 
% rho_projective1 = M1*rho_channel*M1'; % /trace(M0'*M0*rho_channel): normalization ignored.
% % equal to  rho_echo = Gz_echo(rho_channel,2)
% 
% rho_sys1 = ptrace(rho_projective1, 1, [2 2]);
% 
% Fidelity1 = Fidelity1 + trace(System*rho_sys1); %/sqrt(trace(System*System)*trace(rho_sys*rho_sys));
% %         end
% %     end
%     Fidelity0 = Fidelity0/((number_phi+1)*(number_theta+1));
%     Fidelity1 = Fidelity1/((number_phi+1)*(number_theta+1));
% 
%     Fid_no0(ii) = Fidelity0;
%     Fid_no1(ii) = Fidelity1;
% end
% 
% %%% plot parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot(r_para,Fid_no0+Fid_no1)
% 
% fontsize = 14;
% 
% title({'Classical Case Without Correction'},'FontWeight','normal','FontSize',fontsize,...
%    'FontName','Calibri',...
%    'FontAngle','normal');
% 
% % legend('p(1\rightarrow 1)','p(1\rightarrow 2)','p(1\rightarrow 3)');
% % set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
% %     'LineWidth',2,...
% %     'FontWeight','normal','FontSize',fontsize_legend);
% %set(legend,'Color','none')
% 
% xlabel({'r'},'FontWeight','normal','FontSize',fontsize,...
%     'FontName','Calibri');
% 
% ylabel({'fidelity'},'FontWeight','normal','FontSize',fontsize,...
%     'FontName','Calibri');
% 
% set(gca,'ylim',[0.5 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
theta = 0; % 0 to pi
phi = 0; % 0 to 2pi
% r = 0.2; % 0 to 1

% steps for theta and phi
number_theta = 0;
number_phi = 0;
%% With Error Correction

% operators for 4 qubits
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);
STP = 1/sqrt(2)*[1;1]; STM = 1/sqrt(2)*[1;-1];

for ii = 1:41
    r = 1/40*(ii-1);
    r_para(ii) = 1/40*(ii-1);

    Fidelity00 = 0; Fidelity01 = 0; Fidelity10 = 0; Fidelity11 = 0;

% initial state
System = (cos(theta/2)*kron(STP,STP)+exp(i*phi)*sin(theta/2)*kron(STM,STM))* (cos(theta/2)*kron(STP,STP)+exp(i*phi)*sin(theta/2)*kron(STM,STM))';
Input = MultiKron(3,ST0,System,ST0); 

% detected jump channel
A0 = [1,0;0,sqrt(1-r)]; A1 = [0,0;0,sqrt(r)];

% unitary operator
U12 = [1,0,0,0; 0, sqrt(1-r),0,sqrt(r);0,0,1,0;0,sqrt(r),0,sqrt(1-r)];
U34 = CNOT(1,2,2)*CNOT(2,1,2)*CNOT(1,2,2)*U12*CNOT(1,2,2)*CNOT(2,1,2)*CNOT(1,2,2);
U = kron(U12,U34);

% state
rho_channel = U*Input*U';

% projective measurement
M00 = MultiKron(4,ST0, I, I, ST0); M01 = MultiKron(4,ST0, I, I, ST1); M10 = MultiKron(4,ST1, I, I, ST0); M11 = MultiKron(4,ST1, I, I, ST1);
rho_projective00 = M00*rho_channel*M00'; % /trace(M0'*M0*rho_channel): normalization ignored.
% equal to  rho_echo = Gz_echo(rho_channel,2)
rho_sys00 = ptrace(rho_projective00, [1 4], [2 2 2 2]);
V1 = eye(4); V2 = eye(4); V3 = Hadamard(1,2); V4 = Hadamard(2,2);
rho_correction00 = (V4*V3*CNOT(2,1,2)*V2*V1)*rho_sys00*(V4*V3*CNOT(2,1,2)*V2*V1)'
Fidelity00 = Fidelity00 + abs(trace(System*rho_correction00)); %/sqrt(trace(System*System)*trace(rho_sys*rho_sys));

rho_projective01 = M01*rho_channel*M01'; % /trace(M0'*M0*rho_channel): normalization ignored.
% equal to  rho_echo = Gz_echo(rho_channel,2)
rho_sys01 = ptrace(rho_projective01, [1 4], [2 2 2 2]);
V1 = eye(4); V2 = eye(4); V3 = Hadamard(1,2)*kron(I, sigma_x); V4 = eye(4);
rho_correction01 = (V4*V3*CNOT(2,1,2)*V2*V1)*rho_sys01*(V4*V3*CNOT(2,1,2)*V2*V1)'
Fidelity01 = Fidelity01 + abs(trace(System*rho_correction01)); %/sqrt(trace(System*System)*trace(rho_sys*rho_sys));

rho_projective10 = M10*rho_channel*M10'; % /trace(M0'*M0*rho_channel): normalization ignored.
% equal to  rho_echo = Gz_echo(rho_channel,2)
rho_sys10 = ptrace(rho_projective10, [1 4], [2 2 2 2]);
V1 = eye(4); V2 = eye(4); V3 = Hadamard(1,2)*kron(I, sigma_x); V4 = Hadamard(2,2);
rho_correction10 = (V4*V3*CNOT(2,1,2)*V2*V1)*rho_sys10*(V4*V3*CNOT(2,1,2)*V2*V1)'
Fidelity10 = Fidelity10 + abs(trace(System*rho_correction10)); %/sqrt(trace(System*System)*trace(rho_sys*rho_sys));

rho_projective11 = M11*rho_channel*M11'; % /trace(M0'*M0*rho_channel): normalization ignored.
% equal to  rho_echo = Gz_echo(rho_channel,2)
rho_sys11 = ptrace(rho_projective11, [1 4], [2 2 2 2]);
V1 = eye(4); V2 = Hadamard(2,2); V3 = eye(4); V4 = eye(4);
rho_correction11 = (V4*V3*CNOT(2,1,2)*V2*V1)*rho_sys11*(V4*V3*CNOT(2,1,2)*V2*V1)'
Fidelity11 = Fidelity11 + abs(trace(System*rho_correction11)); %/sqrt(trace(System*System)*trace(rho_sys*rho_sys));

    Fid_no00(ii) = Fidelity00;
    Fid_no01(ii) = Fidelity01;
    Fid_no10(ii) = Fidelity10;
    Fid_no11(ii) = Fidelity11;
end

Fidelity = Fid_no00+Fid_no01+Fid_no10+Fid_no11;
%%% plot parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(r_para,Fidelity,'r')

fontsize = 14;

title({'Classical Case Without Correction'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

% legend('p(1\rightarrow 1)','p(1\rightarrow 2)','p(1\rightarrow 3)');
% set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal','FontSize',fontsize_legend);
%set(legend,'Color','none')

xlabel({'r'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'fidelity'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%