clc
clear all

%%%%%%% EXPERIMENT %%%%%%%%%%%%%

[Ix,Iy,Iz,IHx,IHy,IHz,sIHz] = prodop(1,1);

Omega=1;
H=kron(Omega*Ix,eye(3));

A=[1; 0 ;0];
B=[0; 1 ;0];
C=[0; 0 ;1];

x1=[0 0 1;1 0 0; 0 1 0];

x2=[0 1 0;0 0 1; 1 0 0];
L1=eye(3);
Cgate=kron(A*A',L1)+kron(B*B',x1)+kron(C*C',x2); Cgate=increase_dim(Cgate);

load Cgate.mat

INDM=kron([1 0 0; 0 0 0; 0 0 0],[1 0 0; 0 0 0; 0 0 0]); INDM=increase_dim(INDM);

% tau=0:.2:2*pi/Omega;
% tau=[1.3 2.115 3.155 4.168 4.98 6.28]
tau=4.98;
% length(tau)

% error_tol = 0.03;
% N_exp = 100;

for l=1:length(tau)
    %%%% Defininig Times %%%%%%%
    t1 = pi/Omega; t2 = tau(l)+t1; t3 = tau(l)+t2;

    Ut1t0 = increase_dim(genU(0,t1,H));   Ut2t1 = increase_dim(genU(t1,t2,H));
    Ut3t2 = increase_dim(genU(t2,t3,H));  Ut3t1 = increase_dim(genU(t1,t3,H));
    Ut2t0 = increase_dim(genU(0,t2,H));
    
%    load Max_Us.mat
   load Ut1t0_gate.mat
   Ut1t0 = abc;
       Ut3t2 = increase_dim(genU(t2,t3,H));  Ut3t1 = increase_dim(genU(t1,t3,H));

    
    %%% C12
    R1 = Ut1t0*INDM*Ut1t0';
    R2 = Cgate*R1*Cgate';
    diag(Ut2t1*R2*Ut2t1')
    R3 = diag(decrease_dim(Ut2t1*R2*Ut2t1'))';
    C12 = R3*[1;-1;-1;-1;1;1;-1;1;1];
%     for j=1:N_exp;
%         eR3 = inc_error(R3,error_tol);
%         eC12(j) = eR3*[1;-1;-1;-1;1;1;-1;1;1];
%     end
    
    %%% C23
    R1 = Ut2t0*INDM*Ut2t0' ;
    R2 = Cgate*R1*Cgate';
    R3 = diag(decrease_dim(Ut3t2*R2*Ut3t2'))';
    C23 = R3*[1;-1;-1;-1;1;1;-1;1;1];
%     for j=1:N_exp;
%         eR3 = inc_error(R3,error_tol);
%         eC23(j) = eR3*[1;-1;-1;-1;1;1;-1;1;1];
%     end
       
       %%% C13
    R1 = Ut1t0*INDM*Ut1t0' ;
    R2 = Cgate*R1*Cgate';
    R3 = diag(decrease_dim(Ut3t1*R2*Ut3t1'))';
    C13 = R3*[1;-1;-1;-1;1;1;-1;1;1];
%     for j=1:N_exp;
%         eR3 = inc_error(R3,error_tol);
%         eC13(j) = eR3*[1;-1;-1;-1;1;1;-1;1;1];
%     end
%     
    K(l) = C12 + C23 - C13;
%     for j=1:N_exp
%         eK(l,j) = eC12(j) + eC23(j) - eC13(j);
%     end   
end



% K_std = std(eK');
% K_mean = mean(eK');
%  
% subplot(2,2,3)
% title('[ Pi-0.03,  Pi+0.03 ]')
hold on
plot(tau,K,'bo')
% errorbar(tau,K_mean,K_std,'r.')
tau=0:.2:2*pi/Omega;
plot(tau,1.5*ones(length(tau),1),'r')
plot(tau,1.7565*ones(length(tau),1),'b')
tau=0:.001:2*pi/Omega;
K3=1/16 + 2*cos(Omega*tau) - 5/4*cos(2*Omega*tau) + 3/16*cos(4*Omega*tau);

plot(tau,K3,'k')

