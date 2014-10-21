function [intensity, phase, Y_best, square_error] = spec_fitting(X, Y, central_peak, width, calibration, stepsize, N, Region)

step = 0.01;
phase_step = 2*pi/120;

square_error = 10000000000000;
intensity = 0;
phase = 0;

for ii = 0:1/step
    for kk = 0:2*pi/phase_step
    for jj = 1:N
        Y_sim(jj) = ii*step*(cos(phase_step*kk)-(X(Region(jj))-central_peak)*2/width*sin(phase_step*kk))/(1+(X(Region(jj))-central_peak)^2/(width/2)^2)+...
        ii*step*(cos(phase_step*kk)-(X(Region(jj))+central_peak)*2/width*sin(phase_step*kk))/(1+(X(Region(jj))+central_peak)^2/(width/2)^2);
    end
    deviation = 0;
    for jj = 1:N
        deviation = deviation + (Y(Region(jj))/calibration-Y_sim(jj))^2;
    end
    if deviation<square_error
        square_error = deviation;
        intensity = ii*step;
        phase = kk*phase_step;
        Y_best = Y_sim;
    else
    end
    end
end
    
     