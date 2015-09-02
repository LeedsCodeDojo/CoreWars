;redcode
;name black Knight
;author Gordon and Geoff
;strategy mousey bomb
;history attempt1

;COPY SELF
	org  Start
Top	dat	#0,	#0
Start	mov	#15,	Top
Loop	mov	@Top,	<Target
	djn	Loop,	Top
;SPLIT
	SPL  @Target
;CHANGE COPY LOCATION
	add    #653,	Target
;CHANGE BOMB ADDRESS
	mov	 #6,	BSight
Sight	add  	#17,	Bomb	
;LAUNCH BOMB
	mov    Bomb, 	@Bomb
	djn   Sight,    BSight
;REPEAT
	JMP   Start
Target	dat	 #0,	#837
Bomb	dat	  0,    4000
BSight  dat	  0,    0