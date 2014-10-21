% 12, 23, 27, 47, 67, 45
% 123, 467, 127, 237, 247, 267
% 1237, 1267, 1247, 2347, 2367
% 12347, 12367, 12357, 12467
% 123467

clear;

% coh1
[decoherence1(1), min_dec1(1), max_dec1(1)] =  decoherence('IZIIIII');
[decoherence1(2), min_dec1(2), max_dec1(2)] =  decoherence('IIIIIIZ');
[decoherence1(3), min_dec1(3), max_dec1(3)] =  decoherence('IIIIZII');

mean_dec(1) = mean(decoherence1)
upperbound(1) = mean(min_dec1) - mean_dec(1)
lowerbound(1) = mean(max_dec1) - mean_dec(1)

% coh2
[decoherence2(1), min_dec2(1), max_dec2(1)] =  decoherence('ZZIIIII');
[decoherence2(2), min_dec2(2), max_dec2(2)] =  decoherence('IZZIIII');
[decoherence2(3), min_dec2(3), max_dec2(3)] =  decoherence('IZIIIIZ');
[decoherence2(4), min_dec2(4), max_dec2(4)] =  decoherence('IIIZIIZ');
[decoherence2(5), min_dec2(5), max_dec2(5)] =  decoherence('IIIIIZZ');
%decoherence2(6) =  decoherence('IIIZZII');

mean_dec(2) = mean(decoherence2)
upperbound(2) = mean(min_dec2) - mean_dec(2)
lowerbound(2) = mean(max_dec2) - mean_dec(2)

% coh3
[decoherence3(1), min_dec3(1), max_dec3(1)] =  decoherence('ZZZIIII');
[decoherence3(2), min_dec3(2), max_dec3(2)]=  decoherence('IIIZIZZ');
[decoherence3(3), min_dec3(3), max_dec3(3)] =  decoherence('ZZIIIIZ');
[decoherence3(4), min_dec3(4), max_dec3(4)]=  decoherence('IZZIIIZ');
[decoherence3(5), min_dec3(5), max_dec3(5)] =  decoherence('IZIZIIZ');
[decoherence3(6), min_dec3(6), max_dec3(6)]=  decoherence('IZIIIZZ');

mean_dec(3) = mean(decoherence3)
upperbound(3) = mean(min_dec3) - mean_dec(3)
lowerbound(3) = mean(max_dec3) - mean_dec(3)

% coh4
[decoherence4(1), min_dec4(1), max_dec4(1)] =  decoherence('ZZZIIIZ');
[decoherence4(2), min_dec4(2), max_dec4(2)] =  decoherence('ZZIIIZZ');
[decoherence4(3), min_dec4(3), max_dec4(3)] =  decoherence('ZZIZIIZ');
[decoherence4(4), min_dec4(4), max_dec4(4)]=  decoherence('IZZZIIZ');
[decoherence4(5), min_dec4(5), max_dec4(5)] =  decoherence('IZZIIZZ');

mean_dec(4) = mean(decoherence4)
upperbound(4) = mean(min_dec4) - mean_dec(4)
lowerbound(4) = mean(max_dec4) - mean_dec(4)

% coh5
[decoherence5(1), min_dec5(1), max_dec5(1)] =  decoherence('ZZZZIIZ');
[decoherence5(2), min_dec5(2), max_dec5(2)] =  decoherence('ZZZIIZZ');
[decoherence5(3), min_dec5(3), max_dec5(3)] =  decoherence('ZZZIZIZ');
[decoherence5(4), min_dec5(4), max_dec5(4)] =  decoherence('ZZIZIZZ');

mean_dec(5) = mean(decoherence5)
upperbound(5) = mean(min_dec5) - mean_dec(5)
lowerbound(5) = mean(max_dec5) - mean_dec(5)

% coh6
[decoherence6(1), min_dec6(1), max_dec6(1)] =  decoherence('ZZZZIZZ');

mean_dec(6) = mean(decoherence6)
upperbound(6) = mean(min_dec6) - mean_dec(6)
lowerbound(6) = mean(max_dec6) - mean_dec(6)

% coh7
[decoherence7(1), min_dec7(1), max_dec7(1)]  =  decoherence('ZZZZZZZ');

mean_dec(7) = mean(decoherence7)
upperbound(7) = mean(min_dec7) - mean_dec(7)
lowerbound(7) = mean(max_dec7) - mean_dec(7)