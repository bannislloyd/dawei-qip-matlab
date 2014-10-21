#define DEFER(x) x
 DEFER(#include <Avance.incl>)
 DEFER(#include <Grad.incl>)
>>>
;;Declarations:start
<<<

Delay      gon(2e-6);
Delay      goff(2e-6);
Delay      gwait(200e-6);
Delay      grad1(0.002);
Delay      grad2(0.001);
PhaseStack ps0([1...4]);
PhaseStack ps1([5...9]);
PhaseStack ps2([10...14]);
PhaseStack ps3([15...19]);
PhaseStack ps4([20...24]);
PhaseStack ps5([25...29]);

#if defined(calib)
Channel Hch(      'f2', -3000 , H, 1, ps0, ps1);
Channel Cch(      'f3', RC.frequency, C, 1, ps2, ps3);
#else
Channel Hch(      'f2', -3000 , H, 0, ps0, ps1);
Channel Cch(      'f3', -16000, C, 0, ps2, ps3);
#endif
Channel C1obsch(  'f1', C1.frequency , C, 0, ps4, ps5); 
Channel C2obsch(  'f1', C2.frequency , C, 0, ps4, ps5); 
Channel C3obsch(  'f1', C3.frequency , C, 0, ps4, ps5); 
Channel C4obsch(  'f1', C4.frequency , C, 0, ps4, ps5);
Channel RCobsch(  'f1', RC.frequency , C, 0, ps4, ps5); 
Channel H2obsch(  'f1', H2.frequency , H, 0, ps4, ps5); 
Channel H1obsch(  'f1', H1.frequency , H, 0, ps4, ps5); 
Channel Mobsch(  'f1', M.frequency , H, 0, ps4, ps5);
Channel RHobsch(  'f1', RH.frequency , H, 0, ps4, ps5); 

DEFINECYCLEN 14; 
PhaseCycle cyc1([0, 0, 0, 0.5, 0.5,  0.5, 0.5]); 

PhaseCycle cyc7([0, 0.1429, 0.2857, 0.4286, 0.5714,  0.7143, 0.8571]); 

PhaseCycle coh7([0.0000,    0.0714,    0.1429,    0.2143,    0.2857,    0.3571,    0.4286,    0.5000,    0.5714,    0.6429,    0.7143,    0.7857,    0.8571,    0.9286]);
PhaseCycle coh7obs([0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5]);

PhaseCycle coh7X2([0.0000,    0.0714,    0.1429,    0.2143,    0.2857,    0.3571,    0.4286,    0.5000,    0.5714,    0.6429,    0.7143,    0.7857,    0.8571,    0.9286,  0.0000,    0.0714,    0.1429,    0.2143,    0.2857,    0.3571,    0.4286,    0.5000,    0.5714,    0.6429,    0.7143,    0.7857,    0.8571,    0.9286]);
PhaseCycle coh7obsX2([0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5, 0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5]);

PhaseCycle depcyc([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]);

PhaseCycle coh7X32obs([0]);


//#include "phasecycles.frag"

#if defined(C1obs)
ACTIVATECHANNELS [Hch,Cch,C1obsch];
//OBSERVATION       C1obsch 31 65536 C1;
OBSERVATION       C1obsch 31 65536 C1 coh7obs
#elif defined(C2obs)
ACTIVATECHANNELS [Hch,Cch,C2obsch];
OBSERVATION       C2obsch 31 65536 C2;
#elif defined(C3obs)
ACTIVATECHANNELS [Hch,Cch,C3obsch];
// OBSERVATION       C3obsch 31 65536 C3 coh7X32obs;
OBSERVATION       C3obsch 31 65536 C3;
#elif defined(C4obs)
ACTIVATECHANNELS [Hch,Cch,C4obsch];
OBSERVATION       C4obsch 31 65536 C4;
#elif defined(RCobs)
ACTIVATECHANNELS [Hch,Cch,RCobsch];
OBSERVATION       RCobsch 31 65536 RC;
#elif defined(H2obs)
ACTIVATECHANNELS [Hch,Cch,H2obsch];
OBSERVATION       H2obsch 31 65536 H2;
#elif defined(H1obs)
ACTIVATECHANNELS [Hch,Cch,H1obsch];
OBSERVATION       H1obsch 31 65536 H1;
#elif defined(Mobs)
ACTIVATECHANNELS [Hch,Cch,Mobsch];
OBSERVATION       Mobsch 31 65536 M;
#elif defined(RHobs)
ACTIVATECHANNELS [Hch,Cch,RHobsch];
OBSERVATION       RHobsch 31 65536 RH;
#else
ACTIVATECHANNELS [Hch,Cch,C1obsch];
OBSERVATION       C1obsch 31 65536 C1;
#endif
/*
#if defined(calib)
USEBASIC 'C190'    1 2;
USEBASIC 'C290'    2 2;
USEBASIC 'C390'    3 2;
USEBASIC 'C490'    4 2;
USEBASIC 'C1180'   5 2;
USEBASIC 'C4180'   8 2;
USEBASIC 'M90'     9 1;
USEBASIC 'M180'    10 1;
USEBASIC 'Hhc180'  19 1;
USEBASIC 'C2180H'  28 2;
USEBASIC 'M180H'  29 1;
#endif */
#if defined(calib)
USEBASIC 'RC_C190'    1 2;
USEBASIC 'RC_C290'    2 2;
//USEBASIC 'C390'    3 2;
//USEBASIC 'C490'    4 2;
USEBASIC 'RCC1180'   5 2;
USEBASIC 'RCC2180'   6 2;
// USEBASIC 'C4180'   8 2;
USEBASIC 'RH_M90'     9 1;
USEBASIC 'RH_M180'    10 1;
//USEBASIC 'Hhc180'  19 1;
USEBASIC 'RCC218H'  29 2;
USEBASIC 'RHM180H'  28 1;
USEBASIC 'cHh90'  -1 1;
USEBASIC 'cCh90'  -1 2;
USEBASIC 'RH_rf' 30 1;

#endif

#if defined(reference)
USEBASIC 'Hh90'  -1 1;
USEBASIC 'Ch90'  -1 2;
#endif

#if defined(exp)
/*90s*/
USEBASIC 'Hh90'  -1 1;
USEBASIC 'Ch90'  -1 2;


USEBASIC 'C190'   1 2;
USEBASIC 'C290'   2 2;
USEBASIC 'C390'   3 2;
USEBASIC 'C490'   4 2;
USEBASIC 'C1180'   5 2;
USEBASIC 'C4180'   8 2;
USEBASIC 'C3180'   7 2;
USEBASIC 'C2180'   6 2;
//USEBASIC 'C445'   30 2;

USEBASIC 'M90'      9 1;
USEBASIC 'M180'     10 1;
USEBASIC 'H190_H'   11 1;
USEBASIC 'H190_C'   12 2;
USEBASIC 'H290_H'   13 1;
USEBASIC 'H290_C'   14 2;

USEBASIC 'H1180_H'   15 1;
USEBASIC 'H1180_C'   16 2;
USEBASIC 'H2180_H'   17 1;
USEBASIC 'H2180_C'   18 2;
USEBASIC 'Hhc180'    19 1;
USEBASIC 'C2180H'    29 2;
USEBASIC 'M180H'  28 1;
USEBASIC 'C3180H'    31 2;
//USEBASIC 'M90HG'   25 1;
//USEBASIC 'M90CG'   26 2;

//USEBASIC 'Z7_H2_90H'   13 1;
//USEBASIC 'Z7_H2_90C'   14 2;

//USEPARALLEL 'M90G';
USEPARALLEL 'H190';
USEPARALLEL 'H290';
USEPARALLEL 'H1180'; 
USEPARALLEL 'H2180'; 
USEPARALLEL 'MC1180'; 
USEPARALLEL 'MC190';  
USEPARALLEL 'HhcC4180';
USEPARALLEL 'HhcC3180';
USEPARALLEL 'HhcC1180';
USEPARALLEL 'MC490'; 
//USEPARALLEL 'MC1180H'; 
//USEPARALLEL 'H290z';

/*Depolarization and Trotation*/
/*
#if defined(depo0)
USEBASIC    'MCd0_H' 20 1;
USEBASIC    'MCd0_C' 21 2;
USEPARALLEL 'MCd0';
#endif

#if defined(depo1)
USEBASIC    'MCd1_H' 20 1;
USEBASIC    'MCd1_C' 21 2;
USEPARALLEL 'MCd1';
#endif

#if defined(depo2)
USEBASIC    'MCd2_H' 20 1;
USEBASIC    'MCd2_C' 21 2;
USEPARALLEL 'MCd2';
#endif

#if defined(depo3)
USEBASIC    'MCd3_H' 20 1;
USEBASIC    'MCd3_C' 21 2;
USEPARALLEL 'MCd3';
#endif

#if defined(depo4)
USEBASIC    'MCd4_H' 20 1;
USEBASIC    'MCd4_C' 21 2;
USEPARALLEL 'MCd4';
#endif

#if defined(depo5)
USEBASIC    'MCd5_H' 20 1;
USEBASIC    'MCd5_C' 21 2;
USEPARALLEL 'MCd5';
#endif

#if defined(depo6)
USEBASIC    'MCd6_H' 20 1;
USEBASIC    'MCd6_C' 21 2;
USEPARALLEL 'MCd6';
#endif
*/

//USEBASIC    'Trot_H'    22 1;
//USEBASIC    'Trot_C'    23 2;
//USEPARALLEL 'Trot';

/* RF selection */
USEBASIC 'Hrfsel' 30 1;	


#endif

 
 
>>>
;;Declarations:stop

;;basic set-up:
#if defined(simulation)
#else
1 ze
#endif
#if  defined(nograd)
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
