%% Compile
function [U_sim, fidelity, rf_x, rf_y]=compiler(U_ideal_A, U_ideal_B, uncompiled_pulse);
% uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle, pulse_variance], compile option};
load parameter.mat
global nqubits sub_U_ideal_A sub_U_ideal_B time_interval; 
nqubits=12;

number=length(U_ideal_A);
for m=1:number   
    if length(uncompiled_pulse{m})==1 % no initial Gaussian guess
        rf_x{m}=zeros(1,round(uncompiled_pulse{m}{1}(1)/uncompiled_pulse{m}{1}(2)));
        rf_y{m}=zeros(1,round(uncompiled_pulse{m}{1}(1)/uncompiled_pulse{m}{1}(2)));
        U_sim{m}=U_ideal{m}; fidelity(m)=1;
    else                
        sub_U_ideal_A=U_ideal_A{m}; sub_U_ideal_B=U_ideal_B{m}; time_interval=uncompiled_pulse{m}{1}(2);
        [Bx, By]=selpulse({uncompiled_pulse{m}{1},uncompiled_pulse{m}{2}});   % generate Gaussian pulse as initial guess
        Bx2 = zeros(1,length(Bx)); By2 = zeros(1,length(By));
        B=[Bx,By,Bx2, By2]; % first half of B is Bx, second half is By
        Aeq=zeros(length(B),length(B)); beq=zeros(1,length(B));
        lb=-10000*ones(1,length(B)); ub=10000*ones(1,length(B)); % Important!!! try different ub and lb. Unit: Hz
        options=optimset('Algorithm','Interior-Point','SubproblemAlgorithm','ldl-factorization','MaxFunEvals',10000,'AlwaysHonorConstraints','bounds','GradObj','on','Hessian','lbfgs','LineSearchType','quadcubic','MaxIter',80,'display','iter');
        for k=1:1 % iterations for optimization. Can change 7 to other numbers
            [B,fval]=fmincon(@Fidelity_sim1,B,[],[],Aeq,beq,lb,ub,[],options); % optimize B by Fidelity_sim1 Function (GRAPE in subsystem)
%             Bx=B(1:length(B)/2); By=B(length(B)/2+1:length(B));
%             U_sim{m}=U_sim_calculation(Bx, By, uncompiled_pulse{m}{1}(1), uncompiled_pulse{m}{1}(2));
%             fidelity(m)=abs(trace(U_ideal{m}*U_sim{m}'))^2/4^nqubits; disp(fidelity(m));
%             if fidelity(m)>0.9985
%                 break;
%             else ;
%             end
        end
%         rf_x{m}=Bx; rf_y{m}=By;
    end
end