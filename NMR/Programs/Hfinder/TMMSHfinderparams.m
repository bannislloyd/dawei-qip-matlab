function params = malonicHfinderparams

params.nuclei = '~/NMR/EXPERIMENTS/BENCHMARKINGbis/molecule_21Feb2008';

params.datadir ='~/NMR/EXPERIMENTS/BENCHMARKINGbis/exp_data/';

%Vector containing the experiment number of the data to fit, in the case of
%multiple experiments most of the below become cell arrays
params.expnum = [82 83];

%Ratio of experimental FID to use and fit as a fraction between 0 and 1 (cell
%array)
params.ratio{1} = [1];
params.ratio{2} = [1];

%Portion of the spectrum to fit as two element vectors marking beginning and end of
%spectrum as fraction between 0 and 1 (cell array)
params.fitportion{1} = [1/4 3/4];
params.fitportion{2} = [0 1];

%Density matrix to fit (if empty will assume XI+IX + ...
params.rhoin = [];

%Evolve the thermal density matrix under the natural Hamiltonian by the de delay
params.de{1} = 0e-6;
params.de{2} = 0e-6;

%Apply some zero and first order phase correction to the data
params.phcor{1} = [0 0];
params.phcor{2} = [0 0];

%Which nuclei are observed in each experiment (cell array)
params.nucobs{1} = [1];
params.nucobs{2} = [2 3];

%Initial scaling for the experiments 
params.initialscaling{1} = [0.15];
params.initialscaling{2} = [0.15];

%Line broadening to apply
params.lb{1} = 1;
params.lb{2} = 1;

%Flag to fit natural abundance peaks
params.natabunflag = 0;

%Maximum gaussian component to the peaks
params.maxgaussian = 0.1;

%What way to fit the peaks.  Options are
%'spectrum' : least squares on the spectrum
% 'FID'     : least squares on the FID
% 'intcurve': integral curve method on the spectrum

params.fittype = 'spectrum';

%Plot the first try to see how good the initial guess is
params.firstplot = 1;

%Plot the final fit
params.plot = 1;

%Range of chemical shifts allowed (vector with length spins.nb and chemical shifts will be allowed to vary +/- this)
params.csrange = [20 20 20];

%Reference chemical shifts to o1 or bf (1 for o1, 0 for bf)
params.o1ref = 1;

%Range for couplings (array similar to spins.jfreqs or spins.dfreqs)
%Set range to zero to not optimize a particular coupling
params.couprange = 100*ones(3);

%Optimization parameters
params.opt = optimset;
params.opt.MaxIter = 1e2;
params.opt.TolX = 1e-4;
params.opt.Display = 'iter';
params.opt.MaxFunEvals = 1e3;
params.opt.TolFun =1e-6 ;