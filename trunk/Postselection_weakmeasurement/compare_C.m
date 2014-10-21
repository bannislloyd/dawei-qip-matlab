clear;

%12.2263



load sim.mat

% Max_exp = max(Y);
% Max_sim = max(Y_sim);
% 
% Y = Y*Max_sim/Max_exp*0.9;

ind2 = find(X>20312&X<20741);

Y_sim = Y/1e8;

N2 = length(ind2);

for ii = ind2(1):ind2(N2)
    X_sim(ii) =  X(ii);
end
% subplot('Position',[0.1253 0.5527 0.775 0.35]);
%plot(X(ind1(1):ind1(N1)),Y(ind1(1):ind1(N1)),'b'); set(gca,'XDir','reverse');
 %hold on 
plot(X_sim(ind2(1):ind2(N2)),Y_sim(ind2(1):ind2(N2)),'b');set(gca,'XDir','reverse');

load exp.mat;
ind1 = find(X>20312&X<20741);

N1 = length(ind1);
for ii = ind1(1):ind1(N1)
    X(ii) =  X(ii)-0.8;
end

Max_exp = max(Y);
Max_sim = max(Y_sim);

Y = Y*Max_sim/Max_exp;
ind3 = find(X>20560&X<20590);
R = Y_sim(25422)/Y(25422);
%Y(25422) = 273301818;
Y(ind3) = R*Y(ind3);


hold on
plot(X(ind1(1):ind1(N1)),Y(ind1(1):ind1(N1)),'r'); set(gca,'XDir','reverse');
% hold on
% load sim_pps_c7.mat
% for ii = ind2(1):ind2(N2)
%     X_sim(ii) =  X_sim(ii) - 11928.21998;
% end
% plot(X_sim(ind2(1):ind2(N2)),-Y_sim(ind2(1):ind2(N2))/14*sqrt(2),'r');set(gca,'XDir','reverse');

hold on
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set legend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
legend('simulation','experiment');

set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',22);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set label and title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xlabel({},'FontWeight','normal','FontSize',14,...
%     'FontName','Calibri');
% 
% ylabel({'Arb. Unit'},'FontWeight','normal','FontSize',14,...
%     'FontName','Calibri');

% title({'C2 Spectra for PPS'},'FontWeight','bold','FontSize',14,...
%    'FontName','Calibri',...
%    'FontAngle','normal');
% set(gca,'xtick',[],'ylim',[-3 3],'FontName','Calibri');
%set(gca,'xtick',[],'ytick',[],'FontName','Calibri');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
load sim_g005.mat;
ind1 = find(X>20312&X<20741);

Y_sim = Y/1e8-3;
N1 = length(ind1);
for ii = ind1(1):ind1(N1)
    X_sim(ii) =  X(ii);
end

%subplot('Position',[0.1253 0.1701 0.775 0.35]);
plot(X_sim(ind1(1):ind1(N1)),Y_sim(ind1(1):ind1(N1)),'b'); set(gca,'XDir','reverse');

load exp_g005.mat;
ind1 = find(X>20312&X<20741);

N1 = length(ind1);
for ii = ind1(1):ind1(N1)
    X(ii) =  X(ii)-0.8;
end

Max_exp = max(Y);
Max_sim = max(Y_sim+3);

Y = Y*Max_sim/Max_exp*0.94-3;
% ind3 = find(X>20560&X<20590);
% R = Y_sim(25422)/Y(25422);
% Y(ind3) = R*Y(ind3);


hold on
plot(X(ind1(1):ind1(N1)),Y(ind1(1):ind1(N1)),'r'); set(gca,'XDir','reverse');

xlabel({'NMR Frequency (Hz)'},'FontWeight','normal','FontSize',24,...
    'FontName','Calibri');

ylabel({'NMR signal (Arb. Unit)'},'FontWeight','normal','FontSize',24,...
    'FontName','Calibri');

title({'C2 Spectra'},'FontWeight','normal','FontSize',24,...
   'FontName','Calibri',...
   'FontAngle','normal');
set(gca,'xlim',[20300 20750 ],'ylim',[-6 3],'ytick',[],'FontName','Calibri','FontSize',22);

% legend('simulation','experiment');
% 
% set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal');