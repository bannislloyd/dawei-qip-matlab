clear;

sigma_x=[0,1;1,0];                  %sigma��� 
sigma_y=[0,-i;i,0];
sigma_z=[1,0;0,-1];
ST0=[1,0;0,0];
ST1=[0,0;0,1];
Ix=0.5*sigma_x;                      %���˵ĺ��������
Iy=0.5*sigma_y;
Iz=0.5*sigma_z;
I=[1,0;0,1];


expm(-i*pi*Ix)*expm(-i*pi/2*Iy)