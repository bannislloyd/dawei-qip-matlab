clear;
[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);
% Incl. all the unitaries for GRAPE pulses
C7_swap42 =  (MultiKron(7,I,I,I,I,I,I,ST0)+MultiKron(7,I,I,I,ST0,I,I,ST1)+MultiKron(7,I,sigma_x,I,ST1,I,I,ST1))*...
    (MultiKron(7,I,I,I,I,I,I,ST0)+MultiKron(7,I,ST0,I,I,I,I,ST1)+MultiKron(7,I,ST1,I,sigma_x,I,I,ST1))*...
    (MultiKron(7,I,I,I,I,I,I,ST0)+MultiKron(7,I,I,I,ST0,I,I,ST1)+MultiKron(7,I,sigma_x,I,ST1,I,I,ST1));

save C7_swap42.mat C7_swap42

