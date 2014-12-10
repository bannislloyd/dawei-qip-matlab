function rho_out = Gz_echo( rho, spins )
% Simulation of the gradient echo
% Input: density matrix, echo spin number (such as [1 3] means echo on spin 1 and 3)

 v=length(rho);    
 N = log2(v);  
 echo_length = length(spins);
 
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
     temp = expm(-i*2*pi*Z*gradient*ii)*rho*expm(-i*2*pi*Z*gradient*ii)';
     for jj = 1:echo_length  %% this is the echo on the selective spins
         temp = expm(-i*pi*KIx{spins(jj)})*temp*expm(-i*pi*KIx{spins(jj)})';
     end
     rho_out = rho_out + expm(-i*2*pi*Z*gradient*ii)*temp*expm(-i*2*pi*Z*gradient*ii)';
 end
 rho_out = rho_out/steps;
 
 for jj = 1:echo_length %% flip the state back
         rho_out = expm(-i*pi*KIx{spins(jj)})*rho_out*expm(-i*pi*KIx{spins(jj)})';
 end

 % optional, to erase all the small elements due to gradient imperfection in the output 
 for ii = 1:v
     for jj = 1:v
         if abs(rho_out(ii,jj)-rho(ii,jj)) > 0.001
             rho_out(ii,jj) = 0;
         end
     end
 end
 
end

