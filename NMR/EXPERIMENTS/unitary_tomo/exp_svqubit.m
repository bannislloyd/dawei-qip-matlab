clear;

for ii = 200:568
    pathname = ['F:\matlab\NMR\EXPERIMENTS\unitary_tomo\results\', num2str(ii)];
    specstruc = getspec(pathname,1);

   N = length(specstruc.spec);
   swh = specstruc.swh;
   o1 = -specstruc.o1;

step = swh/(N-1);

 for jj = 1:N
     Xname = ['X', num2str(ii)]; Yname = ['Y', num2str(ii)];
     eval(['X', num2str(ii), '(jj) = o1+swh/2-(jj-1)*step;']);
     eval(['Y', num2str(ii), '(jj) = real(specstruc.spec(jj));']);
%      Yname(jj) = real(specstruc.spec(jj));
 end

end

save exp

% plot(real(specstruc.spec));
% %set(gca,'XDir','reverse');
% set(gca,'xtick',1:1:300);