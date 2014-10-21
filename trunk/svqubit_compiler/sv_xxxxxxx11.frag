;pulse C12345690 0.25~C1;0.25~C2;0.25~C3;0.25~C4;0.25~C5;0.25~C6 @*:X+;C7:Z+
;gradient grad1 0 0 37
;pulse C790 0.25~C7 [coh7] @*:I+;C7:X+

;;zz 0.25 C6 C7
;;zz 0.25 C2 C7 
;;zz 0.25 C5 C7 
;;zz 0.25 C4 C7

;;refocus C1180 0~C1
;;refocus C3180 0~C3
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
;;refocus C6180 0~C6
;;refocus C7180 0~C7
;;refocus C4180 0~C4
;;refocus C2180 0~C2


;zz 0.25 C2 C7 
;refocus C2180 0~C2 [coh7]
;refocus C7180 0~C7 [coh7]
;zz 0.25 C4 C7
;refocus C4180 0~C4 [coh7]
;refocus C7180 0~C7 [coh7]
;zz 0.25 C5 C7 
;refocus C5180 0~C5 [coh7]
;refocus C7180 0~C7 [coh7]
;zz 0.25 C6 C7 
;refocus C6180 0~C6 [coh7]
;refocus C7180 0~C7 [coh7]


;pulse C790 0.75~C7 [coh7] @*:Z+;C1:I+;C3:I+
;gradient grad2 0 0 45
;pulse C290 0.25~C2 [coh7] @*:Z+;C1:I+;C3:I+;C2:X+

;zz 0.25 C2 C1
;zz 0.25 C2 C3
;refocus C1180 0~C1
;refocus C2180 0~C2
;refocus C3180 0~C3

;pulse C290 0.75~C2  [coh7] @*:Z+
;gradient grad3 0 0 28
;pulse Ch90 0~C1;0~C2;0~C3;0~C4;0~C5;0~C6;0~C7 [coh7]

;;for here, we got 0.89YYYYYYY, a good fidelity
;;pulse C134690 0~C1;0~C3;0~C4;0~C6 @*:Z+;C2:X+;C5:X+;C7:X+


;;pulse C390 0~C3 
;;pulse C490 0~C4 
;;pulse C690 0~C6 
;;pulse C290 0~C2 
;;pulse C590 0~C5 
;;pulse C790 0~C7 @*:Z+
;;gradient grad4 0 0 52

