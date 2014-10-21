;;;Pseudo-Pure State decoding fragment

;pulse M90 0.75~M;0~C1

;zz 0.25 M C1
;refocus MC1180 0~M;0~C1

;pulse MC190 0.5~M;0.75~C1 @M:0+

;refocus H2180 0
;pulse H290 0.75~H2
;zz 0.25 C1 C2
;zz 0.25 H2 C3

;refocus C1180 0
;refocus C2180 0
;refocus H2180 0
;refocus C3180 0



;pulse C190 0.5~C1 @C1:0+

;pulse H290 0.5~H2 @H2:0+
;pulse C490 0.75~C4
;refocus C4180 0
;zz 0.25 C4 C3
;refocus H1180 0
;pulse C490 0.5~C4 @C4:0+
;refocus C4180 0


;pulse C390 0.75~C3
;refocus C3180 0
;zz 0.25 C2 C3
;pulse C390 0.5~C3 @C3:0+

;pulse C290 0.75~C2
;refocus C2180 0
;zz 0.25 C2 H1
;pulse C290 0.5~C2 @C2:0+
