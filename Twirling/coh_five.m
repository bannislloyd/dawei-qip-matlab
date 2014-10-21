clear;

%% Initial State
Ini_coh2(1) = 0.9757; %Z1Z2
Ini_coh2(2) = 0.9197; %Z6
Ini_coh2(3) = 0.9632; %Z5
Ini_coh2(4) = 0.9927; %Z4
Ini_coh2(5) = 1.0522; %Z3


Ini_coh2 = Ini_coh2/max(Ini_coh2);
mean(Ini_coh2)
std(Ini_coh2)
%% Final State
Decoherence = 0.621;

% Z1Z2Z3Z4Z7
Fin_coh5(1) = 0; 
Fin_coh5(2) = 0.5693;
Fin_coh5(3) = 0.6448;
Fin_coh5(4) = 0; 
Fin_coh5(5) = 0.6963;
Fin_coh5(6) = 0.5755;
Fin_coh5(7) = 0.5782; 
Fin_coh5(8) = 0.5998; 
Fin_coh5(9) = 0.5730;
Fin_coh5(10) = 0;
Fin_coh5(11) = 0.5791; 
Fin_coh5(12) = 0.5809;
Fin_coh5(13) = 0.5686;

Fin_coh5(14) = 0.5809; 
Fin_coh5(15) = 0.5713; 
Fin_coh5(16) = 0.6954;
Fin_coh5(17) = 0.5934;
Fin_coh5(18) = 0.6178; 
Fin_coh5(19) = 0.5751;
Fin_coh5(20) = 0.7002;
Fin_coh5(21) = 0.6546; 
Fin_coh5(22) = 0; 
Fin_coh5(23) = 0.5754;

Fin_coh5(24) = 0.6175;
Fin_coh5(25) = 0.6333; 
Fin_coh5(26) = 0.6431;
Fin_coh5(27) = 0.6074;
Fin_coh5(28) = 0.5924; 
Fin_coh5(29) = 0.6901;
Fin_coh5(30) = 0.6146;
Fin_coh5(31) = 0; 
Fin_coh5(32) = 0.5780;
Fin_coh5(33) = 0.5682;

Fin_coh5(34) = 0.6883; 
Fin_coh5(35) = 0.6036; 
Fin_coh5(36) = 0.5249;
Fin_coh5(37) = 0.5773;
Fin_coh5(38) = 0.6075; 
Fin_coh5(39) = 0.5107;
Fin_coh5(40) = 0.5684;
Fin_coh5(41) = 0.6048; 
Fin_coh5(42) = 0.5817; 
Fin_coh5(43) = 0.6626;

Fin_coh5(44) = 0.6002;
Fin_coh5(45) = 0.5823; 
Fin_coh5(46) = 0.5952;
Fin_coh5(47) = 0.6510;
Fin_coh5(48) = 0.5988; 
Fin_coh5(49) = 0.4916; 
Fin_coh5(50) = 0.6057;
Fin_coh5(51) = 0.6697;
Fin_coh5(52) = 0; 
Fin_coh5(53) = 0.6864;

Fin_coh5(54) = 0.6036;
Fin_coh5(55) = 0.6510; 
Fin_coh5(56) = 0.5773;
Fin_coh5(57) = 0.6175;
Fin_coh5(58) = 0; 
Fin_coh5(59) = 0.5696;
Fin_coh5(60) = 0.5878;
Fin_coh5(61) = 0.5924; 
Fin_coh5(62) = 0.5966; 
Fin_coh5(63) = 0.6010;

Fin_coh5(64) = 0.6865;
Fin_coh5(65) = 0.5701; 
Fin_coh5(66) = 0.6241;
Fin_coh5(67) = 0;
Fin_coh5(68) = 0.6088; 
Fin_coh5(69) = 0.5795; 
Fin_coh5(70) = 0.5746;
Fin_coh5(71) = 0.6086;
Fin_coh5(72) = 0; 
Fin_coh5(73) = 0.5711;

Fin_coh5(74) = 0.5915;
Fin_coh5(75) = 0.6208; 
Fin_coh5(76) = 0; 
Fin_coh5(77) = 0.5695;
Fin_coh5(78) = 0;
Fin_coh5(79) = 0.6413; 
Fin_coh5(80) = 0.5858;
Fin_coh5(81) = 0.6221;
Fin_coh5(82) = 0;
Fin_coh5(83) = 0.6013;

Fin_coh5(84) = 0.6732; 
Fin_coh5(85) = 0;
Fin_coh5(86) = 0.5302;
Fin_coh5(87) = 0.5685; 
Fin_coh5(88) = 0.5744; 
Fin_coh5(89) = 0.6191;
Fin_coh5(90) = 0.5712;
Fin_coh5(91) = 0; 
Fin_coh5(92) = 0.6940;
Fin_coh5(93) = 0.6794;

Fin_coh5(94) = 0.5755; 
Fin_coh5(95) = 0; 
Fin_coh5(96) = 0;
Fin_coh5(97) = 0.6679;
Fin_coh5(98) = 0.6131; 
Fin_coh5(99) = 0.6223;
Fin_coh5(100) = 0.5683;
Fin_coh5(101) = 0.7006; 
Fin_coh5(102) = 0.6740; 
Fin_coh5(103) = 0;

Fin_coh5(104) = 0.5451;
Fin_coh5(105) = 0.6067; 
Fin_coh5(106) = 0.5791;
Fin_coh5(107) = 0.6526;
Fin_coh5(108) = 0.6291; 
Fin_coh5(109) = 0.5711;
Fin_coh5(110) = 0.6688;
Fin_coh5(111) = 0.6528; 
Fin_coh5(112) = 0;
Fin_coh5(113) = 0.7007;

Fin_coh5(114) = 0; 
Fin_coh5(115) = 0.6404; 
Fin_coh5(116) = 0.6180;
Fin_coh5(117) = 0.5758;
Fin_coh5(118) = 0.6874; 
Fin_coh5(119) = 0.6652;
Fin_coh5(120) = 0.4938;
Fin_coh5(121) = 0.5711; 
Fin_coh5(122) = 0.5702; 
Fin_coh5(123) = 0.5691;

Fin_coh5(124) = 0.6928;
Fin_coh5(125) = 0.5741; 
Fin_coh5(126) = 0.5731;
Fin_coh5(127) = 0.6127;
Fin_coh5(128) = 0.6235; 
Fin_coh5(129) = 0.6492; 
Fin_coh5(130) = 0.5090;
Fin_coh5(131) = 0.6874;
Fin_coh5(132) = 0.6918; 
Fin_coh5(133) = 0;

Fin_coh5(134) = 0;
Fin_coh5(135) = 0.5798; 
Fin_coh5(136) = 0.6608;
Fin_coh5(137) = 0.5682;
Fin_coh5(138) = 0.6374; 
Fin_coh5(139) = 0;
Fin_coh5(140) = 0.5925;
Fin_coh5(141) = 0.5925; 
Fin_coh5(142) = 0.5746; 
Fin_coh5(143) = 0.6304;

Fin_coh5(144) = 0.7041;
Fin_coh5(145) = 0.6555; 
Fin_coh5(146) = 0.6657;
Fin_coh5(147) = 0.6364;
Fin_coh5(148) = 0; 
Fin_coh5(149) = 0; 
Fin_coh5(150) = 0.5716;
Fin_coh5(151) = 0.5704;
Fin_coh5(152) = 0.5840; 
Fin_coh5(153) = 0.6803;

Fin_coh5(154) = 0;
Fin_coh5(155) = 0.5995; 
Fin_coh5(156) = 0.5293; 
Fin_coh5(157) = 0;
Fin_coh5(158) = 0.5690;
Fin_coh5(159) = 0.5382; 
Fin_coh5(160) = 0.6324;
Fin_coh5(161) = 0.5923;
Fin_coh5(162) = 0.5684;
Fin_coh5(163) = 0.5733;

Fin_coh5(164) = 0.6585; 
Fin_coh5(165) = 0.6175;
Fin_coh5(166) = 0;
Fin_coh5(167) = 0.5785; 
Fin_coh5(168) = 0.6311; 
Fin_coh5(169) = 0.5871;
Fin_coh5(170) = 0.6320;
Fin_coh5(171) = 0.6345; 
Fin_coh5(172) = 0.6235;
Fin_coh5(173) = 0.6936;

Fin_coh5(174) = 0.6250; 
Fin_coh5(175) = 0; 
Fin_coh5(176) = 0.6080;
Fin_coh5(177) = 0.6415;
Fin_coh5(178) = 0.5889; 
Fin_coh5(179) = 0.6364;
Fin_coh5(180) = 0.6963;
Fin_coh5(181) = 0.5364; 
Fin_coh5(182) = 0.6439; 
Fin_coh5(183) = 0.6794;

Fin_coh5(184) = 0;
Fin_coh5(185) = 0.5258; 
Fin_coh5(186) = 0.5435;
Fin_coh5(187) = 0.7014;
Fin_coh5(188) = 0.6343; 
Fin_coh5(189) = 0.5583;
Fin_coh5(190) = 0.5918;
Fin_coh5(191) = 0.5986; 
Fin_coh5(192) = 0.6856;
Fin_coh5(193) = 0.5127;

Fin_coh5(194) = 0.7031; 
Fin_coh5(195) = 0.6750; 
Fin_coh5(196) = 0;
Fin_coh5(197) = 0.5773;
Fin_coh5(198) = 0.5244; 
Fin_coh5(199) = 0.5692;
Fin_coh5(200) = 0.5666;
Fin_coh5(201) = 0.6706; 
Fin_coh5(202) = 0.5087; 
Fin_coh5(203) = 0.6901;

Fin_coh5(204) = 0.6990;
Fin_coh5(205) = 0; 
Fin_coh5(206) = 0.6289;
Fin_coh5(207) = 0.5696;
Fin_coh5(208) = 0.5906; 
Fin_coh5(209) = 0.5879; 
Fin_coh5(210) = 0.6928;
Fin_coh5(211) = 0;
Fin_coh5(212) = 0; 
Fin_coh5(213) = 0.5844;

Fin_coh5(214) = 0.7091;
Fin_coh5(215) = 0.6242; 
Fin_coh5(216) = 0.5697;
Fin_coh5(217) = 0.5826;
Fin_coh5(218) = 0.5826; 
Fin_coh5(219) = 0;
Fin_coh5(220) = 0;
Fin_coh5(221) = 0.5578; 
Fin_coh5(222) = 0.6368; 
Fin_coh5(223) = 0.5879;

Fin_coh5(224) = 0.5692;
Fin_coh5(225) = 0.5684; 
Fin_coh5(226) = 0.6119;
Fin_coh5(227) = 0.6564;
Fin_coh5(228) = 0.5791; 
Fin_coh5(229) = 0; 
Fin_coh5(230) = 0.6235;
Fin_coh5(231) = 0.6626;
Fin_coh5(232) = 0.6333; 
Fin_coh5(233) = 0.6017;

Fin_coh5(234) = 0.5704;
Fin_coh5(235) = 0.6839; 
Fin_coh5(236) = 0.5789; 
Fin_coh5(237) = 0.6347;
Fin_coh5(238) = 0;
Fin_coh5(239) = 0.5273; 
Fin_coh5(240) = 0.6068;
Fin_coh5(241) = 0.6199;
Fin_coh5(242) = 0.5747;
Fin_coh5(243) = 0.5799;
 
 
 
% Z1Z2Z3Z6Z7
Fin_coh5(244) = 0.5738; 
Fin_coh5(245) = 0.5933;
Fin_coh5(246) = 0.6430;
Fin_coh5(247) = 0.5961; 
Fin_coh5(248) = 0.5897; 
Fin_coh5(249) = 0.6865;
Fin_coh5(250) = 0.5693;

Fin_coh5(251) = 0.6732; 
Fin_coh5(252) = 0.6022;
Fin_coh5(253) = 0.6343;
Fin_coh5(254) = 0.5688; 
Fin_coh5(255) = 0.5693; 
Fin_coh5(256) = 0.6639;
Fin_coh5(257) = 0.5889;
Fin_coh5(258) = 0.6572; 
Fin_coh5(259) = 0.6222;
Fin_coh5(260) = 0.5800;

Fin_coh5(261) = 0.5836; 
Fin_coh5(262) = 0.5742; 
Fin_coh5(263) = 0.7034;
Fin_coh5(264) = 0.6393;
Fin_coh5(265) = 0; 
Fin_coh5(266) = 0.5720;
Fin_coh5(267) = 0.6187;
Fin_coh5(268) = 0.5933; 
Fin_coh5(269) = 0.6446;
Fin_coh5(270) = 0.6070;

Fin_coh5(271) = 0.6436; 
Fin_coh5(272) = 0;
Fin_coh5(273) = 0;
Fin_coh5(274) = 0; 
Fin_coh5(275) = 0.6865; 
Fin_coh5(276) = 0.5720;
Fin_coh5(277) = 0.6146;
Fin_coh5(278) = 0.6418; 
Fin_coh5(279) = 0.5751;
Fin_coh5(280) = 0;

Fin_coh5(281) = 0.5924; 
Fin_coh5(282) = 0.6004; 
Fin_coh5(283) = 0;
Fin_coh5(284) = 0.6741;
Fin_coh5(285) = 0.6279; 
Fin_coh5(286) = 0.5951;
Fin_coh5(287) = 0.6541;
Fin_coh5(288) = 0.5837; 
Fin_coh5(289) = 0.5684; 
Fin_coh5(290) = 0.6306;

Fin_coh5(291) = 0.6803;
Fin_coh5(292) = 0; 
Fin_coh5(293) = 0.6519;
Fin_coh5(294) = 0.6057;
Fin_coh5(295) = 0; 
Fin_coh5(296) = 0.5773;
Fin_coh5(297) = 0.6111;
Fin_coh5(298) = 0.5790; 
Fin_coh5(299) = 0.6175;
Fin_coh5(300) = 0.6222;

Fin_coh5(301) = 0.6432; 
Fin_coh5(302) = 0.5868; 
Fin_coh5(303) = 0.5792;
Fin_coh5(304) = 0.6722;
Fin_coh5(305) = 0.5931; 
Fin_coh5(306) = 0.5953;
Fin_coh5(307) = 0.5964;
Fin_coh5(308) = 0.6456; 
Fin_coh5(309) = 0.6039; 
Fin_coh5(310) = 0.6648;

Fin_coh5(311) = 0.6058;
Fin_coh5(312) = 0.5698; 
Fin_coh5(313) = 0.6802;
Fin_coh5(314) = 0.5827;
Fin_coh5(315) = 0.5884; 
Fin_coh5(316) = 0.6630; 
Fin_coh5(317) = 0.5769;
Fin_coh5(318) = 0.5738;
Fin_coh5(319) = 0.6719; 
Fin_coh5(320) = 0.6111;

Fin_coh5(321) = 0.6244;
Fin_coh5(322) = 0.6574;
Fin_coh5(323) = 0.6164;
Fin_coh5(324) = 0.6084;
Fin_coh5(325) = 0.5423;
Fin_coh5(326) = 0.6555;
Fin_coh5(327) = 0.5871; 
Fin_coh5(328) = 0.5442; 
Fin_coh5(329) = 0.6794;
Fin_coh5(330) = 0.5817;

Fin_coh5(331) = 0.5813; 
Fin_coh5(332) = 0.6590;
Fin_coh5(333) = 0.6137;
Fin_coh5(334) = 0.5902; 
Fin_coh5(335) = 0.7043; 
Fin_coh5(336) = 0;
Fin_coh5(337) = 0.5947;
Fin_coh5(338) = 0.7096; 
Fin_coh5(339) = 0.5694;
Fin_coh5(340) = 0.5861;

Fin_coh5(341) = 0.6288; 
Fin_coh5(342) = 0.6599; 
Fin_coh5(343) = 0.5961;
Fin_coh5(344) = 0.6775;
Fin_coh5(345) = 0.6187; 
Fin_coh5(346) = 0.5855;
Fin_coh5(347) = 0.6484;
Fin_coh5(348) = 0.5938; 
Fin_coh5(349) = 0.6089;
Fin_coh5(350) = 0.6329;

Fin_coh5(351) = 0.6273; 
Fin_coh5(352) = 0.6207;
Fin_coh5(353) = 0.5686;
Fin_coh5(354) = 0; 
Fin_coh5(355) = 0.6166; 
Fin_coh5(356) = 0.5809;
Fin_coh5(357) = 0;
Fin_coh5(358) = 0.6953; 
Fin_coh5(359) = 0.6146;
Fin_coh5(360) = 0.5791;

Fin_coh5(361) = 0.6411; 
Fin_coh5(362) = 0.5746; 
Fin_coh5(363) = 0.5951;
Fin_coh5(364) = 0.6518;
Fin_coh5(365) = 0.6031; 
Fin_coh5(366) = 0.5735;
Fin_coh5(367) = 0.6653;
Fin_coh5(368) = 0.6528; 
Fin_coh5(369) = 0.5692; 
Fin_coh5(370) = 0.6671;

Fin_coh5(371) = 0.6492;
Fin_coh5(372) = 0.5779; 
Fin_coh5(373) = 0.6544;
Fin_coh5(374) = 0.6359;
Fin_coh5(375) = 0.5960; 
Fin_coh5(376) = 0;
Fin_coh5(377) = 0.5702;
Fin_coh5(378) = 0.5773; 
Fin_coh5(379) = 0.6059;
Fin_coh5(380) = 0.6213;

Fin_coh5(381) = 0.6364; 
Fin_coh5(382) = 0.6402; 
Fin_coh5(383) = 0.6042;
Fin_coh5(384) = 0.6020;
Fin_coh5(385) = 0.6204; 
Fin_coh5(386) = 0.6232;
Fin_coh5(387) = 0.6055;
Fin_coh5(388) = 0.5506; 
Fin_coh5(389) = 0.6522; 
Fin_coh5(390) = 0.6282;

Fin_coh5(391) = 0.6284;
Fin_coh5(392) = 0.6115; 
Fin_coh5(393) = 0.5881;
Fin_coh5(394) = 0.6314;
Fin_coh5(395) = 0.6134; 
Fin_coh5(396) = 0.6156; 
Fin_coh5(397) = 0.6651;
Fin_coh5(398) = 0.5680;
Fin_coh5(399) = 0.5746; 
Fin_coh5(400) = 0.6573;

Fin_coh5(401) = 0.6484;
Fin_coh5(402) = 0.6164;
Fin_coh5(403) = 0.6068;
Fin_coh5(404) = 0.5746;
Fin_coh5(405) = 0.5773;
Fin_coh5(406) = 0.6509;
Fin_coh5(407) = 0.6747;
Fin_coh5(408) = 0.6282; 
Fin_coh5(409) = 0.6385; 
Fin_coh5(410) = 0.6206;

Fin_coh5(411) = 0.5941;
Fin_coh5(412) = 0.6956; 
Fin_coh5(413) = 0.6036;
Fin_coh5(414) = 0.6092;
Fin_coh5(415) = 0.6326; 
Fin_coh5(416) = 0.6794; 
Fin_coh5(417) = 0.6687;
Fin_coh5(418) = 0.6544;
Fin_coh5(419) = 0.6197; 
Fin_coh5(420) = 0.6010;

Fin_coh5(421) = 0.6452;
Fin_coh5(422) = 0.6194;
Fin_coh5(423) = 0.6013;
Fin_coh5(424) = 0.6148;
Fin_coh5(425) = 0.6999;
Fin_coh5(426) = 0.6768;
Fin_coh5(427) = 0.6272; 
Fin_coh5(428) = 0.6519; 
Fin_coh5(429) = 0.6137;
Fin_coh5(430) = 0.6819;

Fin_coh5(431) = 0; 
Fin_coh5(432) = 0.6337;
Fin_coh5(433) = 0.6111;
Fin_coh5(434) = 0.6333; 
Fin_coh5(435) = 0.6413; 
Fin_coh5(436) = 0.6450;
Fin_coh5(437) = 0.6421;
Fin_coh5(438) = 0.5702; 
Fin_coh5(439) = 0.5695;
Fin_coh5(440) = 0.5702;

Fin_coh5(441) = 0.5746; 
Fin_coh5(442) = 0.6209; 
Fin_coh5(443) = 0.6315;
Fin_coh5(444) = 0.7016;
Fin_coh5(445) = 0.6800; 
Fin_coh5(446) = 0.6146;
Fin_coh5(447) = 0.5933;
Fin_coh5(448) = 0; 
Fin_coh5(449) = 0.5779;
Fin_coh5(450) = 0.5782;

Fin_coh5(451) = 0.5985; 
Fin_coh5(452) = 0.6484;
Fin_coh5(453) = 0.6386;
Fin_coh5(454) = 0.6000; 
Fin_coh5(455) = 0.6714; 
Fin_coh5(456) = 0.5802;
Fin_coh5(457) = 0.6729;
Fin_coh5(458) = 0.5800; 
Fin_coh5(459) = 0.6253;
Fin_coh5(460) = 0.6047;

Fin_coh5(461) = 0.5800; 
Fin_coh5(462) = 0.5690; 
Fin_coh5(463) = 0.6485;
Fin_coh5(464) = 0.6501;
Fin_coh5(465) = 0.6119; 
Fin_coh5(466) = 0.6722;
Fin_coh5(467) = 0.6102;
Fin_coh5(468) = 0.6315; 
Fin_coh5(469) = 0.6222; 
Fin_coh5(470) = 0.5791;

Fin_coh5(471) = 0.6244;
Fin_coh5(472) = 0.6320; 
Fin_coh5(473) = 0.6306;
Fin_coh5(474) = 0.5986;
Fin_coh5(475) = 0.5849; 
Fin_coh5(476) = 0.6484;
Fin_coh5(477) = 0.5942;
Fin_coh5(478) = 0.6430; 
Fin_coh5(479) = 0.5040;
Fin_coh5(480) = 0.4860;

Fin_coh5(481) = 0.6664; 
Fin_coh5(482) = 0.6162; 
Fin_coh5(483) = 0.5697;
Fin_coh5(484) = 0.6663;
Fin_coh5(485) = 0.7040; 
Fin_coh5(486) = 0.5065;

% Z1Z2Z3Z6Z7
Fin_coh5(487) = 0.2863;
Fin_coh5(488) = 0.2875; 
Fin_coh5(489) = 0.2971; 
Fin_coh5(490) = 0.2897;
Fin_coh5(491) = 0.3391;
Fin_coh5(492) = 0.3748; 
Fin_coh5(493) = 0.6578;
Fin_coh5(494) = 0.6708;
Fin_coh5(495) = 0.6186; 
Fin_coh5(496) = 0.5374; 
Fin_coh5(497) = 0.3097;
Fin_coh5(498) = 0.332 ;
Fin_coh5(499) = 0.2745; 
Fin_coh5(500) = 0     ;
Fin_coh5(501) = 0.3386;
Fin_coh5(502) = 0.6561;
Fin_coh5(503) = 0.6064;
Fin_coh5(504) = 0.5997;
Fin_coh5(505) = 0.3177;
Fin_coh5(506) = 0.3329;
Fin_coh5(507) = 0.3648;
Fin_coh5(508) = 0.3138; 
Fin_coh5(509) = 0.449 ; 
Fin_coh5(510) = 0.47  ;
Fin_coh5(511) = 0.6781;
Fin_coh5(512) = 0.6420; 
Fin_coh5(513) = 0.6135;
Fin_coh5(514) = 0.3254;
Fin_coh5(515) = 0.6217; 
Fin_coh5(516) = 0.6179; 
Fin_coh5(517) = 0.5746;
Fin_coh5(518) = 0.5994;
Fin_coh5(519) = 0.6057; 
Fin_coh5(520) = 0.6375;
Fin_coh5(521) = 0.6239;
Fin_coh5(522) = 0.6200;
Fin_coh5(523) = 0.616 ;
Fin_coh5(524) = 0.6000;
Fin_coh5(525) = 0.6258;
Fin_coh5(526) = 0.6109;
Fin_coh5(527) = 0.6063; 
Fin_coh5(528) = 0.5858; 
Fin_coh5(529) = 0.6396;
Fin_coh5(530) = 0.5928;
Fin_coh5(531) = 0.5975;
Fin_coh5(532) = 0.6011;
Fin_coh5(533) = 0.606 ;
Fin_coh5(534) = 0.6437; 
Fin_coh5(535) = 0.6215; 
Fin_coh5(536) = 0.6137;
Fin_coh5(537) = 0.639 ;
Fin_coh5(538) = 0.6141; 
Fin_coh5(539) = 0.6339;
Fin_coh5(540) = 0.643 ;
Fin_coh5(541) = 0.605 ; 
Fin_coh5(542) = 0.5811; 
Fin_coh5(543) = 0.5993;
Fin_coh5(544) = 0.5859;
Fin_coh5(545) = 0.6214; 
Fin_coh5(546) = 0.6255;
Fin_coh5(547) = 0.6206;
Fin_coh5(548) = 0.5948;
Fin_coh5(549) = 0.5771;
Fin_coh5(550) = 0.636 ;
Fin_coh5(551) = 0.6247; 
Fin_coh5(552) = 0.5965;
Fin_coh5(553) = 0.6441;
Fin_coh5(554) = 0.5998; 
Fin_coh5(555) = 0.6192; 
Fin_coh5(556) = 0.5664;
Fin_coh5(557) = 0.6139;
Fin_coh5(558) = 0.6084; 
Fin_coh5(559) = 0.6305;
Fin_coh5(560) = 0.6073;
Fin_coh5(561) = 0.6369; 
Fin_coh5(562) = 0.6005; 
Fin_coh5(563) = 0.6209;
Fin_coh5(564) = 0.6104;
Fin_coh5(565) = 0.6491; 
Fin_coh5(566) = 0.6168;
Fin_coh5(567) = 0.6472;
Fin_coh5(568) = 0.6277; 
Fin_coh5(569) = 0.6088; 
Fin_coh5(570) = 0.6028;
Fin_coh5(571) = 0.6082;
Fin_coh5(572) = 0.6095; 
Fin_coh5(573) = 0.6561;
Fin_coh5(574) = 0.6489;
Fin_coh5(575) = 0.5960; 
Fin_coh5(576) = 0.6015;
Fin_coh5(577) = 0.6035;
Fin_coh5(578) = 0.591 ; 
Fin_coh5(579) = 0.6151;
Fin_coh5(580) = 0.643 ;
Fin_coh5(581) = 0.6077; 
Fin_coh5(582) = 0.6094; 
Fin_coh5(583) = 0.5905;

% Z1Z2Z3Z6Z7
Fin_coh5(584) = 0.5943;
Fin_coh5(585) = 0.5821; 
Fin_coh5(586) = 0.6276;
Fin_coh5(587) = 0.5907;
Fin_coh5(588) = 0.6010; 
Fin_coh5(589) = 0.5761; 
Fin_coh5(590) = 0.5957;
Fin_coh5(591) = 0.6193;
Fin_coh5(592) = 0.6378; 
Fin_coh5(593) = 0.6223;
Fin_coh5(594) = 0.6101;
Fin_coh5(595) = 0.6550; 
Fin_coh5(596) = 0.5863; 
Fin_coh5(597) = 0.5794;
Fin_coh5(598) = 0.6275;
Fin_coh5(599) = 0.6135;
Fin_coh5(600) = 0.6095;
Fin_coh5(601) = 0.5498;
Fin_coh5(602) = 0.6048;
Fin_coh5(603) = 0.5615;
Fin_coh5(604) = 0.5824;
Fin_coh5(605) = 0.6131;
Fin_coh5(606) = 0.6057;
Fin_coh5(607) = 0.5744;
Fin_coh5(608) = 0.6148; 
Fin_coh5(609) = 0.5819; 
Fin_coh5(610) = 0.6021;



current_length = 610;
         
for ii = 1:current_length
    Fin_coh5(ii) =  Fin_coh5(ii)/0.71/1.05;
end


jj = 1;
for ii = 1:current_length
    if Fin_coh5(ii)>0.75 && Fin_coh5(ii)<1
        Exp_coh5(jj) = Fin_coh5(ii);
        jj = jj+1;
    end
end

length(Exp_coh5)
lamda_5 = mean(Exp_coh5)
delta_5 = std(Exp_coh5)

%Pr_1 = 2*exp(-0.05^2*1600/2)