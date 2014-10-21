% 0.9549 fidelity to get 000000Z at last 

clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 

load parameter.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Encoding Part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%initial state
rho_in = KIz{7}; 

load Uencoding_grape.mat

U_step1 = Uencoding_grape;
rho_step1 = U_step1*rho_in*U_step1';

% verify ZZZZZZZ
% trace(2*rho_step1*(128*KIz{1}*KIz{2}*KIz{3}*KIz{4}*KIz{5}*KIz{6}*KIz{7}))/128

%%%%%%%%%%%%%%%%%%%%%%%
Phase = cell(1,7);
 
 Y_all = gop(1,Y)+gop(2,Y)+gop(3,Y)+gop(4,Y)+gop(5,Y)+gop(6,Y)+gop(7,Y);
 X_all = gop(1,X)+gop(2,X)+gop(3,X)+gop(4,X)+gop(5,X)+gop(6,X)+gop(7,X);
 
 for ii = 1:1:7
      Phase{ii} = R(cos(2*pi/7*ii)*Y_all-sin(2*pi/7*ii)*X_all,90);
 end
 
 %state after phase cycling: highest coherence
 rho_phasecycling = 0;
 for ii = 1:7
     rho_phasecycling = Phase{ii}*rho_step1*Phase{ii}'+rho_phasecycling;
 end
 rho_phasecycling = sqrt(2)*rho_phasecycling/7;

%Test value: rho_phasecycling
% for ii = 1:128
%  off_diag(ii) = rho_phasecycling(129-ii,ii);
% end
% rho_phasecycling_ideal = eye(128);
% for jj  =1:7
%     rho_phasecycling_ideal = (KIx{jj}+i*KIy{jj})*rho_phasecycling_ideal;
% end
% 
% trace(rho_phasecycling_ideal*rho_phasecycling)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decoding Part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Udecoding_grape.mat

U_step2 = Udecoding_grape;
rho_step2 = U_step2*rho_phasecycling*U_step2';
rho_pps = rho_step2;

% verify 000000Z
theo_pps = sqrt(2)*MultiKron(7,ST0,ST0,ST0,ST0,ST0,ST0,Iz);
 abs(trace(rho_pps*theo_pps))
 
 rho_pps2 = expm(-i*pi/2*KIy{7})* rho_pps*expm(-i*pi/2*KIy{7})';
 
 save rho_pps2.mat rho_pps2




