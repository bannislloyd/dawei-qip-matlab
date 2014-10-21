>>>
;;Pulses:stop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#if defined(nograd)
go=2 ph31:r
  100m
  wr #0
  exit
#else
d0:r
 (p11:sp9 ph11):f2 (p11:sp10 ph11):f3 
;;New set-up
  50u BLKGRAD
  go=2 ph31:r
  100m
  wr #0
  exit
#endif
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
<<<
