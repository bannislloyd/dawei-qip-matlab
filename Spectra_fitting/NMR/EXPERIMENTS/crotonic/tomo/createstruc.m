
function struc = createstruc(numexp);
cc = 'F:\matlab\Spectra_fitting\NMR\EXPERIMENTS\crotonic\results';

for k=1:length(numexp)
   struc{k} =  getspec([cc '\' num2str(numexp(k))],1);
end
