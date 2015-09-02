	ORG start
loc:	DAT #0, #10
bomb:	DAT #1, #1
start: 	MOV      bomb,     @loc
	ADD 	 #10,      loc
	JMP	start
	spl	@loc,0
