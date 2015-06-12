clear

addpath H:\Matlab\Twqubit_Circuit_PPS\simulation\Thermal_Fitting_Figures

load thermal_310ms_qubit2.mat

%%%%%%%%%%%%%%% C2 Para %%%%%%%%%%%%
% load Para_12qubit.mat
% Para(2,4) = 0;
% Para(2,5) = 2.62;
% Para(2,6) = 1.66;
% Para(2,8) = 0;
% Para(2,10) = 3.7716;
% Para(2,9) = 3.7716;
% Para(2,12) = 3.8;
% T2 = 0.31;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% determine C2 %%%%%%%
load thermal_exp_C_200.mat
Region_C2 = [8925 8895]; % C2 locates in this region
ind_C2 = find(X_exp>Region_C2(2)&X_exp<Region_C2(1));
scale_factor = sum(Y_exp(ind_C2));

integ_Y = 1.002946185655901e+03; %sum(Y) of the simulated spectrum

subplot(2,1,1)

plot(X,Y/integ_Y*1.15/2,'r') %*scale_factor*0.9
hold on
plot(X_exp,Y_exp/scale_factor)

    % plot setting
    set(gca,'Xdir','reverse','Xlim', [min(X+90) max(X-90)]);
    fontsize = 14;
    fontsize_legend = 12;
    
    title_string = ['Comparison of C2'];
    title({title_string},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

    xlabel({'Frequency (Hz)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

     ylabel({'Arb. Unit'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

 figure_name=strcat('twqubit_C2-',date);
 saveas(gca, figure_name, 'fig');


