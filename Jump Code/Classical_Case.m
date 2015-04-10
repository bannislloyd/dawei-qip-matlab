%simulation of the jump code model for the classical case
%2 qubits, 1-ancilla, 2-system

clear;
number_r = 200;
%% Without Error Correction

% operators for 2 qubits
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(2);
STP = 1/sqrt(2)*[1;1]; STM = 1/sqrt(2)*[1;-1];

for ii = 1:(number_r+1)
    r = 1/number_r*(ii-1);
    r_para(ii) = 1/number_r*(ii-1);

    Fidelity0 = 0; Fidelity1 = 0;
    
% initial state; it can only be |+> or |-> in classical
System = STP*STP';
% System = STM*STM';
Input = MultiKron(2,ST0,System); 

% detected jump channel
A0 = [1,0;0,sqrt(1-r)]; A1 = [0,0;0,sqrt(r)];

% unitary operator
U = [1,0,0,0; 0, sqrt(1-r),0,sqrt(r);0,0,-1,0;0,sqrt(r),0,-sqrt(1-r)];

% state
rho_channel = U*Input*U';

% projective measurement
M0 = kron(ST0, I); M1 = kron(ST1, I);

rho_projective0 = M0*rho_channel*M0'; % if ST0 is detected on the ancilla
% equal to  rho_echo = Gz_echo(rho_channel,2), simulated by Gradient Echo
rho_sys0 = ptrace(rho_projective0, 1, [2 2]); % trace out ancilla
Fidelity0 = trace(System*rho_sys0); 

rho_projective1 = M1*rho_channel*M1';  % if ST1 is detected on the ancilla
% equal to  rho_echo = Gz_echo(rho_channel,2), simulated by Gradient Echo
rho_sys1 = ptrace(rho_projective1, 1, [2 2]); % trace out ancilla
Fidelity1 = trace(System*rho_sys1); 

    Fid_no0(ii) = Fidelity0;
    Fid_no1(ii) = Fidelity1;
end

%%% plot parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(r_para,Fid_no0+Fid_no1,'b')

fontsize = 14;

title({'Classical Case Without and With Correction'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

% legend('p(1\rightarrow 1)','p(1\rightarrow 2)','p(1\rightarrow 3)');
% set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal','FontSize',fontsize_legend);
%set(legend,'Color','none')

xlabel({'r'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'Fidelity'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

% set(gca,'ylim',[0.5 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
number_r = 100;
%% With Error Correction

% operators for 4 qubits
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);
STP = 1/sqrt(2)*[1;1]; STM = 1/sqrt(2)*[1;-1];

for ii = 1:(number_r+1)
    r = 1/number_r*(ii-1);
    r_para(ii) = 1/number_r*(ii-1);

    Fidelity00 = 0; Fidelity01 = 0; Fidelity10 = 0; Fidelity11 = 0;

% initial state
System = kron(STP,STP)*kron(STP,STP)';
Input = MultiKron(3,ST0,System,ST0); 

% detected jump channel
A0 = [1,0;0,sqrt(1-r)]; A1 = [0,0;0,sqrt(r)];

% unitary operator
U12 = [1,0,0,0; 0, sqrt(1-r),0,sqrt(r);0,0,-1,0;0,sqrt(r),0,-sqrt(1-r)];
U34 = [1,0,0,0; 0, -1,0,0;0,0,sqrt(1-r),sqrt(r);0,0,sqrt(r),-sqrt(1-r)];
%U34 = CNOT(1,2,2)*CNOT(2,1,2)*CNOT(1,2,2)*U12*CNOT(1,2,2)*CNOT(2,1,2)*CNOT(1,2,2);
U = kron(U12,U34);

% state
rho_channel = U*Input*U';

hada = 1/sqrt(2)*[1,1;1,1];
% projective measurement
M00 = MultiKron(4,ST0, I, I, ST0); M01 = MultiKron(4,ST0, I, I, ST1); M10 = MultiKron(4,ST1, I, I, ST0); M11 = MultiKron(4,ST1, I, I, ST1);

rho_projective00 = M00*rho_channel*M00'; 
rho_sys00 = ptrace(rho_projective00, [1 4], [2 2 2 2]);
Fidelity00 = abs(trace(System*rho_sys00));
% note we still have pf*p0 probability to succeed, because for the case +-
% and -+ we still have half chance to recover to ++
p0 = 1-r/2-0.25*(1-sqrt(1-r)).^2;
pf = 0.25*(1-sqrt(1-r)).^2;
Fidelity00 = Fidelity00 + pf*p0;

rho_projective01 = M01*rho_channel*M01'; 
rho_sys01 = ptrace(rho_projective01, [1 3 4], [2 2 2 2]); %discard the second qubit too as it happens A1
Fidelity01 = abs(trace(STP*STP'*rho_sys01));

rho_projective10 = M10*rho_channel*M10'; 
rho_sys10 = ptrace(rho_projective10, [1 2 4], [2 2 2 2]); %discard the first qubit too as it happens A1
Fidelity10 = abs(trace(STP*STP'*rho_sys10)); 

rho_projective11 = M11*rho_channel*M11'; 
rho_sys11 = ptrace(rho_projective11, [1 4], [2 2 2 2]);
rho_sys11 = kron(hada,hada)*rho_sys11*kron(hada,hada)'; % A1A1 happens and we get |11> at last. So we can use hadamard to go back and have half chance to succeed to |++>
Fidelity11 = 0.5*abs(trace(System*rho_sys11)); 

    Fid_no00(ii) = Fidelity00;
    Fid_no01(ii) = Fidelity01;
    Fid_no10(ii) = Fidelity10;
    Fid_no11(ii) = Fidelity11;
end

Fidelity = Fid_no00+Fid_no01+Fid_no10+Fid_no11;
%%% plot parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(r_para,Fidelity,'r')

legend('Classical Without Correction','Classical With Correction');
set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend);
set(legend,'Color','none')

% p0 = 1-r_para/2-0.25*(1-sqrt(1-r_para)).^2;
% pe = r_para/2;
% pf = 0.25*(1-sqrt(1-r_para)).^2;
%  p = p0.^2+p0.*pe+pe.*p0+pf.*p0+0.5*pe.^2;
%  hold on
%  plot(r_para,p,'g')
 
 % set(gca,'ylim',[0.5 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%