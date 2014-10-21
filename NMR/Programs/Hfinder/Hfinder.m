%This function fits the thermal spectra.  It will spit out
%the nuclei file at the end.  It requires an appropriate paramaters file
%and perhaps adjustment of the Create_Hamiltonian file

%Written by Colm Ryan 9 September, 2005
%Updated by Colm 10 Novermber 2005 to include frequecies in plotting
%Updated by Colm 5 May, 2006 to better handle strong coupling and to handle
%gaussian line shapes
%Updated by Colm 6 June, 2006 to handle "de" and phcor1
%Updated by Colm 23 January, 2008 to handle multiple experiments and to fit
%everything at once

%function Hfinder(parameterfile)

function resnorm = Hfinder(parameterfile)

global tx ty tz 
global simFID freqs

disp('Starting to fit the spectra....');

%Load the parameter file
params = eval(parameterfile);

%Read in the initial nuclei file for Hamiltonian
spins = read_nucleus_file(params.nuclei);

%Should put in a spins.ignore possibility here

%Make a vector of all the couplings and how many times they've been updated
coupct = 0;
for nuc1 = 1:1:spins.nb
    for nuc2 = nuc1+1:1:spins.nb
        coupct = coupct+1;
        coups_svd{coupct}.values = spins.jfreqs(nuc1,nuc2);
        coups_svd{coupct}.updatect = 0;
    end
end

%First some nice paulis from Osama 
[tx,ty,tz]=observablesM(spins.nb);

%Loop over the number of experiments
for expct = 1:1:length(params.expnum)
    
    %Set up the thermal density matrix if necessary
    if(isempty(params.rhoin))
    rhobase = 0;
    for nucct = 1:1:length(params.nucobs{expct})
        rhobase = rhobase + tx{params.nucobs{expct}(nucct)};
    end
    else
        rhobase = params.rhoin{expct};
    end
    
    %Load the experimental data
    datastr = sprintf('%s/%d',params.datadir,params.expnum(expct));
    spectr = getspec(datastr,1);
 
    %Apply the ratioing and make the time vector
    expFID = ifft(ifftshift(spectr.spec));
    expFID = transpose(expFID(1:end*params.ratio{expct}));
    td = length(expFID);    
    swh = spectr.swh;
    t = [0:1:td-1]./swh;
    
    %Scale the FID to 1
    expFID = expFID/max(abs(expFID));

    %Apply the line broadening (don't do last 100 points for baseline
    %effects)
    if(params.ratio{expct} > 0.99)
    expFID = [exp(-params.lb{expct}*t(1:end-50)) ones(1,50)].*expFID; 
    else
        expFID = exp(-params.lb*t).*expFID;
    end
    
    %Convert back to spectrum and extract the fit portion
    expspec = fftshift(fft(expFID));
    startpt = floor(params.fitportion{expct}(1)*length(expspec))+1;
    endpt = floor(params.fitportion{expct}(2)*length(expspec));
    expspec = real(expspec(startpt:endpt));
    
    %Setup the frequency vector
    N = length(expFID);
    freqs = ((-N/2:N/2-1)*spectr.swh/N);
    
    %Setup the observables matrix 
    obsmatbase = 0;
    for obsnuc = params.nucobs{expct}
      obsmatbase = obsmatbase + tx{obsnuc}-1i*ty{obsnuc};
    end

    %Now we can finally call the optimization procedure

    %Set up initial guess for the chemical shift and couplings
    %Have to figure out which couplings we care about (basically anything
    %that is observed) and store in vector optcopus
    initialcscoup = [];
    UBcscoup = [];
    LBcscoup = [];
    for obsnuc = params.nucobs{expct}
        initialcscoup(end+1) = spins.freqs(obsnuc) - (params.o1ref == 0)*spectr.o1;
        UBcscoup(end+1) = initialcscoup(end) + params.csrange(obsnuc);
        LBcscoup(end+1) = initialcscoup(end) - params.csrange(obsnuc);
    end

    coupct = 0;
    optcoups = [];
    for nuc1 = 1:1:spins.nb
        for nuc2 = nuc1+1:1:spins.nb
            coupct = coupct+1;
            if(ismember(nuc1,params.nucobs{expct}) || ismember(nuc2,params.nucobs{expct}))
                if(params.couprange(nuc1,nuc2) ~= 0)
                    initialcscoup(end+1) = spins.jfreqs(nuc1,nuc2);
                    UBcscoup(end+1) = spins.jfreqs(nuc1,nuc2) + params.couprange(nuc1,nuc2);
                    LBcscoup(end+1) = spins.jfreqs(nuc1,nuc2) - params.couprange(nuc1,nuc2);
                    optcoups(end+1) = coupct;
                end
            end
        end
    end
    
    initialampT2 = [];
    UBampT2 = [];
    LBampT2 = [];
    for obsnuc = params.nucobs{expct}
        initialampT2(end+1) = spins.T2(obsnuc);
        UBampT2(end+1) = spins.T2(obsnuc)*1.5;
        LBampT2(end+1) = spins.T2(obsnuc)*0.5;
    end
    
    if(params.natabunflag)
        initialampT2 = [initialampT2 initialampT2 params.initialscaling{expct}];
        UBampT2 = [UBampT2 UBampT2 2*params.initialscaling{expct}];
        LBampT2 = [LBampT2 LBampT2 0.5*params.initialscaling{expct}];
    else
        initialampT2 = [initialampT2 params.initialscaling{expct}];
        UBampT2 = [UBampT2 2*params.initialscaling{expct}];
        LBampT2 = [LBampT2 0.5*params.initialscaling{expct}];
        
    end

    %Initialize the gaussian amount to zero
    gaussianamt = 0.2;
    
    %Run the fit
    [fitresults,resnorm] = lsqnonlin(@fidelity,[initialcscoup initialampT2 gaussianamt],[LBcscoup LBampT2 0],[UBcscoup UBampT2 params.maxgaussian],params.opt,spins,params,rhobase,obsmatbase,expFID,expspec,t,expct,optcoups);
 
   
    %Plot the results
    if(params.plot)
        figure
        simspec = real(fftshift(fft(simFID)));
        blccutoff  = floor(length(simspec)/20);
        blc = mean([simspec(1:blccutoff) simspec(end-blccutoff:end)]);
        simspec = simspec - blc;
        startpt = floor(params.fitportion{expct}(1)*length(simspec))+1;
        endpt = floor(params.fitportion{expct}(2)*length(simspec));
        simspec = simspec(startpt:endpt);
        plot(freqs(startpt:endpt),simspec,'r');
        hold on
        plot(freqs(startpt:endpt),expspec,'b');
        pause(0.5)
    end

    %Update spins structure
    %The first few are the chemical shifts
    %Update spins structure
    for obsnuc = params.nucobs{expct}
        spins.freqs(obsnuc) = fitresults(1) + (params.o1ref == 0)*spectr.o1; fitresults(1) = [];
    end

    %The next set are the couplings we care about
    coupct = 0;
    for nuc1 = 1:1:spins.nb
        for nuc2 = nuc1+1:1:spins.nb
            coupct = coupct +1;
            if(ismember(coupct,optcoups))
                coups_svd{coupct}.updatect = coups_svd{coupct}.updatect+1;
                coups_svd{coupct}.values(coups_svd{coupct}.updatect) = fitresults(1);
                spins.jfreqs(nuc1,nuc2) = mean(coups_svd{coupct}.values);
                fitresults(1) = [];
            end
        end
    end

    %Now the next section is the T2's
    for obsnuc = params.nucobs{expct}
        spins.T2(obsnuc) = fitresults(1); fitresults(1) = [];
    end

    %Gaussian amount in fit
    disp(sprintf('The amount of gaussian used was %f',fitresults(end)));

    if(params.natabunflag)
        disp(sprintf('\n\nFinal ratio between labelled and unlabelled is %f and initial scaling is [%f %f].',fitresults(end-1)/fitresults(end-2),fitresults(end-2),fitresults(end-1)));

        disp('The T2s used for the natural abundance peaks were,');
        for nucct = 1:1:length(params.nucobs{expct})
            fprintf('%f\t%s\n',fitresults(nucct),spins.nucNames{params.nucobs{expct}(nucct)});
        end
    end


end %expct loop
newnucleifile(spins,params.nuclei);

disp('Finished!');

return

%********************* SUB FUNCTIONS ******************************%
function [termsx,termsy,termsz]=observablesM(n)

%First version O.Moussa feb2004

u= [1,0;0,1];
x = 0.5*[0,1;1,0]; %these are spin 1/2 ops, not bare pauli matrices. 
y = 0.5*[0,-i;i,0];
z = 0.5*[1,0;0,-1];


for(k=1:n)
    m=1;
    termx=1;
    termy=1;
    termz=1;
    while(m<=n)
        
        if(m==k)
            termx=kron(termx,x);
            termy=kron(termy,y);
            termz=kron(termz,z);
        else
            termx=kron(termx,u);
            termy=kron(termy,u);
            termz=kron(termz,u);
        end
        m=m+1;
    end
    termsx{k}=termx;
    termsy{k}=termy;
    termsz{k}=termz;
end

return
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [T2mat] = getT2(V,whichspins)

%This version returns the spin number for use in fidelity2

global tx ty tz 

%Choose a random one for the forbidden coherences
T2mat = whichspins(fix(length(whichspins)*rand(size(V)))+1);

for ct = 1:1:length(whichspins);
    obsspin = whichspins(ct);
	obsmatT2 = V'*(tx{obsspin}-i*ty{obsspin})*V;

    T2mat(find(abs(obsmatT2)>0.5)) = obsspin;
end


return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function newnucleifile(spins,filename)

%Open the nuclei file
nucfile = fopen(filename,'w');

fprintf(nucfile,'# Nuclear types\n');
for nucct = 1:1:length(spins.larmor)
    fprintf(nucfile,'%g\t%s\n',spins.larmor(nucct),spins.typeNames{nucct});
end

fprintf(nucfile,'# Nuclei: <frequency><tab><name><tab><type>\n');
for nucct = 1:1:length(spins.freqs)
    fprintf(nucfile,'%f\t%s\t%s\n',spins.freqs(nucct),spins.nucNames{nucct},spins.typeNames{spins.nucs(nucct)});
end

fprintf(nucfile,'# Reference frequencies:\n');
for nucct = 1:1:length(spins.typeNames)
    fprintf(nucfile,'refFreq\t%s\t',spins.typeNames{nucct});
    nuctypes = find(spins.nucs == nucct);
    refFreqstr = [];
    for ct = 1:1:length(nuctypes)
        refFreqstr = [refFreqstr sprintf('%s;',spins.nucNames{nuctypes(ct)})];
    end
    fprintf(nucfile,refFreqstr(1:end-1));
    fprintf(nucfile,'\n');
    fprintf(nucfile,'offsetFreq\t%s\t0\n',spins.typeNames{nucct});
end

fprintf(nucfile,'# Couplings:  <frequency><tab><name><tab><name> (must be in lex. order.)\n');
for a = 1:1:length(spins.freqs)
    for b = a+1:1:length(spins.freqs)
        fprintf(nucfile,'%f\t%s\t%s\n',spins.jfreqs(a,b),spins.nucNames{a},spins.nucNames{b});
    end
end

fprintf(nucfile,'# T2 error rates:\n');
for nucct = 1:1:length(spins.T2)
    fprintf(nucfile,'%f\t%s\n',spins.T2(nucct),spins.nucNames{nucct});
end

fprintf(nucfile,'# End data\n');

fclose(nucfile);

return
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Matlab function.
%
% Splits a string into a cell array of
% words which are separated by a given substr.
%
%%%
function A = split(string, substr);

  A = {};
  pos = [-length(substr)+1, findstr(substr, string), length(string)+1];
  for n = 1:length(pos)-1;
    A{n} = string(pos(n)+length(substr):pos(n+1)-1);
  end;

return;

