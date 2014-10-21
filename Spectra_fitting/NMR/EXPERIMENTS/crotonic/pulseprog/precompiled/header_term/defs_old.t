>>>
;;Pulses:stop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#if defined(nograd)
go=2 ph31:r
  100m
  wr #0
  exit
#else
;;New set-up
  4u BLKGRAD
  go=2 ph31:r
  100m
  wr #0
  exit
#endif
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
<<<
