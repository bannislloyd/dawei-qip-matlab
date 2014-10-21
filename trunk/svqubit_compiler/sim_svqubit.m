clear;

N = length(spec.spec);
swh = spec.swh;
o1 = spec.o1;

step = swh/(N-1);

 for ii = 1:N
     X_sim(ii) = o1+swh/2-(ii-1)*step;
     Y_sim(ii) = real(spec.spec(N-ii+1));
 end

save sim


% plot(real(specstruc.spec));
% %set(gca,'XDir','reverse');
% set(gca,'xtick',1:1:300);