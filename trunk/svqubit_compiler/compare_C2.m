clear;

%12.2263


load exp.mat;
load sim.mat

 Max_exp = max(Y);
 Max_sim = max(Y_sim);
% 
 Y = Y*Max_sim/Max_exp;

X_sim = -X_sim+1.5; 
 
upper = 8930;
lower = 8620;

ind1 = find(X>lower&X<upper);
ind2 = find(X_sim>lower&X_sim<upper);


N1 = length(ind1);
N2 = length(ind2);

for ii = ind1(1):ind1(N1)
    X(ii) =  X(ii) - 8778.95;
end

for ii = ind2(1):ind2(N2)
    X_sim(ii) =  X_sim(ii) - 8778.95;
end
 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Plot exp and sim in the same figure
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot(X(ind1(1):ind1(N1)),Y(ind1(1):ind1(N1)),'b'); set(gca,'XDir','reverse');
%  hold on
% plot(X_sim(ind2(1):ind2(N2)),Y_sim(ind2(1):ind2(N2)),'r');set(gca,'XDir','reverse');
%  
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %set legend
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% legend('exp','sim');
% 
% set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','bold');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %set label and title
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xlabel({'Frequency (Hz)'},'FontWeight','bold','FontSize',14,...
%     'FontName','Calibri');
% 
% ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',14,...
%     'FontName','Calibri');
% 
% title({'C7:11928.2200Hz'},'FontWeight','bold','FontSize',14,...
%     'FontName','Times New Roman',...
%     'FontAngle','normal');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot exp and sim in two figure in one column
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot('Position',[0.1253 0.5527 0.775 0.35]);
plot(X(ind1(1):ind1(N1)),-Y(ind1(1):ind1(N1)),'b'); set(gca,'XDir','reverse');
legend('exp');

set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','bold'); 



ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri');

title({'Observation of IZIZZZX'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri',...
    'FontAngle','normal');

set(gca,'FontName','Calibri');


axis([-80 80 -1200 1200])
set(gca,'xtick',-inf:inf:inf);

hold on
subplot('Position',[0.1253 0.1701 0.775 0.35]);
plot(X_sim(ind2(1):ind2(N2)),Y_sim(ind2(1):ind2(N2)),'r');set(gca,'XDir','reverse');

legend('sim');
set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','bold');
set(gca,'FontName','Calibri');

xlabel({'Frequency (Hz)'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri');

ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri');

axis([-80 80 -1200 1200])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%