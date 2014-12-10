function[H,U,HD,B] = baseconvert2
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,Ix1,Iy1,Iz1,Ix2,Iy2,Iz2]=pauliform(2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ZLI1132��hamiltonian��ʽ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w1 = 2597.8451; w2 = 2508.4940;
D = 434.2611;
J = 2.26;
 
%Һ����ϵĹ��ܶ���

H = (w1*Iz1+w2*Iz2)+D*(Iz1*Iz2-Ix1*Ix2/2-Iy1*Iy2/2)+J*Iz1*Iz2;
  
%HD = 2375.48*Iz1+2466.97*Iz2+2444.95*Iz3+(-3947.62)*Iz1*Iz2+685.916*Iz2*Iz3+(-3254.5)*Iz1*Iz3




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��H�Խǻ����õ��任����U�ͶԽǵ�HD,����U'*H*U = HD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1 = eig(H);
[V1,D1] = eig(H);

%��V1�������У��õ��任����U����Ӧ�ĵõ�����ֵB������˳��
%���������Ǵ�00-11��˳��,��U(:,1)-U(:,4)�ֱ���Ϊ2���ص�00��11̬

U(:,1) = V1(:,4);  B(1) = a1(4);
U(:,2) = V1(:,3);  B(2) = a1(3);
U(:,3) = V1(:,2);  B(3) = a1(2);
U(:,4) = V1(:,1);  B(4) = a1(1);

%�õ��ĶԽǻ��Ĺ��ܶ���

HD = U'*H*U;