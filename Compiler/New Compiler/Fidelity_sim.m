%% Fidelity: return current fidelity and gradient;
function [f,g]=Fidelity_sim(B)

load parameter.mat
global sub_U_ideal_A sub_U_ideal_B time_interval;

M=length(B)/2;
f=0; g=zeros(1,2*M);

%%

U{1}=eye(8); count=0; num=0;
for j=1:M
    if (B(j)==0) & (B(j+M)==0)
        num=num+1;
    else
        count=count+1;
        if num>0
            A{count}=expm(-i*time_interval*(H_int_A+2*pi*(B(j)*(gopA(1,Ix)+gopA(2,Ix)+gopA(3,Ix))-B(j+M)*(gopA(1,Iy)+gopA(2,Iy)+gopA(3,Iy)))))*expm(-i*H_int_A*num*time_interval);
        else
            A{count}=expm(-i*time_interval*(H_int_A+2*pi*(B(j)*(gopA(1,Ix)+gopA(2,Ix)+gopA(3,Ix))-B(j+M)*(gopA(1,Iy)+gopA(2,Iy)+gopA(3,Iy)))));
        end
        num=0;
        U{count+1}=A{count}*U{count};
    end
end
if num>0
    U{count+1}=expm(-i*H_int_A*num*time_interval)*U{count+1};
else ;
end
U_sim=U{count+1};
f=f-1e+7*(abs(trace(sub_U_ideal_A'*U_sim)))^2/4^3;

count=0; num=0;
if nargout>1
    for j=1:M
        if (B(j)==0) & (B(j+M)==0)
            g(j)=0; g(j+M)=0;
        else
            count=count+1;
            g(j)=g(j)+1e+7*real(trace(i*time_interval*2*pi*sub_U_ideal_A'*(U_sim/U{count})*(gopA(1,Ix)+gopA(2,Ix)+gopA(3,Ix))*U{count})*conj(trace(sub_U_ideal_A'*U_sim)))/2^3;
            g(j+M)=g(j+M)-1e+7*real(trace(i*time_interval*2*pi*sub_U_ideal_A'*(U_sim/U{count})*(gopA(1,Iy)+gopA(2,Iy)+gopA(3,Iy))*U{count})*conj(trace(sub_U_ideal_A'*U_sim)))/2^3;
        end
    end
end


%%
%%

U{1}=eye(16); count=0; num=0;
for j=1:M
    if (B(j)==0) & (B(j+M)==0)
        num=num+1;
    else
        count=count+1;
        if num>0
            A{count}=expm(-i*time_interval*(H_int_B+2*pi*(B(j)*(gopB(1,Ix)+gopB(2,Ix)+gopB(3,Ix)+gopB(4,Ix))-B(j+M)*(gopB(1,Iy)+gopB(2,Iy)+gopB(3,Iy)+gopB(4,Iy)))))*expm(-i*H_int_B*num*time_interval);
        else
            A{count}=expm(-i*time_interval*(H_int_B+2*pi*(B(j)*(gopB(1,Ix)+gopB(2,Ix)+gopB(3,Ix)+gopB(4,Ix))-B(j+M)*(gopB(1,Iy)+gopB(2,Iy)+gopB(3,Iy)+gopB(4,Iy)))));
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
f=f-1e+7*(abs(trace(sub_U_ideal_B'*U_sim)))^2/4^4;
count=0; num=0;
if nargout>1
    for j=1:M
        if (B(j)==0) & (B(j+M)==0)
            g(j)=0; g(j+M)=0;
        else
            count=count+1;
            g(j)=g(j)+1e+7*real(trace(i*time_interval*2*pi*sub_U_ideal_B'*(U_sim/U{count})*(gopB(1,Ix)+gopB(2,Ix)+gopB(3,Ix)+gopB(4,Ix))*U{count})*conj(trace(sub_U_ideal_B'*U_sim)))/2^4;
            g(j+M)=g(j+M)-1e+7*real(trace(i*time_interval*2*pi*sub_U_ideal_B'*(U_sim/U{count})*(gopB(1,Iy)+gopB(2,Iy)+gopB(3,Iy)+gopB(4,Iy))*U{count})*conj(trace(sub_U_ideal_B'*U_sim)))/2^4;
        end
    end
end


f=f/2;