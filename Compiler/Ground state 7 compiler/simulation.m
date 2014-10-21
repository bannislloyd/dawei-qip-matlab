% Test

clear;

load parameter.mat

load Decoding_Bx; load Decoding_By;

T1=[8.015, 3.611, 1.834,  3.722, 12.95,  8.157, 3.636];
T2=[1.611, 0.877, 1.122, 0.792, 1.143, 1.912, 0.531];

rho_ini=gop(1,Z)*gop(2,Z)*gop(3,Z)*gop(4,Z)*gop(5,Z)*gop(6,Z)*gop(7,Z);
rho_final=gop(1,(Z+I)/sqrt(2))*gop(2,(Z-I)/sqrt(2))*gop(3,(Z-I)/sqrt(2))*gop(4,(Z+I)/sqrt(2))*gop(5,(Z+I)/sqrt(2))*gop(6,(Z-I)/sqrt(2))*gop(7,X);

total_time=42312e-6; time_interval=1e-6;
sigma=zeros(128,128);
for k=1:7
    r=k/7*360;
    Rotation=R(gop(1,Z),r)*R(gop(2,Z),r)*R(gop(3,Z),r)*R(gop(4,Z),r)*R(gop(5,Z),r)*R(gop(6,Z),r)*R(gop(7,Z),r)*R(gop(1,Y),90)*R(gop(2,Y),90)*R(gop(3,Y),90)*R(gop(4,Y),90)*R(gop(5,Y),90)*R(gop(6,Y),90);
    rho{k}=U_sim_compute(Decoding_Bx, Decoding_By, total_time, time_interval, T1, T2, Rotation*rho_ini*Rotation');
    sigma=sigma+rho{k};
end


trace(sigma*rho_final)/128
























% Bx=pulse(:,1)*2500/100.*cos(pulse(:,2)*pi/180);


