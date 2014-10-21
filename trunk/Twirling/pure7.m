clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

rho_ini = KIz{7};

load Usim.mat

rho_final = rot(KIy{2},pi/2)*Usim*rho_ini*(rot(KIy{2},pi/2)*Usim)';

% trace(rho_final*KIz{1}*KIx{2}*KIz{3}*KIz{4}*KIz{5}*KIz{6}*KIz{7})

save rho_final.mat rho_final