%Script to initialize matlab for a specific experiment:
%All the paths are stored inside a structure called pathl.

%Load global variables:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global_init;

%Set-up the progress indicator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
progressDisplay = 1; %progress indicator on/off

%Communicate with the spectro or not?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
comm_swich = 1;

%Set-up the spectro connection param:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
login         = 'mditty';
ip            = '129.97.47.82';

%Set-up the dataset config on the spectro:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%dataset       = 'zhang_mag';    %magic state
%dataset       = 'zhang_gp';    %Geometric phase
dataset       = 'Fengcrot';    %error correction
pathl.dataset = ['/opt/topspin/data/mditty/nmr/',dataset];
pathl.suffix  = 'GF/';  

ref_exp_start = 10;
%Basic set-up for the experiments dataset:
%<exp_nb>,<nb repet_loops>,<template exp>,<Calibration parameters file>
basicexp.H    = {1,1,100,'/home/mditty/Calibration/crotonic/calibHobs.dat','/home/mditty/Calibration/crotonic/results/poweroutH'};
basicexp.C    = {2,4,200,'/home/mditty/Calibration/crotonic/calibCobs.dat','/home/mditty/Calibration/crotonic/results/poweroutC'};


%Set-up reference and calibration pulses and pulse sequences:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Definition files:
Def_name_h = 'defs.h';
Def_name_t = 'defs.t';

%Reference pulses and pulsequences:(they have to be in the same
%order thant the corresponding nucleus in the molecule file)
pulist.ref   = {'Hh90','Ch90'};
pplist.ref   = {'rRHg.pup','rMg.pup','rH1g.pup','rH2g.pup',...
	'rRCg.pup','rC1g.pup','rC2g.pup','rC3g.pup','rC4g.pup'};

%Calibration pulses and pulses sequences:
%pulist.calib = {'Hhc180','M90','C190','C290','C390','C490',...
%    'C1180','C4180','M180','C2180H','M180H'};

%pplist.calib = {'cHhc180.pup','cM90.pup',...
%    'cC190.pup','cC290.pup','cC390.pup','cC490.pup','cC1180.pup', ...
%    'cC4180.pup','cM180.pup','cC2180H.pup','cM180H.pup','cM180Hb.pup'};

%pulist.calib = {'M90'};
%pplist.calib = {'cM90.pup'};

pulist.calib = {'cHh90','cCh90','RH_M90','RC_C190','RC_C290','RCC2180', ...
    'RCC1180','RCC218H','RH_M180','RHM180H','RH_rf','RC_C145','RC_C245'};

pplist.calib = {'cRC_Ch90.pup','cRC_Ch90_rf.pup','cRC_Hh90.pup','cRC_M90.pup','cRC_C190.pup','cRC_C290.pup', ...
    'cRC_C1180.pup','cRC_C2180H.pup','cRC_M180.pup','cRC_M180H.pup','cRC_C2180.pup','cRC_rfsel.pup',...
    'cRH_M180.pup','cRH_M90.pup'};

%pplist.calib = {'cHhc180.pup','cM90.pup',...
%    'cC190b.pup','cC290b.pup','cC390.pup','cC490.pup','cC1180.pup', ...
%    'cC4180.pup','cM180.pup','cC2180H.pup','cM180H.pup'};


%pulist.pulse = {'Hh90','Ch90''M90','Hhc180','M90','C190','C290','C390','C490',...
%    'C1180','C4180','M180','C2180H'};

%pplist.pulse


