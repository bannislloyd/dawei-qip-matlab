% spectroinit.m is a script that loads Virtual Spectro settings.  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global tmpspnam

%channels set-up (optional...can be read from the defs file)
%If you do define some channel the simulator will go in stand alone
%mode. Otherwise it will use the compiler's macro files to
%initialize itself. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 f1.type ='C';
 f1.freq = 20696; 
 f1.freqsw = 0;
  f2.type = 'H';
  f2.freq = 2896;
  f2.freqsw = 0;




%Power levels (in rad.s-1)
pl(1)  = pi/2/18e-6;
pl(2)  = pi/2/2e-6;

%Number of scans
ns = 1;


%Receiver set-up: (optional ...can be read from the cpp file)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Receiver channel type:
rct = 'C';

%Reciever phase number (e.g. go=2 ph31)
rcphnum = 'ph31';

%Time Domain
td = 2^12;

%Sweep width:
swh=400;
%swh = 30030.03003003;


%observation frequency:
 o1 = -10333.55;
%o1 = -11928.21998;
% o1 = -8778.95;

%additional phase correction [ph0,ph1]
specphcor  = [0,0];

%obs_decoup = [0 1];

%Gradient simulation set-up: (optional..the default value is 500)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gradient slicing: (Spectrum is better with 5000 slices!)
%zslices= 400;

%Spectrometer variable setup
%sp(1) = 60*2*pi;


%spnam{1} = '12spin_C1_90';
%spnam{2} = 'pops';



%Remember to shift by one e.g. phcor(11) = phcor10 on spectro
phcor(1:11) = 0*ones(1,11);














