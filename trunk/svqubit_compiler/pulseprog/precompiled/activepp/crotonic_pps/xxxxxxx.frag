;;; Transfers the polarization from the Methyl group to the other spins
;;; ZIIIIII --> XXXXXXX

; pulse M90 0~M [coh7] @M:X+  
; zz .25 M C1

	; refocus MC1180 0~M [coh7];0.25~C1 [coh7]

; pulse MC190 0.75~M [coh7];0.5~C1 [coh7] @M:Z+;C1:Z-

 ;zz -0.25 C1 C2

 ;refocus Hhc180 0~M [coh7]

 ;pulse C290 .75~C2 [coh7] @C2:Z-


 ;zz 0.25 C2 C3
 ;zz -.25 C2 H1
 ;zz * C2 C1

 ;refocus C1180 0~C1 [coh7] @C1:-
 ;refocus C2180H 0.5~C2 [coh7] @C2:+

 ;pulse C390 .75~C3 [coh7] @C3:Z-

 ;zz -.25 C3 H2
 ;zz .25 C3 C4
 ;zz * C3 C2;C1

 ;refocus C2180H 0.5~C2 [coh7] @C2:-


 ;refocus Hhc180 0.5~M [coh7] @H1:-;H2:-;M:-



 ;pulse Hh90 0.25~M [coh7] @M:X+;H1:Z-;H2:Z-
 ;zz * M C1;C2;C3;H1;H2
 ;zz * H1 C1;C2;C3;M;H2
 ;zz * H2 C1;C2;C3;M;H1


 ; pulse C490 .25~C4 [coh7] @C4:Z-
 ;zz * C4 C3;C2;C1;M;H1;H2

 ; zz * * *
