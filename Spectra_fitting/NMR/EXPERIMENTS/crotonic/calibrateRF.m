
function calibrateRF(db,ref_exp_nb,refspec);
% Alexandre July 2009 Program to calibrate power level of RFsel
% function calibrate(db,ref_exp_nb,refspec,name,targfolder);
% 
% db is the power level from each experiment
% ref_exp_nb is a vector with number of the experiments 
% refspec is the number of a refence signal
% tragfolder is the folder where the experimental data were saved  
% with getcalib 
% name is the name of the pulse you want to calibrate 
%
% 
%
%
targfolder = '/home/g5feng/NMR/EXPERIMENTS/ErrorC/results';
name = 'Pulse'; 

%=======================================================================
% Sort Data
[db inddb] = sort(db);

ref_exp_nb =  ref_exp_nb(inddb);

%=======================================================================
% Open Spectra
for a=1:length(ref_exp_nb)
   spec{a} = getspec([targfolder num2str(ref_exp_nb(a))],1);
end;

%==========================================================================
% Create frequency axis, select the region -50hz and +50hz around o1 
% and perform numerical integration in this region
freq = [-100 100];

for a=1:length(ref_exp_nb)

        dt = 1/spec{a}.swh;
        fr = (1/dt)*(0:spec{a}.si-1)/spec{a}.si - spec{a}.swh/2;
        
        x1 = round(spec{a}.si*dt*(freq(1) + spec{a}.swh/2));
        x2 = round(spec{a}.si*dt*(freq(2) + spec{a}.swh/2));
        
        ss{a} = real(spec{a}.spec(x1:x2));
        fr2 = fr(x1:x2); 
       
        amp(a) = trapz(ss{a});
      
end


%==========================================================================
% Same thing for reference spectra

       specr = getspec([targfolder num2str(refspec)],1);
       
       dt = 1/specr.swh;
       
       fr = (1/dt)*(0:specr.si-1)/specr.si - specr.swh/2;
        
       x1 = round(specr.si*dt*(freq(1) + specr.swh/2));
        
       x2 = round(specr.si*dt*(freq(2) + specr.swh/2));
        
       ssr = real(specr.spec(x1:x2));
       
       frr = fr(x1:x2); 
       
       ampr = trapz(ssr);
       
%==========================================================================
%Normalization
amp = amp/ampr;
%==========================================================================
%==========================================================================
% Interpolation 

xx = (min(db)-0.1):0.001:(max(db)+0.1);

y1 = spline(db,amp,xx);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(db,amp,'o',xx,xx*0,'r',xx,y1,'k');
title(['Calibration  ' name]);
xlabel('DB');
ylabel('Amplitude (a.u)');
axis([min(xx) max(xx) min(amp)-0.1 max(amp)+0.1])

clc
[aa bb]=max(y1);
disp(xx(bb))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


