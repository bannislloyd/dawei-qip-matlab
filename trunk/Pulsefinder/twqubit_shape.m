
clear;
for ii = 7:7
loadfile = ['twqubit_C', num2str(ii), '180', '.mat'];
eval(['load ', loadfile]);
filename1 = ['twqubit_C', num2str(ii), '180_C_15000.txt'];
filename2 = ['twqubit_C', num2str(ii), '180_H_15000.txt'];
make_bruker_shape(pulses{1}, 15000, filename1,1);
make_bruker_shape(pulses{1}, 15000, filename2,2);
end
%clear
%pulsefinder_main('twqubit_sub','twqubit_C290');
%clear
%pulses_full=pulsefinder_main('sevenbit_full','CCR_full');
%save pulses_full.mat pulses_full

load twqubit_C234790withPC.mat
make_bruker_shape(pulses{1},25000,'twqubit_C234790withPC_C_25000.txt',1);
make_bruker_shape(pulses{1},25000,'twqubit_C234790withPC_H_25000.txt',2);