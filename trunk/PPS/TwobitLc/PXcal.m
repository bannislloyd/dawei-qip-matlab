function [Pcal,Xcal]=PXcal(Utarget,PowerX,PowerY,H_0,dt);

Kbit=log2(length(H_0));
[Sx,Sy,Sz,Ix,Iy,Iz,Si,II,KIx,KIy,KIz,st0,st1] = PauliMatrix(Kbit);
% global KIx KIy H_0 dt
N=length(PowerX);


for j=1:N
%     
%     PulseX=Power(j)*cos(Phase(j));
%     PulseY=Power(j)*sin(Phase(j));
    
    H_ext=0;
    for j2=1:Kbit
%         H_ext=-PowerX(j)*KIx(:,:,j2)+PowerY(j)*KIy(:,:,j2)+H_ext;
        H_ext=PowerX(j)*KIx(:,:,j2)+PowerY(j)*KIy(:,:,j2)+H_ext;
    end
    H_ext=H_ext*2*pi;
    
    Upx1(:,:,j)=expm(-i*(H_0+H_ext)*dt);
%     Upx2(:,:,j)=expm(i*(H_0+H_ext)*dt);
    Upx2(:,:,j)=Upx1(:,:,j)';
end

Xcal(:,:,1)=Upx1(:,:,1);

for j=2:N
    Xcal(:,:,j)=Upx1(:,:,j)*Xcal(:,:,j-1);
end

Pcal(:,:,N)=Utarget;

for j=N-1:-1:1
    Pcal(:,:,j)=Upx2(:,:,j+1)*Pcal(:,:,j+1);
end
% PPcal=Pcal;
% XXcal=Xcal;
end