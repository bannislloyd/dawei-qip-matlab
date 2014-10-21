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
Delay      grad2(0.003);

PhaseStack ps0([1...4]);
PhaseStack ps1([5...9]);
PhaseStack ps2([10...14]);
PhaseStack ps3([15...19]);
PhaseStack ps4([20...24]);
PhaseStack ps5([25...29]);

#if defined(calib)
//Channel Hch(      'f2', -3000 , H, 1, ps0, ps1);    // commented by JZ, Dec10, 2010
Channel Hch(      'f2', RH.frequency, H, 1, ps0, ps1); //by JZ, Dec10, 2010
Channel Cch(      'f3', RC.frequency, C, 1, ps2, ps3);
#else
Channel Hch(      'f2', H1.frequency , H, 0, ps0, ps1);
Channel Cch(      'f3', C1.frequency, C, 0, ps2, ps3);
#endif
Channel C1obsch(  'f1', C1.frequency , C, 0, ps4, ps5); 
Channel RCobsch(  'f1', RC.frequency , C, 0, ps4, ps5);  
Channel H1obsch(  'f1', H1.frequency , H, 0, ps4, ps5); 
Channel RHobsch(  'f1', RH.frequency , H, 0, ps4, ps5); 

DEFINECYCLEN 1; 
//DEFINECYCLEN 14; 
//DEFINECYCLEN 448; 
//DEFINECYCLEN 7; 


PhaseCycle cyc1([0, 0, 0, 0.5, 0.5,  0.5, 0.5]); 

//  PhaseCycle cyc7([0, 0.1429, 0.2857, 0.4286, 0.5714,  0.7143, 0.8571]); 
 PhaseCycle cyc7([0.0714, 0.2143,0.3571,0.5000,0.6429, 0.7857,0.9286]);


PhaseCycle cyc7obs([0, 0, 0, 0, 0, 0, 0]);

PhaseCycle coh7([0.0000,    0.0714,    0.1429,    0.2143,    0.2857,    0.3571,    0.4286,    0.5000,    0.5714,    0.6429,    0.7143,    0.7857,    0.8571,    0.9286]);
PhaseCycle coh7obs([0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5]);

PhaseCycle coh7X2([0.0000,    0.0714,    0.1429,    0.2143,    0.2857,    0.3571,    0.4286,    0.5000,    0.5714,    0.6429,    0.7143,    0.7857,    0.8571,    0.9286,  0.0000,    0.0714,    0.1429,    0.2143,    0.2857,    0.3571,    0.4286,    0.5000,    0.5714,    0.6429,    0.7143,    0.7857,    0.8571,    0.9286]);
PhaseCycle coh7obsX2([0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5, 0, 0.5, 0, 0.5, 0, 0.5, 0, 0.5 , 0, 0.5, 0, 0.5, 0 , 0.5]);

PhaseCycle depcyc([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]);

//PhaseCycle coh7X32obs([0]);


//#include "phasecycles.frag"

#if defined(C1obs)
ACTIVATECHANNELS [Hch,Cch,C1obsch];
//OBSERVATION       C1obsch 31 65536 C1 coh7obs;
OBSERVATION       C1obsch 31 65536 C1;
//OBSERVATION       C1obsch 31 65536 C1 coh7X32obs;
//OBSERVATION       C1obsch 31 65536 C1 cyc7obs;




#elif defined(RCobs)
ACTIVATECHANNELS [Hch,Cch,RCobsch];
OBSERVATION       RCobsch 31 65536 RC;


#elif defined(H1obs)
ACTIVATECHANNELS [Hch,Cch,H1obsch];
//OBSERVATION       H1obsch 31 65536 H1 coh7obs;
OBSERVATION       H1obsch 31 65536 H1;


#elif defined(RHobs)
ACTIVATECHANNELS [Hch,Cch,RHobsch];
OBSERVATION       RHobsch 31 65536 RH;
#else
ACTIVATECHANNELS [Hch,Cch,C1obsch];
OBSERVATION       C1obsch 31 65536 C1;
#endif

#if defined(calib)
//USEBASIC 'RC_C190'    1 2;
//USEBASIC 'RC_C290'    2 2;
//USEBASIC 'C390'    3 2;
//USEBASIC 'C490'    4 2;
//USEBASIC 'RCC1180'   5 2;
//USEBASIC 'RCC2180'   6 2;
// USEBASIC 'C4180'   8 2;
//USEBASIC 'RH_M90'     9 1;
//USEBASIC 'RH_M180'    10 1;
//USEBASIC 'Hhc180'  19 1;
//USEBASIC 'RCC218H'  29 2;
//USEBASIC 'RHM180H'  28 1;
//USEBASIC 'cHh90'  -1 1;
//USEBASIC 'cCh90'  -1 2;
//USEBASIC 'RH_rf' 30 1;
//USEBASIC 'RC_C145'    22 2;
//USEBASIC 'RC_C245'    23 2;
#endif

#if defined(reference)
USEBASIC 'Hh90'  -1 1;
USEBASIC 'Ch90'  -1 2;
#endif

/*90s*/
/* makerefdata, comment out these two following lines becuase of the "reference" opition, by JZ, Sept. 18, 2009 */
USEBASIC 'Hh90'  -1 1;  
USEBASIC 'Ch90'  -1 2;  
USEBASIC 'Hh180'  -1 1;  
USEBASIC 'Ch180'  -1 2;
USEBASIC 'H190'   1 1; 
USEBASIC 'H1180'   2 1;
USEBASIC 'C190'   3 2;
USEBASIC 'C1180'   4 2;
//USEBASIC 'C290'   2 2;
//USEBASIC 'C390'   3 2;
//USEBASIC 'C490'   4 2;
//USEBASIC 'C1180'   5 2;
//USEBASIC 'C4180'   8 2;
//USEBASIC 'C3180'   7 2;
//USEBASIC 'C2180'   6 2;
//USEBASIC 'C145'   22 2;
//USEBASIC 'C445'   23 2;

//USEBASIC 'M90'      9 1;
//USEBASIC 'M180'     10 1;
//USEBASIC 'H190_H'   11 1;
//USEBASIC 'H190_C'   12 2;
//USEBASIC 'H290_H'   13 1;
//USEBASIC 'H290_C'   14 2;

//USEBASIC 'H1180_H'   15 1;
//USEBASIC 'H1180_C'   16 2;
//USEBASIC 'H2180_H'   17 1;
//USEBASIC 'H2180_C'   18 2;
//USEBASIC 'Hhc180'    19 1;
//USEBASIC 'C2180H'    29 2;
//USEBASIC 'M180H'  28 1;
//USEBASIC 'C3180H'    31 2;
//USEBASIC 'C190_H'   25 1;
//USEBASIC 'C190_C'   26 2;
//USEBASIC 'C290_H'   20 1;
//USEBASIC 'C290_C'   21 2;
//USEBASIC 'C390_H'   24 1;
//USEBASIC 'C390_C'   27 2;



//USEPARALLEL 'M90G';
//USEPARALLEL 'H190';
//USEPARALLEL 'H290';
//USEPARALLEL 'H1180'; 
//USEPARALLEL 'H2180'; 
//USEPARALLEL 'MC1180'; 
//USEPARALLEL 'MC190';  
//USEPARALLEL 'HhcC4180';
//USEPARALLEL 'HhcC3180';
//USEPARALLEL 'HhcC1180';
//USEPARALLEL 'MC490'; 
//USEPARALLEL 'C190G'; 
//USEPARALLEL 'C290G'; 
//USEPARALLEL 'C390G'; 


/* RF selection */
//USEBASIC 'Hrfsel' 30 1;	



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
