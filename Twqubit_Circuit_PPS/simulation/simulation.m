clear

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(1); 
rho = gop(7,sigma_x);

T2 = [1 0.31 1 1 1 1 0.42 1 1 1 1 1];

load Para_12qubit.mat
Para(1,7) = 0.7177*2;          
Para(3,7) = 0.47*2;      
Para(7,8) = 4.305*2;    
Para(7,9) = 0;           
Para(7,10) = 0;          
Para(7,11) = 1.47*2;           

% 1.207102822514439e+04

% 1.206988266604001e+04
%1.206885166284606e+04
% 1.206701876827905e+04
%1.206587320917467e+04

 [ peak_position,  peak_intensity] = spec_plot( Para, rho, [7], T2 );
