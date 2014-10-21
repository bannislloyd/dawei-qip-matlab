%%% Define Molecule Hamiltonian;
clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(6);

I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 

system_N=12; subsystem_A_N=6; subsystem_B_N=6; subsystem_A=[1,2,3,9,10,11]; subsystem_B=[4,5,6,7,8,12];

%% Define System Hamiltonian;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The diagonal elements of Para: C1-C7,H1-H5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Para = zeros(12);

Para(1,1) = 30020.877; Para(2,2) = 8778.95; Para(3,3) = 6245.16675; Para(4,4) = 10333.55; Para(5,5) = 15745.42; Para(6,6) = 34381.5934;
Para(7,7) = 11928.21998; Para(8,8) = 3310; Para(9,9) = 2468; Para(10,10) = 2158; Para(11,11) = 2692; Para(12,12) = 3649;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The off-diagonal elements of Para: J-couplings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Para(1,2) = 57.58; Para(1,3) = -2.00; Para(1,4) = 0; Para(1,5) = 1.25; Para(1,6) = 5.54; Para(1,7) = -1.25;
Para(1,8) = 0; Para(1,9) = 4.41;Para(1,10) = 1.81; Para(1,11) = -13.19; Para(1,12) = 7.87;

Para(2,3) = 32.70; Para(2,4) = 0.350; Para(2,5) = 2.62; Para(2,6) = -1.66; Para(2,7) = 37.48;
Para(2,8) = 0; Para(2,9) = 1.86; Para(2,10) = 3.71; Para(2,11) = 133.6; Para(2,12) = -8.35;

Para(3,4) = 0; Para(3,5) = -1.11; Para(3,6) = 0; Para(3,7) = 0.94;
Para(3,8) = 2.36; Para(3,9) = 146.6; Para(3,10) = 146.6; Para(3,11) = -6.97; Para(3,12) = 3.35;

Para(4,5) = 33.16; Para(4,6) = -3.53; Para(4,7) = 29.02;
Para(4,8) = 166.6; Para(4,9) = 2.37; Para(4,10) = 2.37; Para(4,11) = 6.23; Para(4,12) = 8.13;

Para(5,6) = 33.16; Para(5,7) = 21.75;
Para(5,8) = 4.06; Para(5,9) = 0; Para(5,10) = 0; Para(5,11) = 0; Para(5,12) = 2.36;

Para(6,7) = 34.57;
Para(6,8) = 5.39; Para(6,9) = 0; Para(6,10) = 0; Para(6,11) = 5.39; Para(6,12) = 8.52;

Para(7,8) = 8.61; Para(7,9) = 0; Para(7,10) = 0; Para(7,11) = 3.78; Para(7,12) = 148.5;

Para(8,9) = 0; Para(8,10) = 0.18; Para(8,11) = -0.68; Para(8,12) = 8.46;

Para(9,10) = -12.41; Para(9,11) = 1.28; Para(9,12) = -1.06;

Para(10,11) = 6.00; Para(10,12) = -0.36;

Para(11,12) = 1.30;

o1 = 20696;
o2 = 2894;

for ii = 1:7
    w(ii) = Para(ii,ii)-o1;
end
for ii = 8:12
    w(ii) = Para(ii,ii)-o2;
end

for ii = 1:12
    for jj = 1:12
        J(ii,jj) = Para(ii,jj);
    end
end
%% Define Subsystem A Hamiltonian;
H_int_A = 0;
% chemical shift
for ii = 1:3
    H_int_A = H_int_A + w(ii)*KIz{ii};
end
for ii = 9:11
    H_int_A = H_int_A + w(ii)*KIz{ii-5};
end
% J coupling
for ii = 1:2
    for jj = (ii+1):3
        H_int_A = H_int_A + J(ii,jj)*KIz{ii}*KIz{jj};
    end
end
for ii = 9:10
    for jj = (ii+1):11
        H_int_A = H_int_A + J(ii,jj)*KIz{ii-5}*KIz{jj-5};
    end
end
H_int_A = H_int_A + J(1,9)*KIz{1}*KIz{4} + J(1,10)*KIz{1}*KIz{5} + J(1,11)*KIz{1}*KIz{6}+...
    J(2,9)*KIz{2}*KIz{4} + J(2,10)*KIz{2}*KIz{5} + J(2,11)*KIz{2}*KIz{6}+...
    J(3,9)*KIz{3}*KIz{4} + J(3,10)*KIz{3}*KIz{5} + J(3,11)*KIz{3}*KIz{6};

H_int_A = 2*pi*H_int_A;
%% Define Subsystem B Hamiltonian;
H_int_B = 0;
% chemicBl shift
for ii = 4:7
    H_int_B = H_int_B + w(ii)*KIz{ii-3};
end
    H_int_B = H_int_B + w(8)*KIz{5}+ w(12)*KIz{6};
% J coupling
for ii = 4:6
    for jj = (ii+1):7
        H_int_B = H_int_B + J(ii,jj)*KIz{ii-3}*KIz{jj-3};
    end
end
for ii = 4:7
    H_int_B = H_int_B + J(ii,8)*KIz{ii-3}*KIz{5} + J(ii,12)*KIz{ii-3}*KIz{6};
end
H_int_B = H_int_B + J(8,12)*KIz{5}*KIz{6};

H_int_B = 2*pi*H_int_B;

save parameter.mat