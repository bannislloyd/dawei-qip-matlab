%% Define Molecule Hamiltonian;

clear;

global nqubits;  nqubits=7;

I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 

Hamiltonian=[30020,  57.56,  -2.03,  -0.94,   -1.14,    5.54,   0.97;
             57.56,  8778,   32.7,   0.5,     2.8,      -1.7,   37.48;
             -2.03,  32.7,   6245,   0,       1.11,     0,      0.94;
             -0.94,  0.5,    0,      10332.6, 33.07,    -3.53,  29.02;
             -1.14,  2.8,    1.11,   33.07,   15744.72, 33.5,   -21.75;
             5.54,   -1.7,   0,      -3.53,   33.5,     34380,  34.57;
             0.97,   37.48,  0.94,   29.02,   -21.75,   34.57,  11927.5];
         
Hamiltonian_matrix=Hamiltonian/4+diag(diag(Hamiltonian),0)/2;

o1=20696;

Hamiltonian_rotatingframe=Hamiltonian-o1*eye(nqubits);
Hamiltonian_rotatingframe_matrix=Hamiltonian_rotatingframe/4+diag(diag(Hamiltonian_rotatingframe),0)/4;

w=diag(Hamiltonian_rotatingframe);
J=triu(Hamiltonian_rotatingframe,1);

H_w=0; 
for n=1:nqubits
    H_w=H_w+2*pi*Hamiltonian_rotatingframe(n,n)*gop(n,Iz);
end

H_J=0;
for m=1:nqubits-1
    for n=m+1:nqubits
        H_J=H_J+2*pi*Hamiltonian_rotatingframe(m,n)*gop(m,Iz)*gop(n,Iz);
    end
end

H_int=H_w+H_J;