function params = testHfinderparamsbis

params.nuclei = '~/NMR/EXPERIMENTS/LXSTAL/molecule.def';

params.datadir ='~/NMR/EXPERIMENTS/LXSTAL/exp_data/';

params.expnum = [201];

params.ratio = 1;

params.fitportion = [1/4 3/4];

params.de = 0e-6;

params.phcor = [0 0];

params.nucobs{1} = [1 2 3 4];

params.initialscaling = [0.08 0.045];

params.loops = 1;

params.natabunflag = 0;

params.maxgaussian = 1;

params.fittype = 'intcurve';

params.firstplot = 0;

params.plot = 0;

%Optimization parameters
params.opt = optimset;
params.opt.MaxIter = 1e6;
params.opt.TolX = 1e-3;
params.opt.Display = 'iter';
params.opt.MaxFunEvals = 1e6;
params.opt.TolFun =1e-3 ;
