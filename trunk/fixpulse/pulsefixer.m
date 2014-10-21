
%The program iteratively fixes soft shape pulses on the spectrometer to
%correct for amplitude and phase imperfections.  
%
%Written by Colm Ryan 6 January, 2006
%Updated by Colm Ryan 24 March,2006 to handle a subtlety with the decimation

function pulsefixer(params)

%First some parameters 
user = 'c4ryan';

pulselength = params.pulselength;

dw = 10e-6;
softdiscrt = 20e-6;
damping = 1;
predelay = 59e-6;
startpt = fix(predelay/(dw*2)+1);
endpt = startpt-1+fix(pulselength/(dw*2));

%Filter notch frequency
notch = 1.316e5;

%%%%%%%%%%%%%%%%%%%%%%%%
%Load the pulse fid
fidfile = fopen(['curfid'],'r','ieee-be');
if fidfile < 0; fprintf(2, 'Error opening FID.\n'); return; end;

FID = fread(fidfile,inf,'int32');
realFID = FID(1:2:end) - mean(FID(1:2:20));
imagFID = FID(2:2:end) - mean(FID(2:2:20));

FID = realFID -i*imagFID;

%Notch Filter
f = 1/(2*dw);
notch=notch/(f/2);
[d,c]= iirnotch(notch,notch/35);

%Convert to amplitude and phase
ampFID = abs(FID)/params.refscaling;
ampFID = ampFID(startpt:endpt);
phaseFID = mod((180/pi)*angle(FID)-params.refangle,360);
phaseFID = (pi/180)*phaseFID(startpt:endpt);

%ampFID = filtfilt(d,c,ampFID);

%Interpolate the measured pulse to get the same discretization as the soft file
x = [0:dw*2:pulselength-dw*2]; 
xnew = [0:softdiscrt:pulselength-softdiscrt];
interp_ampFID = interp1(x,ampFID,xnew,'linear','extrap');
interp_phaseFID = interp1(x,phaseFID,xnew,'linear','extrap');


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

%Now decimate them to reduce to sampling frequency
ptratio = fix(2*dw/softdiscrt + 10*eps);
stpt = 1;
decim_ampideal = idealpulse(stpt:ptratio:end,1)';
decim_amptried = triedpulse(stpt:ptratio:end,1)';
decim_phaseideal = (pi/180)*idealpulse(stpt:ptratio:end,2)';
decim_phasetried = (pi/180)*triedpulse(stpt:ptratio:end,2)';

%Find the periods from the discontinuities in amplitude
periodmrks = find(diff(idealpulse(:,1)'));
periodmrks = [0 periodmrks size(idealpulse,1)];
periodmrks_decim = fix(periodmrks./ptratio);

%Now fit the amplitude and phase for each section with a linear model and make the new pulse
newpulse_amp = zeros(size(idealpulse,1),1);
newpulse_phase = zeros(size(idealpulse,1),1);
newpulse_phase = decim_phaseideal;

linmodel = fittype('a*x+b','coeff',{'a','b'});

for ct = 1:1:length(periodmrks_decim)-1
    periodlength = periodmrks_decim(ct+1)-periodmrks_decim(ct)-6;
    stper = periodmrks_decim(ct)+4; endper = periodmrks_decim(ct+1)-3;
    
    ampstpt = [0 50];
    phasestpt = [0 pi];
    
    %Unwrap the phases and set the measured phase to zero where we
    %have no amplitude (below 1% cutoff)
    
     if(decim_ampideal(stper-3) > 0.1)
    
    fitdata_ampFID = fit([1:1:periodlength]',ampFID(stper:endper),linmodel,'Startpoint',ampstpt);
    fitdata_amptried = fit([1:1:periodlength]',decim_amptried(stper:endper)',linmodel,'Startpoint',ampstpt);
    fitdata_ampideal = fit([1:1:periodlength]',decim_ampideal(stper:endper)',linmodel,'Startpoint',ampstpt);
    fitdata_phaseFID = fit([1:1:periodlength]',unwrap(phaseFID(stper:endper)),linmodel,'Startpoint',phasestpt);
    fitdata_phasetried = fit([1:1:periodlength]',unwrap(decim_phasetried(stper:endper)'),linmodel,'Startpoint',phasestpt);
    fitdata_phaseideal = fit([1:1:periodlength]',unwrap(decim_phaseideal(stper:endper)'),linmodel,'Startpoint',phasestpt);

    newstper = periodmrks(ct)+1; newendper = periodmrks(ct+1); 
   
    newpulse_amp(newstper:newendper) = decim_amptried(newstper:newendper)' + ...
        damping*(fitdata_ampideal.a - fitdata_ampFID.a)/ptratio*[1:1:newendper-newstper+1]' + damping*(fitdata_ampideal.b-fitdata_ampFID.b)*ones(newendper-newstper+1,1);
   % newpulse_phase(newstper:newendper) = decim_phasetried(newstper:newendper)' + ...
   %     damping*(fitdata_phaseideal.a - fitdata_phaseFID.a)/ptratio*[1:1:newendper-newstper+1]' + damping*(fitdata_phaseideal.b-fitdata_phaseFID.b)*ones(newendper-newstper+1,1);
    end
end
    
%Wrap the phase again
newpulse_phase = mod((180/pi)*newpulse_phase,360);
decim_phaseideal = mod((180/pi)*decim_phaseideal,360);
phaseFID = mod((180/pi)*phaseFID,360);

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
fprintf(shpfile,'##MAXX= %7.6e\n',max(newpulse_amp));
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
    newmag = min(newmag,100); newmag = max(newmag,0);
    
    newphase = newpulse_phase(lnct);
    fprintf(shpfile,'  %7.6e,  %7.6e\n',newmag,newphase);
end
fprintf(shpfile,'##END=');

%Plot the difference
figure
plot(ampFID,'r'); hold on; plot(decim_ampideal);
eval(sprintf('saveas(gcf,''figures/%s_Amp_%i.fig'')',params.idealpulsestr,params.loopnb))
figure
plot(phaseFID,'r'); hold on; plot(decim_phaseideal);
eval(sprintf('saveas(gcf,''figures/%s_Phase_%i.fig'')',params.idealpulsestr,params.loopnb))
close all

%Close the files
fclose('all');

return

