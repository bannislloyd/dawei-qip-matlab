clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

[Para,H] = hamiltonian_7qubit;

H = 0;

for ii = 1:7
    w(ii) = Para(ii,ii);
end
O1 = 20696;

for ii = 1:7
    for jj = 1:7
        J(ii,jj) = Para(ii,jj);
    end
end


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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% para %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f_max = 8500; %starting driving frequency
    alpha = 0.21; %for stage 1 - related to powerlaw decay constant
    gamma = 19.313; %for stage 2 - exponential decay constant
    f_thresh = 64; %determines the border between stage 2 and stage 3
    theta = 0.1; %max angle of rotations used. choose 0.1 or less in order for our discrete evolution to be a good Trotter approximation of a continuous evolution

    % pick out the relevant qubits
    pick = 1:6;
    % state of reference qubit
    s = 0;
    
    
    % Stage 1: Omega decays very quickly as 1/f(t) = 1/f(0) + alpha*t

alpha

% Stage 1 continuous until df/dt reduces to what it would be in the second stage.

% Stage 2: Omega decays exponentially as df(t)/dt = - gamma * f(t)

gamma

% Stage 2 continuous until f reaches roughly the value f_thresh at which the gap becomes
% constant

f_thresh


% Stage 3: f decays linearly in time, continuing at the rate at which
% it was decaying at the end of stage 2.

% Other params

theta %max angle of rotations used. chosen such that Trotter interpretation (Viewpoint 2) is valid

f_max %max effective strength of X pulse (going by what is experimentally feasilbe said), controls the smallest timestep
dt = (2/(2*pi))*theta/f_max; %this is the initial (and smallest) timestep



% will be used to keep track of Omega and dOmega/dt
fprevious = f_max;
dfdt = 0;

% will be used to keep track of t and number of timesteps
t_count = 0;
count = 0;


s = kron(ones(2^6)/2^(6),Iz);
%%%%%%%%%%%%%%%% stage 1 %%%%%%%%%%%%%%%%%%%%
while (exp(gamma*dt) <= 1+(2/(2*pi))*alpha*theta)
    %change timestep
    dt = dt*(1+(2/(2*pi))*alpha*theta);
    

%     s = expm(i*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})*theta-i*H*dt)*s*expm(i*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})*theta-i*H*dt)';
    
    
    %update tracking parameters
    fcurrent = 2*theta/(2*pi*dt);
    df = fcurrent-fprevious;
    t_count = t_count + dt;
    
         H_full = -pi*fcurrent*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})+H;
H_lab = expm(-i*Hfrot*t_count)*H_full* expm(i*Hfrot*t_count)+Hfrot;
s = expm(-i*H_lab*dt)*s*expm(-i*H_lab*dt)';

    count = count+1;
    dfdt = df/dt;
    fprevious = fcurrent;
    
    %store for plotting
    f(count) = fcurrent;
    t(count) = t_count;
    timestep(count) = dt;
    angle(count) = theta;

    %display
    display(['S1 -- f; df; df/f; t; dt; df/dt: ' num2str(fcurrent) '; ' num2str(df) '; ' num2str(df/fcurrent) '; ' num2str(t_count) '; ' num2str(dt) '; ' num2str(dfdt)]);   
end

%store time at end of stage 1
t2 = t_count;
count2 = count;



%%%%%%%%%%%%%%%% stage 2 %%%%%%%%%%%%%%%%%%%%
while (fprevious >= f_thresh)
    %change timestep
    dt = dt*exp(gamma*dt);
   
%     s = expm(i*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})*theta-i*H*dt)*s*expm(i*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})*theta-i*H*dt)';
    %update tracking parameters
    fcurrent = 2*theta/(2*pi*dt);
    df = fcurrent-fprevious;
    t_count = t_count + dt;
    
         H_full = -pi*fcurrent*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})+H;
H_lab = expm(-i*Hfrot*t_count)*H_full* expm(i*Hfrot*t_count)+Hfrot;
s = expm(-i*H_lab*dt)*s*expm(-i*H_lab*dt)';


    count = count+1;
    dfdt = df/dt;
    fprevious = fcurrent;
    
    %store for plotting
    f(count) = fcurrent;
    t(count) = t_count;
    timestep(count) = dt;
    angle(count) = theta;

    %display
    display(['S2 -- f; df; df/f; t; dt; df/dt: ' num2str(fcurrent) '; ' num2str(df) '; ' num2str(df/fcurrent) '; ' num2str(t_count) '; ' num2str(dt) '; ' num2str(dfdt)]);   
end

%store time at end of stage 1
t3 = t_count;
count3 = count;

%%%%%%%%%%%%%%%% stage 3 %%%%%%%%%%%%%%%%%%%%
while (fprevious >= 0)
    %update Omega linearly
    fcurrent = fprevious+df;
    
    %choose theta to realise this
    theta = (2*pi/2)*dt*fcurrent;

%     s = expm(i*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})*theta-i*H*dt)*s*expm(i*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})*theta-i*H*dt)';
    %update tracking parameters
    t_count = t_count + dt;
    
         H_full = -pi*fcurrent*(KIx{1}+KIx{2}+KIx{3}+KIx{4}+KIx{5}+KIx{6})+H;
H_lab = expm(-i*Hfrot*t_count)*H_full* expm(i*Hfrot*t_count)+Hfrot;
s = expm(-i*H_lab*dt)*s*expm(-i*H_lab*dt)';


    count = count+1;
    dfdt = df/dt;
    fprevious = fcurrent;
    
    %store for plotting
    f(count) = fcurrent;
    t(count) = t_count;
    timestep(count) = dt;
    angle(count) = theta;
    
    %display
    display(['S3 -- f; df; df/f; t; dt; df/dt: ' num2str(fcurrent) '; ' num2str(df) '; ' num2str(df/fcurrent) '; ' num2str(t_count) '; ' num2str(dt) '; ' num2str(dfdt)]);

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