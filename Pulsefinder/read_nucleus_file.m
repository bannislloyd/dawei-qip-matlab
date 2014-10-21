%
% Matlab function.
%
% Reads the nuclear data file in preparation for simulation
% 
%%%
function [spins] = read_nucleus_file(filename);
global pathl

%Error message
errorMessage = '';
nucs         = fopen(sprintf('%s',filename), 'r');
if (nucs < 0);
  error('readNuclei: Could not open nuclear data file.');
  return;
end;

%Variables initalization 
spins.typeNames = {};
rcnt            = 0;
nucCount        = 1;
tab             = sprintf('\t');
idx             = [];
T2count         = 1;
larmor_count    = 1;

%Computes the ref freq
while (nucCount);
  [nucData, nucCount] = fscanf(nucs, '%[^\n]%[\n]',1);
  tchar               = fscanf(nucs,'%[\n]', 1);
  fields              = {};fields = split(nucData, tab);
  if (length(nucData) <= 0);
    ;
  elseif (strcmp(fields{1}, 'meval'));
    eval(fields{2});
  elseif (strcmp(fields{1}, 'refFreq'));
    nucType   = strmatch(fields{2}, spins.typeNames, 'exact');
    freqNucs  = {}; freqNucs = split(fields{3}, ';');
    freqs     = [];
    for n     = (1:length(freqNucs));
      nucn    = strmatch(freqNucs{n}, spins.nucNames, 'exact');
      freqs(n)= spins.freqs(nucn);
    end;
    spins.refFreqs(nucType)     = (min(freqs) + max(freqs))/2;
    spins_sim.refFreqs(nucType) = spins.refFreqs(nucType);
  elseif (strcmp(fields{1}, 'offsetFreq'));
      
    
%Reads the freqs and couplings
  elseif (strmatch('# Nuclear types', nucData) > 0);
    rcnt = 1;
  elseif (strmatch('# Nuclei:', nucData) > 0);
    rcnt   = 2;
    nucNum = 0;
    nucType= 0;
  elseif (strmatch('# Couplings:', nucData) > 0);
    rcnt         = 3;
    nucNum1      = 0; nucNum2 = nucNum;    
    spins.jfreqs = zeros(nucNum, nucNum);
  elseif (strmatch('# T2 error rates:', nucData) > 0);
    rcnt = 4;
  elseif (strcmp(nucData(1), '#'));
    ;
  else;
    pos1 = [];
    pos1 = findstr(tab, nucData);
    if (length(pos1) <= 2); pos1(3) = length(nucData)+1; end;
    if (rcnt == 1);
      spins.larmor(larmor_count) = sscanf(fields{1},'%f');
      larmor_count               = larmor_count +1;
    elseif rcnt == 2
      nucNum=nucNum+1;
      spins.freqs(nucNum)    = sscanf(nucData(1:pos1(1)-1), '%g', 1);
      spins.nucNames{nucNum} = nucData(pos1(1)+1:pos1(2)-1);
      typeName               = nucData(pos1(2)+1:pos1(3)-1);
      idx                    = strmatch(typeName, spins.typeNames, 'exact');
      if (length(idx) > 0); 
        spins.nucs(nucNum) = idx(1);
      else;
        nucType                  = nucType+1;
        spins.nucs(nucNum)       = nucType;
        spins.typeNames{nucType} = typeName;
      end;
    elseif (rcnt == 3);
      nucNum2 = nucNum2+1;
      if (nucNum2 > nucNum);
        nucNum1 = nucNum1+1;
        if (nucNum1 >= nucNum); break; end;
        nucNum2 = nucNum1+1;
      end;
      spins.jfreqs(nucNum1,nucNum2) = sscanf(nucData(1:pos1(1)-1), '%g', 1);
     elseif (rcnt == 4)
      spins.T2(T2count) = sscanf(fields{1},'%f');
      T2count           = T2count +1;
    end;
  end;

end;
spins.jfreqs = spins.jfreqs + spins.jfreqs';
fclose(nucs);
spins.nb      = size(spins.nucs,2);



