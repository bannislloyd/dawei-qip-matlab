clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(1);

Input = Iz;

%%%%%%%%%% max rf inhomogeniety and step size %%%%%%%%%%%%%%%
inhomo = 0.1;
inhomo_step = 0.0005;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Number of Loop %%%%%%%%%%%%%%%
Loop = 64;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rfsel_p %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kk = 1;
for epsi = 0:inhomo_step:inhomo

%%%%%%%%%% Rx(pi/2) - { Rx(-pi)}^Loop %%%%%%%%%%%%%%%
   P = expm(-i*Ix*pi/2*(1+epsi))*Input*expm(-i*Ix*pi/2*(1+epsi))';
   for ii = 1:Loop
       P = expm(i*Ix*pi*(1+epsi))*P*expm(i*Ix*pi*(1+epsi))';
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% { Rphi(pi) - R-phi(pi)}^Loop %%%%%%%%%%%%%%%
load phi64.mat
phi = phi*2*pi/360;


   for jj = 1:Loop
       P = expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi))*P*(expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi)))';
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Ry(pi/2) %%%%%%%%%%%%%%%
P = expm(-i*Iy*pi/2*(1+epsi))*P*expm(-i*Iy*pi/2*(1+epsi))';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Value of Map on each axis %%%%%%%%%%%%%%%
Signal_pz(kk) = 2*trace(P*Iz);
Signal_px(kk) = 2*trace(P*Ix);
Signal_py(kk) = 2*trace(P*Iy);
kk = kk+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

Pout_rfsel_p = P;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rfsel_n %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kk = 1;
for epsi = 0:inhomo_step:inhomo

%%%%%%%%%% Rx(pi/2) - { Rx(-pi)}^Loop %%%%%%%%%%%%%%%
P = expm(-i*Ix*pi/2*(1+epsi))*Input*expm(-i*Ix*pi/2*(1+epsi))';
for ii = 1:Loop
    P = expm(i*Ix*pi*(1+epsi))*P*expm(i*Ix*pi*(1+epsi))';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% { Rphi(pi) - R-phi(pi)}^Loop %%%%%%%%%%%%%%%
load phi64.mat
phi = -phi*2*pi/360;


for jj = 1:Loop
    P = expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi))*P*(expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi)))';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Ry(pi/2) %%%%%%%%%%%%%%%
P = expm(-i*Iy*pi/2*(1+epsi))*P*expm(-i*Iy*pi/2*(1+epsi))';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Value of Map on each axis %%%%%%%%%%%%%%%
Signal_nz(kk) = 2*trace(P*Iz);
Signal_nx(kk) = 2*trace(P*Ix);
Signal_ny(kk) = 2*trace(P*Iy);
kk = kk+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

Pout_rfsel_n = P;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% plot(0:(inhomo_step*100):(inhomo*100),(real(Signal_pz)),'g--');
% hold on
% plot(0:(inhomo_step*100):(inhomo*100),(real(Signal_nz)),'k:');
% hold on
plot(0:(inhomo_step*100):(inhomo*100),(real(Signal_pz-Signal_nz)),'b');
hold on




%%%%%%%%%% Number of Loop %%%%%%%%%%%%%%%
Loop = 32;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rfsel_p %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kk = 1;
for epsi = 0:inhomo_step:inhomo

%%%%%%%%%% Rx(pi/2) - { Rx(-pi)}^Loop %%%%%%%%%%%%%%%
   P = expm(-i*Ix*pi/2*(1+epsi))*Input*expm(-i*Ix*pi/2*(1+epsi))';
   for ii = 1:Loop
       P = expm(i*Ix*pi*(1+epsi))*P*expm(i*Ix*pi*(1+epsi))';
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% { Rphi(pi) - R-phi(pi)}^Loop %%%%%%%%%%%%%%%
load phi32.mat
phi = phi*2*pi/360;

   for jj = 1:Loop
       P = expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi))*P*(expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi)))';
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Ry(pi/2) %%%%%%%%%%%%%%%
P = expm(-i*Iy*pi/2*(1+epsi))*P*expm(-i*Iy*pi/2*(1+epsi))';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Value of Map on each axis %%%%%%%%%%%%%%%
Signal_pz(kk) = 2*trace(P*Iz);
Signal_px(kk) = 2*trace(P*Ix);
Signal_py(kk) = 2*trace(P*Iy);
kk = kk+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

Pout_rfsel_p = P;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rfsel_n %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kk = 1;
for epsi = 0:inhomo_step:inhomo

%%%%%%%%%% Rx(pi/2) - { Rx(-pi)}^Loop %%%%%%%%%%%%%%%
P = expm(-i*Ix*pi/2*(1+epsi))*Input*expm(-i*Ix*pi/2*(1+epsi))';
for ii = 1:Loop
    P = expm(i*Ix*pi*(1+epsi))*P*expm(i*Ix*pi*(1+epsi))';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% { Rphi(pi) - R-phi(pi)}^Loop %%%%%%%%%%%%%%%
load phi32.mat
phi = -phi*2*pi/360;

for jj = 1:Loop
    P = expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi))*P*(expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi)))';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Ry(pi/2) %%%%%%%%%%%%%%%
P = expm(-i*Iy*pi/2*(1+epsi))*P*expm(-i*Iy*pi/2*(1+epsi))';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Value of Map on each axis %%%%%%%%%%%%%%%
Signal_nz(kk) = 2*trace(P*Iz);
Signal_nx(kk) = 2*trace(P*Ix);
Signal_ny(kk) = 2*trace(P*Iy);
kk = kk+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

Pout_rfsel_n = P;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% plot(0:(inhomo_step*100):(inhomo*100),(real(Signal_pz)),'g');
% hold on
% plot(0:(inhomo_step*100):(inhomo*100),(real(Signal_nz)),'k');
hold on
plot(0:(inhomo_step*100):(inhomo*100),(real(Signal_pz-Signal_nz)),'r--');

% %%%%%%%%%% Number of Loop %%%%%%%%%%%%%%%
% Loop = 4;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rfsel_p %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kk = 1;
% for epsi = 0:inhomo_step:inhomo
% 
% %%%%%%%%%% Rx(pi/2) - { Rx(-pi)}^Loop %%%%%%%%%%%%%%%
%    P = expm(-i*Ix*pi/2*(1+epsi))*Input*expm(-i*Ix*pi/2*(1+epsi))';
%    for ii = 1:Loop
%        P = expm(i*Ix*pi*(1+epsi))*P*expm(i*Ix*pi*(1+epsi))';
%    end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%% { Rphi(pi) - R-phi(pi)}^Loop %%%%%%%%%%%%%%%
% 
% for jj = 1:Loop
%     phi(jj) = pi/8/Loop;
% end
% 
%    for jj = 1:Loop
%        P = expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi))*P*(expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi)))';
%    end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%% Ry(pi/2) %%%%%%%%%%%%%%%
% P = expm(-i*Iy*pi/2*(1+epsi))*P*expm(-i*Iy*pi/2*(1+epsi))';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%% Value of Map on each axis %%%%%%%%%%%%%%%
% Signal_pz(kk) = 2*trace(P*Iz);
% Signal_px(kk) = 2*trace(P*Ix);
% Signal_py(kk) = 2*trace(P*Iy);
% kk = kk+1;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% end
% 
% Pout_rfsel_p = P;
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rfsel_n %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kk = 1;
% for epsi = 0:inhomo_step:inhomo
% 
% %%%%%%%%%% Rx(pi/2) - { Rx(-pi)}^Loop %%%%%%%%%%%%%%%
% P = expm(-i*Ix*pi/2*(1+epsi))*Input*expm(-i*Ix*pi/2*(1+epsi))';
% for ii = 1:Loop
%     P = expm(i*Ix*pi*(1+epsi))*P*expm(i*Ix*pi*(1+epsi))';
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%% { Rphi(pi) - R-phi(pi)}^Loop %%%%%%%%%%%%%%%
% for jj = 1:Loop
%     phi(jj) = pi/8/Loop;
% end
% 
% for jj = 1:Loop
%     P = expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi))*P*(expm(-i*pi*(cos(-phi(jj))*Ix+sin(-phi(jj))*Iy)*(1+epsi))*expm(-i*pi*(cos(phi(jj))*Ix+sin(phi(jj))*Iy)*(1+epsi)))';
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%% Ry(pi/2) %%%%%%%%%%%%%%%
% P = expm(-i*Iy*pi/2*(1+epsi))*P*expm(-i*Iy*pi/2*(1+epsi))';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%% Value of Map on each axis %%%%%%%%%%%%%%%
% Signal_nz(kk) = 2*trace(P*Iz);
% Signal_nx(kk) = 2*trace(P*Ix);
% Signal_ny(kk) = 2*trace(P*Iy);
% kk = kk+1;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% end
% 
% Pout_rfsel_n = P;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% % plot(0:(inhomo_step*100):(inhomo*100),(real(Signal_pz)),'g');
% % hold on
% % plot(0:(inhomo_step*100):(inhomo*100),(real(Signal_nz)),'k');
% hold on
% plot(0:(inhomo_step*100):(inhomo*100),(real(Signal_pz-Signal_nz)),'r--');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set label and title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlabel({'RF Inhomogeneity (%)'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri');

ylabel({'Amount of Signal'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri');

title({'rf selection'},'FontWeight','bold','FontSize',14,...
    'FontName','Times New Roman',...
    'FontAngle','normal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set legend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% legend('rfsel64','rfsel32');
legend('rfsel64p','rfsel64n','rfsel64p-rfsel64n');

set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','bold');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%