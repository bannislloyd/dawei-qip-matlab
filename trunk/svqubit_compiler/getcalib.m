
function getcalib(ref_exp_nb);
% Alexandre. July 2009 Program created to get calibration 
% experiments from spectrometer 
% 
%
% getcalib(ref_exp_nb,targfolder);
% ref_exp_nb is a vector with the number of experiments 
% 
%  This program save data in targfold (You may ceate it if 
%   you do not have it  )

%==========================================================================

global ip login pathl

targfolder = '/home/g5feng/NMR/EXPERIMENTS/ErrorC/results';   %Error correction and thermal state


for a=1:length(ref_exp_nb)
if a==1;
  strsave=sprintf('%i',ref_exp_nb(a));
else
  strsave= sprintf('%s,%i',strsave,ref_exp_nb(a));
end;
  str    = sprintf('!scp -r %s@%s:%s/%i %s/. ', login,ip,pathl.dataset,ref_exp_nb(a), targfolder);
  eval(str);
  
end;


