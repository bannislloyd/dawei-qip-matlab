clear;

load f.mat
load timestep.mat
N_points = length(f); % 830 steps
% timestep can be integer times of us
timestep = round(timestep*1e6)/1e6; 

t(1) = timestep(1);
for ii = 2:N_points
    t(ii) = t(ii-1) + timestep(ii);
end

plot(t*1000, f/2,'Linewidth',2)

fontsize =16;
title({'Fully Rotating Frame'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

% legend('p(1\rightarrow 1)','p(1\rightarrow 2)','p(1\rightarrow 3)');
% set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
%     'LineWidth',2,...
%     'FontWeight','normal','FontSize',fontsize_legend);
%set(legend,'Color','none')

xlabel({'t (ms)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'Amplitude (Hz)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');
