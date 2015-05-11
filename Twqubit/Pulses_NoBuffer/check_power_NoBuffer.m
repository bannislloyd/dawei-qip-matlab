clear;

Pulse_Name = cell(1,18);

Pulse_Name{1} = 'twqubit_C790';
Pulse_Name{2} = 'twqubit_C290';
Pulse_Name{3} = 'twqubit_C234790';
Pulse_Name{4} = 'twqubit_C234790withPC';
Pulse_Name{5} = 'twqubit_C134690andH90';
Pulse_Name{6} = 'twqubit_C1234690withPC';
Pulse_Name{7} = 'twqubit_C2Y5X90';
Pulse_Name{8} = 'twqubit_C590';
Pulse_Name{9} = 'twqubit_C2180';
Pulse_Name{10} = 'twqubit_C6180';
Pulse_Name{11} = 'twqubit_C4180';
Pulse_Name{12} = 'twqubit_C57180';
Pulse_Name{13} = 'twqubit_C1180';
Pulse_Name{14} = 'twqubit_C23180';
Pulse_Name{15} = 'twqubit_C156180';
Pulse_Name{16} = 'twqubit_C2347andH180';
Pulse_Name{17} = 'twqubit_C23456180';
Pulse_Name{18} = 'twqubit_C27180';

Calibration_C = 25000;
Calibration_H = 25000;
Output1 = 'test1';
Output2 = 'test2';
FirstLine = 21;

Length_90 = 100;
for ii = 1:8 
    Output_C = [Pulse_Name{ii}, '_C_', num2str(Calibration_C), '_NoBuffer' ];
    Output_H = [Pulse_Name{ii}, '_H_', num2str(Calibration_H), '_NoBuffer' ];
    [power1,phase1]=dataout(Output_C,Output1,FirstLine,Length_90);
    [power2,phase2]=dataout(Output_H,Output2,FirstLine,Length_90);
    
    fprintf('Pulse Name: %s\n',Pulse_Name{ii});
    C_ratio = max(power1);
    C_hertz = Calibration_C * C_ratio/100;
    H_ratio = max(power2);
    H_hertz = Calibration_C * H_ratio/100;
    fprintf('C: %f, %f. H: %f, %f. \n\n',C_ratio, C_hertz, H_ratio, H_hertz);
end

Length_180 = 200;
for ii = 9:18
    Output_C = [Pulse_Name{ii}, '_C_', num2str(Calibration_C), '_NoBuffer' ];
    Output_H = [Pulse_Name{ii}, '_H_', num2str(Calibration_H), '_NoBuffer' ];
    [power1,phase1]=dataout(Output_C,Output1,FirstLine,Length_180);
    [power2,phase2]=dataout(Output_H,Output2,FirstLine,Length_180);
    
    fprintf('Pulse Name: %s\n',Pulse_Name{ii});
    C_ratio = max(power1);
    C_hertz = Calibration_C * C_ratio/100;
    H_ratio = max(power2);
    H_hertz = Calibration_C * H_ratio/100;
    fprintf('C: %f, %f. H: %f, %f. \n\n',C_ratio, C_hertz, H_ratio, H_hertz);
end

