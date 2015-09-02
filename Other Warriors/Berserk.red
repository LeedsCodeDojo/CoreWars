;redcode
;name Berserk
;strategy imp
Jump	jmp 	4
Index	dat	#0, #0
Bomb	dat	#0, #CodeLen
CodeLen equ	14
Start	mov	#CodeLen, Index
	mov	Bomb, @Bomb
	add	#CodeLen, Bomb
Loop	mov	@Index,	<Target
	djn	Loop,	Index
	mov	Bomb, <Target
	mov	Index, <Target
	mov	Jump, <Target
	spl	@Target,0
	jmz 	Start, Index
Target	dat	#0,	#7900
	end Start
