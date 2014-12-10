function rho_out=Gz_Real(rho)

 v=length(rho);    
 N = log2(v);  
 
 gradient = 23.1318; % a random value
 time = 1e-3; % 1ms
 steps = 100; % usually 100 steps work fine

 [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(N);
 
 Z = 0;
 for ii = 1:N
     Z = KIz{ii}+Z;
 end

 rho_out = 0;
 for ii = 1:steps
     rho_out = rho_out + expm(-i*2*pi*Z*gradient*ii)*rho*expm(-i*2*pi*Z*gradient*ii)';
 end
 rho_out = rho_out/steps;
 

