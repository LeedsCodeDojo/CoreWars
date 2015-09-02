;redcode
;name Swami
;author Swami
Bomb	dat	#0,	#-980
Spacer	equ	28
Spacer1	equ	27
Spacer2	equ	26
Spacer3	equ	25
Start	mov	Bomb,	@Bomb
	sub	#Spacer,Bomb
	sub	#Spacer1,Bomb
	sub	#Spacer2,Bomb
	sub	#Spacer3,Bomb
	spl	#Spacer ,0
	spl	#Spacer1 ,0
	spl	#Spacer2 ,0
	spl	#Spacer3 ,0
	jmp	Start,	#0
	end	Start
