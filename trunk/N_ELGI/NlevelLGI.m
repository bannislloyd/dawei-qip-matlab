clear all
clc

tic
[Ix,Iy,Iz,IHx,IHy,IHz,sIHz] = prodop(1,1);


Omega=1;
H=Omega*Ix;

state0 = [1; 0 ; 0];  state1 = [0; 1 ; 0]; state2 = [0; 0 ; 1]; 
state1=state1*state1'; state0=state0*state0'; state2=state2*state2';

%%%%% Initial State %%%%%%%%%
Rho_in =  state0;
%%%%%% Measurement Operators %%%%%%%%%%
P(:,:,1)=state0; P(:,:,2)=state1; P(:,:,3)=state2;

%%%%% Measurement Results %%%%%%%%%%%%%%
q(1)=-1; q(2)=1; q(3)=1;

tau=0:.1:2*pi/Omega;
for l=1:length(tau)
%%%% Defininig Times %%%%%%%
    t1 = pi/Omega; t2 = tau(l)+t1; t3 = tau(l)+t2;

    C21=0; C32=0; C31=0;
    Ut1t0 = genU(0,t1,H);   Ut2t1 = genU(t1,t2,H);
    Ut3t2 = genU(t2,t3,H);  Ut3t1 = genU(t1,t3,H);
    Ut2t0 = genU(0,t2,H);

    for j=1:3
        for k=1:3
            C21 = C21 + q(j)*q(k)*trace(P(:,:,j)*Ut2t1*P(:,:,k)*Ut1t0*Rho_in*Ut1t0'*P(:,:,k)*Ut2t1');
            C32 = C32 + q(j)*q(k)*trace(P(:,:,j)*Ut3t2*P(:,:,k)*Ut2t0*Rho_in*Ut2t0'*P(:,:,k)*Ut3t2');
            C31 = C31 + q(j)*q(k)*trace(P(:,:,j)*Ut3t1*P(:,:,k)*Ut1t0*Rho_in*Ut1t0'*P(:,:,k)*Ut3t1');
        end
    end

    K(l) = C21 + C32 - C31;

end

max(K)
figure
plot(K,'bo')
hold on 
plot(1.5*ones(length(tau),1),'r')
plot(1.7565*ones(length(tau),1),'g')

K3=1/16 + 2*cos(Omega*tau) -5/4*cos(2*Omega*tau) + 3/16*cos(4*Omega*tau);

plot(K3,'r')

toc

