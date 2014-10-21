function [Pow,Pha,QQ,Ufinal]=calCore(Qtarget,PowerX,PowerY,H_0,dt,eps,MaxPower)


% global Sx Sy Sz Ix Iy Iz Si II KIx KIy KIz H_0 dt eps
Kbit=log2(length(H_0));
[Sx,Sy,Sz,Ix,Iy,Iz,Si,II,KIx,KIy,KIz,st0,st1] = PauliMatrix(Kbit);
N=length(PowerX);

Rin=KIz(:,:,1)+KIz(:,:,3)+KIz(:,:,2);

% Rin=[1.1044         0         0         0         0         0         0         0
%          0    0.0537    0.0816         0   -0.2517         0         0         0
%          0    0.0816   -0.0638         0   -0.2374         0         0         0
%          0         0         0   -0.1508         0   -0.0631    0.0147         0
%          0   -0.2517   -0.2374         0   -0.4811         0         0         0
%          0         0         0   -0.0631         0    0.0744   -0.0054         0
%          0         0         0    0.0147         0   -0.0054    0.0939         0
%          0         0         0         0         0         0         0   -0.6307];

% Rin=[1.2035 - 0.0000i        0                  0                  0                  0                  0          0 0
%         0            -0.1513 + 0.0000i  -0.1034 + 0.0060i        0             0.0687 - 0.0096i        0          0 0
%         0            -0.1034 - 0.0060i  -0.0994 - 0.0000i        0            -0.0319 - 0.0236i        0          0 0
%         0                  0                  0            -0.1687 + 0.0000i        0            -0.0245 + 0.0036i  -0.0192 + 0.0007i        0      
%         0             0.0687 + 0.0096i  -0.0319 + 0.0236i        0            -0.2700 - 0.0000i        0          0 0
%         0                  0                  0            -0.0245 - 0.0036i        0            -0.1135 + 0.0000i 0.1357 - 0.0167i        0       
%         0                  0                  0            -0.0192 - 0.0007i        0            -0.1357 + 0.0167i -0.1497 + 0.0000i        0         
%         0                  0                  0                  0                  0                  0                0            -0.2509   ];


Utarget=eye(2^Kbit);

% Q=0;
tensr=0;

Qsave=0.97;

HKx=0;HKy=0;
for j2=1:Kbit
    HKx=KIx(:,:,j2)+HKx;
    HKy=KIy(:,:,j2)+HKy;
end

% Q=0;
Step=length(PowerX);


    [Pcal,Xcal]=PXcal(Utarget,PowerX,PowerY,H_0,dt);
%     Q=abs(trace(Utarget'*Xcal(:,:,N)))/(2^Kbit);
%     Fidelity=Q
Q=0;    
%     for j2=1:Kbit
%         H_ext=PowerX(j)*KIx(:,:,j2)+PowerY(j)*KIy(:,:,j2)+H_ext;
%     end
%     H_ext=H_ext*2*pi;
%     
%     Upx1(:,:,j)=expm(-i*(H_0+H_ext)*dt);

StepLimit=2000;

while Q<Qtarget
% while Q<0.95

    
    for j=1:N
        
    H_ext=0;
    for j2=1:Kbit
        H_ext=PowerX(j)*KIx(:,:,j2)+PowerY(j)*KIy(:,:,j2)+H_ext;
    end
    H_ext=H_ext*2*pi;
    Uj=expm(-i*(H_0+H_ext)*dt);
    
    H_ext=0;
    for j2=1:Kbit
        H_ext=(PowerX(j)+1)*KIx(:,:,j2)+PowerY(j)*KIy(:,:,j2)+H_ext;
    end
    H_ext=H_ext*2*pi;
    UjX=expm(-i*(H_0+H_ext)*dt);
    
    H_ext=0;
    for j2=1:Kbit
        H_ext=PowerX(j)*KIx(:,:,j2)+(PowerY(j)+1)*KIy(:,:,j2)+H_ext;
    end
    H_ext=H_ext*2*pi;
    UjY=expm(-i*(H_0+H_ext)*dt);
    
    Uf=Utarget;
    UA=Uj'*Xcal(:,:,j);
    UB=Uf*Pcal(:,:,j)';
        
    Uold=UB*Uj*UA;
    Rold=Uold*Rin*Uold';
    
    UnewX=UB*UjX*UA;
    UnewY=UB*UjY*UA;
    
    RnewX=UnewX*Rin*UnewX';
    RnewY=UnewY*Rin*UnewY';
    
    Rtg=zeros(8,8);Rtg(1,1)=1;Rtg=Rtg-eye(8)/8;
    
    Rold=Gz(Rold);RnewX=Gz(RnewX);RnewY=Gz(RnewY);
%     Rold=Rold.*eye(8);
%     RnewX=RnewX.*eye(8);
%     RnewY=RnewY.*eye(8);

%     Rold=real(Rold);RnewX=real(RnewX);RnewY=real(RnewY);
    
    Fold=trace(Rold*Rtg)/sqrt( trace(Rold*Rold)*trace(Rtg*Rtg) );
    FnewX=trace(RnewX*Rtg)/sqrt( trace(RnewX*RnewX)*trace(Rtg*Rtg) );
    FnewY=trace(RnewY*Rtg)/sqrt( trace(RnewY*RnewY)*trace(Rtg*Rtg) );
        
        dx(j)=eps*(FnewX-Fold);
        dy(j)=eps*(FnewY-Fold);
        
        MP=(PowerX(j)+dx(j))^2+(PowerY(j)+dy(j))^2;
        if MP>MaxPower^2
            dx(j)=0;
            dy(j)=0;
        end




    end

    PowerX=PowerX+dx;
    PowerY=PowerY+dy;

    
    [Pcal,Xcal]=PXcal(Utarget,PowerX,PowerY,H_0,dt);
    FA=Q;Q=Fold;
    
    if Q-FA<1e-6
    Q=0;
    PowerX=MaxPower*(rand(1,Step)-0.5)*2;
    PowerY=MaxPower*(rand(1,Step)-0.5)*2;
    [Pcal,Xcal]=PXcal(Utarget,PowerX,PowerY,H_0,dt);
    end
    
    tensr=tensr+1;
    if tensr>10
        Fidelity=real(Q)
        tensr=tensr-10;
    end
    
    if Q>Qsave
        save PowerX
        save PowerY
        Qsave=Q;
    end
    
    StepLimit=StepLimit-1;
    
    if StepLimit<10
        StepLimit=2000;
        PowerX=MaxPower*(rand(1,Step)-0.5)*2;
        PowerY=MaxPower*(rand(1,Step)-0.5)*2;
        [Pcal,Xcal]=PXcal(Utarget,PowerX,PowerY,H_0,dt);
        Q=0;
%         Q=abs(trace(Utarget'*Xcal(:,:,N)))/(2^Kbit);
%         Fidelity=Q        
    end
    

    
end
Ufinal=Xcal(:,:,N);
Pow=PowerX;
Pha=PowerY;
QQ=Q;
end