clear;

% HI Dawei
% This is the data for simulations only, the actual experiment will have only a few data points for each of these (possibly just 1). 
% The first simulation should be theta=pi/4 changing g from 0 to pi/2. The second simulation should be the same but with cot(theta)=[-1-sqrt(5)]/2. 
% The third simulation is the strong measurement g= pi/2 and varying theta.
% The last simulation will be a weak measurement but we need to see the result of the first two to decide on g. 

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(5);
%% pre-selection
% initial state 00000
input = zeros(32);
input(1,1) = 1;

% theta = acot((-1-sqrt(5))/2); % for the first rotation
% phi = acot((-1-sqrt(5))/2); % for the second rotation
theta = pi/4; % for the first rotation
phi = pi/4; % for the second rotation
temp_angle = acos((cos(phi)+sin(phi))/sqrt(2)); % rotating angle for the 2nd rotation
U1 = rot(KIy{1},2*theta);
U2 = rot(KIy{1},2*temp_angle);

NOT4 = i*rot(KIx{4},pi);

rho_1 = (Hadamard(5,5)*NOT4*U1)*input*(Hadamard(5,5)*NOT4*U1)'; % state after pre-selection
%% weak measurement
fid=fopen('theta_45.txt','w'); 

for jj = 1:4
    if jj == 1
        fprintf(fid, '----- Plus 0 -----\n');
    else if jj == 2
            fprintf(fid, '----- Plus 1 -----\n');
            else if jj == 3
            fprintf(fid, '----- Minus 0 -----\n');
            else 
            fprintf(fid, '----- Minus 1 -----\n');
                end
        end
    end
for g = 0:0.1:1.6
% Four kinds of control-control-rotation
STP = 1/2*[1,1;1,1]; % state plus
STM = 1/2*[1,-1;-1,1]; % state minus
R = expm(i*g*sigma_x);
% 0+
    if jj == 1
        CCR = kron(kron(kron(kron(STP,ST0),R),I),I)+kron(kron(kron(kron(STP,ST1),I),I),I)+kron(kron(kron(kron(STM,ST0),I),I),I)++kron(kron(kron(kron(STM,ST1),I),I),I);
    else if jj == 2
            CCR = kron(kron(kron(kron(STP,ST1),R),I),I)+kron(kron(kron(kron(STP,ST0),I),I),I)+kron(kron(kron(kron(STM,ST0),I),I),I)++kron(kron(kron(kron(STM,ST1),I),I),I);
            else if jj == 3
            CCR = kron(kron(kron(kron(STM,ST0),R),I),I)+kron(kron(kron(kron(STP,ST1),I),I),I)+kron(kron(kron(kron(STP,ST0),I),I),I)++kron(kron(kron(kron(STM,ST1),I),I),I);
            else 
            CCR = kron(kron(kron(kron(STM,ST1),R),I),I)+kron(kron(kron(kron(STP,ST1),I),I),I)+kron(kron(kron(kron(STM,ST0),I),I),I)++kron(kron(kron(kron(STP,ST0),I),I),I);
                end
        end
    end


rho_2 = (CCR*CNOT(1,2,5))*rho_1*(CCR*CNOT(1,2,5))';
%rho_2 = rho_1;
%% post-selection
NOT1 = i*rot(KIx{1},pi);
NOT2 = i*rot(KIx{2},pi);
%CCN = kron(kron(kron(kron(ST0,ST0),I),I),I)+kron(kron(kron(kron(ST0,ST1),I),I),I)+kron(kron(kron(kron(ST1,ST0),I),I),I)+kron(kron(kron(kron(ST1,ST1),I),sigma_x),I);
CCN = kron(kron(kron(kron(I,I),I),I),I)-kron(kron(kron(kron(ST1,ST1),I),I),I)+kron(kron(kron(kron(ST1,ST1),I),sigma_x),I);
CCS = (kron(kron(kron(kron(I,I),I),ST0),I)+kron(kron(kron(kron(I,I),ST0),ST1),I)+kron(kron(kron(kron(I,I),ST1),ST1),sigma_x))*...
    (kron(kron(kron(kron(I,I),I),ST0),I)+kron(kron(kron(kron(I,I),I),ST1),ST0)+kron(kron(kron(kron(I,I),sigma_x),ST1),ST1))*...
    (kron(kron(kron(kron(I,I),I),ST0),I)+kron(kron(kron(kron(I,I),ST0),ST1),I)+kron(kron(kron(kron(I,I),ST1),ST1),sigma_x));

rho_3 = (CCS*CCN*NOT1*NOT2*Hadamard(2,5)*U2')*rho_2*(CCS*CCN*NOT1*NOT2*Hadamard(2,5)*U2')';
rho_3 = (CCS*CCN*NOT1*NOT2*Hadamard(2,5)*U2')*rho_2*(CCS*CCN*NOT1*NOT2*Hadamard(2,5)*U2')';;
%% weak value
sigma_y_md = trace(rho_3*2*KIy{3});
sigma_z_md = trace(rho_3*2*KIz{3});
sigma_z_ps = trace(rho_3*2*KIz{4});

fprintf(fid, 'g: %1.1f, ',g);
fprintf(fid, '<y3>: %1.3f, ',sigma_y_md);
fprintf(fid, '<z3>: %1.3f, ',sigma_z_md);
fprintf(fid, '<z4>:%1.3f\n',sigma_z_ps);
% Re_weak_value = sigma_y_md/(sigma_z_ps+1)/g % Re of the weak value by measuring sigma_y on the device
end
end

