clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);
[Para,H] = hamiltonian_7qubit;

%% re-write the Hamilonian of the 7-qubit subsystem %%%%%%%%%%%
% H is the Hamiltonian in the full rotating frame, only containing J-terms
% Hfrot is the transformation Hamiltonian, only containing w-terms

for ii = 1:7
    w(ii) = Para(ii,ii);
end

for ii = 1:7
    for jj = 1:7
        J(ii,jj) = Para(ii,jj);
    end
end


H = 0;
O1 = 20696; % transmit frequency, the rotating frequency of the partially rotating frame


for ii = 1:6
    for jj = (ii+1):7
        H = H + J(ii,jj)*KIz{ii}*KIz{jj};
    end
end

H = 2*pi*H;  

Hfrot = 0;
for ii = 1:7
    Hfrot = Hfrot + (w(ii)-O1)*KIz{ii};
end
Hfrot = 2*pi*Hfrot;
%% Initial state and all parameters %%%%%%%%%%%%%%%%%%%%%
s = kron(ones(2^6)/2^(6),Iz); %the same initial state

load f.mat
load t.mat
load timestep.mat
N_points = length(f); % 830 steps
% timestep can be integer times of us
timestep = round(timestep*1e6)/1e6; 
%% Check in the fully rotating frame %%%%%%%%%%%%%%%%%%%%%
% for ii = 1:N_points
%     H_full = -pi*f(ii)*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})+H;
%      s = expm(-i*H_full*timestep(ii))*s*expm(-i*H_full*timestep(ii))';
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Check in the partially rotating frame %%%%%%%%%%%%%%%%%%%%%
mini_step = 1e-6;
N = round(timestep/mini_step);
for ii = 1:N_points
    H_full = -pi*f(ii)*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})+H;
    for jj = 1:N(ii)
        tcurrent = timestep(ii)+jj*mini_step;
        H_lab = expm(-i*Hfrot*tcurrent)*H_full* expm(i*Hfrot*tcurrent)+Hfrot;
        s = expm(-i*H_lab*mini_step)*s*expm(-i*H_lab*mini_step)';
    end     
end

  % trace C7 off
  Q1 = kron(I,kron(I,kron(I,kron(I,kron(I,kron(I,[1,0]))))));
  Q2 = kron(I,kron(I,kron(I,kron(I,kron(I,kron(I,[0,1]))))));
  result = Q1*s*Q1'+Q2*s*Q2'; % density matrix of the C1-C6 system
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % find the largest two elements in the diagnol elements
  % the positions should be 43 and 22
  population = abs(diag(result));
  pos1 = find(population == max(population)) % the position of the biggest number
  dec2bin(pos1-1) % the vector
  population(pos1) % the value
  
  population(pos1) = -10000;
  pos2 = find(population == max(population)) % the position of the 2nd biggest number
  dec2bin(pos2-1) % the vector
  population(pos2) % the value
  
  