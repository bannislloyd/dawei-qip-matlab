function sub2fullsystem
%clear
pulses_sub=pulsefinder_main('sevenbit_sub','After_U2_sub');
save pulses_sub.mat pulses_sub
%clear
%pulses_full=pulsefinder_main('sevenbit_full','CCR_full');
%save pulses_full.mat pulses_full
