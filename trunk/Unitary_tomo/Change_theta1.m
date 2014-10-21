% U = [               sqrt(p)                                 sqrt(1-p)e^(i*theta2)
%          -sqrt(1-p)e^(i*theta3)              sqrt(p) e^(i*(theta2+theta3)) ] 

% set sqrt(p) = cos(theta1/2)

% equal to this sequence U = expm(-i*theta3*Iz)*expm(i*acos(sqrt(p))*2*Iy)*expm(-i*theta2*Iz);
%% change theta1
clear;
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(1); 

% consider T gate (pi/8 gate)
theta2 = pi/8; theta3 = pi/8;
rho1 = ST0; rho2 = 1/2*[1,1;1,1];
number = 40;

load expnorm1_0x.mat
load expnorm1_0z.mat
load expnorm1_+x.mat

for ii = 0:number
          theta1 = ii*2*pi/number;
%           U = [sqrt(p), -sqrt(1-p)*exp(i*theta2); sqrt(1-p)*exp(i*theta3), sqrt(p)*exp(i*(theta2+theta3))];
          U = expm(-i*theta3*Iz)*expm(i*theta1*Iy)*expm(-i*theta2*Iz);
          rho_out1 = U*rho1*U';
          rho_out2 = U*rho2*U';
          alpha1(ii+1) = trace(rho_out1*sigma_x);
          beta1(ii+1) = trace(rho_out1*sigma_y);
          gamma1(ii+1) = trace(rho_out1*sigma_z);
          alpha2(ii+1) = trace(rho_out2*sigma_x);
          beta2(ii+1) = trace(rho_out2*sigma_y);
end

theta1 = [0:2*pi/number:2*pi];

subplot(2,2,1);
plot(theta1,alpha1,'r','Linewidth',2);
hold on 
plot(theta1,beta1,'b','Linewidth',2);
hold on
plot(theta1,gamma1,'g','Linewidth',2)
hold on
plot(theta1,real(alpha2),'c','Linewidth',2);
hold on 
plot(theta1,real(beta2),'k','Linewidth',2);
hold on
plot(theta1,-exp1_0x,'rs','Linewidth',1);
hold on 
plot(theta1,exp1_0y,'bs','Linewidth',1);
hold on
plot(theta1,exp1_0z,'gs','Linewidth',1);
hold on
plot(theta1,exp1_px,'cs','Linewidth',1);
hold on 
plot(theta1,-exp1_py,'ks','Linewidth',1);
hold on

fontsize = 14;
fontsize_legend = 12;

title({'\theta2 = \pi/8, \theta3 = \pi/8'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

% legend('Tr(\rho_{out}^0 \sigma_x)','Tr(\rho_{out}^0 \sigma_y)','Tr(\rho_{out}^0 \sigma_z)','Tr(\rho_{out}^+ \sigma_x)','Tr(\rho_{out}^+ \sigma_y)');
% set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal','FontSize',fontsize_legend);
% set(legend,'Color','none','box','off','Position',[0.701914682539675 0.077455048409403 0.228571428571428 0.4])

xlabel({'\theta_1'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'<\sigma_n> = Tr(\rho_{out} \sigma_n)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');
set(gca,'Xlim',[0 2*pi],'Ylim',[-1.2 1.2],'XTick',[0:pi/2:2*pi],'XTickLabel',{'0','0.5¦Ð','¦Ð','1.5¦Ð','2¦Ð'},'FontName','Calibri','FontSize',fontsize);
% 

%% change theta2
clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(1); 

% consider T gate (pi/8 gate)
theta1 = pi/6; theta3 = pi/8;
rho1 = ST0; rho2 = 1/2*[1,1;1,1];
number = 40;

load expnorm2_0x.mat
load expnorm2_0z.mat
load expnorm2_+x.mat

for ii = 0:number
          theta2 = ii*2*pi/number;
%           U = [sqrt(p), -sqrt(1-p)*exp(i*theta2); sqrt(1-p)*exp(i*theta3), sqrt(p)*exp(i*(theta2+theta3))];
          U = expm(-i*theta3*Iz)*expm(i*theta1*Iy)*expm(-i*theta2*Iz);
          rho_out1 = U*rho1*U';
          rho_out2 = U*rho2*U';
          alpha1(ii+1) = trace(rho_out1*sigma_x);
          beta1(ii+1) = trace(rho_out1*sigma_y);
          gamma1(ii+1) = trace(rho_out1*sigma_z);
          alpha2(ii+1) = trace(rho_out2*sigma_x);
          beta2(ii+1) = trace(rho_out2*sigma_y);
end

theta2 = [0:2*pi/number:2*pi];

subplot(2,2,2);
plot(theta2,alpha1,'r','Linewidth',2);
hold on 
plot(theta2,beta1,'b','Linewidth',2);
hold on
plot(theta2,gamma1,'g','Linewidth',2)
hold on
plot(theta2,real(alpha2),'c','Linewidth',2);
hold on 
plot(theta2,real(beta2),'k','Linewidth',2);
hold on
plot(theta2,-exp2_0x,'rs','Linewidth',1);
hold on 
plot(theta2,exp2_0y,'bs','Linewidth',1);
hold on
plot(theta2,exp2_0z,'gs','Linewidth',1);
hold on
plot(theta2,exp2_px,'cs','Linewidth',1);
hold on 
plot(theta2,-exp2_py,'ks','Linewidth',1);
hold on

fontsize = 14;
fontsize_legend = 12;

title({'\theta1 = \pi/6, \theta3 = \pi/8'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

% legend('Tr(\rho_{out}^0 \sigma_x)','Tr(\rho_{out}^0 \sigma_y)','Tr(\rho_{out}^0 \sigma_z)','Tr(\rho_{out}^+ \sigma_x)','Tr(\rho_{out}^+ \sigma_y)');
% set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal','FontSize',fontsize_legend);
% set(legend,'Color','none','box','off','Position',[0.701914682539675 0.077455048409403 0.228571428571428 0.4])

xlabel({'\theta_2'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'<\sigma_n> = Tr(\rho_{out} \sigma_n)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');
set(gca,'Xlim',[0 2*pi],'Ylim',[-1.2 1.2],'XTick',[0:pi/2:2*pi],'XTickLabel',{'0','0.5¦Ð','¦Ð','1.5¦Ð','2¦Ð'},'FontName','Calibri','FontSize',fontsize);



%% change theta3
clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(1); 

% consider T gate (pi/8 gate)
theta1 = pi/6; theta2 = pi/8;
rho1 = ST0; rho2 = 1/2*[1,1;1,1];
number = 40;

load expnorm3_0x.mat
load expnorm3_0z.mat
load expnorm3_+x.mat

for ii = 0:number
          theta3 = ii*2*pi/number;
%           U = [sqrt(p), -sqrt(1-p)*exp(i*theta2); sqrt(1-p)*exp(i*theta3), sqrt(p)*exp(i*(theta2+theta3))];
          U = expm(-i*theta3*Iz)*expm(i*theta1*Iy)*expm(-i*theta2*Iz);
          rho_out1 = U*rho1*U';
          rho_out2 = U*rho2*U';
          alpha1(ii+1) = trace(rho_out1*sigma_x);
          beta1(ii+1) = trace(rho_out1*sigma_y);
          gamma1(ii+1) = trace(rho_out1*sigma_z);
          alpha2(ii+1) = trace(rho_out2*sigma_x);
          beta2(ii+1) = trace(rho_out2*sigma_y);
end

theta3 = [0:2*pi/number:2*pi];

subplot(2,2,3);
plot(theta3,alpha1,'r','Linewidth',2);
hold on 
plot(theta3,beta1,'b','Linewidth',2);
hold on
plot(theta3,gamma1,'g','Linewidth',2);
hold on
plot(theta3,real(alpha2),'c','Linewidth',2);
hold on 
plot(theta3,real(beta2),'k','Linewidth',2);
hold on
plot(theta3,-exp3_0x,'rs','Linewidth',1);
hold on 
plot(theta3,exp3_0y,'bs','Linewidth',1);
hold on
plot(theta3,exp3_0z,'gs','Linewidth',1);
hold on
plot(theta3,exp3_px,'cs','Linewidth',1);
hold on 
plot(theta3,exp3_py,'ks','Linewidth',1);
hold on

fontsize = 14;
fontsize_legend = 8;

title({'\theta1 = \pi/6, \theta2 = \pi/8'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

legend('Tr(\rho_{out}^0 \sigma_x)','Tr(\rho_{out}^0 \sigma_y)','Tr(\rho_{out}^0 \sigma_z)','Tr(\rho_{out}^+ \sigma_x)','Tr(\rho_{out}^+ \sigma_y)');
set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend);
set(legend,'Color','none','box','off','Position',[0.595486111111106 0.282295988934991 0.0366666666666666 0.104273858921162])

xlabel({'\theta_3'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'<\sigma_n> = Tr(\rho_{out} \sigma_n)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');
set(gca,'Xlim',[0 2*pi],'Ylim',[-1.2 1.2],'XTick',[0:pi/2:2*pi],'XTickLabel',{'0','0.5¦Ð','¦Ð','1.5¦Ð','2¦Ð'},'FontName','Calibri','FontSize',fontsize);
% 
% 
% % X=theta3(1:41)';
% % Y=-Y_exp';
% % s =fitoptions('Method','NonlinearLeastSquares','Lower',[-1,-1],'Upper',[1,1]);
% % f = fittype('a*(-sin(x))+b','options',s);
% % [c2,gof2] = fit(X,Y,f); 
% % c2  %???????
% % 
% % plot(theta3, -0.3873*sin(theta3))