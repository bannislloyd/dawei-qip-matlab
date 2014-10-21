;;;Selects the spin-1/2 subspace of the Methyl group

; pulse noop @*:I-;M:Z-

; pulse Hh90  .18944~M 
		;;|ph29::r~M
		

; pulse Hh90 .5~M
		;;a(ZII) + b(XII)

; zz .25 M C1
	; refocus MC1180 .5~M;.25~C1 @M:+;C1:+
; pulse C190 .25~C1 @C1:Z-
		;;a(ZII) + b(YII)X

; zz 0.125 M C1
	; refocus MC1180 0~M;.75~C1 @M:+;C1:-
	; zz end C1 M
	; pulse noop
; zz 0.125 M C1
	; refocus MC1180 .5~M;.25~C1 @M:+;C1:+


; pulse C190 .75~C1 @C1:Z+
		;;a(ZII) - b(YZZ)Z

; zz .25 M C1
	; refocus MC1180 0~M;.75~C1 @M:-;C1:-
		;;a(ZII) + b(XZZ)

; pulse Hh90 0~M

; pulse Hh90 .3238 @M:Z+
        	;;|ph30::r~M 

; gradient grad1 0 0 25
		;;ac(ZII) + b( ccd(ZZZ) + cdd((XXZ)+(YYZ))/2 )
