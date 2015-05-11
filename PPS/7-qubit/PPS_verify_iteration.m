% 0.9549 fidelity to get 000000Z at last 

clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 

 Phase = cell(1,7);
 Y_all = gop(1,Y)+gop(2,Y)+gop(3,Y)+gop(4,Y)+gop(5,Y)+gop(6,Y)+gop(7,Y);
 X_all = gop(1,X)+gop(2,X)+gop(3,X)+gop(4,X)+gop(5,X)+gop(6,X)+gop(7,X);

load parameter.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Encoding Part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%initial state
rho_pps =  KIz{7};
for ii=1:7
    
rho_in = rho_pps; 

U_ideal{1}=R(gop(7,Y),90);
U_ideal{2}=F(H_int,1/4/abs(J(5,7)))*...
    R(gop(7,X),180)*R(gop(5,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(4,7))))*...
    R(gop(4,X),180)*F(H_int,(1/4/abs(J(4,7))-1/4/abs(J(6,7))))*...
    R(gop(6,X),180)*F(H_int,(1/4/abs(J(6,7))-1/4/abs(J(2,7))))*...
    R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)));
U_ideal{3}=R(gop(7,Y),90);
U_ideal{4}=R(gop(2,Y),90);
U_ideal{5}=F(H_int,1/4/abs(J(2,3)))*...
    R(gop(3,X),180)*R(gop(2,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
    R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)));
U_ideal{6}=R(gop(2,-Y),90);

U_step1 = U_ideal{6}*U_ideal{5}*U_ideal{4}*U_ideal{3}*U_ideal{2}*U_ideal{1};
rho_step1 = U_step1*rho_in*U_step1';

% verify ZZZZZZZ
% trace(2*rho_step1*(128*KIz{1}*KIz{2}*KIz{3}*KIz{4}*KIz{5}*KIz{6}*KIz{7}))/128

%%%%%%%%%%%%%%%%%%%%%%%

      Phase{ii} = R(cos(2*pi/7*ii)*Y_all-sin(2*pi/7*ii)*X_all,90);

 
 %state after phase cycling: highest coherence

     rho_phasecycling = Phase{ii}*rho_step1*Phase{ii}';


%Test value: rho_phasecycling
% for ii = 1:128
%  off_diag(ii) = rho_phasecycling(129-ii,ii);
% end
% rho_phasecycling_ideal = eye(128);
% for jj  =1:7
%     rho_phasecycling_ideal = (KIx{jj}+i*KIy{jj})*rho_phasecycling_ideal;
% end
% 
% trace(rho_phasecycling_ideal*rho_phasecycling)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decoding Part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
U_ideal{1}=R(gop(1,X),90)*R(gop(3,X),90)*R(gop(4,X),90)*R(gop(6,X),90);
U_ideal{2}=F(H_int,1/4/abs(J(2,3)))*...
    R(gop(2,X),180)*R(gop(3,X),180)*R(gop(4,X),180)*R(gop(5,X),180)*R(gop(6,X),180)*F(H_int,(1/4/abs(J(2,3))-1/4/abs(J(1,2))))*...
    R(gop(1,X),180)*F(H_int,1/4/abs(J(1,2)));
U_ideal{3}=R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))'*R(gop(1,Y),90)*R(gop(1,Z),360*w(1)*(1/2/abs(J(1,2))-1/2/abs(J(2,3))))*...
    R(gop(3,Y),90)*...
    R(gop(4,-Y),90)*...
    R(gop(6,-Y),90);
U_ideal{4}=R(gop(2,X),90)*R(gop(5,X),90);
U_ideal{5}=F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
    R(gop(1,X),180)*R(gop(3,X),180)*F(H_int,1/4/abs(J(2,7)))*...
    R(gop(5,X),180)*R(gop(7,X),180)*F(H_int,(1/4/abs(J(5,7))-1/4/abs(J(2,7))))*...
    R(gop(2,X),180)*F(H_int,1/4/abs(J(2,7)));
U_ideal{6}=R(gop(7,Y),90)*R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))'*R(gop(2,Y),90)*R(gop(2,Z),360*w(2)*(1/2/abs(J(2,7))-1/2/abs(J(5,7))))*...
    R(gop(5,Y),90);

U_step2 = U_ideal{6}*U_ideal{5}*U_ideal{4}*U_ideal{3}*U_ideal{2}*U_ideal{1};
rho_step2 = U_step2*rho_phasecycling*U_step2';
rho_pps = rho_step2;
 
end

 rho_pps = sqrt(2)*rho_pps/7;

% verify 000000Z
theo_pps = sqrt(2)*MultiKron(7,ST0,ST0,ST0,ST0,ST0,ST0,Iz);
 abs(trace(rho_pps*theo_pps))

 rho_pps = expm(-i*pi/2*KIy{7})* rho_pps*expm(-i*pi/2*KIy{7})';



