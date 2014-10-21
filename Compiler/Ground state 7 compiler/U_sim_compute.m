%% Calculation of U_sim;
function rho_out=U_sim_compute(Bx, By, total_time, time_interval, T1, T2, rho_in)

load parameter.mat

Nsteps=round(total_time/time_interval);

eta{1}=rho_in;

count=0; num=0;
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
        eta{count+1}=A{count}*eta{count}*A{count}';
        %eta{count+1}=ad(eta{count+1}, (num+1)*time_interval, T1);
        eta{count+1}=pd(eta{count+1}, (num+1)*time_interval, T2);  
        num=0;
    end
end

if num>0
    eta{count+1}=expm(-i*H_int*num*time_interval)*eta{count+1}*(expm(-i*H_int*num*time_interval))';
    %eta{count+1}=ad(eta{count+1}, (num)*time_interval, T1);
    eta{count+1}=pd(eta{count+1}, (num)*time_interval, T2);  
else
    ;
end

rho_out=eta{count+1};