clear;

%% Initial State
Ini_coh2(1) = 0.6359; %Z1Z2
Ini_coh2(2) = 0.6070; %Z6
Ini_coh2(3) = 0.6836; %Z5
Ini_coh2(4) = 0.6729; %Z4
Ini_coh2(5) = 0.6594; %Z3
Ini_coh2(6) = 0.6680;

Ini_coh2 = Ini_coh2/max(Ini_coh2);
mean(Ini_coh2)
std(Ini_coh2)
%% Final State
Decoherence = 0.8521;

% Z1Z2Z3
Fin_coh3(1) = 0.6801; 
Fin_coh3(2) = 0.7830;
Fin_coh3(3) = 0.7521;
Fin_coh3(4) = 0.9200; 
Fin_coh3(5) = 0.8323;
Fin_coh3(6) = 0;
Fin_coh3(7) = 0.8185; 
Fin_coh3(8) = 0.7451; 
Fin_coh3(9) = 0.7022;
Fin_coh3(10) = 0.7629;
Fin_coh3(11) = 0.6747; 
Fin_coh3(12) = 0.7813;
Fin_coh3(13) = 0.6799;
Fin_coh3(14) = 0.7471; 
Fin_coh3(15) = 0.6998; 
Fin_coh3(16) = 0.6097;
Fin_coh3(17) = 0.7815;
Fin_coh3(18) = 0; 
Fin_coh3(19) = 0.7247;
Fin_coh3(20) = 0.7049;
Fin_coh3(21) = 0.7347; 
Fin_coh3(22) = 0; 
Fin_coh3(23) = 0;
Fin_coh3(24) = 0.7001;
Fin_coh3(25) = 0.6962; 
Fin_coh3(26) = 0.7313;
Fin_coh3(27) = 0.6964;



% Z4Z6Z7
Fin_coh3(28) = 0.5134; 
Fin_coh3(29) = 0.7993;
Fin_coh3(30) = 0.8881;
Fin_coh3(31) = 0.5033; 
Fin_coh3(32) = 0.7336;
Fin_coh3(33) = 0.8739;
Fin_coh3(34) = 0; 
Fin_coh3(35) = 0.7349; 
Fin_coh3(36) = 0.7407;
Fin_coh3(37) = 0.4406;
Fin_coh3(38) = 0.8322; 
Fin_coh3(39) = 0.7239;
Fin_coh3(40) = 0.6289;
Fin_coh3(41) = 0.8118; 
Fin_coh3(42) = 0.7540; 
Fin_coh3(43) = 0;
Fin_coh3(44) = 0.7914;
Fin_coh3(45) = 0.7887; 
Fin_coh3(46) = 0;
Fin_coh3(47) = 0.7777;
Fin_coh3(48) = 0.7057; 
Fin_coh3(49) = 0; 
Fin_coh3(50) = 0.8220;
Fin_coh3(51) = 0.7582;
Fin_coh3(52) = 0.7497; 
Fin_coh3(53) = 0.7666;
Fin_coh3(54) = 0.7460;

 for ii = 28:54
     Fin_coh3(ii) =  Fin_coh3(ii)*Ini_coh2(2)/Ini_coh2(1);
 end
% Z1Z2Z7
Fin_coh3(55) = 2; 
Fin_coh3(56) = 0;
Fin_coh3(57) = 0;
Fin_coh3(58) = 0; 
Fin_coh3(59) = 2;
Fin_coh3(60) = 0.7993;
Fin_coh3(61) = 0.8071; 
Fin_coh3(62) = 2; 
Fin_coh3(63) = 0.7896;
Fin_coh3(64) = 2;
Fin_coh3(65) = 0; 
Fin_coh3(66) = 0;
Fin_coh3(67) = 0;
Fin_coh3(68) = 2; 
Fin_coh3(69) = 0.8697; 
Fin_coh3(70) = 0.8553;
Fin_coh3(71) = 2;
Fin_coh3(72) = 2; 
Fin_coh3(73) = 0.7363;
Fin_coh3(74) = 0.6377;
Fin_coh3(75) = 0.8249; 
Fin_coh3(76) = 0.7156; 
Fin_coh3(77) = 0.6286;
Fin_coh3(78) = 0;
Fin_coh3(79) = 0.7489; 
Fin_coh3(80) = 0;
Fin_coh3(81) = 0;

 for ii = 55:81
     Fin_coh3(ii) =  Fin_coh3(ii)*Ini_coh2(3)/Ini_coh2(1);
 end

% Z2Z3Z7
Fin_coh3(82) = 0; 
Fin_coh3(83) = 0;
Fin_coh3(84) = 0;
Fin_coh3(85) = 0; 
Fin_coh3(86) = 0;
Fin_coh3(87) = 0;
Fin_coh3(88) = 0.6862; 
Fin_coh3(89) = 0.7825; 
Fin_coh3(90) = 0.8606;
Fin_coh3(91) = 0;
Fin_coh3(92) = 0.8704; 
Fin_coh3(93) = 0.8484;
Fin_coh3(94) = 0;
Fin_coh3(95) = 0.8668; 
Fin_coh3(96) = 0.8499; 
Fin_coh3(97) = 0.6941;
Fin_coh3(98) = 0.7283;
Fin_coh3(99) = 0.8620; 
Fin_coh3(100) = 0.8984;
Fin_coh3(101) = 0.7763;
Fin_coh3(102) = 0.9166; 
Fin_coh3(103) = 0.8620; 
Fin_coh3(104) = 0.8558;
Fin_coh3(105) = 2;
Fin_coh3(106) = 0.8681; 
Fin_coh3(107) = 0;
Fin_coh3(108) = 0;

 for ii = 82:108
     Fin_coh3(ii) =  Fin_coh3(ii)*Ini_coh2(4)/Ini_coh2(1);
 end
         
% Z2Z4Z7
Fin_coh3(109) = 0.8163; 
Fin_coh3(110) = 0.9506;
Fin_coh3(111) = 0.9253;
Fin_coh3(112) = 0.5901; 
Fin_coh3(113) = 0.6963;
Fin_coh3(114) = 0.7407;
Fin_coh3(115) = 0.6276; 
Fin_coh3(116) = 0.6729; 
Fin_coh3(117) = 0.8685;
Fin_coh3(118) = 0.9266;
Fin_coh3(119) = 0.7275; 
Fin_coh3(120) = 0.6901;
Fin_coh3(121) = 0.6661;
Fin_coh3(122) = 0.8020; 
Fin_coh3(123) = 0.7637; 
Fin_coh3(124) = 0.5498;
Fin_coh3(125) = 0.5877;
Fin_coh3(126) = 0.8357; 
Fin_coh3(127) = 0.7924;
Fin_coh3(128) = 0.7857;
Fin_coh3(129) = 0.7742; 
Fin_coh3(130) = 0.7318; 
Fin_coh3(131) = 0.8161;
Fin_coh3(132) = 0.8354;
Fin_coh3(133) = 0.8429; 
Fin_coh3(134) = 0.5928;
Fin_coh3(135) = 0.8041;

 for ii = 109:135
     Fin_coh3(ii) =  Fin_coh3(ii)*Ini_coh2(5)/Ini_coh2(1);
 end

% Z2Z6Z7
Fin_coh3(136) = 0.8398; 
Fin_coh3(137) = 0.9399;
Fin_coh3(138) = 0.8085;
Fin_coh3(139) = 0.8253;  
Fin_coh3(140) = 0.9650;
Fin_coh3(141) = 0.8202;
Fin_coh3(142) = 0.6425; 
Fin_coh3(143) = 0;
Fin_coh3(144) = 0.7549;
Fin_coh3(145) = 0.8373; 
Fin_coh3(146) = 0.8329; 
Fin_coh3(147) = 0.9153;
Fin_coh3(148) = 0.8275;
Fin_coh3(149) = 0.8199; 
Fin_coh3(140) = 0.8216;
Fin_coh3(151) = 0.6935;
Fin_coh3(152) = 0.8066; 
Fin_coh3(153) = 0.6657; 
Fin_coh3(154) = 0.7523;
Fin_coh3(155) = 0.7969;
Fin_coh3(156) = 0.8324; 
Fin_coh3(157) = 0.8416;
Fin_coh3(158) = 0.7446;
Fin_coh3(159) = 0.8007; 
Fin_coh3(160) = 0.8091; 
Fin_coh3(161) = 0.7230;
Fin_coh3(162) = 0.7645;

 for ii = 136:162
     Fin_coh3(ii) =  Fin_coh3(ii)*Ini_coh2(6)/Ini_coh2(1);
 end
 
 
current_length = 162;
         
for ii = 1:current_length
    Fin_coh3(ii) =  Fin_coh3(ii)/Decoherence;
end


jj = 1;
for ii = 1:current_length
    if Fin_coh3(ii)>0.8 && Fin_coh3(ii)<1
        Exp_coh3(jj) = Fin_coh3(ii);
        jj = jj+1;
    end
end

length(Exp_coh3)
lamda_3 = mean(Exp_coh3)
delta_3 = std(Exp_coh3)

%Pr_1 = 2*exp(-0.05^2*1600/2)