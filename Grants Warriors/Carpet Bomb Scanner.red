;redcode
;name Carpet Bomb Scanner
;author G Crofton
;strategy scanner that bombs a whole section if anything found.  Kills itself.

            ORG scan
		
loopsize EQU 8
bombsize EQU 8
		
empty:      DAT 0, 0                    ; empty field to compare against.  Also used for bombing.
scan:       ADD #loopsize, location      ; keep moving location forward while scanning
            SEQ @location, empty        ; copare scan location with empty memory
            JMP bombing                 ; if something there, swithch to bombing
location:   JMP scan, #bombsize         ; otherwise keep scanning.  Also used to store location.

bombing:    MOV empty, @location        ; bomb the current location
            MOV.B location, bombtarget  ; store current location in bombtarget
            SUB #loopsize, bombtarget    ; update bombtarget to location - size of bot
            
bombloop:   MOV empty, <location        ; -1 from location and bomb
            SEQ.B location, bombtarget  ; if bombing has reached target, continue scanning
bombtarget: JMP bombloop, #0            ; otherwise continue bombing
            JMP scan
