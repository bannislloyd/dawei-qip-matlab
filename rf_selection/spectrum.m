clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rfsel0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

size = 32;
fidin=fopen('rfsel0.txt');
line=fgetl(fidin);

t(1)=0;

for n=1:(size)
    line=fgetl(fidin);
    x=fscanf(fidin,'%f');
    rfsel0(n)=x(4);
    t(n) = (n-1)*0.05;
end
fclose(fidin);


plot(t,rfsel0,'bo')

fun=inline('a(2)*exp(-t/a(1))','a','t'); 
a=nlinfit(t, rfsel0, fun,[0.01,0])

for ppp = 1:size
    kkk(ppp) = a(2)*exp(-t(ppp)/a(1));
end
hold on;
plot(t,kkk,'b')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rfsel4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

size = 32;
fidin=fopen('rfsel4.txt');
line=fgetl(fidin);

t(1)=0;

for n=1:(size)
    line=fgetl(fidin);
    x=fscanf(fidin,'%f');
    rfsel4(n)=x(4);
    t(n) = (n-1)*0.05;
end
fclose(fidin);

rfsel4 = rfsel4/1.3026;


plot(t,rfsel4,'kh')

fun=inline('e(2)*exp(-t/e(1))','e','t'); 
e=nlinfit(t, rfsel4, fun,[0.01,0])

for ppp = 1:size
    kkk(ppp) = e(2)*exp(-t(ppp)/e(1));
end
hold on;
plot(t,kkk,'k:')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rfsel32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

size = 32;
fidin=fopen('rfsel32.txt');
line=fgetl(fidin);

t(1)=0;

for n=1:(size)
    line=fgetl(fidin);
    x=fscanf(fidin,'%f');
    rfsel32(n)=x(4);
    t(n) = (n-1)*0.05;
end
fclose(fidin);

rfsel32=rfsel32*0.2684;

plot(t,rfsel32,'r*')

fun=inline('d(2)*exp(-t/d(1))','d','t'); 
d=nlinfit(t, rfsel32, fun,[0.01,0])

for ppp = 1:size
    kkk(ppp) = d(2)*exp(-t(ppp)/d(1));
end
hold on;

plot(t,kkk,'r--')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rfsel64
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

size = 32;
fidin=fopen('rfsel64.txt');
line=fgetl(fidin);

t(1)=0;

for n=1:(size)
    line=fgetl(fidin);
    x=fscanf(fidin,'%f');
    rfsel64(n)=x(4);
    t(n) = (n-1)*0.05;
end
fclose(fidin);

rfsel64 = rfsel64*0.0958;

hold on
plot(t,rfsel64,'g+')

fun=inline('b(2)*exp(-t/b(1))','b','t'); 
b=nlinfit(t, rfsel64, fun,[0.01,0])

for ppp = 1:32
    kkk(ppp) = b(2)*exp(-t(ppp)/b(1));
end
hold on;
plot(t,kkk,'g-.')
% 
% 
% 
% 
% size = 32;
% fidin=fopen('rfsel128.txt');
% line=fgetl(fidin);
% 
% t(1)=0;
% 
% for n=1:(size)
%     line=fgetl(fidin);
%     x=fscanf(fidin,'%f');
%     rfsel128(n)=x(4);
%     t(n) = (n-1)*0.05;
% end
% fclose(fidin);
% 
% hold on
% plot(t,rfsel128,'md')
% 
% fun=inline('c(2)*exp(-t/c(1))','c','t'); 
% c=nlinfit(t, rfsel128, fun,[0.01,0])
% 
% for ppp = 1:32
%     kkk(ppp) = c(2)*exp(-t(ppp)/c(1));
% end
% hold on;
% plot(t,kkk)
% 

% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set legend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
legend('rfsel0-data','rfsel0-fit:382ms','rfsel4-data','rfsel4-fit:409ms','rfsel32-data','rfsel32-fit:467ms','rfsel64-data','rfsel64-fit:464ms');

set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','bold');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set label and title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlabel({'Time (s)'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri');

ylabel({'Arb. Unit'},'FontWeight','bold','FontSize',14,...
    'FontName','Calibri');

title({'Rf Selection'},'FontWeight','bold','FontSize',14,...
    'FontName','Times New Roman',...
    'FontAngle','normal');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%