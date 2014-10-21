% file: pd2.m
% April 2001
% Lieven Vandersypen <lieven@snow.stanford.edu>
%
%simulates phase damping (PD), 7 spins
% model assumes no correlation of PD on different spins
%
% Usage rout=pd(rin,t,ratio)
%
% rin initial density matrix
% t duration for which PD acts
% ratio set this to 1 to simulate PD, set this to say 1e9 to
% simulate the same sequence without PD
% rout final density matrix

function rout=pd(rin,t,T2)
  

global nqubits 


% T2 effects on each spin 
for n = 1:nqubits
    g=(1+exp(-t/T2(n)))/2;
    E{1}=sqrt(g)*[1 0; 0 1]; E{2}=sqrt(1-g)*[1 0;0 -1];
    r{n}=0;
    if n == 1
        for k=1:2
        r{n} = r{n} + gop(nqubits, E{k})*rin*gop(nqubits, E{k})';
        end
    else
        for k=1:2
        r{n} = r{n} + gop(nqubits, E{k})*r{n-1}*gop(nqubits, E{k})';
        end
    end     
end


rout=r{n};