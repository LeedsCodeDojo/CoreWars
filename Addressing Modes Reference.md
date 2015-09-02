Addressing Modes Reference
==========================
    
ADdressing modes are used by putting a prefix before the number in a field:

    ADD 1, 5   ; default addressing modes
    ADD #1, >5 ; different addressing modes
    
They also work with labels:

    counter: DAT #0, #0
             ADD #1, >counter

| Mode Prefix | Description |
|-------------|-------------|
| # | immediate |
| $ | direct (the $ may be omitted) |
| * | A-field indirect |
| @ | B-field indirect |
| { | A-field indirect with predecrement |
| < | B-field indirect with predecrement |
| } | A-field indirect with postincrement |
| > | B-field indirect with postincrement |
