function experiment

%% Experiment's number
clear data
for j = 1:255
    data(j,1) = {num2str(j)};
end

%% Initial state
ct = 1;
for j = 1:3
    data(ct,2) = {'ZIII'};
    data(ct+3,2) = {'IZII'};
    data(ct+6,2) = {'IIZI'};
    data(ct+9,2) = {'IIIZ'};
    ct = ct+1;
end
ct = 13;
for j = 1:9
    data(ct,2) = {'ZZII'};
    data(ct+9,2) = {'ZIZI'};
    data(ct+18,2) = {'ZIIZ'};
    data(ct+27,2) = {'IZZI'};
    data(ct+36,2) = {'IZIZ'};
    data(ct+45,2) = {'IIZZ'};
    ct = ct+1;
end
ct = 67;
for j = 1:27
    data(ct,2) = {'ZZZI'};
    data(ct+27,2) = {'ZZIZ'};
    data(ct+54,2) = {'ZIZZ'};
    data(ct+81,2) = {'IZZZ'}; 
    ct = ct + 1;
end
ct = 175;
for j = 1:81
    data(ct,2) = {'ZZZZ'};
    ct = ct+1;
end

%% State 1
P = Create_all_Paulis;
for j = 1:255
    A = data(j,2);
    [C D] = Find_closest(A,P);
    data(j,4) = C;
    P = D;
end

%% Measurement 
O = Create_all_Obs;
for j = 1:255
    A = data(j,4);
    [C D] = Find_closest(A,O);
    data(j,6) = C;
end

%% Upre
for j = 1:255
    A = data(j,2);
    B = data(j,4);
    data(j,3) = find_unitary(A,B);
end

%% Upost
for j = 1:255
    A = data(j,4);
    B = data(j,6);
    data(j,5) = find_unitary(A,B);
end

%% Plot and save the table
scrsz = get(0,'ScreenSize');
figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);

cnames = {'Experiment #','p0','Upre','p1','Upost','M'}; 
t = uitable('ColumnName',cnames,'Position',[0 0 770 600]);
set(t,'ColumnWidth',{100})
set(t,'Data',data);
set(gcf,'color','white'); % sets the background color to white
File_Name = sprintf('Calibration');

matrix2latex(data,'Calibration');

Results_Path = '/Users/dtrottie/Documents/MATLAB/Programs/JZ/certification/4qubits/DoNothing';
saveas(gcf,[Results_Path '/figures',filesep,File_Name],'fig');


end

