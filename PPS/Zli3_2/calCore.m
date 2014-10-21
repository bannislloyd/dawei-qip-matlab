function [Pow,Pha,QQ,Ufinal]=calCore(Qtarget,PowerX,PowerY,H_0,dt,eps,MaxPower)


% global Sx Sy Sz Ix Iy Iz Si II KIx KIy KIz H_0 dt eps
Kbit=log2(length(H_0));
[Sx,Sy,Sz,Ix,Iy,Iz,Si,II,KIx,KIy,KIz,st0,st1] = PauliMatrix(Kbit);
N=length(PowerX);

Rin=KIz(:,:,1)+KIz(:,:,3)+KIz(:,:,2);
Utarget=eye(2^Kbit);

Q=0;
tensr=0;
Qsave=0.99;
StepLimit=2000;

HKx=0;HKy=0;
for j2=1:Kbit
    HKx=KIx(:,:,j2)+HKx;
    HKy=KIy(:,:,j2)+HKy;
end

% Q=0;
Step=length(PowerX);


    [Pcal_1,Xcal_1]=PXcal(Utarget,PowerX(1:Step/2),PowerY(1:Step/2),H_0,dt);
    [Pcal_2,Xcal_2]=PXcal(Utarget,PowerX(1+Step/2:Step),PowerY(1+Step/2:Step),H_0,dt);




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
    
    if j<N/2+1
    Uf=Utarget;
    UA=Uj'*Xcal_1(:,:,j);
    UB=Uf*Pcal_1(:,:,j)';
        
    Uold=UB*Uj*UA;
    Rold=Uold*Rin*Uold';
    Rold=Gz(Rold);
    Rold=Xcal_2(:,:,N/2)*Rold*Xcal_2(:,:,N/2)';
    Rold=Gz(Rold);
    
    UnewX=UB*UjX*UA;
    UnewY=UB*UjY*UA;
    
    RnewX=UnewX*Rin*UnewX';
    RnewX=Gz(RnewX);
    RnewX=Xcal_2(:,:,N/2)*RnewX*Xcal_2(:,:,N/2)';
    RnewX=Gz(RnewX);
    
    RnewY=UnewY*Rin*UnewY';
    RnewY=Gz(RnewY);
    RnewY=Xcal_2(:,:,N/2)*RnewY*Xcal_2(:,:,N/2)';
    RnewY=Gz(RnewY);
    
%     RnewX=UnewX*Rin*UnewX';
%     RnewY=UnewY*Rin*UnewY';
    
    
    
    Rtg=zeros(8,8);Rtg(1,1)=1;Rtg=Rtg-eye(8)/8;

    
    Fold=trace(Rold*Rtg)/sqrt( trace(Rold*Rold)*trace(Rtg*Rtg) );
    FnewX=trace(RnewX*Rtg)/sqrt( trace(RnewX*RnewX)*trace(Rtg*Rtg) );
    FnewY=trace(RnewY*Rtg)/sqrt( trace(RnewY*RnewY)*trace(Rtg*Rtg) );
        
        dx(j)=eps*(FnewX-Fold);
        dy(j)=eps*(FnewY-Fold);
    else
        
    Uf=Utarget;
    UA=Uj'*Xcal_2(:,:,j-N/2);
    UB=Uf*Pcal_2(:,:,j-N/2)';
        
%     Uold=Xcal_2(:,:,N/2)*Uj*UA;
    Rold=Xcal_1(:,:,N/2)*Rin*Xcal_1(:,:,N/2)';
    Rold=Gz(Rold);
    Uold=UB*Uj*UA;
    Rold=Uold*Rold*Uold';
    Rold=Gz(Rold);
    
    UnewX=UB*UjX*UA;
    UnewY=UB*UjY*UA;
    
    RnewX=Xcal_1(:,:,N/2)*Rin*Xcal_1(:,:,N/2)';
    RnewX=Gz(RnewX);
    RnewX=UnewX*RnewX*UnewX';
    RnewX=Gz(RnewX);
    
    RnewY=Xcal_1(:,:,N/2)*Rin*Xcal_1(:,:,N/2)';
    RnewY=Gz(RnewY);
    RnewY=UnewY*RnewY*UnewY';
    RnewY=Gz(RnewY);
    
%     RnewX=UnewX*Rin*UnewX';
%     RnewY=UnewY*Rin*UnewY';
    
    
    
    Rtg=zeros(8,8);Rtg(1,1)=1;Rtg=Rtg-eye(8)/8;

    
    Fold=trace(Rold*Rtg)/sqrt( trace(Rold*Rold)*trace(Rtg*Rtg) );
    FnewX=trace(RnewX*Rtg)/sqrt( trace(RnewX*RnewX)*trace(Rtg*Rtg) );
    FnewY=trace(RnewY*Rtg)/sqrt( trace(RnewY*RnewY)*trace(Rtg*Rtg) );
        
        dx(j)=eps*(FnewX-Fold);
        dy(j)=eps*(FnewY-Fold);
        
    end
        
        
        MP=(PowerX(j)+dx(j))^2+(PowerY(j)+dy(j))^2;
        if MP>MaxPower^2
            dx(j)=0;
            dy(j)=0;
        end




    end

    PowerX=PowerX+dx;
    PowerY=PowerY+dy;

    [Pcal_1,Xcal_1]=PXcal(Utarget,PowerX(1:Step/2),PowerY(1:Step/2),H_0,dt);
    [Pcal_2,Xcal_2]=PXcal(Utarget,PowerX(1+Step/2:Step),PowerY(1+Step/2:Step),H_0,dt);
    FA=Q;Q=Fold;
    
    if Q-FA<1e-6
    Q=0;
    PowerX=MaxPower*(rand(1,Step)-0.5)*2;
    PowerY=MaxPower*(rand(1,Step)-0.5)*2;
    [Pcal_1,Xcal_1]=PXcal(Utarget,PowerX(1:Step/2),PowerY(1:Step/2),H_0,dt);
    [Pcal_2,Xcal_2]=PXcal(Utarget,PowerX(1+Step/2:Step),PowerY(1+Step/2:Step),H_0,dt);
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
    [Pcal_1,Xcal_1]=PXcal(Utarget,PowerX(1:Step/2),PowerY(1:Step/2),H_0,dt);
    [Pcal_2,Xcal_2]=PXcal(Utarget,PowerX(1+Step/2:Step),PowerY(1+Step/2:Step),H_0,dt);
        Q=0;
%         Q=abs(trace(Utarget'*Xcal(:,:,N)))/(2^Kbit);
%         Fidelity=Q        
    end
    

    
end
Ufinal(:,:,1)=Xcal_1(:,:,N/2);
Ufinal(:,:,2)=Xcal_2(:,:,N/2);
Pow=PowerX;
Pha=PowerY;
QQ=Q;
end