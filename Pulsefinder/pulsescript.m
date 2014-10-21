[pulses] = pulsefinder_main('TCEparams_ordi2');
save
pulseout = smoothpulse(pulses{1},1e-6,40,0);
pulseguess = pulseout;
[pulses] = pulsefinder_main('TCEparams_ordi22');
save
exit