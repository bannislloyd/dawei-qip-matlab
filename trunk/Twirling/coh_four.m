clear;

%% Initial State
Ini_coh2(1) = 1; %Z1Z2
Ini_coh2(2) = 0.9369; %Z6
Ini_coh2(3) = 0.9542; %Z5
Ini_coh2(4) = 0.9291; %Z4
Ini_coh2(5) = 0.9532; %Z3


Ini_coh2 = Ini_coh2/max(Ini_coh2);
mean(Ini_coh2)
std(Ini_coh2)
%% Final State
Decoherence = 0.71;

% Z1Z2Z3Z7
Fin_coh4(1) = 0.6183; 
Fin_coh4(2) = 0.6270;
Fin_coh4(3) = 0.5727;
Fin_coh4(4) = 0.6488; 
Fin_coh4(5) = 0.6359;
Fin_coh4(6) = 0.5909;
Fin_coh4(7) = 0.6772; 
Fin_coh4(8) = 0; 
Fin_coh4(9) = 0;
Fin_coh4(10) = 0.6031;
Fin_coh4(11) = 0.6106; 
Fin_coh4(12) = 0.6006;
Fin_coh4(13) = 0.6509;
Fin_coh4(14) = 0.6386; 
Fin_coh4(15) = 0.6131; 
Fin_coh4(16) = 0;
Fin_coh4(17) = 0.6119;
Fin_coh4(18) = 0.5764; 
Fin_coh4(19) = 0.5939;
Fin_coh4(20) = 0;
Fin_coh4(21) = 0; 
Fin_coh4(22) = 0.5905; 
Fin_coh4(23) = 0;
Fin_coh4(24) = 0;
Fin_coh4(25) = 0.5934; 
Fin_coh4(26) = 0.5831;
Fin_coh4(27) = 0.5646;
Fin_coh4(28) = 0.6081; 
Fin_coh4(29) = 0.6497;
Fin_coh4(30) = 0.6117;
Fin_coh4(31) = 0.6558; 
Fin_coh4(32) = 0.6355;
Fin_coh4(33) = 0.6250;
Fin_coh4(34) = 0.6442; 
Fin_coh4(35) = 0; 
Fin_coh4(36) = 0;
Fin_coh4(37) = 0.6733;
Fin_coh4(38) = 0.6037; 
Fin_coh4(39) = 0.5607;
Fin_coh4(40) = 0.6507;
Fin_coh4(41) = 0.6097; 
Fin_coh4(42) = 0.5964; 
Fin_coh4(43) = 0;
Fin_coh4(44) = 0.6113;
Fin_coh4(45) = 0.5893; 
Fin_coh4(46) = 0.6162;
Fin_coh4(47) = 0;
Fin_coh4(48) = 0; 
Fin_coh4(49) = 0.6088; 
Fin_coh4(50) = 0;
Fin_coh4(51) = 0;
Fin_coh4(52) = 0.6208; 
Fin_coh4(53) = 0.6142;
Fin_coh4(54) = 0.6235;
Fin_coh4(55) = 0.6389; 
Fin_coh4(56) = 0;
Fin_coh4(57) = 0;
Fin_coh4(58) = 0.6503; 
Fin_coh4(59) = 0;
Fin_coh4(60) = 0;
Fin_coh4(61) = 0.6555; 
Fin_coh4(62) = 0.6242; 
Fin_coh4(63) = 0.6047;
Fin_coh4(64) = 0;
Fin_coh4(65) = 0.6246; 
Fin_coh4(66) = 0.5793;
Fin_coh4(67) = 0;
Fin_coh4(68) = 0.6217; 
Fin_coh4(69) = 0.6275; 
Fin_coh4(70) = 0.639;
Fin_coh4(71) = 0.6439;
Fin_coh4(72) = 0.6086; 
Fin_coh4(73) = 0.6248;
Fin_coh4(74) = 0.5993;
Fin_coh4(75) = 0.6042; 
Fin_coh4(76) = 0.6169; 
Fin_coh4(77) = 0.6284;
Fin_coh4(78) = 0.6091;
Fin_coh4(79) = 0.5972; 
Fin_coh4(80) = 0;
Fin_coh4(81) = 0;

% Z1Z2Z6Z7
Fin_coh4(82) = 0.5742;
Fin_coh4(83) = 0;
Fin_coh4(84) = 0; 
Fin_coh4(85) = 0.6348;
Fin_coh4(86) = 0;
Fin_coh4(87) = 0; 
Fin_coh4(88) = 0.6462; 
Fin_coh4(89) = 0;
Fin_coh4(90) = 0;
Fin_coh4(91) = 0; 
Fin_coh4(92) = 0.5749;
Fin_coh4(93) = 0.5858;
Fin_coh4(94) = 0; 
Fin_coh4(95) = 0.6138; 
Fin_coh4(96) = 0.5984;
Fin_coh4(97) = 0;
Fin_coh4(98) = 0.6483; 
Fin_coh4(99) = 0.6146;
Fin_coh4(100) = 0.5462;
Fin_coh4(101) = 0.5691; 
Fin_coh4(102) = 0.5875; 
Fin_coh4(103) = 0.5681;
Fin_coh4(104) = 0.6124;
Fin_coh4(105) = 0.5658; 
Fin_coh4(106) = 0.5710;
Fin_coh4(107) = 0.6048;
Fin_coh4(108) = 0.5991; 
Fin_coh4(109) = 0.5906;
Fin_coh4(110) = 0;
Fin_coh4(111) = 0; 
Fin_coh4(112) = 0.5974;
Fin_coh4(113) = 0;
Fin_coh4(114) = 0; 
Fin_coh4(115) = 0.6065; 
Fin_coh4(116) = 0;
Fin_coh4(117) = 0;
Fin_coh4(118) = 0; 
Fin_coh4(119) = 0.5900;
Fin_coh4(120) = 0.5913;
Fin_coh4(121) = 0; 
Fin_coh4(122) = 0.6128; 
Fin_coh4(123) = 0.5877;
Fin_coh4(124) = 0;
Fin_coh4(125) = 0.6219; 
Fin_coh4(126) = 0.6139;
Fin_coh4(127) = 0.5791;
Fin_coh4(128) = 0.5991; 
Fin_coh4(129) = 0.5680; 
Fin_coh4(130) = 0.5791;
Fin_coh4(131) = 0.5849;
Fin_coh4(132) = 0.5993; 
Fin_coh4(133) = 0.5703;
Fin_coh4(134) = 0.5911;
Fin_coh4(135) = 0.5966; 
Fin_coh4(136) = 0.5919;
Fin_coh4(137) = 0.5796;
Fin_coh4(138) = 0.5724; 
Fin_coh4(139) = 0.5872;
Fin_coh4(140) = 0.6099;
Fin_coh4(141) = 0.5763; 
Fin_coh4(142) = 0.6086; 
Fin_coh4(143) = 0.6528;
Fin_coh4(144) = 0.6588;
Fin_coh4(145) = 0.5702; 
Fin_coh4(146) = 0.5763;
Fin_coh4(147) = 0.5644;
Fin_coh4(148) = 0.6662; 
Fin_coh4(149) = 0.6068; 
Fin_coh4(150) = 0.5618;
Fin_coh4(151) = 0.5964;
Fin_coh4(152) = 0.6442; 
Fin_coh4(153) = 0.6071;
Fin_coh4(154) = 0.5775;
Fin_coh4(155) = 0; 
Fin_coh4(156) = 0; 
Fin_coh4(157) = 0.6029;
Fin_coh4(158) = 0;
Fin_coh4(159) = 0; 
Fin_coh4(160) = 0.6101;
Fin_coh4(161) = 0;
Fin_coh4(162) = 0;

% Z1Z2Z4Z7
Fin_coh4(163) = 0.5830;
Fin_coh4(164) = 0; 
Fin_coh4(165) = 0;
Fin_coh4(166) = 0.3730;
Fin_coh4(167) = 0; 
Fin_coh4(168) = 0; 
Fin_coh4(169) = 0.6570;
Fin_coh4(170) = 0;
Fin_coh4(171) = 0; 
Fin_coh4(172) = 0;
Fin_coh4(173) = 0.5488;
Fin_coh4(174) = 0.5746; 
Fin_coh4(175) = 0; 
Fin_coh4(176) = 0.6027;
Fin_coh4(177) = 0.6134;
Fin_coh4(178) = 0; 
Fin_coh4(179) = 0.6068;
Fin_coh4(180) = 0.5584;
Fin_coh4(181) = 0.4823; 
Fin_coh4(182) = 0.5937; 
Fin_coh4(183) = 0.4929;
Fin_coh4(184) = 0.3986;
Fin_coh4(185) = 0.5744; 
Fin_coh4(186) = 0.4836;
Fin_coh4(187) = 0.5699;
Fin_coh4(188) = 0.5865; 
Fin_coh4(189) = 0.5904;
Fin_coh4(190) = 0.5331;
Fin_coh4(191) = 0; 
Fin_coh4(192) = 0;
Fin_coh4(193) = 0.3975;
Fin_coh4(194) = 0; 
Fin_coh4(195) = 0; 
Fin_coh4(196) = 0.5673;
Fin_coh4(197) = 0;
Fin_coh4(198) = 0; 
Fin_coh4(199) = 0;
Fin_coh4(200) = 0.5045;
Fin_coh4(201) = 0.5438; 
Fin_coh4(202) = 0; 
Fin_coh4(203) = 0.5943;
Fin_coh4(204) = 0.5840;
Fin_coh4(205) = 0; 
Fin_coh4(206) = 0.5909;
Fin_coh4(207) = 0.5814;
Fin_coh4(208) = 0.4237; 
Fin_coh4(209) = 0.5895; 
Fin_coh4(210) = 0.5740;
Fin_coh4(211) = 0.3448;
Fin_coh4(212) = 0.5958; 
Fin_coh4(213) = 0.5684;
Fin_coh4(214) = 0.6028;
Fin_coh4(215) = 0.6036; 
Fin_coh4(216) = 0.5943;
Fin_coh4(217) = 0.5906;
Fin_coh4(218) = 0.6022; 
Fin_coh4(219) = 0.6417;
Fin_coh4(220) = 0.4376;
Fin_coh4(221) = 0.6080; 
Fin_coh4(222) = 0.5389; 
Fin_coh4(223) = 0.6535;
Fin_coh4(224) = 0.6561;
Fin_coh4(225) = 0.5821; 
Fin_coh4(226) = 0.5860;
Fin_coh4(227) = 0.5631;
Fin_coh4(228) = 0.6357; 
Fin_coh4(229) = 0.4439; 
Fin_coh4(230) = 0.5884;
Fin_coh4(231) = 0.6106;
Fin_coh4(232) = 0.5973; 
Fin_coh4(233) = 0.6260;
Fin_coh4(234) = 0.5702;
Fin_coh4(235) = 0.5688; 
Fin_coh4(236) = 0; 
Fin_coh4(237) = 0;
Fin_coh4(238) = 0;
Fin_coh4(239) = 0; 
Fin_coh4(240) = 0;
Fin_coh4(241) = 0.6877;
Fin_coh4(242) = 0;
Fin_coh4(243) = 0;

% Z2Z3Z4Z7
Fin_coh4(244) = 0.6202; 
Fin_coh4(245) = 0;
Fin_coh4(246) = 0.6413;
Fin_coh4(247) = 0; 
Fin_coh4(248) = 0.5742; 
Fin_coh4(249) = 0.6714;
Fin_coh4(250) = 0.6217;
Fin_coh4(251) = 0.6892; 
Fin_coh4(252) = 0.6457;
Fin_coh4(253) = 0.5862;
Fin_coh4(254) = 0; 
Fin_coh4(255) = 0.5453; 
Fin_coh4(256) = 0.3987;
Fin_coh4(257) = 0.6563;
Fin_coh4(258) = 0.4609; 
Fin_coh4(259) = 0.5862;
Fin_coh4(260) = 0.6350;
Fin_coh4(261) = 0.6750; 
Fin_coh4(262) = 0.5560; 
Fin_coh4(263) = 0.5715;
Fin_coh4(264) = 0.6421;
Fin_coh4(265) = 0; 
Fin_coh4(266) = 0.5809;
Fin_coh4(267) = 0.5742;
Fin_coh4(268) = 0.5887; 
Fin_coh4(269) = 0.6391;
Fin_coh4(270) = 0.5920;
Fin_coh4(271) = 0; 
Fin_coh4(272) = 0.5827;
Fin_coh4(273) = 0.6910;
Fin_coh4(274) = 0; 
Fin_coh4(275) = 0.5951; 
Fin_coh4(276) = 0.6706;
Fin_coh4(277) = 0;
Fin_coh4(278) = 0.5758; 
Fin_coh4(279) = 0.5165;
Fin_coh4(280) = 0.6896;
Fin_coh4(281) = 0.5560; 
Fin_coh4(282) = 0.6865; 
Fin_coh4(283) = 0;
Fin_coh4(284) = 0.5904;
Fin_coh4(285) = 0.5675; 
Fin_coh4(286) = 0;
Fin_coh4(287) = 0.6195;
Fin_coh4(288) = 0.5687; 
Fin_coh4(289) = 0.6830; 
Fin_coh4(290) = 0.5962;
Fin_coh4(291) = 0.7060;
Fin_coh4(292) = 0.5704; 
Fin_coh4(293) = 0.4973;
Fin_coh4(294) = 0.6617;
Fin_coh4(295) = 0.5960; 
Fin_coh4(296) = 0.6365;
Fin_coh4(297) = 0.5744;
Fin_coh4(298) = 0.5489; 
Fin_coh4(299) = 0.5844;
Fin_coh4(300) = 0.6146;
Fin_coh4(301) = 0; 
Fin_coh4(302) = 0.6182; 
Fin_coh4(303) = 0.5480;
Fin_coh4(304) = 0.5525;
Fin_coh4(305) = 0.5996; 
Fin_coh4(306) = 0.5544;
Fin_coh4(307) = 0.6173;
Fin_coh4(308) = 0.6635; 
Fin_coh4(309) = 0.5677; 
Fin_coh4(310) = 0;
Fin_coh4(311) = 0.5907;
Fin_coh4(312) = 0.6208; 
Fin_coh4(313) = 0.6626;
Fin_coh4(314) = 0.6117;
Fin_coh4(315) = 0.5771; 
Fin_coh4(316) = 0.6904; 
Fin_coh4(317) = 0.5862;
Fin_coh4(318) = 0.6683;
Fin_coh4(319) = 0.6945; 
Fin_coh4(320) = 0.5822;
Fin_coh4(321) = 0.6182;
Fin_coh4(322) = 0.6670;
Fin_coh4(323) = 0;
Fin_coh4(324) = 0.6673;

% Z2Z3Z6Z7
Fin_coh4(325) = 0.6074;
Fin_coh4(326) = 0.5716;
Fin_coh4(327) = 0.6910; 
Fin_coh4(328) = 0.6104; 
Fin_coh4(329) = 0.5505;
Fin_coh4(330) = 0;
Fin_coh4(331) = 0.6049; 
Fin_coh4(332) = 0.6838;
Fin_coh4(333) = 0;
Fin_coh4(334) = 0.5815; 
Fin_coh4(335) = 0.5933; 
Fin_coh4(336) = 0.6404;
Fin_coh4(337) = 0.6370;
Fin_coh4(338) = 0.6981; 
Fin_coh4(339) = 0.6341;
Fin_coh4(340) = 0.6359;
Fin_coh4(341) = 0.6003; 
Fin_coh4(342) = 0.4804; 
Fin_coh4(343) = 0.5684;
Fin_coh4(344) = 0.5837;
Fin_coh4(345) = 0.5704; 
Fin_coh4(346) = 0.5663;
Fin_coh4(347) = 0.6430;
Fin_coh4(348) = 0.5711; 
Fin_coh4(349) = 0.5704;
Fin_coh4(350) = 0.5835;
Fin_coh4(351) = 0.6235; 
Fin_coh4(352) = 0;
Fin_coh4(353) = 0.5755;
Fin_coh4(354) = 0.6235; 
Fin_coh4(355) = 0.6164; 
Fin_coh4(356) = 0.6066;
Fin_coh4(357) = 0.6528;
Fin_coh4(358) = 0; 
Fin_coh4(359) = 0.6013;
Fin_coh4(360) = 0.5142;
Fin_coh4(361) = 0.7082; 
Fin_coh4(362) = 0.5682; 
Fin_coh4(363) = 0.6919;
Fin_coh4(364) = 0.6741;
Fin_coh4(365) = 0.5778; 
Fin_coh4(366) = 0.6848;
Fin_coh4(367) = 0;
Fin_coh4(368) = 0.6217; 
Fin_coh4(369) = 0.5986; 
Fin_coh4(370) = 0.6047;
Fin_coh4(371) = 0.5760;
Fin_coh4(372) = 0.6475; 
Fin_coh4(373) = 0.6425;
Fin_coh4(374) = 0.6670;
Fin_coh4(375) = 0.5702; 
Fin_coh4(376) = 0.6223;
Fin_coh4(377) = 0.5906;
Fin_coh4(378) = 0.5730; 
Fin_coh4(379) = 0.5773;
Fin_coh4(380) = 0.5895;
Fin_coh4(381) = 0.6096; 
Fin_coh4(382) = 0.6119; 
Fin_coh4(383) = 0.6217;
Fin_coh4(384) = 0.5984;
Fin_coh4(385) = 0.6741; 
Fin_coh4(386) = 0;
Fin_coh4(387) = 0.5908;
Fin_coh4(388) = 0.7049; 
Fin_coh4(389) = 0.5733; 
Fin_coh4(390) = 0.6403;
Fin_coh4(391) = 0.6857;
Fin_coh4(392) = 0.6777; 
Fin_coh4(393) = 0.6144;
Fin_coh4(394) = 0.6732;
Fin_coh4(395) = 0.6768; 
Fin_coh4(396) = 0.6240; 
Fin_coh4(397) = 0.5720;
Fin_coh4(398) = 0.5240;
Fin_coh4(399) = 0.6718; 
Fin_coh4(400) = 0.5711;
Fin_coh4(401) = 0.6550;
Fin_coh4(402) = 0.6186;
Fin_coh4(403) = 0;
Fin_coh4(404) = 0;
Fin_coh4(405) = 0;

current_length = 405;
         
for ii = 1:current_length
    Fin_coh4(ii) =  Fin_coh4(ii)/Decoherence;
end


jj = 1;
for ii = 1:current_length
    if Fin_coh4(ii)>0.8 && Fin_coh4(ii)<1
        Exp_coh4(jj) = Fin_coh4(ii);
        jj = jj+1;
    end
end

length(Exp_coh4)
lamda_4 = mean(Exp_coh4)
delta_4 = std(Exp_coh4)

%Pr_1 = 2*exp(-0.05^2*1600/2)