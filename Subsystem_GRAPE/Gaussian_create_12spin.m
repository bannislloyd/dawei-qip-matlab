clear;

load parameter.mat

total_time = 1e-3;
stepsize = 1e-5;
steps = round(total_time/stepsize);

uncompiled_pulse{1} = {[total_time, stepsize], [6, 0.5e-3, 1e-3, 0, 90, 60]};
[Bx, By]=selpulse({uncompiled_pulse{1}{1},uncompiled_pulse{1}{2}});   

Bx2 = 0; By2 = 0;

load twqubit_C790.mat
for ii = 1:steps
    pulses{1}.pulse(ii,1) = stepsize;
    pulses{1}.pulse(ii,2) = Bx(ii);
    pulses{1}.pulse(ii,3) = By(ii);
    pulses{1}.pulse(ii,4) = Bx2;
    pulses{1}.pulse(ii,5) = By2;
end

save Gaussian_Guess_C690.mat pulses