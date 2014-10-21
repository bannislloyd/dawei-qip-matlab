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
#if defined(nograd)
  ;;go=2 ph31:r  ;; commented by JZ Dec08, 10
  go=2 ph30 ph31:r	;; by JZ Dec08, 10
  100m
  wr #0
  exit
#else
;;New set-up
  ;50u BLKGRAD
  ;;go=2 ph31:r  ;; commented by JZ Dec08, 10
  go=2 ph30 ph31:r	;; by JZ Dec08, 10
  //30m do:f2 mc #0 to 2 F0(zd)
30m do:f2
wr #0
  exit
#endif 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ph30 = (65536) 0
   ph25 = 0
ph0=0
ph1=1
<<<
