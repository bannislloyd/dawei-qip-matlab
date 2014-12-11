function[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,Ix1,Iy1,Iz1,Ix2,Iy2,Iz2,Ix3,Iy3,Iz3,Ix4,Iy4,Iz4,Ix5,Iy5,Iz5,Ix6,Iy6,Iz6] = paulin(n)

sigma_x=[0,1;1,0];                  %sigma��� 
sigma_y=[0,-i;i,0];
sigma_z=[1,0;0,-1];
ST0=[1,0;0,0];
ST1=[0,0;0,1];
Ix=0.5*sigma_x;                      %���˵ĺ��������
Iy=0.5*sigma_y;
Iz=0.5*sigma_z;
I=[1,0;0,1];

Ix1=0;Iy1=0;Iz1=0;Ix2=0;Iy2=0;Iz2=0;Ix3=0;Iy3=0;Iz3=0;Ix4=0;Iy4=0;Iz4=0;
%-----------�����ķָ���------------

if n == 2
   Ix1 = kron(Ix,I);
   Iy1 = kron(Iy,I);
   Iz1 = kron(Iz,I);
   
   Ix2 = kron(I,Ix);
   Iy2 = kron(I,Iy);
   Iz2 = kron(I,Iz);
   
    elseif n == 3

   Ix1=kron(kron(Ix,I),I);             %��������ϵ��1�˵ĺ��������
   Iy1=kron(kron(Iy,I),I);
   Iz1=kron(kron(Iz,I),I);
   
   Ix2=kron(kron(I,Ix),I);            %��������ϵ��2�˵ĺ��������
   Iy2=kron(kron(I,Iy),I);
   Iz2=kron(kron(I,Iz),I);
   
   Ix3=kron(kron(I,I),Ix);            %��������ϵ��3�˵ĺ��������
   Iy3=kron(kron(I,I),Iy);
   Iz3=kron(kron(I,I),Iz);
   
    elseif n == 4

   Ix1=kron(kron(kron(Ix,I),I),I);            %�ı�����ϵ��1�˵ĺ��������
   Iy1=kron(kron(kron(Iy,I),I),I);
   Iz1=kron(kron(kron(Iz,I),I),I);
   
   Ix2=kron(kron(kron(I,Ix),I),I);            %�ı�����ϵ��2�˵ĺ��������
   Iy2=kron(kron(kron(I,Iy),I),I);
   Iz2=kron(kron(kron(I,Iz),I),I);
   
   Ix3=kron(kron(kron(I,I),Ix),I);            %�ı�����ϵ��3�˵ĺ��������
   Iy3=kron(kron(kron(I,I),Iy),I);
   Iz3=kron(kron(kron(I,I),Iz),I);
   
   Ix4=kron(kron(kron(I,I),I),Ix);            %�ı�����ϵ��4�˵ĺ��������
   Iy4=kron(kron(kron(I,I),I),Iy);
   Iz4=kron(kron(kron(I,I),I),Iz);
    
elseif n == 5

   Ix1=kron(kron(kron(kron(Ix,I),I),I),I);            %�������ϵ��1�˵ĺ��������
   Iy1=kron(kron(kron(kron(Iy,I),I),I),I);
   Iz1=kron(kron(kron(kron(Iz,I),I),I),I);
   
   Ix2=kron(kron(kron(kron(I,Ix),I),I),I);            %�������ϵ��2�˵ĺ��������
   Iy2=kron(kron(kron(kron(I,Iy),I),I),I);
   Iz2=kron(kron(kron(kron(I,Iz),I),I),I);
   
   Ix3=kron(kron(kron(kron(I,I),Ix),I),I);            %�������ϵ��3�˵ĺ��������
   Iy3=kron(kron(kron(kron(I,I),Iy),I),I);
   Iz3=kron(kron(kron(kron(I,I),Iz),I),I);
   
   Ix4=kron(kron(kron(kron(I,I),I),Ix),I);            %�������ϵ��4�˵ĺ��������
   Iy4=kron(kron(kron(kron(I,I),I),Iy),I);
   Iz4=kron(kron(kron(kron(I,I),I),Iz),I);

   Ix5=kron(kron(kron(kron(I,I),I),I),Ix);            %�������ϵ��5�˵ĺ��������
   Iy5=kron(kron(kron(kron(I,I),I),I),Iy);
   Iz5=kron(kron(kron(kron(I,I),I),I),Iz);
   
   elseif n == 6

   Ix1=kron(kron(kron(kron(kron(Ix,I),I),I),I),I);            %�������ϵ��1�˵ĺ��������
   Iy1=kron(kron(kron(kron(kron(Iy,I),I),I),I),I);
   Iz1=kron(kron(kron(kron(kron(Iz,I),I),I),I),I);
   
   Ix2=kron(kron(kron(kron(kron(I,Ix),I),I),I),I);            %�������ϵ��2�˵ĺ��������
   Iy2=kron(kron(kron(kron(kron(I,Iy),I),I),I),I);
   Iz2=kron(kron(kron(kron(kron(I,Iz),I),I),I),I);
   
   Ix3=kron(kron(kron(kron(kron(I,I),Ix),I),I),I);            %�������ϵ��3�˵ĺ��������
   Iy3=kron(kron(kron(kron(kron(I,I),Iy),I),I),I);
   Iz3=kron(kron(kron(kron(kron(I,I),Iz),I),I),I);
   
   Ix4=kron(kron(kron(kron(kron(I,I),I),Ix),I),I);            %�������ϵ��4�˵ĺ��������
   Iy4=kron(kron(kron(kron(kron(I,I),I),Iy),I),I);
   Iz4=kron(kron(kron(kron(kron(I,I),I),Iz),I),I);

   
   Ix5=kron(kron(kron(kron(kron(I,I),I),I),Ix),I);            %�������ϵ��5�˵ĺ��������
   Iy5=kron(kron(kron(kron(kron(I,I),I),I),Iy),I);
   Iz5=kron(kron(kron(kron(kron(I,I),I),I),Iz),I);

   Ix6=kron(kron(kron(kron(kron(I,I),I),I),I),Ix);            %�������ϵ��5�˵ĺ��������
   Iy6=kron(kron(kron(kron(kron(I,I),I),I),I),Iy);
   Iz6=kron(kron(kron(kron(kron(I,I),I),I),I),Iz);


    else fprintf('Have not so big n...' \n);
        
end