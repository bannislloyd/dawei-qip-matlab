function [Para,H] = hamiltonian_7qubit

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The diagonal elements of Para: C1-C7,H1-H5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Para = zeros(12);


Para(1,1) = 30031; Para(2,2) = 8787; Para(3,3) = 6248; Para(4,4) = 10334; Para(5,5) = 15746; Para(6,6) = 34382;
Para(7,7) = 11932; Para(8,8) = 3310; Para(9,9) = 2468; Para(10,10) = 2158; Para(11,11) = 2692; Para(12,12) = 3649;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The off-diagonal elements of Para: J-couplings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Para(1,2) = 57.56; Para(1,3) = -2.03; Para(1,4) = -0.96; Para(1,5) = -1.14; Para(1,6) = 5.54; Para(1,7) = 0.97;
Para(1,8) = 0; Para(1,9) = 4.41;Para(1,10) = 1.81; Para(1,11) = -13.19; Para(1,12) = 7.87;

Para(2,3) = 32.70; Para(2,4) = 0.50; Para(2,5) = 2.80; Para(2,6) = -1.70; Para(2,7) = 37.48;
Para(2,8) = 0; Para(2,9) = 1.86; Para(2,10) = 3.71; Para(2,11) = 133.6; Para(2,12) = -8.35;

Para(3,4) = 0; Para(3,5) = 1.11; Para(3,6) = 0; Para(3,7) = 0.94;
Para(3,8) = 2.36; Para(3,9) = 146.6; Para(3,10) = 146.6; Para(3,11) = -6.97; Para(3,12) = 3.35;

Para(4,5) = 33.07; Para(4,6) = -3.53; Para(4,7) = 29.02;
Para(4,8) = 166.6; Para(4,9) = 2.37; Para(4,10) = 2.37; Para(4,11) = 6.23; Para(4,12) = 8.13;

Para(5,6) = 33.50; Para(5,7) = -21.75;
Para(5,8) = 4.06; Para(5,9) = 0; Para(5,10) = 0; Para(5,11) = 0; Para(5,12) = 2.36;

Para(6,7) = 34.57;
Para(6,8) = 5.39; Para(6,9) = 0; Para(6,10) = 0; Para(6,11) = 5.39; Para(6,12) = 8.52;

Para(7,8) = 8.61; Para(7,9) = 0; Para(7,10) = 0; Para(7,11) = 3.78; Para(7,12) = 148.5;

Para(8,9) = 0; Para(8,10) = 0.18; Para(8,11) = -0.68; Para(8,12) = 8.46;

Para(9,10) = -12.41; Para(9,11) = 1.28; Para(9,12) = -1.06;

Para(10,11) = 6.00; Para(10,12) = -0.36;

Para(11,12) = 1.30;

%%%%%%%%%%%%%%%%%% Hamilonian %%%%%%%%%%%
for ii = 1:7
    w(ii) = Para(ii,ii);
end

for ii = 1:7
    for jj = 1:7
        J(ii,jj) = Para(ii,jj);
    end
end


H = 0;
for ii = 1:7
    H = H + w(ii)*KIz{ii};
end

for ii = 1:6
    for jj = (ii+1):7
        H = H + J(ii,jj)*KIz{ii}*KIz{jj};
    end
end

H = 2*pi*H;


save('Para.mat', 'Para', 'H')