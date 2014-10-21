clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);

rho_in = kron(ST0,kron(ST1,ST0));
N = 600;
step = 2*pi/N;
X = 0:step:(2*pi);

%% Case 1: Symmetric XX+YY %%

ii = 1;
for t = 0:step:(2*pi)

H12 = 2*(KIx{1}*KIx{2}+KIy{1}*KIy{2});
U12 = expm(-i*H12*t);
H23 = 2*(KIx{2}*KIx{3}+KIy{2}*KIy{3});
U23 = expm(-i*H23*t);
H13 = 2*(KIx{1}*KIx{3}+KIy{1}*KIy{3});
U13 = expm(-i*H13*t);

rho_fin = (U12*U23*U13*U13*U23*U12)*rho_in*(U12*U23*U13*U13*U23*U12)';

A(ii) = abs(trace(rho_fin*kron(ST1,kron(ST0,ST0))));
B(ii) = abs(trace(rho_fin*kron(ST0,kron(ST1,ST0))));
C(ii) = abs(trace(rho_fin*kron(ST0,kron(ST0,ST1))));
D(ii) = A(ii)+B(ii)+C(ii);

ii = ii+1;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot Parameters %%
subplot(2,2,1);
plot(X,real(A),'b-','Linewidth',2,'Color',[0.4667 0.7647 0.3882])
hold on
plot(X,real(B),'r--','Linewidth',2,'Color',[0.4 0.4 1])
hold on
plot(X,real(C),'g-.','Linewidth',2,'Color',[1 0.6 0.6])

fontsize = 14;
fontsize_legend = 8;

title({'XX+YY'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

legend('p(2\rightarrow 1)','p(2\rightarrow 2)','p(2\rightarrow 3)');
set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend);
%set(legend,'Color','none')

xlabel({'t'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'p(2\rightarrow n)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');
set(gca,'Xlim',[0 2*pi],'Ylim',[0 1],'XTick',[0:pi/2:2*pi],'XTickLabel',{'0','0.5¦Ð','¦Ð','1.5¦Ð','2¦Ð'},'FontName','Calibri','FontSize',fontsize);

% px=[0:pi/2:2*pi];
% py=px*0-0.05;
% text(px,py,{'0','\pi/2','\pi','3\pi/2','2\pi'},'FontWeight','normal','FontName','Calibri','FontSize',14);
% text(pi,-0.15,{'t'},'FontWeight','normal','FontName','Calibri','FontSize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Case 2: Symmetric -(XX+YY) %%

ii = 1;
for t = 0:step:(2*pi)

H12 = -2*(KIx{1}*KIx{2}+KIy{1}*KIy{2});
U12 = expm(-i*H12*t);
H23 = -2*(KIx{2}*KIx{3}+KIy{2}*KIy{3});
U23 = expm(-i*H23*t);
H13 = -2*(KIx{1}*KIx{3}+KIy{1}*KIy{3});
U13 = expm(-i*H13*t);

rho_fin = (U12*U23*U13*U13*U23*U12)*rho_in*(U12*U23*U13*U13*U23*U12)';

A(ii) = abs(trace(rho_fin*kron(ST1,kron(ST0,ST0))));
B(ii) = abs(trace(rho_fin*kron(ST0,kron(ST1,ST0))));
C(ii) = abs(trace(rho_fin*kron(ST0,kron(ST0,ST1))));
D(ii) = A(ii)+B(ii)+C(ii);

ii = ii+1;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot Parameters %%
subplot(2,2,2);
plot(X,real(A),'b-','Linewidth',2,'Color',[0.4667 0.7647 0.3882])
hold on
plot(X,real(B),'r--','Linewidth',2,'Color',[0.4 0.4 1])
hold on
plot(X,real(C),'g-.','Linewidth',2,'Color',[1 0.6 0.6])



title({'-(XX+YY)'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

legend('p(2\rightarrow 1)','p(2\rightarrow 2)','p(2\rightarrow 3)');
set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend);
%set(legend,'Color','none')

xlabel({'t'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'p(2\rightarrow n)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');
set(gca,'Xlim',[0 2*pi],'Ylim',[0 1],'XTick',[0:pi/2:2*pi],'XTickLabel',{'0','0.5¦Ð','¦Ð','1.5¦Ð','2¦Ð'},'FontName','Calibri','FontSize',fontsize);

% px=[0:pi/2:2*pi];
% py=px*0-0.05;
% text(px,py,{'0','\pi/2','\pi','3\pi/2','2\pi'},'FontWeight','normal','FontName','Calibri','FontSize',14);
% text(pi,-0.15,{'t'},'FontWeight','normal','FontName','Calibri','FontSize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Case 3: AntiSymmetric XY-YX %%

ii = 1;
for t = 0:step:(2*pi)

H12 = 2*(KIx{1}*KIy{2}-KIy{1}*KIx{2});
U12 = expm(-i*H12*t);
H23 = 2*(KIx{2}*KIy{3}-KIy{2}*KIx{3});
U23 = expm(-i*H23*t);
H13 = 2*(KIx{1}*KIy{3}-KIy{1}*KIx{3});
U13 = expm(-i*H13*t);

rho_fin = (U12*U23*U13*U13*U23*U12)*rho_in*(U12*U23*U13*U13*U23*U12)';

A(ii) = abs(trace(rho_fin*kron(ST1,kron(ST0,ST0))));
B(ii) = abs(trace(rho_fin*kron(ST0,kron(ST1,ST0))));
C(ii) = abs(trace(rho_fin*kron(ST0,kron(ST0,ST1))));
D(ii) = A(ii)+B(ii)+C(ii);

ii = ii+1;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot Parameters %%
subplot(2,2,3);
plot(X,real(A),'b-','Linewidth',2,'Color',[0.4667 0.7647 0.3882])
hold on
plot(X,real(B),'r--','Linewidth',2,'Color',[0.4 0.4 1])
hold on
plot(X,real(C),'g-.','Linewidth',2,'Color',[1 0.6 0.6])



title({'XY-YX'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

legend('p(2\rightarrow 1)','p(2\rightarrow 2)','p(2\rightarrow 3)');
set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend);
%set(legend,'Color','none')

xlabel({'t'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'p(2\rightarrow n)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');
set(gca,'Xlim',[0 2*pi],'Ylim',[0 1],'XTick',[0:pi/2:2*pi],'XTickLabel',{'0','0.5¦Ð','¦Ð','1.5¦Ð','2¦Ð'},'FontName','Calibri','FontSize',fontsize);

% px=[0:pi/2:2*pi];
% py=px*0-0.05;
% text(px,py,{'0','\pi/2','\pi','3\pi/2','2\pi'},'FontWeight','normal','FontName','Calibri','FontSize',14);
% text(pi,-0.15,{'t'},'FontWeight','normal','FontName','Calibri','FontSize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Cse 4: AntiSymmetric -(XY-YX) %%

ii = 1;
for t = 0:step:(2*pi)

H12 = -2*(KIx{1}*KIy{2}-KIy{1}*KIx{2});
U12 = expm(-i*H12*t);
H23 = -2*(KIx{2}*KIy{3}-KIy{2}*KIx{3});
U23 = expm(-i*H23*t);
H13 = -2*(KIx{1}*KIy{3}-KIy{1}*KIx{3});
U13 = expm(-i*H13*t);

rho_fin = (U12*U23*U13*U13*U23*U12)*rho_in*(U12*U23*U13*U13*U23*U12)';

A(ii) = abs(trace(rho_fin*kron(ST1,kron(ST0,ST0))));
B(ii) = abs(trace(rho_fin*kron(ST0,kron(ST1,ST0))));
C(ii) = abs(trace(rho_fin*kron(ST0,kron(ST0,ST1))));
D(ii) = A(ii)+B(ii)+C(ii);

ii = ii+1;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot Parameters %%
subplot(2,2,4);
plot(X,real(A),'b-','Linewidth',2,'Color',[0.4667 0.7647 0.3882])
hold on
plot(X,real(B),'r--','Linewidth',2,'Color',[0.4 0.4 1])
hold on
plot(X,real(C),'g-.','Linewidth',2,'Color',[1 0.6 0.6])



title({'-(XY-YX)'},'FontWeight','normal','FontSize',fontsize,...
   'FontName','Calibri',...
   'FontAngle','normal');

legend('p(2\rightarrow 1)','p(2\rightarrow 2)','p(2\rightarrow 3)');
set(legend,'EdgeColor',[1 0.8 0],'YColor',[1 0.8 0],'XColor',[1 0.8 0],...
    'LineWidth',2,...
    'FontWeight','normal','FontSize',fontsize_legend);
%set(legend,'Color','none')

xlabel({'t'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');

ylabel({'p(2\rightarrow n)'},'FontWeight','normal','FontSize',fontsize,...
    'FontName','Calibri');
set(gca,'Xlim',[0 2*pi],'Ylim',[0 1],'XTick',[0:pi/2:2*pi],'XTickLabel',{'0','0.5¦Ð','¦Ð','1.5¦Ð','2¦Ð'},'FontName','Calibri','FontSize',fontsize);

% px=[0:pi/2:2*pi];
% py=px*0-0.05;
% text(px,py,{'0','\pi/2','\pi','3\pi/2','2\pi'},'FontWeight','normal','FontName','Calibri','FontSize',14);
% text(pi,-0.15,{'t'},'FontWeight','normal','FontName','Calibri','FontSize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%