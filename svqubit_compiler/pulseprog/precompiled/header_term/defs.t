>>>
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
  50u BLKGRAD
  ;;go=2 ph31:r  ;; commented by JZ Dec08, 10
  go=2 ph30 ph31:r	;; by JZ Dec08, 10
  100m
  wr #0
  exit
#endif 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ph30 = (65536) 0
<<<
