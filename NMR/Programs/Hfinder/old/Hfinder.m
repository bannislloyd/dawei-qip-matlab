%This function fits the thermal spectra.  It will spit out
%the nuclei file at the end.  It requires an appropriate paramaters file
%and perhaps adjustment of the Create_Hamiltonian file

%Written by Colm Ryan 9 September, 2005
%Updated by Colm 10 Novermber 2005 to include frequecies in plotting
%Updated by Colm 5 May, 2006 to better handle strong coupling and to handle
%gaussian line shapes
%Updated by Colm 6 June, 2006 to handle "de" and phcor1
%Updated by Colm 23 January, 2008 to handle multiple experiments

%function Hfinder(parameterfile)

function resnorm = Hfinder(parameterfile)

global tx ty tz 
global simFID freqs

disp('Starting to fit the spectra....');

%Randomize the state of the random number generator
rand('state',sum(100*clock));

%Load the parameter file
params = eval(parameterfile);

%Read in the initial nuclei file for Hamiltonian
spins = read_nucleus_file(params.nuclei);

%Should put in a spins.ignore possibility here

%First some nice paulis from Osama 
[tx,ty,tz]=observablesM(spins.nb);

%Loop over the number of experiments
for expct = 1:1:length(params.expnum)
    
    %Set up the thermal density matrix
    rhobase = 0;
    for nucct = 1:1:length(params.nucobs{expct})
        rhobase = rhobase + tx{params.nucobs{expct}(nucct)};
    end
    %rhobase = rhobase + 0.1*tx{1};

    %Load the experimental data
    datastr = sprintf('%s/%d',params.datadir,params.expnum(expct));
    spectr = get_pspec(datastr,1);
    spectr.spec = applyPhase(spectr);
    
    %Apply the ratioing and make the time vector
    expFID = cift(spectr.spec);
    td = length(expFID);    
    swh = spectr.swh;
    t = [0:1:td-1]*1/swh;
    
    expFID = expFID/max(abs(expFID));
    expspec = cfft(expFID);
    expFID = expFID(1:end*params.ratio{expct});
    startpt = floor(params.fitportion{expct}(1)*length(spectr.spec))+1;
    endpt = floor(params.fitportion{expct}(2)*length(spectr.spec));
    expspec = real(expspec(startpt:endpt));
    
    %Setup the frequency vector
    N = length(spectr.spec);
    freqs = ((-N/2:N/2-1)*spectr.swh/N)';
    
    %Setup the observables matrix 
    obsmatbase = 0;
    for nucct=1:1:length(params.nucobs{expct})
      obsmatbase = obsmatbase + tx{params.nucobs{expct}(nucct)}-i*ty{params.nucobs{expct}(nucct)};
    end

    %Now we can finally call the optimization procedure

    %Set up initial guess for the chemical shift and couplings
    %Have to figure out which couplings we care about
    %Keep track of which we have done using base spins.nb+1
    %Should also have something like in Manny's fitter where user can say
    %which fittings to optimize
    initialcscoup = [];
    for obsct = 1:1:length(params.nucobs{expct})
        initialcscoup(obsct) = spins.freqs(params.nucobs{expct}(obsct));
    end
    
    done = [];
    for obsct = 1:1:length(params.nucobs{expct})
        nuc1 = params.nucobs{expct}(obsct);
        for nuc2 = 1:1:length(spins.freqs)
            %Now sort out whether these are not the same and whether it has already
            %been done
            nucsrt = sort([nuc1 nuc2]);
            donechk = nucsrt(1)*(spins.nb+1) + nucsrt(2);
            if(nucsrt(1)~=nucsrt(2) & isempty(find(donechk == done)))
                initialcscoup(end+1) = spins.jfreqs(nuc1,nuc2);
                done(end+1) = donechk;
            end
        end
    end
    
    initialampT2 = [];
    for obsct = 1:1:length(params.nucobs{expct})
        initialampT2(end+1) = spins.T2(params.nucobs{expct}(obsct));
    end
    
    if(params.natabunflag)
        natabunT2s = initialampT2;
        initialampT2 = [initialampT2 initialampT2 params.initialscaling];
       
    else
        natabunT2s = [];
        initialampT2 = [initialampT2 params.initialscaling];
    end

    %Initialize the first guess scaling
    scaling = params.initialscaling;
    
    %Initialize the gaussian amount to zero
    gaussianamt = 0;
    
    %Run the optimization
    for l = 1:1:params.loops
      
       %Hack in a contraint on cs
       %UB = initialcscoup + [200*ones(1,4)  200*ones(1,length(initialcscoup)-4)];
       %LB = initialcscoup - [200*ones(1,4)  200*ones(1,length(initialcscoup)-4)];
        %Fit the CS and couplings first
        disp(sprintf('\nFitting chemical shifts and couplings for experiment %d on loop %d',params.expnum(expct),l));
        [fittedcscoup,resnorm] = lsqnonlin(@fidelity1,initialcscoup,[],[],params.opt,spins,params,rhobase,obsmatbase,expFID,expspec,t,scaling,natabunT2s,gaussianamt,expct);
        initialcscoup = fittedcscoup;
 
        %Do some zero padding and plot
        if(params.plot)
             padding = (1/params.ratio{expct} -1)*length(simFID);
             simFID = [simFID; zeros(padding,1)];
             figure
             simspec = real(cfft(simFID)); 
             blccutoff  = floor(length(simspec)/20);
             blc = mean([simspec(1:blccutoff); simspec(end-blccutoff:end)]);
             simspec = simspec - blc;
             startpt = floor(params.fitportion{expct}(1)*length(simspec))+1;
             endpt = floor(params.fitportion{expct}(2)*length(simspec));
             simspec = simspec(startpt:endpt);
             plot(freqs(startpt:endpt),simspec,'r');
             hold on
             plot(freqs(startpt:endpt),expspec,'b');
             pause(2)
        end
        
        %Update spins structure
        for obsct = 1:1:length(params.nucobs{expct})
            spins.freqs(params.nucobs{expct}(obsct)) = fittedcscoup(obsct);
        end
     
        done = [];
        couplingct = 1;
        for obsct = 1:1:length(params.nucobs{expct})
            nuc1 = params.nucobs{expct}(obsct);
            for nuc2 = 1:1:length(spins.freqs)
                %Now sort out whether these are not the same and whether it has already
                %been done
                nucsrt = sort([nuc1 nuc2]);
                donechk = nucsrt(1)*(spins.nb+1) + nucsrt(2);
                if(nuc1~=nuc2 & isempty(find(donechk == done)))
                    spins.jfreqs(nuc1,nuc2) = fittedcscoup(length(params.nucobs{expct})+couplingct);
                    spins.jfreqs(nuc2,nuc1) = fittedcscoup(length(params.nucobs{expct})+couplingct);
                    couplingct =  couplingct +1;
                    done(end+1) = donechk;
                end
            end
        end
        
       
        %Update Hamiltonian
        %Create the natural Hamiltonian and diagonalize
        HNAT = CreateHamiltonian(spins);

        [V{1},Dtemp] = eig(HNAT);
        D{1} = diag(Dtemp);
        
        %Transform observable matrix and thermal density matrix and evolve
        %by de delay
        obsmat{1} = V{1}'*obsmatbase*V{1};
        prop = expm(-i*params.de{expct}*HNAT);
        rho{1} = V{1}'*prop*rhobase*prop'*V{1};

        %Now find the relevant terms for the acquisition
        [r c] = find(abs(obsmat{1}) > 1e-6);
        whichterms{1} = [r c];
        
        %Finally set-up the T2 list 
        T2s{1} = getT2(V{1},params.nucobs{expct});

        %If we want to include the natural abundance peaks we need to redo everything for those 
        if(params.natabunflag)
            spins_natabun = spins;
            spins_natabun.jfreqs = zeros(size(spins.jfreqs));
    
            HNAT = CreateHamiltonian(spins_natabun);

            [V{2},Dtemp] = eig(HNAT);
            D{2} = diag(Dtemp);

            %Transform observable matrix and thermal density matrix
            obsmat{2} = V{2}'*obsmatbase*V{2};
            prop = expm(-i*params.de{expct}*HNAT);
            rho{2} = V{2}'*prop*rhobase*prop'*V{2};

            %Now find the relevant terms for the acquisition
            [r c] = find(abs(obsmat{2}) > 1e-6);
            whichterms{2} = [r c];
       
            %Finally set-up the T2 list 
            T2s{2} = getT2(V{2},params.nucobs{expct});

        end %natabunflag            
            
            
        %Now fit the amplitudes and T2's
        disp(sprintf('\nFitting amplitudes and T2''s for experiment %d on loop %d',params.expnum(expct),l));
        UB = [inf*ones(1,length(initialampT2)) params.maxgaussian];
        LB = zeros(1,length(initialampT2)+1);
        [fittedampT2,resnorm] = lsqnonlin(@fidelity2,[initialampT2 gaussianamt],LB,UB,params.opt,spins,params,rho,obsmat,D,whichterms,T2s,expFID,expspec,t,expct);
        gaussianamt = fittedampT2(end);
        initialampT2 = fittedampT2(1:end-1);
        fittedampT2 = initialampT2;
        
        if(params.natabunflag)
            natabunT2s = fittedampT2(length(params.nucobs{expct})+1:end-2);
            scaling = fittedampT2(end-1:end);
        else
            scaling = fittedampT2(end);
        end
        
        %Update spins
        for obsct = 1:1:length(params.nucobs{expct})
            spins.T2(params.nucobs{expct}(obsct)) = fittedampT2(obsct);
        end

         %Do some zero padding and plot
        if(params.plot)
             padding = (1/params.ratio{expct} -1)*length(simFID);
             simFID = [simFID; zeros(padding,1)];
             figure
             simspec = real(cfft(simFID)); 
             blccutoff  = floor(length(simspec)/20);
             blc = mean([simspec(1:blccutoff); simspec(end-blccutoff:end)]);
             simspec = simspec - blc;
             startpt = floor(params.fitportion{expct}(1)*length(simspec))+1;
             endpt = floor(params.fitportion{expct}(2)*length(simspec));
             simspec = simspec(startpt:endpt);
             plot(freqs(startpt:endpt),simspec,'r');
             hold on
             plot(freqs(startpt:endpt),expspec,'b');
             pause(2)
        end
        
    end % l loop
end %expct loop

newnucleifile(spins,params.nuclei);

if(params.natabunflag)
    disp(sprintf('\n\nFinal ratio between labelled and unlabelled is %f to %f',...
    scaling(1)/max(scaling),scaling(2)/max(scaling)));

    disp('The T2s used for the natural abundance peaks were,');
    for nucct = 1:1:length(params.nucobs{expct})
        fprintf('%f\t%s\n',natabunT2s(nucct),spins.nucNames{params.nucobs{expct}(nucct)});
    end
end

disp(sprintf('The amount of gaussian used was %f',gaussianamt));

if(params.plot)
    eval(sprintf('saveas(gcf,''%s/finalfit.fig'')',pwd));
end

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



%
% Matlab function
%
% Return a spectrum structure according to processed bruker data.
%
% Input: 
%   path   ; directory for the file information.
%   ; spectral width and frequency of transmitter are
%   ; obtained from the acqus file.
%   The processed data asked for is loaded.
%
% Spectrum structure:
%   .ph  ;phase correction (two element array).
%   .o1  ;center frequency relative to standard.
%   .swh ;spectral width.
%   .fid ;induction decay signal, if available.
%   .spec;spectrum, properly centered.
%
%   Requirement: The lengths of .fid and .spec must be even.
%
%
%%%

function spec = get_pspec(path, pnumber);
  
  spec.ph = [0,0];
  spec.o1 = 0;
  spec.swh = 0;
  
  %filed = fopen([path, sprintf('/pdata/%d/1r', pnumber)], 'r', 'ieee-be'); %for unix formatted
  filed = fopen([path, sprintf('/pdata/%d/1r', pnumber)], 'r', 'ieee-le'); % for windows
  if filed < 0; fprintf(2, 'Error opening 1r.\n'); return; end;
  [pdatar, sl] = fread(filed, inf, 'long');
  fclose(filed);
  
  %filed = fopen([path, sprintf('/pdata/%d/1i', pnumber)], 'r', 'ieee-be'); %for unix
  filed = fopen([path, sprintf('/pdata/%d/1i', pnumber)], 'r', 'ieee-le'); % for windows
  if filed < 0; fprintf(2, 'Error opening 1i.\n'); return; end;
  [pdatai, sl] = fread(filed, inf, 'long');
  fclose(filed);
  
  spec.spec = pdatar(1:sl)+i*pdatai(1:sl);
  
  % Get swh and o1 information:
  filed = fopen([path, '/acqus'], 'r');
  if (filed < 0); filed = fopen([path, '/acqu'], 'r'); end;
  
  acCount = 1;
  while (acCount);
    [acData, acCount] = fscanf(filed, '%[^\n]\n',1);
    [o1,cnt] = sscanf(acData, '##$O1=%f',1);
    if (cnt); spec.o1 = -o1; end;
    [swh,cnt] = sscanf(acData, '##$SW_h=%f',1);
    if (cnt); spec.swh = swh; end;
    [td,cnt] = sscanf(acData, '##$TD=%d',1);
    if (cnt); spec.td = td/2; end;
  end;
  fclose(filed);
  
  % Get scaling and phase correction information:
  filed = fopen([path, sprintf('/pdata/%d/procs', pnumber)], 'r');
  acCount = 1;
  while (acCount);
    [acData, acCount] = fscanf(filed, '%[^\n]\n',1);
    [p0,cnt]      = sscanf(acData, '##$PHC0=%f',1);
    if (cnt); 
      spec.ph(1) = p0*2*pi/360; 
      spec.spec  = spec.spec*exp(-i*spec.ph(1));
    end;
    [sc,cnt]            = sscanf(acData, '##$NC_proc=%f',1);
    if (cnt); spec.spec = spec.spec*2^(sc+10); end;
  end;
  fclose(filed);
  
  return;
  
  
%
% Matlab function.
%
% Applies the phase correction to a spectrum structure and
% returns the corrected spectrum.
%
%%%
function ospec = applyPhase(ispec);

sl = size(ispec.spec,1);
ospec = exp(i*ispec.ph(1))*ispec.spec.*exp(i*ispec.ph(2)*(ispec.swh/sl)*(-sl/2:sl/2-1)).';

return;


%
% Matlab function.
% 
% Centered inverse fourier transform.
%
%%%
function fid = cift(spec);

  sl = length(spec);
  tspec = [spec(sl/2+1:sl);spec(1:sl/2)];
  fid = ifft(tspec);

return; 

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

