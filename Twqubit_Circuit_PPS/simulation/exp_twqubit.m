clear;

addpath H:\Matlab\Twqubit_Circuit_PPS\simulation\Spectra_Data
%specstruc = getspec('/home/dtrottie/NMR/EXPERIMENTS/twqubit/results/1',1);
specstruc = getspec('H:\Matlab\Twqubit_Circuit_PPS\simulation\Spectra_Data\1409', 1);

%load thermal.mat
%load exp_thermal.mat

N = length(specstruc.spec);
swh = specstruc.swh;
o1 = -specstruc.o1;

step = swh/(N-1);

 for ii = 1:N
     X_exp(ii) = o1+swh/2-(ii-1)*step;
     Y_exp(ii) = real(specstruc.spec(ii));
 end


save exp_encoding2_obC7_Hdecouple.mat X_exp Y_exp

% plot(real(specstruc.spec));
% %set(gca,'XDir','reverse');
% set(gca,'xtick',1:1:300);