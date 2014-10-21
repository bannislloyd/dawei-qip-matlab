Htype = 'strong'; 

%spins.ignore = {'M','H1','H2','C1','C2','C3','C4'}; 
spins.ignore = {'RH','RC'};

%spins_sub{1} = [1 5]; 

     spins_sub{1} = 2;
     spins_sub{2} = 3;
     spins_sub{3} = 4;
    spins_sub{4} = 6;
     spins_sub{5} = 7;
     spins_sub{6} = 8;
     spins_sub{7} = 9;
% spins_sub{1} = [2 3 4 6 7 8 9]; 
 
 
%spins_sub{1} = [2 6];
%spins_sub{2} = [6 7];
%spins_sub{3} = [3 4 7 8];
%spins_sub{4} = [8 9];
%spins_sub{1} = [1 5];
 
dz=[1 0;0 -1]; 
u=[1 0;0 0];
%spins.state=mkstate('+4ZI+1IZ'); 
%spins.state  = mkstate('+4ZIIIIII+4IZIIIII+4IIZIIII+1IIIZIII+1IIIIZII+1IIIIIZI+1IIIIIIZ');
spins.state = mkstate('+1ZIIIIII');
%spins.state = kron(u,kron(dz,kron(u,kron(u,kron(u,kron(u,u))))));
% %== initial state for decoding in pure state =====
% Ip = mkstate('+1X') +i*mkstate('+1Y');
% Im = mkstate('+1X') -i*mkstate('+1Y');
% 
% rohp = 1; for k=1:7; rohp = kron(rohp,Ip); end 
% rohm = 1; for k=1:7; rohm = kron(rohm,Im); end 
% %spins.state  = rohp + rohm ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load depo0
%spins.state = ROH_tot;

%load p1_ini.mat
%p1 = p_out;
%load p2_ini.mat
%p2 = p_out;
%spins.state = -(p1-p2);    %00Z000 by simulation

%spins.state= mkstate('+1UUZUUUU'); %ideal pure state
%spins.state= mkstate('+1UUUUUUU'); %pure for the seven spins, simulation
%spins.state= mkstate('+1UUUZUUU'); %ideal pure state, labelled by C1


%spins.state      = mkstate('+1IIIZIII+1IIIIZII+1IIIIIZI+1IIIIIIZ');
