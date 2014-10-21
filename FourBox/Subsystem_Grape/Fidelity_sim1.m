%% Fidelity: return current fidelity and gradient;
function [f,g]=Fidelity_sim1(B)

load parameter.mat
global time_interval Uideal;

M=length(B)/2;
f=0; g=zeros(1,2*M);
IX=gop(1,Ix)+gop(2,Ix)+gop(3,Ix)+gop(4,Ix)+gop(5,Ix)+gop(6,Ix)+gop(7,Ix);
IY=gop(1,Iy)+gop(2,Iy)+gop(3,Iy)+gop(4,Iy)+gop(5,Iy)+gop(6,Iy)+gop(7,Iy);

% Calculation of fidelity;
l=1;
for j=1:M
    A{j}=expm(-i*time_interval*(H_int+2*pi*(B(j)*IX-B(j+M)*IY)));
    if j>1
        U{j}=A{j}*U{j-1};
    else
        U{j}=A{j};
    end
end

f=f-1e+7*(abs(trace(Uideal'*U{M})))^2/4^7;

if nargout>1
    for k=1:M
        g(k)=g(k)+1e+8*real(trace(i*time_interval*2*pi*Uideal'*(U{M}/U{k})*IX*U{k})*conj(trace(Uideal'*U{M})))/2^7;
    end
    for k=M+1:2*M
        g(k)=g(k)-1e+8*real(trace(i*time_interval*2*pi*Uideal'*(U{M}/U{k-M})*IY*U{k-M})*conj(trace(Uideal'*U{M})))/2^7;
    end
end
