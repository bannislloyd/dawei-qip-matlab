clear;

%% encoding %%
filename1 = 'twqubit_encoding1_C';
filename2 = 'twqubit_encoding1_H';

arg2=  '/opt/topspin/exp/stan/nmr/lists/wave';
eval(sprintf ('! scp %s %s mditty@enlil.uwaterloo.ca:%s',filename1,filename2,arg2));
fprintf('DONE!\n')

filename1 = 'twqubit_encoding2_C';
filename2 = 'twqubit_encoding2_H';

arg2=  '/opt/topspin/exp/stan/nmr/lists/wave';
eval(sprintf ('! scp %s %s mditty@enlil.uwaterloo.ca:%s',filename1,filename2,arg2));
fprintf('DONE!\n')

filename1 = 'twqubit_encoding3_C';
filename2 = 'twqubit_encoding3_H';

arg2=  '/opt/topspin/exp/stan/nmr/lists/wave';
eval(sprintf ('! scp %s %s mditty@enlil.uwaterloo.ca:%s',filename1,filename2,arg2));
fprintf('DONE!\n')

%% phase cycling %%
filename1 = 'twqubit_phasecycling_C';
filename2 = 'twqubit_phasecycling_H';

arg2=  '/opt/topspin/exp/stan/nmr/lists/wave';
eval(sprintf ('! scp %s %s mditty@enlil.uwaterloo.ca:%s',filename1,filename2,arg2));
fprintf('DONE!\n')

%% decoding %%
filename1 = 'twqubit_decoding_C';
filename2 = 'twqubit_decoding_H';

arg2=  '/opt/topspin/exp/stan/nmr/lists/wave';
eval(sprintf ('! scp %s %s mditty@enlil.uwaterloo.ca:%s',filename1,filename2,arg2));
fprintf('DONE!\n')