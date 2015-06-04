%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab start-up file to set-up the path for nmr experiments preparation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Some initial cleaning
clc;
clear all;
%Let's go:
fprintf('\nInitialization of the NMR package.....\n\n')
%Some global variables:
global srcpath sequencecompilerpath pulsecompilerpath pathl

%CHANGE THIS PATH WHEN YOU INSTALL THE PACKAGE:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialize machine dependant paths (to be addapted according to
%the computer you are using):
NMRPATH         = 'H:/Matlab/NMR';
%%%%%

%Some paths to be added:
docpath                 = [NMRPATH,'/DOC'];
srcpath                 = [NMRPATH,'/SRC'];
experimentspath         = [NMRPATH,'/EXPERIMENTS'];

pulsefinderpath         = [srcpath,'/pulsefinder'];
pulsecompilerpath       = [srcpath,'/pulsecompiler'];
sequencecompilerpath    = [srcpath,'/sequencecompiler'];
simulatorpath           = [srcpath,'/simulator'];
qcircuitpath            = [srcpath,'/qcircuit'];
datanalysispath         = [srcpath,'/datanalysis'];
scriptspath             = [srcpath,'/hlscripts'];
commonpath              = [srcpath,'/common'] ;


%Add the source and TMP paths:
addpath (pulsefinderpath, pulsecompilerpath, sequencecompilerpath, ...
         simulatorpath, qcircuitpath, datanalysispath, scriptspath, ...
         commonpath);
%%%%%%%%%%%%% 




%Initialize everything experiment dependant:
reply = input('Which experiment are you working on ?  [TEMPLATE]\n ', 's');
if isempty(reply)
  reply = 'TEMPLATE';
end;
  pathl.experiment= [experimentspath,'/',reply];

while ~exist(pathl.experiment)
  reply = input(['No such directory, please choose another one ?  ' ...
                 '[TEMPLATE]\n '], 's');
  if isempty(reply)
    reply = 'TEMPLATE';
  end;
    pathl.experiment= [experimentspath,'/',reply];
end;
eval(['cd ', pathl.experiment]);


%Set up the bruker specific path:
pathl.au       = '/opt/topspin/exp/stan/nmr/au/src';
pathl.pp       = '/opt/topspin/exp/stan/nmr/lists/pp/user';
pathl.gp       = '/opt/topspin/exp/stan/nmr/lists/gp';
pathl.mac      = '/opt/topspin/exp/stan/nmr/lists/mac/user';
pathl.f1       = '/opt/topspin/exp/stan/nmr/lists/f1';
pathl.wave     = '/opt/topspin/exp/stan/nmr/lists/wave';
%Set-up the local paths:
pathl.notes      = [pathl.experiment,'/notes'] ;
pathl.exp_data   = [pathl.experiment,'/exp_data'] ;
pathl.sim_data   = [pathl.experiment,'/sim_data'] ;
pathl.scripts    = [pathl.experiment,'/scripts'] ;
pathl.exp_results= [pathl.exp_data  ,'/results'] ;
pathl.sim_results= [pathl.sim_data  ,'/results'] ;
pathl.tmp        = [pathl.experiment,'/.tmp'];
pathl.pulses     = [pathl.experiment,'/pulses'] ;
pathl.textshapes = [pathl.experiment,'/textshapes'];
      pathl.presimpulses   = [pathl.pulses     ,'/presimpulses'];    
      pathl.pulseinfo      = [pathl.pulses     ,'/pulseinfo'];    
      pathl.brukershapes   = [pathl.pulses,'/brukershapes'];
      pathl.matlabshapes   = [pathl.pulses,'/matlabshapes'];
      pathl.simshapes      = [pathl.pulses,'/simshapes'];        
pathl.pulseprog  = [pathl.experiment,'/pulseprog'] ;
      pathl.compiled       = [pathl.pulseprog  ,'/compiled'];
      pathl.precompiled    = [pathl.pulseprog  ,'/precompiled']; 
           pathl.calibration    = [pathl.precompiled,'/calibration'];
           pathl.references     = [pathl.precompiled,'/references'];
           pathl.headterm       = [pathl.precompiled,'/header_term'];
           pathl.activepp       = [pathl.precompiled,'/activepp'];
           pathl.test           = [pathl.precompiled,'/test'];
%Set-up the experiment variables:
experiment;
eval(['cd ', pathl.experiment]);

% Load the sample settings:
spins     = read_nucleus_file('molecule.def');

%Display a summary:
if comm_swich == 0
  fprintf('------------------------------------------------------------------\n'); 
  fprintf('No transfer to the spectrometer.\n');
  fprintf('------------------------------------------------------------------\n'); 
else
  fprintf('------------------------------------------------------------------\n');
  fprintf('You are using the spectro''s Ip: %s and the login:%s \n',ip,login);
  fprintf('You are working within the %s \n',pathl.dataset);
  fprintf('------------------------------------------------------------------\n');
end;

 fprintf('------------------------------------------------------------------\n');
  fprintf('In this experiment the molecule has the following attributes:\n')
  spins
  fprintf('------------------------------------------------------------------\n');

%Display the documentation command:
fprintf('\n \nType "docnmr" to display the package documentation.\n\n');
