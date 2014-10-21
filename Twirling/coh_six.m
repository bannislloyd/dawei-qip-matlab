clear;

%% Initial State
Ini_coh2(1) = 1.0070; %Z1Z2
Ini_coh2(2) = 1.0387; %Z6

Ini_coh2(3) = 0.9632; %Z5
Ini_coh2(4) = 0.9927; %Z4
Ini_coh2(5) = 1.0522; %Z3


Ini_coh2 = Ini_coh2/max(Ini_coh2);
mean(Ini_coh2)
std(Ini_coh2)
%% Final State
Decoherence = 0.586;

% Z1Z2Z3Z4Z7
Fin_coh6(1) = 0.5704; 
Fin_coh6(2) = 0.5713;
Fin_coh6(3) = 0;
Fin_coh6(4) = 0.5702; 
Fin_coh6(5) = 0.5924;
Fin_coh6(6) = 0;
Fin_coh6(7) = 0.5853; 
Fin_coh6(8) = 0.6031; 
Fin_coh6(9) = 0.6155;
Fin_coh6(10) = 0;
Fin_coh6(11) = 0.5697; 
Fin_coh6(12) = 0.5720;
Fin_coh6(13) = 0;

Fin_coh6(14) = 0; 
Fin_coh6(15) = 0.6546; 
Fin_coh6(16) = 0;
Fin_coh6(17) = 0.6093;
Fin_coh6(18) = 0; 
Fin_coh6(19) = 0.5844;
Fin_coh6(20) = 0.6464;
Fin_coh6(21) = 0.6284; 
Fin_coh6(22) = 0.5696; 
Fin_coh6(23) = 0.6692;

Fin_coh6(24) = 0.6343;
Fin_coh6(25) = 0.6111; 
Fin_coh6(26) = 0.6632;
Fin_coh6(27) = 0.6003;
Fin_coh6(28) = 0.5871; 
Fin_coh6(29) = 0.5882;
Fin_coh6(30) = 0;
Fin_coh6(31) = 0.5826; 
Fin_coh6(32) = 0.6119;
Fin_coh6(33) = 0;

Fin_coh6(34) = 0.5768; 
Fin_coh6(35) = 0.5764; 
Fin_coh6(36) = 0.5695;
Fin_coh6(37) = 0;
Fin_coh6(38) = 0; 
Fin_coh6(39) = 0.5862;
Fin_coh6(40) = 0;
Fin_coh6(41) = 0; 
Fin_coh6(42) = 0.6119; 
Fin_coh6(43) = 0;

Fin_coh6(44) = 0;
Fin_coh6(45) = 0.6111; 
Fin_coh6(46) = 0.6164;
Fin_coh6(47) = 0.6323;
Fin_coh6(48) = 0.5878; 
Fin_coh6(49) = 0.5682; 
Fin_coh6(50) = 0.6430;
Fin_coh6(51) = 0.6226;
Fin_coh6(52) = 0.6830; 
Fin_coh6(53) = 0.6430;

Fin_coh6(54) = 0.5745;
Fin_coh6(55) = 0.6084; 
Fin_coh6(56) = 0.5830;
Fin_coh6(57) = 0.6045;
Fin_coh6(58) = 0.6270; 
Fin_coh6(59) = 0.5770;
Fin_coh6(60) = 0.6026;
Fin_coh6(61) = 0.5746; 
Fin_coh6(62) = 0.6408; 
Fin_coh6(63) = 0.6194;

Fin_coh6(64) = 0;
Fin_coh6(65) = 0.6234; 
Fin_coh6(66) = 0.5696;
Fin_coh6(67) = 0;
Fin_coh6(68) = 0.5976; 
Fin_coh6(69) = 0.5770; 
Fin_coh6(70) = 0;
Fin_coh6(71) = 0.5988;
Fin_coh6(72) = 0.5878; 
Fin_coh6(73) = 0.6057;

Fin_coh6(74) = 0.6560;
Fin_coh6(75) = 0.6317; 
Fin_coh6(76) = 0.6235; 
Fin_coh6(77) = 0.6099;
Fin_coh6(78) = 0.5830;
Fin_coh6(79) = 0.6208; 
Fin_coh6(80) = 0.6377;
Fin_coh6(81) = 0.6244;
Fin_coh6(82) = 0.6173;
Fin_coh6(83) = 0;

Fin_coh6(84) = 0; 
Fin_coh6(85) = 0.6308;
Fin_coh6(86) = 0;
Fin_coh6(87) = 0.6482; 
Fin_coh6(88) = 0.5876; 
Fin_coh6(89) = 0.6173;
Fin_coh6(90) = 0;
Fin_coh6(91) = 0; 
Fin_coh6(92) = 0.6244;
Fin_coh6(93) = 0.5968;

Fin_coh6(94) = 0; 
Fin_coh6(95) = 0.6185; 
Fin_coh6(96) = 0;
Fin_coh6(97) = 0.6395;
Fin_coh6(98) = 0.6421; 
Fin_coh6(99) = 0.6223;
Fin_coh6(100) = 0.5683;
Fin_coh6(101) = 0.5702; 
Fin_coh6(102) = 0.5905; 
Fin_coh6(103) = 0.6324;

Fin_coh6(104) = 0.5848;
Fin_coh6(105) = 0.5945; 
Fin_coh6(106) = 0.6350;
Fin_coh6(107) = 0.5694;
Fin_coh6(108) = 0; 
Fin_coh6(109) = 0.5746;
Fin_coh6(110) = 0.5924;
Fin_coh6(111) = 0; 
Fin_coh6(112) = 0.6155;
Fin_coh6(113) = 0.6421;

Fin_coh6(114) = 0.6329; 
Fin_coh6(115) = 0.5960; 
Fin_coh6(116) = 0.6128;
Fin_coh6(117) = 0;
Fin_coh6(118) = 0; 
Fin_coh6(119) = 0.6448;
Fin_coh6(120) = 0.5729;
Fin_coh6(121) = 0; 
Fin_coh6(122) = 0.5702; 
Fin_coh6(123) = 0.5691;

Fin_coh6(124) = 0.6555;
Fin_coh6(125) = 0.6315; 
Fin_coh6(126) = 0.6155;
Fin_coh6(127) = 0.5977;
Fin_coh6(128) = 0.6285; 
Fin_coh6(129) = 0.5908; 
Fin_coh6(130) = 0.5906;
Fin_coh6(131) = 0.6633;
Fin_coh6(132) = 0.6346; 
Fin_coh6(133) = 0.6395;

Fin_coh6(134) = 0.6554;
Fin_coh6(135) = 0.5737; 
Fin_coh6(136) = 0;
Fin_coh6(137) = 0.5729;
Fin_coh6(138) = 0.5702; 
Fin_coh6(139) = 0;
Fin_coh6(140) = 0.5702;
Fin_coh6(141) = 0.5702; 
Fin_coh6(142) = 0; 
Fin_coh6(143) = 0.6048;

Fin_coh6(144) = 0.6413;
Fin_coh6(145) = 0; 
Fin_coh6(146) = 0.5933;
Fin_coh6(147) = 0.6670;
Fin_coh6(148) = 0; 
Fin_coh6(149) = 0.6279; 
Fin_coh6(150) = 0.6839;
Fin_coh6(151) = 0.5704;
Fin_coh6(152) = 0.6501; 
Fin_coh6(153) = 0.5809;

Fin_coh6(154) = 0.5922;
Fin_coh6(155) = 0.5938; 
Fin_coh6(156) = 0.5688; 
Fin_coh6(157) = 0.6301;
Fin_coh6(158) = 0.6003;
Fin_coh6(159) = 0.5745; 
Fin_coh6(160) = 0;
Fin_coh6(161) = 0.6521;
Fin_coh6(162) = 0.5804;
Fin_coh6(163) = 0.6341;

Fin_coh6(164) = 0.5986; 
Fin_coh6(165) = 0.6175;
Fin_coh6(166) = 0.6270;
Fin_coh6(167) = 0.5683; 
Fin_coh6(168) = 0.5862; 
Fin_coh6(169) = 0.6943;
Fin_coh6(170) = 0;
Fin_coh6(171) = 0.5941; 
Fin_coh6(172) = 0;
Fin_coh6(173) = 0.5759;

Fin_coh6(174) = 0.5940; 
Fin_coh6(175) = 0; 
Fin_coh6(176) = 0.5731;
Fin_coh6(177) = 0.6415;
Fin_coh6(178) = 0; 
Fin_coh6(179) = 0.5959;
Fin_coh6(180) = 0.5735;
Fin_coh6(181) = 0.6377; 
Fin_coh6(182) = 0.6345; 
Fin_coh6(183) = 0.6048;

Fin_coh6(184) = 0.6430;
Fin_coh6(185) = 0.6074; 
Fin_coh6(186) = 0.5717;
Fin_coh6(187) = 0.6777;
Fin_coh6(188) = 0.6181; 
Fin_coh6(189) = 0.5680;
Fin_coh6(190) = 0.6359;
Fin_coh6(191) = 0.5813; 
Fin_coh6(192) = 0.5930;
Fin_coh6(193) = 0.6004;

Fin_coh6(194) = 0.5871; 
Fin_coh6(195) = 0.5690; 
Fin_coh6(196) = 0.6617;
Fin_coh6(197) = 0.5900;
Fin_coh6(198) = 0.6118; 
Fin_coh6(199) = 0.6066;
Fin_coh6(200) = 0.5874;
Fin_coh6(201) = 0.5988; 
Fin_coh6(202) = 0; 
Fin_coh6(203) = 0.5711;

Fin_coh6(204) = 0.6269;
Fin_coh6(205) = 0; 
Fin_coh6(206) = 0.5887;
Fin_coh6(207) = 0.5754;
Fin_coh6(208) = 0.5729; 
Fin_coh6(209) = 0.6595; 
Fin_coh6(210) = 0.5903;
Fin_coh6(211) = 0.6537;
Fin_coh6(212) = 0.6032; 
Fin_coh6(213) = 0.5828;

Fin_coh6(214) = 0.6883;
Fin_coh6(215) = 0.6247; 
Fin_coh6(216) = 0.5928;
Fin_coh6(217) = 0.5780;
Fin_coh6(218) = 0; 
Fin_coh6(219) = 0.5977;
Fin_coh6(220) = 0.5780;
Fin_coh6(221) = 0.6164; 
Fin_coh6(222) = 0; 
Fin_coh6(223) = 0.6128;

Fin_coh6(224) = 0.6075;
Fin_coh6(225) = 0; 
Fin_coh6(226) = 0.5871;
Fin_coh6(227) = 0;
Fin_coh6(228) = 0.5791; 
Fin_coh6(229) = 0; 
Fin_coh6(230) = 0.6235;
Fin_coh6(231) = 0.6626;
Fin_coh6(232) = 0.6333; 
Fin_coh6(233) = 0.6017;

Fin_coh6(234) = 0.5704;
Fin_coh6(235) = 0.6528; 
Fin_coh6(236) = 0.6108; 
Fin_coh6(237) = 0.5887;
Fin_coh6(238) = 0.6528;
Fin_coh6(239) = 0.6660; 
Fin_coh6(240) = 0.6058;
Fin_coh6(241) = 0.6395;
Fin_coh6(242) = 0.6816;
Fin_coh6(243) = 0.6159;
 
Fin_coh6(244) = 0.5738; 
Fin_coh6(245) = 0.6004;
Fin_coh6(246) = 0.6137;
Fin_coh6(247) = 0.5915; 
Fin_coh6(248) = 0.6244; 
Fin_coh6(249) = 0.5800;
Fin_coh6(250) = 0.5693;

Fin_coh6(251) = 0.6013; 
Fin_coh6(252) = 0.6155;
Fin_coh6(253) = 0.6343;
Fin_coh6(254) = 0.5688; 
Fin_coh6(255) = 0.5693; 
Fin_coh6(256) = 0;
Fin_coh6(257) = 0.6279;
Fin_coh6(258) = 0.6519; 
Fin_coh6(259) = 0.6222;
Fin_coh6(260) = 0.5800;

Fin_coh6(261) = 0.5836; 
Fin_coh6(262) = 0.5960; 
Fin_coh6(263) = 0.6598;
Fin_coh6(264) = 0.5922;
Fin_coh6(265) = 0; 
Fin_coh6(266) = 0.6788;
Fin_coh6(267) = 0.6423;
Fin_coh6(268) = 0.6022; 
Fin_coh6(269) = 0.6856;
Fin_coh6(270) = 0.6086;

Fin_coh6(271) = 0.6436; 
Fin_coh6(272) = 0;
Fin_coh6(273) = 0;
Fin_coh6(274) = 0; 
Fin_coh6(275) = 0.6865; 
Fin_coh6(276) = 0.5720;
Fin_coh6(277) = 0.6146;
Fin_coh6(278) = 0.6418; 
Fin_coh6(279) = 0.5751;
Fin_coh6(280) = 0;

Fin_coh6(281) = 0.5924; 
Fin_coh6(282) = 0.6004; 
Fin_coh6(283) = 0;
Fin_coh6(284) = 0.6741;
Fin_coh6(285) = 0.6279; 
Fin_coh6(286) = 0.5951;
Fin_coh6(287) = 0.6541;
Fin_coh6(288) = 0.5837; 
Fin_coh6(289) = 0.5684; 
Fin_coh6(290) = 0.6495;

Fin_coh6(291) = 0.5919;
Fin_coh6(292) = 0.5720; 
Fin_coh6(293) = 0.6502;
Fin_coh6(294) = 0.6326;
Fin_coh6(295) = 0.6759; 
Fin_coh6(296) = 0.6998;
Fin_coh6(297) = 0.5934;
Fin_coh6(298) = 0.5684; 
Fin_coh6(299) = 0.5953;
Fin_coh6(300) = 0.5928;

Fin_coh6(301) = 0.6439; 
Fin_coh6(302) = 0.6165; 
Fin_coh6(303) = 0.6323;
Fin_coh6(304) = 0.6722;
Fin_coh6(305) = 0.6456; 
Fin_coh6(306) = 0.6304;
Fin_coh6(307) = 0.5964;
Fin_coh6(308) = 0.6456; 
Fin_coh6(309) = 0.5745; 
Fin_coh6(310) = 0.6648;

Fin_coh6(311) = 0.6058;
Fin_coh6(312) = 0.5698; 
Fin_coh6(313) = 0.6802;
Fin_coh6(314) = 0.5827;
Fin_coh6(315) = 0.5931; 
Fin_coh6(316) = 0.6510; 
Fin_coh6(317) = 0.6529;
Fin_coh6(318) = 0.6371;
Fin_coh6(319) = 0.5719; 
Fin_coh6(320) = 0.6149;

Fin_coh6(321) = 0.5890;
Fin_coh6(322) = 0.6574;
Fin_coh6(323) = 0.6529;
Fin_coh6(324) = 0.6576;
Fin_coh6(325) = 0.5423;
Fin_coh6(326) = 0.6555;
Fin_coh6(327) = 0.5871; 
Fin_coh6(328) = 0.5442; 
Fin_coh6(329) = 0.6794;
Fin_coh6(330) = 0.5817;

Fin_coh6(331) = 0.5813; 
Fin_coh6(332) = 0.6590;
Fin_coh6(333) = 0.6137;
Fin_coh6(334) = 0.5902; 
Fin_coh6(335) = 0.7043; 
Fin_coh6(336) = 0;
Fin_coh6(337) = 0.5947;
Fin_coh6(338) = 0.7096; 
Fin_coh6(339) = 0.5694;
Fin_coh6(340) = 0.5861;

Fin_coh6(341) = 0.6288; 
Fin_coh6(342) = 0.6599; 
Fin_coh6(343) = 0.5961;
Fin_coh6(344) = 0.5896;
Fin_coh6(345) = 0.6187; 
Fin_coh6(346) = 0.5855;
Fin_coh6(347) = 0.6484;
Fin_coh6(348) = 0.5938; 
Fin_coh6(349) = 0.6089;
Fin_coh6(350) = 0.6329;

Fin_coh6(351) = 0.6273; 
Fin_coh6(352) = 0.6207;
Fin_coh6(353) = 0.5686;
Fin_coh6(354) = 0; 
Fin_coh6(355) = 0.6166; 
Fin_coh6(356) = 0.5809;
Fin_coh6(357) = 0;
Fin_coh6(358) = 0.6953; 
Fin_coh6(359) = 0.6146;
Fin_coh6(360) = 0.5791;

Fin_coh6(361) = 0.6411; 
Fin_coh6(362) = 0.5746; 
Fin_coh6(363) = 0.5951;
Fin_coh6(364) = 0.6518;
Fin_coh6(365) = 0.6031; 
Fin_coh6(366) = 0.5735;
Fin_coh6(367) = 0.6653;
Fin_coh6(368) = 0.6528; 
Fin_coh6(369) = 0.5692; 
Fin_coh6(370) = 0.6892;

Fin_coh6(371) = 0.6134;
Fin_coh6(372) = 0.5733; 
Fin_coh6(373) = 0.6421;
Fin_coh6(374) = 0.6342;
Fin_coh6(375) = 0.6173; 
Fin_coh6(376) = 0.5924;
Fin_coh6(377) = 0.6247;
Fin_coh6(378) = 0.5793; 
Fin_coh6(379) = 0;
Fin_coh6(380) = 0.6386;

Fin_coh6(381) = 0.6364; 
Fin_coh6(382) = 0.6402; 
Fin_coh6(383) = 0.6042;
Fin_coh6(384) = 0.6020;
Fin_coh6(385) = 0.6204; 
Fin_coh6(386) = 0.6232;
Fin_coh6(387) = 0.6055;
Fin_coh6(388) = 0.5506; 
Fin_coh6(389) = 0.5977; 
Fin_coh6(390) = 0.6581;

Fin_coh6(391) = 0.6284;
Fin_coh6(392) = 0.6199; 
Fin_coh6(393) = 0.6868;
Fin_coh6(394) = 0.6314;
Fin_coh6(395) = 0.6134; 
Fin_coh6(396) = 0.6156; 
Fin_coh6(397) = 0.5969;
Fin_coh6(398) = 0.5840;
Fin_coh6(399) = 0.5702; 
Fin_coh6(400) = 0.6750;

Fin_coh6(401) = 0.6062;
Fin_coh6(402) = 0.5821;
Fin_coh6(403) = 0.6068;
Fin_coh6(404) = 0.5799;
Fin_coh6(405) = 0.5816;
Fin_coh6(406) = 0.5702;
Fin_coh6(407) = 0.6747;
Fin_coh6(408) = 0.6282; 
Fin_coh6(409) = 0.5968; 
Fin_coh6(410) = 0.5789;

Fin_coh6(411) = 0.5941;
Fin_coh6(412) = 0.6519; 
Fin_coh6(413) = 0.6036;
Fin_coh6(414) = 0.6083;
Fin_coh6(415) = 0.6326; 
Fin_coh6(416) = 0.6794; 
Fin_coh6(417) = 0.6687;
Fin_coh6(418) = 0.6544;
Fin_coh6(419) = 0.6197; 
Fin_coh6(420) = 0.6010;

Fin_coh6(421) = 0.6452;
Fin_coh6(422) = 0.6194;
Fin_coh6(423) = 0.6013;
Fin_coh6(424) = 0.6148;
Fin_coh6(425) = 0.6445;
Fin_coh6(426) = 0.6282;
Fin_coh6(427) = 0.6272; 
Fin_coh6(428) = 0.6168; 
Fin_coh6(429) = 0.5682;
Fin_coh6(430) = 0.6510;

Fin_coh6(431) = 0.6307; 
Fin_coh6(432) = 0.5881;
Fin_coh6(433) = 0.5853;
Fin_coh6(434) = 0.6333; 
Fin_coh6(435) = 0.6413; 
Fin_coh6(436) = 0.6450;
Fin_coh6(437) = 0.6421;
Fin_coh6(438) = 0.5702; 
Fin_coh6(439) = 0.5695;
Fin_coh6(440) = 0.5702;

Fin_coh6(441) = 0.5946; 
Fin_coh6(442) = 0.6209; 
Fin_coh6(443) = 0.6315;
Fin_coh6(444) = 0;
Fin_coh6(445) = 0.6600; 
Fin_coh6(446) = 0.6146;
Fin_coh6(447) = 0.5933;
Fin_coh6(448) = 0; 
Fin_coh6(449) = 0.5779;
Fin_coh6(450) = 0.5782;

Fin_coh6(451) = 0.6315; 
Fin_coh6(452) = 0.6554;
Fin_coh6(453) = 0.6171;
Fin_coh6(454) = 0.5693; 
Fin_coh6(455) = 0.6099; 
Fin_coh6(456) = 0.5710;
Fin_coh6(457) = 0.6057;
Fin_coh6(458) = 0.6573; 
Fin_coh6(459) = 0.6045;
Fin_coh6(460) = 0.6047;

Fin_coh6(461) = 0.5800; 
Fin_coh6(462) = 0.5690; 
Fin_coh6(463) = 0.6485;
Fin_coh6(464) = 0.6501;
Fin_coh6(465) = 0.6119; 
Fin_coh6(466) = 0.6722;
Fin_coh6(467) = 0.6102;
Fin_coh6(468) = 0.6315; 
Fin_coh6(469) = 0.6222; 
Fin_coh6(470) = 0.5791;

Fin_coh6(471) = 0.6244;
Fin_coh6(472) = 0.6320; 
Fin_coh6(473) = 0.6306;
Fin_coh6(474) = 0.5986;
Fin_coh6(475) = 0.5849; 
Fin_coh6(476) = 0.6484;
Fin_coh6(477) = 0.5942;
Fin_coh6(478) = 0.6430; 
Fin_coh6(479) = 0.6220;
Fin_coh6(480) = 0.5979;

Fin_coh6(481) = 0.6350; 
Fin_coh6(482) = 0.6781; 
Fin_coh6(483) = 0.6096;
Fin_coh6(484) = 0.5933;
Fin_coh6(485) = 0.6070; 
Fin_coh6(486) = 0.5922;
Fin_coh6(487) = 0.5951;
Fin_coh6(488) = 0.6089; 
Fin_coh6(489) = 0.5697; 
Fin_coh6(490) = 0.6190;

Fin_coh6(491) = 0.5789;
Fin_coh6(492) = 0.5938; 
Fin_coh6(493) = 0.5684;
Fin_coh6(494) = 0.6213;
Fin_coh6(495) = 0.5874; 
Fin_coh6(496) = 0.5374; 
Fin_coh6(497) = 0.6213;
Fin_coh6(498) = 0.5820 ;
Fin_coh6(499) = 0.6571; 
Fin_coh6(500) = 0.6429;

Fin_coh6(501) = 0.5847;
Fin_coh6(502) = 0.6561;
Fin_coh6(503) = 0.6064;
Fin_coh6(504) = 0.5997;
Fin_coh6(505) = 0.6333;
Fin_coh6(506) = 0.6566;
Fin_coh6(507) = 0.6336;
Fin_coh6(508) = 0.6359; 
Fin_coh6(509) = 0.6099; 
Fin_coh6(510) = 0.5874;

Fin_coh6(511) = 0.5880;
Fin_coh6(512) = 0.6336; 
Fin_coh6(513) = 0.6232;
Fin_coh6(514) = 0.5764;
Fin_coh6(515) = 0.6070; 
Fin_coh6(516) = 0.5735; 
Fin_coh6(517) = 0.6608;
Fin_coh6(518) = 0.5957;
Fin_coh6(519) = 0.6039; 
Fin_coh6(520) = 0.6057;

Fin_coh6(521) = 0.6516;
Fin_coh6(522) = 0.5849;
Fin_coh6(523) = 0.6160;
Fin_coh6(524) = 0.6000;
Fin_coh6(525) = 0.5694;
Fin_coh6(526) = 0.6109;
Fin_coh6(527) = 0.6063; 
Fin_coh6(528) = 0.5844; 
Fin_coh6(529) = 0.6396;
Fin_coh6(530) = 0.5928;

Fin_coh6(531) = 0.5979;
Fin_coh6(532) = 0.6022;
Fin_coh6(533) = 0.6639;
Fin_coh6(534) = 0.6456; 
Fin_coh6(535) = 0.6617; 
Fin_coh6(536) = 0.5846;
Fin_coh6(537) = 0.5878;
Fin_coh6(538) = 0.5853; 
Fin_coh6(539) = 0.6450;
Fin_coh6(540) = 0.6295;

Fin_coh6(541) = 0.6050; 
Fin_coh6(542) = 0.6466; 
Fin_coh6(543) = 0.5690;
Fin_coh6(544) = 0.5906;
Fin_coh6(545) = 0.6128; 
Fin_coh6(546) = 0.6255;
Fin_coh6(547) = 0.6206;
Fin_coh6(548) = 0.6466;
Fin_coh6(549) = 0.5915;
Fin_coh6(550) = 0;

Fin_coh6(551) = 0.6247; 
Fin_coh6(552) = 0.6128;
Fin_coh6(553) = 0.6441;
Fin_coh6(554) = 0.5998; 
Fin_coh6(555) = 0.6192; 
Fin_coh6(556) = 0.5664;
Fin_coh6(557) = 0.6139;
Fin_coh6(558) = 0.6084; 
Fin_coh6(559) = 0.6874;
Fin_coh6(560) = 0.6329;

Fin_coh6(561) = 0.5890; 
Fin_coh6(562) = 0.6297; 
Fin_coh6(563) = 0.6522;
Fin_coh6(564) = 0.6459;
Fin_coh6(565) = 0.6812; 
Fin_coh6(566) = 0.5720;
Fin_coh6(567) = 0.6187;
Fin_coh6(568) = 0.6277; 
Fin_coh6(569) = 0.5889; 
Fin_coh6(570) = 0.5844;

Fin_coh6(571) = 0.6082;
Fin_coh6(572) = 0.5817; 
Fin_coh6(573) = 0.6217;
Fin_coh6(574) = 0.5705;
Fin_coh6(575) = 0.5720; 
Fin_coh6(576) = 0.6039;
Fin_coh6(577) = 0.5835;
Fin_coh6(578) = 0.5916; 
Fin_coh6(579) = 0.6839;
Fin_coh6(580) = 0.6432;

Fin_coh6(581) = 0.6182; 
Fin_coh6(582) = 0.6830; 
Fin_coh6(583) = 0.6803;
Fin_coh6(584) = 0.5943;
Fin_coh6(585) = 0.5821; 
Fin_coh6(586) = 0.6187;
Fin_coh6(587) = 0.5912;
Fin_coh6(588) = 0.5898; 
Fin_coh6(589) = 0.5758; 
Fin_coh6(590) = 0.6200;




current_length = 590;
         
for ii = 1:current_length
    Fin_coh6(ii) =  Fin_coh6(ii)/0.71/1.05;
end


jj = 1;
for ii = 1:current_length
    if Fin_coh6(ii)>0.75 && Fin_coh6(ii)<1
        Exp_coh6(jj) = Fin_coh6(ii);
        jj = jj+1;
    end
end

length(Exp_coh6)
lamda_6 = mean(Exp_coh6)
delta_6 = std(Exp_coh6)

%Pr_1 = 2*exp(-0.05^2*1600/2)