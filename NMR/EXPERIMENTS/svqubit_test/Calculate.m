clear
load parameter.mat
load Bx_deco.mat
load By_deco.mat
load U_decoding.mat

Bx=Bx_deco; By=By_deco; time_interval=1e-6;

size=length(Bx);
U_sim=gate(Bx, By, size, time_interval); 
f=trace(U_sim*U_decoding')/128;