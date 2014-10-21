;pulse H190 0.75~H1
;refocus H1180 0~H1
;z 0.16667 H1
;pulse H190 0.25~H1
;refocus H1180 0~H1
;gradient grad1 0 0 37

;pulse H190 0.75~H1
;refocus H1180 0~H1
;z 0.125 H1
;pulse H190 0.25~H1
;;refocus H1180 0~H1

;zz 0.25 H1 C1
;;refocus H1180 0~H1
;;refocus C1180 0~C1

;pulse H190 0~H1
;refocus H1180 0~H1
;z -0.125 H1
;pulse H190 0.5~H1
;;refocus H1180 0~H1
;gradient grad2 0 0 57
;zz * * *
