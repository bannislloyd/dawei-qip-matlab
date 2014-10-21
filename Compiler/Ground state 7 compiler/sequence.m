%%% Main Programe for Pulse Compiling;

% Author: Jun Li
% Date: 2013.06.21
% References: 
%   (1) C. A. Ryan, et al, Phys. Rev. A 78, 012328, (2008).
%   (2) Codes by Ryan at IQC NMR lab.

clear;

load parameter.mat

% Write target U_ideal and uncompiled pulse pulse;
% U_ideal{1}=R(gop(1,-Y),90);
% U_ideal{2}=expm(-i*H_int*1/4/abs(J(1,2)))*R(gop(1,X),180)*R(gop(2,X),180)*expm(-i*H_int*1/4/abs(J(1,2)));
% U_ideal{3}=R(gop(1,X),90);
% U_ideal{4}=R(gop(2,Y),270);
% U_ideal{5}=expm(-i*H_int*1/4/abs(J(2,3)))*R(gop(2,X),180)*R(gop(3,X),180)*expm(-i*H_int*1/4/abs(J(2,3)));
% U_ideal{6}=R(gop(2,-X),90);
% U_ideal{7}=R(gop(3,-Y),90);
% U_ideal{8}=expm(-i*H_int*1/4/abs(J(2,3)))*R(gop(2,X),180)*R(gop(3,X),180)*expm(-i*H_int*1/4/abs(J(2,3)));
% U_ideal{9}=R(gop(3,-X),90);
% U_ideal{10}=R(gop(2,Y),270);
% U_ideal{11}=expm(-i*H_int*1/4/abs(J(1,2)))*R(gop(1,X),180)*R(gop(2,X),180)*expm(-i*H_int*1/4/abs(J(1,2)));
% U_ideal{12}=R(gop(2,X),270);
% U_ideal{13}=R(gop(1,X),180);

U_ideal={R(gop(4,Y),270), expm(-i*H_int*1/4/abs(J(4,5)))*R(gop(4,X),180)*R(gop(5,X),180)*expm(-i*H_int*1/4/abs(J(4,5))), R(gop(4,X),180)*R(gop(5,X),180), R(gop(4,X),270),...
    R(gop(5,Y),90), expm(-i*H_int*1/4/abs(J(5,6)))*R(gop(5,X),180)*R(gop(6,X),180)*expm(-i*H_int*1/4/abs(J(5,6))), R(gop(5,X),180)*R(gop(6,X),180), R(gop(5,X),90),...
    R(gop(6,Y),90), expm(-i*H_int*1/4/abs(J(6,7)))*R(gop(6,X),180)*R(gop(7,X),180)*expm(-i*H_int*1/4/abs(J(6,7))), R(gop(6,X),180)*R(gop(7,X),180), R(gop(6,X),90),...
    R(gop(7,Y),270), expm(-i*H_int*1/4/abs(J(4,7)))*R(gop(4,X),180)*R(gop(7,X),180)*expm(-i*H_int*1/4/abs(J(4,7))), R(gop(4,X),180)*R(gop(7,X),180),R(gop(7,X),270)};




% uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle], compile option};
% compile option= 
%   I: eliminate nontrivial post_errors; 
%  II: eliminate nontrivial pre_errors and post_erros; 
% III: eliminate nontrivial pre_errors;

% optimized selective pulse: 90: [1e-3, 5e-6]; 180: 270:[]
% uncompiled_pulse{1}={[1e-3, 5e-6], [1, 0.5e-3, 1e-3, 0, 90], {'I'}}; 
% uncompiled_pulse{2}={[1/(2*abs(J(1,2))), 5e-6], [1, 1/(4*abs(J(1,2))), 2e-3, 0, 180; 2, 1/(4*abs(J(1,2))), 2e-3, 0, 180], {'II';'II'}};
% uncompiled_pulse{3}={[1e-3, 5e-6], [1, 0.5e-3, 1e-3, 0, 90],{'III'}};
% 
% uncompiled_pulse{4}={[3e-3, 5e-6], [2, 1.5e-3, 3e-3, 0, 270], {'I'}}; 
% uncompiled_pulse{5}={[1/(2*abs(J(2,3))), 5e-6], [2, 1/(4*abs(J(2,3))), 2e-3, 0, 180; 3, 1/(4*abs(J(2,3))), 2e-3, 0, 180], {'II';'II'}};
% uncompiled_pulse{6}={[3e-3, 5e-6], [2, 1.5e-3, 3e-3, 0, 270], {'III'}}; 
% 
% uncompiled_pulse{7}={[1e-3, 5e-6], [3, 0.5e-3, 1e-3, 0, 90], {'I'}}; 
% uncompiled_pulse{8}={[1/(2*abs(J(2,3))), 5e-6], [2, 1/(4*abs(J(2,3))), 2e-3, 0, 180; 3, 1/(4*abs(J(2,3))), 2e-3, 0, 180], {'II';'II'}};
% uncompiled_pulse{9}={[1e-3, 5e-6], [3, 0.5e-3, 1e-3, 0, 90], {'III'}};
% 
% uncompiled_pulse{10}={[3e-3, 5e-6], [2, 1.5e-3, 3e-3, 0, 270], {'I'}};
% uncompiled_pulse{11}={[1/(2*abs(J(1,2))), 5e-6], [1, 1/(4*abs(J(1,2))), 2e-3, 0, 180; 2, 1/(4*abs(J(1,2))), 2e-3, 0, 180], {'II';'II'}};
% uncompiled_pulse{12}={[3e-3, 5e-6], [2, 1.5e-3, 3e-3, 0, 270],{'III'}};
% uncompiled_pulse{13}={[2e-3, 5e-6], [1, 1e-3, 2e-3, 0, 180],{'II'}};

uncompiled_pulse{1}={[3e-3, 5e-6], [4, 1.5e-3, 3e-3, 0, 270], {'I'}}; 
uncompiled_pulse{2}={[1/(2*abs(J(4,5))), 5e-6], [4, 1/(4*abs(J(4,5))), 2e-3, 0, 180; 5, 1/(4*abs(J(4,5))), 2e-3, 0, 180], {'II';'II'}};
uncompiled_pulse{3}={[2e-3, 5e-6], [4, 1e-3, 2e-3, 0, 180; 5, 1e-3, 2e-3, 0, 180], {'II';'II'}};
uncompiled_pulse{4}={[3e-3, 5e-6], [4, 1.5e-3, 3e-3, 0, 270], {'III'}}; 

uncompiled_pulse{5}={[1e-3, 5e-6], [5, 0.5e-3, 1e-3, 0, 90], {'I'}}; 
uncompiled_pulse{6}={[1/(2*abs(J(5,6))), 5e-6], [5, 1/(4*abs(J(5,6))), 2e-3, 0, 180; 6, 1/(4*abs(J(5,6))), 2e-3, 0, 180], {'II';'II'}};
uncompiled_pulse{7}={[2e-3, 5e-6], [5, 1e-3, 2e-3, 0, 180; 6, 1e-3, 2e-3, 0, 180], {'II';'II'}};
uncompiled_pulse{8}={[1e-3, 5e-6], [5, 0.5e-3, 1e-3, 0, 90], {'III'}};

uncompiled_pulse{9}={[1e-3, 5e-6], [6, 0.5e-3, 1e-3, 0, 90], {'I'}}; 
uncompiled_pulse{10}={[1/(2*abs(J(6,7))), 5e-6], [6, 1/(4*abs(J(6,7))), 2e-3, 0, 180; 7, 1/(4*abs(J(6,7))), 2e-3, 0, 180], {'II';'II'}};
uncompiled_pulse{11}={[2e-3, 5e-6], [6, 1e-3, 2e-3, 0, 180; 7, 1e-3, 2e-3, 0, 180], {'II';'II'}};
uncompiled_pulse{12}={[1e-3, 5e-6], [6, 0.5e-3, 1e-3, 0, 90], {'III'}};

uncompiled_pulse{13}={[3e-3, 5e-6], [7, 1.5e-3, 3e-3, 0, 270], {'I'}}; 
uncompiled_pulse{14}={[1/(2*abs(J(4,7))), 5e-6], [4, 1/(4*abs(J(4,7))), 2e-3, 0, 180; 7, 1/(4*abs(J(4,7))), 2e-3, 0, 180], {'II';'II'}};
uncompiled_pulse{15}={[2e-3, 5e-6], [4, 1e-3, 2e-3, 0, 180; 7, 1e-3, 2e-3, 0, 180], {'II';'II'}};
uncompiled_pulse{16}={[3e-3, 5e-6], [7, 1.5e-3, 3e-3, 0, 270], {'III'}}; 
 


[compiled_pulse, U_sim, pre_error, post_error, phase_correction, fidelity]=compile(U_ideal, uncompiled_pulse);


% rho_eq=(gop(1,Z)+gop(2,Z)+gop(3,Z)+gop(4,Z)+gop(5,Z)+gop(6,Z)+gop(7,Z))/sqrt(7);
% rho1=gop(1,Z);
% rho2=gop(1,Z)*gop(3,Z);
% rho1=gop(2,Z);
% rho2=gop(3,Z);
% rho1=gop(3,Z);
% rho2=gop(1,Z)*gop(2,Z)*gop(3,Z);
% ideal=eye(2^nqubits); sim=ideal;
% for k=1:length(U_ideal)
%     ideal=U_ideal{k}*ideal;
%     sim=U_sim{k}*sim;
% end
% trace(ideal*rho1*ideal'*rho2)/128;
% trace(sim*rho1*sim'*rho2)/128;


rho_eq=(gop(1,Z)+gop(2,Z)+gop(3,Z)+gop(4,Z)+gop(5,Z)+gop(6,Z)+gop(7,Z))/sqrt(7);
rho1=gop(4,Z);
rho2=gop(5,Z)*gop(6,Z)*gop(7,Z);
rho1=gop(5,Z);
rho2=gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z);
rho1=gop(4,Z)*gop(6,Z);
rho2=gop(4,Z)*gop(5,Z);
ideal=eye(2^nqubits); sim=ideal;
for k=1:length(U_ideal)
    ideal=U_ideal{k}*ideal;
    sim=U_sim{k}*sim;
end
trace(ideal*rho1*ideal'*rho2)/128
trace(sim*rho1*sim'*rho2)/128



%%% shapefile
Bx=[]; By=[]; 
for n=1:length(compiled_pulse)
    [x,y]=selpulse(compiled_pulse{n});
    Bx=[Bx,x]; By=[By,y];
end
    
total_time=length(Bx)*5e-6; ref_power=1000; 
Amp=abs(Bx+i*By)*100/ref_power; Phase=angle(Bx+i*By)*180/pi;
fid=fopen('12spin_7PPS_C45.txt','w');
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


