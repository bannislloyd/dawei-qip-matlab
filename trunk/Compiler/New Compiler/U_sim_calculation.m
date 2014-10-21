%% Calculation of U_sim;
function U_sim=U_sim_calculation(Bx, By, total_time, time_interval)

load parameter.mat
global nqubits

size=round(total_time/time_interval);

U{1}=eye(2^nqubits); count=0; num=0;
for j=1:size
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