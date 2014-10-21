function [Mean_Decoherence, Min_Decoherence, Max_Decoherence ] = decoherence(InitialState)
% To produce the shape pulses for the twirling experiment, including the pulse for state preparation and measurement.
% Example: PulseGeneration('ZZZIIII')


[sigma_x,sigma_y,sigma_z,I,Ix,Iy,Iz,ST0,ST1,KIx,KIy,KIz] = MultiPauli(7);

% t2 = [1.611 0.877 1.122 0.792 1.143 1.912 0.531];
t2 = [1.912 1.611 1.143 1.122 0.877  0.792  0.531];
%InitialState = 'ZIIIIII';
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    temp = searchp2fmp1(PreState{ii});
    PostState{ii} = temp(3:9); % discard +1 or -1 before the PostState in the original code
    Order_post(ii) = 7;
    for kk = 1:7
        if strcmp('I',PostState{ii}(kk))
           Order_post(ii) = Order_post(ii)-1;
        end
    end    
end
%     eval(['save ',InitialState,'_pre.mat PreState']);
%     eval(['save ',InitialState,'_post.mat PostState']);
%% Calculate Decoherence

Order_pre = Order;

for ii = 1:PreState_Number
    Order_diff(ii) = abs(Order_post(ii)-Order_pre)+1;
    Min_Order = min(Order_post(ii), Order_pre);
    Max_Order = max(Order_post(ii), Order_pre);
    Decoherence(ii) = exp(-80/Order_diff(ii)/970.8)^((Order_pre+Order_post(ii))*Order_diff(ii)/2);
   Min_Dec(ii) = 1; Max_Dec(ii) = 1;
    for kk = Min_Order:Max_Order
         for jj = 1:kk
                      Min_Dec(ii)  =  Min_Dec(ii)*exp(-0.08/Order_diff(ii)/t2(jj));
                     Max_Dec(ii)  =  Max_Dec(ii)*exp(-0.08/Order_diff(ii)/t2(7-jj+1));
         end
    end
end

Mean_Decoherence = mean(Decoherence);
Min_Decoherence = mean(Min_Dec);
Max_Decoherence = mean(Max_Dec);