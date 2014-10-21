%% Fidelity: return current fidelity and gradient;
function [f,g]=Fidelity_sim(B)

load parameter.mat
global sub_U_ideal_A sub_U_ideal_B time_interval; 

M=length(B)/2;
f=0; g=zeros(1,2*M);

IX=zeros(8,8); IY=zeros(8,8);
for k=1:3
    IX=IX+gopA(k,Ix);
    IY=IY+gopA(k,Iy);
end
for l=1:3
    for j=1:M
        A{j}=expm(-i*time_interval*(H_int_A+2*pi*70*(l-2)*gopA(2,Iz)+2*pi*(B(j)*IX-B(j+M)*IY)));
        if j>1
            U{j}=A{j}*U{j-1};
        else
            U{j}=A{j};
        end
    end
    f=f-1e+7*(abs(trace(sub_U_ideal_A'*U{M})))^2/4^3;
    if nargout>1
        for k=1:M
            g(k)=g(k)+1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_A'*(U{M}/U{k})*IX*U{k})*conj(trace(sub_U_ideal_A'*U{M})))/2^3;
        end
        for k=M+1:2*M
            g(k)=g(k)-1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_A'*(U{M}/U{k-M})*IY*U{k-M})*conj(trace(sub_U_ideal_A'*U{M})))/2^3;
        end
    end
end


IX=zeros(16,16); IY=zeros(16,16);
for k=1:4
    IX=IX+gopB(k,Ix);
    IY=IY+gopB(k,Iy);
end
for l=1:3
    for j=1:M
        A{j}=expm(-i*time_interval*(H_int_B+2*pi*70*(l-2)*gopB(4,Iz)+2*pi*(B(j)*IX-B(j+M)*IY)));
        if j>1
            U{j}=A{j}*U{j-1};
        else
            U{j}=A{j};
        end
    end
    f=f-1e+7*(abs(trace(sub_U_ideal_B'*U{M})))^2/4^4;
    if nargout>1
        for k=1:M
            g(k)=g(k)+1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_B'*(U{M}/U{k})*IX*U{k})*conj(trace(sub_U_ideal_B'*U{M})))/2^4;
        end
        for k=M+1:2*M
            g(k)=g(k)-1e+8*real(trace(i*time_interval*2*pi*sub_U_ideal_B'*(U{M}/U{k-M})*IY*U{k-M})*conj(trace(sub_U_ideal_B'*U{M})))/2^4;
        end
    end
end

f=f/6;