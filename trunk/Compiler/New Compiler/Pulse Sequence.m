%%% Main Programe for Pulse Compiling;

% Author: Jun Li
% Date: 2013.06.21
% References: 
%   (1) C. A. Ryan, et al, Phys. Rev. A 78, 012328, (2008).
%   (2) Codes by Ryan at IQC NMR lab.

% clear;
% 
% load parameter.mat
% global nqubits; nqubits=7;
% 
% % Write target U_ideal and uncompiled pulse pulse;
% 
% % U_90_123456
% % U_ideal{1}=R(gop(1,Y),90)*R(gop(2,Y),90)*R(gop(3,Y),90)*R(gop(4,Y),90)*R(gop(5,Y),90)*R(gop(6,Y),90);
% 
% % U_Encoding
% 
% U_ideal{1}=R(gop(7,Y),90)*F(H_int,1e-3);
% U_ideal{2}=F(H_int,1/4/abs(J(5,7)))*...
%     R(gop(7,X),180)*R(gop(5,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(4,7))))*...
%     R(gop(4,X),180)*F(H_int,(1/4/abs(J(4,7))-1/4/abs(J(6,7))))*...
%     R(gop(6,X),180)*F(H_int,(1/4/abs(J(6,7))-1/4/abs(J(2,7))))*...
%     R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)));
% U_ideal{3}=F(H_int,1e-3)*R(gop(7,-Y),90);
% U_ideal{4}=R(gop(2,Y),90)*F(H_int,1e-3);
% U_ideal{5}=F(H_int,1/4/abs(J(2,3)))*...
%     R(gop(3,X),180)*R(gop(2,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
%     R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)));
% U_ideal{6}=F(H_int,1e-3)*R(gop(2,-Y),90);
% 
% U_ideal_A{1}=F(H_int_A,1e-3); U_ideal_B{1}=R(gopB(4,Y),90)*F(H_int_B,1e-3);
% U_ideal_A{2}=F(H_int_A,1/2/abs(J(5,7))-1/4/abs(J(2,7)))*R(gopA(2,X),180)*F(H_int_A,1/4/abs(J(2,7)));
% U_ideal_B{2}=F(H_int_B,1/4/abs(J(5,7)))*R(gopB(2,X),180)*R(gopB(4,X),180)*...
%     F(H_int_B,1/4/abs(J(5,7))-1/4/abs(J(4,7)))*R(gopB(1,X),180)*...
%     F(H_int_B,1/4/abs(J(4,7))-1/4/abs(J(6,7)))*R(gopB(3,X),180)*...
%     F(H_int_B,1/4/abs(J(6,7)));
% U_ideal_A{3}=F(H_int_A,1e-3); U_ideal_B{3}=F(H_int_B,1e-3)*R(gopB(4,-Y),90);
% U_ideal_A{4}=R(gopA(2,Y),90)*F(H_int_A,1e-3); U_ideal_B{4}=F(H_int_B,1e-3);
% U_ideal_A{5}=F(H_int_A,1/4/abs(J(2,3)))*...
%     R(gopA(3,X),180)*R(gopA(2,X),180)*F(H_int_A,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
%     R(gopA(1,X),180)*F(H_int_A,1/4/abs(J(1,2))); 
% U_ideal_B{5}=F(H_int_B,1/2/abs(J(2,3)));
% U_ideal_A{6}=F(H_int_A,1e-3)*R(gopA(2,-Y),90); U_ideal_B{6}=F(H_int_B,1e-3);
% 
% % U_Encoding
% uncompiled_pulse{1}={[1e-3, 1e-5], [7, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{2}={[1/(2*abs(J(5,7))), 1e-5], [2, 1/4/abs(J(2,7)), 2e-3, 0, 180, 100; 4, 1/4/abs(J(4,7)), 2e-3, 0, 180, 100; 5, 1/4/abs(J(5,7)), 2e-3, 0, 180, 100; 6, 1/4/abs(J(6,7)), 2e-3, 0, 180, 100; 7, 1/4/abs(J(5,7)), 2e-3, 0, 180, 100]};
% uncompiled_pulse{3}={[1e-3, 1e-5], [7, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{4}={[1e-3, 1e-5], [2, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{5}={[1/(2*abs(J(2,3))), 1e-5], [1, 1/4/abs(J(1,2)), 2e-3, 0, 180, 100; 2, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 3, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100]};
% uncompiled_pulse{6}={[1e-3, 1e-5], [2, 0.5e-3, 1e-3, 0, 90, 60]};
% 
% [U_sim, fidelity, rf_x, rf_y]=compiler(U_ideal, U_ideal_A, U_ideal_B, uncompiled_pulse);
% save Encoding.mat
% 
% 
% %%
% % U_90_1234567
% % U_ideal{1}=R(gop(1,Y),90)*R(gop(2,Y),90)*R(gop(3,Y),90)*R(gop(4,Y),90)*R(gop(5,Y),90)*R(gop(6,Y),90)*R(gop(7,Y),90);
% 
% clear;
% 
% load parameter.mat
% global nqubits; nqubits=7;
% 
% % U_Decoding
% U_ideal{1}=R(gop(1,X),90)*R(gop(3,X),90)*R(gop(4,X),90)*R(gop(6,X),90)*F(H_int,1e-3);
% U_ideal{2}=F(H_int,1/4/abs(J(2,3)))*...
%     R(gop(2,X),180)*R(gop(3,X),180)*R(gop(4,X),180)*R(gop(5,X),180)*R(gop(6,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
%     R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)));
% U_ideal{3}=F(H_int,1e-3)*R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))'*R(gop(1,-Y),90)*R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))*...
%     R(gop(3,-Y),90)*...
%     R(gop(4,-Y),90)*...
%     R(gop(6,-Y),90);
% U_ideal{4}=R(gop(2,X),90)*R(gop(5,X),90)*F(H_int,1e-3);
% U_ideal{5}=F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
%     R(gop(1,X),180)*R(gop(3,X),180)*F(H_int,1/4/abs(J(2,7)))*...
%     R(gop(5,X),180)*R(gop(7,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
%     R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)));
% U_ideal{6}=F(H_int,1e-3)*R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))'*R(gop(2,-Y),90)*R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))*...
%     R(gop(5,-Y),90);
% 
% U_ideal_A{1}=R(gopA(1,X),90)*R(gopA(3,X),90)*F(H_int_A,1e-3); 
% U_ideal_B{1}=R(gopB(1,X),90)*R(gopB(3,X),90)*F(H_int_B,1e-3);
% 
% U_ideal_A{2}=F(H_int_A,1/4/abs(J(2,3)))*...
%     R(gopA(2,X),180)*R(gopA(3,X),180)*F(H_int_A,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
%     R(gopA(1,X),180)*F(H_int_A,1/4/abs(J(1,2)));
% U_ideal_B{2}=F(H_int_B,1/4/abs(J(2,3)))*...
%     R(gopB(1,X),180)*R(gopB(2,X),180)*R(gopB(3,X),180)*F(H_int_B,1/4/abs(J(2,3)));
% 
% U_ideal_A{3}=F(H_int_A,1e-3)*R(gopA(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))'*R(gopA(1,-Y),90)*R(gopA(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))*...
%     R(gopA(3,-Y),90); 
% U_ideal_B{3}=F(H_int_B,1e-3)*R(gopB(1,-Y),90)*R(gopB(3,-Y),90);
% 
% U_ideal_A{4}=R(gopA(2,X),90)*F(H_int_A,1e-3); 
% U_ideal_B{4}=R(gopB(2,X),90)*F(H_int_B,1e-3);
% 
% U_ideal_A{5}=F(H_int_A,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
%     R(gopA(1,X),180)*R(gopA(3,X),180)*F(H_int_A,1/4/abs(J(5,7)))*...
%     R(gopA(2,X),180)*F(H_int_A,1/4/abs(J(2,7))); 
% U_ideal_B{5}=F(H_int_B,1/4/abs(J(5,7)))*...
%     R(gopB(2,X),180)*R(gopB(4,X),180)*F(H_int_B,1/4/abs(J(5,7)));
% 
% U_ideal_A{6}=F(H_int_A,1e-3)*R(gopA(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))'*R(gopA(2,-Y),90)*R(gopA(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7)))); 
% U_ideal_B{6}=F(H_int_B,1e-3)*R(gopB(2,-Y),90);
% 
% 
% % uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle, pulse_variance], compile option};
% % suggested pulse_variance: Gaussian: (90 degree: 60; 180 degree: 120; 270 degree: 150;)
% % compile option= 
% %   I: eliminate nontrivial post_errors; 
% %  II: eliminate nontrivial pre_errors and post_erros; 
% % III: eliminate nontrivial pre_errors;
% 
% % U_90_123456
% % uncompiled_pulse{1}={[1e-3, 5e-6], [1, 0.5e-3, 1e-3, 0, 90, 80; 2, 0.5e-3, 1e-3, 0, 90, 70; 3, 0.5e-3, 1e-3, 0, 90, 80; 4, 0.5e-3, 1e-3, 0, 90, 70; 5, 0.5e-3, 1e-3, 0, 90, 80; 6, 0.5e-3, 1e-3, 0, 90, 90], {'I','I','I','I','I','I'}}; 
% 
% 
% 
% % U_90_1234567
% % uncompiled_pulse{1}={[1e-3, 5e-6], [1, 0.5e-3, 1e-3, 0, 90, 80; 2, 0.5e-3, 1e-3, 0, 90, 80; 3, 0.5e-3, 1e-3, 0, 90, 80; 4, 0.5e-3, 1e-3, 0, 90, 80; 5, 0.5e-3, 1e-3, 0, 90, 80; 6, 0.5e-3, 1e-3, 0, 90, 80; 7, 0.5e-3, 1e-3, 0, 90, 80], {'I','I','I','I','I','I','I'}}; 
% 
% % U_Decoding
% uncompiled_pulse{1}={[1e-3, 1e-5], [1, 0.5e-3, 1e-3, 0, 90, 60; 3, 0.5e-3, 1e-3, 0, 90, 60; 4, 0.5e-3, 1e-3, 0, 90, 60; 6, 0.5e-3, 1e-3, 0, 90, 60]}; 
% uncompiled_pulse{2}={[1/(2*abs(J(2,3))), 1e-5], [1, 1/4/abs(J(1,2)), 2e-3, 0, 180, 100; 2, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 3, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 4, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 5, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100; 6, 1/4/abs(J(2,3)), 2e-3, 0, 180, 100]};
% uncompiled_pulse{3}={[1e-3, 1e-5], [1, 0.5e-3, 1e-3, 0, 90, 60; 3, 0.5e-3, 1e-3, 0, 90, 60; 4, 0.5e-3, 1e-3, 0, 90, 60; 6, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{4}={[1e-3, 1e-5], [2, 0.5e-3, 1e-3, 0, 90, 60; 5, 0.5e-3, 1e-3, 0, 90, 60]};
% uncompiled_pulse{5}={[1/(2*abs(J(5,7))), 1e-5], [1, 1/4/abs(J(2,7))+1/4/abs(J(5,7)), 2e-3, 0, 180, 100; 2, 1/4/abs(J(2,7)), 2e-3, 0, 180, 100; 3, 1/4/abs(J(2,7))+1/4/abs(J(5,7)), 2e-3, 0, 180, 100; 5, 1/4/abs(J(5,7)), 2e-3, 0, 180, 100; 7, 1/4/abs(J(5,7)), 2e-3, 0, 180, 100]};
% uncompiled_pulse{6}={[1e-3, 1e-5], [2, 0.5e-3, 1e-3, 0, 90, 60; 5, 0.5e-3, 1e-3, 0, 90, 60]};
% 
% 
% [U_sim, fidelity, rf_x, rf_y]=compiler(U_ideal, U_ideal_A, U_ideal_B, uncompiled_pulse);
% 
% save Decoding.mat


%% Main Programe for Pulse Compiling;

% Author: Jun Li
% Date: 2013.06.21
% References: 
%   (1) C. A. Ryan, et al, Phys. Rev. A 78, 012328, (2008).
%   (2) Codes by Ryan at IQC NMR lab.

clear;

load parameter.mat
global nqubits; nqubits=7;

% Write target U_ideal and uncompiled pulse pulse;

% U_90_123456
% U_ideal{1}=R(gop(1,Y),90)*R(gop(2,Y),90)*R(gop(3,Y),90)*R(gop(4,Y),90)*R(gop(5,Y),90)*R(gop(6,Y),90);

% U_Encoding

U_ideal{1}=R(gop(7,Y),90)*F(H_int,1e-3);
U_ideal{2}=F(H_int,1/4/abs(J(2,7))-1e-3);
U_ideal{3}=F(H_int,1e-3)*R(gop(4,X),180)*F(H_int,(1/4/abs(J(4,7))-1/4/abs(J(6,7))))*...
    R(gop(6,X),180)*F(H_int,(1/4/abs(J(6,7))-1/4/abs(J(2,7))))*...
    R(gop(2,X),180)*F(H_int,1e-3);
U_ideal{4}=F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(4,7)))-2e-3);
U_ideal{5}=F(H_int,1e-3)*R(gop(7,X),180)*R(gop(5,X),180)*F(H_int,1e-3);
U_ideal{6}=F(H_int,1/4/abs(J(5,7))-1e-3);
U_ideal{7}=F(H_int,1e-3)*R(gop(7,-Y),90);
U_ideal{8}=R(gop(2,Y),90)*F(H_int,1e-3);
U_ideal{9}=F(H_int,1/4/abs(J(1,2))-1e-3);
U_ideal{10}=F(H_int,1e-3)*R(gop(1,X),180)*F(H_int,1e-3);
U_ideal{11}=F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2)))-2e-3);
U_ideal{12}=F(H_int,1e-3)*R(gop(2,X),180)*R(gop(3,X),180)*F(H_int,1e-3);
U_ideal{13}=F(H_int,(1/4/abs(J(2,3))-1e-3));
U_ideal{14}=F(H_int,1e-3)*R(gop(2,-Y),90);

U_ideal_A{1}=F(H_int_A,1e-3); U_ideal_B{1}=R(gopB(4,Y),90)*F(H_int_B,1e-3);
U_ideal_A{2}=F(H_int_A,1/4/abs(J(2,7))-1e-3); U_ideal_B{2}=F(H_int_B,1/4/abs(J(2,7))-1e-3);
U_ideal_A{3}=F(H_int_A,(1/4/abs(J(4,7))-1/4/abs(J(2,7)))+1e-3)*R(gopA(2,X),180)*F(H_int_A,1e-3);
U_ideal_B{3}=F(H_int_B,1e-3)*R(gopB(1,X),180)*F(H_int_B,(1/4/abs(J(4,7))-1/4/abs(J(6,7))))*...
    R(gopB(3,X),180)*F(H_int_B,(1/4/abs(J(6,7))-1/4/abs(J(2,7)))+1e-3);
U_ideal_A{4}=F(H_int_A,(1/4/abs(J(5,7))-1/4/abs(J(4,7)))-2e-3);
U_ideal_B{4}=F(H_int_B,(1/4/abs(J(5,7))-1/4/abs(J(4,7)))-2e-3);
U_ideal_A{5}=F(H_int_A,2e-3);
U_ideal_B{5}=F(H_int_B,1e-3)*R(gopB(2,X),180)*R(gopB(4,X),180)*F(H_int_B,1e-3);
U_ideal_A{6}=F(H_int_A,1/4/abs(J(5,7))-1e-3);
U_ideal_B{6}=F(H_int_B,1/4/abs(J(5,7))-1e-3);
U_ideal_A{7}=F(H_int_A,1e-3);
U_ideal_B{7}=F(H_int_B,1e-3)*R(gopB(4,-Y),90);
U_ideal_A{8}=R(gopA(2,Y),90)*F(H_int_A,1e-3);
U_ideal_B{8}=F(H_int_B,1e-3);
U_ideal_A{9}=F(H_int_A,1/4/abs(J(1,2))-1e-3);
U_ideal_B{9}=F(H_int_B,1/4/abs(J(1,2))-1e-3);
U_ideal_A{10}=F(H_int_A,1e-3)*R(gopA(1,X),180)*F(H_int_A,1e-3);
U_ideal_B{10}=F(H_int_B,2e-3);
U_ideal_A{11}=F(H_int_A,(1/4/abs(J(2,3))-1/4/abs(J(1,2)))-2e-3);
U_ideal_B{11}=F(H_int_B,(1/4/abs(J(2,3))-1/4/abs(J(1,2)))-2e-3);
U_ideal_A{12}=F(H_int_A,1e-3)*R(gopA(2,X),180)*R(gopA(3,X),180)*F(H_int_A,1e-3);
U_ideal_B{12}=F(H_int_B,2e-3);
U_ideal_A{13}=F(H_int_A,(1/4/abs(J(2,3))-1e-3));
U_ideal_B{13}=F(H_int_B,(1/4/abs(J(2,3))-1e-3));
U_ideal_A{14}=F(H_int_A,1e-3)*R(gopA(2,-Y),90);
U_ideal_B{14}=F(H_int_B,1e-3);


% U_Encoding
uncompiled_pulse{1}={[1e-3, 1e-6], [7, 0.5e-3, 1e-3, 0, 90, 300]};
uncompiled_pulse{2}={[1/4/abs(J(2,7))-1e-3, 1e-6]};
uncompiled_pulse{3}={[(1/4/abs(J(4,7))-1/4/abs(J(2,7)))+2e-3, 1e-6], [2, 1e-3, 2e-3, 0, 180, 100; 4, (1/4/abs(J(4,7))-1/4/abs(J(2,7)))+1e-3, 2e-3, 0, 180, 100; 6, (1/4/abs(J(6,7))-1/4/abs(J(2,7)))+1e-3, 2e-3, 0, 180, 100]};
uncompiled_pulse{4}={[(1/4/abs(J(5,7))-1/4/abs(J(4,7)))-2e-3, 1e-6]};
uncompiled_pulse{5}={[2e-3,1e-6],[5, 1e-3, 2e-3, 0, 180, 100; 7, 1e-3, 2e-3, 0, 180, 100]};
uncompiled_pulse{6}={[1/4/abs(J(5,7))-1e-3,1e-6]};
uncompiled_pulse{7}={[1e-3, 1e-6], [7, 0.5e-3, 1e-3, 0, 90, 300]};
uncompiled_pulse{8}={[1e-3, 1e-6], [2, 0.5e-3, 1e-3, 0, 90, 300]};
uncompiled_pulse{9}={[1/4/abs(J(1,2))-1e-3, 1e-6]};
uncompiled_pulse{10}={[2e-3, 1e-6], [1, 1e-3, 2e-3, 0, 180, 100]};
uncompiled_pulse{11}={[(1/4/abs(J(2,3))-1/4/abs(J(1,2)))-2e-3,1e-6]};
uncompiled_pulse{12}={[2e-3,1e-6],[2, 1e-3, 2e-3, 0, 180, 100; 3, 1e-3, 2e-3, 0, 180, 100]};
uncompiled_pulse{13}={[(1/4/abs(J(2,3))-1e-3),1e-6]};
uncompiled_pulse{14}={[1e-3, 1e-6], [2, 0.5e-3, 1e-3, 0, 90, 300]};


[U_sim, fidelity, rf_x, rf_y]=compiler(U_ideal, U_ideal_A, U_ideal_B, uncompiled_pulse);
save Encoding.mat

U_Encoding=eye(128);
for k=1:length(U_ideal)
    U_Encoding=U_ideal{k}*U_Encoding;
end

%% shapefile





Bx=[]; By=[]; 
for n=1:length(rf_x)
    Bx=[Bx,rf_x{n}]; 
    By=[By,rf_y{n}];
end

    
total_time=length(Bx)*1e-5; ref_power=2500; 
Amp=abs(Bx+i*By)*100/ref_power; Phase=angle(Bx+i*By)*180/pi;
fid=fopen('12spin_7PPS_U_Encoding.txt','w');
fprintf(fid, '##TITLE= %s\n','Gaussian');
fprintf(fid, '##JCAPM-DX= 5.00 Bruker JCAMP library\n');
fprintf(fid, '##DATA TYPE= Shape Pulses \n');
fprintf(fid, '##ORIGIN= Colm Fixed Pulses \n');
fprintf(fid, '##OWNER= %s\n', 'Dawei Lu');
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



%%
clear;

load parameter.mat
global nqubits; nqubits=7;

% U_Decoding
U_ideal{1}=R(gop(1,X),90)*R(gop(3,X),90)*R(gop(4,X),90)*R(gop(6,X),90)*F(H_int,1e-3);
U_ideal{2}=F(H_int,1/4/abs(J(1,2))-1e-3);
U_ideal{3}=F(H_int,1e-3)*R(gop(1,X),180)*F(H_int,1e-3);
U_ideal{4}=F(H_int,1/4/abs(J(2,3))-1/4/abs(J(1,2))-2e-3);
U_ideal{5}=F(H_int,1e-3)*R(gop(2,X),180)*R(gop(3,X),180)*R(gop(4,X),180)*R(gop(5,X),180)*R(gop(6,X),180)*F(H_int,1e-3);
U_ideal{6}=F(H_int,1/4/abs(J(2,3))-1e-3);
U_ideal{7}=F(H_int,1e-3)*R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))'*R(gop(1,-Y),90)*R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))*...
    R(gop(3,-Y),90)*...
    R(gop(4,-Y),90)*...
    R(gop(6,-Y),90);
U_ideal{8}=R(gop(2,X),90)*R(gop(5,X),90)*F(H_int,1e-3);
U_ideal{9}=F(H_int,1/4/abs(J(2,7))-1e-3);
U_ideal{10}=F(H_int,1e-3)*R(gop(2,X),180)*F(H_int,1e-3);
U_ideal{11}=F(H_int,1/4/abs(J(5,7))-1/4/abs(J(2,7))-2e-3);
U_ideal{12}=F(H_int,1e-3)*R(gop(5,X),180)*R(gop(7,X),180)*F(H_int,1e-3);
U_ideal{13}=F(H_int,1/4/abs(J(2,7))-2e-3);
U_ideal{14}=F(H_int,1e-3)*R(gop(1,X),180)*R(gop(3,X),180)*F(H_int,1e-3);
U_ideal{15}=F(H_int,1/4/abs(J(5,7))-1/4/abs(J(2,7))-1e-3);
U_ideal{16}=F(H_int,1e-3)*R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))'*R(gop(2,-Y),90)*R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))*...
    R(gop(5,-Y),90);

U_ideal_A{1}=R(gopA(1,X),90)*R(gopA(3,X),90)*F(H_int_A,1e-3); 
U_ideal_B{1}=R(gopB(1,X),90)*R(gopB(3,X),90)*F(H_int_B,1e-3);
U_ideal_A{2}=F(H_int_A,1/4/abs(J(1,2))-1e-3); 
U_ideal_B{2}=F(H_int_B,1/4/abs(J(1,2))-1e-3);
U_ideal_A{3}=F(H_int_A,1e-3)*R(gopA(1,X),180)*F(H_int_A,1e-3); 
U_ideal_B{3}=F(H_int_B,2e-3);
U_ideal_A{4}=F(H_int_A,1/4/abs(J(2,3))-1/4/abs(J(1,2))-2e-3); 
U_ideal_B{4}=F(H_int_B,1/4/abs(J(2,3))-1/4/abs(J(1,2))-2e-3);
U_ideal_A{5}=F(H_int_A,1e-3)*R(gopA(2,X),180)*R(gopA(3,X),180)*F(H_int_A,1e-3); 
U_ideal_B{5}=F(H_int_B,1e-3)*R(gopB(1,X),180)*R(gopB(2,X),180)*R(gopB(3,X),180)*F(H_int_B,1e-3);
U_ideal_A{6}=F(H_int_A,1/4/abs(J(2,3))-1e-3); 
U_ideal_B{6}=F(H_int_B,1/4/abs(J(2,3))-1e-3);
U_ideal_A{7}=F(H_int_A,1e-3)*R(gopA(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))'*R(gopA(1,-Y),90)*R(gopA(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))*...
    R(gopA(3,-Y),90); 
U_ideal_B{7}=F(H_int_B,1e-3)*R(gopB(1,-Y),90)*R(gopB(3,-Y),90);
U_ideal_A{8}=R(gopA(2,X),90)*F(H_int_A,1e-3); 
U_ideal_B{8}=R(gopB(2,X),90)*F(H_int_B,1e-3);
U_ideal_A{9}=F(H_int_A,1/4/abs(J(2,7))-1e-3); 
U_ideal_B{9}=F(H_int_B,1/4/abs(J(2,7))-1e-3);
U_ideal_A{10}=F(H_int_A,1e-3)*R(gopA(2,X),180)*F(H_int_A,1e-3);
U_ideal_B{10}=F(H_int_B,2e-3);
U_ideal_A{11}=F(H_int_A,1/4/abs(J(5,7))-1/4/abs(J(2,7))-2e-3); 
U_ideal_B{11}=F(H_int_B,1/4/abs(J(5,7))-1/4/abs(J(2,7))-2e-3);
U_ideal_A{12}=F(H_int_A,2e-3); 
U_ideal_B{12}=F(H_int_B,1e-3)*R(gopB(2,X),180)*R(gopB(4,X),180)*F(H_int_B,1e-3);
U_ideal_A{13}=F(H_int_A,1/4/abs(J(2,7))-2e-3); 
U_ideal_B{13}=F(H_int_B,1/4/abs(J(2,7))-2e-3);
U_ideal_A{14}=F(H_int_A,1e-3)*R(gopA(1,X),180)*R(gopA(3,X),180)*F(H_int_A,1e-3); 
U_ideal_B{14}=F(H_int_B,2e-3);
U_ideal_A{15}=F(H_int_A,1/4/abs(J(5,7))-1/4/abs(J(2,7))-1e-3); 
U_ideal_B{15}=F(H_int_B,1/4/abs(J(5,7))-1/4/abs(J(2,7))-1e-3);
U_ideal_A{16}=F(H_int_A,1e-3)*R(gopA(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))'*R(gopA(2,-Y),90)*R(gopA(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7)))); 
U_ideal_B{16}=F(H_int_B,1e-3)*R(gopB(2,-Y),90);


% uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle, pulse_variance], compile option};
% suggested pulse_variance: Gaussian: (90 degree: 60; 180 degree: 120; 270 degree: 150;)
% compile option= 
%   I: eliminate nontrivial post_errors; 
%  II: eliminate nontrivial pre_errors and post_erros; 
% III: eliminate nontrivial pre_errors;

% U_Decoding
uncompiled_pulse{1}={[1e-3, 1e-6], [1, 0.5e-3, 1e-3, 0, 90, 300; 3, 0.5e-3, 1e-3, 0, 90, 300; 4, 0.5e-3, 1e-3, 0, 90, 300; 6, 0.5e-3, 1e-3, 0, 90, 300]}; 
uncompiled_pulse{2}={[1/4/abs(J(1,2))-1e-3,1e-6]};
uncompiled_pulse{3}={[2e-3,1e-6],[1, 1e-3, 2e-3, 0, 180, 100]};
uncompiled_pulse{4}={[1/4/abs(J(2,3))-1/4/abs(J(1,2))-2e-3,1e-6]};
uncompiled_pulse{5}={[2e-3,1e-6],[2, 1e-3, 2e-3, 0, 180, 100; 3, 1e-3, 2e-3, 0, 180, 100; 4, 1e-3, 2e-3, 0, 180, 100; 5, 1e-3, 2e-3, 0, 180, 100; 6, 1e-3, 2e-3, 0, 180, 100]};
uncompiled_pulse{6}={[1/4/abs(J(2,3))-1e-3,1e-6]};
uncompiled_pulse{7}={[1e-3, 1e-6], [1, 0.5e-3, 1e-3, 0, 90, 300; 3, 0.5e-3, 1e-3, 0, 90, 300; 4, 0.5e-3, 1e-3, 0, 90, 300; 6, 0.5e-3, 1e-3, 0, 90, 300]};
uncompiled_pulse{8}={[1e-3, 1e-6], [2, 0.5e-3, 1e-3, 0, 90, 300; 5, 0.5e-3, 1e-3, 0, 90, 300]};
uncompiled_pulse{9}={[1/4/abs(J(2,7))-1e-3,1e-6]};
uncompiled_pulse{10}={[2e-3,1e-6],[2, 1e-3, 2e-3, 0, 180, 100]};
uncompiled_pulse{11}={[1/4/abs(J(5,7))-1/4/abs(J(2,7))-2e-3,1e-6]};
uncompiled_pulse{12}={[2e-3,1e-6],[5, 1e-3, 2e-3, 0, 180, 100; 5, 1e-3, 2e-3, 0, 180, 100]};
uncompiled_pulse{13}={[1/4/abs(J(2,7))-2e-3,1e-6]};
uncompiled_pulse{14}={[2e-3,1e-6], [1, 1e-3, 2e-3, 0, 180, 100; 3, 1e-3, 2e-3, 0, 180, 100]};
uncompiled_pulse{15}={[1/4/abs(J(5,7))-1/4/abs(J(2,7))-1e-3,1e-6]};
uncompiled_pulse{16}={[1e-3, 1e-6], [2, 0.5e-3, 1e-3, 0, 90, 300; 5, 0.5e-3, 1e-3, 0, 90, 300]};


[U_sim, fidelity, rf_x, rf_y]=compiler(U_ideal, U_ideal_A, U_ideal_B, uncompiled_pulse);

save Decoding.mat

U_Decoding=eye(128);
for k=1:length(U_ideal)
    U_Decoding=U_ideal{k}*U_Decoding;
end





















%% shapefile





Bx=[]; By=[]; 
for n=1:length(rf_x)
    Bx=[Bx,rf_x{n}]; 
    By=[By,rf_y{n}];
end

    
total_time=length(Bx)*1e-5; ref_power=2500; 
Amp=abs(Bx+i*By)*100/ref_power; Phase=angle(Bx+i*By)*180/pi;
fid=fopen('12spin_7PPS_U_Decoding.txt','w');
fprintf(fid, '##TITLE= %s\n','Gaussian');
fprintf(fid, '##JCAPM-DX= 5.00 Bruker JCAMP library\n');
fprintf(fid, '##DATA TYPE= Shape Pulses \n');
fprintf(fid, '##ORIGIN= Colm Fixed Pulses \n');
fprintf(fid, '##OWNER= %s\n', 'Dawei Lu');
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