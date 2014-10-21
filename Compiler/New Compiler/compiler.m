%% Compile
function [U_sim, fidelity, rf_x, rf_y]=compiler(U_ideal, U_ideal_A, U_ideal_B, uncompiled_pulse);
% uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle, pulse_variance], compile option};
load parameter.mat
global nqubits sub_U_ideal_A sub_U_ideal_B time_interval; 
nqubits=7;

number=length(U_ideal);
for m=1:number
    if length(uncompiled_pulse{m})==1
        rf_x{m}=zeros(1,round(uncompiled_pulse{m}{1}(1)/uncompiled_pulse{m}{1}(2)));
        rf_y{m}=rf_x{m};
        U_sim{m}=U_ideal{m}; fidelity(m)=1;
    else
        sub_U_ideal_A=U_ideal_A{m}; sub_U_ideal_B=U_ideal_B{m}; time_interval=uncompiled_pulse{m}{1}(2);
%         [Bx, By]=selpulse({uncompiled_pulse{m}{1},uncompiled_pulse{m}{2}});    B=[Bx,By];
load x; load y; Bx=x; By=y; B=[Bx,By];
        Aeq=zeros(length(B),length(B)); beq=zeros(1,length(B));
        lb=-1500*ones(1,length(B)); ub=1500*ones(1,length(B));
        options=optimset('Algorithm','Interior-Point','SubproblemAlgorithm','ldl-factorization','MaxFunEvals',10000,'AlwaysHonorConstraints','bounds','GradObj','on','Hessian','lbfgs','LineSearchType','quadcubic','MaxIter',50,'display','iter');
        for k=1:10
            [B,fval]=fmincon(@Fidelity_sim,B,[],[],Aeq,beq,lb,ub,[],options);
            Bx=B(1:length(B)/2); By=B(length(B)/2+1:length(B));
            U_sim{m}=U_sim_calculation(Bx, By, uncompiled_pulse{m}{1}(1), uncompiled_pulse{m}{1}(2));
            fidelity(m)=abs(trace(U_ideal{m}*U_sim{m}'))^2/4^nqubits
            if fidelity(m)>0.9985
                break;
            else  ;
            end
        end
        rf_x{m}=Bx; rf_y{m}=By;
    end
    disp(fidelity(m));
end