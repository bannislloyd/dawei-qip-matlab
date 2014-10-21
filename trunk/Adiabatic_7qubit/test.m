clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(2);

dt = 100.57896;


w1 = 0; w2 = 0; J = 100;

H = w1*KIz{1}+w2*KIz{2}+J*KIz{1}*KIz{2};

Hc = KIx{1} + KIx{2};

si = expm(-i*H*dt-i*Hc*dt)'* [1,0,0,0]';

sf = expm(-i*H*dt-i*Hc*dt)* si

w1 = 2675; w2 = 1234; J = 100;

H2 = w1*KIz{1}+w2*KIz{2}+J*KIz{1}*KIz{2};

Hc2 = cos(w1*dt)*KIx{1} + cos(w2*dt)*KIx{2}+sin(w1*dt)*KIy{1}+sin(w2*dt)*KIy{2};

sf2 = expm(-i*H2*dt-i*Hc2*dt)* si