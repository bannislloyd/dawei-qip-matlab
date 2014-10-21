% spectroinit.m is a script that loads Virtual Spectro settings.  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%channels set-up (optional...can be read from the defs file)
%If you do define some channel the simulator will go in stand alone
%mode. Otherwise it will use the compiler's macro files to
%initialize itself. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f1.type ='H';
% f1.freq = -3000; 
% f1.freqsw = 0;
%  
% f2.type = 'C';
% f2.freq = -16000; 
% f2.freqsw = 0;
% 
% %Power levels (in rad.s-1)
% pl1  = 0;
% pl2  = 0;
%f3.type = 'C';
%f3.freq = 4000;
%f3.freqsw = 0;
%Number of scans
ns = 1;


%Receiver set-up: (optional ...can be read from the cpp file)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Receiver channel type:
% rct = 'C';
% 
% %Time Domain:
% td = 10000;
% 
% %Sweep width:
 swh =10000;
% 
% %observation frequency:
% o1 = -21000;
% 
% %Receiver phase number
% rcphnum = 'ph31';
% 
% %additional phase correction [ph0,ph1]
% phcor  = [0,0];

%Gradient simulation set-up: (optional..the default value is 500)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gradient slicing: (Spectrum is better with 5000 slices!)
zslices= 2000;
% 
% sp(1) = 25e1*2*pi;
% sp(2) = 16.7e1*2*pi;
% 
% spnam{1} = 'H190_H';
% spnam{2} = 'H190_C';
% 
