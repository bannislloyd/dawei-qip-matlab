% Fidelity: return current fidelity and gradient;
function [f,g]=Fidelity(B)
global H_int Uideal M t I Ix Iy Iz;
g=zeros(1,4*M);  % gradient;
f=0;

% Calculation of fidelity;
l=1;
for j=1:M
    A{j}=expm(-i*t*(H_int+2*pi*(0.95+0.05*l)*(B(j)*(kron(kron(Ix,I),I)+kron(kron(I,Ix),I))-B(j+M)*(kron(kron(Iy,I),I)+kron(kron(I,Iy),I))+B(j+2*M)*kron(kron(I,I),Ix)-B(j+3*M)*kron(kron(I,I),Iy))));
    if j>1
        U{j}=A{j}*U{j-1};
    else
        U{j}=A{j};
    end
end

f=f-1e+7*(abs(trace(Uideal'*U{M})))^2/64;

% Calculation of gradient;
if nargout>1
    for k=1:M
        g(k)=g(k)+1e+8*real(trace(i*t*2*pi*(0.95+0.05*l)*Uideal'*(U{M}/U{k})*(kron(kron(Ix,I),I)+kron(kron(I,Ix),I))*U{k})*conj(trace(Uideal'*U{M})))/32;
    end
    for k=M+1:2*M
        g(k)=g(k)-1e+8*real(trace(i*t*2*pi*(0.95+0.05*l)*Uideal'*(U{M}/U{k-M})*(kron(kron(Iy,I),I)+kron(kron(I,Iy),I))*U{k-M})*conj(trace(Uideal'*U{M})))/32;
    end
    for k=2*M+1:3*M
        g(k)=g(k)+1e+8*real(trace(i*t*2*pi*(0.95+0.05*l)*Uideal'*(U{M}/U{k-2*M})*kron(kron(I,I),Ix)*U{k-2*M})*conj(trace(Uideal'*U{M})))/32;
    end
    for k=3*M+1:4*M
        g(k)=g(k)-1e+8*real(trace(i*t*2*pi*(0.95+0.05*l)*Uideal'*(U{M}/U{k-3*M})*kron(kron(I,I),Iy)*U{k-3*M})*conj(trace(Uideal'*U{M})))/32;
    end
end

f=f;
g=g;