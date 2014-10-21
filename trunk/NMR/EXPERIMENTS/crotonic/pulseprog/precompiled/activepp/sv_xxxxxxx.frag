;pulse C12345690 0.25~C1;0.25~C2;0.25~C3;0.25~C4;0.25~C5;0.25~C6 @C1:X+;C2:X+;C3:X+;C4:X+;C5:X+;C6:X+;C7:Z+

;gradient grad1 0 0 37
;pulse C790 0.25~C7  @C1:I+;C2:I+;C3:I+;C4:I+;C5:I+;C6:I+;C7:X+
;zz 0.25 C7 C2;C4;C6
;zz -0.25 C5 C7

;refocus C6180 0~C6 
;refocus C4180 0~C4 
;refocus C5180 0~C5 
;refocus C7180 0~C7 
;refocus C2180 0~C2 
;refocus C4180 0~C4 

;pulse C790 0.25~C7  @C1:I+;C2:Z+;C3:I+;C4:Z+;C5:I+;C6:Z+;C7:Z+
;gradient grad2 0 0 45
;pulse C290 0.25~C2  @C1:I+;C2:X+;C3:I+;C4:Z+;C5:I+;C6:Z+;C7:Z+
;zz 0.25 C2 C1;C3

;refocus C3180 0~C3 
;refocus C2180 0~C2 
;refocus C1180 0~C1 

;pulse C290 0.75~C2  @C1:Z+;C2:Z+;C3:Z+;C4:Z+;C5:Z+;C6:Z+;C7:Z+
;gradient grad3 0 0 51
;;pulse Cencoding 0.25~C1;0.25~C2;0.25~C3;0.25~C4;0.25~C5;0.25~C6;0.25~C7 @C1:X+;C2:X+;C3:X+;C4:X+;C5:X+;C6:X+;C7:X+

;pulse Ch90 0.25~C1 ;0.25~C2 ;0.25~C3 ;0.25~C4;0.25~C5 ;0.25~C6 ;0.25~C7  @C1:X+;C2:X+;C3:X+;C4:X+;C5:X+;C6:X+;C7:X+