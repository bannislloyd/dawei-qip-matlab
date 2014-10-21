%% Generate Selective Pulses;
% pulse_description={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle, pulse_variance;]};
function [Bx, By]=selpulse(pulse_description)

load parameter.mat

total_time=pulse_description{1}(1); time_interval=pulse_description{1}(2); Nsteps=round(total_time/time_interval);
Bx=zeros(1,Nsteps); By=zeros(1,Nsteps);

for k=1:size(pulse_description{2},1)
    pulse_qubit=pulse_description{2}(k,1);
    pulse_center=pulse_description{2}(k,2);
    pulse_width=pulse_description{2}(k,3);
    pulse_phase=pulse_description{2}(k,4);
    pulse_angle=pulse_description{2}(k,5);
    pulse_variance=pulse_description{2}(k,6);  
    M=round(pulse_width/time_interval);
    
    Gaussian=exp(-((1:M)-M/2).*((1:M)-M/2)/(pulse_variance)^2);    Gaussian=Gaussian/sum(Gaussian)*pulse_angle/360/time_interval;
    Bx=Bx+[zeros(1, round((pulse_center-pulse_width/2)/time_interval)), Gaussian.*cos(2*pi*w(pulse_qubit)*(1:M)*time_interval+pulse_phase*pi/180), zeros(1, Nsteps-round((pulse_center-pulse_width/2)/time_interval)-M)];
    By=By+[zeros(1, round((pulse_center-pulse_width/2)/time_interval)), -Gaussian.*sin(2*pi*w(pulse_qubit)*(1:M)*time_interval+pulse_phase*pi/180), zeros(1, Nsteps-round((pulse_center-pulse_width/2)/time_interval)-M)];
    
%     Sech=sech(((1:M)-M/2)/pulse_variance);  Sech=Sech/sum(Sech)*pulse_angle/360/time_interval;
%     Bx=Bx+[zeros(1, round((pulse_center-pulse_width/2)/time_interval)), Sech.*cos(2*pi*w(pulse_qubit)*(1:M)*time_interval+pulse_phase*pi/180), zeros(1, Nsteps-round((pulse_center-pulse_width/2)/time_interval)-M)];
%     By=By+[zeros(1, round((pulse_center-pulse_width/2)/time_interval)), -Sech.*sin(2*pi*w(pulse_qubit)*(1:M)*time_interval+pulse_phase*pi/180), zeros(1, Nsteps-round((pulse_center-pulse_width/2)/time_interval)-M)];
end