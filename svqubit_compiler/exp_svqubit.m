clear;

%specstruc = getspec('/home/dtrottie/NMR/EXPERIMENTS/twqubit/results/1',1);
specstruc = getspec('/home/dtrottie/NMR/EXPERIMENTS/svqubits_compiler/results/9020', 1);

%load thermal.mat
%load exp_thermal.mat

N = length(specstruc.spec);
swh = specstruc.swh;
o1 = -specstruc.o1;

step = swh/(N-1);

 for ii = 1:N
     X(ii) = o1+swh/2-(ii-1)*step;
     Y(ii) = real(specstruc.spec(ii));
 end


save exp

% plot(real(specstruc.spec));
% %set(gca,'XDir','reverse');
% set(gca,'xtick',1:1:300);