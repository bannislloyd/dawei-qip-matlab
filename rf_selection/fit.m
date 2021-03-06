fun=inline('a(1)+a(2)*exp(-a(3)*t)','a','t');    %建立函数
T=[14.57 6.05 4.57 3.54 2.89 2.45 2.12 1.89 1.7 1.55 0.4 0.41 0.43 0.44 0.43 0.43];
t=[0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75];
a=lsqcurvefit(fun,[0,0,0],t,T);    %拟合
hold on;plot(t,T,'bo');    %画原始数据点  
t0=min(t):max(t);
T0=fun(a,t0);
plot(t0,T0,'r');  %画拟和曲线
hold off;disp(a)  %显示A、B、R参数的值