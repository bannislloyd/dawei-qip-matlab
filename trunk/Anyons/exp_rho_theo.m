%For producing figures for the PDF file. 
%Data names
data_name1={'anyon_theo_spec','exp_10002'}

figure;
handle=gcf;

load(data_name1{1})
load(data_name1{2})


Y_average=average_noise(Y,2);

Max_exp=max(Y_average);
Max_sim=2*max(Y_sim0);

Y_sim0=Y_sim0/Max_sim;
Y_average=Y_average/Max_exp;

subplot(5,1,1)

plot(X,Y_average,X_sim-11928+0.36,Y_sim0)
legend('Experiment','Simulated')

set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','bold');


% %xlabel({'Frequency (Hz)'},'FontWeight','bold','FontSize',20,...
%     'FontName','Calibri');
 set(gca,'XtickLabel',[]);
ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',20,...
    'FontName','Calibri');


load('exp_30002')

Y_sim1=Y_sim1/Max_sim;
Y=Y/Max_exp;
Y_average=average_noise(Y,2);

hold on
subplot(5,1,2)
plot(X,Y_average,X_sim-11928+0.4,Y_sim1)
legend('Experiment','Simulation')


set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','bold');

% %xlabel({'Frequency (Hz)'},'FontWeight','bold','FontSize',20,...
%     'FontName','Calibri');
 set(gca,'XtickLabel',[]);

ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',20,...
    'FontName','Calibri');

data_name={'exp_30003' 'exp_30004' 'exp_30005' 'bd1_nodec_spec' 'bd0_nodec_spec'}


load(data_name{1})
X_bd=X;
Y_bd=Y;
load(data_name{2})
X_bd2=X;
Y_bd2=Y;
load(data_name{3})
X_bd0=X;
Y_bd0=Y;

Y_bd=average_noise(Y_bd,2);
Y_bd2=average_noise(Y_bd2,2);
Y_bd0=average_noise(Y_bd0,2);

Y_bd=Y_bd/Max_exp;
Y_bd2=Y_bd2/Max_exp;
Y_bd0=Y_bd0/Max_exp;

hold on
subplot(5,1,3)
handle=gcf;

plot(X_bd,Y_bd,X_sim-11928+0.36,Y_sim3/Max_sim,X_sim-11928+0.36,Y_sim2/Max_sim)
legend('Exp B.P. 1','Simulated B.P. 1','Simulated B.P. 0')
% %xlabel({'Frequency (Hz)'},'FontWeight','bold','FontSize',20,...
%     'FontName','Calibri');
 set(gca,'XtickLabel',[]);

ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',20,...
    'FontName','Calibri');

hold on
subplot(5,1,4)

plot(X_bd0,Y_bd0,X_sim-11928+0.36,Y_sim3/Max_sim,X_sim-11928+0.36,Y_sim2/Max_sim)
legend('Exp B.P. 0','Simulated B.P. 1','Simulated B.P. 0')
% %xlabel({'Frequency (Hz)'},'FontWeight','bold','FontSize',20,...
%     'FontName','Calibri');
 set(gca,'XtickLabel',[]);
ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',20,...
    'FontName','Calibri');

hold on
subplot(5,1,5)
plot(X_bd2,Y_bd2,X_sim-11928+0.36,Y_sim3/Max_sim,X_sim-11928+0.36,Y_sim2/Max_sim)
legend('Exp B.P. 2','Simulated B.P. 1','Simulated B.P. 0')
xlabel({'Frequency (Hz)'},'FontWeight','bold','FontSize',20,...
    'FontName','Calibri');

ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',20,...
    'FontName','Calibri');