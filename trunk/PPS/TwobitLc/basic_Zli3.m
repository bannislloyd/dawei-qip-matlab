% 总的输入模块
clear
clc
% THREADS = 2; 
% N qubit
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,Ix1,Iy1,Iz1,Ix2,Iy2,Iz2]=pauliform(2);

% H0
% w1=1000;w2=-2000;J=50;
% H_0=w1*KIz(:,:,1)+w2*KIz(:,:,2)+J*KIz(:,:,1)*KIz(:,:,2);
% H_0=H_0*2*pi;

% H 参数
% w1 = 3706;	w2 = 3881;	w3 = 3931;
% J12 = 8;	J23 = 1.4;	J13 = 8;
% D12 = -1382;	D23 = -295;	D13 = -1191;
% 
% o1=w2;
% w1=w1-o1;w2=w2-o1;w3=w3-o1;

% LDW
% w1=2335.5; w2=2456.3; w3=2495.6;          %化学位移参数
% D12=-3215.8; D23=-669.6; D13=-2648.2;      %dipole耦合参数
% J12=8; J23=1.4; J13=8;                    %J耦合参数
%  
% %液晶耦合的哈密顿量
% H =
% (w1*Iz1+w2*Iz2+w3*Iz3)+D12*(Iz1*Iz2-Ix1*Ix2/2-Iy1*Iy2/2)+D23*(Iz2*Iz3-Ix2*Ix3/2-Iy
% 2*Iy3/2)+D13*(Iz1*Iz3-Ix1*Ix3/2-Iy1*Iy3/2)+...
%       J12*Iz1*Iz2+J23*Iz2*Iz3+J13*Iz1*Iz3; 

w1 = 2597.8451; w2 = 2508.4940;
D = 434.2611;
J = 2.26;

o1=(w1+w2)/2;
w1=w1-o1;w2=w2-o1;
%液晶耦合的哈密顿量

Hint = 2*pi*((w1*Iz1+w2*Iz2)+D*(Iz1*Iz2-Ix1*Ix2/2-Iy1*Iy2/2)+J*Iz1*Iz2);






TotalTime=6000e-6;
dt=100e-6;
Step=round(TotalTime/dt);


eps=1e4;

% Power Limit
MaxPower=9100;

% Starting Guess
PowerX=MaxPower*(rand(1,Step)-0.5)*2*0.2;
PowerY=MaxPower*(rand(1,Step)-0.5)*2*0.2;

% load PowerX
% load PowerY

filename='PPS.txt';


Qtarget=0.98;

% AA=[1 0 0 0;0 1 0 0;0 0 0 1;0 0 1 0];
% Utarget=kron(AA,II);

% Calculating...
[PowX,PowY,Q,Ufinal]=calCore(Qtarget,PowerX,PowerY,Hint,dt,eps,MaxPower);

[MaxPower_Hz,Time_us]=creat(PowX,PowY,filename,TotalTime)
% MaxPower
% TotalTime=TotalTime*1e6

 Rin=Iz1+Iz2
 Rot=Gz(Ufinal*Rin*Ufinal')
 Rtg=zeros(4,4);Rtg(1,1)=1;Rtg=Rtg-eye(4)/4;
 F=trace(Rot*Rtg)/sqrt( trace(Rot*Rot)*trace(Rtg*Rtg) )
 
 % 归一化&画图
 RR=Rot/Rot(1,1)*0.75+eye(4)/4
 bar3(real(RR))
 