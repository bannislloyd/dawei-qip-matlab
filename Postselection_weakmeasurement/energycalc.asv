clear;
[Para,H_int] = hamiltonian_TCE;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The diagonal elements of Para: C1-C2,H1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Para = zeros(3);


Para(1,1) = 21784.629481; Para(2,2) = 20528.0490; Para(3,3) = 4546.854470; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The off-diagonal elements of Para: J-couplings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Para(1,2) = 103.03016; Para(1,3) = 8.5185; 

Para(2,3) = 201.44573; 

%%%%%%%%%%%%%%%%%% Hamilonian %%%%%%%%%%%
o1_C=0;
o1_H=0 ;
for ii = 1:2
    w(ii) = Para(ii,ii)-o1_C;
end
w(3) = Para(3,3)-o1_H;



H = 0;
for ii = 1:3
    H = H + w(ii)*KIz{ii};
end

H=H+Para(1,2)*(KIx{1}*KIx{2}+KIy{1}*KIy{2}+KIz{1}*KIz{2})+Para(1,3)*KIz{1}*KIz{3}+Para(2,3)*KIz{2}*KIz{3};
[V1,D1]=eig(H)