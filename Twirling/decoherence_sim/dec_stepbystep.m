 function Loss = dec_stepbystep(InitialState)
% To produce the shape pulses for the twirling experiment, including the pulse for state preparation and measurement.
% Example: PulseGeneration('ZZZIIII')

load U_encoding80ms.mat
load decoherence_matrix_0650.mat
load U_4us.mat
% load decoherence_matrix_100.mat

[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

% t2 = [1.611 0.877 1.122 0.792 1.143 1.912 0.531];
% InitialState = 'IIIIIZZ';
%% Get the order of coherence of the initial state
jj = 1;
for ii = 1:7
    if strcmp('Z',InitialState(ii)) 
       Coherence_Position(jj) = ii;
       jj = jj+1;
    end
end

Order = length(Coherence_Position);

%% Generating different Pre States and Post States
PreState_Number = 3^Order;
PreState = cell(PreState_Number,1);
PostState = cell(PreState_Number,1);

for ii = 1:PreState_Number
    State_Index(ii) = {dec2base(ii-1,3,Order)};
    %%%%%%%%%%%%%%%% Creating the forms of different pre states %%%%%%%%%%%%%%%%%%%%%%%
    SpinNumber = 1;
    for jj = 1:7
        if jj == Coherence_Position(SpinNumber)
              PreState{ii} = [PreState{ii},State_Index{ii}(SpinNumber)];
              if SpinNumber == Order
              else
              SpinNumber = SpinNumber+1;
              end
        else
        PreState{ii} = [PreState{ii},'I'];
        end
    end
    PreState{ii} = strrep(PreState{ii},'0','X'); % Replace 0 with X
    PreState{ii} = strrep(PreState{ii},'1','Y'); % Replace 0 with Y
    PreState{ii} = strrep(PreState{ii},'2','Z'); % Replace 0 with Z
    
    temp = searchp2fmp1(PreState{ii});
    PostState{ii} = temp(3:9);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
end
%% Calculate Decoherence
PreMatrix = cell(PreState_Number,1);
PostMatrix = cell(PreState_Number,1);
for ii = 1:PreState_Number
    PreMatrix{ii} = 1;
    PostMatrix{ii} = 1;
    for jj = 1:7
        if strcmp(PreState{ii}(jj), 'X')
            PreMatrix{ii}  =kron(PreMatrix{ii}, sigma_x);
        else if strcmp(PreState{ii}(jj), 'Y')
            PreMatrix{ii}  =kron(PreMatrix{ii}, sigma_y);
        else if strcmp(PreState{ii}(jj), 'Z')
            PreMatrix{ii}  =kron(PreMatrix{ii}, sigma_z);
        else if strcmp(PreState{ii}(jj), 'I')
            PreMatrix{ii}  =kron(PreMatrix{ii}, I);
            end
            end
            end
        end
    end
    
    for jj = 1:7
        if strcmp(PostState{ii}(jj), 'X')
            PostMatrix{ii}  =kron(PostMatrix{ii}, sigma_x);
        else if strcmp(PostState{ii}(jj), 'Y')
            PostMatrix{ii}  =kron(PostMatrix{ii}, sigma_y);
        else if strcmp(PostState{ii}(jj), 'Z')
            PostMatrix{ii}  =kron(PostMatrix{ii}, sigma_z);
        else if strcmp(PostState{ii}(jj), 'I')
            PostMatrix{ii}  =kron(PostMatrix{ii}, I);
            end
            end
            end
        end
    end

end

for ii = 1:PreState_Number
  p = PreMatrix{ii} ;
  p = U_4us*p*U_4us';
   for kk = 1:4000
      p = decoherence_matrix.*(U_encoding80ms{kk}*p*U_encoding80ms{kk}');
   end
   p = U_4us*p*U_4us';
  Loss(ii) = abs( trace(p*PostMatrix{ii} )/128 )
end

% for ii = 1:PreState_Number
%   p = PreMatrix{ii} ;
%    for kk = 1:40
%        for jj = 1:100
%            p = (U_encoding80ms{100*(kk-1)+jj}*p*U_encoding80ms{100*(kk-1)+jj}');
%        end
%        p = decoherence_matrix.*p;
%    end
%   Loss(ii) = abs( trace(p*PostMatrix{ii} )/128 )
% end

 eval(['save ',InitialState,'_loss.mat Loss']);