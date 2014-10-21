clear;

%% Initial State
Ini_coh1(1) = 1.011; %Z7
Ini_coh1(2) = 0.9609; %Z6
Ini_coh1(3) = 0.9632; %Z5
Ini_coh1(4) = 1.0105; %Z4
Ini_coh1(5) = 0.9808; %Z3
Ini_coh1(6) = 1.0160; %Z2
Ini_coh1(7) = 1.0078; %Z1

Ini_coh1 = Ini_coh1/max(Ini_coh1);
mean(Ini_coh1)
std(Ini_coh1)
%% Final State
Coefficient7 = 2.2204;
Decoherence = 0.813;

% Z7 X7 Y7
Fin_coh1(1) = (0.0759+0.2130+0.0898)*Coefficient7; %Z123456 X7 
Fin_coh1(2) = 0.712; %I123456 X7
Fin_coh1(3) = (0.1039+0.2141+0.1071)*Coefficient7; %Z123456 Y7

% Z6 X6 Y6
Fin_coh1(4) = 0.6737/Decoherence; % 
Fin_coh1(5) = 0.059*16; %I123456 X7
Fin_coh1(6) = 0.0606*16; %Z123456 Y7

% Z5 X5 Y5
Fin_coh1(7) = 0.8304/Decoherence; % 
Fin_coh1(8) = 0.0482*16; %I123456 X7
Fin_coh1(9) = 0.0465*16; %Z123456 Y7

% Z4 X4 Y4
Fin_coh1(10) = 0.6403/Decoherence; % 
Fin_coh1(11) = 0.0619*16; %I123456 X7
Fin_coh1(12) = 0.0482*16; %Z123456 Y7

% Z3 X3 Y3
Fin_coh1(13) = 0.7992/Decoherence; % 
Fin_coh1(14) = 0; %I123456 X7
Fin_coh1(15) = 0; %Z123456 Y7

% Z2 X2 Y2
Fin_coh1(16) = 0.0985*8/Decoherence; % 
Fin_coh1(17) = 0.1191*8; %I123456 X7
Fin_coh1(18) = 0; %Z123456 Y7

% Z1 X1 Y1
Fin_coh1(19) = 0.8316/Decoherence; % 
Fin_coh1(20) = 0; %I123456 X7
Fin_coh1(21) = 0; %Z123456 Y7

jj = 1;
for ii = 1:length(Fin_coh1)
    if Fin_coh1(ii)>0.8
        Exp_coh1(jj) = Fin_coh1(ii)/1.016;%Decoherence;
        jj = jj+1;
    end
end

lamda_1 = mean(Exp_coh1)
delta_1 = std(Exp_coh1)

%Pr_1 = 2*exp(-0.05^2*1600/2)