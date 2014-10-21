clear;

t = 2;
T2 = 2;
lamda = 1- (exp(-t/T2))^2;

E0 = [1, 0; 0, sqrt(1-lamda)];
E1 = [0, 0; 0, sqrt(lamda)];

input = [0,1;1,0];

output = E0*input*E0'+E1*input*E1'