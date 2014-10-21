%% Fidelity: return current fidelity and gradient;
function [f,g]=Fidelity_sim1(B)

load parameter.mat
global sub_U_ideal_A sub_U_ideal_B time_interval;

a = 1;

M=length(B)/4;
f=0; g=zeros(1,4*M);
IX_A_1=gopA(1,Ix)+gopA(2,Ix)+gopA(3,Ix);IY_A_1=gopA(1,Iy)+gopA(2,Iy)+gopA(3,Iy);
IX_A_2=gopA(4,Ix)+gopA(5,Ix)+gopA(6,Ix);IY_A_2=gopA(4,Iy)+gopA(5,Iy)+gopA(6,Iy);
IX_B_1=gopB(1,Ix)+gopB(2,Ix)+gopB(3,Ix)+gopB(4,Ix);IY_B_1=gopB(1,Iy)+gopB(2,Iy)+gopB(3,Iy)+gopB(4,Iy);
IX_B_2=gopB(5,Ix)+gopB(6,Ix);IY_B_2=gopB(5,Iy)+gopB(6,Iy);

%% subsystem A %%
U{1}=eye(2^6); count=0; num=0;
for j=1:M
    if (B(j)==0) & (B(j+M)==0)&(B(j+2*M)==0) &(B(j+3*M)==0) % if the jth step is Free Evolution, go to judge j+1 step
        num=num+1;
    else % if not Free evolution, calculate the current step unitary
        count=count+1;
        if num>0
            A{count}=expm(-i*time_interval*(H_int_A+2*pi*(B(j)*IX_A_1-B(j+M)*IY_A_1+B(j+2*M)*IX_A_2-B(j+3*M)*IY_A_2)))*expm(-i*H_int_A*num*time_interval);
        else
            A{count}=expm(-i*time_interval*(H_int_A+2*pi*(B(j)*IX_A_1-B(j+M)*IY_A_1+B(j+2*M)*IX_A_2-B(j+3*M)*IY_A_2)));
        end
        num=0;
        U{count+1}=A{count}*U{count};
    end
end

% judge if there are still Free Evolutions after U{count+1}
if num>0
    U{count+1}=expm(-i*H_int_A*num*time_interval)*U{count+1};
else ;
end
U_sim=U{count+1};
f=f-1e+7*(abs(trace(sub_U_ideal_A'*U_sim)))^2/4^6;
count=0; num=0;
if nargout>1
    for j=1:M
        if (B(j)==0) & (B(j+M)==0)&(B(j+2*M)==0) &(B(j+3*M)==0)
            g(j)=0; g(j+M)=0;g(j+2*M)=0; g(j+3*M)=0;
        else
            count=count+1;
            g(j)=g(j)+a*1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_A'*(U_sim/U{count})*IX_A_1*U{count})*conj(trace(sub_U_ideal_A'*U_sim)))/2^6;
            g(j+M)=g(j+M)-a*1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_A'*(U_sim/U{count})*IY_A_1*U{count})*conj(trace(sub_U_ideal_A'*U_sim)))/2^6;
            g(j+2*M)=g(j+2*M)+a*1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_A'*(U_sim/U{count})*IX_A_2*U{count})*conj(trace(sub_U_ideal_A'*U_sim)))/2^6;
            g(j+3*M)=g(j+3*M)-a*1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_A'*(U_sim/U{count})*IY_A_2*U{count})*conj(trace(sub_U_ideal_A'*U_sim)))/2^6;
        end
    end
end

%% subsystem B %%
U{1}=eye(2^6); count=0; num=0;
for j=1:M
    if (B(j)==0) & (B(j+M)==0)&(B(j+2*M)==0) &(B(j+3*M)==0) % if the jth step is Free Evolution, go to judge j+1 step
        num=num+1;
    else % if not Free evolution, calculate the current step unitary
        count=count+1;
        if num>0
            A{count}=expm(-i*time_interval*(H_int_B+2*pi*(B(j)*IX_B_1-B(j+M)*IY_B_1+B(j+2*M)*IX_B_2-B(j+3*M)*IY_B_2)))*expm(-i*H_int_B*num*time_interval);
        else
            A{count}=expm(-i*time_interval*(H_int_B+2*pi*(B(j)*IX_B_1-B(j+M)*IY_B_1+B(j+2*M)*IX_B_2-B(j+3*M)*IY_B_2)));
        end
        num=0;
        U{count+1}=A{count}*U{count};
    end
end
if num>0
    U{count+1}=expm(-i*H_int_B*num*time_interval)*U{count+1};
else ;
end
U_sim=U{count+1};
f=f-1e+7*(abs(trace(sub_U_ideal_B'*U_sim)))^2/4^6;
count=0; num=0;
if nargout>1
    for j=1:M
        if (B(j)==0) & (B(j+M)==0)&(B(j+2*M)==0) &(B(j+3*M)==0)
            g(j)=0; g(j+M)=0;g(j+2*M)=0; g(j+3*M)=0;
        else
            count=count+1;
            g(j)=g(j)+a*1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_B'*(U_sim/U{count})*IX_B_1*U{count})*conj(trace(sub_U_ideal_B'*U_sim)))/2^6;
            g(j+M)=g(j+M)-a*1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_B'*(U_sim/U{count})*IY_B_1*U{count})*conj(trace(sub_U_ideal_B'*U_sim)))/2^6;
            g(j+2*M)=g(j+2*M)+a*1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_B'*(U_sim/U{count})*IX_B_2*U{count})*conj(trace(sub_U_ideal_B'*U_sim)))/2^6;
            g(j+3*M)=g(j+3*M)-a*1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_B'*(U_sim/U{count})*IY_B_2*U{count})*conj(trace(sub_U_ideal_B'*U_sim)))/2^6;
        end
    end
end


f=f/2;