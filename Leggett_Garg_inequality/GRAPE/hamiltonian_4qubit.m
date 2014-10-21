function [Para,H] = hamiltonian_4qubit

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The diagonal elements of Para: C1-C4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Para = zeros(4);

Para(1,1) = 2995.72; Para(2,2) = 25531.06; Para(3,3) = 21584.04; Para(4,4) = 29489.74;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The off-diagonal elements of Para: J-couplings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Para(1,2) = 20.81*2; Para(1,3) = 0.73*2; Para(1,4) = 3.51*2; 

Para(2,3) = 34.83*2; Para(2,4) = 0.59*2; 

Para(3,4) = 36.08*2; 
%%%%%%%%%%%%%%%%%% Hamilonian %%%%%%%%%%%
for ii = 1:4
    w(ii) = Para(ii,ii);
end

for ii = 1:4
    for jj = 1:4
        J(ii,jj) = Para(ii,jj);
    end
end

% O1 = mean(w);
o1 = w(3);
H = 0;
for ii = 1:4
    H = H + (w(ii)-o1)*KIz{ii};
end

for ii = 1:3
    for jj = (ii+1):4
        H = H + J(ii,jj)*(KIz{ii}*KIz{jj}+KIx{ii}*KIx{jj}+KIy{ii}*KIy{jj});
    end
end

H = 2*pi*H;


save('Para.mat', 'Para', 'H')