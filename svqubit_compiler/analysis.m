
clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);


load sim_7coh_gz.mat
load U_decoding.mat
Final = U_decoding*RHO_out*U_decoding';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This part is used to find the state rho_step3, it is 1111112

A = cell(1,2);
A{1} = I/2+Iz; A{2} = I/2-Iz;

B = cell(1,2);
B{1} = Ix+i*Iy; B{2} = Ix-i*Iy;

 script=['1','2'];
  for j1=1:2
         for j2=1:2
            for j3=1:2
                for j4=1:2
                     for j5=1:2
                          for j6=1:2
                               for j7=1:2
                               value = trace(Final*kron(kron(kron(kron(kron(kron(A{j1},A{j2}),A{j3}),A{j4}),A{j5}),A{j6}),B{j7}));
                               
                               if (abs(value)>0.01)
                               fprintf('%c%c%c%c%c%c%c , %g+%gi \n',script(j1),script(j2),script(j3),script(j4),script(j5),script(j6),script(j7),real(value),imag(value))
                               end
                               
                               end
                          end
                     end
                end
            end
        end
  end
  iden = eye(128);
 rho_step3_ideal = (KIz{1}+iden/2)*(KIz{2}-iden/2)*(KIz{3}-iden/2)*(KIz{4}+iden/2)*(KIz{5}+iden/2)*(KIz{6}-iden/2)*KIx{7};
  trace(Final*sqrt(2)*rho_step3_ideal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
