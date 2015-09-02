;redcode
;name Tester
;author Testers
;strategy Test
;history Just a test
Top	dat	#0,	#0
Bomb	dat	#0,	#-10
Spacer	equ	2
Start	spl Imp
Bomber	mov	Bomb,	@Bomb
		sub	#Spacer,Bomb
		jmp	Bomber
Target	dat	#0,	#80
Imp		mov	0,	1
		end	Start
	

	



	
