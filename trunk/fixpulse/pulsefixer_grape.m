%The program iteratively fixes soft shape pulses on the spectrometer to
%correct for amplitude and phase imperfections.  
%
%Written by Colm Ryan 6 January, 2006
%Updated by Colm Ryan 24 March,2006 to handle a subtlety with the decimation
%Updated by Colm Ryan 6 April, 2006 to handle smooth pulses
%Updated by Colm Ryan 22 July,2006 to fit overlapping periods and
%then average to smooth out discontinuities between fitting periods
%Updated by Colm Ryan 18 October, 2006 to handle soft files which
%are discretized below 1us

%Update by Colm and Adam 13 August, 2007 to smooth input and output
%files using Butterworth lowpass filter (gets rid of noise source
%at 700MHz and nicely smooth discontinuties in the fixed pulse
%but may cause issues on other systems).  Also added
%tried pulse to plots.  Added possiblity of fast point to point
%correction. Added loop dependent damping.

% function pulsefixer_grape(params)

params.pulselength = 0.004;
params.loopnb = 2;
params.refscaling = 364.961378;
params.refangle = 343.760967;
params.idealpulsestr = '12spin_7PPS_U_90_1234567.txt';
params.triedpulsestr = '12spin_7PPS_U_90_1234567.txt';
params.newshpfilename = 'testaaa';
%First some parameters 
user = 'd29lu';

pulselength = params.pulselength;


%dw = 2e-6;  %for Gina 
dw = 10e-6;    %for Jingfu

%softdiscrt = 4e-6; % for Gina 
%softdiscrt =1e-6; % for Jingfu,% Carbon
softdiscrt = 20e-6 ; %for Jingfu Dec 22,2008


%damping = [0.5 0.75 1 1 0.75 0.5 0.5 0.5 0.5 0.5]; %not good for sig
% damping = [0.25 0.25 0.5 0.5 0.5 0.5 0.5 0.5 0.3 0.3 0.1 0.1 0.5];
%damping = [1 0.85 0.75 0.5 0.125 0.25 0.5]; %gpsp_1
%damping = [1 0.75 0.5 0.25 0.75 1]%sigmas
damping = [1 0.8 0.5 0.2 0.1 0.05 0.3 0.2 0.1 0.05 0.05 0.025 0.05 0.05 0.05]; %for C


%damping = [0.5 0.5 0.3 0.3 0.1 0.1 0.05 0.1 0.1 0.5 0.5 0.25]; %for TTMSA_H

% damping = [1 1 1 1 1 1 1 1 1 1];%testing rf amplifier fluctuation
damping = damping(params.loopnb);
predelay = 270e-6;
startpt = fix(predelay/(dw*2)+1);
endpt = startpt-1+fix(pulselength/(dw*2));

%Filter cutoff frequency
%cutoff = 1e5;
cutoff = 1e5/16;
%cutoff=1e5/4;
%Filter notch frequency
notch = 1.33e5; 

%%%%%%%%%%%%%%%%%%%%%%%%
%Load the pulse fid
fidfile = fopen(['curfid'],'r','ieee-be');
if fidfile < 0; fprintf(2, 'Error opening FID.\n'); return; end;

FID = fread(fidfile,inf,'int32');
realFID = FID(1:2:end) - mean(FID(1:2:20));
imagFID = FID(2:2:end) - mean(FID(2:2:20));

FID = realFID(startpt:endpt) -i*imagFID(startpt:endpt);

%Scale the FID and adjust the phase according to the reference
FID = FID*(1/params.refscaling)*exp(-i*pi*params.refangle/180);

%Filter the signal to reduce noise on the 700 
%Apply a Butterworth lowpass filter 10th order

%Sampling frequency
f=1/(2*dw);

%Cutoff for the lowpass normalized to sampling frequency
cutoff = cutoff/(f/2); 


%Filter design
[b,a] = butter(10,cutoff,'low');
% 
% % Notch Filter
% notch=notch/(f/2);                  %GP commented out
% [d,c]= iirnotch(notch,notch/15);    %GP commented out to
% %accommodate 80ms long pulses
% 
% %Apply the notch filter
% FID = filtfilt(d,c,FID);            %GP commented out

%Apply the low pass filter
FID = filtfilt(b,a,FID);  

%Extract quadrature components
realFID = real(FID);
imagFID = imag(FID);

%Interpolate the measured pulse to get the same discretization as the soft file
x = [0:dw*2:pulselength-dw*2]; 
xnew = [0:softdiscrt:pulselength-softdiscrt];
realFID = (interp1(x,realFID,xnew,'linear','extrap'))';
imagFID = (interp1(x,imagFID,xnew,'linear','extrap'))';

%Load the ideal soft file (first open and check for comments)
idealfile = fopen(['pulsefiles/' params.idealpulsestr],'r');
tmpidealfile = fopen('pulsefiles/tmpideal','w');
line = fgets(idealfile);
while(line ~= -1)
    if(strfind(line,'##')); 
    else
        fprintf(tmpidealfile,line);
    end
    line = fgets(idealfile);
end

idealpulse = load('pulsefiles/tmpideal');

%Load the tried pulse
triedfile = fopen(['pulsefiles/' params.triedpulsestr]);
tmptriedfile = fopen('pulsefiles/tmptried','w');
line = fgets(triedfile);
while(line ~= -1)
    if(strfind(line,'##'));
    else
        fprintf(tmptriedfile,line);
    end
    line = fgets(triedfile);
end
triedpulse = load('pulsefiles/tmptried');

%Convert them to quadrature components
idealpulse_real = idealpulse(:,1).*cos(idealpulse(:,2)*pi/180);
idealpulse_imag = idealpulse(:,1).*sin(idealpulse(:,2)*pi/180);
triedpulse_real = triedpulse(:,1).*cos(triedpulse(:,2)*pi/180);
triedpulse_imag = triedpulse(:,1).*sin(triedpulse(:,2)*pi/180);


%Fast point to point correction (works well in most situations and
%is much faster

newpulse_real = triedpulse_real + damping*(idealpulse_real - realFID);
newpulse_imag = triedpulse_imag + damping*(idealpulse_imag - imagFID);

%for kkk=1:(length(idealpulse_real)-4)
%newpulse_real(kkk)=triedpulse_real(kkk)+damping*(idealpulse_real(kkk+4)-realFID(kkk+4));
%newpulse_imag(kkk)=triedpulse_imag(kkk)+damping*(idealpulse_imag(kkk+4)-imagFID(kkk+4));
%end
%newpulse_real=[newpulse_real,zeros(1,4)];
%newpulse_imag=[newpulse_imag,zeros(1,4)];

%Filter the new pulse with same low pass to get rid of discontinuties
%newpulse_real = filtfilt(b,a,newpulse_real);
%newpulse_imag = filtfilt(b,a,newpulse_imag);

%Convert back to amplitude and phase for the new shape file
newpulse_amp = abs(newpulse_real+i*newpulse_imag);
newpulse_phase = (180/pi)*angle(newpulse_real+i*newpulse_imag);

%Write the new shape file
shpfile = fopen(['pulsefiles/' params.newshpfilename],'w');

%First the starting stuff
%Write the first few lines
fprintf(shpfile,'##TITLE= %s\n',params.newshpfilename);
fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
fprintf(shpfile,'##DATA TYPE= Shape Data\n');
fprintf(shpfile,'##ORIGIN= Colm Fixed Pulses \n');
fprintf(shpfile,'##OWNER= %s\n',user);
fprintf(shpfile,'##DATE= %s\n',date);
time = clock;
fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
fprintf(shpfile,'##MINX= %7.6e\n',min(newpulse_amp));
fprintf(shpfile,'##MAXX= %7.6e\n',min(max(newpulse_amp),100));
fprintf(shpfile,'##MINY= %7.6e\n',min(newpulse_phase));
fprintf(shpfile,'##MAXY= %7.6e\n',max(newpulse_phase));
fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
fprintf(shpfile,'##$SHAPE_MODE= 1\n');
fprintf(shpfile,'##NPOINTS= %d\n',length(newpulse_amp));
fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');


%Now write out the pulse
for lnct = 1:1:length(newpulse_amp)
 
    %Make sure magnitude is between zero and 100
    newmag = newpulse_amp(lnct);
    newmag = min(newmag,100);     newmag = max(newmag,0);
    
    newphase = newpulse_phase(lnct);
    fprintf(shpfile,'  %7.6e,  %7.6e\n',newmag,newphase);
    
end
fprintf(shpfile,'##END=');

%Plot the difference
figure
plot(realFID,'r'); hold on; plot(idealpulse_real); plot(triedpulse_real,'g'); 
legend('Measured','Ideal','Tried');
eval(sprintf('saveas(gcf,''figures/%s_real_%i.fig'')',params.idealpulsestr,params.loopnb))
figure
plot(imagFID,'r'); hold on; plot(idealpulse_imag); plot(triedpulse_imag,'g');
legend('Measured','Ideal','Tried');
eval(sprintf('saveas(gcf,''figures/%s_imag_%i.fig'')',params.idealpulsestr,params.loopnb))


%Display the difference
disp(sprintf('The sum square error is %f for the real and %f for the imaginary',sum((realFID-idealpulse_real).^2),sum((imagFID-idealpulse_imag).^2)));

close all

%Close the files
fclose('all');

return
