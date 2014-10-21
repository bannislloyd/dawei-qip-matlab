clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);


load Para.mat
load U_pps.mat

Time = 2e-3;
Steps = 1000;

pulse(U_pps1,H_int,Time,Steps);