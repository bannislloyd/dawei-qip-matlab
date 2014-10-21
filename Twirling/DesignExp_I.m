% Program that designs certification experiments
%
% INPUTS:
% n: Number of qubits

function data = DesignExp_I(n)

%% Create experiment's number
clear data
for j = 1:4^n-1
    data(j,1) = {num2str(j)};
end

%% Create initial state
% Identity element
In = dec2base(0,2,n); % n-digits base 2 representation
In = strrep(In,'0','I'); % Replace 0 with I

% Z string
Zn = dec2base(0,2,n); % n-digits base 2 representation
Zn = strrep(Zn,'0','Z'); % Replace 0 with Z

% Create the Paulis with only Z and I terms
clear P
for j = 1:2^n-1
    P(j) = {dec2base(j,2,n)}; % n-digits base 2 representation
    P(j) = strrep(P(j),'0','I'); % Replace 0 with I
    P(j) = strrep(P(j),'1','Z'); % Replace 1 with Z 
end

% Sort the Pauli operators according to their weight
clear s_P
for j = 1:2^n-1
    weight(j) = sum(mod((P{j} == In)+1,2)); % Here, P{1} = 'II...I'
end
[s_weight ind] = sort(weight);
s_P = P(ind); % s_P is the vector P sorted according to the weight of the Pauli operators

% Get the number of Z terms
for j = 1:2^n-1
    NbZ(j) = sum(mod((s_P{j} == Zn),2)); % Here, P{1} = 'II...I'
end

% Duplicate each element
ct = 1;
for k = 1:2^n-1
    for nb = 1:3^NbZ(k)
        data(ct,2) = s_P(k);
        ct = ct + 1;
    end
end

%% Create state 1
P = Create_all_Paulis(n);
for j = 1:4^n-1
    A = data(j,2);
    [C D] = Find_closest(A,P,n);
    data(j,4) = C;
    P = D;
end

%% Create measurement
O = Create_all_Obs(n);
for j = 1:4^n-1
    A = data(j,4);
    [C D] = Find_closest(A,O,n);
    data(j,6) = C;
end

%% Create Upre
for j = 1:4^n-1
    A = data(j,2);
    B = data(j,4);
    data(j,3) = find_unitary(A,B,n);
end

%% Create Upost
for j = 1:4^n-1
    A = data(j,4);
    B = data(j,6);
    data(j,5) = find_unitary(A,B,n);
end

%% delete +1 and replace -1 by -
for j = 1:4^n-1
    data(j,4) = reformat(data(j,4));
    data(j,6) = reformat(data(j,6));
end

%% Plot and save the table
% scrsz = get(0,'ScreenSize');
% figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
% 
% cnames = {'Experiment #','p0','Upre','p1','Upost','M'}; 
% t = uitable('ColumnName',cnames,'Position',[0 0 770 600]);
% set(t,'ColumnWidth',{100})
% set(t,'Data',data);
% set(gcf,'color','white'); % sets the background color to white
% File_Name = sprintf('TEST');
% 
% matrix2latex(data,'TEST');
% 
% Results_Path = '/Users/dtrottie/Documents/MATLAB/Programs/NMR/EXPERIMENTS/DFBA23_500H/certification/DesignExp';
% saveas(gcf,[Results_Path '/figures',filesep,File_Name],'fig');
% save Table_I data
% end

