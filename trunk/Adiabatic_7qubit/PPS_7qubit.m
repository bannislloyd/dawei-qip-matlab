clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

[Para,H] = hamiltonian_7qubit;
I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Encoding Part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%First step
%initial state
rho_in = KIx{7}; 

%free evolution 1/4J27
U1 = expm(-i*H*1/4/Para(2,7));

%pi_pulse on C2
P2 = expm(-i*pi*KIx{2});

%free evolution 1/4J67-1/4J27
U2 = expm(-i*H*(1/4/Para(6,7)-1/4/Para(2,7)));

%pi_pulse on C6
P6 = expm(-i*pi*KIx{6});

%free evolution 1/4J47-1/4J67
U3 = expm(-i*H*(1/4/Para(4,7)-1/4/Para(6,7)));

%pi_pulse on C4
P4 = expm(-i*pi*KIx{4});

%free evolution 1/4J57-1/4J47
U4 = expm(-i*H*(1/4/Para(5,7)-1/4/Para(4,7)));

%pi_pulse on C5,C7
P5 = expm(-i*pi*KIx{5});
P7 = expm(-i*pi*KIx{7});

%free evolution 1/4J57
U5 = expm(-i*H*(1/4/Para(5,7)));


U_step1 = U5*P5*P7*U4*P4*U3*P6*U2*P2*U1;
rho_step1 = U_step1*rho_in*U_step1';

%Test value: IZIZZZX
%trace(rho_step1*(16*KIz{2}*KIz{4}*KIz{5}*KIz{6}*KIx{7}))/128
%%%%%%%%%%%%%%%%%%%%%%%
%Second step

%pi/2_pulse on C2,C7
P2_2 = expm(-i*pi/2*KIy{2});
P7_2 = expm(i*pi/2*KIy{7});

%free evolution 1/4J12
U6 = expm(-i*H*1/4/Para(1,2));

%pi_pulse on C1
P1 = expm(-i*pi*KIx{1});

%free evolution 1/4J23-1/4J12
U7 = expm(-i*H*(1/4/Para(2,3)-1/4/Para(1,2)));

%pi_pulse on C2,C3
P2 = expm(-i*pi*KIx{2});
P3 = expm(-i*pi*KIx{3});

%free evolution 1/4J23
U8 = expm(-i*H*(1/4/Para(2,3)));

U_step2 = U8*P2*P3*U7*P1*U6*P2_2*P7_2;
rho_step2 = U_step2*rho_step1*U_step2';
rho_step2 = expm(-i*pi/2*(KIy{2}))*rho_step2*expm(-i*pi/2*(KIy{2}))';
%Test value: ZXZZZZZ
%trace(rho_step2*(64*KIz{1}*KIx{2}*KIz{3}*KIz{4}*KIz{5}*KIz{6}*KIz{7}))/128
% % % % 
% % % % %rho_encoding = expm(-i*pi/2*(KIy{1}+KIy{3}+KIy{4}+KIy{5}+KIy{6}+KIy{7}))*rho_step2*expm(-i*pi/2*(KIy{1}+KIy{3}+KIy{4}+KIy{5}+KIy{6}+KIy{7}))';
% % % % %trace(rho_encoding*(64*KIx{1}*KIx{2}*KIx{3}*KIx{4}*KIx{5}*KIx{6}*KIx{7}))/128
% % % % clear
% % % % [sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(4);
% % % % aa =16*KIz{1}*KIz{2}*KIz{3}*KIz{4};
% % % % I=[1,0;0,1]; Ix=[0,1;1,0]/2; Iy=[0,-i;i,0]/2; Iz=[1,0;0,-1]/2; X=2*Ix; Y=2*Iy; Z=2*Iz; 
% % % % Phase = cell(1,8);
% % % %  
% % % %  Y_all = gop(1,Y)+gop(2,Y)+gop(3,Y)+gop(4,Y);
% % % %  X_all = gop(1,X)+gop(2,X)+gop(3,X)+gop(4,X);
% % % %  
% % % %  for ii = 1:2:7
% % % %       Phase{ii} = R(cos(pi/4*ii)*Y_all-sin(pi/4*ii)*X_all,90);
% % % %       %Phase{ii} = expm(-i*(cos(pi/7*ii+pi)*Y_all-sin(pi/7*ii+pi)*X_all)*pi/2);
% % % %  end
% % % %   for ii = 2:2:8
% % % %      Phase{ii} = R(cos(pi/4*ii)*Y_all-sin(pi/4*ii)*X_all,90);
% % % %      %Phase{ii} = expm(-i*(cos(pi/7*ii)*Y_all-sin(pi/7*ii)*X_all)*pi/2);
% % % %  end
% % % % 
% % % %  %state after phase cycling: highest coherence
% % % %  rho_phasecycling = 0;
% % % %  for ii = 1:8
% % % %      rho_phasecycling = Phase{ii}*(-1)^(ii+1)*aa*Phase{ii}'+rho_phasecycling;
% % % %  end
% % % %  rho_phasecycling = real(rho_phasecycling/8)

%%%%%%%%%%%%%%%%%%%%%%%
Phase = cell(1,14);
 
 Y_all = gop(1,Y)+gop(2,Y)+gop(3,Y)+gop(4,Y)+gop(5,Y)+gop(6,Y)+gop(7,Y);
 X_all = gop(1,X)+gop(2,X)+gop(3,X)+gop(4,X)+gop(5,X)+gop(6,X)+gop(7,X);
 
 for ii = 1:2:13
      Phase{ii} = R(cos(pi/7*ii)*Y_all-sin(pi/7*ii)*X_all,90);
      %Phase{ii} = expm(-i*(cos(pi/7*ii+pi)*Y_all-sin(pi/7*ii+pi)*X_all)*pi/2);
 end
  for ii = 2:2:14
     Phase{ii} = R(cos(pi/7*ii)*Y_all-sin(pi/7*ii)*X_all,90);
     %Phase{ii} = expm(-i*(cos(pi/7*ii)*Y_all-sin(pi/7*ii)*X_all)*pi/2);
 end

 %state after phase cycling: highest coherence
 rho_phasecycling = 0;
 for ii = 1:14
     rho_phasecycling = Phase{ii}*rho_step2*Phase{ii}'+rho_phasecycling;
 end
 rho_phasecycling = sqrt(2)*rho_phasecycling/14
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Phase Cycling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
Phase = cell(1,14);

for ii = 1:14
    Phase{ii} = expm(-i*(KIz{1}+KIz{2}+KIz{3}+KIz{4}+KIz{5}+KIz{6}+KIz{7})*pi/7*ii);
end

rho_phase = cell(1,14);

for ii = 1:14
    rho_phase{ii} = Phase{ii}*(-1)^(ii+1)*rho_encoding*Phase{ii}';
end

%state after phase cycling: highest coherence
rho_phasecycling = 0;
for jj = 1:14
    rho_phasecycling = rho_phasecycling+rho_phase{jj};
end
rho_phasecycling = sqrt(2)*rho_phasecycling/14;
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
%Third step

%pi/2_pulse on C1,C3,C4,C6
P1_2 = expm(-i*pi/2*KIx{1});
P3_2 = expm(-i*pi/2*KIx{3});
P4_2 = expm(-i*pi/2*KIx{4});
P6_2 = expm(-i*pi/2*KIx{6});
%ideal = (KIx{1}+i*KIz{1})*(KIx{2}+i*KIy{2})*(KIx{3}+i*KIz{3})*(KIx{4}+i*KIz{4})*(KIx{5}+i*KIy{5})*(KIx{6}+i*KIz{6})*(KIx{7}+i*KIy{7});


%free evolution 1/4J12
U9 = expm(-i*H*1/4/Para(1,2));

%pi_pulse on C1
P1 = expm(-i*pi*KIx{1});

%free evolution 1/4J23-1/4J12
U10 = expm(-i*H*(1/4/Para(2,3)-1/4/Para(1,2)));

%pi_pulse on C2,C3,C4,C5,C6
P2 = expm(-i*pi*KIx{2});
P3 = expm(-i*pi*KIx{3});
P4 = expm(-i*pi*KIx{4});
P5 = expm(-i*pi*KIx{5});
P6 = expm(-i*pi*KIx{6});

%free evolution 1/4J23
U11 = expm(-i*H*1/4/Para(2,3));

%pi/2_pulse on C1,C3,C4,C6
P1_2y = expm(i*pi/2*KIy{1});
P3_2y = expm(i*pi/2*KIy{3});
P4_2y = expm(i*pi/2*KIy{4});
P6_2y = expm(i*pi/2*KIy{6});



  
U_step3 = P6_2y*P4_2y*P3_2y*P1_2y*expm(i*KIz{1}*2*pi*Para(1,1)*(1/2/Para(2,3)-1/2/Para(1,2)))*U11*P2*P3*P4*P5*P6*U10*P1*U9*P6_2*P4_2*P3_2*P1_2;
 rho_step3 = U_step3*rho_phasecycling*U_step3';

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %This part is used to find the state rho_step3, it is 1111112
% 
% A = cell(1,2);
% A{1} = I/2+Iz; A{2} = I/2-Iz;
% 
% B = cell(1,2);
% B{1} = Ix+i*Iy; B{2} = Ix-i*Iy;
% 
%  script=['1','2'];
%   for j1=1:2
%          for j2=1:2
%             for j3=1:2
%                 for j4=1:2
%                      for j5=1:2
%                           for j6=1:2
%                                for j7=1:2
%                                value = trace(rho_step3*kron(kron(kron(kron(kron(kron(A{j1},B{j2}),A{j3}),A{j4}),B{j5}),A{j6}),B{j7}));
%                                
%                                if (abs(value)>0.005)
%                                fprintf('%c%c%c%c%c%c%c , %g+%gi \n',script(j1),script(j2),script(j3),script(j4),script(j5),script(j6),script(j7),real(value),imag(value))
%                                end
%                                
%                                end
%                           end
%                      end
%                 end
%             end
%         end
%       end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

iden = eye(128);
 rho_step3_ideal = (KIz{1}+iden/2)*(KIx{2}+i*KIy{2})*(KIz{3}+iden/2)*(KIz{4}+iden/2)*(KIx{5}+i*KIy{5})*(KIz{6}+iden/2)*(KIx{7}-i*KIy{7})+...
     (KIz{1}+iden/2)*(KIx{2}-i*KIy{2})*(KIz{3}+iden/2)*(KIz{4}+iden/2)*(KIx{5}-i*KIy{5})*(KIz{6}+iden/2)*(KIx{7}+i*KIy{7});
  trace(sqrt(2)/2*rho_step3*rho_step3_ideal)
%%%%%%%%%%%%%%%%%%%%%%%
%Fourth step
%pi/2_pulse on C2,C5
P2_2 = expm(-i*pi/2*KIx{2});
P5_2 = expm(-i*pi/2*KIx{5});

%free evolution 1/4J27
U12 = expm(-i*H*1/4/Para(2,7));

%pi_pulse on C2
P2 = expm(-i*pi*KIx{2});

%free evolution 1/4J57-1/4J27
U13 = expm(-i*H*(1/4/Para(5,7)-1/4/Para(2,7)));

%pi_pulse on C5,C7
P5 = expm(-i*pi*KIx{5});
P7 = expm(-i*pi*KIx{7});

%free evolution 1/4J27
U14 = expm(-i*H*1/4/Para(2,7));

%pi_pulse on C1,C3
P1 = expm(-i*pi*KIx{1});
P3 = expm(-i*pi*KIx{3});

%free evolution 1/4J57-1/4J27
U15 = expm(-i*H*(1/4/Para(5,7)-1/4/Para(2,7)));

%pi/2_pulse on C2,C5
P2_2y = expm(i*pi/2*KIy{2});
P5_2y = expm(i*pi/2*KIy{5});

U_step4 = P5_2y*P2_2y*expm(i*KIz{2}*2*pi*Para(2,2)*(1/2/Para(5,7)-1/2/Para(2,7)))*U15*P3*P1*U14*P7*P5*U13*P2*U12*P5_2*P2_2;

rho_out = U_step4*rho_step3*U_step4';

rho_out_ideal = (KIz{1}-iden/2)*(KIz{2}-iden/2)*(KIz{3}-iden/2)*(KIz{4}+iden/2)*(KIz{5}-iden/2)*(KIz{6}+iden/2)*(KIx{7});

 trace(rho_step3*rho_step3_ideal)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %This part is used to find the state rho_out, it is 2221211
% 
% A = cell(1,2);
% A{1} = I/2+Iz; A{2} = I/2-Iz;
% 
% B = cell(1,2);
% B{1} = Ix+i*Iy; B{2} = Ix-i*Iy;
% 
%  script=['1','2'];
%   for j1=1:2
%          for j2=1:2
%             for j3=1:2
%                 for j4=1:2
%                      for j5=1:2
%                           for j6=1:2
%                                for j7=1:2
%                                value = trace(rho_out*kron(kron(kron(kron(kron(kron(A{j1},A{j2}),A{j3}),A{j4}),A{j5}),A{j6}),B{j7}));
%                                
%                                if (abs(value)>0.005)
%                                fprintf('%c%c%c%c%c%c%c , %g+%gi \n',script(j1),script(j2),script(j3),script(j4),script(j5),script(j6),script(j7),real(value),imag(value))
%                                end
%                                
%                                end
%                           end
%                      end
%                 end
%             end
%         end
%       end 

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Next step is how to use phase cycling for coherence transfer and
% decoding part




