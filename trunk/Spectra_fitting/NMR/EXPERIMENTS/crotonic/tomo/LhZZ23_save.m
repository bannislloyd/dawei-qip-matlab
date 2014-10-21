clear;
clc;
% specN = [3];  %here is the numbers of the spectra that need fitting
% for k = 1:length(specN);
% vec = specN(k);
% n = k;
% [A,ff,Err]=ThermalZ_fit(vec,n);   %here n is the fig window number. A is the amplitude of peaks. Err is the fitting error.
% strk = ['A_LhZZ23_' num2str(k)];
% save (strk, 'A', 'Err'); %  A and Err are saved       
% end

%% pps as a reference
vec = 3;
n = 50;
[A,ff,Err]=ThermalZ_fit(vec,n);   
strk = ['LhZZ23_ref'];
 save (strk, 'A', 'Err');       