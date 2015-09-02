;redcode
;name Gimp Hammer
;author G Crofton
;strategy destroys incoming imps

		ORG main
		
bomb:	DAT #0, #0
main:	mov bomb, bomb-1
		jmp main