%
% Matlab function
%
% Return a spectrum structure according to processed bruker data.
%
% Input: 
%   path   ; directory for the file information.
%   ; spectral width and frequency of transmitter are
%   ; obtained from the acqus file.
%   The processed data asked for is loaded.
%
% Spectrum structure:
%   .ph  ;phase correction (two element array).
%   .o1  ;center frequency relative to standard.
%   .swh ;spectral width.
%   .fid ;induction decay signal, if available.
%   .spec;spectrum, properly centered.
%
%   Requirement: The lengths of .fid and .spec must be even.
%
%
%%%

function spec = get_pspec(path, pnumber);
  
  spec.ph = [0,0];
  spec.o1 = 0;
  spec.swh = 0;
  
  %filed = fopen([path, sprintf('/pdata/%d/1r', pnumber)], 'r', 'ieee-be'); %for unix formatted
  filed = fopen([path, sprintf('/pdata/%d/1r', pnumber)], 'r', 'ieee-le'); % for windows
  if filed < 0; fprintf(2, 'Error opening 1r.\n'); return; end;
  [pdatar, sl] = fread(filed, inf, 'long');
  fclose(filed);
  
  %filed = fopen([path, sprintf('/pdata/%d/1i', pnumber)], 'r', 'ieee-be'); %for unix
  filed = fopen([path, sprintf('/pdata/%d/1i', pnumber)], 'r', 'ieee-le'); % for windows
  if filed < 0; fprintf(2, 'Error opening 1i.\n'); return; end;
  [pdatai, sl] = fread(filed, inf, 'long');
  fclose(filed);
  
  spec.spec = pdatar(1:sl)+i*pdatai(1:sl);
  
  % Get swh and o1 information:
  filed = fopen([path, '/acqus'], 'r');
  if (filed < 0); filed = fopen([path, '/acqu'], 'r'); end;
  
  acCount = 1;
  while (acCount);
    [acData, acCount] = fscanf(filed, '%[^\n]\n',1);
    [o1,cnt] = sscanf(acData, '##$O1=%f',1);
    if (cnt); spec.o1 = -o1; end;
    [swh,cnt] = sscanf(acData, '##$SW_h=%f',1);
    if (cnt); spec.swh = swh; end;
    [td,cnt] = sscanf(acData, '##$TD=%d',1);
    if (cnt); spec.td = td/2; end;
  end;
  fclose(filed);
  
  % Get scaling and phase correction information:
  filed = fopen([path, sprintf('/pdata/%d/procs', pnumber)], 'r');
  acCount = 1;
  while (acCount);
    [acData, acCount] = fscanf(filed, '%[^\n]\n',1);
    [p0,cnt]      = sscanf(acData, '##$PHC0=%f',1);
    if (cnt); 
      spec.ph(1) = p0*2*pi/360; 
      spec.spec  = spec.spec*exp(-i*spec.ph(1));
    end;
    [sc,cnt]            = sscanf(acData, '##$NC_proc=%f',1);
    if (cnt); spec.spec = spec.spec*2^(sc+10); end;
  end;
  fclose(filed);
  
  return;
  
  
