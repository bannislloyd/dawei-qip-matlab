%% Calculate pre_errors and post_errors of the Real Unitary Compared With the Ideal Unitary: U_sim=U_pre_error*U_ideal*U_post_error;
function [pre_error, post_error, fidelity]=error_calculation(U_sim, U_ideal)

load parameter.mat
global nqubits

% Initial Guess;
count=0;
for m=1:nqubits
    for n=m:nqubits
        count=count+1;
        if m==n
            P{count}=gop(m,Z);
            scale(count)=2^3;
        else
            P{count}=gop(m,Z)*gop(n,Z);
            scale(count)=1;
        end
    end
end
P=[P,P]; scale=[scale,scale];

num=nqubits+nchoosek(nqubits,2);
phase_error=zeros(1,2*num);

% Optimization;
for k=1:100
    pre=0;
    for m=1:num
        pre=pre+phase_error(m)*P{m};
    end
    U_pre=expm(-i*pre/2*pi/180);
    post=0;
    for m=1:num
        post=post+phase_error(num+m)*P{m};
    end
    U_post=expm(-i*post/2*pi/180);
    
    fidelity=abs(trace(U_sim'*U_post*U_ideal*U_pre))^2/4^nqubits;
    disp(fidelity)
    
    for m=1:num
        g(m)=real(trace(U_sim'*U_post*U_ideal*U_pre*(-i*pi/360*P{m}))*conj(trace(U_sim'*U_post*U_ideal*U_pre)))/2^nqubits;
        g(m+num)=real(trace(U_sim'*(-i*pi/360*P{m})*U_post*U_ideal*U_pre)*conj(trace(U_sim'*U_post*U_ideal*U_pre)))/2^nqubits;
    end
    
    if fidelity<0.5
        l=2^3;
    elseif fidelity<0.9
        l=2^2;
    elseif fidelity<0.99
        l=2^1;
    else
        l=2^0;
    end
    
    for j=1:10
        phase_error_new=phase_error+l*scale.*g/norm(g);
        pre=0;
        for m=1:num
            pre=pre+phase_error_new(m)*P{m};
        end
        U_pre=expm(-i*pre/2*pi/180);
        post=0;
        for m=1:num
            post=post+phase_error_new(num+m)*P{m};
        end
        U_post=expm(-i*post/2*pi/180);
    
        fidelity_new=abs(trace(U_sim'*U_post*U_ideal*U_pre))^2/4^nqubits;
        if fidelity_new>fidelity
            phase_error=phase_error_new;
            break;
        else
            l=l/2;
        end       
    end
    
    if (fidelity_new-fidelity<1e-5)&(fidelity>0.95)
        break;
    else ;
    end
    
end

% Pre_errors and Post_errors;
count=0;
for m=1:nqubits
    for n=m:nqubits
        count=count+1;
        pre_error(m,n)=phase_error(count);
        post_error(m,n)=phase_error(num+count);
    end
end