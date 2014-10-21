function params=Crotonic
% global pulseguess
% global Uwantin

%Reset the params structure
params = [];

%Location of the nuclei file (full path name)
%params.nucleifile = '/Users/caryan/MatlabCode/NMR/Programs/pulsefinder/molecule_sample1.def';
%params.nucleifile = '/home/dtrottie/pulsefinder/molecule_sample1.def';
params.nucleifile = 'molecule_Crot4.def';

%Number of timesteps
params.plength = 250;

%Length of each time step
params.timestep = 2e-6;

%Initial stepsize (this is reasonably important - run some tries
%and choose a value which is close to what the program is choosing
%after 50 or so iterations)
params.stepsize = 4e-4;

%Desired unitary
%load U_encoding.mat
%params.Uwant = U_encoding;
%load U_decoding.mat
%params.Uwant = U_decoding;
% load MAX_Us.mat
% params.Uwant = Ut2t1;
[Ix,Iy,Iz,IHx,IHy,IHz,sIHz] = prodop(1/2,4);
params.Uwant = expm(-1i*pi/2*Ix(:,:,4)); 
%load U_C123456790.mat
%params.Uwant = U_C123456790;
% load C190.mat
% params.Uwant = U_C190;
params.subsystem{1} = [1 2 3 4];
params.subsys_weight = [1];

%Desired fidelity for the unitary (this is the trace squared fidelity F = abs(Ugoal^dagger*Usim)^2/N^2)
params.fidelity = 0.999;

%RF distribution to optimize over (will slow down search and convergence dramatically)
%Two dimensional array first column is percentage of sample; second
%column is percentage of rf strength it sees. 
params.rfdist = [0.3 0.97;.4 1.00;0.3 1.03];

%params.rfdist = [1 1];

%Hamiltonian distribution to optimize over
%params.Hamdist = (1/8)*ones(1,8);

params.Hamdist = [1];

%Matrices for robustness to Hamiltonian distributions.  These will be
%multiplied by 2PI and added to the natural Hamiltonian.
params.Hammatts{1} = 0;

%Spins in nuclei file to ignore in search
params.spins_ignore = {};


%RF control fields (3D array of control Hamiltonians - as many as you like)
params.RFmatts(:,:,1) = (1/2)*full(mkstate('+1XIII+1IXII+1IIXI+1IIIX',0));
params.RFmatts(:,:,2) = (1/2)*full(mkstate('+1YIII+1IYII+1IIYI+1IIIY',0));
%params.RFmatts(:,:,3) = (1/2)*full(mkstate('+1ZII',0));
% params.RFmatts(:,:,3) = (1/2)*full(mkstate('+1IIIXIII+1IIIIXII+1IIIIIXI+1IIIIIIX',0));
% params.RFmatts(:,:,4) = (1/2)*full(mkstate('+1IIIYIII+1IIIIYII+1IIIIIYI+1IIIIIIY',0));
%params.RFmatts(:,:,6) = (1/2)*full(mkstate('+1IZI+1IIZ',0));


%The maximum rf power for each rf field in rad/s
params.rfmax = 2*pi*[25e3 25e3 16.7e3 16.7e3 15e3 15e3];

%Some parameters for the random guess 
%Scale of the random guess for each RFmatt (between 0 and 1)
params.randscale = [0.05 0.05 0.05 0.05 0.05 0.05];

%Choose every randevery points at random (rest will be fit to cubic spline)
params.randevery = 25;

%Tolerance for improving i.e. if over 20 tries we are not improving by an average of at least this, 
%we will try a new random starting point
params.improvechk = 1e-7;

%Minimum stepsize (if we're not moving anywhere we should stop searching)
params.minstepsize = 1e-7;

%Number of random guesses to try before giving up
params.numtry = 1;

%A vector of the pulsing frequency for each spin (this is defined
%with respect to the same frequency your nuclei file is)
params.pulsefreq = [21584.04 21584.04 21584.04 21584.04];	

%Soft pulse buffering delay (delays required before and after soft pulses.
%  (Since our time periods are usually greater than 350ns we could probably
    %try to use fast shapes)
params.softpulsebuffer = 4e-6;

%If there is a starting guess for the pulse load it in here (should
%be a structure
% load Croton_90x1.mat
% for  j=length(pulses{1}.pulse)+1:length(pulses{1}.pulse)+50
		% pulses{1}.pulse(j,:)=pulses{1}.pulse(j-35,:);
% end

% params.pulseguess = pulses{1};
params.pulseguess = [];
%The type of pulse we are searching for (1 for unitary, 2 for state
%to state)
params.searchtype = 1;

%Flag for whether you want to allow the time steps to vary
params.tstepflag = 0;

%Maximum length of pulse (rather soft boundary)
params.tpulsemax = 10e-3;

%Input and goal states for state to state
% params.rhoin = mkstate('+1IIIIIIZ',1);
% params.rhogoal = mkstate('+1ZZZZZZZ',1);

%Allow Zfreedom or not
params.Zfreedomflag = 0;

%Parameter to force the beginnings and end of the pulse to zero
%with a penalty function
params.onofframps = 1;
params.onoff_numpts = 10;
params.onoff_param1 = 1e-3;
params.onoff_param2 = 0.25;

%Display every x seconds irrespective of how things are improved
params.dispevery = 60;
