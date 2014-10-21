# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/C901234.pup"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/C901234.pup"


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

OBSERVATION C1obsch 31 65536 C1;
# 167 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/defs.h"
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




>>>
;;Declarations:stop

;;basic set-up:


1 ze




 2 30m
  d1
  1u reset:f1
  1u reset:f2
  1u reset:f3
  1m

  50u UNBLKGRAD


;;Pulses:start
<<<

;;;;;;;;;;;;;;INCLUDE THE PULSE SEQUENCE HERE;;;;;;;;;;;;
# 4 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/C901234.pup" 2

;;>$locRng = 5; $locStp = 3; $locStopOpt = 1e-8; $stopOpt = 1e-6
;;<

;>
;pulse noop @*:Z-
;pulse Ch90 0.25~C1;0.25~C2;0.25~C3;0.25~C4;0.25~C5;0.25~C6;0.25~C7 @*:X+
;;pulse C790 0.75~C7 @*:X+;C7:Z+
;;gradient grad1 0 0 37
;;pulse C12345690 0.25~C1;0.25~C2;0.25~C3;0.25~C4;0.25~C5;0.25~C6 @*:X+;C7:Z+
;;@*:X+;C7:Z+
;;zz 0.25 C1 C2
;;refocus C1180 0~C1
;;refocus C2180 0~C2
;;pulse C190 0.25~C1
;<

;;>
;;pulse noop @*:I+;C7:Z+
;;pulse C790 0.25~C7 @*:I+;C7:X+

;;zz 0.25 C6 C7
;;zz 0.25 C2 C7
;;zz 0.25 C5 C7
;;zz 0.25 C4 C7

;;refocus C5180 0~C5
;;refocus C2180 0~C2
;;refocus C6180 0~C6
;;refocus C4180 0~C4
;;refocus C5180 0~C5
;;refocus C7180 0~C7
;;refocus C2180 0~C2
;;refocus C6180 0~C6
;;refocus C5180 0~C5
;;refocus C2180 0~C2
;;refocus C5180 0~C5
;;refocus C2180 0~C2
;;refocus C6180 0~C6

;;zz 0.25 C2 C7
;;refocus C2180 0~C2
;;refocus C7180 0~C7
;;zz 0.25 C4 C7
;;refocus C4180 0~C4
;;refocus C7180 0~C7
;;zz 0.25 C5 C7
;;refocus C5180 0~C5
;;refocus C7180 0~C7
;;zz 0.25 C6 C7
;;refocus C6180 0~C6
;;refocus C7180 0~C7

;;<

;;Terminal file:
;;--------------
# 1 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/defs.t" 1
>>>
;;Pulses:stop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;New set-up
  50u BLKGRAD
  ;;go=2 ph31:r ;; commented by JZ Dec08, 10
  go=2 ph30 ph31:r ;; by JZ Dec08, 10
  100m
  wr #0
  exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ph30 = (65536) 0
<<<
# 61 "/home/dtrottie/NMR/EXPERIMENTS/svqubit_compiler/pulseprog/precompiled/C901234.pup" 2
