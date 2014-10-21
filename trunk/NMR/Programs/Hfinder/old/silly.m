bestfit = 1e6;

for ct = 1:1:100

%Copy in the base molecule file
copyfile('~/NMR/EXPERIMENTS/LXSTAL/molecule.bak','~/NMR/EXPERIMENTS/LXSTAL/molecule.def');

Hfinderbis('testHfinderparamsbis');

%Run the Hfinder
currentfit = Hfinder('testHfinderparams');

%If it is better write that as the best nuclei file
if( currentfit < bestfit)
copyfile('~/NMR/EXPERIMENTS/LXSTAL/molecule.def',['~/NMR/EXPERIMENTS/LXSTAL/best_nuclei']);
bestfit = currentfit
end

end
