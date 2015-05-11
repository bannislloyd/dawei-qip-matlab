function [ phase_new ] = grape_phase( phase, initial_phase, end_phase )
% change the phase of a pulse to a desired one, such as the original pulse
% is for X rotation, we can change it to Y or -X or -Y.
% initial_phase and end_phase should be X, Y, -X, or -Y.

if initial_phase == 'X'
    P_begin = 1;
else if initial_phase == 'Y'
        P_begin = 2;
    else if initial_phase == '-X'
        P_begin = 3;
        else if initial_phase == '-Y'
        P_begin = 4;
            end
        end
    end
end

if end_phase == 'X'
    P_end = 1;
else if end_phase == 'Y'
        P_end = 2;
    else if end_phase == '-X'
        P_end = 3;
        else if end_phase == '-Y'
        P_end = 4;
            end
        end
    end
end

phase = phase - (P_end-P_begin)*90;
phase_new = mod(phase,360);


end

