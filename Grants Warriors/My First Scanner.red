;redcode
;name My First Scanner
;author G Crofton
;strategy Basic scanner.  Bombs single location if something found.

            ORG scan

botsize EQU 8
bombsize EQU 3
            
empty:      DAT 0, 0                    ; empty field to compare against.  Also used for bombing.
scan:       ADD #botsize, location      ; keep moving location forward while scanning
            SEQ @location, empty        ; compare scan location with empty memory
            JMP bombing                 ; if something there, swithch to bombing
location:   JMP scan, #bombsize         ; otherwise keep scanning.  Also used to store location.

bombing:    MOV empty, @location        ; bomb the current location
            JMP scan
