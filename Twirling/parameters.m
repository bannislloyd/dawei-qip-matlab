clear;

%% Number of Experiments
qubits = 7;
Number = 4^qubits-1; % 16383
N = 1656;
Distribution = [3 22 101 272 505 524 229]; % sum is 1656

%% Typical time and decoherence for each order of coherence
T(1) = 2e-3;  Dec(1) = 0.811; %0.813;
T(2) = 26e-3; Dec(2) = 0.766; %0.760;
T(3) = 34e-6; Dec(3) = 0.717; %0.715;
T(4) = 49e-6; Dec(4) = 0.668; %0.642;
T(5) = 53e-6; Dec(5) = 0.624; %0.621;
T(6) = 55e-6; Dec(6) = 0.605; %0.586;
T(7) = 60e-6; Dec(7) = 0.569; %0.548;

%% Calibration
Mean_Cali(1) = 0.9772;
Std_Cali(1) = 0.0236;

Mean_Cali(2) = 0.9153;
Std_Cali(2) = 0.0290;

Mean_Cali(3) = 0.8945;
Std_Cali(3) = 0.0386;

Mean_Cali(4) = 0.8655;
Std_Cali(4) = 0.0249;

Mean_Cali(5) = 0.8383;
Std_Cali(5) = 0.0412;

Mean_Cali(6) = 0.8605;
Std_Cali(6) = 0.0304;

Mean_Cali(7) = 0.8649;
Std_Cali(7) = 0.0310;

%% Final
Mean_Dec(1) = 0.7645; Mean_Fin(1) = Mean_Dec(1)/Dec(1); %0.9404;
Std_Dec(1) = 0.0120; Std_Fin(1) = 0.0148;

Mean_Dec(2) = 0.6416; Mean_Fin(2) = Mean_Dec(2)/Dec(2); % 0.8442;
Std_Dec(2) = 0.0428; Std_Fin(2) = 0.0563;

Mean_Dec(3) = 0.6003; Mean_Fin(3) = Mean_Dec(3)/Dec(3); %0.8396;
Std_Dec(3) = 0.0373; Std_Fin(3) = 0.0522;

Mean_Dec(4) = 0.5039; Mean_Fin(4) = Mean_Dec(4)/Dec(4); %0.7849;
Std_Dec(4) = 0.0287; Std_Fin(4) = 0.0447;

Mean_Dec(5) = 0.4630; Mean_Fin(5) = Mean_Dec(5)/Dec(5); %0.7456;
Std_Dec(5) = 0.0275; Std_Fin(5) = 0.0443;

Mean_Dec(6) = 0.4455; Mean_Fin(6) = Mean_Dec(6)/Dec(6); %0.7603;
Std_Dec(6) = 0.0226; Std_Fin(6) = 0.0386;

Mean_Dec(7) = 0.4233; Mean_Fin(7) = Mean_Dec(7)/Dec(7); %0.7725;
Std_Dec(7) = 0.0247; Std_Fin(7) = 0.0450;

Fin = 1-Mean_Cali+Mean_Fin;

Fidelity = 0;
Decoherence = 0;
Fd = 0;
for ii = 1:7
    Fidelity = Distribution(ii)*Fin(ii)+Fidelity;
    Decoherence = Distribution(ii)*Dec(ii)+Decoherence;
    Fd = Distribution(ii)*Mean_Fin(ii)+Fd;
end
Fidelity = Fidelity/N;
Decoherence = Decoherence/N;
Fd = Fd/N;
% Fidelity = 0;
% for ii = 1:7
%     Fidelity = Distribution(ii)*(1-Mean_Cali(ii))+Fidelity;
% end
% Fidelity = Fidelity/N

for ii = 1:7
    FF(ii) = Fidelity;
end

plot(Mean_Dec,'b-o','Linewidth',2,'Color',[0.4667 0.7647 0.3882],'MarkerSize',8)
hold on
plot(Mean_Fin,'r-v','Linewidth',2,'Color',[0.4 0.4 1],'MarkerSize',8)
hold on
plot(Fin,'g-d','Linewidth',2,'Color',[1 0.6 0.6],'MarkerSize',8)
hold on
%plot(Mean_Cali,'k-s')
plot(FF,'k--','Linewidth',2,'Color',[0.8 0.8 0.8])

fontsize = 16;
fontsize_legend = 14;


title({'Fidelity For Different Weights'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

xlabel({'Weight \omega'},'FontWeight','normal','FontSize',18,...
    'FontName','Calibri');

ylabel({'Fidelity'},'FontWeight','normal','FontSize',18,...
    'FontName','Calibri');

legend('F_e    (by experiment) ','F_d    (by eliminating E_d)','F_{d,c} (by eliminating E_d and E_c)');
set(legend,'box','off','EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend,'Position',[0.2396 0.235 0.2031 0.1346]);

set(gca,'box','off','Xlim',[0.5 7.5],'Ylim',[0 1],'XTick',[1:1:7],'XTickLabel',{'1','2','3','4','5','6','7'},'FontName','Calibri','FontSize',fontsize);