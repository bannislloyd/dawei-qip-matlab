clear;

%% load the spectrum data %%
specstruc = getspec('F:\matlab\NMR\EXPERIMENTS\svqubit_test\results\5', 1);
N = length(specstruc.spec);
swh = specstruc.swh;
o1 = -specstruc.o1;

step = swh/(N-1);

 for ii = 1:N
     X(ii) = o1+swh/2-(ii-1)*step;
     Y(ii) = real(specstruc.spec(ii));
 end

delta_f = X(1)-X(2);

%% default chemical shifts for 7 Carbons %%%%%
Para(1,1) = 2989.02; Para(2,2) = 25458.75; Para(3,3) = 21592.58; Para(4,4) = 29341.98; 

%% determine C1 %%%%%%%
Region_C1 = [3600 2200]; % C1 locates in this region

ind_C1 = find(X>Region_C1(2)&X<Region_C1(1));
length_C1 = length(ind_C1);

min_peakheight = max(Y(ind_C1))/2; % minimal peak height; 1/10 of the maxmimal peak
min_peakdistance = round(0.3/delta_f);

[pks_C1,locs_C1]=findpeaks(Y(ind_C1(1):ind_C1(length_C1)), 'minpeakheight',min_peakheight,'minpeakdistance',min_peakdistance);
if length(locs_C1) ~= 8
    fprintf('Warning: Different Number (%d) of Peaks for C1 (default: 8) \n', length(locs_C1));
end
chemical_shift(1) = mean(X(ind_C1(locs_C1)));
% fprintf('C1: %f; default: %f; drift: %f \n', chemical_shift(1), Para(1,1), chemical_shift(1)-Para(1,1));

%% determine C4 %%%%%%%
Region_C4 = [29600 29000]; % C4 locates in this region

ind_C4 = find(X>Region_C4(2)&X<Region_C4(1));
length_C4 = length(ind_C4);

min_peakheight = max(Y(ind_C4))/2; % minimal peak height; 1/10 of the maxmimal peak
min_peakdistance = round(0.5/delta_f);

[pks_C4,locs_C4]=findpeaks(Y(ind_C4(1):ind_C4(length_C4)), 'minpeakheight',min_peakheight,'minpeakdistance',min_peakdistance);
if length(locs_C4) ~= 8
    fprintf('Warning: Different Number (%d) of Peaks for C4 (default: 8) \n', length(locs_C4) );
end
chemical_shift(4) = mean(X(ind_C4(locs_C4)));
% fprintf('C4: %f; default: %f; drift: %f \n', chemical_shift(4), Para(4,4), chemical_shift(4)-Para(4,4));

%% determine C2 %%%%%%%
Region_C2 = [26200 24800]; % C2 locates in this region

ind_C2 = find(X>Region_C2(2)&X<Region_C2(1));
length_C2 = length(ind_C2);

min_peakheight = max(Y(ind_C2))/2; % minimal peak height; 1/10 of the maxmimal peak
min_peakdistance = round(0.5/delta_f);

[pks_C2,locs_C2]=findpeaks(Y(ind_C2(1):ind_C2(length_C2)), 'minpeakheight',min_peakheight,'minpeakdistance',min_peakdistance);
if length(locs_C2) ~= 8
    fprintf('Warning: Different Number (%d) of Peaks for C2 (default: 8) \n', length(locs_C2) );
end
chemical_shift(2) = mean(X(ind_C2(locs_C2)));
% fprintf('C2: %f; default: %f; drift: %f \n', chemical_shift(2), Para(2,2), chemical_shift(2)-Para(2,2));

%% determine C3 %%%%%%%
Region_C3 = [22400 20800]; % C3 locates in this region

ind_C3 = find(X>Region_C3(2)&X<Region_C3(1));
length_C3 = length(ind_C3);

min_peakheight = max(Y(ind_C3))/2; % minimal peak height; 1/10 of the maxmimal peak
min_peakdistance = round(0.5/delta_f);

[pks_C3,locs_C3]=findpeaks(Y(ind_C3(1):ind_C3(length_C3)), 'minpeakheight',min_peakheight,'minpeakdistance',min_peakdistance);
if length(locs_C3) ~= 8
    fprintf('Warning: Different Number (%d) of Peaks for C3 (default: 8) \n', length(locs_C3) );
end
chemical_shift(3) = mean(X(ind_C3(locs_C3)));
% fprintf('C3: %f; default: %f; drift: %f \n', chemical_shift(3), Para(3,3), chemical_shift(3)-Para(3,3));

%% all chemical shifts differences %%%%
for ii = 1:4
    fprintf('C%d: %f; default: %f; drift: %f \n', ii, chemical_shift(ii), Para(ii,ii), chemical_shift(ii)-Para(ii,ii));
end

%% plot with the selected peaks %%
plot(X,Y,'b');set(gca,'XDir','reverse');
hold on;
% offset values of peak heights for plotting

plot(X(ind_C1(locs_C1)),pks_C1+0.05,'k^','markerfacecolor',[1 0 0]);
hold on;
plot(X(ind_C4(locs_C4)),pks_C4+0.05,'k^','markerfacecolor',[1 0 0]);
hold on;
plot(X(ind_C2(locs_C2)),pks_C2+0.05,'k^','markerfacecolor',[1 0 0]);
hold on;
plot(X(ind_C3(locs_C3)),pks_C3+0.05,'k^','markerfacecolor',[1 0 0]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set label and title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlabel({'Frequency (Hz)'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri');

ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri');

title({'Thermal'},'FontWeight','bold','FontSize',14,...
    'FontName','Times New Roman',...
    'FontAngle','normal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%