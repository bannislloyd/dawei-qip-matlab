clear;

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(3);
[Para,H] = hamiltonian_TCE;

% for pauli decomposition
pauli = cell(1,4);  
pauli{1}=[0,1;1,0];  pauli{2}=[0,-i;i,0];  pauli{3}=[1,0;0,-1];  pauli{4}=eye(2);
script=['X','Y','Z','I'];

fid=fopen('theta12.txt','w'); % change the name for different theta
fprintf(fid, 'Initial State: cos(theta)*|0>+sin(theta)*|1>. theta=1.2\n'); % change theta here
fprintf(fid, 'Ancilla:C1; Measuring Device:C2; System: H\n');
fprintf(fid, '\n'); 
%% initial state I|00> and observation
theta = 1.2;

input = 2*KIz{3}+KIz{2};
U_pps = rot(-KIy{3},pi/4)*rot(KIz{3}*KIz{2},pi)*rot(KIx{3},pi/4);
pps = Gz(U_pps*input*U_pps')/4; % factor 1/4 is used for normalization
save U_pps.mat U_pps
pps_c2spectrum = rot(KIy{2},pi/2)*pps*(rot(KIy{2},pi/2))'; % observation of PPS on C2
rho_ini = rot(KIy{3},2*theta)*rot(KIy{2},pi/2)*pps*(rot(KIy{3},2*theta)*rot(KIy{2},pi/2))';

fprintf(fid, '%%%%%% PPS Spectrum as Reference %%%%%%\n');
fprintf(fid, 'PPS:I|00>, ');
for j1=1:4
    for j2=1:4
         for j3=1:4
              value = trace(pps_c2spectrum*kron(kron(pauli{j1},pauli{j2}),pauli{j3}));
                 if (abs(value)>0.01)
                    
                     fprintf(fid, '(%1.2f)%c%c%c ',real(value),script(j1),script(j2),script(j3));
                    
                 end           
         end
    end
end
fprintf(fid, '(A Ry Rotation on C2)');
fprintf(fid, '\nFour Peaks of C2: ');
% 4 factor is to set the intensity of one peak on C2 is 1;
peak_pps(1) = 4*pps_c2spectrum(1,3); peak_pps(3) = 4*pps_c2spectrum(2,4); peak_pps(2) = 4*pps_c2spectrum(5,7); peak_pps(4) = 4*pps_c2spectrum(6,8);
for ii = 1:4
    if (real(peak_pps(ii))<0.01)
       peak_pps(ii) = peak_pps(ii)-real(peak_pps(ii));
    end
    if (imag(peak_pps(ii))<0.01)
       peak_pps(ii) = peak_pps(ii)-i*imag(peak_pps(ii));
    end
    if (imag(peak_pps(ii))>=0)
        fprintf(fid, '%g+%gi, ',real(peak_pps(ii)),imag(peak_pps(ii)));
    else 
        fprintf(fid, '%g-%gi, ',real(peak_pps(ii)),-imag(peak_pps(ii)));
    end
end

fprintf(fid, '\nFour Peaks of H:  ');
peak_pps(5) = 4*pps_c2spectrum(1,2); peak_pps(7) = 4*pps_c2spectrum(3,4); peak_pps(6) = 4*pps_c2spectrum(5,6); peak_pps(8) = 4*pps_c2spectrum(7,8);
for ii = 5:8
    if (real(peak_pps(ii))<0.01)
       peak_pps(ii) = peak_pps(ii)-real(peak_pps(ii));
    end
    if (imag(peak_pps(ii))<0.01)
       peak_pps(ii) = peak_pps(ii)-i*imag(peak_pps(ii));
    end
    if (imag(peak_pps(ii))>=0)
        fprintf(fid, '%g+%gi, ',real(peak_pps(ii)),imag(peak_pps(ii)));
    else 
        fprintf(fid, '%g-%gi, ',real(peak_pps(ii)),-imag(peak_pps(ii)));
    end
end
fprintf(fid, '\n');
%% measure and decomposition
fprintf(fid, '\n%%%%%% Experiment for Different g %%%%%%');
fprintf(fid, '\nInitial State is IX(cos(pi/4)|0>+sin(pi/4)|1>)');
for kk = 1:4
g = 0.05*kk;
fprintf(fid, '\ng = %1.3f ',g);

T = g/pi/Para(2,3);
measure_operator = 2*Ix;
u_weak = expm(-i*2*pi*Para(2,3)*T*kron(I,kron(I,measure_operator))*KIz{2});
rho_weak = u_weak*rho_ini*u_weak';

fprintf(fid, '\nState after Weak Measument: ');
for j1=1:4
    for j2=1:4
         for j3=1:4
              value = trace(rho_weak*kron(kron(pauli{j1},pauli{j2}),pauli{j3}));
                     if (abs(real(value))<0.0005)
                        value = value-real(value);
                     end
                     if (abs(imag(value))<0.0005)
                        value = value-i*imag(value);
                     end
                 if (abs(value)>0.0005)
                    
                     fprintf(fid, '(%1.4f)%c%c%c ',real(value),script(j1),script(j2),script(j3));
                   
                 end           
         end
    end
end

Toffoli = kron(I,kron(I,I))-kron(ST1,kron(I,ST1))+kron(ST1,kron(sigma_z,ST1));
% projective measurement operator
rho_final = Toffoli*rho_weak*Toffoli'; % the final state after the projective measurement
fprintf(fid, '\nState after Post Selection: ');
for j1=1:4
    for j2=1:4
         for j3=1:4
              value = trace(rho_final*kron(kron(pauli{j1},pauli{j2}),pauli{j3}));
                     if (abs(real(value))<0.0005)
                        value = value-real(value);
                     end
                     if (abs(imag(value))<0.0005)
                        value = value-i*imag(value);
                     end
                 if (abs(value)>0.0005)
                    
                     fprintf(fid, '(%1.4f)%c%c%c ',real(value),script(j1),script(j2),script(j3));
                   
                 end           
         end
    end
end

fprintf(fid, '\nFour Peaks of C2 (Im part): ');
peak_pps(1) = -4*rho_final(1,3); peak_pps(3) = -4*rho_final(2,4); peak_pps(2) = -4*rho_final(5,7); peak_pps(4) = -4*rho_final(6,8);
for ii = 1:4
    if (abs(real(peak_pps(ii)))<0.0005)
       peak_pps(ii) = peak_pps(ii)-real(peak_pps(ii));
    end
    if (abs(imag(peak_pps(ii)))<0.0005)
       peak_pps(ii) = peak_pps(ii)-i*imag(peak_pps(ii));
    end
    if (imag(peak_pps(ii))>=0)
        fprintf(fid, '%1.4f+%1.4fi, ',real(peak_pps(ii)),imag(peak_pps(ii)));
    else 
        fprintf(fid, '%1.4f-%1.4fi, ',real(peak_pps(ii)),-imag(peak_pps(ii)));
    end
end

rho_final_H = rot(KIy{3},pi/2)*rho_final*rot(KIy{3},pi/2)';
fprintf(fid, '\nFour Peaks of H  (Re part): ');
peak_pps(5) = 4*rho_final_H(1,2); peak_pps(7) = 4*rho_final_H(3,4); peak_pps(6) = 4*rho_final_H(5,6); peak_pps(8) = 4*rho_final_H(7,8);
for ii = 5:8
    if (abs(real(peak_pps(ii)))<0.0005)
       peak_pps(ii) = peak_pps(ii)-real(peak_pps(ii));
    end
    if (abs(imag(peak_pps(ii)))<0.0005)
       peak_pps(ii) = peak_pps(ii)-i*imag(peak_pps(ii));
    end
    if (imag(peak_pps(ii))>=0)
        fprintf(fid, '%1.4f+%1.4fi, ',real(peak_pps(ii)),imag(peak_pps(ii)));
    else 
        fprintf(fid, '%1.4f-%1.4fi, ',real(peak_pps(ii)),-imag(peak_pps(ii)));
    end
end
fprintf(fid, '(After a Ry rotation to observe)\n');


weak_value = imag(sum(peak_pps(1:4)))/2/g/(real(sum(peak_pps(5:8)))/2+1)

fprintf(fid, 'Weak Value: 0.5*Im(C2)/g(0.5*Re(H)+1) = %1.4f\n ', weak_value);
end
%% for g = 0.1 to 0.9
for kk = 3:7
g = 0.1*kk;
fprintf(fid, '\ng = %1.3f ',g);

T = g/pi/Para(2,3);
measure_operator = 2*Ix;
u_weak = expm(-i*2*pi*Para(2,3)*T*kron(I,kron(I,measure_operator))*KIz{2});
rho_weak = u_weak*rho_ini*u_weak';

fprintf(fid, '\nState after Weak Measument: ');
for j1=1:4
    for j2=1:4
         for j3=1:4
              value = trace(rho_weak*kron(kron(pauli{j1},pauli{j2}),pauli{j3}));
                     if (abs(real(value))<0.0005)
                        value = value-real(value);
                     end
                     if (abs(imag(value))<0.0005)
                        value = value-i*imag(value);
                     end
                 if (abs(value)>0.0005)
                    
                     fprintf(fid, '(%1.4f)%c%c%c ',real(value),script(j1),script(j2),script(j3));
                   
                 end           
         end
    end
end

Toffoli = kron(I,kron(I,I))-kron(ST1,kron(I,ST1))+kron(ST1,kron(sigma_z,ST1));
% projective measurement operator
rho_final = Toffoli*rho_weak*Toffoli'; % the final state after the projective measurement
fprintf(fid, '\nState after Post Selection: ');
for j1=1:4
    for j2=1:4
         for j3=1:4
              value = trace(rho_final*kron(kron(pauli{j1},pauli{j2}),pauli{j3}));
                     if (abs(real(value))<0.0005)
                        value = value-real(value);
                     end
                     if (abs(imag(value))<0.0005)
                        value = value-i*imag(value);
                     end
                 if (abs(value)>0.0005)
                    
                     fprintf(fid, '(%1.4f)%c%c%c ',real(value),script(j1),script(j2),script(j3));
                   
                 end           
         end
    end
end

fprintf(fid, '\nFour Peaks of C2 (Im part): ');
peak_pps(1) = -4*rho_final(1,3); peak_pps(3) = -4*rho_final(2,4); peak_pps(2) = -4*rho_final(5,7); peak_pps(4) = -4*rho_final(6,8);
for ii = 1:4
    if (abs(real(peak_pps(ii)))<0.0005)
       peak_pps(ii) = peak_pps(ii)-real(peak_pps(ii));
    end
    if (abs(imag(peak_pps(ii)))<0.0005)
       peak_pps(ii) = peak_pps(ii)-i*imag(peak_pps(ii));
    end
    if (imag(peak_pps(ii))>=0)
        fprintf(fid, '%1.4f+%1.4fi, ',real(peak_pps(ii)),imag(peak_pps(ii)));
    else 
        fprintf(fid, '%1.4f-%1.4fi, ',real(peak_pps(ii)),-imag(peak_pps(ii)));
    end
end

rho_final_H = rot(KIy{3},pi/2)*rho_final*rot(KIy{3},pi/2)';
fprintf(fid, '\nFour Peaks of H  (Re part): ');
peak_pps(5) = 4*rho_final_H(1,2); peak_pps(7) = 4*rho_final_H(3,4); peak_pps(6) = 4*rho_final_H(5,6); peak_pps(8) = 4*rho_final_H(7,8);
for ii = 5:8
    if (abs(real(peak_pps(ii)))<0.0005)
       peak_pps(ii) = peak_pps(ii)-real(peak_pps(ii));
    end
    if (abs(imag(peak_pps(ii)))<0.0005)
       peak_pps(ii) = peak_pps(ii)-i*imag(peak_pps(ii));
    end
    if (imag(peak_pps(ii))>=0)
        fprintf(fid, '%1.4f+%1.4fi, ',real(peak_pps(ii)),imag(peak_pps(ii)));
    else 
        fprintf(fid, '%1.4f-%1.4fi, ',real(peak_pps(ii)),-imag(peak_pps(ii)));
    end
end
fprintf(fid, '(After a Ry rotation to observe)\n');


weak_value = imag(sum(peak_pps(1:4)))/2/g/(real(sum(peak_pps(5:8)))/2+1)

fprintf(fid, 'Weak Value: 0.5*Im(C2)/g(0.5*Re(H)+1) = %1.4f\n ', weak_value);

end
% sigma_y_md = trace(rho_final*2*KIy{2})
% sigma_z_s = trace(rho_final*2*KIz{3})
%  Re_weak_value = sigma_y_md/(sigma_z_s+1)/g