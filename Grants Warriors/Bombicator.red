;name Bombicator
;author G Crofton
;strategy Replicating Bomber

repSize EQU 5
repGap  EQU 1000

            ORG replicate
            
repIndex:   DAT #0, #repSize ; tracks number of instructions copied

bomb:       DAT #4, #0
bombLoop:   SUB.AB bomb, bomb
            MOV bomb, @bomb
            JMP bombLoop

repLoop:    SEQ.B repCount, #10 ; replicate every 10 turns
            JMP repLoop, >repCount
            
            MOV.AB #0, repCount
            
replicate:  MOV <repIndex, <repLoc
            SEQ.B repIndex, #1
            JMP replicate
            
            ADD #1, repLoc
            SPL @repLoc
            MOV.AB #repSize, repIndex
            ADD.AB repLoc, repLoc
            JMP repLoop
            
repLoc:     DAT #repGap, #repGap ; records where a new replicant is spawned
repCount:   DAT #0, #0 ; counts how many turns since last replication
