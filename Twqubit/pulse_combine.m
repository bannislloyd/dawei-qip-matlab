
% Combine many small shape files into one big shape file

clear;
addpath .\C_rotations;

Length_90 = 100;
Length_180 = 200;
FirstLine = 19; % the first line which contains the information of power and phase 
Output1 = 'test';
Output2 = 'test';
dt = 1e-5; % time step for the new big shapefile
Calibration = 25000; % the calibration power used for the big shapefile
Calibration_old = 25000; % the calibration power for the single rotations
Amplitude = Calibration;

for spin_number = 1:7
       Name1 = ['twqubit_C', num2str(spin_number), '90_C_25000.txt'];
       Name2 = ['twqubit_C', num2str(spin_number), '90_H_25000.txt'];
       [power1,phase1]=dataout(Name1,Output1,FirstLine,Length_90);
       [power2,phase2]=dataout(Name2,Output2,FirstLine,Length_90);
       eval(['power_C', num2str(spin_number), '90_C = power1;']); eval(['phase_C', num2str(spin_number), '90_C = phase1;']);
       eval(['power_C', num2str(spin_number), '90_H = power2;']); eval(['phase_C', num2str(spin_number), '90_H = phase2;']);
end

for spin_number = 1:7
       Name1 = ['twqubit_C', num2str(spin_number), '180_C_25000.txt'];
       Name2 = ['twqubit_C', num2str(spin_number), '180_H_25000.txt'];
       [power1,phase1]=dataout(Name1,Output1,FirstLine,Length_180);
       [power2,phase2]=dataout(Name2,Output2,FirstLine,Length_180);
       eval(['power_C', num2str(spin_number), '180_C = power1;']); eval(['phase_C', num2str(spin_number), '180_C = phase1;']);
       eval(['power_C', num2str(spin_number), '180_H = power2;']); eval(['phase_C', num2str(spin_number), '180_H = phase2;']);
%C_ratio(spin_number) = max(power1)
%C_hertz(spin_number) = Amplitude * C_ratio(spin_number)/100
%H_ratio(spin_number) = max(power2)
%H_hertz(spin_number) = Amplitude * H_ratio(spin_number)/100
end

FirstLine = 21; % for C57180
[power_C57180_C,phase_C57180_C]=dataout('twqubit_C57180_C_25000.txt',Output1,FirstLine,Length_180);
[power_C57180_H,phase_C57180_H]=dataout('twqubit_C57180_H_25000.txt',Output1,FirstLine,Length_180);

load Para.mat
%% From Z7 to Z24567
step_27 = round(1/(4*Para(2,7))/dt);
step_67_27 = round((1/(4*Para(6,7))-1/(4*Para(2,7)))/dt);
step_47_67 = round((1/(4*Para(4,7))-1/(4*Para(6,7)))/dt);
step_57_47 = round((1/(4*Para(5,7))-1/(4*Para(4,7)))/dt);
step_57 = round((1/(4*Para(5,7)))/dt);

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

total_time_encoding1 = length(power_encoding1_C)*dt;

outputfile = 'twqubit_encoding1_C';
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
    
outputfile = 'twqubit_encoding1_H';
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
    
% %% From Z24567 to Z1234567
% step_12 = round(1/(4*Para(1,2))/dt);
% step_23_12 = round((1/(4*Para(2,3))-1/(4*Para(1,2)))/dt);
% step_23 = round((1/(4*Para(2,3)))/dt);
% 
% power_encoding2_C = [power_C290_C; zeros(step_12,1);power_C1180_C; zeros(step_23_12,1);...
%                                   power_C2180_C; power_C3180_C; zeros(step_23,1);power_C290_C]*Calibration/Calibration_old;
% phase_encoding2_C = [phase_C290_C; zeros(step_12,1);phase_C1180_C; zeros(step_23_12,1);...
%                                   phase_C2180_C; phase_C3180_C; zeros(step_23,1);mod((phase_C290_C-90),360)]
% power_encoding2_H = [power_H290_H; zeros(step_12,1);power_H1180_H; zeros(step_23_12,1);...
%                                   power_H2180_H; power_H3180_H; zeros(step_23,1);power_H290_H]*Calibration/Calibration_old;
% phase_encoding2_H = [phase_H290_H; zeros(step_12,1);phase_H1180_H; zeros(step_23_12,1);...
%                                   phase_H2180_H; phase_H3180_H; zeros(step_23,1);mod((phase_H290_H-90),360)]
% 
% total_time_encoding2 = length(power_encoding2_C)*dt;
% 
% outputfile = 'twqubit_encoding2_C';
% shpfile = fopen(outputfile,'w');
%     fprintf(shpfile,'##TITLE= %s\n',outputfile);
%     fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
%     fprintf(shpfile,'##DATA TYPE= Shape Data\n');
%     fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
%     fprintf(shpfile,'##OWNER= Dawei\n');
%     fprintf(shpfile,'##DATE= %s\n',date);
%     time = clock;
%     fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
%     fprintf(shpfile,'##MINX= %7.6e\n',min(power_encoding2_C));
%     fprintf(shpfile,'##MAXX= %7.6e\n',max(power_encoding2_C));
%     fprintf(shpfile,'##MINY= %7.6e\n',min(phase_encoding2_C));
%     fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_encoding2_C));
%     fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
%     fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
%     fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
%     fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
%     fprintf(shpfile,'##$SHAPE_MODE= 1\n');
%     fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_encoding2);
%     fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
%     fprintf(shpfile,'##NPOINTS= %d\n',length(power_encoding2_C));
%     fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');
% 
% for ii = 1:length(power_encoding2_C)
%     fprintf(shpfile,'  %7.6e,  %7.6e\n',power_encoding2_C(ii),phase_encoding2_C(ii));
% end
% 
%     fprintf(shpfile,'##END=\n');
%     
% outputfile = 'twqubit_encoding2_H';
% shpfile = fopen(outputfile,'w');
%     fprintf(shpfile,'##TITLE= %s\n',outputfile);
%     fprintf(shpfile,'##JCAMP-DX= 5.00 Bruker JCAMP library\n');
%     fprintf(shpfile,'##DATA TYPE= Shape Data\n');
%     fprintf(shpfile,'##ORIGIN= Dawei''s GRAPE Pulses \n');
%     fprintf(shpfile,'##OWNER= Dawei\n');
%     fprintf(shpfile,'##DATE= %s\n',date);
%     time = clock;
%     fprintf(shpfile,'##TIME= %d:%d\n',fix(time(4)),fix(time(5)));
%     fprintf(shpfile,'##MINX= %7.6e\n',min(power_encoding2_H));
%     fprintf(shpfile,'##MAXX= %7.6e\n',max(power_encoding2_H));
%     fprintf(shpfile,'##MINY= %7.6e\n',min(phase_encoding2_H));
%     fprintf(shpfile,'##MAXY= %7.6e\n',max(phase_encoding2_H));
%     fprintf(shpfile,'##$SHAPE_EXMODE= None\n');
%     fprintf(shpfile,'##$SHAPE_TOTROT= %7.6e\n',90);
%     fprintf(shpfile,'##$SHAPE_BWFAC= %7.6e\n',1);
%     fprintf(shpfile,'##$SHAPE_INTEGFAC= %7.6e\n',1);
%     fprintf(shpfile,'##$SHAPE_MODE= 1\n');
%     fprintf(shpfile, '##PULSE_WIDTH= %d\n',total_time_encoding2);
%     fprintf(shpfile, '##Calibration_Power= %d\n',Calibration);
%     fprintf(shpfile,'##NPOINTS= %d\n',length(power_encoding2_H));
%     fprintf(shpfile,'##XYPOINTS= (XY..XY)\n');
% 
% for ii = 1:length(power_encoding2_H)
%     fprintf(shpfile,'  %7.6e,  %7.6e\n',power_encoding2_H(ii),phase_encoding2_H(ii));
% end
% 
%     fprintf(shpfile,'##END=\n');



