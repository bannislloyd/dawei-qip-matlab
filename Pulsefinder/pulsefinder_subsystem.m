function [pulses] = pulsefinder_subsystem(paramsfile)

%This MATLAB file tries to find strongly modulating pulses based on the
%GRAPE method see JMR Vol 172 pgs 296-305
%
% Usage:  [pulses] = pulsefinder('paramsfile');
%
%Written by Colm Ryan 26 February, 2006
%
%Updated by Colm Ryan 25 July, 2006 - to handle state to state,
%search with conjugate gradients, time step derivatives and
%handle all the different possibilities (Zfreedom,Hamdist,rfdist) nicely
%
%Updated by Colm Ryan 7 Aug,2006 to add option of on/off ramps
% If you ctrl-c out of the function you can get at the results so far
% through the global variable pulses
%
% Updated by Colm Ryan 12 January, 2007 to fix a small bug and
% change the averaging so that each Hamiltonian is averaged over
% the r.f.


%Define some global variables
global spins params pulses

global tstepscale
global Uwant rhoin rhogoal
global plength

%Load the params file
eval(paramsfile)

%Clear the pulses cell array
pulses = {};

%Read the nucleus file and remove ignored spins
spins = read_nucleus_file(params.nucleifile);
if(isfield(params,'spins_ignore'))
    spins.ignore = params.spins_ignore;
    if(length(spins.ignore)>0)
        spins = spins_ignore(spins);
    end
end

%Update the spins.freqs to the pulsing frequencies
spins.freqs = spins.freqs - params.pulsefreq;

%Create the natural Hamiltonian in the pulsing reference frame
HNAT = full(CreateHamiltonian);

%Load what type of search we want to do (unitary or state to state)
typeflag = params.searchtype;

%Load whether we want to allow the timesteps to vary
tstepflag = params.tstepflag;

%Load whether we want to allow Zfreedom
Zfreedomflag = params.Zfreedomflag;

%Randomize the state of the random number generator
rand('state',sum(100*clock));

%Initialize some of the optimization variables
goodness = 0;
tryct = 1;

%Setup the RFmatts and HNAT for the subsystems
nbsub = length(params.subsystem);
for ct = 1:1:nbsub
    %Sort the subsystem 
    params.subsystem{ct} = sort(params.subsystem{ct});
   
    %The spins we are taking out
    tspins = setxor(params.subsystem{ct},[1:1:spins.nb]);

    %The reduced natural Hamiltonian
    HNAT_sub{ct} = Partrace(HNAT,tspins)/2^length(tspins);

    %The reduced RFmatts
    rfct = 1;
    for ct2 = 1:1:size(params.RFmatts,3)
      %This can really speed things up but I need to sort out the
      %indexing.  
% $$$       tmpRFmatt = params.rfmax(ct2)*Partrace(params.RFmatts(:,:,ct2),tspins)/2^length(tspins);
% $$$       if(any(any(abs(tmpRFmatt)>1e-10)))
% $$$       RFmatts{ct}(:,:,rfct) = tmpRFmatt;
% $$$       rfct = rfct+1;
% $$$       end
    
    RFmatts{ct}(:,:,ct2) =  params.rfmax(ct2)*Partrace(params.RFmatts(:,:,ct2),tspins)/2^length(tspins);
    end

    %The reduced Uwant 
    %We apply a random unitary and then take the partial trace
    if(~iscell(params.Uwant))
    randU = 1;
    for ct3 = 1:1:spins.nb
      if(ismember(ct3,tspins))
        %Make a random 1 qubit unitary.  These aren't properly
        %distributed but oh well
        a = 0; b = 2*pi*rand; c = 2*pi*rand; d = 2*pi*rand;
        singleU = [exp(i*(a-b/2-d/2))*cos(c/2) -exp(i*(a-b/2+d/2))*sin(c/2); exp(i*(a+b/2-d/2))*sin(c/2) exp(i*(a+b/2+d/2))*cos(c/2)];
        randU = kron(randU,singleU);
      else
        randU = kron(randU,eye(2));
      end
    end
    if(typeflag == 1)
      Uwant_sub{ct} = Partrace(randU*params.Uwant,tspins);
      Uwant_sub{ct} = Uwant_sub{ct}/sqrt(trace(Uwant_sub{ct}*Uwant_sub{ct}'))*sqrt(2^length(params.subsystem{ct}));
      rhos_sub{ct} = [];
    else
      rhos_sub{ct}.rhoin = Partrace(randU*params.rhoin*randU',tspins);
      rhos_sub{ct}.rhogoal = Partrace(randU*params.rhogoal*randU',tspins);
      
    end %typeflag if
    
    else
      Uwant_sub{ct} = params.Uwant{ct};
    end %iscell if 
end %nbsub ct

%Normalize the sub-system weighting
subsys_wt = params.subsys_weight./sum(params.subsys_weight);

%Start the big optimization loop
while(goodness < params.fidelity & tryct < params.numtry+1)

    %Load the pulse from the intial guess or create a new random guess
    if(~isempty(params.pulseguess))
        disp(sprintf('\nLoading pulse from params.pulseguess'));
        pulse = params.pulseguess.pulse;
        for ct = 1:1:size(pulse,2)-1
            pulse(:,ct+1) = pulse(:,ct+1)/params.rfmax(ct);
        end
        plength = size(pulse,1);
        if(Zfreedomflag)
            zangles = params.pulseguess.zangles;
        else
            zangles = zeros(2,spins.nb);
        end
        %There is only point in trying one
        params.numtry = 1;
    else

        %Initialize the pulse i.e. create a skeleton of random points for each rf. field and then
        %fit the points with a interpolating cubic spline
        disp(sprintf('\nTrying new random guess....'));
        plength = params.plength;

        xold = [1:params.randevery:plength plength]';
        xnew = [1:1:plength]';
        skeletonpts = [];
        for ct = 1:1:size(params.RFmatts,3)
            skeletonpts = [skeletonpts params.randscale(ct)*(2*rand(size(xold,1),1)-1)];
        end
        skeletonpts(1,:) = 0; skeletonpts(end,:) = 0;
        pulse = interp1(xold,skeletonpts,xnew,'spline');
        pulse = [params.timestep*ones(plength,1) pulse];

        %Initialize the zangles if we are allowing Zfreedom
        if(Zfreedomflag)
            zangles = rand(2,spins.nb);
        else
            zangles = zeros(2,spins.nb);
        end

        %Save the initial guess
        pulses{tryct}.initialguess = pulse;
    end %load pulseguess if
  
    %Redefine the timesteps in terms of the mean time step = 0.1 units
    global tstepscale
    tstepscale = 10*mean(pulse(:,1));
    pulse(:,1) = pulse(:,1)/tstepscale;
    
     
    %Print out a header line
    disp(' Goodness |  Improvement/step |  Step Size  |  Iterations  |  CPU Time');

    %Initialize some checks and counters and other assorted variables
    stepsize = params.stepsize;
    oldgoodness = -1;
    improvect = 0;
    improvesum = 0;
    improveavg = 0;
    improveflag = 1;
    dispchk = -1;
    iterct = 0;
    oldderivs = zeros(size(pulse));
    olddirec  = zeros(size(pulse));
    oldpulse = zeros(size(pulse));

    goodzdirec = zeros(2,spins.nb);
    if(Zfreedomflag)
        oldzderivs = zeros(2,spins.nb);
        oldzdirec = zeros(2,spins.nb);
        oldzangles = zeros(2,spins.nb);
    end

    beta = 0;
    betaresetct = 0;

    %Start the clock
    t = cputime;
    lasttime = 0;

    %Initialize the pulses structure
    pulses{tryct}.params = params;

    %Start the small optimization loop
    while(stepsize > params.minstepsize & improveflag & goodness< ...
            params.fidelity & betaresetct < 20)

          %Update the iterct
        iterct = iterct+1;

        %Reset the beta reset flag
        betaresetflag = 0;

        %Call a subfunction which evaluates the goodness of the
        %current pulse and calculates the approximate derivatives
        goodness = 0;
        derivs = zeros(size(pulse));
        if(Zfreedomflag)
            zderivs = zeros(2,spins.nb);
            for ct = 1:1:nbsub
              subsys = params.subsystem{ct};
              [tmpgoodness,tmpderivs,tmpzderivs] = evalpulse(pulse, ...
                                                             HNAT_sub{ct},RFmatts{ct},Uwant_sub{ct},rhos_sub{ct},typeflag,tstepflag,Zfreedomflag,zangles(:,subsys));
              pulses{tryct}.subgood(ct) = tmpgoodness;              
              goodness = goodness + subsys_wt(ct)*tmpgoodness;
              derivs = derivs + subsys_wt(ct)*tmpderivs;
              zderivs(:,subsys) = zderivs(:,subsys) + subsys_wt(ct)*tmpzderivs;
           end
        else
            for ct = 1:1:nbsub
              [tmpgoodness,tmpderivs] = evalpulse(pulse,HNAT_sub{ct},RFmatts{ct},Uwant_sub{ct},rhos_sub{ct},typeflag,tstepflag,Zfreedomflag);
              pulses{tryct}.subgood(ct) = tmpgoodness;              
              goodness = goodness + subsys_wt(ct)*tmpgoodness;
              derivs = derivs + subsys_wt(ct)*tmpderivs;
            end
        end

            %Shift the derivatives by half a timestep (I'm not sure why I have to do
        %this but it takes ~1/1000 of the time to evalpulse and it makes the
        %derivatives almost perfect.  However, this method also
        %filters out high frequency components so I'm not
        %convninced it is the best way.
        derivs(:,2:end) = filter([0.5 0.5],1,derivs(:,2:end));
        derivs(1,2:end) = 2*derivs(1,2:end);

        %If we didn't improve then the conjugate gradient or our fitting
        %screwed up so go back to the old pulse and reset the beta 
        if(goodness < oldgoodness)
          disp('had to reset');
          
            pulse = oldpulse;
            derivs = oldderivs;
            goodness = oldgoodness;

            if(Zfreedomflag)
                zangles = oldzangles;
                zderivs = oldzderivs;
            end

            beta = 0;
            betaresetflag = 1;
            betaresetct = betaresetct+1;
        end

        %Calculate the conjugate gradient direction we should have to reset
        %every once and a while but we don't seem to have to.
        if(iterct ~= 1 & ~betaresetflag)
            diffderivs = derivs - oldderivs;
            if(Zfreedomflag)
                diffzderivs = zderivs - oldzderivs;
                beta = (sum(sum(derivs.*diffderivs))+sum(sum(zderivs.*diffzderivs)))/(sum(sum(oldderivs.^2)) + sum(sum(oldzderivs.^2)));
            else
                beta = sum(sum(derivs.*diffderivs))/sum(sum(oldderivs.^2));

            end

        end

        %Do a sort of reset.  If we have really lost conjugacy then beta will be
        %negative.  If we than reset beta to zero then we start with the
        %steepest descent again.
        beta = max(beta,0);

        %Define the good direction as the linear combination
        gooddirec = derivs + beta*olddirec;
        if(Zfreedomflag)
            goodzdirec = zderivs + beta*oldzdirec;
        end

        %Now find the best step size along this direction by calculating two more points along this direction and fitting to a quadratic
        mults = [0 1 2];
        tmpgoodness(1) = goodness;
        for ct = 2:1:3
          tmpgoodness(ct) = 0;
          for ct2 = 1:1:nbsub
            subsys = params.subsystem{1,ct2};
            tmp  =  evalpulse(pulse+mults(ct)*stepsize*gooddirec,HNAT_sub{ct2},RFmatts{ct2},Uwant_sub{ct2},rhos_sub{ct2},typeflag,tstepflag,Zfreedomflag,zangles(:,subsys)+mults(ct)*stepsize*goodzdirec(:,subsys));
            tmpgoodness(ct) = tmpgoodness(ct) + subsys_wt(ct2)*tmp;
          end
           
          end

        %We have three points to fit a quadratic to.  The matrix to obtain
        %the [a b c] coordinates for fitting points 0,1,2 is
        fitcoeffs = [0.5   -1    0.5; -1.5    2   -0.5; ...
            1.0000         0         0]*tmpgoodness';

        %If the quadratic is negative this method did not work so just
        %go for the maximum value
        if(fitcoeffs(1) > 0)
            [maximum,maxindex] = max(tmpgoodness);
            maxmult = mults(maxindex);
            %Otherwise choose the maximum of the quadratic
        else
            maxmult = -fitcoeffs(2)/fitcoeffs(1)/2;
        end

        %If the max looks like it is beyond 2X the stepsize, try to fit up
        %to 4X the stepsize using the same steps
        if(maxmult > 1.99)
            mults = [0 2 4];
            tmpgoodness(2) = tmpgoodness(3);
            tmpgoodness(3) = 0;
            for ct2 = 1:1:nbsub
              subsys = params.subsystem{1,ct2};              
              tmp =  evalpulse(pulse+mults(3)*stepsize*gooddirec,HNAT_sub{ct2},RFmatts{ct2},Uwant_sub{ct2},rhos_sub{ct2},typeflag,tstepflag,Zfreedomflag,zangles(:,subsys)+mults(ct)*stepsize*goodzdirec(:,subsys));
              tmpgoodness(3) = tmpgoodness(3) + subsys_wt(ct2)*tmp;
            end
            
            fitcoeffs = [0.125   -0.25    0.125; -0.75    1   -0.25; ...
                1.0000         0         0]*tmpgoodness';

            if(fitcoeffs(1) > 0)
                [maximum,maxindex] = max(tmpgoodness);
                maxmult = mults(maxindex);
            else
                maxmult = -fitcoeffs(2)/fitcoeffs(1)/2;
            end

        end %maxmult >2 if

        %Move by at least 0.1 and at most 4;
        maxmult = min(max(maxmult,0.1),4);

        %Now move uphill and update the pulse
        oldpulse = pulse;
        pulse = pulse+maxmult*stepsize*gooddirec;
        if(Zfreedomflag)
            oldzangles = zangles;
            zangles = zangles+maxmult*stepsize*goodzdirec;
        end

        %Change the stepsize by the sqrt of the maxmult so that we move in
        %the general direction of the right stepsize but don't jump around
        %too much
        stepsize = sqrt(maxmult)*stepsize;

        %Make sure we are not over %100 power
        pulse(:,2:end) = min(max(pulse(:,2:end),-1),1);

        %If we are changing the time steps remove those
        %that are negative
        if(tstepflag)
            zerolines = pulse(:,1)<0;
            if(sum(zerolines) ~= 0)
                pulse(zerolines,:) = []; derivs(zerolines,:) = []; ...
                    gooddirec(zerolines,:) = [];
                plength = size(pulse,1);
            end
        end
 
        %Update the improvement sums
        improvesum = improvesum + goodness-oldgoodness;
        improvect = improvect+1;

        %Every 20 improvements calculate the improvement average and update the
        %improveflag whether it is greater than params.improveby
        if(improvect > 19)

            improveavg = improvesum/improvect;
            improveflag = improveavg>params.improvechk;

            %Reset the improvement sum and coutner
            improvect = 0;
            improvesum = 0;

            %Save the pulse in case we need to ctrl-c out of the
            %function
            tmppulse = pulse;
            tmppulse(:,1) = tstepscale*tmppulse(:,1);
            for ct = 1:1:size(params.RFmatts,3)
                tmppulse(:,ct+1) = params.rfmax(ct)*tmppulse(:,ct+1);
            end
            pulses{tryct}.pulse = tmppulse;
            pulses{tryct}.zangles = zangles;
            pulses{tryct}.goodness = goodness;

        end

        %Transfer the variables to the old ones
        oldgoodness = goodness;
        oldderivs = derivs;
        olddirec = gooddirec;

        if(Zfreedomflag)
            oldzderivs = zderivs;
            oldzdirec = goodzdirec;
        end

        %Now display if we want (basically we display when we are 20% closer
        %to the goal than the last time we displayed)
        if(goodness>dispchk | (cputime-lasttime > params.dispevery))
            fprintf('  %6.4f         %5.3e       %5.3e      %5d         %5.2f \n',goodness,improveavg,stepsize,iterct,(cputime-t)/60)

            %Set the next display trigger point
            dispchk = max((params.fidelity-goodness)*0.2,1e-4) + goodness;
            
            %Set the lasttime 
            lasttime = cputime;
        end

    end % stepsize and improving and goodness while loop

    %Save each try because it might be as good as we get
    tmppulse = pulse;
    tmppulse(:,1) = tstepscale*tmppulse(:,1);
    for ct = 1:1:size(params.RFmatts,3)
        tmppulse(:,ct+1) = params.rfmax(ct)*tmppulse(:,ct+1);
    end
    pulses{tryct}.pulse = tmppulse;
    pulses{tryct}.zangles = zangles;
    pulses{tryct}.goodness = goodness;

    %Increment the try counter
    tryct = tryct+1;

    %Print out some info about why we gave up on this one.
    if(stepsize < params.minstepsize)
        disp('Failed to find pulse because stepsize is less than params.minstepsize');
    end
    if(improveflag == 0)
        disp('Failed to find pulse because no longer improving by params.improvechk');
    end

    if(betaresetct > 19)
        disp(sprintf('Failed to find pulse because had to reset conjugate gradients too many times. \n Usually this is because pulse is hitting maximum power limits'));
    end

end  %goodness and tryct while loop

%Print out some information about whether we got a good enough pulse or not
%and where the best one we found was
if(goodness>params.fidelity)
    disp(sprintf('\nFound pulse of desired fidelity!'))
else
    bestpulse = 1;
    for ct = 2:1:length(pulses)
        if(pulses{ct}.goodness > pulses{bestpulse}.goodness)
            bestpulse = ct;
        end
    end

    disp(sprintf('\nUnable to find decent pulse.  Best one found is number %d at a fidelity of %f',bestpulse,pulses{bestpulse}.goodness));
    disp('You might want to try fiddling with the timestep, number of points or the random guess paramaters');
end

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [goodness,derivs,zderivs] = evalpulse(pulse,HNAT,RFmatts,Uwantsub,rhossub,typeflag,tstepflag,Zfreedomflag,zangles);

%Subfunction to cacluate goodness of pulse and approximate
%derivatives.  If only one output arguement is called for it
%returns only the goodness
%typeflag is 1 for unitary and 2 for state to state
%tstepflag turns on and off derivitives of the timestep
%Zfreedomflag combined with asking for three outputs allows for zangles and
%returns zderivs

global params 
global tstepscale
global Uwant rhoin rhogoal
global corrmat

%Modify the pulse by the tstepscale
pulse(:,1) = tstepscale*pulse(:,1);

%Load the rf and Hamiltonian distribution
rfdist = params.rfdist;
Hamdist = params.Hamdist;

%Initialize the goodness variable
goodness  = 0;

%Calculate the number of spins
nbspins = log2(size(HNAT,1));

%Initialize the derivatives
derivs = zeros(size(pulse));
zderivs = zeros(2,nbspins);
HTOT = zeros(size(HNAT));

%Loop over the Hamiltonian distribution
for Hamct = 1:1:length(Hamdist)

    %Load the matrix of Hamiltonian shifts
    Hamshift = 2*pi*params.Hammatts{Hamct};

%Reset the Uwant and rhoin and rhogoal to the params values
if (typeflag == 1)
  Uwant = Uwantsub;
else
  rhoin = rhossub.rhoin;
  rhogoal = rhossub.rhogoal;
end

%If we are allowing Zfreedom, then modify the Uwant or
%rhoin/rhogoal by the Z rotations
if(Zfreedomflag)
  
  %Set up the corrmat: each column contains the diagonal of ZIII,IZII.... 
   corrmat = zeros(2^nbspins,nbspins);
    for ct = 1:1:2^nbspins
        tmpstr = dec2bin(ct-1,nbspins);
        for ct2 = 1:1:nbspins
            corrmat(ct,ct2) = str2num(tmpstr(ct2));
        end
    end
    corrmat = -2*corrmat + 1;
  
    Zpre = 0; Zpost = 0;
    for ct = 1:1:size(corrmat,2)
        Zpre = Zpre + zangles(1,ct)*corrmat(:,ct);
        Zpost = Zpost + zangles(2,ct)*corrmat(:,ct);
    end

    if(typeflag == 1)
        Uwant = diag(exp(i*pi*Zpost))*Uwant*diag(exp(i*pi*Zpre));
    else
        rhoin = diag(exp(-i*pi*Zpre))*rhoin*diag(exp(i*pi*Zpre));
        rhogoal = diag(exp(i*pi*Zpost))*rhogoal*diag(exp(-i*pi*Zpost));
    end %typeflag if

end  %Zfreedomflag if 
    
%Modify the desired unitary or the goal states by the soft pulse
%buffer free evolution
if(typeflag == 1)
    Uwant = expm(i*params.softpulsebuffer*(HNAT+Hamshift))*Uwant*expm(i*params.softpulsebuffer*(HNAT+Hamshift));
elseif(typeflag == 2)
    rhoin = expm(-i*params.softpulsebuffer*(HNAT+Hamshift))*rhoin* ...
        expm(+i*params.softpulsebuffer*(HNAT+Hamshift));
    rhogoal = expm(i*params.softpulsebuffer*(HNAT+Hamshift))*rhogoal* ...
        expm(-i*params.softpulsebuffer*(HNAT+Hamshift));
end

%Loop over r.f. dist
for rfct = 1:1:size(rfdist,1)
  
    %If we are doing a line search we only need the goodness
    if(nargout==1)

       %Calculate the total propgator
        Usim = calc_prop(HNAT+Hamshift,pulse,rfdist(rfct,2),RFmatts,1);
      
        %Calculate the trace squared fidelity of the propagator
        if(typeflag == 1)
            goodness = goodness + Hamdist(Hamct)*rfdist(rfct,1)*(abs(trace(Usim'*Uwant)))^2;
        else
            goodness = goodness + Hamdist(Hamct)*rfdist(rfct,1)*(abs(trace(Usim*rhoin*Usim'*rhogoal')))^2;
        end

        %Otherwise we need to store each timestep and calculate the derivatives
    else %nargout == 1 if

        %Calculate the Hamiltonian for each step and the propagator (if we
        %are doing timestep derivatives, we also need to store the HTOT for
        %each step
        if(tstepflag)
            [prop,HTOT] = calc_prop(HNAT+Hamshift,pulse,rfdist(rfct,2),RFmatts,0);
        else
            prop = calc_prop(HNAT+Hamshift,pulse,rfdist(rfct,2),RFmatts,0);
        end
          
        %Now calculate the derivatives
        if(Zfreedomflag)
            [tmpderivs,tmpgoodness,tmpzderivs] = calc_derivs(prop,RFmatts,typeflag,tstepflag,pulse,HTOT);
        else
            [tmpderivs,tmpgoodness] = calc_derivs(prop,RFmatts,typeflag,tstepflag,pulse,HTOT);
        end
        
        goodness = goodness+Hamdist(Hamct)*rfdist(rfct,1)*tmpgoodness;
        derivs = derivs + Hamdist(Hamct)*rfdist(rfct,1)*rfdist(rfct,2)*tmpderivs;
        
        if(Zfreedomflag)
        zderivs = zderivs + Hamdist(Hamct)*rfdist(rfct,1)*tmpzderivs;
        end
        
    end %nargout == 1 if

    end %rfct
end %Hamct loop


%Scale the goodness and derivs
if(~isempty(Hamdist) & ~isempty(rfdist))
    goodness= goodness/(sum(rfdist(:,1))*sum(Hamdist));
    derivs = derivs/(sum(rfdist(:,1))*sum(Hamdist));
    zderivs = zderivs/(sum(rfdist(:,1))*sum(Hamdist));
elseif(~isempty(Hamdist))
    goodness = goodness/sum(Hamdist);
    derivs = derivs/sum(Hamdist);
    zderivs = zderivs/sum(Hamdist);
else
    error('You need at least some distribution to average over!');
end

if(typeflag == 1)
    goodness =  goodness/2^(2*nbspins);
    derivs = derivs/2^(2*nbspins);
    if(Zfreedomflag)
      zderivs = zderivs/2^(2*nbspins);
    end
else
    goodness = goodness/abs(trace(rhoin^2)*trace(rhogoal^2));
    derivs = derivs/abs(trace(rhoin^2)*trace(rhogoal^2));
    zderivs = zderivs/abs(trace(rhoin^2)*trace(rhogoal^2));tmpgoodness = tmpgoodness*(size(HNAT_sub{ct},1))^2;
end

%If we are doing timestep derivatives then modify the goodness and
%derivatives with the penalty function for extra time
if(tstepflag)
    tottime = sum(pulse(:,1));
    goodness = goodness - 0.01*exp(10*(tottime/params.tpulsemax - 1));

    if(typeflag == 1)
        derivs(:,1) = derivs(:,1) - 0.01*exp(-10)*(10/params.tpulsemax)*exp(10*tottime/params.tpulsemax);
    else
        derivs(:,1) = derivs(:,1) - 0.01*exp(-10)*(10/params.tpulsemax)*exp(10*tottime/params.tpulsemax);
    end

    derivs(:,1) = derivs(:,1)*tstepscale;

end %tstepflag if

%If we want on and off ramps then modify the goodness and the
%derivatives with the penalty function
if(params.onofframps)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% These variables adjust the penalty function for the onoff ramps
% They are a bit of a hack for now however roughly speaking
% numpts says how many points at beginning/end are penalized
% param1 is the strength of the penalty (larger = stronger push to zero)
% param2 determines how quickly the penalty decreases/increases as
% you move away from the end points (larger = decreases faster)
% The penalty function is some sort of cosh function
  numpts = 10;
  param1 = 1e-4;
  param2 = 0.25;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

  for ct = 1:1:size(RFmatts,3)
    %First the on ramp
    goodness = goodness - sum(param1*exp(-10*[param2:param2:param2*numpts]').*(exp(10*pulse(1:numpts,ct+1)) + exp(-10*pulse(1:numpts,ct+1))))...
                                     + 2*param1*sum(exp(-10*[param2:param2:param2*numpts]));
    
    %Now the off ramp
    goodness = goodness - sum(param1*exp(-10*[param2*numpts:-param2:param2]').*(exp(10*pulse(end-numpts+1:end,ct+1)) ...
                                  + exp(-10*pulse(end-numpts+1:end,ct+1)))) + 2*param1*sum(exp(-10*[param2:param2:param2*numpts]));

    %Now adjust the derivatives
    derivs(1:numpts,ct+1) = derivs(1:numpts,ct+1) - ...
        10*param1*(exp(-10*[param2:param2:param2*numpts]').*(exp(10*pulse(1:numpts,ct+1)) - exp(-10*pulse(1:numpts,ct+1))));
    
    derivs(end-numpts+1:end,ct+1) = derivs(end-numpts+1:end,ct+1) - 10*param1*exp(-10*[param2*numpts:-param2:param2]').* ...
        (exp(10*pulse(end-numpts+1:end,ct+1)) - exp(-10*pulse(end-numpts+1:end,ct+1)));
    
  end
end

return %end evalpulse
%        derivs = zeros(size(derivs));

        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [prop,HTOT] = calc_prop(HNAT,pulse,rfmult,RFmatts,linesearchflag)

%Calculates the propagator for a given pulse.  If we are only doing
%a line search we don't need to save the propagator.  If we are
%doing timestep derivatives we need to save HTOT for each step.


plength = size(pulse,1);
nbspins = log2(size(HNAT,1));

if(linesearchflag & nargout == 1)
    prop = eye(2^nbspins);
    for ct = 1:1:plength
        HTOT = HNAT;
        for RFmattct = 1:1:size(RFmatts,3)
            HTOT = HTOT + rfmult*pulse(ct,RFmattct+1)*RFmatts(:,:,RFmattct);
        end
        prop = expm(-i*pulse(ct,1)*HTOT)*prop;
    end

elseif(nargout == 2)
        %Initialize the propagator and Hamiltonian storage
        prop = zeros(2^nbspins,2^nbspins,plength);
        HTOT = repmat(HNAT,[1 1 plength]);
        for ct = 1:1:plength
            for RFmattct = 1:1:size(RFmatts,3)
                HTOT(:,:,ct) = HTOT(:,:,ct) + rfmult*pulse(ct,RFmattct+1)*RFmatts(:,:,RFmattct);
            end
            prop(:,:,ct) = expm(-i*pulse(ct,1)*HTOT(:,:,ct));
        end
else
        prop = zeros(2^nbspins,2^nbspins,plength);
        for ct = 1:1:plength
            HTOT = HNAT;
            for RFmattct = 1:1:size(RFmatts,3)
                HTOT = HTOT + rfmult*pulse(ct,RFmattct+1)*RFmatts(:,:,RFmattct);
            end
            prop(:,:,ct) = expm(-i*pulse(ct,1)*HTOT);
        end
end %linesearchflag nargout if

return %calc_pulse

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [derivs,goodness,zderivs] = calc_derivs(prop,RFmatts,typeflag,tstepflag,pulse,HTOT);

global spins plength
global Uwant rhoin rhogoal
global corrmat

nbspins = log2(size(HTOT,1));

derivs = zeros(size(pulse));

%Now calculate forward propagation
Uforward = zeros(2^nbspins,2^nbspins,plength);
Uforward(:,:,1) = prop(:,:,1);
for ct = 2:1:plength
    Uforward(:,:,ct) = prop(:,:,ct)*Uforward(:,:,ct-1);
end

%And now the backwards
Uback = zeros(2^nbspins,2^nbspins,plength);

%Whether we are doing unitary or state this is a bit different
if(typeflag == 1)
    Uback(:,:,1) = -Uwant;
else
    Uback(:,:,1) = eye(2^nbspins);
end

for ct = 2:1:plength
    Uback(:,:,ct) = prop(:,:,plength-ct+2)'*Uback(:,:,ct-1);
end
Uback = flipdim(Uback,3);

%Finally the derivatives (again this is different for state to state or
%unitary)
if(typeflag == 1) %Do the derivatives for unitary
    tmpRFmat = zeros(size(RFmatts,3),2^(2*nbspins));
    
    for RFmattct = 1:1:size(RFmatts,3)
        tmpRFmat(RFmattct,:) = reshape(transpose(RFmatts(:,:,RFmattct)),[1 2^(2*nbspins)]);
    end
    
    for ct = 1:1:plength
        tmpmat = Uforward(:,:,ct)*Uback(:,:,ct)';
        tmpmult = conj(trace(tmpmat));
        tmpmatt = reshape(tmpmat,[1 2^(2*nbspins)]);
        
        for RFmattct = 1:1:size(RFmatts,3)
            derivs(ct,RFmattct+1) = 2*pulse(ct,1)*imag(sum(tmpRFmat(RFmattct,:).*tmpmatt)*tmpmult);
%            derivs(ct,RFmattct+1) = -2*real(trace(Uback(:,:,ct)'*i*pulse(ct,1)*RFmatts(:,:,RFmattct)*Uforward(:,:,ct))*trace(Uforward(:,:,ct)'*Uback(:,:,ct))); 
        end %RFmattct loop

        %If we want calculate the time step derivatives
        if(tstepflag)
            derivs(ct,1) = 2*imag(sum(reshape(transpose(HTOT(:,:,ct)),[1 2^(2*nbspins)]).*tmpmatt)*tmpmult);
        end

    end %ct loop

else %Do the same for state to state
    rhon = Uforward(:,:,plength)*rhoin*Uforward(:,:,plength)';
    for ct = 1:1:plength
        lambdaj = Uback(:,:,ct)*rhogoal*Uback(:,:,ct)';
        rhoj = Uforward(:,:,ct)*rhoin*Uforward(:,:,ct)';

        for RFmattct = 1:1:size(RFmatts,3)
            derivs(ct,RFmattct+1) = 2*pulse(ct,1)*imag(trace(lambdaj'*(RFmatts(:,:,RFmattct)*rhoj - rhoj*RFmatts(:,:,RFmattct)))*trace(rhon'*rhogoal));
        end %RFmattct loop

        if(tstepflag)
            derivs(ct,1) = 2*imag(trace(lambdaj'*(HTOT(:,:,ct)*rhoj - rhoj*HTOT(:,:,ct)))*trace(rhon'*rhogoal));
        end %tstepflag

    end %ct loop

end %typeflag if

%Calculate the trace squared fidelity of the propagator
if(typeflag == 1)
    goodness = (abs(trace(Uforward(:,:,plength)'*Uwant)))^2;
else
    goodness = (abs(trace(rhon'*rhogoal)))^2;
end

%If we are asking for the z derivatives calculate them with finite
%difference (fast enough because there isn't very many of them and
%the matrices are diagonal)

if(nargout == 3)
    zderivs = zeros(2,nbspins);

    %Switch depending on whether we are doing state to state or
    %unitary
    if(typeflag == 1)

        %Do the Zpre first
        tmpmat = diag(Uwant'*Uforward(:,:,plength));
        for ct = 1:1:nbspins
            newgoodness = (abs(sum(exp(-i*pi*1e-6*corrmat(:,ct)).*tmpmat)))^2;
            zderivs(1,ct) = 1e6*(newgoodness-goodness);
        end

        %And now Zpost
        tmpmat = diag(Uforward(:,:,plength)*Uwant');
        for ct = 1:1:nbspins
            newgoodness = (abs(sum(exp(-i*pi*1e-6*corrmat(:,ct)).*tmpmat)))^2;
            zderivs(2,ct) = 1e6*(newgoodness-goodness);
        end

    else %Do state to state
        %Do the Zpre first
        Usim = Uforward(:,:,plength);
        for ct = 1:1:nbspins
            newgoodness = (abs(trace(rhogoal'*Usim*diag(exp(-i*pi*1e-6*corrmat(:,ct)))*rhoin*diag(exp(i*pi*1e-6*corrmat(:,ct)))*Usim')))^2;
            zderivs(1,ct) = 1e6*(newgoodness-goodness);
        end

        %And now Zpost
        for ct = 1:1:nbspins
            newgoodness = (abs(trace(rhogoal'*diag(exp(-i*pi*1e-6*corrmat(:,ct)))*Usim*rhoin*Usim'*diag(exp(i*pi*1e-6*corrmat(:,ct))))))^2;
            zderivs(2,ct) = 1e6*(newgoodness-goodness);
        end
    end %typeflag if
end %nargout == 3 if

return %end calc_derivs


function some_extra_stuff
%Below is some code for doing diagnostics

%Do some finite difference checking of the approximate gradients

    if(iterct>0)

    tempstep = [0:0.2:4];
    figure
    for ct = 1:1:length(tempstep);
         tmpgoodness(ct) = 0;
          for ct2 = 1:1:nbsub
            subsys = params.subsystem{1,ct2};
            tmp  =  evalpulse(pulse+tempstep(ct)*stepsize*gooddirec,HNAT_sub{ct2},RFmatts{ct2},Uwant_sub{ct2},typeflag,tstepflag,Zfreedomflag,zangles(:,subsys)+tempstep(ct)*stepsize*goodzdirec(:,subsys));
            tmpgoodness(ct) = tmpgoodness(ct) + subsys_wt(ct2)*tmp;
          end
      end
 
     plot([0:0.2:4],tmpgoodness)
    hold on
    plot([0:0.2:4],fitcoeffs(1)*[0:0.2:4].^2+fitcoeffs(2)*[0:0.2:4]+ ...
        fitcoeffs(3),'r')
   
    
    for ct = 1:1:length(tempstep);
      tmpgoodness(ct) = 0;
      for ct2 = 1:1:nbsub
            subsys = params.subsystem{1,ct2};
            tmp  =  evalpulse(pulse+tempstep(ct)*stepsize*derivs,HNAT_sub{ct2},RFmatts{ct2},Uwant_sub{ct2},typeflag,tstepflag,Zfreedomflag,zangles(:,subsys)+tempstep(ct)*stepsize*zderivs(:,subsys));
            tmpgoodness(ct) = tmpgoodness(ct) + subsys_wt(ct2)*tmp;
          end
  
    end
    plot([0:0.2:4],tmpgoodness,'g')
    maxmult
    beta

    pause
end



           

tmpgoodness = tmpgoodness*(size(HNAT_sub{ct},1))^2;
timestep = params.timestep;
pulse(:,1) = tstepscale*pulse(:,1);
for derivct = 2:1:5
for ct2 = 1:1:length(pulse)
       pulse(ct2,derivct) = pulse(ct2,derivct) + 1e-6;
    newgoodness = 0;
    for rfct = 1:1:size(params.rfdist,1)
     prop = eye(size(HNAT_sub{ct}));
 
    for ct3 = 1:1:length(pulse)
      HTOT = HNAT_sub{ct};
      for ct4 = 1:1:size(RFmatts{ct},3)
        HTOT = HTOT + params.rfdist(rfct,2)*pulse(ct3,ct4+1)*RFmatts{ct}(:,:,ct4);
      end
      
        prop = expm(-i*HTOT*pulse(ct3,1))*prop;
    end
     nbspins = length(subsys);
      corrmat = zeros(2^nbspins,nbspins);
    for corrct = 1:1:2^nbspins
        tmpstr = dec2bin(corrct-1,nbspins);
        for corrct2 = 1:1:nbspins
            corrmat(corrct,corrct2) = str2num(tmpstr(corrct2));
        end
    end
    corrmat = -2*corrmat + 1;
    
      Zpre = 0; Zpost = 0;
    for Zct = 1:1:size(corrmat,2)
        Zpre = Zpre + zangles(1,subsys(Zct))*corrmat(:,Zct);
        Zpost = Zpost + zangles(2,subsys(Zct))*corrmat(:,Zct);
    end

    prop = diag(exp(-i*pi*Zpost))*prop*diag(exp(-i*pi*Zpre));
    
    newgoodness = newgoodness+ params.rfdist(rfct,1)*(abs(trace(prop'*Uwant_sub{ct})))^2;
    %newgoodness = (abs(trace(params.rhogoal*prop*params.rhoin* ...
    %                         prop')))^2;
    
    end
    
    derivcheck(ct2,derivct) = 1e6*(newgoodness-tmpgoodness);
    pulse(ct2,derivct) = pulse(ct2,derivct) - 1e-6;
end
end
ct

for figct = 1:1:4
  
  tmpderivs(:,2:end) = filter([0.5 0.5],1,tmpderivs(:,2:end));
        tmpderivs(1,2:end) = 2*tmpderivs(1,2:end); 
figure
plot((size(HNAT_sub{ct},1)^2)*tmpderivs(:,figct+1))
hold on

plot(derivcheck(:,figct+1),'r')
zoom on
end
pulse(:,1) = pulse(:,1)/tstepscale;
tmpgoodness
pause
              
