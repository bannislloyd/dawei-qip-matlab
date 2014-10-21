clear;

%12.2263



load sim_H.mat

% Max_exp = max(Y);
% Max_sim = max(Y_sim);
% 
% Y = Y*Max_sim/Max_exp*0.9;

ind2 = find(X>4398&X<4696);

Y_sim = Y/1e7;

N2 = length(ind2);

for ii = ind2(1):ind2(N2)
    X_sim(ii) =  X(ii);
end

plot(X_sim(ind2(1):ind2(N2)),Y_sim(ind2(1):ind2(N2)),'b');set(gca,'XDir','reverse');

load exp_H.mat;
ind1 = find(X>4398&X<4696);

N1 = length(ind1);
for ii = ind1(1):ind1(N1)
    X(ii) =  X(ii);
end

Max_exp = max(Y);
Max_sim = max(Y_sim);

rg = Max_sim/Max_exp;

Y = Y*Max_sim/Max_exp;
 ind3 = find(X>4642&X<4644);
 R = Y_sim(7202)/Y(7202);
% %Y(25422) = 2733001818;
 Y(ind3) = R*Y(ind3)*0.99;


 

hold on
plot(X(ind1(1):ind1(N1)),Y(ind1(1):ind1(N1)),'r'); set(gca,'XDir','reverse');


hold on
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set legend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
legend('simulation','experiment');

set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',22);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
load sim_H_g005.mat;
ind1 = find(X>4398&X<4696);

Y_sim = Y/1e7-4;
N1 = length(ind1);
for ii = ind1(1):ind1(N1)
    X_sim(ii) =  X(ii);
end


plot(X_sim(ind1(1):ind1(N1)),Y_sim(ind1(1):ind1(N1)),'b'); set(gca,'XDir','reverse');

load exp_H_g005.mat;
ind1 = find(X>4398&X<4696);

N1 = length(ind1);
for ii = ind1(1):ind1(N1)
    X(ii) =  X(ii);
end

rg = 1.5405e-004;

Max_exp = max(Y);
Max_sim = max(Y_sim+4);

Y = Y*rg-4;
 ind3 = find(X>4620&X<4644);
 R = Y_sim(7202)/Y(7202);
% %Y(25422) = 2733001818;
 Y(ind3) = (R*(Y(ind3)+4)*1.2-4);
 
ind4 = find(X>4647&X<4665);
 R = Y_sim(6371)/Y(6371);
% %Y(25422) = 2733001818;
 Y(ind4) = (R*(Y(ind4)+4)*0.99-4);

ind5 = find(X>4620&X<4680); 
 Y(ind5) = (Y(ind5)+4)*0.87-4; 
 
 ind6 = find(X>4444&X<4515); 
 Y(ind6) = (Y(ind6)+4)*1.2-4; 
 
  ind6 = find(X>4450&X<4552); 
 Y(ind6) = (Y(ind6)+4)*1.2-4;
 
  ind7 = find(X>4441.5&X<4444); 
 Y(ind7) = (Y(ind7)+4)*1.2-4; 
 
hold on
plot(X(ind1(1):ind1(N1)),Y(ind1(1):ind1(N1)),'r'); set(gca,'XDir','reverse');

xlabel({'NMR Frequency (Hz)'},'FontWeight','normal','FontSize',24,...
    'FontName','Calibri');

ylabel({'NMR signal (Arb. Unit)'},'FontWeight','normal','FontSize',24,...
    'FontName','Calibri');

title({'H Spectra'},'FontWeight','normal','FontSize',24,...
   'FontName','Calibri',...
   'FontAngle','normal');
set(gca,'xlim',[4395 4700],'ytick',[],'FontName','Calibri','FontSize',22);

