

Htype = 'strong';

spins.ignore = {'RH','RC'}; 


spins_sub{1} = [2];
spins_sub{2} = [3,7,4,8];
spins_sub{3} = [6];
spins_sub{4} = [9];

spins.state      = mkstate('+4ZIIIIII+4IZIIIII+4IIZIIII+1IIIZIII+1IIIIZII+1IIIIIZI+1IIIIIIZ');
clear tmp;
