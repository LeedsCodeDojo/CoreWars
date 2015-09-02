;redcode-94
;name split-pit
;author Jonny
;strategy Throw everything into a pit, and slow it down
;assert CORESIZE==8000

            org     start
magic           equ     2384
nloops          equ     4
looplen         equ     5
life            equ     500

_BOMB_01   equ     #1
_BOMB_02   equ     #2
_BOMB_03   equ     #3
_BOMB_04   equ     #4

before      NOP     0
before1     NOP     0
before2     NOP     0
ix          for     nloops
split&ix    SPL     0                           ; Split the bot asap, and then send one forward
; move&ix must come after split&ix
move&ix     SNE.B   @jump&ix, magic             ; Check if given JMP have the magic
            MOV.I   jump&ix, jump&ix + looplen  ; Copy the jump to another, to repair broken jumps
            JMP     split&ix+looplen            ; If the current index is broken, use the next
jump&ix     JMP     split&ix, magic             ; Jump back to the split to repeat, with a magic indicator
            rof

            for     20
            NOP     0                           ; the last loop will throw a jump out here, don't have our code here
            rof

start       nop     0
            SPL     main
loop        DJN     0, death            ; Loop until the enemy runs out of life
nbombs      for nloops
            MOV death, _BOMB_&nbombs    ; throw in a bomb
            rof

death       DAT     0, life

main        SPL     jumpbomber
            JMP     imptrap

bomb        JMP     split01             ; Throw an imp into the trap
imptrap     MOV     -1, before
            MOV     -2, before
            MOV     -3, before
            JMP     -3

jumpbomber SUB #2, 3
            MOV bomb, @2
            JMP -2
            DAT #0, #8000
