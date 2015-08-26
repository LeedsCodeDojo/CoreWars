;redcode
;name InstructionModifiersTest
;author G Crofton

		org start
data:	DAT #33, #99
start:	MOV data, 10 ; no modifiers (same as MOV.I)
		MOV.I data, 10 ; whole instruction
		MOV.B data, 10 ; B field
		MOV.A data, 10 ; A field
		MOV.AB data, 10 ; A field into B
		MOV.BA data, 10 ; B field into A
		MOV.F data, 10 ; both data fields
		MOV.X data, 10 ; swap data fields
		