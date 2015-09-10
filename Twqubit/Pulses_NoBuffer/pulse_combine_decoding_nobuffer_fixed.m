
% Combine many small shape files into one big shape file

clear;

addpath H:\Matlab\Twqubit\Pulses_NoBuffer\fixed_pulses

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

Calibration_C = 25000;
Calibration_H = 25000;

Fix_Number_C = [5,7,5,5,5,5,4,8,8,8,4,6,6,9,5,7,7,9];
Fix_Number_H = [5,6,7,7,9,7,8,7,9,4,8,4,4,5,9,5,4,4];

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

load Para.mat
%% From max coherence to PPS
%FirstLine = 19; % for C2347andH180
[power_C2347andH180_C,phase_C2347andH180_C]=dataout(Output_C{16},Output1,FirstLine,Length_180);
[power_C2347andH180_H,phase_C2347andH180_H]=dataout(Output_H{16},Output1,FirstLine,Length_180);

% FirstLine = 21; % for C134690andH90
[power_C134690andH90_C,phase_C134690andH90_C]=dataout(Output_C{5},Output1,FirstLine,Length_90);
[power_C134690andH90_H,phase_C134690andH90_H]=dataout(Output_H{5},Output1,FirstLine,Length_90);

% FirstLine = 21; % for C23456180
[power_C23456180_C,phase_C23456180_C]=dataout(Output_C{17},Output1,FirstLine,Length_180);
[power_C23456180_H,phase_C23456180_H]=dataout(Output_H{17},Output1,FirstLine,Length_180);

% FirstLine = 21; % for C1234690withPC
[power_C1234690withPC_C,phase_C1234690withPC_C]=dataout(Output_C{6},Output1,FirstLine,Length_90);
[power_C1234690withPC_H,phase_C1234690withPC_H]=dataout(Output_H{6},Output1,FirstLine,Length_90);

% FirstLine = 21; % for C27180
[power_C27180_C,phase_C27180_C]=dataout(Output_C{18},Output1,FirstLine,Length_180);
[power_C27180_H,phase_C27180_H]=dataout(Output_C{18},Output1,FirstLine,Length_180);

% FirstLine = 21; % for C2Y5X90
[power_C2Y5X90_C,phase_C2Y5X90_C]=dataout(Output_C{7},Output1,FirstLine,Length_90);
[power_C2Y5X90_H,phase_C2Y5X90_H]=dataout(Output_H{7},Output1,FirstLine,Length_90);

% FirstLine = 21; % for C57180
[power_C57180_C,phase_C57180_C]=dataout(Output_C{12},Output1,FirstLine,Length_180);
[power_C57180_H,phase_C57180_H]=dataout(Output_H{12},Output1,FirstLine,Length_180);

% FirstLine = 21; % for C590
[power_C590_C,phase_C590_C]=dataout(Output_C{8},Output1,FirstLine,Length_90);
[power_C590_H,phase_C590_H]=dataout(Output_H{8},Output1,FirstLine,Length_90);

[power_C1180_C,phase_C1180_C]=dataout(Output_C{13},Output1,FirstLine,Length_180);
[power_C1180_H,phase_C1180_H]=dataout(Output_H{13},Output1,FirstLine,Length_180);

step_CH = 168; %round(1/(4*148.5)/dt);

step_12 = 434; %round((1/(4*Para(1,2)))/dt);
step_23_12 = 330; %round((1/(4*Para(2,3))-1/(4*Para(1,2)))/dt);
step_23 = 764; %round((1/(4*Para(2,3)))/dt);

step_27 = 667; % round((1/(4*Para(2,7)))/dt);

step_57 = 1149; %round((1/(4*Para(5,7)))/dt);
% all free evolutions
FreeCH = zeros(step_CH,1); Free12 = zeros(step_12,1); Free23_12 = zeros(step_23_12,1); Free23 = zeros(step_23,1); Free27 = zeros(step_27,1); Free57 = zeros(step_57,1);
% all pulses, 7 in total
P1C = power_C2347andH180_C; PH1C = phase_C2347andH180_C; P1H = power_C2347andH180_H; PH1H = phase_C2347andH180_H;
P2C = power_C134690andH90_C; PH2C = phase_C134690andH90_C; P2H = power_C134690andH90_H; PH2H = phase_C134690andH90_H;
P3C = power_C1234690withPC_C; PH3C = phase_C1234690withPC_C; P3H = power_C1234690withPC_H; PH3H = phase_C1234690withPC_H;
P4C = power_C27180_C; PH4C = phase_C27180_C; P4H = power_C27180_H; PH4H = phase_C27180_H;
P5C = power_C2Y5X90_C; PH5C = phase_C2Y5X90_C; P5H = power_C2Y5X90_H; PH5H = phase_C2Y5X90_H;
P6C = power_C57180_C; PH6C = phase_C57180_C; P6H = power_C57180_H; PH6H = phase_C57180_H;
P7C = power_C590_C; PH7C = grape_phase(phase_C590_C, 'X', 'Y'); P7H = power_C590_H; PH7H = grape_phase(phase_C590_H, 'X', 'Y');

P9C = power_C1180_C; PH9C = phase_C1180_C; P9H = power_C1180_H; PH9H = phase_C1180_H;
P11C = power_C23456180_C; PH11C = phase_C23456180_C; P11H = power_C23456180_H; PH11H = phase_C23456180_H;


power_decoding_C = [FreeCH; P1C; FreeCH;P2C; ...
                                           Free12; P9C; Free23_12; P11C; Free23; P3C; ...
                                           Free27; P4C; Free27; P5C; ...
                                           Free57; P6C; Free57; P7C]*Calibration/Calibration_old;
phase_decoding_C = [FreeCH; PH1C; FreeCH;PH2C; ...
                                           Free12; PH9C; Free23_12; PH11C; Free23; PH3C; ...
                                           Free27; PH4C; Free27; PH5C; ...
                                           Free57; PH6C; Free57; PH7C];    
                                      
power_decoding_H = [FreeCH; P1H; FreeCH;P2H; ...
                                           Free12; P9H; Free23_12; P11H; Free23; P3H; ...
                                           Free27; P4H; Free27; P5H; ...
                                           Free57; P6H; Free57; P7H]*Calibration/Calibration_old;        
                                       
phase_decoding_H = [FreeCH; PH1H; FreeCH;PH2H; ...
                                           Free12; PH9H; Free23_12; PH11H; Free23; PH3H; ...
                                           Free27; PH4H; Free27; PH5H; ...
                                           Free57; PH6H; Free57; PH7H];                                        

total_time_decoding = length(power_decoding_C)*dt

outputfile = 'twqubit_decoding_C_nobuffer_fix';
shpfile = fopen(outputfile,'w');
    fprintf(shpfile,'##TITLE= %s\n',outputfile);
    fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
    fprintf(shpfile,'##DATA TYPE= Shape Data\n');
    fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
    fprintf(shpfile,'##OWNER= Dawei\n');
    fprintf(shpfile,'##DATE= %s\n',date);
    time = clock;
    fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
    fprintf(shpfile,'##MINX= %7.6e\n',min(power_decoding_C));
    fprintf(shpfile,'##MAXX= %7.6e\n',max(power_decoding_C));
    fprintf(shpfile,'##MINY= %7.6e\n',min(phase_decoding_C));
    fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_decoding_C));
    fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
    fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
    fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_MODE= 1\n');
    fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_decoding);
    fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
    fprintf(shpfile,'##NPOINTS= %d\n',length(power_decoding_C));
    fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');

for ii = 1:length(power_decoding_C)
    fprintf(shpfile,'  %7.6e,  %7.6e\n',power_decoding_C(ii),phase_decoding_C(ii));
end

    fprintf(shpfile,'##END=\n');
    
outputfile = 'twqubit_decoding_H_nobuffer_fix';
shpfile = fopen(outputfile,'w');
    fprintf(shpfile,'##TITLE= %s\n',outputfile);
    fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
    fprintf(shpfile,'##DATA TYPE= Shape Data\n');
    fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
    fprintf(shpfile,'##OWNER= Dawei\n');
    fprintf(shpfile,'##DATE= %s\n',date);
    time = clock;
    fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
    fprintf(shpfile,'##MINX= %7.6e\n',min(power_decoding_H));
    fprintf(shpfile,'##MAXX= %7.6e\n',max(power_decoding_H));
    fprintf(shpfile,'##MINY= %7.6e\n',min(phase_decoding_H));
    fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_decoding_H));
    fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
    fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
    fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
    fprintf(shpfile,'##$SHAPE_MODE= 1\n');
    fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_decoding);
    fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
    fprintf(shpfile,'##NPOINTS= %d\n',length(power_decoding_H));
    fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');

for ii = 1:length(power_decoding_H)
    fprintf(shpfile,'  %7.6e,  %7.6e\n',power_decoding_H(ii),phase_decoding_H(ii));
end

    fprintf(shpfile,'##END=\n');
    

