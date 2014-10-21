clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);

load Para.mat

N = 36;
step = 2*pi/N;
X = 0:step:(2*pi);
U_node11 = cell(N+1,1);

%% Case 1: Symmetric XX+YY %%

ii = 1;
Time = 20e-6;
Steps = 1000;
 
for t = 0:step:(2*pi)

H12 = 2*(KIx{1}*KIx{2}+KIy{1}*KIy{2});
U12 = expm(-i*H12*t);
H23 = 2*(KIx{2}*KIx{3}+KIy{2}*KIy{3});
U23 = expm(-i*H23*t);
H13 = 2*(KIx{1}*KIx{3}+KIy{1}*KIy{3});
U13 = expm(-i*H13*t);

U_node11{ii} = rot(KIx{2},pi/2)*U12*U23*U13*U13*U23*U12;

filename1 = ['TCE_node11_',num2str(ii),'_C'];
filename2 = ['TCE_node11_',num2str(ii),'_H'];
f(ii) = pulse(U_node11{ii},H_int,Time,Steps,filename1,filename2);
 
ii = ii+1;

end

