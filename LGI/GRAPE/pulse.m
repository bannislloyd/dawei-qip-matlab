% GRAPE for Crotonic;

%function pulse(U,H,Time,Steps)
clear;

global H_int Uideal M t I Ix Iy Iz;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);
I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2;
load Para.mat
load Cgate.mat

Uideal = Cgate;
H_int = H;

M = 5500;
t = 10e-6;
total_time = M*t;
% M=input('Please enter the steps\n');
% t=input('Please enter the evolution time for each step\n');

% Initial Guess;
%x=0:1:2*M/10;xx=0:0.1:2*M/10;
%B=1000-2000*rand(1,2*M/10+1);
%B=spline(x,B,xx);
%B=B(1:2*M);
load Cgate_guess90.mat
B = B;

% Optimization Function: Fmincon;
% Optimization Conditions;
Aeq=zeros(2*M,2*M); 
Aeq(1,1)=1;
Aeq(M,M)=1;
Aeq(M+1,M+1)=1;
Aeq(2*M,2*M)=1;

beq=zeros(1,2*M);
lb=-8000*ones(1,2*M);
ub=8000*ones(1,2*M);
options=optimset('Algorithm','Interior-Point','SubproblemAlgorithm','ldl-factorization','MaxFunEvals',10000,'AlwaysHonorConstraints','bounds','GradObj','on','Hessian','lbfgs','LineSearchType','quadcubic','MaxIter',20,'display','iter');
%[B,fval]=fmincon(@Fidelity,B,[],[],Aeq,beq,lb,ub,[],options);

for k=1:50 % iterations for optimization. Can change 7 to other numbers
            [B,fval]=fmincon(@Fidelity,B,[],[],Aeq,beq,lb,ub,[],options); % optimize B by Fidelity Function (GRAPE in subsystem)
            Bx=B(1:M); By=B(M+1:2*M);
            U_sim=U_sim_calculation(Bx, By, total_time, t);
            fidelity=abs(trace(Uideal*U_sim'))^2/4^4; disp(fidelity);
            if fidelity>0.99
                break;
            else ;
            end
end
% C
Bx=B(1:M);
By=B(M+1:2*M);
total_time= total_time; 
ref_power= 6000; 
Amp=abs(Bx+i*By)*100/ref_power; Phase=angle(Bx+i*By)*180/pi;
fid=fopen('Cgate.txt','w');
fprintf(fid, '##TITLE= %s\n','ShapedPulse');
fprintf(fid, '##JCAPM-DX= 5.00 Bruker JCAMP library\n');
fprintf(fid, '##DATA TYPE= Shape Pulses \n');
fprintf(fid, '##ORIGIN= Colm Fixed Pulses \n');
fprintf(fid, '##OWNER= %s\n', ' ');
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