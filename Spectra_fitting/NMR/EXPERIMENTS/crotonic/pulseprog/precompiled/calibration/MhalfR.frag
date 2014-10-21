;;;Selects the spin-1/2 subspace of the Methyl group

; pulse noop @*:I-;RH:Z-

; pulse cHh90  .18944~RH 
		;;|ph29::r~RH
		

; pulse cHh90 .5~RH
		;;a(ZII) + b(XII)

; zz .25 RH RC
	;; refocus MC1180 .5~M;.25~C1 @M:+;C1:+
       ;refocus RCC1180 0.25~RC @RC:+

       ;refocus RH_M180 0.5~RH @RH:+

; pulse cCh90 .25~RC @RC:Z-
		;;a(ZII) + b(YII)X

; zz 0.125 RH RC
	;; refocus MC1180 0~M;.75~C1 @M:+;C1:-
       ;refocus RCC1180 0.75~RC @RC:-

       ;refocus RH_M180 0~RH @RH:+
	; zz end RC RH
	; pulse noop
; zz 0.125 RH RC
	;; refocus MC1180 .5~M;.25~C1 @M:+;C1:+
       ;refocus RCC1180 0.25~RC @RC:+
       ;refocus RH_M180 0.5~RH @RH:+

; pulse cCh90 .75~RC @RC:Z+
		;;a(ZII) - b(YZZ)Z

; zz .25 RH RC
	;; refocus MC1180 0~M;.75~C1 @M:-;C1:-
       ;refocus RCC1180 0.75~RC @RC:-
       ;refocus RH_M180 0~RH @RH:-
		;;a(ZII) + b(XZZ)

; pulse cHh90 0~RH

; pulse cHh90 .3238 @RH:Z+
        	;;|ph30::r~M 

; gradient grad1 0 0 25
		;;ac(ZII) + b( ccd(ZZZ) + cdd((XXZ)+(YYZ))/2 )
