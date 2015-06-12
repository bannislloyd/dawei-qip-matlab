clear

load thermal_420ms_qubit7.mat
load thermal_exp_C_200.mat

%% determine C7 %%%%%%%
Region_C7 = [12200 11600]; % C7 locates in this region

ind_C7 = find(X_exp>Region_C7(2)&X_exp<Region_C7(1));

scale_factor = max(Y_exp(ind_C7))/max(Y);

subplot(2,1,2)

plot(X+0.3,scale_factor*Y,'r');
hold on
plot(X_exp,Y_exp,'b');

    % plot setting
    set(gca,'Xdir','reverse','Xlim', [min(X+90) max(X-90)]);
    fontsize = 14;
    fontsize_legend = 12;
    
    title_string = ['Comparison of C7'];
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

 figure_name=strcat('twqubit_C7-',date);
 saveas(gca, figure_name, 'fig');