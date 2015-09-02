	org	start
a	dat	#0,#80
	spl	start
start	mov	a, a-1
	mov	a, @a
	add	#45, a
	jmp	start