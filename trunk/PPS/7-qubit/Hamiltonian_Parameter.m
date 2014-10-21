%%% Define Molecule Hamiltonian;

clear;

I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 

system_N=7; subsystem_A_N=3; subsystem_B_N=4; subsystem_A=[1,2,3]; subsystem_B=[4,5,6,7];

%% Define System Hamiltonian;         
         H=[30020.877/2,  28.79,  -1.0,  0.02,   0.625,    2.7981,   -0.7177;
             28.79,  8778.95/2,  16.3531,   0.15,     1.31,      -0.83,   18.7132;
             -1.0,  16.3531,   6245.16675/2,   0,       -0.555,     0,      0.47;
             0.02,  0.15,    0,      10333.55/2, 16.58,    -1.765,  14.51;
             0.625,  1.31,    -0.555,   16.58,   15745.42/2, 16.58,   10.875;
             2.7981,   -0.83,   0,      -1.765,   16.58,     34381.5934/2,  17.285;
             -0.7177,   18.7132,  0.47,   14.51,   10.875,   17.285,  11928.21998/2];
         
         H = H*2;

o1=20696;

H_rotframe=H-o1*eye(system_N);
w=diag(H_rotframe); J=triu(H_rotframe,1);

H_w=0; 
for n=1:system_N
    H_w=H_w+2*pi*H_rotframe(n,n)*gop(n,Iz);
end

H_J=0;
for m=1:system_N-1
    for n=m+1:system_N
        H_J=H_J+2*pi*H_rotframe(m,n)*gop(m,Iz)*gop(n,Iz);
    end
end

H_int=H_w+H_J;

%% Define Subsystem A Hamiltonian;
for k=1:subsystem_A_N
    for j=1:subsystem_A_N
        H_rotframe_A(k,j)=H_rotframe(subsystem_A(k),subsystem_A(j));
    end
end
H_w_A=0;
for k=1:subsystem_A_N
    H_w_A=H_w_A+2*pi*H_rotframe_A(k,k)*gopA(k,Iz);
end
H_J_A=0;
for k=1:subsystem_A_N-1
    for j=k+1:subsystem_A_N
        H_J_A=H_J_A+2*pi*H_rotframe_A(k,j)*gopA(k,Iz)*gopA(j,Iz);
    end
end
H_int_A=H_w_A+H_J_A;


%% Define Subsystem B Hamiltonian;
for k=1:subsystem_B_N
    for j=1:subsystem_B_N
        H_rotframe_B(k,j)=H_rotframe(subsystem_B(k),subsystem_B(j));
    end
end
H_w_B=0;
for k=1:subsystem_B_N
    H_w_B=H_w_B+2*pi*H_rotframe_B(k,k)*gopB(k,Iz);
end
H_J_B=0;
for k=1:subsystem_B_N-1
    for j=k+1:subsystem_B_N
        H_J_B=H_J_B+2*pi*H_rotframe_B(k,j)*gopB(k,Iz)*gopB(j,Iz);
    end
end
H_int_B=H_w_B+H_J_B;

save parameter.mat