function specstruc = getspec(expdir,pnum)

%Function to load spectromter data into matlab and properly deal with the
%ieee-be versus ieee-le mess. 
%
% function specstruc = getspec(expdir (string),pnum (int));
%
% expdir is full path name to experimental directory and pnum is process
% number
%
% Outputs a spectrum structure 
%
% Written by Colm Ryan 16 August, 2007

%If we don't have a process number specified then load number 1
if(nargin<2)
    pnum = 1;
end

%Process the acqus file to get some acquisition info
ACQUS = fopen([expdir, '/acqus'], 'r');

if(ACQUS == -1)
    error('Unable to open acqus file.');
end

line = fgetl(ACQUS);
while (line ~= -1)
    [byteorder,cnt] = sscanf(line, '##$BYTORDA=%d',1);
    if(cnt) fid_byteorder = byteorder; end;
    [o1,cnt] = sscanf(line, '##$O1=%f',1);
    if (cnt); specstruc.o1 = -o1; end;
    [swh,cnt] = sscanf(line, '##$SW_h=%f',1);
    if (cnt); specstruc.swh = swh; end;
    [td,cnt] = sscanf(line, '##$TD=%d',1);
    if (cnt); specstruc.td = td; end;

    line = fgetl(ACQUS);
end

%Load the fid
if(fid_byteorder)
    FID = fopen([expdir, '/fid'],'r','ieee-be');
else
    FID = fopen([expdir, '/fid'],'r','ieee-le');
end

if(FID == -1)
    error('Unable to open fid file.');
end

rawFID = fread(FID, inf, 'int32');

specstruc.fid = rawFID(1:2:end)-i*rawFID(2:2:end);

%Process the procs file to get the processing information
PROCS = fopen([expdir, sprintf('/pdata/%d/procs',pnum)], 'r');

if(PROCS == -1)
    error('Unable to open procs file.');
end

line = fgetl(PROCS);
while (line ~= -1)
    [byteorder,cnt] = sscanf(line, '##$BYTORDP=%d',1);
    if(cnt) spec_byteorder = byteorder; end;
    [phc0,cnt] = sscanf(line, '##$PHC0=%f',1);
    if (cnt); specstruc.phc(1) = phc0; end;
    [phc1,cnt] = sscanf(line, '##$PHC1=%f',1);
    if (cnt); specstruc.phc(2) = phc1; end;
    [NC_proc,cnt] = sscanf(line, '##$NC_proc=%d',1);
    if (cnt); specstruc.NC_proc = NC_proc; end;
    [SI,cnt] = sscanf(line, '##$SI=%d',1);
    if (cnt); specstruc.si = SI; end;
    

    line = fgetl(PROCS);
end

%Load the processed spectrum 
if(spec_byteorder)
    SPECREAL = fopen([expdir, sprintf('/pdata/%d/1r',pnum)],'r','ieee-be');
    SPECIMAG = fopen([expdir, sprintf('/pdata/%d/1i',pnum)],'r','ieee-be');
else
    SPECREAL = fopen([expdir, sprintf('/pdata/%d/1r',pnum)],'r','ieee-le');
    SPECIMAG = fopen([expdir, sprintf('/pdata/%d/1i',pnum)],'r','ieee-le');
end

if(SPECREAL == -1 || SPECIMAG == -1)
    error('Unable to open processed 1r or 1i file.');
end

specreal = fread(SPECREAL,inf,'int32');
specimag = fread(SPECIMAG,inf,'int32');

specstruc.spec = specreal + i*specimag;
specstruc.spec = 2^(specstruc.NC_proc)*specstruc.spec;

%Close all the files
fclose all;

