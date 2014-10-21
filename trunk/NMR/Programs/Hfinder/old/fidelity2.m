%Function which calculates fidelity of spectrum to calculated one.
%Uses FID or spectral fitting
%Takes in new amplitude and T2 values

function goodness = fidelity2(current,spins,params,rho,obsmat,D,whichterms,T2s,expFID,expspec,t,expct)

global freqs
global simFID tx ty tz

%Gaussian amount
gaussianamt = current(end);

%Update spins
for obsct = 1:1:length(params.nucobs{expct})
    spins.T2(params.nucobs{expct}(obsct)) = current(obsct);
end

%Run labelled system

%Calculate the simulated FID
simFID = zeros(size(t));

rhotemp = rho{1};
whichtermstemp = whichterms{1};
T2stemp = T2s{1};
Dtemp = D{1};
obsmattemp = obsmat{1};


for ct = 1:1:size(whichtermstemp,1)
          a = whichtermstemp(ct,1);
          b = whichtermstemp(ct,2);
          freq = Dtemp(b) - Dtemp(a);
    
        %Check to make sure frequency is in obsrange to avoid aliasing
        if(freq > freqs(1)*2*pi & freq < freqs(end)*2*pi)
            T2 = spins.T2(T2stemp(a,b));
            simFID = simFID + rhotemp(b,a)*obsmattemp(a,b)*exp(i*freq*t - (1-gaussianamt)*1/T2*t - gaussianamt*(1/T2^2)*t.^2) ;
        end
end


if(params.natabunflag)
    simFID = current(end-2)*simFID;
else
    simFID = current(end-1)*simFID;
end

%If we want, add in natural abundance peaks
if(params.natabunflag)
    spins_natabun = spins;
    for obsct = 1:1:length(params.nucobs{expct})
        spins_natabun.T2(params.nucobs{expct}(obsct)) = current(obsct+length(params.nucobs{expct}));
    end

    
    %Calculate the simulated FID
    simFIDtemp = zeros(size(t));

    rhotemp = rho{2};
    whichtermstemp = whichterms{2};
    T2stemp = T2s{2};
    Dtemp = D{2};
    obsmattemp = obsmat{2};

    for ct = 1:1:size(whichtermstemp,1)
         a = whichtermstemp(ct,1);
         b = whichtermstemp(ct,2);
         freq = Dtemp(b) - Dtemp(a);
    
        %Check to make sure frequency is in obsrange to avoid aliasing
        if(freq > freqs(1)*2*pi & freq < freqs(end)*2*pi)
            T2 = spins_natabun.T2(T2stemp(a,b));
            simFIDtemp = simFIDtemp + rhotemp(b,a)*obsmattemp(a,b)*exp(i*freq*t - (1-gaussianamt)*1/T2*t - gaussianamt*(1/T2^2)*t.^2) ;
        end
    end

    simFID = simFID + current(end-1)*simFIDtemp;
    
end %natabunflag

simFID = transpose(simFID);

%Now calculate the fidelity of the fit
if(strcmp(params.fittype,'FID'))
    goodness = abs(real(expFID) - real(simFID)) + abs(imag(expFID) - imag(simFID));

    if(params.firstplot);
        figure
        plot(real(simFID),'r');
        hold on
        plot(real(expFID),'b');
        figure
        plot(freqs,real(cfft(simFID)),'r');
        hold on
        plot(freqs,real(cfft(expFID)),'b');
        pause
    end


elseif(strcmp(params.fittype,'spectrum'))
   
    %Fourier transform the signal and extract the relevant part
    padding = (1/params.ratio{expct} -1)*length(simFID);
    simFIDtmp = [simFID; zeros(padding,1)];
    simspec = cfft(simFIDtmp);
    sl = length(simspec);
    simspec = exp(i*params.phcor{expct}(1))*simspec.*exp(i*params.phcor{expct}(2)*freqs/(freqs(end)-freqs(1)));
    simspec = real(simspec); 
    blccutoff  = floor(length(simspec)/20);
    blc = mean([simspec(1:blccutoff); simspec(end-blccutoff:end)]);
    simspec = simspec - blc;
    startpt = floor(params.fitportion{expct}(1)*length(simspec))+1;
    endpt = floor(params.fitportion{expct}(2)*length(simspec));
    simspec = simspec(startpt:endpt);
   
 
    goodness = simspec-expspec;
 
   if(params.firstplot)
        figure
        plot(freqs(startpt:endpt),simspec,'r')
        hold on
        plot(freqs(startpt:endpt),expspec,'b')
        pause
    end

elseif(strcmp(params.fittype,'intcurve'))
   
    %Fourier transform the signal and extract the relevant part
    padding = (1/params.ratio{expct} -1)*length(simFID);
    simFIDtmp = [simFID; zeros(padding,1)];
    simspec = cfft(simFIDtmp);
    sl = length(simspec);
    simspec = exp(i*params.phcor{expct}(1))*simspec.*exp(i*params.phcor{expct}(2)*freqs/(freqs(end)-freqs(1)));
    simspec = real(simspec); 
    blccutoff  = floor(length(simspec)/20);
    blc = mean([simspec(1:blccutoff); simspec(end-blccutoff:end)]);
    simspec = simspec - blc;
    startpt = floor(params.fitportion{expct}(1)*length(simspec))+1;
    endpt = floor(params.fitportion{expct}(2)*length(simspec));
    simspec = simspec(startpt:endpt);
   
  goodness = cumsum(simspec/sum(simspec)) - cumsum(expspec/sum(expspec));

else
    error('Your params.fittype does not correspond to FID or spectrum')
end

return


%
% Matlab function.
%
% Centered fourier transform: spectrum goes from -swh/2 to +swh/2.
%
%%%
function spec = cfft(fid);

tspec = fft(fid); sl = length(tspec);
spec = [tspec(sl/2+1:sl);tspec(1:sl/2)];

return;


