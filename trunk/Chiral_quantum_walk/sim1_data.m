clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);

rho_in = kron(ST1,kron(ST0,ST0));
N = 36;
step = 2*pi/N;
X = 0:step:(2*pi);
fid=fopen('Sim1.txt','w');
fprintf(fid, 'Initial State: |100>\n');

%% Case 1: Symmetric XX+YY %%
fprintf(fid, '%%%%%% XX+YY %%%%%%\n');
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

fprintf(fid, 'Num %2d:%1.3f,%1.3f,%1.3f; ',ii,A(ii),B(ii),C(ii));
if mod(ii,3)==0
    fprintf(fid,'\n');
end

ii = ii+1;

end

%% Case 2: Symmetric -(XX+YY) %%
fprintf(fid, '\n\n%%%%%% -(XX+YY) %%%%%%\n');
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

fprintf(fid, 'Num %2d:%1.3f,%1.3f,%1.3f; ',ii,A(ii),B(ii),C(ii));
if mod(ii,3)==0
    fprintf(fid,'\n');
end

ii = ii+1;

end

%% Case 3: AntiSymmetric XY-YX %%
fprintf(fid, '\n\n%%%%%% XY-YX %%%%%%\n');
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

fprintf(fid, 'Num %2d:%1.3f,%1.3f,%1.3f; ',ii,A(ii),B(ii),C(ii));
if mod(ii,3)==0
    fprintf(fid,'\n');
end

ii = ii+1;

end

%% Case 4: AntiSymmetric -(XY-YX) %%
fprintf(fid, '\n\n%%%%%% -(XY-YX) %%%%%%\n');
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

fprintf(fid, 'Num %2d:%1.3f,%1.3f,%1.3f; ',ii,A(ii),B(ii),C(ii));
if mod(ii,3)==0
    fprintf(fid,'\n');
end

ii = ii+1;

end
