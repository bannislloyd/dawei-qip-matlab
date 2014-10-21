clear all
clc

[Ix,Iy,Iz,IHx,IHy,IHz,sIHz] = prodop(1/2,1);

Omega=1;

H=Omega*Ix;

state0 = [1; 0]; state0=state0*state0';
state1 = [0; 1]; state1=state1*state1';


%%%%% Initial State %%%%%%%%%
Rho_in =  state0;

%%%%%% Measurement Operators %%%%%%%%%%
P(:,:,1)=state0; P(:,:,2)=state1;
q(1)=-1;
q(2)=1;


tau=0:.0005:2*pi/Omega;


parfor l=1:length(tau)
    %%%% Defininig Times %%%%%%%
    t1 = pi/Omega;
    t2 = t1+tau(l);
    t3 = t2+tau(l);

    C21=0; C32=0; C31=0;
    
    for j=1:2
        for k=1:2
            C21 = C21 + q(j)*q(k)*trace(P(:,:,j)*genU(t1,t2,H)*P(:,:,k)*genU(0,t1,H)*Rho_in*(genU(0,t1,H))'*P(:,:,k)*(genU(t1,t2,H))');
            C32 = C32 + q(j)*q(k)*trace(P(:,:,j)*genU(t2,t3,H)*P(:,:,k)*genU(0,t2,H)*Rho_in*(genU(0,t2,H))'*P(:,:,k)*(genU(t2,t3,H))');
            C31 = C31 + q(j)*q(k)*trace(P(:,:,j)*genU(t1,t3,H)*P(:,:,k)*genU(0,t1,H)*Rho_in*(genU(0,t1,H))'*P(:,:,k)*(genU(t1,t3,H))');
        end
    end
    K(l) = C21 + C32 - C31;
end

max(K)
plot(K)
hold on 
plot(1.5*ones(length(tau),1),'r')
% plot(1.7565*ones(length(tau),1),'g')

K3=2*cos(Omega*tau)-cos(2*Omega*tau);

plot(K3,'r')



