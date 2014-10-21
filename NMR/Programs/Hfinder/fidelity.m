%Function which calculates fidelity of spectrum to calculated one.
%Uses FID or spectral fitting
%Takes in new chemical shifts and coupling values

function goodness = fidelity(current,spins,params,rhobase,obsmatbase,expFID,expspec,t,expct,optcoups)

global simFID freqs

%First we need to parse the input vector of current and chomp it off as we
%go

%The first few are the chemical shifts 
%Update spins structure
for obsnuc = params.nucobs{expct}
        spins.freqs(obsnuc) = current(1); current(1) = [];
end

%The next set are the couplings we care about
coupct = 0;
for nuc1 = 1:1:spins.nb
    for nuc2 = nuc1+1:1:spins.nb
        coupct = coupct +1;
        if(ismember(coupct,optcoups))
            spins.jfreqs(nuc1,nuc2) = current(1);
            current(1) = [];
        end
    end
end

%Now the next section is the T2's
for obsnuc = params.nucobs{expct}
    spins.T2(obsnuc) = current(1); current(1) = [];
end

%Finally the gaussianamt and overall scaling
gaussianamt = current(end);
scaling = current(end-1);
current(end-1:end) = [];

%So now what is left in current is the natural abundance properties:
%the natural abundance T2's and proportion

%First run normal peaks
%Update Hamiltonian
%Create the natural Hamiltonian and diagonalize it
HNAT = CreateHamiltonian(spins);
[V,D] = eig(HNAT);
D = diag(D);

%Transform observable matrix and thermal density matrix
%First evolve the density matrix for the deadtime
if(params.de{expct} ~= 0)
    prop = expm(-1i*params.de{expct}*HNAT);
    rhobase = prop*rhobase*prop';
end
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
    if(freq > freqs(1)*2*pi && freq < freqs(end)*2*pi)
        T2 = T2mat(a,b);
        
        simFID = simFID + rhoV(b,a)*obsmat(a,b)*exp(1i*freq*t - (1-gaussianamt)*1/T2*t - gaussianamt*(1/T2^2)*t.^2);
    end
end
simFID = scaling*simFID;

%Now if we also want the natural abundance peaks let's add them in
if(params.natabunflag)
    %First create the Hamiltonian,
    spins_natabun = spins;
    spins_natabun.jfreqs = zeros(size(spins.jfreqs));
    
    for obsnuc = params.nucobs{expct}
        spins_natabun.T2(obsnuc) = current(1); current(1) = [];
    end
    
    HNAT = CreateHamiltonian(spins_natabun);

    [V,D] = eig(HNAT);
    D = diag(D);

    %Transform observable matrix and thermal density matrix
    if(params.de{expct} ~= 0)
        prop = expm(-1i*params.de{expct}*HNAT);
        rhobase = prop*rhobase*prop';
    end
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
        if(freq > freqs(1)*2*pi && freq < freqs(end)*2*pi)
            
            T2 = T2mat(a,b);
            simFIDtemp = simFIDtemp + rhoV(b,a)*obsmat(a,b)*exp(1i*freq*t - (1-gaussianamt)*1/T2*t - gaussianamt*(1/T2^2)*t.^2);
        end
    end

    simFID = simFID + current(end)*simFIDtemp;

end %natural abundance flag

%Apply exponential smoothing
if(params.lb{expct} ~= 0)
    simFID = exp(-params.lb{expct}*t).*simFID;
end

%Now calculate the fidelity of the fit
if(strcmp(params.fittype,'FID'))
    goodness = abs(real(expFID) - real(simFID)) + abs(imag(expFID) - imag(simFID));

    if(params.firstplot);
        figure
        plot(real(simFID),'r');
        hold on
        plot(real(expFID),'b');
        figure
        plot(freqs,real(fftshift(fft(simFID))),'r');
        hold on
        plot(freqs,real(fftshift(fft(expFID))),'b');
        pause
    end

elseif(strcmp(params.fittype,'spectrum'))

    %Fourier transform the signal and extract the relevant part
    simspec = fftshift(fft(simFID));
    if(~isempty(find(params.phcor{expct}, 1)))
        simspec = exp(1i*params.phcor{expct}(1))*simspec.*exp(1i*params.phcor{expct}(2)*freqs/(freqs(end)-freqs(1)));
    end
    simspec = real(simspec); 
    blccutoff  = floor(length(simspec)/20);
    blc = mean([simspec(1:blccutoff) simspec(end-blccutoff:end)]);
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
    simspec = fftshift(fft(simFID));
    simspec = exp(1i*params.phcor{expct}(1))*simspec.*exp(1i*params.phcor{expct}(2)*freqs/(freqs(end)-freqs(1)));
    simspec = real(simspec); 
    blccutoff  = floor(length(simspec)/20);
    blc = mean([simspec(1:blccutoff) simspec(end-blccutoff:end)]);
    simspec = simspec - blc;
    startpt = floor(params.fitportion{expct}(1)*length(simspec))+1;
    endpt = floor(params.fitportion{expct}(2)*length(simspec));
    simspec = simspec(startpt:endpt);
    
    goodness = cumsum(simspec) - cumsum(expspec);
    
    if(params.firstplot)
        figure
        plot(freqs(startpt:endpt),simspec,'r')
        hold on
        plot(freqs(startpt:endpt),expspec,'b')
        pause
    end
    
else
    error('Your params.fittype does not correspond to FID or spectrum')
end


return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [T2mat] = getT2(V,spins,whichspins)

global tx ty  

nbspin = log2(size(V,1));

%Leave unknown coherences as the average T2 (I don't know else to deal with
%these forbidden transistions).

T2mat = ones(2^nbspin)*mean(spins.T2(whichspins));

for ct = 1:1:length(whichspins);
    obsspin = whichspins(ct);
	obsmatT2 = V'*(tx{obsspin}-1i*ty{obsspin})*V;

    T2mat(abs(obsmatT2)>0.5) = spins.T2(obsspin);
end


return


