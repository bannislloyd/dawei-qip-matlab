clear;

sigmax = [0 1;1 0];

sigmay = [0 -i;i 0];

sigmaz = [1 0;0 -1];

we = [1 0;0 1];

Ix1 = kron(kron(sigmax/2,we),we);

Ix2 = kron(kron(we,sigmax/2),we);

Ix3 = kron(kron(we,we),sigmax/2);

Iy3 = kron(kron(we,we),sigmay/2);
     
Iy2 = kron(kron(we,sigmay/2),we);
         
Iy1 = kron(kron(sigmay/2,we),we);
       
Iz1 = kron(kron(sigmaz/2,we),we);

Iz2 = kron(kron(we,sigmaz/2),we);

Iz3 = kron(kron(we,we),sigmaz/2);

Iz12 = kron(kron(sigmaz/2,sigmaz/2),we);

Iz23 = kron(kron(we,sigmaz/2),sigmaz/2);

Iz13 = kron(kron(sigmaz/2,we),sigmaz/2);

Ix12 = kron(kron(sigmax/2,sigmax/2),we);

Ix23 = kron(kron(we,sigmax/2),sigmax/2);

Ix13 = kron(kron(sigmax/2,we),sigmax/2);

Iy23 = kron(kron(we,sigmay/2),sigmay/2);
     
Iy12 = kron(kron(sigmay/2,sigmay/2),we);
         
Iy13 = kron(kron(sigmay/2,we),sigmay/2);

Iz123 = kron(kron(sigmaz/2,sigmaz/2),sigmaz/2);

w = 1.0e+003 * [
     21.787    20.527    4.5468   0.10306   0.2013   0.0085  ];

H = (w(1)*Iz1+w(2)*Iz2+w(3)*Iz3)+w(4)*(Iz1*Iz2+Ix1*Ix2+Iy1*Iy2)+w(5)*(Iz2*Iz3)+w(6)*(Iz1*Iz3);

wtmp = w;

w_out = w;

%peak_position = -1179.0631 + 1.0e+003 *[
%    7.1729    5.9853    4.9340    3.7491    3.6107    3.5658    2.3777    1.3714         0];

peak_position = [   21843.6625    21834.8425    21740.6041    21731.7841    20678.7716    20575.7132    20477.6370    20374.5786  4651.87045 4642.99796 4450.71085 4441.84185];



error = 100000000000;

while (error > 0.1) 
    
errorpri = error ;
if rand < 0.01
    errorpri = error 
end

%for ll = 1:3
%    w_out(ll) = w(ll) +  - (-5.0513) + (-1179.0631) ;
%end

if rand < 0.001
    w
    
end

if error < 1000000
    for num = 1:6
        wtmp(num) = w(num);
        w(num) = w(num) + ( 2*rand-1)/100000;       %生成1/1000范围内随机变化
    end
end

H = (w(1)*Iz1+w(2)*Iz2+w(3)*Iz3)+w(4)*(Iz1*Iz2+Ix1*Ix2+Iy1*Iy2)+w(5)*(Iz2*Iz3)+w(6)*(Iz1*Iz3);

[V1,D1] = eig(H);
ene = diag(D1);

for ii=1:8
    a1(ii)=D1(ii,ii);
    b1(:,ii)=V1(:,ii);
end

for ii=1:8
    for jj=1:8
        energy(ii,jj) = ene(ii) - ene(jj);  				%任意两个能级间的跃迁能量
        p(ii,jj) = (b1(:,ii)'*(Ix1+i*Iy1+Ix2+i*Iy2+Ix3+i*Iy3)*b1(:,jj))^2; 	%所有跃迁几率
    end
end

f2(1) = energy(8,7);  %可能的跃迁能量
f2(2) = energy(8,6);
f2(3) = energy(8,5);
f2(4) = energy(7,4);
f2(5) = energy(7,3);
f2(6) = energy(6,4);
f2(7) = energy(6,2);
f2(8) = energy(5,3);
f2(9) = energy(5,2);
f2(10) = energy(4,1);
f2(11) = energy(3,1);
f2(12) = energy(2,1);

peak_position_new = sortn( f2 , 12);
%peak_position_new = peak_position_new - peak_position_new(9);

error = sqrt(((peak_position_new(1) - peak_position(1))^2+ ...	%peak_position是图上各峰位置值，从大到小对应填入,
    (peak_position_new(2) - peak_position(2) )^2 + ...        		 %error表示用试探耦合系数w得出峰位置与图中的偏差
    (peak_position_new(3) - peak_position(3) )^2 + ...
    (peak_position_new(4) - peak_position(4) )^2 + ...
    (peak_position_new(5) - peak_position(5) )^2 + ...    
    (peak_position_new(6) - peak_position(6) )^2 + ...
    (peak_position_new(7) - peak_position(7) )^2 + ...        
    (peak_position_new(8) - peak_position(8) )^2 + ...
    (peak_position_new(10) - peak_position(10) )^2 + ...
    (peak_position_new(11) - peak_position(11) )^2 + ...
    (peak_position_new(12) - peak_position(12) )^2 + ...
    (peak_position_new(9) - peak_position(9) )^2 ) );

if error < errorpri  %如随机变化使偏差变小，
    continue;          %保留变化并进入下一步
else                   %否则返回原值
    error = errorpri ;
    for num=1:6
    w(num) = wtmp(num);
    end
end
end

