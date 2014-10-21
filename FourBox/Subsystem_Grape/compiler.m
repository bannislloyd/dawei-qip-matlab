%% Compile
function [rf_x, rf_y]=compiler(U_ideal, uncompiled_pulse);
% uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle, pulse_variance], compile option};
load parameter.mat
global nqubits time_interval step Uideal; 
nqubits=7;

number=length(U_ideal);
for m=1:number                 
        Uideal = U_ideal{m};
        time_interval=uncompiled_pulse{m}{1}(2);
        step = round(uncompiled_pulse{m}{1}(1)/time_interval);
        % Initial Guess;
        x=0:1:2*step/10;xx=0:0.1:2*step/10;
        B=1000-2000*rand(1,2*step/10+1);
        B=spline(x,B,xx);
        B=B(1:2*step);
%        load Bx.mat
%        load By.mat
%        B = [Bx,By];

        Aeq=zeros(length(B),length(B)); beq=zeros(1,length(B));
        lb=-8000*ones(1,length(B)); ub=8000*ones(1,length(B)); % Important!!! try different ub and lb. Unit: Hz
        options=optimset('Algorithm','Interior-Point','SubproblemAlgorithm','ldl-factorization','MaxFunEvals',10000,'AlwaysHonorConstraints','bounds','GradObj','on','Hessian','lbfgs','LineSearchType','quadcubic','MaxIter',80,'display','iter');
        for k=1:3 % iterations for optimization. Can change 7 to other numbers
            [B,fval]=fmincon(@Fidelity_sim1,B,[],[],Aeq,beq,lb,ub,[],options); % optimize B by Fidelity_sim1 Function (GRAPE in subsystem)
            Bx=B(1:length(B)/2); By=B(length(B)/2+1:length(B));
        end
        rf_x{m}=Bx; rf_y{m}=By;
end