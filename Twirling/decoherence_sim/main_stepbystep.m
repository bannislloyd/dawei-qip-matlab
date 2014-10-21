clear;

% coh1
% dec_stepbystep('IZIIIII');
% dec_stepbystep('IIIIIIZ');
% dec_stepbystep('IIIIZII');

load IZIIIII_loss.mat
dec1(1) = mean(Loss);
load IIIIIIZ_loss.mat
dec1(2) = mean(Loss);
load IIIIZII_loss.mat
dec1(3) = mean(Loss);

dec_weight(1) = mean(dec1);

% coh2
% dec_stepbystep('ZZIIIII');
% dec_stepbystep('IZZIIII');
% dec_stepbystep('IZIIIIZ');
% dec_stepbystep('IIIZIIZ');
% dec_stepbystep('IIIIIZZ');

load ZZIIIII_loss.mat
dec2(1) = mean(Loss);
load IZZIIII_loss.mat
dec2(2) = mean(Loss);
load IZIIIIZ_loss.mat
dec2(3) = mean(Loss);
load IIIZIIZ_loss.mat
dec2(4) = mean(Loss);
load IIIIIZZ_loss.mat
dec2(5) = mean(Loss);

dec_weight(2) = mean(dec2);
%
%% coh3
% dec_stepbystep('ZZZIIII');
% dec_stepbystep('IIIZIZZ');
% dec_stepbystep('ZZIIIIZ');
% dec_stepbystep('IZZIIIZ');
% dec_stepbystep('IZIZIIZ');
% dec_stepbystep('IZIIIZZ');

load ZZZIIII_loss.mat
dec3(1) = mean(Loss);
load IIIZIZZ_loss.mat
dec3(2) = mean(Loss);
load ZZIIIIZ_loss.mat
dec3(3) = mean(Loss);
load IZZIIIZ_loss.mat
dec3(4) = mean(Loss);
load IZIZIIZ_loss.mat
dec3(5) = mean(Loss);
load IZIIIZZ_loss.mat
dec3(6) = mean(Loss);

dec_weight(3) = mean(dec3);
%
%% coh4
% dec_stepbystep('ZZZIIIZ');
% dec_stepbystep('ZZIIIZZ');
% dec_stepbystep('ZZIZIIZ');
% dec_stepbystep('IZZZIIZ');
% dec_stepbystep('IZZIIZZ');

load ZZZIIIZ_loss.mat
dec4(1) = mean(Loss);
load ZZIIIZZ_loss.mat
dec4(2) = mean(Loss);
load ZZIZIIZ_loss.mat
dec4(3) = mean(Loss);
load IZZZIIZ_loss.mat
dec4(4) = mean(Loss);
load IZZIIZZ_loss.mat
dec4(5) = mean(Loss);

dec_weight(4) = mean(dec4);
%
%% coh5
% dec_stepbystep('ZZZZIIZ');
% dec_stepbystep('ZZZIIZZ');
% dec_stepbystep('ZZZIZIZ');
% dec_stepbystep('ZZIZIZZ');

load ZZZZIIZ_loss.mat
dec5(1) = mean(Loss);
load ZZZIIZZ_loss.mat
dec5(2) = mean(Loss);
load ZZZIZIZ_loss.mat
dec5(3) = mean(Loss);
load ZZIZIZZ_loss.mat
dec5(4) = mean(Loss);

dec_weight(5) = mean(dec5);


% dec_stepbystep('ZZZZIZZ');
load ZZZZIZZ_loss.mat
dec6(1) = mean(Loss);


% dec_stepbystep('ZZZZZZZ');
load ZZZZZZZ_loss.mat
dec7(1) = mean(Loss);


dec_weight