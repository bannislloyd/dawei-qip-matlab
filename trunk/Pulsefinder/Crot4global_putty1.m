function params = Crot4global_putty1

global pulseguess
global myU
global myL
global myStep

%Reset the params structure
params = [];

%Location of the nuclei file (full path name)
params.nucleifile = 'molecule_twqubit.def';

%Number of timesteps
%params.plength = 500;	%for single spins 

params.plength = 4000;	%for single spins 

%params.plength = 4000;	%for Uent and U_global

%params.plength = 16000;	%for JC1C2

%Length of each time step
%params.timestep = 1e-6;    %for single spins 

%params.timestep = 10e-6;    %for Uent, U_global

%params.timestep = 1e-6;    %J12

params.timestep = 1e-6;

%Initial stepsize (this is reasonably important - run some tries
%and choose a value which is close to what the program is choosing
%after 50 or so iterations)
params.stepsize = 2e-2;

%Desired unitary
%params.Uwant = expm(-i*(83*pi/180)/2*full(mkstate('+1IIXI',0)));   %C3, 83
%params.Uwant = expm(-i*(45*pi/180)/2*full(mkstate('+1IXII',0)));   %C2, 45
%params.Uwant = expm(-i*(180*pi/180)/2*full(mkstate('+1IXII',0)))*expm(-i*(180*pi/180)/2*full(mkstate('+1IIXI',0)));   %C2, C3, 180
%params.Uwant = expm(-i*(90*pi/180)/2*full(mkstate('+1XIII+1IXII',0)));   %C1, C2, 90
%params.Uwant = expm(-i*(180*pi/180)/2*full(mkstate('+1XIII+1IXII',0)));   %C1, C2, 180
%params.Uwant = expm(-i*(90*pi/180)/2*full(mkstate('+1IIXI+1IIIX',0)));   %C3, C4, 90
%params.Uwant = expm(-i*(180*pi/180)/2*full(mkstate('+1IIXI+1IIIX',0)));   %C3, C4, 180
%params.Uwant = expm(-i*(45*pi/180)/2*full(mkstate('+1IIXI',0)));   %C3, 45
%params.Uwant = expm(-i*(60*pi/180)/2*full(mkstate('+1IXII',0)))*expm(-i*(75*pi/180)/2*full(mkstate('+1IIXI',0)));   %C2,C3, 60,75
%params.Uwant = expm(-i*(90*pi/180)/2*full(mkstate('+1XIII',0)));   %C1, 90
%params.Uwant = expm(-i*(45*pi/180)/2*full(mkstate('+1XIII',0)));   %C1, 45
%params.Uwant = expm(-i*(90*pi/180)/2*full(mkstate('+1IXII',0)));   %C2, 90
%params.Uwant = expm(-i*(90*pi/180)/2*full(mkstate('+1IIXI',0)));   %C3, 90
%params.Uwant = expm(-i*(90*pi/180)/2*full(mkstate('+1IIIX',0)));   %C4, 90
%params.Uwant = expm(-i*(180*pi/180)/2*full(mkstate('+1XIII',0)));   %C1, 180

%Desired unitary
%H90
%params.Uwant = expm(-i*(pi/2)*(full(mkstate('+1IIX',0))));

Had = 1/sqrt(2)*[1 1;1 -1];
%Phase = [1 0;0 i];

I = eye(2);
params.Uwant = kron(kron(kron(kron(kron(kron(Had,I),I),I),I),I),I);
%params.Uwant = kron(kron(kron(Had,I),I),I);

CNOT = [1 0 0 0;0 1 0 0;0 0 0 1;0 0 1 0];
%swap = [1 0 0 0;0 0 1 0;0 1 0 0;0 0 0 1];
%params.Uwant = kron(I,swap)*kron(CNOT,I)*kron(I,swap);

%params.Uwant = kron(I,CNOT);

%params.Uwant = Uwantin;

params.subsystem{1} = [1 2 3 4 5 6 7];
%params.subsystem{1} = [1 2 3 4];

params.subsys_weight =[1];
%Desired fidelity for the unitary (this is the trace squared fidelity F = abs(Ugoal^dagger*Usim)^2/N^2)
params.fidelity = 0.99;

%RF distribution to optimize over (will slow down search and convergence dramatically)
%Two dimensional array first column is percentage of sample; second
%column is percentage of rf strength it sees. 
params.rfdist = [0.3 0.97;0.4 1.00;0.3 1.03];
% params.rfdist = [1 1];

%Hamiltonian distribution to optimize over
%params.Hamdist = [1]; params.Hammatts{1} = 0;

params.Hamdist = [0.3,0.4,0.3];

%Matrices for robustness to Hamiltonian distributions.  These will be
%multiplied by 2PI and added to the natural Hamiltonian.
 
 params.Hammatts{1} = 7*0.5*full(mkstate('+1ZIIIIII+1IZIIIII+1IIZIIII+1IIIZIII+1IIIIZII+1IIIIIZI+1IIIIIIZ',0));
 params.Hammatts{2} = 0;
 params.Hammatts{3} = -7*0.5*full(mkstate('+1ZIIIIII+1IZIIIII+1IIZIIII+1IIIZIII+1IIIIZII+1IIIIIZI+1IIIIIIZ',0));


%Spins in nuclei file to ignore in search
params.spins_ignore = {'H1','H2','H3','H4','H5'};

%RF control fields (3D array of control Hamiltonians - as many as you like)
params.RFmatts(:,:,1) = (1/2)*full(mkstate('+1XIIIIII+1IXIIIII+1IIXIIII+1IIIXIII+1IIIIXII+1IIIIIXI+1IIIIIIX',0));
params.RFmatts(:,:,2) = (1/2)*full(mkstate('+1YIIIIII+1IYIIIII+1IIYIIII+1IIIYIII+1IIIIYII+1IIIIIYI+1IIIIIIY',0));


%The maximum rf power for each rf field in rad/s
params.rfmax = 2*pi*[12.5e3 12.5e3];

%Some parameters for the random guess 
%Scale of the random guess for each RFmatt (between 0 and 1)
params.randscale = [0.05 0.05 0.05 0.05];

%Choose every randevery points at random (rest will be fit to cubic spline)
params.randevery = 20;

%Tolerance for improving i.e. if over 20 tries we are not improving by an average of at least this, 
%we will try a new random starting point
params.improvechk = 1e-7;

%Minimum stepsize (if we're not moving anywhere we should stop searching)
params.minstepsize = 1e-7;

%Number of random guesses to try before giving up
params.numtry = 1;

%A vector of the pulsing frequency for each spin (this is defined
%with respect to the same frequency your nuclei file is)
%params.pulsefreq = [-25479.6 -25479.6 -25479.6 -25479.6];	% C2
params.pulsefreq = [-25472.22];	% % not necessary for C2, but it should be o3=o1 in experiments



%Soft pulse buffering delay (delays required before and after soft pulses.
%  (Since our time periods are usually greater than 350ns we could probably
    %try to use fast shapes)
params.softpulsebuffer = 10e-6;

%If there is a starting guess for the pulse load it in here (should
%be a structure
params.pulseguess = [];

%The type of pulse we are searching for (1 for unitary, 2 for state
%to state)
params.searchtype = 1;

%Flag for whether you want to allow the time steps to vary
params.tstepflag = 0;

%Maximum length of pulse (rather soft boundary)
params.tpulsemax = 20e-3;

%Input and goal states for state to state
%params.rhoin = mkstate('+1XIII',1);
%params.rhogoal = mkstate('+1YIII',1);


%Allow Zfreedom or not
params.Zfreedomflag = 0;

%Parameter to force the beginnings and end of the pulse to zero
%with a penalty function
% flag
params.onofframps = 1;
% number of points to consider
params.onoff_numpts = 10;
% strength of penalty
params.onoff_param1 = 0.2;
% penalty decay rate
params.onoff_param2 = 0.3;

%Display every x seconds irrespective of how things are improved
params.dispevery = 60;
