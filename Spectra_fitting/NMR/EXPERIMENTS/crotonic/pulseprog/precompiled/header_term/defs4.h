#define depolarize
#define DEFER(x) x
 DEFER(#include <Avance.incl>)
 DEFER(#include <Grad.incl>)
>>>
;;Declarations:start
<<<

Delay      gon(1e-6);
Delay      goff(1e-6);
Delay      gwait(1e-6);
Delay      grad1(0.002);
PhaseStack ps0([1...5]);
PhaseStack ps1([6...10]);
PhaseStack ps2([11...15]);
PhaseStack ps3([16...19]);
PhaseStack ps4([20...23]);
PhaseStack ps5([24...27]);

Channel Hch(  'f2', M.frequency  , H, 1, ps0, ps3);
Channel Cch(  'f3', C1.frequency , C, 1, ps1, ps4);
Channel C1obsch(  'f1', C1.frequency , C, 0, ps1, ps1); 
Channel C3obsch(  'f1', C3.frequency , C, 0, ps1, ps1); 
Channel H2obsch(  'f1', H2.frequency , H, 0, ps0, ps3); 
Channel H1obsch(  'f1', H1.frequency , H, 0, ps0, ps3); 

DEFINECYCLEN 1; 
PhaseCycle cyc1([0,0.25,0.5,1  ]); 
PhaseCycle cyc2([0,0.5 ,0  ,0.5]); 




#if defined(C1obs)
ACTIVATECHANNELS [Hch,Cch,C1obsch];
OBSERVATION       C1obsch 31 65536 C1;
#elif defined(C3obs)
ACTIVATECHANNELS [Hch,Cch,C3obsch];
OBSERVATION       C3obsch 31 65536 C3;
#elif defined(H2obs)
ACTIVATECHANNELS [Hch,Cch,H2obsch];
OBSERVATION       H2obsch 31 65536 H2;
#elif defined(H1obs)
ACTIVATECHANNELS [Hch,Cch,H1obsch];
OBSERVATION       H1obsch 31 65536 H1;
#else
ACTIVATECHANNELS [Hch,Cch,C1obsch];
OBSERVATION       C1obsch 31 65536 C1;
#endif


//90s
USEBASIC 'Hh90'  -1 1;
USEBASIC 'M90'    1 1;
USEBASIC 'H190'   2 1;
USEBASIC 'H290'   3 1;

USEBASIC 'Ch90'  -1 2;
USEBASIC 'C190'   4 2;
USEBASIC 'C290'   5 2;
USEBASIC 'C390'   6 2;
USEBASIC 'C490'   7 2;


//180s
USEBASIC    'Hhc180' 8 1;
USEBASIC    'M180'   9 1;
USEBASIC    'H11801' 10 1;
USEBASIC    'H11802' 11 2;

USEBASIC    'C1180'   20 2;
USEBASIC    'C2180'   21 2;
USEBASIC    'C3180'   22 2;
USEBASIC    'C4180'   23 2;

USEBASIC 'Mvar4' 25 1;
USEBASIC 'C1var4' 26 2;
USEBASIC 'C2var4' 27 2;
USEBASIC 'C3var4' 28 2;
USEBASIC 'C4var4' 29 2;
USEPARALLEL 'MC1var4';

//parallels
USEPARALLEL 'MC190'; 
USEPARALLEL 'MC490'; 
USEPARALLEL 'MC1180'; 

USEPARALLEL 'HhcC1180'; 
USEPARALLEL 'HhcC2180'; 
USEPARALLEL 'HhcC3180'; 
USEPARALLEL 'HhcC4180'; 

USEPARALLEL 'H1180tot'; 


 
 
>>>
;;Declarations:stop

;;basic set-up:
#if defined(simulation)
#else
1 ze
#endif
#if  defined nograd
2 d1
#else
 2 30m
  d1
  1u reset:f1
  1u reset:f2
  1u reset:f3
  1m
 
  50u UNBLKGRAD
#endif

;;Pulses:start
<<<

;;;;;;;;;;;;;;INCLUDE THE PULSE SEQUENCE HERE;;;;;;;;;;;;
