%
% Matlab function.
%
% Applies the phase correction to a spectrum structure and
% returns the corrected spectrum.
%
%%%
function ospec = applyPhase(ispec);

sl = size(ispec.spec,1);
ospec = exp(i*ispec.ph(1))*ispec.spec.*exp(i*ispec.ph(2)*(ispec.swh/sl)*(-sl/2:sl/2-1)).';

return;