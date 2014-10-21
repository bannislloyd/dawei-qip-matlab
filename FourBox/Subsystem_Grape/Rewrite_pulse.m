clear;

%% Parameters for the GRAPE pulse
Name = 'U_ground';
Amplitude = 2500;
Time = 60000e-6;
Length = 6000;
dt = Time/Length;
FirstLine = 19; % the first line which contains the information of power and phase 

Output = 'test';

[power,phase]=dataout(Name,Output,FirstLine,Length);
power = power*25/60;

fid=fopen('U_ground_6000hz.txt','w');
fprintf(fid, '##TITLE= %s\n','Gaussian');
fprintf(fid, '##JCAPM-DX= 5.00 Bruker JCAMP library\n');
fprintf(fid, '##DATA TYPE= Shape Pulses \n');
fprintf(fid, '##ORIGIN= Colm Fixed Pulses \n');
fprintf(fid, '##OWNER= %s\n', 'Jun Li');
fprintf(fid, '##DATE= \n');
fprintf(fid, '##TIME= \n');
fprintf(fid, '##MINX= %7.6e\n',min(power));
fprintf(fid, '##MAXX= %7.6e\n',min(max(power),100));
fprintf(fid, '##MINY= %7.6e\n',min(phase));
fprintf(fid, '##MAXY= %7.6e\n',max(phase));
fprintf(fid, '##$SHAPE_EXMODE= None\n');
fprintf(fid, '##$SHAPE_TOTROT= %7.6e\n',90);
fprintf(fid, '##$SHAPE_BWFAC= %7.6e\n',1);
fprintf(fid, '##$SHAPE_INTEGFAC= %7.6e\n',1);
fprintf(fid, '##$SHAPE_MODE= 1\n');
fprintf(fid, '##PULSE_WIDTH= %d\n',Time);
fprintf(fid, '##NPOINTS= %d\n',length(power));
fprintf(fid, '##XYPOINTS= (XY..XY)\n');
for j=1:Length
    fprintf(fid,'%f', power(j));
    fprintf(fid,'%s','e+000, ');
    fprintf(fid,'%f', phase(j));
    fprintf(fid,'%s\n','e+000 ');
end
fprintf(fid, '##END=');
fclose(fid);