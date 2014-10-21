clear;

load exp.mat
% plot(X241,Y241,'r');set(gca,'XDir','reverse');

%% calibration by exp 241
peak_position = 3277; %peak position X(3278) and Y(3278)
stepsize = X241(1)-X241(2); %frequency between two points

N = round((5720 - X241(peak_position))/stepsize);

% define processing region
Region_low = peak_position-N; Frequency_low = X241(peak_position)-N*stepsize;
Region_up = peak_position+N; Frequency_UP = X241(peak_position)+N*stepsize;
Region = Region_low:Region_up;
N = 2*N+1; % total points

% calibration = sum(Y241(Region_low:Region_up));
calibration = Y241(peak_position);
delta_w = 1; % half height width

for ii  = 0:40
    start_nb = 527;
    [intensity, phase, Y_sim, best] = spec_fitting(eval(['X', num2str(ii+start_nb)]), eval(['Y', num2str(ii+start_nb)]), X241(peak_position), delta_w, calibration, stepsize, N, Region);
    X_exp(ii+1) = intensity*cos(phase);
    Y_exp(ii+1) = intensity*sin(phase);
end

save('exp3_+x.mat', 'X_exp', 'Y_exp')
% [intensity, phase, Y_sim, best] = spec_fitting(X527, Y527, X241(peak_position), delta_w, calibration, stepsize, N, Region);
% intensity*cos(phase)
% intensity*sin(phase)
% 
% plot(X527(Region),Y527(Region)/calibration,'r');
% hold on
% plot(X527(Region),Y_sim,'b');