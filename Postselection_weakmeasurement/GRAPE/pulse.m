% GRAPE for TCE;
clear;
global H_int Uideal M t I Ix Iy Iz;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);
I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2;

load Para.mat
load U_pps.mat
load Toffoli.mat



%Uideal=rot(KIx{1},pi/2);
Uideal=Toffoli;
%Uideal=U1^3;

M=input('Please enter the steps\n');
t=input('Please enter the evolution time for each step\n');

% Initial Guess;
x=0:1:4*M/10;xx=0:0.1:4*M/10;
B=1000-2000*rand(1,4*M/10+1);
B=spline(x,B,xx);
B=B(1:4*M);

% Optimization Function: Fmincon;
% Optimization Conditions;
Aeq=zeros(4*M,4*M); 
Aeq(1,1)=1;
Aeq(M,M)=1;
Aeq(M+1,M+1)=1;
Aeq(2*M,2*M)=1;
Aeq(2*M+1,2*M+1)=1;
Aeq(3*M,3*M)=1;
Aeq(3*M+1,3*M+1)=1;
Aeq(4*M,4*M)=1;
beq=zeros(1,4*M);
lb=-4000*ones(1,4*M);
ub=4000*ones(1,4*M);
options=optimset('Algorithm','Interior-Point','SubproblemAlgorithm','ldl-factorization','MaxFunEvals',10000,'AlwaysHonorConstraints','bounds','GradObj','on','Hessian','lbfgs','LineSearchType','quadcubic','MaxIter',1000,'display','iter');
[B,fval]=fmincon(@Fidelity,B,[],[],Aeq,beq,lb,ub,[],options);

