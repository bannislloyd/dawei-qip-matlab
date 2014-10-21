%Function which calculates fidelity of spectrum to calculated one.
%Uses FID or spectral fitting
%Takes in new chemical shifts and coupling values

function goodness = fidelity1(current,spins,params,rhobase,obsmatbase,expFID,expspec,t,scaling,natabunT2s,gaussianamt,expct)

global tx ty tz
global simFID freqs

%Update spins structure
for obsct = 1:1:length(params.nucobs{expct})
        spins.freqs(params.nucobs{expct}(obsct)) = current(obsct);
end

couplingct = 1;
done = [];
for obsct = 1:1:length(params.nucobs{expct})
    nuc1 = params.nucobs{expct}(obsct);
    for nuc2 = 1:1:length(spins.freqs)
       %Now sort out whether these are not the same and whether it has already
       %been done
       nucsrt = sort([nuc1 nuc2]);
       donechk = nucsrt(1)*(spins.nb+1) + nucsrt(2);
       if(nuc1~=nuc2 & isempty(find(donechk == done)))
          spins.jfreqs(nuc1,nuc2) = current(length(params.nucobs{expct})+couplingct);
          spins.jfreqs(nuc2,nuc1) = current(length(params.nucobs{expct})+couplingct);
          couplingct =  couplingct +1;
          done(end+1) = donechk;
       end
    end
end


%First run normal peaks
%Update Hamiltonian
%Create the natural Hamiltonian and diagonalize it
HNAT = CreateHamiltonian(spins);
[V,D] = eig(HNAT);
D = diag(D);

%Transform observable matrix and thermal density matrix
%First evolve the density matrix for the deadtime
prop = expm(-i*params.de{expct}*HNAT);
rhobase = prop*rhobase*prop';
obsmat = V'*obsmatbase*V;
rhoV = V'*rhobase*V;

%First let's find which terms of the density matrix we need to look at.  
[r,c] = find(abs(obsmat)>1e-6);
whichterms = [r c];

%Define the T2 for each coherence
T2mat = getT2(V,spins,params.nucobs{expct}); 

%Okay now we know which terms to care about we can make the fid

%Now calculate the FID this density matrix gives.  
simFID = zeros(size(t));

for ct = 1:1:size(whichterms,1)
    a = whichterms(ct,1);
    b = whichterms(ct,2);
    freq = D(b) - D(a);
   
    %Check to make sure frequency is in obsrange to avoid aliasing
    if(freq > freqs(1)*2*pi & freq < freqs(end)*2*pi)
        T2 = T2mat(a,b);
        
        simFID = simFID + rhoV(b,a)*obsmat(a,b)*exp(i*freq*t - (1-gaussianamt)*1/T2*t - gaussianamt*(1/T2^2)*t.^2);
    end
end
simFID = scaling(1)*simFID;

%Now if we also want the natural abundance peaks let's add them in
if(params.natabunflag)
    %First create the Hamiltonian,
    spins_natabun = spins;
    spins_natabun.jfreqs = zeros(size(spins.jfreqs));
    
    for obsct = 1:1:length(params.nucobs{expct})
        spins_natabun.T2(params.nucobs{expct}(obsct)) = natabunT2s(obsct);
    end
    
    HNAT = CreateHamiltonian(spins_natabun);

    [V,D] = eig(HNAT);
    D = diag(D);

    %Transform observable matrix and thermal density matrix
    prop = expm(-i*params.de{expct}*HNAT);
    rhobase = prop*rhobase*prop';
    obsmat = V'*obsmatbase*V;
    rhoV = V'*rhobase*V;

    %First let's find which terms of the density matrix we need to look at.  
    [r,c] = find(abs(obsmat)>1e-6);
    whichterms = [r c];

    %Define the T2 for each coherence
    T2mat = getT2(V,spins_natabun,params.nucobs{expct}); 
   
    %Okay now we know which terms to care about we can make the fid

    %Now calculate the FID this density matrix gives.  
    simFIDtemp = zeros(size(t));

    for ct = 1:1:size(whichterms,1)
        a = whichterms(ct,1);
        b = whichterms(ct,2);
        freq = D(b) - D(a);
    
        %Check to make sure frequency is in obsrange to avoid aliasing
        if(freq > freqs(1)*2*pi & freq < freqs(end)*2*pi)
            
            T2 = T2mat(a,b);
            simFIDtemp = simFIDtemp + rhoV(b,a)*obsmat(a,b)*exp(i*freq*t - (1-gaussianamt)*1/T2*t - gaussianamt*(1/T2^2)*t.^2);
        end
    end

    simFID = simFID + scaling(2)*simFIDtemp;

end %natural abundance flag

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [T2mat] = getT2(V,spins,whichspins)

global tx ty tz 

nbspin = log2(size(V,1));

%Leave unknown coherences as the average T2 (I don't know else to deal with
%these forbidden transistions).

T2mat = ones(2^nbspin)*mean(spins.T2(whichspins));

for ct = 1:1:length(whichspins);
    obsspin = whichspins(ct);
	obsmatT2 = V'*(tx{obsspin}-i*ty{obsspin})*V;

    T2mat(find(abs(obsmatT2)>0.5)) = spins.T2(obsspin);
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

