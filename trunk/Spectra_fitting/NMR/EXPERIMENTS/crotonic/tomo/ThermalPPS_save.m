clear;
clc;
specN = [7401:2:7401];
for k = 1:length(specN);
vec = specN(k);
n = k;
[A,ff,Err]=ThermalZ_fit(vec,n);
strk = ['mz_' num2str(k)];
save (strk, 'A','Err');
end

%% pps as a reference
vec = 7403;
n = 22;
[A,ff]=ThermalZ_fit(vec,n)
strk = ['PPS_ref'];
save (strk, 'A');