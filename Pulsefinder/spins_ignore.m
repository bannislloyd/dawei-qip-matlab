function[spins]=spins_ignore(spins)

if isfield( spins,'ignore')  
    cpt=0;
    for a=1:length(spins.ignore)
      for b=1:spins.nb
	if strcmp(spins.ignore{a},spins.nucNames{b})
	  cpt   = cpt+1;
	  A(cpt)= b;
	end;
      end;
    end;
    spins.nucs     = takeout(spins.nucs,A);
    spins.nucNames = takeout(spins.nucNames,A);
    spins.T2       = takeout(spins.T2,A);    
    spins.nb       = length(spins.nucNames);  
    cpt = 1;
    cpt1= 1;
    A   = sort(A);    
    cpt=0;
    for a=1:length(A)
      spins.freqs(A(a)-cpt)   = [];
      spins.jfreqs(A(a)-cpt,:)= [];
      spins.jfreqs(:,A(a)-cpt)= [];
      cpt = cpt+1;
    end;
    
end;
   
  clear spins_tmp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
