clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);
[Para,H] = hamiltonian_TCE;
%% initial state |000>

input = KIz{1}+KIz{2}+4*KIz{3};

U_pps1 = rot(KIy{3},pi/3)*rot(KIy{1},pi/3);
part1 = Gz(U_pps1*input*U_pps1');

U_pps2 = rot(-KIy{3},pi/2)*rot(KIz{3}*KIz{2},pi)*rot(KIx{3},pi/2);
part2 = Gz(U_pps2*part1*U_pps2');

U_pps3 = rot(-KIy{2},pi/4)*rot(KIz{1}*KIz{2},pi)*rot(KIx{2},pi/4);
part3 = Gz(U_pps3*part2*U_pps3');

U_pps4 = rot(-KIy{3},pi/4)*rot(KIz{3}*KIz{2},pi)*rot(KIx{3},pi/4);
pps = Gz(U_pps4*part3*U_pps4');

save U_pps.mat U_pps1 U_pps2 U_pps3 U_pps4

