clear;
% labeling C5,C4,C7,C2,C6. 
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

%% pre-selection
% initial state 0000000
input = zeros(64);
input(1,1) = 1;
input = kron(input,Iz);
% input = kron(Iz,input);

% theta = acot((-1-sqrt(5))/2); % for the first rotation
% phi = acot((-1-sqrt(5))/2); % for the second rotation
theta = pi/4; % for the first rotation
phi = pi/4; % for the second rotation
temp_angle = acos((cos(phi)+sin(phi))/sqrt(2)); % rotating angle for the 2nd rotation
U1 = rot(KIy{5},2*theta);
U2 = rot(KIy{5},2*temp_angle);

NOT4 = rot(KIx{2},pi);

rho_1 = (Hadamard(6,7)*NOT4*U1)*input*(Hadamard(6,7)*NOT4*U1)'; % state after pre-selection

%% weak measurement
fid=fopen('theta_45_exp.txt','w'); 

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
STP = 1/2*[1,1;1,1]; % state plus
STM = 1/2*[1,-1;-1,1]; % state minus
R = expm(i*g*sigma_x);
    if jj == 1
        CCR = MultiKron(7,I,I,I,ST0,STP,I,R)+MultiKron(7,I,I,I,ST1,STP,I,I)+MultiKron(7,I,I,I,ST0,STM,I,I)+MultiKron(7,I,I,I,ST1,STM,I,I);
    else if jj == 2
            CCR = MultiKron(7,I,I,I,ST0,STP,I,I)+MultiKron(7,I,I,I,ST1,STP,I,R)+MultiKron(7,I,I,I,ST0,STM,I,I)+MultiKron(7,I,I,I,ST1,STM,I,I);
            else if jj == 3
            CCR = MultiKron(7,I,I,I,ST0,STP,I,I)+MultiKron(7,I,I,I,ST1,STP,I,I)+MultiKron(7,I,I,I,ST0,STM,I,R)+MultiKron(7,I,I,I,ST1,STM,I,I);
            else 
            CCR = MultiKron(7,I,I,I,ST0,STP,I,I)+MultiKron(7,I,I,I,ST1,STP,I,I)+MultiKron(7,I,I,I,ST0,STM,I,I)+MultiKron(7,I,I,I,ST1,STM,I,R);
                end
        end
    end
rho_2 = (CCR*CNOT(5,4,7))*rho_1*(CCR*CNOT(5,4,7))';

%% post-selection
NOT1 = rot(KIx{5},pi);
NOT2 = rot(KIx{4},pi);

CCN = MultiKron(7,I,I,I,I,I,I,I)-MultiKron(7,I,I,I,ST1,ST1,I,I)+MultiKron(7,I,sigma_x,I,ST1,ST1,I,I);
CCS = (MultiKron(7,I,ST0,I,I,I,I,I)+MultiKron(7,I,ST1,I,I,I,I,ST0)+MultiKron(7,I,ST1,I,I,I,sigma_x,ST1))*...
    (MultiKron(7,I,ST0,I,I,I,I,I)+MultiKron(7,I,ST1,I,I,I,ST0,I)+MultiKron(7,I,ST1,I,I,I,ST1,sigma_x))*...
    (MultiKron(7,I,ST0,I,I,I,I,I)+MultiKron(7,I,ST1,I,I,I,I,ST0)+MultiKron(7,I,ST1,I,I,I,sigma_x,ST1));

rho_3 =  (CCS*CCN*NOT1*NOT2*Hadamard(4,7)*U2')*rho_2*(CCS*CCN*NOT1*NOT2*Hadamard(4,7)*U2')';

After_U2 = CCS*CCN*NOT1*NOT2*Hadamard(4,7);
save After_U2.mat After_U2
%% weak value
sigma_y_md = trace(rho_3*2*KIy{7});
sigma_z_md = trace(rho_3*2*KIz{7});
sigma_z_ps = trace(rho_3*2*KIz{2}*KIz{7});

fprintf(fid, 'g: %1.1f, ',g);
fprintf(fid, '<y7>: %1.3f, ',sigma_y_md);
fprintf(fid, '<z7>: %1.3f, ',sigma_z_md);
fprintf(fid, '<z2>:%1.3f\n',sigma_z_ps);
% Re_weak_value = sigma_y_md/(sigma_z_ps+1)/g % Re of the weak value by measuring sigma_y on the device
end
end