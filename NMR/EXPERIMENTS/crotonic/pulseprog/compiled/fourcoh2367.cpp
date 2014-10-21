# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_test/pulseprog/precompiled/fourcoh2367.pup"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_test/pulseprog/precompiled/fourcoh2367.pup"


# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_test/pulseprog/precompiled/defs.h" 1


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

DEFINECYCLEN 1;





PhaseCycle cyc1([0, 0, 0, 0.5, 0.5, 0.5, 0.5]);


 PhaseCycle cyc7([0.0714, 0.2143,0.3571,0.5000,0.6429, 0.7857,0.9286]);


PhaseCycle cyc7obs([0, 0, 0, 0, 0, 0, 0]);

PhaseCycle coh7([0.0000, 0.0714, 0.1429, 0.2143, 0.2857, 0.3571, 0.4286, 0.5000, 0.5714, 0.6429, 0.7143, 0.7857, 0.8571, 0.9286]);
PhaseCycle coh7obs([0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5]);

PhaseCycle coh7X2([0.0000, 0.0714, 0.1429, 0.2143, 0.2857, 0.3571, 0.4286, 0.5000, 0.5714, 0.6429, 0.7143, 0.7857, 0.8571, 0.9286, 0.0000, 0.0714, 0.1429, 0.2143, 0.2857, 0.3571, 0.4286, 0.5000, 0.5714, 0.6429, 0.7143, 0.7857, 0.8571, 0.9286]);
PhaseCycle coh7obsX2([0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5, 0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5]);

PhaseCycle depcyc([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]);







ACTIVATECHANNELS [Hch,Cch,C1obsch];

OBSERVATION C1obsch 31 65536 C5;
# 174 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_test/pulseprog/precompiled/defs.h"
USEBASIC 'C190_pre' 1 2;
USEBASIC 'C290_pre' 2 2;
USEBASIC 'C390_pre' 3 2;
USEBASIC 'C490_pre' 4 2;
USEBASIC 'C590_pre' 5 2;
USEBASIC 'C690_pre' 6 2;
USEBASIC 'C790_pre' 7 2;

USEBASIC 'C190_post' 11 2;
USEBASIC 'C290_post' 12 2;
USEBASIC 'C390_post' 13 2;
USEBASIC 'C490_post' 14 2;
USEBASIC 'C590_post' 15 2;
USEBASIC 'C690_post' 16 2;
USEBASIC 'C790_post' 17 2;

USEBASIC 'C1180' 21 2;
USEBASIC 'C2180' 22 2;
USEBASIC 'C3180' 23 2;
USEBASIC 'C4180' 24 2;
USEBASIC 'C5180' 25 2;
USEBASIC 'C6180' 26 2;
USEBASIC 'C7180' 27 2;



USEBASIC 'C13456790' 30 2;





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
# 4 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_test/pulseprog/precompiled/fourcoh2367.pup" 2

;>
;pulse noop @*:Z-
;pulse C13456790 0~C1;0~C3;0~C4;0~C5;0~C6;0~C7 @*:Z-
;gradient grad1 0 0 23

;pulse C290_pre 0.25~C2 @C1:I-;C2:Z-;C3:I-;C4:I-;C5:I-;C6:I-;C7:I-
;zz 0.25 C3;C7 C2
;refocus C3180 0~C3
;refocus C2180 0~C2
;refocus C7180 0~C7

;pulse C290_post 0.25~C2 @C1:I-;C2:Z+;C3:Z-;C4:I-;C5:I-;C6:I-;C7:Z-
;gradient grad2 0 0 37
;pulse C790_pre 0.25~C7 @C1:I-;C2:Z-;C3:Z-;C4:I-;C5:I-;C6:I-;C7:Z-

;zz 0.25 C6 C7
;refocus C6180 0~C6
;refocus C7180 0~C7

;pulse C790_post 0~C7 @C1:I-;C2:Z-;C3:Z-;C4:I-;C5:I-;C6:Z-;C7:Z+
;gradient grad3 0 0 51
;<



;;Terminal file:
;;--------------
# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_test/pulseprog/precompiled/defs.t" 1
>>>
;if (l1==1)
;{
;(p21:sp28 ph0):f3
;}
;else
;{
;}
;(4u p20:sp20 ph0 4u):f3
;if (l2==1)
;{
;(p21:sp29 ph0):f3
;}
;else
;{
;}
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
ph0=0
ph1=1
<<<
# 32 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_test/pulseprog/precompiled/fourcoh2367.pup" 2
