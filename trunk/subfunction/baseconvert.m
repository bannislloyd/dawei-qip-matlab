function[H,U,HD,B] = baseconvert
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,Ix1,Iy1,Iz1,Ix2,Iy2,Iz2,Ix3,Iy3,Iz3]=pauliform(3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ZLI1132的hamiltonian形式
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% w1=2335.5; w2=2456.3; w3=2495.6;          %化学位移参数
% o1 = w2;
% w1 = w1-o1;w2 = w2-o1;w3 = w3-o1;
% D12=-3215.8; D23=-669.6; D13=-2648.2;      %dipole耦合参数
% J12=8; J23=1.4; J13=8;                    %J耦合参数

w1=1945.5; w2=2094.8; w3=2147.2;          %化学位移参数
o1 = w2;
w1 = w1-o1;w2 = w2-o1;w3 = w3-o1;
D12=-3266.6; D23=-678.8; D13=-2683.4;      %dipole耦合参数
J12=8; J23=1.4; J13=8;                    %J耦合参数
 
%液晶耦合的哈密顿量
H = (w1*Iz1+w2*Iz2+w3*Iz3)+D12*(Iz1*Iz2-Ix1*Ix2/2-Iy1*Iy2/2)+D23*(Iz2*Iz3-Ix2*Ix3/2-Iy2*Iy3/2)+D13*(Iz1*Iz3-Ix1*Ix3/2-Iy1*Iy3/2)+...
      J12*Iz1*Iz2+J23*Iz2*Iz3+J13*Iz1*Iz3; 
  
%HD = 2375.48*Iz1+2466.97*Iz2+2444.95*Iz3+(-3947.62)*Iz1*Iz2+685.916*Iz2*Iz3+(-3254.5)*Iz1*Iz3




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%把H对角化，得到变换矩阵U和对角的HD,满足U'*H*U = HD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1 = eig(H);
[V1,D1] = eig(H);

%对V1重新排列，得到变换矩阵U，相应的得到本征值B的重排顺序
%以下排列是从000-111的顺序,即U(:,1)-U(:,8)分别标记为三比特的000－111态

% U(:,1) = V1(:,7);  B(1) = a1(7);
% U(:,2) = V1(:,5);  B(2) = a1(5);
% U(:,3) = V1(:,6);  B(3) = a1(6);
% U(:,4) = V1(:,4);  B(4) = a1(4);
% U(:,5) = V1(:,8);  B(5) = a1(8);
% U(:,6) = V1(:,3);  B(6) = a1(3);
% U(:,7) = V1(:,2);  B(7) = a1(2);
% U(:,8) = V1(:,1);  B(8) = a1(1);


U(:,1) = V1(:,1);  B(1) = a1(1);
U(:,2) = V1(:,3);  B(2) = a1(3);
U(:,3) = V1(:,5);  B(3) = a1(5);
U(:,4) = V1(:,7);  B(4) = a1(7);
U(:,5) = V1(:,8);  B(5) = a1(8);
U(:,6) = V1(:,6);  B(6) = a1(6);
U(:,7) = V1(:,4);  B(7) = a1(4);
U(:,8) = V1(:,2);  B(8) = a1(2);

%得到的对角化的哈密顿量

HD = U'*H*U;

%H = 2*pi*H;

%save H
%save U