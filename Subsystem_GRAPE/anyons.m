%%% Main Programe for Pulse Compiling;

% Author: Jun Li
% Date: 2013.06.21
% References: 
%   (1) C. A. Ryan, et al, Phys. Rev. A 78, 012328, (2008).
%   (2) Codes by Ryan at IQC NMR lab.

clear;

load parameter.mat
global nqubits; nqubits=7;

% Write target U_ideal and uncompiled pulse pulse;

% U_181_123456
% U_ideal{1}=R(gop(1,X),180)*R(gop(2,X),180)*R(gop(3,X),180)*R(gop(4,Y),180)*R(gop(5,X),180)*R(gop(6,X),180);
% U_ideal{1}=R(gop(1,X),180)*R(gop(2,X),180)*R(gop(3,X),180)*R(gop(7,X),180);
U_ideal{1}=R(gop(4,Y),180)*R(gop(5,X),180)*R(gop(6,X),180)*R(gop(7,X),180);

% U_ideal_A{1}=R(gopA(1,X),180)*R(gopA(2,X),180)*R(gopA(3,X),180); 
% U_ideal_B{1}=R(gopB(1,Y),180)*R(gopB(2,X),180)*R(gopB(3,X),180);

% U_ideal_A{1}=R(gopA(1,X),180)*R(gopA(2,X),180)*R(gopA(3,X),180); 
% U_ideal_B{1}=R(gopB(4,X),180);

U_ideal_A{1}=eye(8); 
U_ideal_B{1}=R(gopB(1,Y),180)*R(gopB(2,X),180)*R(gopB(3,X),180)*R(gopB(4,X),180);

% uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle, pulse_variance], compile option};
% suggested pulse_variance: Gaussian: (90 degree: 60; 180 degree: 120; 270 degree: 150;)
% compile option= 
%   I: eliminate nontrivial post_errors; 
%  II: eliminate nontrivial pre_errors and post_erros; 
% III: eliminate nontrivial pre_errors;

% U_90_123456
% uncompiled_pulse{1}={[1e-3, 5e-6], [1, 0.5e-3, 1e-3, 0, 180, 80; 2, 0.5e-3, 1e-3, 0, 180, 70; 3, 0.5e-3, 1e-3, 0, 180, 80; 4, 0.5e-3, 1e-3, 0, 180, 70; 5, 0.5e-3, 1e-3, 0, 180, 80; 6, 0.5e-3, 1e-3, 0, 180, 90]}; 
uncompiled_pulse{1}={[1e-3, 5e-6], [4, 0.5e-3, 1e-3, 0, 180, 70; 5, 0.5e-3, 1e-3, 0, 180, 80; 6, 0.5e-3, 1e-3, 0, 180, 90; 7, 0.5e-3, 1e-3, 0, 180, 80]}; 


[U_sim, fidelity, rf_x, rf_y]=compiler(U_ideal, U_ideal_A, U_ideal_B, uncompiled_pulse);

%%% shapefile
Bx=[]; By=[]; 
for n=1:length(rf_x)
    Bx=[Bx,rf_x{n}]; By=[By,rf_y{n}];
end
    
total_time=length(Bx)*5e-6; ref_power=6000; 
Amp=abs(Bx+i*By)*100/ref_power; Phase=angle(Bx+i*By)*180/pi;
fid=fopen('braiding2_option2','w');
fprintf(fid, '##TITLE= %s\n','Gaussian');
fprintf(fid, '##JCAPM-DX= 5.00 Bruker JCAMP library\n');
fprintf(fid, '##DATA TYPE= Shape Pulses \n');
fprintf(fid, '##ORIGIN= Colm Fixed Pulses \n');
fprintf(fid, '##OWNER= %s\n', 'Jun Li');
fprintf(fid, '##DATE= \n');
fprintf(fid, '##TIME= \n');
fprintf(fid, '##MINX= %7.6e\n',min(Amp));
fprintf(fid, '##MAXX= %7.6e\n',min(max(Amp),100));
fprintf(fid, '##MINY= %7.6e\n',min(Phase));
fprintf(fid, '##MAXY= %7.6e\n',max(Phase));
fprintf(fid, '##$SHAPE_EXMODE= None\n');
fprintf(fid, '##$SHAPE_TOTROT= %7.6e\n',90);
fprintf(fid, '##$SHAPE_BWFAC= %7.6e\n',1);
fprintf(fid, '##$SHAPE_INTEGFAC= %7.6e\n',1);
fprintf(fid, '##$SHAPE_MODE= 1\n');
fprintf(fid, '##PULSE_WIDTH= %d\n',total_time);
fprintf(fid, '##NPOINTS= %d\n',length(Amp));
fprintf(fid, '##XYPOINTS= (XY..XY)\n');
for j=1:length(Amp)
    fprintf(fid,'%f', Amp(j));
    fprintf(fid,'%s','e+000, ');
    fprintf(fid,'%f', Phase(j));
    fprintf(fid,'%s\n','e+000 ');
end
fprintf(fid, '##END=');
fclose(fid);


% Notes:
%   1. For a new experiment, values of the following parameters may be modified to improve performance:  
%      (1) selective pulse shape;