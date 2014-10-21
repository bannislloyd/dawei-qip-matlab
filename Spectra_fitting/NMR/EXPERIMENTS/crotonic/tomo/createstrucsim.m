
function struc = createstrucsim(nomestruc)
% function struc = createstrucsim(nomestruc,cc);
cc = 'C:\Users\carolineru\Desktop\NMR\EXPERIMENTS\crotonic\results';
dd='simdata';

for k=1:length(nomestruc)
    f=nomestruc(k);
   eval(['load ' cc '\' num2str(f) '\' dd]) 
   struc{k} =  spec;
end
