;redcode
;name AddressModesTest
;author G Crofton

		org start
data:	DAT #15, #20
start:	MOV data, 10 ; copy Dat to address 10 ahead of current
		MOV data, *data ; copy Dat to address specified in A (15 ahead of Dat)
		MOV data, @data ; copy Dat to address specified in B (20 ahead of Dat)
		MOV data, {data ; copy Dat to address specified in A, but decrements it beforehand (14 ahead of Dat)
		MOV data, <data ; copy Dat to address specified in B, but decrements it beforehand (19 ahead of Dat)
		MOV data, }data ; copy Dat to address specified in A, but increments it beforehand (15 ahead of Dat)
		MOV data, >data ; copy Dat to address specified in B, but increments it beforehand (20 ahead of Dat)