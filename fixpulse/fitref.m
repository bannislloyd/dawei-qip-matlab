%This function fits the shaperef file to obtain the reference phase and
%scaling for the pulsefixer program.  It expects a shaperef file and a fid
%with a 100us shaperef pulse recorded.  

%Modified by Colm 6 August 2008 to try and get rid of 0-360 problem

%Some constants
pulselength = 100e-6;
%pulselength = 20000e-6;  %by Jingfu, Dec. 31,2008

%dw = 2e-6;  %for Gina 
%dw = 0.5e-6; %for jingfu, carbon

dw = 2.5e-6; %for Jingfu, commented by Jingfu Dec 22,2008

%softdiscrt = 1e-7;

softdiscrt = 1e-7;

predelay = 59e-6;
startpt = fix(predelay/(dw*2)+1);
endpt = startpt-1+fix(pulselength/(dw*2));


%First load the FID and extract the pulse.  
fidfile = fopen(['curfid'],'r','ieee-be');
if fidfile < 0; fprintf(2, 'Error opening FID.\n'); return; end;

FID = fread(fidfile,inf,'int32');
realFID = FID(1:2:end) - mean(FID(1:2:20));
imagFID = FID(2:2:end) - mean(FID(2:2:20));

FID = realFID -i*imagFID;

%Convert to amplitude and phase
ampFID = abs(FID);
ampFID = ampFID(startpt:endpt);
phaseFID = mod((180/pi)*angle(FID),360);
phaseFID = phaseFID(startpt:endpt);

%Fix the 0-360 problem if possible
meanphase = mean(phaseFID);

if(meanphase < 180)
  phaseFID(phaseFID > 330) = phaseFID(phaseFID > 330) - 360;
elseif(meanphase > 180)
  phaseFID(phaseFID < 30) = phaseFID(phaseFID < 30) + 360;
end



%Interpolate the measured pulse to get the same discretization as the soft file
x = [0:dw*2:pulselength-dw*2]; 
xnew = [0:softdiscrt:pulselength-softdiscrt];
interp_ampFID = interp1(x,ampFID,xnew,'linear','extrap');
interp_phaseFID = interp1(x,phaseFID,xnew,'linear','extrap');

%Load the ideal soft file (first open and check for comments)
idealfile = fopen('pulsefiles/shaperef','r');
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


%Now find the best refscaling and refangle
%We will  take the middle points to avoid issues at the end and just take the
%mean and work out the appropriate ratio/difference

startpt = fix(size(idealpulse,1)/4);
endpt = fix(size(idealpulse,1)*5/6);
mean_idealamp = mean(idealpulse(startpt:endpt,1));
mean_idealphase = mean(idealpulse(startpt:endpt,2));
mean_ampFID = mean(interp_ampFID(startpt:endpt));
mean_phaseFID = mean(interp_phaseFID(startpt:endpt));

refscaling = mean_ampFID/mean_idealamp;
refangle = mean_phaseFID - mean_idealphase;

%Write out the results in a file.
resultsfile = fopen('fitref_results.dat','w');
fprintf(resultsfile,'params.refscaling = %f\n',refscaling);
fprintf(resultsfile,'params.refangle = %f\n',refangle);
fclose(resultsfile);


%Plot the difference
figure
plot(interp_ampFID/refscaling,'r'); hold on; plot(idealpulse(:,1));
eval(sprintf('saveas(gcf,''figures/refamp.fig'')'))
%disp('all ok')
plot(mod(interp_phaseFID-refangle,360),'r'); hold on; plot(idealpulse(:,2));
eval(sprintf('saveas(gcf,''figures/refphase.fig'')'))
close all







