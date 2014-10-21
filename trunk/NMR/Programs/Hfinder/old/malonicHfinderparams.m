function params = malonicHfinderparams

params.nuclei = '~/NMR/EXPERIMENTS/MALONICbis/nuclei_23Jan2007';

params.datadir ='~/NMR/EXPERIMENTS/MALONICbis/exp_data/';

%Vector containing the experiment number of the data to fit, in the case of
%multiple experiments most of the below become cell arrays
params.expnum = [406];

%Ratio of experimental FID to use and fit as a fraction between 0 and 1 (cell
%array)
params.ratio{1} = [1];

%Portion of the spectrum to fit as two element vectors marking beginning and end of
%spectrum as fraction between 0 and 1 (cell array)
params.fitportion{1} = [0 1];

%Density matrix to fit (if empty will assume XI+IX + ...
params.rhoin = [];

%Evolve the thermal density matrix under the natural Hamiltonian by the de delay
params.de{1} = 0e-6;

%Apply some zero and first order phase correction to the data
params.phcor{1} = [0 0];

%Which nuclei are observed in each experiment (cell array)
params.nucobs{1} = [1 2 3];

%Initial scaling for the experiments (if there is natrual abundance there should be two numbers with first number for nat abun) 
params.initialscaling{1} = [0.05 0.15];

%Number of loops to go through the fit
params.loops = 4;

params.natabunflag = 1;

params.maxgaussian = 1;

params.fittype = 'spectrum';

%Plot the first try to see how good the initial guess is
params.firstplot = 0;

%Plot the final result
params.plot = 1;

%Range of chemical shifts allowed (vector with length spins.nb and chemical shifts will be allowed to vary +/- this)
params.csrange = [20 20 20];

%Range for couplings (array similar to spins.jfreqs or spins.dfreqs)
params.couprange = 100*ones(3);

%Optimization parameters
params.opt = optimset;
params.opt.MaxIter = 1e6;
params.opt.TolX = 1e-4;
params.opt.Display = 'iter';
params.opt.MaxFunEvals = 1e3;
params.opt.TolFun =1e-6 ;
