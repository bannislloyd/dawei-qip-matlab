%% Calculation of U_sim;
function U_sim=U_sim_calculation(Bx, By, total_time, time_interval)

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);

load Para.mat
Hint = H;

size=round(total_time/time_interval);
%% Check
X = 0; Y = 0;
for jj = 1:4
    X = X + KIx{jj};
    Y = Y + KIy{jj};
end

U = eye(2^4);

for ii = 1:size
    Hext = 2*pi*(Bx(ii)*X-By(ii)*Y);
    U = expm(-i*(Hext+Hint)*time_interval)*U;  
end

U_sim = U;
% Utar = rot(Y,pi/2);
%  rho_ini = KIz{1}+KIz{3};
%  rho_fin = U*rho_ini*U';
%  rho_tar = Utar*rho_ini*Utar';
%  Fidelity = trace(rho_fin*rho_tar)/trace( rho_ini* rho_ini)
% Uencoding_grape_80Iterations = U;
% save  Uencoding_grape_80Iterations.mat  Uencoding_grape_80Iterations