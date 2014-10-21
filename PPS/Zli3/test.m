Nbit=3;
% global Sx Sy Sz Ix Iy Iz Si II KIx KIy KIz H_0 dt eps
[Sx,Sy,Sz,Ix,Iy,Iz,Si,II,KIx,KIy,KIz,st0,st1] = PauliMatrix(Nbit);

% H0
% w1=1000;w2=-2000;J=50;
% H_0=w1*KIz(:,:,1)+w2*KIz(:,:,2)+J*KIz(:,:,1)*KIz(:,:,2);
% H_0=H_0*2*pi;

% H ²ÎÊý
w1=2335.5; w2=2456.3; w3=2495.6;
J12 = 8;	J23 = 1.4;	J13 = 8;
D12=-3215.8/2; D23=-669.6/2; D13=-2648.2/2; 

% o1=w2;
% w1=w1-o1;w2=w2-o1;w3=w3-o1;

Hint = 2*pi*w1*kron3(Iz,II,II) + 2*pi*w2*kron3(II,Iz,II) + 2*pi*w3*kron3(II,II,Iz) +...
     2*pi*J12*kron3(Iz,Iz,II) + 2*pi*J13*kron3(Iz,II,Iz) + 2*pi*J23*kron3(II,Iz,Iz) + ...
     2*pi*D12*(2*kron3(Iz,Iz,II)-kron3(Ix,Ix,II)-kron3(Iy,Iy,II)) +...
     2*pi*D13*(2*kron3(Iz,II,Iz)-kron3(Ix,II,Ix)-kron3(Iy,II,Iy)) +...
     2*pi*D23*(2*kron3(II,Iz,Iz)-kron3(II,Ix,Ix)-kron3(II,Iy,Iy)) ;
 
load PowerX
load PowerY

PowX=PowerX;
PowY=PowerY;

TotalTime=600e-6;
dt=10e-6;
Step=round(TotalTime/dt);

Rin=KIz(:,:,1)+KIz(:,:,3)+KIz(:,:,2);

for ii=1:Step
    
    H_ext=0;
    for j2=1:Nbit
        H_ext=PowX(ii)*KIx(:,:,j2)+PowY(ii)*KIy(:,:,j2)+H_ext;
    end
    H_ext=H_ext*2*pi;
    U=expm(-i*(Hint+H_ext)*dt);
    Rin=U*Rin*U';
end

%  Rot=Gz(Rin)
 Rot=Gz(Rin);

 Rtg=zeros(8,8);Rtg(1,1)=1;Rtg=Rtg-eye(8)/8;
 
 F=trace(Rot*Rtg)/sqrt( trace(Rot*Rot)*trace(Rtg*Rtg) )
 
 RR=Rot/Rot(1,1)*0.875+eye(8)/8
 bar3(real(RR))