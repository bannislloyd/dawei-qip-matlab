clear

addpath H:\Matlab\Twqubit_Circuit_PPS\simulation\Encoding2_Operators

% %% for 7 qubits: Ob C2 %%%%%%%%
% load exp_encoding2_obC2_Hdecouple.mat
% 
% load Para_7qubit.mat
% T2 = [1 0.6 1 1 1 1 0.42]; 
% 
% [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7); 
% rho = KIz{1}*KIx{2}*KIz{3}*KIz{4}*KIz{5}*KIz{6}*KIz{7};
% 
%  [peak_position,  peak_intensity, X, Y] = spectra( Para, rho, [2], T2 );
%  
% scale_factor = max(abs(Y_exp))/max(abs(Y));
% 
% subplot(2,1,1)
% 
% plot(X-0.1,Y,'r') %*scale_factor*0.9
% hold on
% plot(X_exp,-Y_exp/scale_factor)
% 
%     % plot setting
%     set(gca,'Xdir','reverse','Xlim', [min(X+90) max(X-90)],'Ylim',[-0.01 0.01]);
%     fontsize = 14;
%     fontsize_legend = 12;
%     
%     title_string = ['Encoding2 ZZZZZZZIIIII: Ob C2 with H decoupled'];
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
%      legend('sim','exp');
%      set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal','FontSize',fontsize_legend);
% 
%  figure_name=strcat('encoding2_C2_Hdecouple-',date);
%  saveas(gca, figure_name, 'fig');
% 
%  %% for 7 qubits: Ob C7 %%%%%%%%
% load exp_encoding2_obC7_Hdecouple.mat
% 
% load Para_7qubit.mat
% T2 = [1 0.6 1 1 1 1 0.50]; 
% 
% [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7); 
% rho = KIz{1}*KIz{2}*KIz{3}*KIz{4}*KIz{5}*KIz{6}*KIx{7};
% 
%  [peak_position,  peak_intensity, X, Y] = spectra( Para, rho, [7], T2 );
%  
% scale_factor = max(abs(Y_exp))/max(abs(Y));
% 
% subplot(2,1,2)
% 
% plot(X-0.1,Y,'r') %*scale_factor*0.9
% hold on
% plot(X_exp,Y_exp/scale_factor*1.2)
% 
%     % plot setting
%     set(gca,'Xdir','reverse','Xlim', [min(X+90) max(X-90)],'Ylim',[-0.01 0.01]);
%     fontsize = 14;
%     fontsize_legend = 12;
%     
%     title_string = ['Encoding2 ZZZZZZZIIIII: Ob C7 with H decoupled'];
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
%      legend('sim','exp');
%      set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal','FontSize',fontsize_legend);
% 
%  figure_name=strcat('encoding2_C7_Hdecouple-',date);
%  saveas(gca, figure_name, 'fig');
 
%% for 12 qubits: Ob C2 %%%%%%%%
load exp_encoding2_obC2.mat
load encoding2_qubit2.mat

load Para_12qubit.mat
T2 = [1 0.31 1 1 1 1 0.42 1 1 1 1 1]; 

scale_factor = 1.3556e+05; % for C2

subplot(2,1,1)

plot(X-0.1,Y,'r') %*scale_factor*0.9
hold on
plot(X_exp,Y_exp/scale_factor)

    % plot setting
    set(gca,'Xdir','reverse','Xlim', [min(X+90) max(X-90)],'Ylim',[-30 30]);
    fontsize = 14;
    fontsize_legend = 12;
    
    title_string = ['Encoding2 ZZZZZZZIIIII: Ob C2'];
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

 figure_name=strcat('encoding2_C2-',date);
 saveas(gca, figure_name, 'fig');

%% for 12 qubits: Ob C7 %%%%%%%%
load exp_encoding2_obC7.mat
load encoding2_qubit7.mat

load Para_12qubit.mat
T2 = [1 0.31 1 1 1 1 0.42 1 1 1 1 1]; 

% scale_factor = 1.3556e+05; % for C2
scale_factor = 1.6938e+05; % for C7

subplot(2,1,2)

plot(X+0.3,Y,'r') %*scale_factor*0.9
hold on
plot(X_exp,Y_exp/scale_factor)

    % plot setting
    set(gca,'Xdir','reverse','Xlim', [min(X+90) max(X-90)],'Ylim',[-30 30]);
    fontsize = 14;
    fontsize_legend = 12;
    
    title_string = ['Encoding2 ZZZZZZZIIIII: Ob C7'];
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

 figure_name=strcat('encoding2_C7-',date);
 saveas(gca, figure_name, 'fig');
