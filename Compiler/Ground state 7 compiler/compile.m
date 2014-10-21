%% Compile
function [compiled_pulse, U_sim, pre_error, post_error, phase_correction, fidelity]=compile(U_ideal, uncompiled_pulse)

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);
load parameter.mat

U_ideal{1} = rot(KIx{1},pi/2);
% the number of Cell U_ideal;
number=length(U_ideal);

Loop = 1; % iterative times

number  = 1;

load U.mat
U_sim{1} = U;

% uncompiled_pulse={[total_time, time_interval], [pulse_qubit, pulse_center, pulse_width, pulse_phase, pulse_angle], compile option};
for m=1:number
    
    for n=1:Loop
       % [Bx, By]=selpulse({uncompiled_pulse{m}{1},uncompiled_pulse{m}{2}});
      %  U_sim{m}=U_sim_calculation(Bx, By, uncompiled_pulse{m}{1}(1), uncompiled_pulse{m}{1}(2));
        [pre_error{m}, post_error{m}, fidelity(m)]=error_calculation(U_sim{m}, U_ideal{m});
        pre_error{m}
        post_error{m}
        fidelity(m)
        
        for k=1:size(uncompiled_pulse{m}{2},1)
            if strcmp(uncompiled_pulse{m}{3}{k}, 'I')
                phase_correction{m}(k)=-post_error{m}(uncompiled_pulse{m}{2}(k,1),uncompiled_pulse{m}{2}(k,1));
            elseif strcmp(uncompiled_pulse{m}{3}{k}, 'II')
                phase_correction{m}(k)=-post_error{m}(uncompiled_pulse{m}{2}(k,1),uncompiled_pulse{m}{2}(k,1));
            elseif strcmp(uncompiled_pulse{m}{3}{k}, 'III')
                phase_correction{m}(k)=pre_error{m}(uncompiled_pulse{m}{2}(k,1),uncompiled_pulse{m}{2}(k,1));
            end
        end
        if max(abs(phase_correction{m}))>0.01
            uncompiled_pulse{m}{2}(:,4)=uncompiled_pulse{m}{2}(:,4)+phase_correction{m}';
        else
            break ;
        end
        compiled_pulse{m}={uncompiled_pulse{m}{1},uncompiled_pulse{m}{2}};
    end
end




    


%% Calculation of U_sim;
function U_sim=U_sim_calculation(Bx, By, total_time, time_interval)

load parameter.mat

Nsteps=round(total_time/time_interval);

U{1}=eye(2^nqubits); count=0; num=0;
for j=1:Nsteps
    if (Bx(j)==0) & (By(j)==0)
        num=num+1;
    else
        count=count+1;
        if num>0
            A{count}=expm(-i*time_interval*(H_int+2*pi*(Bx(j)*(gop(1,Ix)+gop(2,Ix)+gop(3,Ix)+gop(4,Ix)+gop(5,Ix)+gop(6,Ix)+gop(7,Ix))-By(j)*(gop(1,Iy)+gop(2,Iy)+gop(3,Iy)+gop(4,Iy)+gop(5,Iy)+gop(6,Iy)+gop(7,Iy)))))*expm(-i*H_int*num*time_interval);
        else
            A{count}=expm(-i*time_interval*(H_int+2*pi*(Bx(j)*(gop(1,Ix)+gop(2,Ix)+gop(3,Ix)+gop(4,Ix)+gop(5,Ix)+gop(6,Ix)+gop(7,Ix))-By(j)*(gop(1,Iy)+gop(2,Iy)+gop(3,Iy)+gop(4,Iy)+gop(5,Iy)+gop(6,Iy)+gop(7,Iy)))));
        end
        num=0;
        U{count+1}=A{count}*U{count};
    end
end

if num>0
    U{count+1}=expm(-i*H_int*num*time_interval)*U{count+1};
else
    ;
end

U_sim=U{count+1};


%% File: gop.m (generalized operator)
% Date: 2005/07/14
% Author: Xinhua Peng
%
% Usage: gop(s,U)
% In: single-qubit unitary operator U, qubit name s 
% Out: n-spin unitary operator which acts on qubit s with U and
% trivially on the remaining qubits
% Order: 1,2,3,4 from high to low bit
function gop=gop(s,U)

global nqubits
goplocal=U;

for position=1:(s-1)
    goplocal=kron(eye(2),goplocal);
end

for position=s+1:nqubits
    goplocal=kron(goplocal,eye(2));
end

gop=goplocal;

%% Generate the Unitary Matrix for Rotation Around a Product Operator;
function R=R(operator, angle)
R=expm(-i*operator/2*angle*pi/180);