clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);
load Para.mat

load f_100000.mat

N_points = length(f);

for ii=1:N_points
    if f(ii)>40000
        fp1(ii)=f(ii);
    end
end

N_p1 = length(fp1);
load timestep_100000.mat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% U1 is calculated by f and timestep %%%%%%%%%%%%%%
 %U1 = eye(2^7);
 %for ii = 1:N_points
 %      U = expm(i*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6}+KIx{7})*f(ii)/2*2*pi*timestep(ii)-i*H*timestep(ii));
 %      U1=U*U1;
 %end
 %save U1.mat U1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load U1.mat

Input = kron(ones(2^6)/2^(6),Ix);
Output = U1*Input*U1';
diag(Output);

Up1 = eye(2^7);
for ii = 1:N_p1
      U = expm(i*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6}+KIx{7})*f(ii)/2*2*pi*timestep(ii)-i*H*timestep(ii));
      Up1 = U*Up1;
end
save Up1.mat Up1

Up2 = eye(2^7);
for ii = (N_p1+1):N_points
      U = expm(i*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6}+KIx{7})*f(ii)/2*2*pi*timestep(ii)-i*H*timestep(ii));
      Up2 = U*Up2;
end
save Up2.mat Up2

