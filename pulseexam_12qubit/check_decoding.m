clear;

addpath C_rotations

%% This fidelity is 0.9750
%Fid = trace(rho_phasecycling_grape*rho_phasecycling)/sqrt(trace(rho_phasecycling^2)*trace(rho_phasecycling_grape^2)) 

load twpauliX_full.mat
load twpauliY_full.mat
load twpauliZ_full.mat
load Para.mat
I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 
%initial state
%load twqubit_C2347andH180_Ufid.mat
%theo  = R(gop(2,X)+gop(3,X)+gop(4,X)+gop(7,X)+gop(8,X)+gop(9,X)+gop(10,X)+gop(11,X)+gop(12,X),180);
%Fid = abs(trace(U*theo'))/2^12  % 0.8424

% Till first 1/4J_CH, Fid =1; dunno why...
% Till C2347andH180, test2, Fid =-0.6504; dunno why...
% Till C134690andH90, test3, Fid =0.4081; dunno why...

% load rho_phasecycling_grape.mat
 %A0 = rho_phasecycling_grape(1,4096);
% rho_phasecycling_grape = abs(rho_phasecycling_grape);
 
%U_decoding1_grape = R(gop(8,X)+gop(9,X)+gop(10,X)+gop(11,X)+gop(12,X),90); 
 %free evolution 1/4JCH  1680us
 %U_decoding1_grape = F(H,1/4/148.5)*U_decoding1_grape;
%load twqubit_C134690andH90_Ufid.mat
% U_decoding1_grape = U*F(H,1/4/148.5); 
%load rho_test_grape2.mat
% %U_decoding1 = F(H,1/4/148.5)*U_decoding1;
%rho_test_grape = U_decoding1_grape*rho_test_grape*U_decoding1_grape';
%  
% save rho_test_grape3.mat rho_test_grape
% 
%
% 
%% P8_12 = R(gop(8,X)+gop(9,X)+gop(10,X)+gop(11,X)+gop(12,X),90);   											% Pi_2 on 8 to 12
%% U6 = F(H,1/4/148.5);                                												    	%free evolution 1/4J_C7H5
%% P2347_12  = R(gop(2,X)+gop(3,X)+gop(4,X)+gop(7,X)+gop(8,X)+gop(9,X)+gop(10,X)+gop(11,X)+gop(12,X),180);     % Pi on 2,3,4,7-12
%P8_12_1 = R(gop(1,X)+gop(3,X)+gop(4,X)+gop(6,X),90)*R(gop(8,-Y)+gop(9,-Y)+gop(10,-Y)+gop(11,-Y)+gop(12,-Y),90);   									% Pi_2 on 8 to 12
%
%  load rho_test2.mat
% U_decoding1 =   P8_12_1*F(H,1/4/148.5);
%
%
% rho_test =  U_decoding1*(rho_test)*U_decoding1';
%  
%  save rho_test3.mat rho_test
%  
%Fid = trace(rho_test_grape*rho_test)/sqrt(trace(rho_test^2)*trace(rho_test_grape^2)) 

load rho_phasecycling_grape.mat
%  %A0 = rho_phasecycling_grape(1,4096);
% rho_phasecycling_grape = abs(rho_phasecycling_grape);
A0 = 1;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First Step
U_decoding1 = R(gop(8,X)+gop(9,X)+gop(10,X)+gop(11,X)+gop(12,X),90); 
%free evolution 1/4JCH  1680us
U_decoding1 = F(H,1680*1e-6)*U_decoding1;
load twqubit_C2347andH180_Ufid.mat
U_decoding1 = U*U_decoding1;  
disp('Finished pi refocusing...')
%free evolution 1/4JCH  1680us
U_decoding1 = F(H,1680*1e-6)*U_decoding1;

load twqubit_C134690andH90_Ufid.mat
U_decoding1 = U*U_decoding1;    

 rho_decoding1_grape = U_decoding1*rho_phasecycling_grape*U_decoding1';
 
 U_decoding1_grape = U_decoding1;
 
 save  U_decoding1_grape.mat  U_decoding1_grape
 save rho_decoding1_grape.mat rho_decoding1_grape

 disp('Saved U and rho...')

th1 = (Para(1,1)-20696)*2*pi*(3360*1e-6);  A1=(cos(th1)-i*sin(th1));
th5 = (Para(5,5)-20696)*2*pi*(3360*1e-6);  A5=(cos(th5)-i*sin(th5));
th6 = (Para(6,6)-20696)*2*pi*(3360*1e-6);  A6=(cos(th6)-i*sin(th6));

Test_state1 = (A0*A1*A5*A6*gop(1,Ix+i*Iy)*gop(2,Ix-i*Iy)*gop(3,Ix-i*Iy)*gop(4,Ix-i*Iy)*gop(5,Ix+i*Iy)*gop(6,Ix+i*Iy)*gop(7,Ix-i*Iy) + A0'*A1'*A5'*A6'*gop(1,Ix-i*Iy)*gop(2,Ix+i*Iy)*gop(3,Ix+i*Iy)*gop(4,Ix+i*Iy)*gop(5,Ix-i*Iy)*gop(6,Ix-i*Iy)*gop(7,Ix+i*Iy))*gop(8,Iz+I/2)*gop(9,Iz+I/2)*gop(10,Iz+I/2)*gop(11,Iz+I/2)*gop(12,Iz+I/2);
Test_state1 = R(gop(1,X)+gop(3,X)+gop(4,X)+gop(6,X),90)*Test_state1*R(gop(1,X)+gop(3,X)+gop(4,X)+gop(6,X),90)';
Test_state1 = Test_state1/sqrt(2);

Fidelity=trace(Test_state1*rho_decoding1_grape) %/sqrt(trace(Test_state1^2)*trace(rho_decoding1_grape^2))   
f(1) = Fidelity   
%%% FIDELITY AT THIS POINT IS --->  0.3909
%% First Step Over and Checked %%%%%%%%%%%%%%%%%%%%%
load rho_decoding1_grape.mat
% Second Step

%free evolution 1/4J12  4341.78us = 4340us
U_decoding2 = F(H,4340*1e-6);
load twqubit_C1180_Ufid.mat
U_decoding2 = U*U_decoding2;                   
%free evolution 1/4J23-1/4J12  3303.47us = 3300us
U_decoding2 = F(H,3300*1e-6)*U_decoding2;

load twqubit_C23456180_Ufid.mat
U_decoding2 = U*U_decoding2;    
%free evolution 1/4J23  7645.26us = 7640us
U_decoding2 = F(H,7640*1e-6)*U_decoding2;

load twqubit_C1234690withPC_Ufid.mat
U_decoding2 = U*U_decoding2;   


 rho_decoding2_grape = U_decoding2*rho_decoding1_grape*U_decoding2';
 
 U_decoding2_grape = U_decoding2;
 
 save  U_decoding2_grape.mat  U_decoding2_grape
 save rho_decoding2_grape.mat rho_decoding2_grape


th1 = (Para(1,1)-20696)*2*pi*(3360*1e-6);  A1=(cos(th1)-i*sin(th1));
th5 = (Para(5,5)-20696)*2*pi*(3360*1e-6);  A5=(cos(th5)-i*sin(th5));
th6 = (Para(6,6)-20696)*2*pi*(3360*1e-6);  A6=(cos(th6)-i*sin(th6));
th7 = (Para(7,7)-20696)*2*pi*(15280*1e-6);  A7=(cos(th7)+i*sin(th7));
% this phase is different! Because the state of C7 is X-iY but not X+iY

%
for ii = 8:12
    theta_C7H_evolution(ii-7) = pi*Para(7,ii)*(15280*1e-6);
    relative_phase(ii-7) = cos(theta_C7H_evolution(ii-7))+i*sin(theta_C7H_evolution(ii-7)); % because C7 is X-iY so the phase is plus
    A7 = relative_phase(ii-7)*A7;
end

Ip=Ix+i*Iy; Im=Ix-i*Iy; Zp = Iz+I/2; Zm = Iz-I/2;

Test_state2 = (A1*A5*A6*A7*gop(2,Ip)*gop(5,Im)*gop(7,Im) + A1'*A5'*A6'*A7'*gop(2,Im)*gop(5,Ip)*gop(7,Ip))*gop(1,Zp)*gop(3,Zp)*gop(4,Zp)*gop(6,Zp)*gop(8,Zp)*gop(9,Zp)*gop(10,Zp)*gop(11,Zp)*gop(12,Zp);
Test_state2 = R(gop(2,X),90)*Test_state2*R(gop(2,X),90)';
Test_state2 = Test_state2/sqrt(2);

Fidelity=trace(Test_state2*rho_decoding2_grape); %/sqrt(trace(Test_state2^2)*trace(rho_decoding2_grape^2))  
f(2) = Fidelity
%%% FIDELITY AT THIS POINT IS --->  0.3906
%% Second Step Over and Checked %%%%%%%%%%%%%%%%%%%%%
% 
load rho_decoding2_grape.mat
% Third Step

%free evolution 1/4J27  6670.22us = 6670us
U_decoding3 = F(H,6670*1e-6);
load twqubit_C27180_Ufid.mat
U_decoding3 = U*U_decoding3;                   
%free evolution 1/4J27  6670.22us = 6670us
U_decoding3 = F(H,6670*1e-6)*U_decoding3;

disp('Finished J27 evolution')

load twqubit_C2Y5X90_Ufid.mat
U_decoding3 = U*U_decoding3;    
%free evolution 1/4J27  11494.25us = 11490us
U_decoding3 = F(H,11490*1e-6)*U_decoding3;

load twqubit_C57180_Ufid.mat
U_decoding3 = U*U_decoding3;   
%free evolution 1/4J27  11494.25us = 11490us
U_decoding3 = F(H,11490*1e-6)*U_decoding3;

load twqubit_C590_Ufid.mat
U_decoding3 = expm(-i*pi/2*KIz{5})*U*expm(i*pi/2*KIz{5})*U_decoding3;   

disp('U_decoding3_grape finished')

 rho_decoding3_grape = U_decoding3*rho_decoding2_grape*U_decoding3';
 
 U_decoding3_grape = U_decoding3;
 
 save  U_decoding3_grape.mat  U_decoding3_grape
 save rho_decoding3_grape.mat rho_decoding3_grape


th1 = (Para(1,1)-20696)*2*pi*(3360*1e-6);  A1=(cos(th1)-i*sin(th1));
th5 = (Para(5,5)-20696)*2*pi*(3360*1e-6);  A5=(cos(th5)-i*sin(th5));
th6 = (Para(6,6)-20696)*2*pi*(3360*1e-6);  A6=(cos(th6)-i*sin(th6));
th7 = (Para(7,7)-20696)*2*pi*(15280*1e-6);  A7=(cos(th7)+i*sin(th7));
% this phase is different! Because the state of C7 is X-iY but not X+iY
for ii = 8:12
    theta_C7H_evolution(ii-7) = pi*Para(7,ii)*(15280*1e-6);
    relative_phase(ii-7) = cos(theta_C7H_evolution(ii-7))+i*sin(theta_C7H_evolution(ii-7)); % because C7 is X-iY so the phase is plus
    A7 = relative_phase(ii-7)*A7;
end

th5_new = (Para(5,5)-20696)*2*pi*(13340*1e-6);  
A5_new=(cos(th5_new)+i*sin(th5_new));
theta_C45 = pi*Para(4,5)*(13340*1e-6); theta_C56 = pi*Para(5,6)*(13340*1e-6);theta_C15 = pi*Para(1,5)*(13340*1e-6); theta_C35 = pi*Para(3,5)*(13340*1e-6);
A5_new = (cos(theta_C15)+i*sin(theta_C15))*(cos(theta_C35)+i*sin(theta_C35))*(cos(theta_C45)+i*sin(theta_C45))*(cos(theta_C56)+i*sin(theta_C56))*A5_new;
for ii = 8:12
    theta_C5H_evolution(ii-7) = pi*Para(5,ii)*(13340*1e-6);
    relative_phase(ii-7) = cos(theta_C5H_evolution(ii-7))+i*sin(theta_C5H_evolution(ii-7)); % because C5 is X-iY so the phase is plus
    A5_new = relative_phase(ii-7)*A5_new;
end

Ip=Ix+i*Iy; Im=Ix-i*Iy; Zp = Iz+I/2; Zm = Iz-I/2;

Test_state3 = (A1*A5*A6*A7*A5_new*gop(7,Im) + A1'*A5'*A6'*A7'*A5_new'*gop(7,Ip))*gop(1,Zp)*gop(2,Zp)*gop(3,Zp)*gop(4,Zp)*gop(5,Zp)*gop(6,Zp)*gop(8,Zp)*gop(9,Zp)*gop(10,Zp)*gop(11,Zp)*gop(12,Zp);
Test_state3 = Test_state3/sqrt(2);

Fidelity=trace(Test_state3*rho_decoding3_grape); %/sqrt(trace(Test_state3^2)*trace(rho_decoding3_grape^2)) 
f(3) = Fidelity
%%% FIDELITY AT THIS POINT IS --->  0.4220 phase: 0.9908+0.1357i angel 0.1361 Z rotation. NO 0.1982 - 0.5598i -1.2305 Z rotation
%% New state rho_12pps_grape

% abs 0.6060 for circuit, 0.5939 for grape 


%% Compare the state fidelity before and after phase correction
A0 = 0.5018/0.6453-0.4057/0.6453*i;

% load rho_decoding1_grape.mat
% 
% th1 = (Para(1,1)-20696)*2*pi*(3360*1e-6);  A1=(cos(th1)-i*sin(th1));
% th5 = (Para(5,5)-20696)*2*pi*(3360*1e-6);  A5=(cos(th5)-i*sin(th5));
% th6 = (Para(6,6)-20696)*2*pi*(3360*1e-6);  A6=(cos(th6)-i*sin(th6));
% 
% Test_state1 = (A0*A1*A5*A6*gop(1,Ix+i*Iy)*gop(2,Ix-i*Iy)*gop(3,Ix-i*Iy)*gop(4,Ix-i*Iy)*gop(5,Ix+i*Iy)*gop(6,Ix+i*Iy)*gop(7,Ix-i*Iy) + A0'*A1'*A5'*A6'*gop(1,Ix-i*Iy)*gop(2,Ix+i*Iy)*gop(3,Ix+i*Iy)*gop(4,Ix+i*Iy)*gop(5,Ix-i*Iy)*gop(6,Ix-i*Iy)*gop(7,Ix+i*Iy))*gop(8,Iz+I/2)*gop(9,Iz+I/2)*gop(10,Iz+I/2)*gop(11,Iz+I/2)*gop(12,Iz+I/2);
% Test_state1 = R(gop(1,X)+gop(3,X)+gop(4,X)+gop(6,X),90)*Test_state1*R(gop(1,X)+gop(3,X)+gop(4,X)+gop(6,X),90)';
% Test_state1 = Test_state1/sqrt(2);
% 
% Fidelity=trace(Test_state1*rho_decoding1_grape) %/sqrt(trace(Test_state1^2)*trace(rho_decoding1_grape^2))  
% Fidelity2=trace(abs(Test_state1)*abs(rho_decoding1_grape)) 

load rho_decoding2_grape.mat

th1 = (Para(1,1)-20696)*2*pi*(3360*1e-6);  A1=(cos(th1)-i*sin(th1));
th5 = (Para(5,5)-20696)*2*pi*(3360*1e-6);  A5=(cos(th5)-i*sin(th5));
th6 = (Para(6,6)-20696)*2*pi*(3360*1e-6);  A6=(cos(th6)-i*sin(th6));
th7 = (Para(7,7)-20696)*2*pi*(15280*1e-6);  A7=(cos(th7)+i*sin(th7));
% this phase is different! Because the state of C7 is X-iY but not X+iY

for ii = 8:12
    theta_C7H_evolution(ii-7) = pi*Para(7,ii)*(15280*1e-6);
    relative_phase(ii-7) = cos(theta_C7H_evolution(ii-7))+i*sin(theta_C7H_evolution(ii-7)); % because C7 is X-iY so the phase is plus
    A7 = relative_phase(ii-7)*A7;
end

Ip=Ix+i*Iy; Im=Ix-i*Iy; Zp = Iz+I/2; Zm = Iz-I/2;

Test_state2 = (A0*A1*A5*A6*A7*gop(2,Ip)*gop(5,Im)*gop(7,Im) + A0'*A1'*A5'*A6'*A7'*gop(2,Im)*gop(5,Ip)*gop(7,Ip))*gop(1,Zp)*gop(3,Zp)*gop(4,Zp)*gop(6,Zp)*gop(8,Zp)*gop(9,Zp)*gop(10,Zp)*gop(11,Zp)*gop(12,Zp);
Test_state2 = R(gop(2,X),90)*Test_state2*R(gop(2,X),90)';
Test_state2 = Test_state2/sqrt(2);

Fidelity=trace(Test_state2*rho_decoding2_grape) %/sqrt(trace(Test_state2^2)*trace(rho_decoding2_grape^2))  
Fidelity2=trace(abs(Test_state2)*abs(rho_decoding2_grape)) 


load rho_decoding3_grape.mat

th1 = (Para(1,1)-20696)*2*pi*(3360*1e-6);  A1=(cos(th1)-i*sin(th1));
th5 = (Para(5,5)-20696)*2*pi*(3360*1e-6);  A5=(cos(th5)-i*sin(th5));
th6 = (Para(6,6)-20696)*2*pi*(3360*1e-6);  A6=(cos(th6)-i*sin(th6));
th7 = (Para(7,7)-20696)*2*pi*(15280*1e-6);  A7=(cos(th7)+i*sin(th7));
% this phase is different! Because the state of C7 is X-iY but not X+iY

for ii = 8:12
    theta_C7H_evolution(ii-7) = pi*Para(7,ii)*(15280*1e-6);
    relative_phase(ii-7) = cos(theta_C7H_evolution(ii-7))+i*sin(theta_C7H_evolution(ii-7)); % because C7 is X-iY so the phase is plus
    A7 = relative_phase(ii-7)*A7;
end

th5_new = (Para(5,5)-20696)*2*pi*(13340*1e-6);  
A5_new=(cos(th5_new)+i*sin(th5_new));
theta_C45 = pi*Para(4,5)*(13340*1e-6); theta_C56 = pi*Para(5,6)*(13340*1e-6);theta_C15 = pi*Para(1,5)*(13340*1e-6); theta_C35 = pi*Para(3,5)*(13340*1e-6);
A5_new = (cos(theta_C15)+i*sin(theta_C15))*(cos(theta_C35)+i*sin(theta_C35))*(cos(theta_C45)+i*sin(theta_C45))*(cos(theta_C56)+i*sin(theta_C56))*A5_new;
for ii = 8:12
    theta_C5H_evolution(ii-7) = pi*Para(5,ii)*(13340*1e-6);
    relative_phase(ii-7) = cos(theta_C5H_evolution(ii-7))+i*sin(theta_C5H_evolution(ii-7)); % because C5 is X-iY so the phase is plus
    A5_new = relative_phase(ii-7)*A5_new;
end

Ip=Ix+i*Iy; Im=Ix-i*Iy; Zp = Iz+I/2; Zm = Iz-I/2;

Test_state3 = (A0*A1*A5*A6*A7*A5_new*gop(7,Im) + A0'*A1'*A5'*A6'*A7'*A5_new'*gop(7,Ip))*gop(1,Zp)*gop(2,Zp)*gop(3,Zp)*gop(4,Zp)*gop(5,Zp)*gop(6,Zp)*gop(8,Zp)*gop(9,Zp)*gop(10,Zp)*gop(11,Zp)*gop(12,Zp);
Test_state3 = Test_state3/sqrt(2);

Fidelity=trace(Test_state3*rho_decoding3_grape) %/sqrt(trace(Test_state3^2)*trace(rho_decoding3_grape^2)) 
Fidelity2=trace(abs(Test_state3)*abs(rho_decoding3_grape)) %/sqrt(trace(Test_state3^2)*trace(rho_decoding3_grape^2)) 