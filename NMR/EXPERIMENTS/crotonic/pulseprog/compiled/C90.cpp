# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/C90.pup"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/C90.pup"


# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/defs.h" 1


 #include <Avance.incl>
 #include <Grad.incl>
>>>
;;Declarations:start
<<<

Delay gon(2e-6);
Delay goff(2e-6);
Delay gwait(200e-6);
Delay grad1(0.002);
Delay grad2(0.003);
Delay grad3(0.003);
Delay grad4(0.003);
Delay grad5(0.003);

PhaseStack ps0([1...4]);
PhaseStack ps1([5...9]);
PhaseStack ps2([10...14]);
PhaseStack ps3([15...19]);
PhaseStack ps4([20...24]);
PhaseStack ps5([25...29]);







Channel Cch( 'f3', -20696, C, 0, ps2, ps3);
Channel Hch( 'f2', -3000 , H, 0, ps0, ps1);

Channel C1obsch( 'f1', -20696 , C, 0, ps4, ps5);
Channel C2obsch( 'f1', C2.frequency , C, 0, ps4, ps5);
Channel C3obsch( 'f1', C3.frequency , C, 0, ps4, ps5);
Channel C4obsch( 'f1', C4.frequency , C, 0, ps4, ps5);

Channel RCobsch( 'f1', RC.frequency, C, 0, ps4, ps5);
Channel Mobsch( 'f1', M.frequency , H, 0, ps4, ps5);
Channel H2obsch( 'f1', H2.frequency , H, 0, ps4, ps5);
Channel H1obsch( 'f1', H1.frequency , H, 0, ps4, ps5);
Channel RHobsch( 'f1', RH.frequency , H, 0, ps4, ps5);




DEFINECYCLEN 14;


PhaseCycle cyc1([0, 0, 0, 0.5, 0.5, 0.5, 0.5]);


 PhaseCycle cyc7([0.0714, 0.2143,0.3571,0.5000,0.6429, 0.7857,0.9286]);


PhaseCycle cyc7obs([0, 0, 0, 0, 0, 0, 0]);

PhaseCycle coh7([0.0000, 0.0714, 0.1429, 0.2143, 0.2857, 0.3571, 0.4286, 0.5000, 0.5714, 0.6429, 0.7143, 0.7857, 0.8571, 0.9286]);
PhaseCycle coh7obs([0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5]);

PhaseCycle coh7X2([0.0000, 0.0714, 0.1429, 0.2143, 0.2857, 0.3571, 0.4286, 0.5000, 0.5714, 0.6429, 0.7143, 0.7857, 0.8571, 0.9286, 0.0000, 0.0714, 0.1429, 0.2143, 0.2857, 0.3571, 0.4286, 0.5000, 0.5714, 0.6429, 0.7143, 0.7857, 0.8571, 0.9286]);
PhaseCycle coh7obsX2([0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5, 0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5]);

PhaseCycle depcyc([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]);







ACTIVATECHANNELS [Hch,Cch,C1obsch];
OBSERVATION C1obsch 31 65536 C5 coh7obs;
# 170 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/defs.h"
USEBASIC 'Ch90' -1 2;

USEBASIC 'C190' 1 2;
USEBASIC 'C290' 2 2;
USEBASIC 'C390' 3 2;
USEBASIC 'C490' 4 2;
USEBASIC 'C590' 5 2;
USEBASIC 'C690' 6 2;
USEBASIC 'C790' 7 2;

USEBASIC 'C1180' 11 2;
USEBASIC 'C2180' 12 2;
USEBASIC 'C3180' 13 2;
USEBASIC 'C4180' 14 2;
USEBASIC 'C5180' 15 2;
USEBASIC 'C6180' 16 2;
USEBASIC 'C7180' 17 2;


USEBASIC 'C12345690' 8 2;
USEBASIC 'C134690' 9 2;
USEBASIC 'Cencoding' 10 2;
>>>
;;Declarations:stop

;;basic set-up:



1 ze
d11 pl12:f2





 2 30m do:f2
  d11 cpd2:f2
  d1
  1u reset:f1

  1u reset:f3
  1m

  50u UNBLKGRAD


;;Pulses:start
<<<

;;;;;;;;;;;;;;INCLUDE THE PULSE SEQUENCE HERE;;;;;;;;;;;;
# 4 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/C90.pup" 2

;;>$locRng = 5; $locStp = 3; $locStopOpt = 1e-8; $stopOpt = 1e-6
;;<

;>
;pulse noop @*:Z-


;;pulse Cdecoding 0~C1;0~C2;0~C3;0~C4;0~C5;0~C6;0~C7
;;pulse Ch90 0~C1;0~C2;0~C3;0~C4;0~C5;0~C6;0~C7 @*:Z+
;;pulse Ch90 0.5~C1;0.5~C2;0.5~C3;0.5~C4;0.5~C5;0.5~C6;0.5~C7
;;pulse C134690 0~C1;0~C3;0~C4;0~C6 @*:Z+;C2:X+;C5:X+;C7:X+
# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/sv_xxxxxxx_pc.frag" 1
;pulse C12345690 0.25~C1;0.25~C2;0.25~C3;0.25~C4;0.25~C5;0.25~C6 @C1:X+;C2:X+;C3:X+;C4:X+;C5:X+;C6:X+;C7:Z+

;gradient grad1 0 0 37
;pulse C790 0.25~C7 [coh7] @C1:I+;C2:I+;C3:I+;C4:I+;C5:I+;C6:I+;C7:X+
;zz 0.25 C7 C2;C4;C6
;zz -0.25 C5 C7

;refocus C6180 0~C6 [coh7]
;refocus C4180 0~C4 [coh7]
;refocus C5180 0~C5 [coh7]
;refocus C7180 0~C7 [coh7]
;refocus C2180 0~C2 [coh7]
;refocus C4180 0~C4 [coh7]

;pulse C790 0.25~C7 [coh7] @C1:I+;C2:Z+;C3:I+;C4:Z+;C5:I+;C6:Z+;C7:Z+
;gradient grad2 0 0 45
;pulse C290 0.25~C2 [coh7] @C1:I+;C2:X+;C3:I+;C4:Z+;C5:I+;C6:Z+;C7:Z+
;zz 0.25 C2 C1;C3

;refocus C3180 0~C3 [coh7]
;refocus C2180 0~C2 [coh7]
;refocus C1180 0~C1 [coh7]

;pulse C290 0.25~C2 [coh7] @C1:Z+;C2:Z+;C3:Z+;C4:Z+;C5:Z+;C6:Z+;C7:Z+
;gradient grad3 0 0 51
;;;pulse Cencoding 0.25~C1 [coh7];0.25~C2 [coh7];0.25~C3 [coh7];0.25~C4 [coh7];0.25~C5 [coh7];0.25~C6 [coh7];0.25~C7 [coh7] @C1:X+;C2:X+;C3:X+;C4:X+;C5:X+;C6:X+;C7:X+

;;pulse Ch90 0.25~C1 [coh7];0.25~C2 [coh7];0.25~C3 [coh7];0.25~C4 [coh7];0.25~C5 [coh7];0.25~C6 [coh7];0.25~C7 [coh7] @C1:X+;C2:X+;C3:X+;C4:X+;C5:X+;C6:X+;C7:X+
# 17 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/C90.pup" 2
;<

;>
;;pulse C134690 0~C1;0~C3;0~C4;0~C6 @C1:Z+;C3:Z+;C4:Z+;C6:Z+;C2:X+;C5:X+;C7:X+



;pulse noop @C1:Z-;C3:Z-;C4:Z-;C6:Z-;C2:Z-;C5:Z-;C7:Z-
;;pulse C134690 0.75~C1;0.75~C3;0.75~C4;0.75~C6 @C1:Z-;C3:Z-;C4:Z-;C6:Z-;C2:Z-;C5:Z-;C7:Z-
;;zz 0.25 C2 C1
;;zz 0.25 C2 C3
;;zz 0.25 C5 C6
;;zz 0.25 C5 C4
;;refocus C1180 0~C1
;;refocus C3180 0~C3
;;refocus C2180 0~C2
;;refocus C6180 0~C6
;;refocus C5180 0~C5
;;refocus C4180 0~C4
;;refocus C3180 0
;;refocus C2180 0
;;refocus C1180 0
;;refocus C6180 0
;;pulse C134690 0~C1;0~C3;0~C4;0~C6 @C1:Z+;C3:Z+;C4:Z+;C6:Z+

;pulse C190 0.75~C1 @C1:Z-;C3:Z-;C4:Z-;C6:Z-;C2:Z-;C5:Z-;C7:Z-
;pulse C390 0.75~C3 @C1:X-;C3:Z-;C4:Z-;C6:Z-;C2:Z-;C5:Z-;C7:Z-
;zz 0.25 C2 C1
;zz 0.25 C2 C3
;refocus C3180 0~C3
;refocus C2180 0~C2
;refocus C1180 0~C1
;pulse noop @C1:X-;C3:X-;C4:Z-;C6:Z-;C2:Z-;C5:Z-;C7:Z-
;pulse C190 0~C1 @C1:0+;C3:X-;C4:Z+;C6:Z+;C2:Z+;C5:Z+;C7:Z+
;pulse C390 0~C3 @C1:0+;C3:0+;C4:Z+;C6:Z+;C2:Z+;C5:Z+;C7:Z+

;pulse C490 0.75~C4 @C1:0-;C3:0-;C4:Z-;C6:Z-;C2:Z-;C5:Z-;C7:Z-
;pulse C690 0.75~C6 @C1:0-;C3:0-;C4:X-;C6:Z-;C2:Z-;C5:Z-;C7:Z-
;zz 0.25 C5 C4
;zz 0.25 C5 C6
;refocus C4180 0~C4
;refocus C5180 0~C5
;refocus C6180 0~C6
;pulse noop @C1:0-;C3:0-;C4:X-;C6:X-;C2:Z-;C5:Z-;C7:Z-
;pulse C490 0~C4 @C1:0+;C3:0+;C4:0+;C6:X-;C2:Z+;C5:Z+;C7:Z+
;;pulse C690 0~C6 @C1:0+;C3:0+;C4:Z+;C6:Z+;C2:Z+;C5:Z+;C7:Z+

;<




;;Terminal file:
;;--------------
# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/defs.t" 1
>>>
(p25:sp25 ph25 2u):f3

;;Pulses:stop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;New set-up
  ;50u BLKGRAD
  ;;go=2 ph31:r ;; commented by JZ Dec08, 10
  go=2 ph30 ph31:r ;; by JZ Dec08, 10

30m do:f2
wr #0
  exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ph30 = (65536) 0
   ph25 = 0
<<<
# 71 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/C90.pup" 2
