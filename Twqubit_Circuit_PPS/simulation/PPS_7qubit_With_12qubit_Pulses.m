clear

addpath H:\Matlab\Twqubit_Circuit_PPS\simulation\PPS_7qubit_With_12qubit_Pulses_Operators

% %% for 7 qubits: Ob C7: Compare Thermal with and without SWAP %%%%%%%%
% load SWAP_thermal_obC7.mat
% 
% ind = find(X_exp>11840&X_exp<12020);
% A = max(abs(Y_exp));
% 
% plot(X_exp,Y_exp/A,'r');
% hold on
% 
% load original_thermal_obC7.mat
% 
% B = max(abs(Y_exp(ind(1):ind(end))));
% scale_factor = A/B
% 
% plot(X_exp,Y_exp/B,'b');
% 
% 
%     % plot setting
%     set(gca,'Xdir','reverse','Xlim', [11840 12020],'Ylim',[-0.2 1.2]);
%     fontsize = 14;
%     fontsize_legend = 12;
%     
%     title_string = ['Compare Thermal With and Without SWAP'];
%     title({title_string},'FontWeight','normal','FontSize',fontsize,...
%    'FontName','Calibri',...
%    'FontAngle','normal');
% 
%     xlabel({'Frequency (Hz)'},'FontWeight','normal','FontSize',fontsize,...
%     'FontName','Calibri');
% 
%      ylabel({'Arb. Unit'},'FontWeight','normal','FontSize',fontsize,...
%     'FontName','Calibri');
% 
%      legend('With SWAP','Without SWAP*3.39');
%      set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal','FontSize',fontsize_legend);
% 
%  figure_name=strcat('Compare_Thermal_with_and_without_SWAP-',date);
%  saveas(gca, figure_name, 'fig');

% %% for 7 qubits: Ob C7: SWAP Thermal and 7-qubit PPS %%%%%%%%
% load SWAP_thermal_obC7.mat
% 
% ind = find(X_exp>11840&X_exp<12020);
% A = max(abs(Y_exp));
% 
% integ = find(X_exp>11984&X_exp<11996);
% integ_thermal = sum(Y_exp(integ));
% 
% plot(X_exp,Y_exp/A,'r');
% hold on
% 
% load PPS_7qubit_obC7.mat
% 
% B = max(abs(Y_exp(ind(1):ind(end))));
% 
% integ = find(X_exp>11984&X_exp<11996);
% integ_pps = sum(Y_exp(integ));
% scale_factor = 1/(integ_thermal/integ_pps/4)
% 
% plot(X_exp,Y_exp/A,'b');
% 
% 
%     % plot setting
%     set(gca,'Xdir','reverse','Xlim', [11840 12020],'Ylim',[-0.2 1.2]);
%     fontsize = 14;
%     fontsize_legend = 12;
%     
%     title_string = ['SWAP Thermal and 7-qubit PPS (56%)'];
%     title({title_string},'FontWeight','normal','FontSize',fontsize,...
%    'FontName','Calibri',...
%    'FontAngle','normal');
% 
%     xlabel({'Frequency (Hz)'},'FontWeight','normal','FontSize',fontsize,...
%     'FontName','Calibri');
% 
%      ylabel({'Arb. Unit'},'FontWeight','normal','FontSize',fontsize,...
%     'FontName','Calibri');
% 
%      legend('SWAP Thermal','7-qubit PPS');
%      set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal','FontSize',fontsize_legend);
% 
%  figure_name=strcat('SWAP_Thermal_and_7-qubit_PPS-',date);
%  saveas(gca, figure_name, 'fig');
 
 %% for 7 qubits: Ob C7: 7 PPS,  7 PPS with 12 Encoding, 7 PPS with 12 Encoding and PC %%%%%%%%
load PPS_7qubit_obC7.mat

ind = find(X_exp>11840&X_exp<12020);
A = max(abs(Y_exp));

plot(X_exp,Y_exp/A,'r');
hold on

load PPS_7qubit_With_12qubit_Encoding_obC7.mat

B = max(abs(Y_exp(ind(1):ind(end))));
scale_factor = B/A*0.56

plot(X_exp,Y_exp/A,'b');

load PPS_7qubit_With_12qubit_EncodingAndPhaseCycling_obC7.mat

C = max(abs(Y_exp(ind(1):ind(end))));
scale_factor = C/A*0.56

plot(X_exp,Y_exp/A,'g');


    % plot setting
    set(gca,'Xdir','reverse','Xlim', [11840 12020],'Ylim',[-0.2 1.2]);
    fontsize = 14;
    fontsize_legend = 12;
    
    title_string = ['7 PPS (56%),  7 PPS with 12 Encoding (46%), 7 PPS with 12 Encoding and PC (11%)'];
    title({title_string},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

    xlabel({'Frequency (Hz)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

     ylabel({'Arb. Unit'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

     legend('7 PPS (56%)','7 PPS with 12 Encoding (46%)', '7 PPS with 12 Encoding and PC (11%)');
     set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend);

 figure_name=strcat('7PPS_7PPSwith12Encoding_7PPSwith12EncodingandPC-',date);
 saveas(gca, figure_name, 'fig');