clear;

%addpath H:\Matlab\Twqubit_Circuit_PPS\simulation\Spectra_Data
%specstruc = getspec('/home/dtrottie/NMR/EXPERIMENTS/twqubit/results/1',1);
specstruc = getspec('\Spectra_Data\1893', 1);

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


save PPS_7qubit_With_12qubit_EncodingAndPhaseCycling_obC7.mat X_exp Y_exp

% plot(real(specstruc.spec));
% %set(gca,'XDir','reverse');
% set(gca,'xtick',1:1:300);