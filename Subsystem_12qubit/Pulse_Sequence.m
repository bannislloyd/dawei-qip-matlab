%%% Main Programe for Pulse Compiling;

% Author: Jun Li; Modified by Dawei Lu
% Date: 2013.06.21
% References: 
%   (1) C. A. Ryan, et al, Phys. Rev. A 78, 012328, (2008).
%   (2) Codes by Ryan at IQC NMR lab.

clear;

% parameter.mat contains all the infromation of Hamiltonian
load parameter.mat
global nqubits; nqubits=12;

% Write target U_ideal and uncompiled pulse pulse;

%% All four Unitaries used in PPS preparation
%  U_ideal{1}=R(gop(1,Y),90);
 U_ideal_A{1}=R(gopA(1,Y),90); U_ideal_B{1}=eye(2^6);

%% Initial Guess for each Unitary by Gaussian Shape
% uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle, pulse_variance], compile option};
% delete the second cell if no Gaussian shape is known; initial guess is 0
% suggested pulse_variance: Gaussian: (90 degree: 60; 180 degree: 120; 270 degree: 150;)
% compile option= 
%   I: eliminate nontrivial post_errors; 
%  II: eliminate nontrivial pre_errors and post_erros; 
% III: eliminate nontrivial pre_errors;

 uncompiled_pulse{1}={[1e-3, 1e-6], [1, 0.5e-3, 1e-3, 0, 90, 120]};

[U_sim, fidelity, rf_x, rf_y]=compiler(U_ideal_A, U_ideal_B, uncompiled_pulse);

%% generating shapefile 
% Bx=[]; By=[]; 
% for n=1:length(rf_x)
%     Bx=[Bx,rf_x{n}]; By=[By,rf_y{n}];
% end
%     
% total_time=length(Bx)*1e-5; % modify step size 
% ref_power=2500; % modify calibration power
% Amp=abs(Bx+i*By)*100/ref_power; Phase=angle(Bx+i*By)*180/pi;
% fid=fopen('12spin_7PPS_U_Decoding_80Iterations.txt','w'); % modify pulse name
% fprintf(fid, '##TITLE= %s\n','Gaussian');
% fprintf(fid, '##JCAPM-DX= 5.00 Bruker JCAMP library\n');
% fprintf(fid, '##DATA TYPE= Shape Pulses \n');
% fprintf(fid, '##ORIGIN= Colm Fixed Pulses \n');
% fprintf(fid, '##OWNER= %s\n', 'Jun Li');
% fprintf(fid, '##DATE= \n');
% fprintf(fid, '##TIME= \n');
% fprintf(fid, '##MINX= %7.6e\n',min(Amp));
% fprintf(fid, '##MAXX= %7.6e\n',min(max(Amp),100));
% fprintf(fid, '##MINY= %7.6e\n',min(Phase));
% fprintf(fid, '##MAXY= %7.6e\n',max(Phase));
% fprintf(fid, '##$SHAPE_EXMODE= None\n');
% fprintf(fid, '##$SHAPE_TOTROT= %7.6e\n',90);
% fprintf(fid, '##$SHAPE_BWFAC= %7.6e\n',1);
% fprintf(fid, '##$SHAPE_INTEGFAC= %7.6e\n',1);
% fprintf(fid, '##$SHAPE_MODE= 1\n');
% fprintf(fid, '##PULSE_WIDTH= %d\n',total_time);
% fprintf(fid, '##NPOINTS= %d\n',length(Amp));
% fprintf(fid, '##XYPOINTS= (XY..XY)\n');
% for j=1:length(Amp)
%     fprintf(fid,'%f', Amp(j));
%     fprintf(fid,'%s','e+000, ');
%     fprintf(fid,'%f', Phase(j));
%     fprintf(fid,'%s\n','e+000 ');
% end
% fprintf(fid, '##END=');
% fclose(fid);
