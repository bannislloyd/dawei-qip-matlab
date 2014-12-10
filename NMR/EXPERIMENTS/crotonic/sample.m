% sampleinit.m is a script that loads the constants for the sample.

%Sample init:
%------------
%Define the molecule structure according to the nuclei file:

   spins_sub{1} = [1];
   spins_sub{2} = [2];
   spins_sub{3} = [3];
   spins_sub{4} = [4];

%spins.ignore = {'H1','H2','H3','H4','H5'}; 
spins.ignore = {}; 
Htype = 'strong';

%Define the sub-system partition of your system:

%Define the Starting Density Matrix RHO:
%tmp = zeros(8); tmp(1,8) = 1; tmp(8,1) = 1;
%spins_sim.state = tmp;
spins.state = mkstate('+1XIII+1IXII+1IIXI+1IIIX');
%spins.state = mkstate('+1UUUUUUU+1DDDDDDD');
%spins.state = mkstate('+1XIIIIII+1IXIIIII+1IIXIIII+1IIIXIII+1IIIIXII+1IIIIIXI+1IIIIIIX');
%spins.state = mkstate('+1ZIIIIIIIIIII+1IZIIIIIIIIII+1IIZIIIIIIIII+1IIIZIIIIIIII+1IIIIZIIIIIII+1IIIIIZIIIIII+1IIIIIIZIIIII+1IIIIIIIZIIII+1IIIIIIIIZIII+1IIIIIIIIIZII+1IIIIIIIIIIZI+1IIIIIIIIIIIZ');
%spins.state = mkstate('+1XIIIIIIIIIII+1IXIIIIIIIIII+1IIXIIIIIIIII+1IIIXIIIIIIII+1IIIIXIIIIIII+1IIIIIXIIIIII+1IIIIIIXIIIII+1IIIIIIIXIIII+1IIIIIIIIXIII+1IIIIIIIIIXII+1IIIIIIIIIIXI+1IIIIIIIIIIIX');
%spins.state = mkstate('+1XIIIIIIIIIII');
%spins.state = mkstate('+0.8384IZIZZZX-0.5450IZIZIZY');
%spins.state = mkstate('-1ZXIIIIX');
%spins.state = mkstate('+1IZIZZZX');
%spins.state = mkstate('+0.75ZXZZZZZ');
%spins.state = mkstate('+1IXIIIIIIIIII');

spins.channel = [1 1 1 1];
%spins.channel = [1 1 1 1 1 1 1 2 2 2 2 2];
%spins.gaussianamt = 0.2;
%clear tmp