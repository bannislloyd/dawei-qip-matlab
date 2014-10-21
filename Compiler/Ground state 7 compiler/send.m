

homepath    = '/home/dtrottie/postselection/GRAPE/alpha';
arg1=[homepath,'/',filename1];
arg2=  '/opt/topspin/exp/stan/nmr/lists/wave';
eval(sprintf ('! scp %s mditty@enlil.uwaterloo.ca:%s',arg1,arg2));
fprintf('DONE!\n')
