%%% Main Programe for Pulse Compiling;

% Author: Jun Li; Modified by Dawei Lu
% Date: 2013.06.21
% References: 
%   (1) C. A. Ryan, et al, Phys. Rev. A 78, 012328, (2008).
%   (2) Codes by Ryan at IQC NMR lab.

clear;

% parameter.mat contains all the infromation of Hamiltonian
load parameter.mat
global nqubits; nqubits=7;

% Write target U_ideal and uncompiled pulse pulse;

%% All four Unitaries used in PPS preparation

% First: U_90_123456
% U_ideal{1}=R(gop(1,Y),90)*R(gop(2,Y),90)*R(gop(3,Y),90)*R(gop(4,Y),90)*R(gop(5,Y),90)*R(gop(6,Y),90);

% Second: U_Encoding

 U_ideal{1}=R(gop(7,Y),90);
% U_ideal{2}=F(H_int,1/4/abs(J(5,7)))*...
%     R(gop(7,X),180)*R(gop(5,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(4,7))))*...
%     R(gop(4,X),180)*F(H_int,(1/4/abs(J(4,7))-1/4/abs(J(6,7))))*...
%     R(gop(6,X),180)*F(H_int,(1/4/abs(J(6,7))-1/4/abs(J(2,7))))*...
%     R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)));
% U_ideal{3}=R(gop(7,-Y),90);
% U_ideal{4}=R(gop(2,Y),90);
% U_ideal{5}=F(H_int,1/4/abs(J(2,3)))*...
%     R(gop(3,X),180)*R(gop(2,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
%     R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)));
% U_ideal{6}=R(gop(2,-Y),90);
% 
 U_ideal_A{1}=eye(2^3); U_ideal_B{1}=R(gopB(4,Y),90);
% U_ideal_A{2}=F(H_int_A,1/2/abs(J(5,7))-1/4/abs(J(2,7)))*R(gopA(2,X),180)*F(H_int_A,1/4/abs(J(2,7)));
% U_ideal_B{2}=F(H_int_B,1/4/abs(J(5,7)))*R(gopB(2,X),180)*R(gopB(4,X),180)*...
%     F(H_int_B,1/4/abs(J(5,7))-1/4/abs(J(4,7)))*R(gopB(1,X),180)*...
%     F(H_int_B,1/4/abs(J(4,7))-1/4/abs(J(6,7)))*R(gopB(3,X),180)*...
%     F(H_int_B,1/4/abs(J(6,7)));
% U_ideal_A{3}=eye(2^3); U_ideal_B{3}=R(gopB(4,-Y),90);
% U_ideal_A{4}=R(gopA(2,Y),90); U_ideal_B{4}=eye(2^4);
% U_ideal_A{5}=F(H_int_A,1/4/abs(J(2,3)))*...
%     R(gopA(3,X),180)*R(gopA(2,X),180)*F(H_int_A,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
%     R(gopA(1,X),180)*F(H_int_A,1/4/abs(J(1,2))); 
% U_ideal_B{5}=F(H_int_B,1/2/abs(J(2,3)));
% U_ideal_A{6}=R(gopA(2,-Y),90); U_ideal_B{6}=eye(2^4);

% Third: U_90_1234567
% U_ideal{1}=R(gop(1,Y),90)*R(gop(2,Y),90)*R(gop(3,Y),90)*R(gop(4,Y),90)*R(gop(5,Y),90)*R(gop(6,Y),90)*R(gop(7,Y),90);
% 
% Fourth: U_Decoding
% U_ideal{1}=R(gop(1,X),90)*R(gop(3,X),90)*R(gop(4,X),90)*R(gop(6,X),90);
% U_ideal{2}=F(H_int,1/4/abs(J(2,3)))*...
%     R(gop(2,X),180)*R(gop(3,X),180)*R(gop(4,X),180)*R(gop(5,X),180)*R(gop(6,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
%     R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)));
% U_ideal{3}=R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))'*R(gop(1,Y),90)*R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))*...
%     R(gop(3,Y),90)*...
%     R(gop(4,-Y),90)*...
%     R(gop(6,-Y),90);
%  U_ideal{4}=R(gop(2,X),90)*R(gop(5,X),90);
%  U_ideal{5}=F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
%      R(gop(1,X),180)*R(gop(3,X),180)*F(H_int,1/4/abs(J(2,7)))*...
%      R(gop(5,X),180)*R(gop(7,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
%      R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)));
% U_ideal{6}=R(gop(7,Y),90)*R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))'*R(gop(2,Y),90)*R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))*...
%     R(gop(5,Y),90);
% 
% U_ideal_A{1}=R(gopA(1,X),90)*R(gopA(3,X),90); 
% U_ideal_B{1}=R(gopB(1,X),90)*R(gopB(3,X),90);
% 
% U_ideal_A{2}=F(H_int_A,1/4/abs(J(2,3)))*...
%     R(gopA(2,X),180)*R(gopA(3,X),180)*F(H_int_A,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
%     R(gopA(1,X),180)*F(H_int_A,1/4/abs(J(1,2)));
% U_ideal_B{2}=F(H_int_B,1/4/abs(J(2,3)))*...
%     R(gopB(1,X),180)*R(gopB(2,X),180)*R(gopB(3,X),180)*F(H_int_B,1/4/abs(J(2,3)));
% 
% U_ideal_A{3}=R(gopA(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))'*R(gopA(1,Y),90)*R(gopA(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))*...
%     R(gopA(3,Y),90); 
% U_ideal_B{3}=R(gopB(1,-Y),90)*R(gopB(3,-Y),90);
% 
%  U_ideal_A{4}=R(gopA(2,X),90); 
%  U_ideal_B{4}=R(gopB(2,X),90);
% 
%  U_ideal_A{5}=F(H_int_A,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
%      R(gopA(1,X),180)*R(gopA(3,X),180)*F(H_int_A,1/4/abs(J(5,7)))*...
%      R(gopA(2,X),180)*F(H_int_A,1/4/abs(J(2,7))); 
%  U_ideal_B{5}=F(H_int_B,1/4/abs(J(5,7)))*...
%      R(gopB(2,X),180)*R(gopB(4,X),180)*F(H_int_B,1/4/abs(J(5,7)));
% 
% U_ideal_A{6}=R(gopA(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))'*R(gopA(2,Y),90)*R(gopA(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7)))); 
% U_ideal_B{6}=R(gopB(4,Y),90)*R(gopB(2,Y),90);


%% Initial Guess for each Unitary by Gaussian Shape
% uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle, pulse_variance], compile option};
% delete the second cell if no Gaussian shape is known; initial guess is 0
% suggested pulse_variance: Gaussian: (90 degree: 60; 180 degree: 120; 270 degree: 150;)
% compile option= 
%   I: eliminate nontrivial post_errors; 
%  II: eliminate nontrivial pre_errors and post_erros; 
% III: eliminate nontrivial pre_errors;

% U_90_123456
% uncompiled_pulse{1}={[1e-3, 5e-6], [1, 0.5e-3, 1e-3, 0, 90, 80; 2, 0.5e-3, 1e-3, 0, 90, 70; 3, 0.5e-3, 1e-3, 0, 90, 80; 4, 0.5e-3, 1e-3, 0, 90, 70; 5, 0.5e-3, 1e-3, 0, 90, 80; 6, 0.5e-3, 1e-3, 0, 90, 90], {'I','I','I','I','I','I'}}; 

% U_Encoding
 uncompiled_pulse{1}={[1e-3, 1e-5], [7, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{2}={[1/(2*abs(J(5,7))), 1e-5], [2, 1/4/abs(J(2,7)), 2e-3, 0, 180, 100; 4, 1/4/abs(J(4,7)), 2e-3, 0, 180, 100; 5, 1/4/abs(J(5,7)), 2e-3, 0, 180, 100; 6, 1/4/abs(J(6,7)), 2e-3, 0, 180, 100; 7, 1/4/abs(J(5,7)), 2e-3, 0, 180, 100]};
% uncompiled_pulse{3}={[1e-3, 1e-5], [7, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{4}={[1e-3, 1e-5], [2, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{5}={[1/(2*abs(J(2,3))), 1e-5], [1, 1/4/abs(J(1,2)), 2e-3, 0, 180, 100; 2, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 3, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100]};
% uncompiled_pulse{6}={[1e-3, 1e-5], [2, 0.5e-3, 1e-3, 0, 90, 60]};


% U_90_1234567
% uncompiled_pulse{1}={[1e-3, 5e-6], [1, 0.5e-3, 1e-3, 0, 90, 80; 2, 0.5e-3, 1e-3, 0, 90, 80; 3, 0.5e-3, 1e-3, 0, 90, 80; 4, 0.5e-3, 1e-3, 0, 90, 80; 5, 0.5e-3, 1e-3, 0, 90, 80; 6, 0.5e-3, 1e-3, 0, 90, 80; 7, 0.5e-3, 1e-3, 0, 90, 80], {'I','I','I','I','I','I','I'}}; 

% U_Decoding
% uncompiled_pulse{1}={[1e-3, 1e-5], [1, 0.5e-3, 1e-3, 0, 90, 60; 3, 0.5e-3, 1e-3, 0, 90, 60; 4, 0.5e-3, 1e-3, 0, 90, 60; 6, 0.5e-3, 1e-3, 0, 90, 60]}; 
% uncompiled_pulse{2}={[1/(2*abs(J(2,3))), 1e-5], [1, 1/4/abs(J(1,2)), 2e-3, 0, 180, 100; 2, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 3, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 4, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 5, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 6, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100]};
% uncompiled_pulse{3}={[1e-3, 1e-5], [1, 0.5e-3, 1e-3, 0, 90, 60; 3, 0.5e-3, 1e-3, 0, 90, 60; 4, 0.5e-3, 1e-3, 0, 90, 60; 6, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{4}={[1e-3, 1e-5], [2, 0.5e-3, 1e-3, 0, 90, 60; 5, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{5}={[1/(2*abs(J(5,7))), 1e-5], [1, 1/4/abs(J(2,7))+1/4/abs(J(5,7)), 2e-3, 0, 180, 100; 2, 1/4/abs(J(2,7)), 2e-3, 0, 180, 100; 3, 1/4/abs(J(2,7))+1/4/abs(J(5,7)), 2e-3, 0, 180, 100; 5, 1/4/abs(J(5,7)), 2e-3, 0, 180, 100; 7, 1/4/abs(J(5,7)), 2e-3, 0, 180, 100]};
% uncompiled_pulse{6}={[1e-3, 1e-5], [2, 0.5e-3, 1e-3, 0, 90, 60; 5, 0.5e-3, 1e-3, 0, 90, 60; 7, 0.5e-3, 1e-3, 0, 90, 60]};

[U_sim, fidelity, rf_x, rf_y]=compiler(U_ideal, U_ideal_A, U_ideal_B, uncompiled_pulse);

%% generating shapefile 
Bx=[]; By=[]; 
for n=1:length(rf_x)
    Bx=[Bx,rf_x{n}]; By=[By,rf_y{n}];
end
    
total_time=length(Bx)*1e-5; % modify step size 
ref_power=2500; % modify calibration power
Amp=abs(Bx+i*By)*100/ref_power; Phase=angle(Bx+i*By)*180/pi;
fid=fopen('12spin_7PPS_U_Decoding_80Iterations.txt','w'); % modify pulse name
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
