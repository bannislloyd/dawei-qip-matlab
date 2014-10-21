% U = [               sqrt(p)                                 sqrt(1-p)e^(i*theta2)
%          -sqrt(1-p)e^(i*theta3)              sqrt(p) e^(i*(theta2+theta3)) ] 

% set sqrt(p) = cos(theta1/2)

% equal to this sequence U = expm(-i*theta3*Iz)*expm(i*acos(sqrt(p))*2*Iy)*expm(-i*theta2*Iz);
%% change theta1
clear;
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(1); 

% consider T gate (pi/8 gate)
theta2 = pi/8; theta3 = pi/8;
rho1 = ST0; rho2 = 1/2*[1,1;1,1];
number = 40;

load expnorm1_0x.mat
load expnorm1_0z.mat
load expnorm1_+x.mat


for ii = 0:number
          theta1 = ii*2*pi/number;
%           U = [sqrt(p), -sqrt(1-p)*exp(i*theta2); sqrt(1-p)*exp(i*theta3), sqrt(p)*exp(i*(theta2+theta3))];
          U = expm(-i*theta3*Iz)*expm(i*theta1*Iy)*expm(-i*theta2*Iz);
          rho_out1 = U*rho1*U';
          rho_out2 = U*rho2*U';
          alpha1(ii+1) = trace(rho_out1*sigma_x);
          beta1(ii+1) = trace(rho_out1*sigma_y);
          gamma1(ii+1) = trace(rho_out1*sigma_z);
          alpha2(ii+1) = trace(rho_out2*sigma_x);
          beta2(ii+1) = trace(rho_out2*sigma_y);
end

% for ii = 1:41
% theo_theta1(ii) = 2*acos(sqrt((1+gamma1(ii))*0.5));
% end
% 
% for ii = 1:41
% cos_theta3(ii) = -alpha1(ii)/2/sqrt(cos(theo_theta1(ii)/2)^2-cos(theo_theta1(ii)/2)^4)
% end
% 
% plot(cos_theta3,'b')

for ii = 1:41
exp_theta1(ii) = 2*acos(sqrt((1+exp1_0z(ii))*0.5));
end
% theta1 = [0:2*pi/number:2*pi];
for ii = 1:41
cos_theta3(ii) = acos(exp1_0x(ii)/2/sqrt(cos(exp_theta1(ii)/2)^2-cos(exp_theta1(ii)/2)^4))
end
% plot(real(exp_theta1),'r')
% hold on
% plot(theta1,'b')
% hold on
plot(real(cos_theta3),'k')