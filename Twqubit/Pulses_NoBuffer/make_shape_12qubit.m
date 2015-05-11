% generate all the new GRAPE pulses without the 4us buffer delay

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

for ii = 9:18
    MatFile = ['pulsefinder', num2str(ii), '.log.mat'];
    
    Output_C = [Pulse_Name{ii}, '_C_', num2str(Calibration_C), '_NoBuffer' ];
    Output_H = [Pulse_Name{ii}, '_H_', num2str(Calibration_H), '_NoBuffer' ];
    
    eval(['load ', MatFile]);
    
    make_bruker_shape(pulses{1}, Calibration_C, Output_C, 1);
    make_bruker_shape(pulses{1}, Calibration_H, Output_H, 2);
end
    