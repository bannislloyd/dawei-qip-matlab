% This program is used to optimize all the small J-couplings between C2 and
% all H except H4. C-C couplings adre all determined and they are only used as
% constants here.

% Just fitting the leftmost peaks in the region [8925 8895] since all big
% J's are already there.

clear

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(8); 

Para = zeros(8); % including C2C4, C2C5, C2C6, C2H1, C2H2, C2H3, C2H5..

% Another assumption is C2H2 and C2H3 have the same couplings to reduce
% time.

Para(1,1) = 8.909743320688780e+03; % 1 stands for C2
Para(1,2) = 0.3;           % C2C4, fixed
Para(1,3) = 2.62;      % C2C5, fixed
Para(1,4) = -1.66;    % C2C6, fixed
Para(1,5) = 0;           % C2H1
Para(1,6) = 0;           % C2H2, equals to Para(1,7)
Para(1,7) = 0;           % C2H3, equals to Para(1,6)
Para(1,8) = 0;           % C2H5

% thermal state
rho = 2*KIx{1};

%% load experimental spectrum and rescale
load thermal_exp_C_200.mat
Region_C2 = [8920 8900]; % C2 locates in this region
ind_C2 = find(X_exp>Region_C2(2)&X_exp<Region_C2(1));
% the scale factor is defined as the integral of this region
scale_factor = sum(Y_exp(ind_C2));

% all 13 peaks positions. Used for fitting
Exp_13peaks = [8.917647678509024e+03 8.916043895762887e+03  8.914669224837628e+03  8.913523665733243e+03  8.912148994807983e+03 8.911003435703602e+03 8.909743320688780e+03 ...
                            8.908368649763521e+03 8.907223090659136e+03 8.905962975644314e+03 8.904588304719055e+03 8.903328189704233e+03 8.901724406958099e+03];
Exp_13peaks = fliplr(Exp_13peaks);

% all 13 peaks intensities. Use positions to fit. When positions
% match well, go to check the intensities.
Exp_13intensities = [5424615 12508762 1.938778150000000e+07 30630273 3.727627350000000e+07 4.199704650000000e+07 49710459 ...
                                    4.148912150000000e+07 3.606134150000000e+07 2.990670350000000e+07 18389444 12249348 5.667683500000000e+06];
Exp_13intensities = fliplr(Exp_13intensities);
Exp_13intensities = Exp_13intensities/scale_factor;

%% simulation setting
% integral of the region in simulation
integ_Y = 2.005895804618441e+03; %sum(Y) of the simulated spectrum
% T2 can be 300ms to 400ms from the experience
T2 = [0.31 1 1 1 1 1 1 1];
% constraints. The sum over all J's should be equal to the width of
% spectrum 15.92Hz
total_width = 15.923271550924255-abs(Para(1,2))-abs(Para(1,3))-abs(Para(1,4));

%% fitting started
% stepsize in Hz
stepsize = 0.2;
% optimal function of the peak heights. Default 100, and when frequency
% matches, a new g will be calculated and saved.
g = 100*ones(400);

count = 0;

for ii = 1:20
    % from 0.2 to 4Hz
    Para(1,5) = ii*stepsize;%2.5+ii*0.1;%;  
    for jj = 1:20
        % constraint of total width
        Para(1,6) = min([jj*stepsize (total_width-Para(1,5))/2]); %min([4.5+ii*0.1 total_width-Para(1,5)]);%
        Para(1,7) = Para(1,6);
        Para(1,8) = total_width - Para(1,5) - Para(1,6) - Para(1,7);
        
        [ peak_position,  peak_intensity, X, Y] = spectra( Para, rho, [1], T2 );
        
        min_peakheight = 0; 
        min_peakdistance = 10; % peak point to be bigger than the neighbored 10 points.

        [pks_C2,locs_C2]=findpeaks(Y, 'minpeakheight',min_peakheight,'minpeakdistance',min_peakdistance); 

        if length(locs_C2) ~= 13
        fprintf('Warning: Different Number (%d) of Peaks for C2 (default: 13) \n', length(locs_C2) );
        end

        Peak_Number = length(locs_C2);
        Sim_13peaks = X(locs_C2(1:Peak_Number));
        % if less than 13 peaks in simulation, take this number. Otherwise
        % use 13
        Peak_Number = min([13 Peak_Number]);
        f(ii,jj) = sum(abs(Exp_13peaks(1:Peak_Number)-Sim_13peaks(1:Peak_Number)).^2)/Peak_Number*13;

        if f(ii,jj)<1
            Sim_13intensities = Y(locs_C2(1:Peak_Number))/integ_Y;
            g(ii,jj) = sum(abs(Exp_13intensities(1:Peak_Number)-Sim_13intensities(1:Peak_Number)).^2)/Peak_Number*10;
            
        end
            
            
    end
    count = count+1
    

end


%% plot setting after optimization
% plot(X,Y/integ_Y*1.2,'r') 
% hold on
% plot(X_exp,Y_exp/scale_factor)
% 
% set(gca,'Xdir','reverse','Xlim',[8900 8920])

