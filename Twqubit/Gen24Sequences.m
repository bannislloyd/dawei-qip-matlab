% Generate 24 pulse sequences for 12-qubit PPS. Every sequence includes
% different phase cycling phase and ph31

clear;

Sequence_Name = 'twqubit_12cpps_p';

for ii = 1:24
    Current_Name = [Sequence_Name, num2str(ii)];
    seq = fopen(Current_Name,'w');
    
    %% Write Head %%%%%%%%%%%%%%%%%%%%%%
    fprintf(seq,'#include <Avance.incl>\n');
    fprintf(seq,'#include <Grad.incl>\n');
    fprintf(seq,'"acqt0=-p1*2/3.1416"\n\n\n');
    
    fprintf(seq,'1 ze\n');
    fprintf(seq,'2 30m\n');
    fprintf(seq,'	d1\n\n\n');
    
    %% C-H SWAP %%%%%%%%%%%%%%%%%%%%%%
    fprintf(seq,';;C-H SWAP\n');
    fprintf(seq,'(4u p1:sp1 ph4 4u):f3  (4u p2:sp2 ph4 4u):f2\n\n');
    
    fprintf(seq,'50u UNBLKGRAD\n');
    fprintf(seq,'p30:gp5\n');
    fprintf(seq,'500u\n\n');
    
    fprintf(seq,'(4u p3:sp3 ph4 4u):f3  (4u p4:sp4 ph4 4u):f2\n\n');
    
    fprintf(seq,'50u UNBLKGRAD\n');
    fprintf(seq,'p30:gp6\n');
    fprintf(seq,'500u\n\n');    
    
    %% kill C1-C6 and H1-H5
    fprintf(seq,';;kill C1-C6 and H1-H5\n');
    fprintf(seq,'(4u p9:sp9 ph4 4u):f3  (4u p10:sp10 ph4 4u):f2\n\n');
    
    fprintf(seq,'50u UNBLKGRAD\n');
    fprintf(seq,'p30:gp1\n');
    fprintf(seq,'500u\n\n');      
    
    %% encoding1 to get Z24567 
    fprintf(seq,';;encoding1 to get Z24567\n');
    fprintf(seq,'(p11:sp11 ph4):f3  (p12:sp12 ph4):f2\n\n');
    
    fprintf(seq,'50u UNBLKGRAD\n');
    fprintf(seq,'p30:gp2\n');
    fprintf(seq,'500u\n\n');      
    
    %% encoding2 to get Z1234567
    fprintf(seq,';;encoding2 to get Z1234567\n');
    fprintf(seq,'(p13:sp13 ph4):f3  (p14:sp14 ph4):f2\n\n');
    
    fprintf(seq,'50u UNBLKGRAD\n');
    fprintf(seq,'p30:gp3\n');
    fprintf(seq,'500u\n\n');   
    
    %% encoding3 to get Z123456789101112
    fprintf(seq,';;encoding3 to get Z123456789101112\n');
    fprintf(seq,'(p15:sp15 ph4):f3  (p16:sp16 ph4):f2\n\n');
    
    fprintf(seq,'50u UNBLKGRAD\n');
    fprintf(seq,'p30:gp4\n');
    fprintf(seq,'500u\n\n');   
    
    %% Phase Cycling and Decoding
    fprintf(seq,';;Phase Cycling\n');
    fprintf(seq,'(4u p17:sp17 ph6 4u):f3  (4u p18:sp18 ph6 4u):f2\n\n');
    
    fprintf(seq,';;Decoding\n');
    fprintf(seq,'(p19:sp19 ph4):f3  (p20:sp20 ph4):f2\n\n\n\n');
    
    fprintf(seq,'50u UNBLKGRAD\n');
    fprintf(seq,'p30:gp7\n');
    fprintf(seq,'500u\n\n');  
    
    fprintf(seq,'(p21:sp21 ph4):f3  (p22:sp22 ph4):f2\n\n');
    %% Write Tail
    fprintf(seq,'  go=2 ph31\n');
    fprintf(seq,'  30m mc #0 to 2 F0(zd)\n');
    fprintf(seq,'exit\n\n\n');
    
    %% Write Phase
    fprintf(seq,'ph1=1\n');
    fprintf(seq,'ph2=2\n');
    fprintf(seq,'ph3=3\n');
    fprintf(seq,'ph4=0\n\n');
    
    fprintf(seq,'ph6=(24) %d\n\n',ii-1);
    if mod(ii,2) == 0
        ph31 = 2;
    else ph31 = 0;
    end
    fprintf(seq,'ph31=%d\n',ph31);
    
    fclose(seq);
end

% homepath = 'H:/Matlab/Twqubit';
% arg1=[homepath,'/','twqubit_12cpps_p2'];
% arg2=  '/opt/topspin/exp/stan/nmr/lists/pp/user';
% eval(sprintf ('! scp %s mditty@enlil.uwaterloo.ca:%s',arg1,arg2));
% fprintf('DONE!\n')

%% Decouple H
% fprintf(seq,'\n;;Decouple H\n');
% fprintf(seq,'1u pl12:f2\n');
% fprintf(seq,'1u cpd2:f2\n');
% fprintf(seq,';(p27:sp27 ph4):f3  ; ob C2\n');
% fprintf(seq,'(p28:sp28 ph4):f3  ; ob C7\n');


