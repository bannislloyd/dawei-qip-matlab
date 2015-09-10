function Spectra_Read( SpecPath, ExpNo, ProcNo, SaveFlag )
%Read out the NMR Spectra Data to Matlab Files, Combined with getspec.m.
%   SpecPath: location of the NMR spectra
%   ExpNo: Experiment Number in Bruker
%   ProcNo: Proc Number in Bruker
%   SaveFlag: A string of the savefile name. 

if(nargin<3)
    ProcNo = 1;
end

specstruc = getspec([SpecPath, '\', num2str(ExpNo)], ProcNo);

N = length(specstruc.spec);
swh = specstruc.swh;
o1 = -specstruc.o1;

step = swh/(N-1);

 for ii = 1:N
     X_exp(ii) = o1+swh/2-(ii-1)*step;
     Y_exp(ii) = real(specstruc.spec(ii));
 end
 
 if (SaveFlag)
     eval(['save ', SaveFlag,'.mat X_exp Y_exp'])
 end

end

