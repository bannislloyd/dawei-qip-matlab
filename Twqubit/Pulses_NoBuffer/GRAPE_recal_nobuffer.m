% Recalculate GRAPE pulses without 4us buffer.
% AU program
clear;

HomePath    = '/home/d29lu/pulseexam_12qubit/C_rotations/GRAPE_nobuffer';
ServerPath = 'hkatiyar@feynman.math.uwaterloo.ca';
ServerDir = '/u/hkatiyar/pulsefinder_DL';

Ordi2 = '/home/d29lu/pulsefinder';

%% write the cluster file %%

    ClusterFile = 'Cluster_NoBuffer.m';
    cluster = fopen(ClusterFile,'w');
    fprintf(cluster,'pfobj = pulsefinder_cluster_sge; \n\n');

%% For all 90 rotations
Pulse_Name = cell(1,8);
Pulse_U = cell(1,8);

Pulse_Name{1} = 'twqubit_C790';
Pulse_U{1} = 'expm(-1i*(90*pi/180)/2*full(mkstate(''+1IIIIIIXIIIII'',0)))';

Pulse_Name{2} = 'twqubit_C290';
Pulse_U{2} = 'expm(-1i*(90*pi/180)/2*full(mkstate(''+1IXIIIIIIIIII'',0)))';

Pulse_Name{3} = 'twqubit_C234790';
Pulse_U{3} = 'expm(-1i*(90*pi/180)/2*full(mkstate(''+1IXIIIIIIIIII+1IIXIIIIIIIII+1IIIXIIIIIIII+1IIIIIIXIIIII'',0)))';

Pulse_Name{4} = 'twqubit_C234790withPC';
Pulse_U{4} = 'expm(-1i*(90*pi/180)/2*full(mkstate(''+1IXIIIIIIIIII-1IIYIIIIIIIII+1IIIXIIIIIIII+1IIIIIIXIIIII'',0)))*expm(-1i*((8778.95-20696)*(3360*1e-6)*360*pi/180)/2*full(mkstate(''-1IZIIIIIIIIII'',0)))*expm(-1i*((6245.16675-20696)*(3360*1e-6)*360*pi/180)/2*full(mkstate(''-1IIZIIIIIIIII'',0)))*expm(-1i*((10333.55-20696)*(3360*1e-6)*360*pi/180)/2*full(mkstate(''-1IIIZIIIIIIII'',0)))*expm(-1i*((11928.21998-20696)*(3360*1e-6)*360*pi/180)/2*full(mkstate(''-1IIIIIIZIIIII'',0)))';

Pulse_Name{5} = 'twqubit_C134690andH90';
Pulse_U{5} = 'expm(-1i*(90*pi/180)/2*full(mkstate(''+1XIIIIIIIIIII+1IIXIIIIIIIII+1IIIXIIIIIIII+1IIIIIXIIIIII-1IIIIIIIYIIII-1IIIIIIIIYIII-1IIIIIIIIIYII-1IIIIIIIIIIYI-1IIIIIIIIIIIY'',0)))';

Pulse_Name{6} = 'twqubit_C1234690withPC';
Pulse_U{6} = 'expm(-1i*(90*pi/180)/2*full(mkstate(''+1YIIIIIIIIIII+1IXIIIIIIIIII-1IIYIIIIIIIII+1IIIYIIIIIIII-1IIIIIYIIIIII'',0)))*expm(-1i*((30020.877-20696)*(6600*1e-6)*360*pi/180)/2*full(mkstate(''-1ZIIIIIIIIIII'',0)))';

Pulse_Name{7} = 'twqubit_C2Y5X90';
Pulse_U{7} = 'expm(-1i*(90*pi/180)/2*full(mkstate(''+1IYIIIIIIIIII+1IIIIXIIIIIII'',0)))';

Pulse_Name{8} = 'twqubit_C590';
Pulse_U{8} = 'expm(-1i*(90*pi/180)/2*full(mkstate(''+1IIIIXIIIIIII'',0)))';


Calibration = 25000;
FirstLine = 21;
Time = 1e-3;
Length_90 = 100;
dt = Time/Length_90;
Output1 = 'test1';
Output2 = 'test2';

for ii = 1:8
    
    Name1 = [Pulse_Name{ii}, '_C_25000.txt'];
    Name2 = [Pulse_Name{ii}, '_H_25000.txt'];
    
    [power1,phase1]=dataout(Name1,Output1,FirstLine,Length_90);
    [power2,phase2]=dataout(Name2,Output2,FirstLine,Length_90);
    
    for jj = 1:Length_90
    Bx_C(jj) = 2*pi*Calibration*power1(jj)/100*cos(phase1(jj)/360*2*pi);
    By_C(jj) = -2*pi*Calibration*power1(jj)/100*sin(phase1(jj)/360*2*pi);
    Bx_H(jj) = 2*pi*Calibration*power2(jj)/100*cos(phase2(jj)/360*2*pi);
    By_H(jj) = -2*pi*Calibration*power2(jj)/100*sin(phase2(jj)/360*2*pi);
    
    %%%%%%%%%%%%%%% Check if the Bx, By conversion is correct. Compare with
    %%%%%%%%%%%%%%% the original pulse. %%%%%%%%%%
%     amp_C(jj) =  abs(Bx_C(jj)+1i*By_C(jj))*100/Calibration/2/pi;
%     phase_C(jj) = mod((180/pi)*angle(Bx_C(jj) - 1i*By_C(jj)),360);
%     amp_H(jj) =  abs(Bx_H(jj)+1i*By_H(jj))*100/Calibration/2/pi;
%     phase_H(jj) = mod((180/pi)*angle(Bx_H(jj) - 1i*By_H(jj)),360);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    temp(jj,1) = dt;
    temp(jj,2) = Bx_C(jj);
    temp(jj,3) = By_C(jj);
    temp(jj,4) = Bx_H(jj);
    temp(jj,5) = By_H(jj);
    end
   
    PulseInfo = [];
    PulseInfo.pulse = temp;
    
    savefile = [Pulse_Name{ii}, '_InitialGuess.mat'];
    save (savefile, 'PulseInfo');
    
    %%%%% write params file %%%%%%%%%
    ParamsFile = [Pulse_Name{ii}, '.m']
    params = fopen(ParamsFile,'w');
    
    fprintf(params,'function params= %s\n',Pulse_Name{ii});
    fprintf(params,'params = []; \n');
    fprintf(params,'params.nucleifile = ''molecule_12qubit.def''; \n');
    fprintf(params,'params.plength = 100; \n');
    fprintf(params,'params.timestep = 10e-6; \n');
    fprintf(params,'params.stepsize = 3e-3; \n');
    fprintf(params,'params.Uwant = %s;\n',Pulse_U{ii});
    fprintf(params,'params.subsystem{1} = [1 2 3 9 10 11]; \n');
    fprintf(params,'params.subsystem{2} = [4 5 6 7 8 12]; \n');
    fprintf(params,'params.subsys_weight = [6 6]; \n');
    fprintf(params,'params.fidelity = 0.995; \n');
    fprintf(params,'params.rfdist = [0.3 0.97;.4 1.00;0.3 1.03]; \n');
    fprintf(params,'params.Hamdist = [1]; \n');
    fprintf(params,'params.Hammatts{1} = 0; \n');
    fprintf(params,'params.spins_ignore = {}; \n');
    fprintf(params,'params.RFmatts(:,:,1) = (1/2)*full(mkstate(''+1XIIIIIIIIIII+1IXIIIIIIIIII+1IIXIIIIIIIII+1IIIXIIIIIIII+1IIIIXIIIIIII+1IIIIIXIIIIII+1IIIIIIXIIIII'',0)); \n');
    fprintf(params,'params.RFmatts(:,:,2) = (1/2)*full(mkstate(''+1YIIIIIIIIIII+1IYIIIIIIIIII+1IIYIIIIIIIII+1IIIYIIIIIIII+1IIIIYIIIIIII+1IIIIIYIIIIII+1IIIIIIYIIIII'',0)); \n');
    fprintf(params,'params.RFmatts(:,:,3) = (1/2)*full(mkstate(''+1IIIIIIIXIIII+1IIIIIIIIXIII+1IIIIIIIIIXII+1IIIIIIIIIIXI+1IIIIIIIIIIIX'',0)); \n');
    fprintf(params,'params.RFmatts(:,:,4) = (1/2)*full(mkstate(''+1IIIIIIIYIIII+1IIIIIIIIYIII+1IIIIIIIIIYII+1IIIIIIIIIIYI+1IIIIIIIIIIIY'',0)); \n');
    fprintf(params,'params.rfmax = 2*pi*[12.5e3 12.5e3 25e3 25e3]; \n'); %%% Note I use 12.5KHz for C channel here
    fprintf(params,'params.randscale = [0.05 0.05 0.05 0.05]; \n');
    fprintf(params,'params.randevery = 25; \n');
    fprintf(params,'params.improvechk = 1e-7; \n');
    fprintf(params,'params.minstepsize = 1e-7; \n');
    fprintf(params,'params.numtry = 1; \n');
    fprintf(params,'params.pulsefreq = [20696 20696 20696 20696 20696 20696 20696 2894 2894 2894 2894 2894];	 \n');
    fprintf(params,'params.softpulsebuffer = 0; \n'); %% buffer is 0 now
    fprintf(params,'load %s\n',savefile);
    fprintf(params,'params.pulseguess = PulseInfo; \n');
    fprintf(params,'params.searchtype = 1; \n');
    fprintf(params,'params.tstepflag = 0; \n');
    fprintf(params,'params.tpulsemax = 10e-3; \n');
    fprintf(params,'params.Zfreedomflag = 0; \n');
    fprintf(params,'params.onofframps = 1; \n');
    fprintf(params,'params.onoff_numpts = 10; \n');
    fprintf(params,'params.onoff_param1 = 1e-3; \n');
    fprintf(params,'params.onoff_param2 = 0.25; \n');
    fprintf(params,'params.dispevery = 60; \n');
    
    fclose(params);
    
    %%% cluster file %%%
    fprintf(cluster,'pfobj.addpulse(''%s'',%d);\n',ParamsFile,ii);
    
    %%%%% transfer files %%%%%%%%%
    arg1=[HomePath,'/',savefile];
    arg2=[HomePath,'/',ParamsFile];
    eval(sprintf ('! scp %s %s:%s',arg1,ServerPath,ServerDir));
    eval(sprintf ('! scp %s %s:%s',arg2,ServerPath,ServerDir));
    
    eval(sprintf ('! scp %s %s',arg1,Ordi2));
    eval(sprintf ('! scp %s %s',arg2,Ordi2));
    fprintf('DONE!\n')
end

%% For all 180 rotations
Pulse_Name = cell(1,10);
Pulse_U = cell(1,10);

Pulse_Name{1} = 'twqubit_C2180';
Pulse_U{1} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1IXIIIIIIIIII'',0)))';

Pulse_Name{2} = 'twqubit_C6180';
Pulse_U{2} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1IIIIIXIIIIII'',0)))';

Pulse_Name{3} = 'twqubit_C4180';
Pulse_U{3} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1IIIXIIIIIIII'',0)))';

Pulse_Name{4} = 'twqubit_C57180';
Pulse_U{4} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1IIIIXIIIIIII+1IIIIIIXIIIII'',0)))';

Pulse_Name{5} = 'twqubit_C1180';
Pulse_U{5} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1XIIIIIIIIIII'',0)))';

Pulse_Name{6} = 'twqubit_C23180';
Pulse_U{6} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1IXIIIIIIIIII+1IIXIIIIIIIII'',0)))';

Pulse_Name{7} = 'twqubit_C156180';
Pulse_U{7} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1XIIIIIIIIIII+1IIIIXIIIIIII+1IIIIIXIIIIII'',0)))';

Pulse_Name{8} = 'twqubit_C2347andH180';
Pulse_U{8} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1IXIIIIIIIIII+1IIXIIIIIIIII+1IIIXIIIIIIII+1IIIIIIXIIIII+1IIIIIIIXIIII+1IIIIIIIIXIII+1IIIIIIIIIXII+1IIIIIIIIIIXI+1IIIIIIIIIIIX'',0)))';

Pulse_Name{9} = 'twqubit_C23456180';
Pulse_U{9} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1IXIIIIIIIIII+1IIXIIIIIIIII+1IIIXIIIIIIII+1IIIIXIIIIIII+1IIIIIXIIIIII'',0)))';

Pulse_Name{10} = 'twqubit_C27180';
Pulse_U{10} = 'expm(-1i*(180*pi/180)/2*full(mkstate(''+1IXIIIIIIIIII+1IIIIIIXIIIII'',0)))';

Calibration = 25000;
FirstLine = 21;
Time = 2e-3;
Length_180 = 200;
dt = Time/Length_180;
Output1 = 'test1';
Output2 = 'test2';

for ii = 1:10
    
    Name1 = [Pulse_Name{ii}, '_C_25000.txt'];
    Name2 = [Pulse_Name{ii}, '_H_25000.txt'];
    
    [power1,phase1]=dataout(Name1,Output1,FirstLine,Length_180);
    [power2,phase2]=dataout(Name2,Output2,FirstLine,Length_180);
    
    for jj = 1:Length_180
    Bx_C(jj) = 2*pi*Calibration*power1(jj)/100*cos(phase1(jj)/360*2*pi);
    By_C(jj) = -2*pi*Calibration*power1(jj)/100*sin(phase1(jj)/360*2*pi);
    Bx_H(jj) = 2*pi*Calibration*power2(jj)/100*cos(phase2(jj)/360*2*pi);
    By_H(jj) = -2*pi*Calibration*power2(jj)/100*sin(phase2(jj)/360*2*pi);
    
    %%%%%%%%%%%%%%% Check if the Bx, By conversion is correct. Compare with
    %%%%%%%%%%%%%%% the original pulse. %%%%%%%%%%
%     amp_C(jj) =  abs(Bx_C(jj)+1i*By_C(jj))*100/Calibration/2/pi;
%     phase_C(jj) = mod((180/pi)*angle(Bx_C(jj) - 1i*By_C(jj)),360);
%     amp_H(jj) =  abs(Bx_H(jj)+1i*By_H(jj))*100/Calibration/2/pi;
%     phase_H(jj) = mod((180/pi)*angle(Bx_H(jj) - 1i*By_H(jj)),360);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    temp(jj,1) = dt;
    temp(jj,2) = Bx_C(jj);
    temp(jj,3) = By_C(jj);
    temp(jj,4) = Bx_H(jj);
    temp(jj,5) = By_H(jj);
    end
   
    PulseInfo = [];
    PulseInfo.pulse = temp;
    
    savefile = [Pulse_Name{ii}, '_InitialGuess.mat'];
    save (savefile, 'PulseInfo');
    
    %%%%% write params file %%%%%%%%%
    ParamsFile = [Pulse_Name{ii}, '.m']
    params = fopen(ParamsFile,'w');
    
    fprintf(params,'function params= %s\n',Pulse_Name{ii});
    fprintf(params,'params = []; \n');
    fprintf(params,'params.nucleifile = ''molecule_12qubit.def''; \n');
    fprintf(params,'params.plength = 200; \n');
    fprintf(params,'params.timestep = 10e-6; \n');
    fprintf(params,'params.stepsize = 3e-3; \n');
    fprintf(params,'params.Uwant = %s;\n',Pulse_U{ii});
    fprintf(params,'params.subsystem{1} = [1 2 3 9 10 11]; \n');
    fprintf(params,'params.subsystem{2} = [4 5 6 7 8 12]; \n');
    fprintf(params,'params.subsys_weight = [6 6]; \n');
    fprintf(params,'params.fidelity = 0.995; \n');
    fprintf(params,'params.rfdist = [0.3 0.97;.4 1.00;0.3 1.03]; \n');
    fprintf(params,'params.Hamdist = [1]; \n');
    fprintf(params,'params.Hammatts{1} = 0; \n');
    fprintf(params,'params.spins_ignore = {}; \n');
    fprintf(params,'params.RFmatts(:,:,1) = (1/2)*full(mkstate(''+1XIIIIIIIIIII+1IXIIIIIIIIII+1IIXIIIIIIIII+1IIIXIIIIIIII+1IIIIXIIIIIII+1IIIIIXIIIIII+1IIIIIIXIIIII'',0)); \n');
    fprintf(params,'params.RFmatts(:,:,2) = (1/2)*full(mkstate(''+1YIIIIIIIIIII+1IYIIIIIIIIII+1IIYIIIIIIIII+1IIIYIIIIIIII+1IIIIYIIIIIII+1IIIIIYIIIIII+1IIIIIIYIIIII'',0)); \n');
    fprintf(params,'params.RFmatts(:,:,3) = (1/2)*full(mkstate(''+1IIIIIIIXIIII+1IIIIIIIIXIII+1IIIIIIIIIXII+1IIIIIIIIIIXI+1IIIIIIIIIIIX'',0)); \n');
    fprintf(params,'params.RFmatts(:,:,4) = (1/2)*full(mkstate(''+1IIIIIIIYIIII+1IIIIIIIIYIII+1IIIIIIIIIYII+1IIIIIIIIIIYI+1IIIIIIIIIIIY'',0)); \n');
    fprintf(params,'params.rfmax = 2*pi*[12.5e3 12.5e3 25e3 25e3]; \n'); %%% Note I use 12.5KHz for C channel here
    fprintf(params,'params.randscale = [0.05 0.05 0.05 0.05]; \n');
    fprintf(params,'params.randevery = 25; \n');
    fprintf(params,'params.improvechk = 1e-7; \n');
    fprintf(params,'params.minstepsize = 1e-7; \n');
    fprintf(params,'params.numtry = 1; \n');
    fprintf(params,'params.pulsefreq = [20696 20696 20696 20696 20696 20696 20696 2894 2894 2894 2894 2894];	 \n');
    fprintf(params,'params.softpulsebuffer = 0; \n'); %% buffer is 0 now
    fprintf(params,'load %s\n',savefile);
    fprintf(params,'params.pulseguess = PulseInfo; \n');
    fprintf(params,'params.searchtype = 1; \n');
    fprintf(params,'params.tstepflag = 0; \n');
    fprintf(params,'params.tpulsemax = 10e-3; \n');
    fprintf(params,'params.Zfreedomflag = 0; \n');
    fprintf(params,'params.onofframps = 1; \n');
    fprintf(params,'params.onoff_numpts = 10; \n');
    fprintf(params,'params.onoff_param1 = 1e-3; \n');
    fprintf(params,'params.onoff_param2 = 0.25; \n');
    fprintf(params,'params.dispevery = 60; \n');
    
    fclose(params);
    
    %%% cluster file %%%
    fprintf(cluster,'pfobj.addpulse(''%s'',%d);\n',ParamsFile,ii);
    
    %%%%% transfer files %%%%%%%%%
    arg1=[HomePath,'/',savefile];
    arg2=[HomePath,'/',ParamsFile];
    eval(sprintf ('! scp %s %s:%s',arg1,ServerPath,ServerDir));
    eval(sprintf ('! scp %s %s:%s',arg2,ServerPath,ServerDir));
    
    eval(sprintf ('! scp %s %s',arg1,Ordi2));
    eval(sprintf ('! scp %s %s',arg2,Ordi2));
    fprintf('DONE!\n')
end
    %% write cluster again %%
    fprintf(cluster,'\n pfobj.submit(1:1); \n');
    fprintf(cluster,'\n pfobj.dispresults; \n');
    fprintf(cluster,'\n pfobj.displogfile([1 3]); \n');
    fprintf(cluster,'\n pulse2 = pfobj.getresults(2); \n');
    
    fclose(cluster);
    
    eval(sprintf ('! scp %s %s',ClusterFile,Ordi2));
    fprintf('DONE!\n')
