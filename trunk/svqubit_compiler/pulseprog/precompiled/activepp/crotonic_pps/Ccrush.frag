;;;Crushes the Polarization on all spins but Methyl

;zz * * *
; pulse C490 0
;zz * * *

;zz * * *
; pulse C390 0
;zz * * *

;zz * * *
; pulse C290 0
;zz * * *

;zz * * *
; pulse C190 0
;zz * * *

;zz * * *
; pulse Hh90 0.25~M
;zz * * *

;zz 0 M C1
;refocus C1180 0 @C1:-
; pulse M90 0.75 @M:Z+

; gradient grad1 0 0 29
