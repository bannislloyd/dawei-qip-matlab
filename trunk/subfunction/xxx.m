clear;

BBB = 4;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(BBB);

U = eye(2^BBB);

% for ii = 1:(BBB-1)
%     U = expm(i*KIx{ii}*pi/2)*expm(-i*pi*KIz{ii}*KIz{ii+1})*expm(-i*KIy{ii}*pi/2)*U;
% end
% 
% % for mm = 1:6
% %     U = expm(i*KIx{8-ii}*pi/2)*expm(-i*pi*KIz{8-ii}*KIz{8-ii-1})*expm(-i*KIy{8-ii}*pi/2)*U;
% % end
% 
% U = expm(i*KIx{BBB}*pi/2)*expm(-i*pi*KIz{BBB}*KIz{1})*expm(-i*KIy{BBB}*pi/2)*U;
% % U = expm(i*KIx{6}*pi/2)*expm(-i*pi*KIz{6}*KIz{7})*expm(-i*KIy{6}*pi/2)*U;


for ii = 1:(BBB-2)
    U = expm(i*KIx{ii}*pi/2)*expm(-i*pi*KIz{ii}*KIz{ii+1})*expm(-i*KIy{ii}*pi/2)*U;
end

% for mm = 1:6
%     U = expm(i*KIx{8-ii}*pi/2)*expm(-i*pi*KIz{8-ii}*KIz{8-ii-1})*expm(-i*KIy{8-ii}*pi/2)*U;
% end

U = expm(i*KIx{BBB-1}*pi/2)*expm(-i*pi*KIz{BBB-1}*KIz{1})*expm(-i*KIy{BBB-1}*pi/2)*U;
% U = expm(i*KIx{6}*pi/2)*expm(-i*pi*KIz{6}*KIz{7})*expm(-i*KIy{6}*pi/2)*U;

U = expm(i*KIx{BBB-1}*pi/2)*expm(-i*pi*KIz{BBB-1}*KIz{BBB})*expm(-i*KIy{BBB-1}*pi/2)*U;
U = expm(i*KIx{BBB}*pi/2)*expm(-i*pi*KIz{BBB-1}*KIz{BBB})*expm(-i*KIy{BBB}*pi/2)*U;


rou = zeros(2^BBB);

for jj = 1:2^BBB
    rou(jj,jj) = jj;
end

diag(U*rou*U')-diag(rou)

A(1) = rou(1,1);

for kk  = 1:(2^BBB-2)
    rou = U*rou*U';
    A(kk+1) = rou(1,1);
end

unique(real(A))