clear;
clc;
s0 = [1;0;];
s1 = [0;1;];
s(:,:,1) = kron(kron(s0,s0),kron(s0,s0));
% s(:,:,2)=  kron(kron(s0,s0),kron(s0,s1));
% s(:,:,3) = kron(kron(s0,s0),kron(s1,s0));
% s(:,:,4) = kron(kron(s0,s0),kron(s1,s1));

s(:,:,2) = kron(kron(s0,s1),kron(s0,s0));
% s(:,:,6) = kron(kron(s0,s1),kron(s0,s1));
% s(:,:,7) = kron(kron(s0,s1),kron(s1,s0));
% s(:,:,8) = kron(kron(s0,s1),kron(s1,s1));

s(:,:,3) =  kron(kron(s1,s0),kron(s0,s0));
% s(:,:,10) = kron(kron(s1,s0),kron(s0,s1));
% s(:,:,11) = kron(kron(s1,s0),kron(s1,s0));
% s(:,:,12) = kron(kron(s1,s0),kron(s1,s1));

s(:,:,4) = kron(kron(s1,s1),kron(s0,s0));
% s(:,:,14) = kron(kron(s1,s1),kron(s0,s1));
% s(:,:,15) = kron(kron(s1,s1),kron(s1,s0));
% s(:,:,16) = kron(kron(s1,s1),kron(s1,s1));




%%% erorrs  
dx=[0 1
    1 0];
dy=[0 -i
    i 0];
dz=[1 0
    0 -1];
E2=eye(2,2);
E4=eye(4,4);
E8=eye(8,8);

X1 = kron(dx,E8);           Y1 =  kron(dy,E8);           Z1 =  kron(dz,E8); 
X2 = kron(E2,kron(dx,E4));  Y2 =  kron(E2,kron(dy,E4));  Z2 =  kron(E2,kron(dz,E4));
X3 = kron(E4,kron(dx,E2));  Y3 =  kron(E4,kron(dy,E2));  Z3 =  kron(E4,kron(dz,E2));
X4 = kron(E8,dx);           Y4 = kron(E8,dy);            Z4 = kron(E8,dz);  


[U_de1]=QEC_442_de1;
 U_en = U_de1';             %%%% for all decoding

 [U_de]=QEC_442_de2;
 %%% error at 2
 for k = 1:4;
     
 s_out_errE2(:,:,k) = (U_de*U_en)*s(:,:,k);
 s_out_errX2(:,:,k) = (U_de*X2*U_en)*s(:,:,k);
 s_out_errY2(:,:,k) = (U_de*Y2*U_en)*s(:,:,k);
 s_out_errZ2(:,:,k) = (U_de*Z2*U_en)*s(:,:,k);
 end
