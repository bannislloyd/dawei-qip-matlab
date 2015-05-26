

% Combine many small shape files into one big shape file

clear;

addpath fixed_pulses

Pulse_Name = cell(1,18);
Output_C = cell(1,18);
Output_H = cell(1,18);

Pulse_Name{1} = 'twqubit_C790';
Pulse_Name{2} = 'twqubit_C290';
Pulse_Name{3} = 'twqubit_C234790';
Pulse_Name{4} = 'twqubit_C234790withPC';
Pulse_Name{5} = 'twqubit_C134690andH90';
Pulse_Name{6} = 'twqubit_C1234690withPC';
Pulse_Name{7} = 'twqubit_C2Y5X90';
Pulse_Name{8} = 'twqubit_C590';
Pulse_Name{9} = 'twqubit_C2180';
Pulse_Name{10} = 'twqubit_C6180';
Pulse_Name{11} = 'twqubit_C4180';
Pulse_Name{12} = 'twqubit_C57180';
Pulse_Name{13} = 'twqubit_C1180';
Pulse_Name{14} = 'twqubit_C23180';
Pulse_Name{15} = 'twqubit_C156180';
Pulse_Name{16} = 'twqubit_C2347andH180';
Pulse_Name{17} = 'twqubit_C23456180';
Pulse_Name{18} = 'twqubit_C27180';

Fix_Number_C = [5,7,5,5,5,5,4,8,8,8,4,6,6,9,5,7,7,9];
Fix_Number_H = [5,6,7,7,9,7,8,7,9,4,8,4,4,5,9,5,4,4];

Calibration_C = 25000;
Calibration_H = 25000;

for ii = 1:18
    Output_C{ii} = [Pulse_Name{ii}, '_C_', num2str(Calibration_C), '_NoBufferfix', num2str(Fix_Number_C(ii))];
    Output_H{ii} = [Pulse_Name{ii}, '_H_', num2str(Calibration_H), '_NoBufferfix', num2str(Fix_Number_H(ii))];
end

Length_90 = 100;
Length_180 = 200;
dt = 1e-5;
Output1 = 'test';
Output2 = 'test';

Calibration = 25000; % the calibration power used for the big shapefile
Calibration_old = 25000; % the calibration power for the single rotations
Amplitude = Calibration;

FirstLine = 19; % for C57180

[power_C790_C,phase_C790_C]=dataout(Output_C{1},Output1,FirstLine,Length_90);
[power_C790_H,phase_C790_H]=dataout(Output_H{1},Output1,FirstLine,Length_90);

[power_C2180_C,phase_C2180_C]=dataout(Output_C{9},Output1,FirstLine,Length_180);
[power_C2180_H,phase_C2180_H]=dataout(Output_H{9},Output1,FirstLine,Length_180);

[power_C6180_C,phase_C6180_C]=dataout(Output_C{10},Output1,FirstLine,Length_180);
[power_C6180_H,phase_C6180_H]=dataout(Output_H{10},Output1,FirstLine,Length_180);

[power_C4180_C,phase_C4180_C]=dataout(Output_C{11},Output1,FirstLine,Length_180);
[power_C4180_H,phase_C4180_H]=dataout(Output_H{11},Output1,FirstLine,Length_180);

[power_C57180_C,phase_C57180_C]=dataout(Output_C{12},Output1,FirstLine,Length_180);
[power_C57180_H,phase_C57180_H]=dataout(Output_H{12},Output1,FirstLine,Length_180);

load Para.mat
%% From Z7 to Z24567
step_27 = 667; %round(1/(4*Para(2,7))/dt);
step_67_27 =56; % round((1/(4*Para(6,7))-1/(4*Para(2,7)))/dt);
step_47_67 = 138; %round((1/(4*Para(4,7))-1/(4*Para(6,7)))/dt);
step_57_47 = 288; %round((1/(4*Para(5,7))-1/(4*Para(4,7)))/dt);
step_57 = 1149; %round((1/(4*Para(5,7)))/dt);

% all free evolutions
Free27 = zeros(step_27,1); Free67_27 = zeros(step_67_27,1); Free47_67 = zeros(step_47_67,1); Free57_47 = zeros(step_57_47,1); Free57 = zeros(step_57,1);
% all pulses, 6 in total
P1C = power_C790_C; PH1C = grape_phase(phase_C790_C, 'X', 'Y'); P1H = power_C790_H; PH1H = grape_phase(phase_C790_H, 'X', 'Y');
P2C = power_C2180_C; PH2C = phase_C2180_C; P2H = power_C2180_H; PH2H = phase_C2180_H;
P3C = power_C6180_C; PH3C = phase_C6180_C; P3H = power_C6180_H; PH3H = phase_C6180_H;
P4C = power_C4180_C; PH4C = phase_C4180_C; P4H = power_C4180_H; PH4H = phase_C4180_H;
P5C = power_C57180_C; PH5C = phase_C57180_C; P5H = power_C57180_H; PH5H = phase_C57180_H;
P6C = power_C790_C; PH6C = grape_phase(phase_C790_C, 'X', '-Y'); P6H = power_C790_H; PH6H = grape_phase(phase_C790_H, 'X', '-Y');


power_encoding1_C = [P1C; Free27;P2C; Free67_27; P3C; Free47_67;P4C; Free57_47;...
                                  P5C; Free57;P6C]*Calibration/Calibration_old;
phase_encoding1_C = [PH1C; Free27;PH2C; Free67_27; PH3C; Free47_67;PH4C; Free57_47;...
                                  PH5C; Free57;PH6C];
power_encoding1_H = [P1H; Free27;P2H; Free67_27; P3H; Free47_67;P4H; Free57_47;...
                                  P5H; Free57;P6H]*Calibration/Calibration_old;
phase_encoding1_H = [PH1H; Free27;PH2H; Free67_27; PH3H; Free47_67;PH4H; Free57_47;...
                                  PH5H; Free57;PH6H];

total_time_encoding1 = length(power_encoding1_C)*dt

outputfile = 'twqubit_encoding1_C_nobuffer_fix';
shpfile = fopen(outputfile,'w');
    fprintf(shpfile,'##TITLE= %s\n',outputfile);
    fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
    fprintf(shpfile,'##DATA TYPE= Shape Data\n');
    fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
    fprintf(shpfile,'##OWNER= Dawei\n');
    fprintf(shpfile,'##DATE= %s\n',date);
    time = clock;
    fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
    fprintf(shpfile,'##MINX= %7.6e\n',min(power_encoding1_C));
    fprintf(shpfile,'##MAXX= %7.6e\n',max(power_encoding1_C));
    fprintf(shpfile,'##MINY= %7.6e\n',min(phase_encoding1_C));
    fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_encoding1_C));
    fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
    fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
    fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_MODE= 1\n');
    fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_encoding1);
    fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
    fprintf(shpfile,'##NPOINTS= %d\n',length(power_encoding1_C));
    fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');

for ii = 1:length(power_encoding1_C)
    fprintf(shpfile,'  %7.6e,  %7.6e\n',power_encoding1_C(ii),phase_encoding1_C(ii));
end

    fprintf(shpfile,'##END=\n');
    
outputfile = 'twqubit_encoding1_H_nobuffer_fix';
shpfile = fopen(outputfile,'w');
    fprintf(shpfile,'##TITLE= %s\n',outputfile);
    fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
    fprintf(shpfile,'##DATA TYPE= Shape Data\n');
    fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
    fprintf(shpfile,'##OWNER= Dawei\n');
    fprintf(shpfile,'##DATE= %s\n',date);
    time = clock;
    fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
    fprintf(shpfile,'##MINX= %7.6e\n',min(power_encoding1_H));
    fprintf(shpfile,'##MAXX= %7.6e\n',max(power_encoding1_H));
    fprintf(shpfile,'##MINY= %7.6e\n',min(phase_encoding1_H));
    fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_encoding1_H));
    fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
    fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
    fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_MODE= 1\n');
    fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_encoding1);
    fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
    fprintf(shpfile,'##NPOINTS= %d\n',length(power_encoding1_H));
    fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');

for ii = 1:length(power_encoding1_H)
    fprintf(shpfile,'  %7.6e,  %7.6e\n',power_encoding1_H(ii),phase_encoding1_H(ii));
end

    fprintf(shpfile,'##END=\n');
%     
% %% From Z24567 to Z1234567
step_12 = 434; %round(1/(4*Para(1,2))/dt);
step_23_12 = 330; %round((1/(4*Para(2,3))-1/(4*Para(1,2)))/dt);
step_23 = 764; %round((1/(4*Para(2,3)))/dt);

FirstLine = 19; % for C57180

[power_C290_C,phase_C290_C]=dataout(Output_C{2},Output1,FirstLine,Length_90);
[power_C290_H,phase_C290_H]=dataout(Output_H{2},Output1,FirstLine,Length_90);

[power_C1180_C,phase_C1180_C]=dataout(Output_C{13},Output1,FirstLine,Length_180);
[power_C1180_H,phase_C1180_H]=dataout(Output_H{13},Output1,FirstLine,Length_180);

[power_C23180_C,phase_C23180_C]=dataout(Output_C{14},Output1,FirstLine,Length_180);
[power_C23180_H,phase_C23180_H]=dataout(Output_H{14},Output1,FirstLine,Length_180);

% all free evolutions
Free12 = zeros(step_12,1); Free23_12 = zeros(step_23_12,1); Free23 = zeros(step_23,1);
% all pulses, 4 in total
P1C = power_C290_C; PH1C = grape_phase(phase_C290_C, 'X', 'Y'); P1H = power_C290_H; PH1H = grape_phase(phase_C290_H, 'X', 'Y');
P2C = power_C1180_C; PH2C = phase_C1180_C; P2H = power_C1180_H; PH2H = phase_C1180_H;
P3C = power_C23180_C; PH3C = phase_C23180_C; P3H = power_C23180_H; PH3H = phase_C23180_H;
P4C = power_C290_C; PH4C = grape_phase(phase_C290_C, 'X', '-Y'); P4H = power_C290_H; PH4H = grape_phase(phase_C290_H, 'X', '-Y');

power_encoding2_C = [P1C; Free12;P2C; Free23_12; P3C; Free23;P4C]*Calibration/Calibration_old;
phase_encoding2_C = [PH1C; Free12;PH2C; Free23_12; PH3C; Free23;PH4C];
power_encoding2_H = [P1H; Free12;P2H; Free23_12; P3H; Free23;P4H]*Calibration/Calibration_old;
phase_encoding2_H = [PH1H; Free12;PH2H; Free23_12; PH3H; Free23;PH4H];

total_time_encoding2 = length(power_encoding2_C)*dt

outputfile = 'twqubit_encoding2_C_nobuffer_fix';
shpfile = fopen(outputfile,'w');
    fprintf(shpfile,'##TITLE= %s\n',outputfile);
    fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
    fprintf(shpfile,'##DATA TYPE= Shape Data\n');
    fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
    fprintf(shpfile,'##OWNER= Dawei\n');
    fprintf(shpfile,'##DATE= %s\n',date);
    time = clock;
    fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
    fprintf(shpfile,'##MINX= %7.6e\n',min(power_encoding2_C));
    fprintf(shpfile,'##MAXX= %7.6e\n',max(power_encoding2_C));
    fprintf(shpfile,'##MINY= %7.6e\n',min(phase_encoding2_C));
    fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_encoding2_C));
    fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
    fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
    fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_MODE= 1\n');
    fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_encoding2);
    fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
    fprintf(shpfile,'##NPOINTS= %d\n',length(power_encoding2_C));
    fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');

for ii = 1:length(power_encoding2_C)
    fprintf(shpfile,'  %7.6e,  %7.6e\n',power_encoding2_C(ii),phase_encoding2_C(ii));
end

    fprintf(shpfile,'##END=\n');
    
outputfile = 'twqubit_encoding2_H_nobuffer_fix';
shpfile = fopen(outputfile,'w');
    fprintf(shpfile,'##TITLE= %s\n',outputfile);
    fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
    fprintf(shpfile,'##DATA TYPE= Shape Data\n');
    fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
    fprintf(shpfile,'##OWNER= Dawei\n');
    fprintf(shpfile,'##DATE= %s\n',date);
    time = clock;
    fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
    fprintf(shpfile,'##MINX= %7.6e\n',min(power_encoding2_H));
    fprintf(shpfile,'##MAXX= %7.6e\n',max(power_encoding2_H));
    fprintf(shpfile,'##MINY= %7.6e\n',min(phase_encoding2_H));
    fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_encoding2_H));
    fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
    fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
    fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_MODE= 1\n');
    fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_encoding2);
    fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
    fprintf(shpfile,'##NPOINTS= %d\n',length(power_encoding2_H));
    fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');

for ii = 1:length(power_encoding2_H)
    fprintf(shpfile,'  %7.6e,  %7.6e\n',power_encoding2_H(ii),phase_encoding2_H(ii));
end

    fprintf(shpfile,'##END=\n');

%% From Z1234567 to Z123456789101112
load Para.mat

 step_CH = 168;
 
 FirstLine = 19; % for C57180
 [power_C234790_C,phase_C234790_C]=dataout(Output_C{3},Output1,FirstLine,Length_90);
 [power_C234790_H,phase_C234790_H]=dataout(Output_H{3},Output1,FirstLine,Length_90);
 
 [power_C156180_C,phase_C156180_C]=dataout(Output_C{15},Output1,FirstLine,Length_180);
 [power_C156180_H,phase_C156180_H]=dataout(Output_H{15},Output1,FirstLine,Length_180);
 
 [power_PC_C,phase_PC_C]=dataout(Output_C{4},Output1,FirstLine,Length_90);
 [power_PC_H,phase_PC_H]=dataout(Output_H{4},Output1,FirstLine,Length_90);
 
 
 % all free evolutions
 FreeCH = zeros(step_CH,1); 
 % all pulses, 3 in total
 P1C = power_C234790_C; PH1C = grape_phase(phase_C234790_C, 'X', 'Y'); P1H = power_C234790_H; PH1H = grape_phase(phase_C234790_H, 'X', 'Y');
 P2C = power_C156180_C; PH2C = phase_C156180_C; P2H = power_C156180_H; PH2H = phase_C156180_H;
 P3C = power_PC_C; PH3C = phase_PC_C; P3H = power_PC_H; PH3H = phase_PC_H;
 
 power_encoding3_C = [P1C; FreeCH;P2C; FreeCH; P3C]*Calibration/Calibration_old;
 phase_encoding3_C = [PH1C; FreeCH;PH2C; FreeCH; PH3C];
 power_encoding3_H = [P1H; FreeCH;P2H; FreeCH; P3H]*Calibration/Calibration_old;
 phase_encoding3_H = [PH1H; FreeCH;PH2H; FreeCH; PH3H];
 
 total_time_encoding3 = length(power_encoding3_C)*dt
 
 outputfile = 'twqubit_encoding3_C_nobuffer_fix';
 shpfile = fopen(outputfile,'w');
     fprintf(shpfile,'##TITLE= %s\n',outputfile);
     fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
     fprintf(shpfile,'##DATA TYPE= Shape Data\n');
     fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
     fprintf(shpfile,'##OWNER= Dawei\n');
     fprintf(shpfile,'##DATE= %s\n',date);
     time = clock;
     fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
     fprintf(shpfile,'##MINX= %7.6e\n',min(power_encoding3_C));
     fprintf(shpfile,'##MAXX= %7.6e\n',max(power_encoding3_C));
     fprintf(shpfile,'##MINY= %7.6e\n',min(phase_encoding3_C));
     fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_encoding3_C));
     fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
     fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
     fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
     fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
     fprintf(shpfile,'##$SHAPE_MODE= 1\n');
     fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_encoding3);
     fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
     fprintf(shpfile,'##NPOINTS= %d\n',length(power_encoding3_C));
     fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');
 
 for ii = 1:length(power_encoding3_C)
     fprintf(shpfile,'  %7.6e,  %7.6e\n',power_encoding3_C(ii),phase_encoding3_C(ii));
 end
 
     fprintf(shpfile,'##END=\n');
     
 outputfile = 'twqubit_encoding3_H_nobuffer_fix';
 shpfile = fopen(outputfile,'w');
     fprintf(shpfile,'##TITLE= %s\n',outputfile);
     fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
     fprintf(shpfile,'##DATA TYPE= Shape Data\n');
     fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
     fprintf(shpfile,'##OWNER= Dawei\n');
     fprintf(shpfile,'##DATE= %s\n',date);
     time = clock;
     fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
     fprintf(shpfile,'##MINX= %7.6e\n',min(power_encoding3_H));
     fprintf(shpfile,'##MAXX= %7.6e\n',max(power_encoding3_H));
     fprintf(shpfile,'##MINY= %7.6e\n',min(phase_encoding3_H));
     fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_encoding3_H));
     fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
     fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
     fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
     fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
     fprintf(shpfile,'##$SHAPE_MODE= 1\n');
     fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_encoding3);
     fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
     fprintf(shpfile,'##NPOINTS= %d\n',length(power_encoding3_H));
     fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');
 
 for ii = 1:length(power_encoding3_H)
     fprintf(shpfile,'  %7.6e,  %7.6e\n',power_encoding3_H(ii),phase_encoding3_H(ii));
 end
 
     fprintf(shpfile,'##END=\n');

