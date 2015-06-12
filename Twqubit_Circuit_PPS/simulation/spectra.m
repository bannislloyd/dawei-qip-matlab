function [ peak_position,  peak_intensity, X, Y] = spec_plot( Para, rho, ob_spin, T2 )
%   SPEC_PLOT is to plot the NMR spectra by giving the Hamiltonian, density
%   matrix and T2* time
%
%   Author: Dawei Lu at 2015/06/08
%
%   Para includes all the Hamiltonian parameters of the system with frequency unit. It is a
%   N-by-N matrix where N is the qubit number. Para(ii,ii) is the chemical
%   shift and Para(ii,jj) (jj>ii) is the J-coupling between spin ii and spin jj.
%
%   rho is the density matrix that you want to simulate.
%
%   ob_spin shows the qubits that you want to draw spectra. For example,
%   ob_spin = [1 3 7 11];
%
%   T2 is the T2* time of ALL qubits. For example, T2 = [0.2 0.4 0.65] for
%   3 qubits.
%
%   Output: peak_position is a M-by-N matrix. M stands for the qubit
%   defined in ob_spin, and N=2^(qubit_number-1) stands for all the peak positions of this
%   qubit, labelling from 00...0 to 11...1 of the other qubits.
%
%   peak_intensity is the height of each peak corresponding to
%   peak_position.

%Fig_name = input('Do you want to save spectra to Fig files and data to Mat files? \n\n If NO, type 0; \n If YES, type the name without extension. \n','s');

N_qubits = length(Para); % number of qubits
ob_qubits = length(ob_spin); % number of observed qubits

width = 100; % default setting; the range of the spectrum is the real with +/- 100Hz

% check if T2 has enough input values
if N_qubits ~= length(T2)
    disp('T2 dimension dismatches with Hamiltonian dimension! Please check T2!');
    return
end

% get all chemical shifts w and J-couplings J
for ii = 1:N_qubits
    w(ii) = Para(ii,ii);
end

for ii = 1:N_qubits
    for jj = ii:N_qubits
        J(ii,jj) = Para(ii,jj);
    end
end

%% generate all peak positions and intensities
% initialize 
peak_position = zeros(ob_qubits, 2^(N_qubits-1));
peak_intensity = zeros(ob_qubits, 2^(N_qubits-1));

for ii = 1:ob_qubits
    
    cur_ob_qubit = ob_spin(ii);
    
    for kk = 1:2^(N_qubits-1)
        state = dec2bin(kk-1,N_qubits-1);
        row_position = [state(1:(cur_ob_qubit-1)), num2str(0), state((cur_ob_qubit):(N_qubits-1))]; % row state (binary)
        column_position = [state(1:(cur_ob_qubit-1)), num2str(1), state((cur_ob_qubit):(N_qubits-1))]; % column state (binary)
        
        row_index = bin2dec(row_position)+1; column_index = bin2dec(column_position)+1; % find the element in the density matrix
        
        peak_intensity(ii, kk) = rho(row_index, column_index);
        peak_position(ii, kk) = w(cur_ob_qubit); % the central value equals to the chemical shift
       
        % find all the peaks by the N_qubits-1 couplings splitting
        if cur_ob_qubit ==1
            for mm = 2: N_qubits
                peak_position(ii, kk) = peak_position(ii, kk) + (-1)^(str2num(state(mm-1)))*J(cur_ob_qubit, mm)/2;
            end
                
        else if cur_ob_qubit == N_qubits
                for mm = 1: (N_qubits-1)
                    peak_position(ii, kk) = peak_position(ii, kk) + (-1)^(str2num(state(mm)))*J(mm, cur_ob_qubit)/2;
                end
                
            else 
                for mm = 1: (cur_ob_qubit-1)
                    peak_position(ii, kk) = peak_position(ii, kk) + (-1)^(str2num(state(mm)))*J(mm, cur_ob_qubit)/2;
                end
                for mm = (cur_ob_qubit+1):N_qubits
                    peak_position(ii, kk) = peak_position(ii, kk) + (-1)^(str2num(state(mm-1)))*J(cur_ob_qubit, mm)/2;
                end
            end
        end
            

    end
    
end

%% plot every peak
for ii = 1:ob_qubits
    
    tic
    cur_ob_qubit = ob_spin(ii);
    fprintf('\n Trying to generate the spectrum of qubit %d \n \n',cur_ob_qubit);
    
    half_width = 1/pi/T2(cur_ob_qubit); % width at half height 
    stepsize = half_width/10; % resolution: 10 points over half-width
    left_bound = min(peak_position(ii,:))-width;  
    spec_td = round((max(peak_position(ii,:))+width-left_bound)/stepsize);
    
    for kk = 1:spec_td
        X(kk) = left_bound+kk*stepsize;
        Y(kk) = 0;
        for mm = 1:2^(N_qubits-1)
            peak_angle = angle(peak_intensity(ii,mm));
            
            Y(kk) = Y(kk)+abs(peak_intensity(ii,mm))*(cos(peak_angle)+(X(kk)-peak_position(ii,mm))*2/half_width*sin(peak_angle))/(1+(X(kk)-peak_position(ii,mm))^2/(half_width/2)^2);
        end
    end
    
    fprintf('Finished the spectrum of qubit %d in %g minutes ! \n \n',cur_ob_qubit,toc/60); 
    
%     plot(X,Y)
%     
%     % plot setting
%     set(gca,'Xdir','reverse');
%     fontsize = 14;
%     fontsize_legend = 12;
%     
%     title_string = ['Spectrum of Qubit ', num2str(cur_ob_qubit)];
%     title({title_string},'FontWeight','normal','FontSize',fontsize,...
%    'FontName','Calibri',...
%    'FontAngle','normal');
% 
%     xlabel({'Frequency (Hz)'},'FontWeight','normal','FontSize',fontsize,...
%     'FontName','Calibri');
% 
%      ylabel({'Arb. Unit'},'FontWeight','normal','FontSize',fontsize,...
%     'FontName','Calibri');
% 
%      if str2num(Fig_name) == 0 
%      else
%          cur_Fig_name = [Fig_name, '_qubit', num2str(cur_ob_qubit)];
%          saveas(gca, cur_Fig_name, 'fig');
%          cur_Matfile = [Fig_name, '_qubit', num2str(cur_ob_qubit), '.mat'];
%          eval(['save ', cur_Matfile, ' X Y']);
%      end
% 
%     clear X Y
        
end



end

