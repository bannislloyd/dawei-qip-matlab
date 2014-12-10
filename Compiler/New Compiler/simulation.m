%%% PPS Cat State Method Simulation;


%% 12 Qubits System;

clear;
load CH_Hamiltonian.mat;
load C_H_int.mat;

rho_initial=4*gop(7,Z);
rho_12coherence=gop(1,Z)*gop(2,Z)*gop(3,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z)*gop(8,Z)*gop(9,Z)*gop(10,Z)*gop(11,Z)*gop(12,Z);
rho_12coherence1=gop(1,(X+i*Y)/sqrt(2))*gop(2,(X+i*Y)/sqrt(2))*gop(3,(X+i*Y)/sqrt(2))*gop(4,(X+i*Y)/sqrt(2))*gop(5,(X+i*Y)/sqrt(2))*gop(6,(X+i*Y)/sqrt(2))*gop(7,(X+i*Y)/sqrt(2))*...
    gop(8,(X+i*Y)/sqrt(2))*gop(9,(X+i*Y)/sqrt(2))*gop(10,(X+i*Y)/sqrt(2))*gop(11,(X+i*Y)/sqrt(2))*gop(12,(X+i*Y)/sqrt(2));
rho_12coherence2=gop(1,(X-i*Y)/sqrt(2))*gop(2,(X+i*Y)/sqrt(2))*gop(3,(X+i*Y)/sqrt(2))*gop(4,(X+i*Y)/sqrt(2))*gop(5,(X-i*Y)/sqrt(2))*gop(6,(X-i*Y)/sqrt(2))*gop(7,(X+i*Y)/sqrt(2))*...
    gop(8,(Z+I)/sqrt(2))*gop(9,(Z+I)/sqrt(2))*gop(10,(Z+I)/sqrt(2))*gop(11,(Z+I)/sqrt(2))*gop(12,(Z+I)/sqrt(2));
rho_12coherence3=gop(1,(Z-I)/sqrt(2))*gop(2,(X-i*Y)/sqrt(2))*gop(3,(Z+I)/sqrt(2))*gop(4,(Z-I)/sqrt(2))*gop(5,(X+i*Y)/sqrt(2))*gop(6,(Z+I)/sqrt(2))*gop(7,(X+i*Y)/sqrt(2))*...
    gop(8,(Z+I)/sqrt(2))*gop(9,(Z+I)/sqrt(2))*gop(10,(Z+I)/sqrt(2))*gop(11,(Z+I)/sqrt(2))*gop(12,(Z+I)/sqrt(2));
rho_12coherence_final=gop(1,(Z+I)/sqrt(2))*gop(2,(Z-I)/sqrt(2))*gop(3,(Z-I)/sqrt(2))*gop(4,(Z-I)/sqrt(2))*gop(5,(Z-I)/sqrt(2))*gop(6,(Z+I)/sqrt(2))*gop(7,(X-i*Y)/sqrt(2))*...
    gop(8,(Z+I)/sqrt(2))*gop(9,(Z+I)/sqrt(2))*gop(10,(Z+I)/sqrt(2))*gop(11,(Z+I)/sqrt(2))*gop(12,(Z+I)/sqrt(2));



U_Encoding=R(gop(2,Z),360*w(2)*1/2/abs(J(7,12)))*R(gop(2,X),90)*R(gop(2,Z),360*w(2)*1/2/abs(J(7,12)))'*...
    R(gop(3,Z),360*w(3)*1/2/abs(J(7,12)))*R(gop(3,-Y),90)*R(gop(3,Z),360*w(3)*1/2/abs(J(7,12)))'*...
    R(gop(4,Z),360*w(4)*1/2/abs(J(7,12)))*R(gop(4,X),90)*R(gop(4,Z),360*w(4)*1/2/abs(J(7,12)))'*...
    R(gop(7,Z),360*w(7)*1/2/abs(J(7,12)))*R(gop(7,X),90)*R(gop(7,Z),360*w(7)*1/2/abs(J(7,12)))'*...
    F(H_int,1/4/abs(J(7,12)))*R(gop(1,X),180)*R(gop(5,X),180)*R(gop(6,X),180)*F(H_int,1/4/abs(J(7,12)))*...
    R(gop(2,Y),90)*R(gop(3,Y),90)*R(gop(4,Y),90)*R(gop(7,Y),90)*...
    R(gop(2,-Y),90)*...
    F(H_int,1/4/abs(J(2,3)))*...
    R(gop(3,X),180)*R(gop(2,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
    R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)))*...
    R(gop(2,Y),90)*...
    R(gop(7,-Y),90)*...
    F(H_int,1/4/abs(J(5,7)))*...
    R(gop(7,X),180)*R(gop(5,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(4,7))))*...
    R(gop(4,X),180)*F(H_int,(1/4/abs(J(4,7))-1/4/abs(J(6,7))))*...
    R(gop(6,X),180)*F(H_int,(1/4/abs(J(6,7))-1/4/abs(J(2,7))))*...
    R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)))*...
    R(gop(7,Y),90);


U_Decoding=R(gop(2,Z),360*(w(2)+(J(2,8)+J(2,9)+J(2,10)+J(2,11)+J(2,12))/2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))'*R(gop(2,-Y),90)*R(gop(2,Z),360*(w(2)+(J(2,8)+J(2,9)+J(2,10)+J(2,11)+J(2,12))/2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))*...
    R(gop(5,-Y),90)*...
    F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
    R(gop(1,X),180)*R(gop(3,X),180)*F(H_int,1/4/abs(J(2,7)))*...
    R(gop(5,X),180)*R(gop(7,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
    R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)))*...
    R(gop(2,X),90)*R(gop(5,X),90)*...
    R(gop(1,Z),360*(w(1)+(J(1,8)+J(1,9)+J(1,10)+J(1,11)+J(1,12))/2)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))'*R(gop(1,-Y),90)*R(gop(1,Z),360*(w(1)+(J(1,8)+J(1,9)+J(1,10)+J(1,11)+J(1,12))/2)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))*...
    R(gop(3,-Y),90)*...
    R(gop(4,-Y),90)*...
    R(gop(6,-Y),90)*...
    F(H_int,1/4/abs(J(2,3)))*...
    R(gop(2,X),180)*R(gop(3,X),180)*R(gop(4,X),180)*R(gop(5,X),180)*R(gop(6,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
    R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)))*...
    R(gop(1,X),90)*R(gop(3,X),90)*R(gop(4,X),90)*R(gop(6,X),90)*...
    R(gop(8,Z),360*w(8)*1/2/abs(J(7,12)))*R(gop(8,-Y),90)*R(gop(8,Z),360*w(8)*1/2/abs(J(7,12)))'*...
    R(gop(9,Z),360*w(9)*1/2/abs(J(7,12)))*R(gop(9,-Y),90)*R(gop(9,Z),360*w(9)*1/2/abs(J(7,12)))'*...
    R(gop(10,Z),360*w(10)*1/2/abs(J(7,12)))*R(gop(10,-Y),90)*R(gop(10,Z),360*w(10)*1/2/abs(J(7,12)))'*...
    R(gop(11,Z),360*w(11)*1/2/abs(J(7,12)))*R(gop(11,-Y),90)*R(gop(11,Z),360*w(11)*1/2/abs(J(7,12)))'*...
    R(gop(12,Z),360*w(12)*1/2/abs(J(7,12)))*R(gop(12,-Y),90)*R(gop(12,Z),360*w(12)*1/2/abs(J(7,12)))'*...
    F(H_int,1/4/abs(J(7,12)))*R(gop(1,X),180)*R(gop(5,X),180)*R(gop(6,X),180)*F(H_int,1/4/abs(J(7,12)))*...
    R(gop(8,X),90)*R(gop(9,X),90)*R(gop(10,X),90)*R(gop(11,X),90)*R(gop(12,X),90);

T=F(H_int, 5.5e-6);

% Encoding Part:
% I, II: 1;
% III: 0.95, 0.9996;

% Decoding Part:
% 0.2884 + 0.9205i  0.9646;
% 0.5513 - 0.8126i  0.9820;



sigma=zeros(2^nqubits,2^nqubits);
for k=1:24
    r=k/24*360+mod(k,2)*180;
    U_PC=R(gop(1,Z),r)*R(gop(2,Z),r)*R(gop(3,Z),r)*R(gop(4,Z),r)*R(gop(5,Z),r)*R(gop(6,Z),r)*R(gop(7,Z),r)*R(gop(8,Z),r)*R(gop(9,Z),r)*R(gop(10,Z),r)*R(gop(11,Z),r)*R(gop(12,Z),r)*...
        R(gop(1,Y),90)*R(gop(2,Y),90)*R(gop(3,Y),90)*R(gop(4,Y),90)*R(gop(5,Y),90)*R(gop(6,Y),90)*R(gop(7,Y),90)*R(gop(8,Y),90)*R(gop(9,Y),90)*R(gop(10,Y),90)*R(gop(11,Y),90)*R(gop(12,Y),90);
    rho{k}=U_Decoding*U_PC*GP(U_Encoding*rho_initial*U_Encoding')*U_PC'*U_Decoding';
    sigma=sigma+rho{k};
end
save sigma sigma

% 0.95*0.1177*

XY_decompose(sigma)



%% 7 Carbons System
clear;
load parameter.mat;

rho_initial=gop(7,Z);
rho_7coherence=gop(1,Z)*gop(2,Z)*gop(3,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z);
rho_7coherence1=gop(1,(X+i*Y)/sqrt(2))*gop(2,(X+i*Y)/sqrt(2))*gop(3,(X+i*Y)/sqrt(2))*gop(4,(X+i*Y)/sqrt(2))*gop(5,(X+i*Y)/sqrt(2))*gop(6,(X+i*Y)/sqrt(2))*gop(7,(X+i*Y)/sqrt(2));
rho_7coherence2=gop(1,(Z+I)/sqrt(2))*gop(2,(X-i*Y)/sqrt(2))*gop(3,(Z+I)/sqrt(2))*gop(4,(Z+I)/sqrt(2))*gop(5,(X-i*Y)/sqrt(2))*gop(6,(Z+I)/sqrt(2))*gop(7,(X+i*Y)/sqrt(2));
rho_7coherence3=gop(1,(Z-I)/sqrt(2))*gop(2,(Z-I)/sqrt(2))*gop(3,(Z-I)/sqrt(2))*gop(4,(Z+I)/sqrt(2))*gop(5,(Z+I)/sqrt(2))*gop(6,(Z+I)/sqrt(2))*gop(7,(X-i*Y)/sqrt(2));
rho_final=gop(1,(Z-I)/sqrt(2))*gop(2,(Z-I)/sqrt(2))*gop(3,(Z-I)/sqrt(2))*gop(4,(Z+I)/sqrt(2))*gop(5,(Z+I)/sqrt(2))*gop(6,(Z+I)/sqrt(2))*gop(7,X);

U_Encoding=R(gop(2,-Y),90)*...
    F(H_int,1/4/abs(J(2,3)))*...
    R(gop(3,X),180)*R(gop(2,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
    R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)))*...
    R(gop(2,Y),90)*...
    R(gop(7,-Y),90)*...
    F(H_int,1/4/abs(J(5,7)))*...
    R(gop(7,X),180)*R(gop(5,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(4,7))))*...
    R(gop(4,X),180)*F(H_int,(1/4/abs(J(4,7))-1/4/abs(J(6,7))))*...
    R(gop(6,X),180)*F(H_int,(1/4/abs(J(6,7))-1/4/abs(J(2,7))))*...
    R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)))*...
    R(gop(7,Y),90);

U_Decoding=R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))'*R(gop(2,-Y),90)*R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))*...
    R(gop(5,-Y),90)*...
    F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
    R(gop(1,X),180)*R(gop(3,X),180)*F(H_int,1/4/abs(J(2,7)))*...
    R(gop(5,X),180)*R(gop(7,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
    R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)))*...
    R(gop(2,X),90)*R(gop(5,X),90)*...
    R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))'*R(gop(1,-Y),90)*R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))*...
    R(gop(3,-Y),90)*...
    R(gop(4,-Y),90)*...
    R(gop(6,-Y),90)*...
    F(H_int,1/4/abs(J(2,3)))*...
    R(gop(2,X),180)*R(gop(3,X),180)*R(gop(4,X),180)*R(gop(5,X),180)*R(gop(6,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
    R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)))*...
    R(gop(1,X),90)*R(gop(3,X),90)*R(gop(4,X),90)*R(gop(6,X),90);

% trace(U_Encoding*rho_initial*U_Encoding'*rho_7coherence')/2^7=1
% trace(U_Decoding*rho_7coherence1*U_Decoding'*rho_7coherence2')/2^7=0.8770 + 0.4463i, 0.9840
% trace(U_Decoding*rho_7coherence1*U_Decoding'*rho_7coherence3')/2^7=0.8979 + 0.3933i, 0.9803
nqubits = 7;
sigma=zeros(2^nqubits,2^nqubits);
T=expm(-i*H_int*7e-6);
for k=1:7
    r=k/7*360;
    U_PC=R(gop(1,Z),r)*R(gop(2,Z),r)*R(gop(3,Z),r)*R(gop(4,Z),r)*R(gop(5,Z),r)*R(gop(6,Z),r)*R(gop(7,Z),r)*...
        R(gop(1,Y),90)*R(gop(2,Y),90)*R(gop(3,Y),90)*R(gop(4,Y),90)*R(gop(5,Y),90)*R(gop(6,Y),90)*R(gop(7,Y),90);
    rho{k}=T*U_Decoding*U_PC*GP(U_Encoding*rho_initial*U_Encoding')*U_PC'*U_Decoding'*T';
    sigma=sigma+rho{k};
end

% trace(sigma*rho_final')/2^7 = 0.8575;
% trace(sigma/sqrt(trace(sigma*sigma')/2^7)*rho_final')/2^7 = 0.98;

