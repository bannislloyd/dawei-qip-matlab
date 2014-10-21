   clear;

% fun=inline('a(1)*sin(t/10^(-6)/11850*2*pi)*exp(-t*a(2))','a','t');    %建立函数

%*exp(-t/a(2))*


size = 400;
fidin=fopen('rfsel4.txt');
line=fgetl(fidin);

rfsel64(1)=0;
t(1)=0;

for n=2:(size+1)
    line=fgetl(fidin);
    x=fscanf(fidin,'%f');
    rfsel64(n)=x(4)*sin((n-1)*400/11850*2*pi);
    t(n) = (n-1)*400*10^(-6);
end
fclose(fidin);


%plot(t,rfsel64)

for n = (size+2):450
    rfsel64(n)= 0;
end
%number of durations
m = ceil(400*size/11850);
p = floor(11850/400);


for ii = 1:m
    for jj = 1:p
    Amplitude(jj) = rfsel64(((ii-1)*p+jj));
    end
    [AA(ii),BB(ii)] = max(Amplitude);
    BB(ii) = (BB(ii)-1)*400*10^(-6)+(ii-1)*(p-1)*400*10^(-6);
end

plot(BB,AA,'ro')    


fun=inline('a(2)*exp(-BB/a(1))','a','BB'); 
a=nlinfit(BB, AA, fun,[0.01,0])


for ppp = 1:14
    kkk(ppp) = a(2)*exp(-BB(ppp)/a(1));
end
hold on;
plot(BB,kkk)



% 
% %*sin(t/10^(-6)/11850*2*pi)
% 
% a=lsqcurvefit(fun,[0.01],BB,AA);    %拟合


% hold on;plot(t,rfsel64,'bo');    %画原始数据点  
% t0=min(BB):max(BB);
% CC=fun(a,t0);
% plot(t0,CC,'r');  %画拟和曲线
% hold off;disp(a)  %显示A、B、R参数的值