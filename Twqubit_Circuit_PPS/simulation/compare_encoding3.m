clear

addpath H:\Matlab\Twqubit_Circuit_PPS\simulation\Encoding3_Operators
 
%% for 12 qubits: Ob C2 %%%%%%%%
load exp_encoding3_obC2.mat
load encoding3_qubit2.mat

load Para_12qubit.mat
T2 = [1 0.31 1 1 1 1 0.42 1 1 1 1 1]; 

scale_factor = max(Y_exp)/max(Y); % for C2

subplot(2,1,1)

plot(X+1,Y,'r') %*scale_factor*0.9
hold on
plot(X_exp,Y_exp/scale_factor)

    % plot setting
    set(gca,'Xdir','reverse','Xlim', [min(X+90) max(X-90)],'Ylim',[-20 20]);
    fontsize = 14;
    fontsize_legend = 12;
    
    title_string = ['Encoding3 Applied On Thermal: Ob C2'];
    title({title_string},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

    xlabel({'Frequency (Hz)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

     ylabel({'Arb. Unit'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

     legend('sim','exp');
     set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend);

 figure_name=strcat('encoding3_C2-',date);
 saveas(gca, figure_name, 'fig');

%% for 12 qubits: Ob C7 %%%%%%%%
load exp_encoding3_obC7.mat
load encoding3_qubit7.mat

load Para_12qubit.mat
T2 = [1 0.31 1 1 1 1 0.42 1 1 1 1 1]; 


scale_factor = max(Y_exp)/max(Y); % for C7

subplot(2,1,2)

plot(X-0.1,Y,'r') %*scale_factor*0.9
hold on
plot(X_exp,Y_exp/scale_factor)

    % plot setting
    set(gca,'Xdir','reverse','Xlim', [min(X+90) max(X-90)],'Ylim',[-15 15]);
    fontsize = 14;
    fontsize_legend = 12;
    
    title_string = ['Encoding3 Applied On Thermal: Ob C7'];
    title({title_string},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

    xlabel({'Frequency (Hz)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

     ylabel({'Arb. Unit'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

     legend('sim','exp');
     set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend);

 figure_name=strcat('encoding3_C7-',date);
 saveas(gca, figure_name, 'fig');
