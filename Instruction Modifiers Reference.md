Instruction Modifiers Reference
===============================

If you need to be more specific about the fields your instruction is operating on, you can optionally use one of a handful of modifiers:

    ADD #1, 5   ; default
    ADD.A #1, 5 ; with modifier

### Modifiers List

Here are all of the modifiers, applied to a MOV instruction as an example:
    
| Modifier | Description |
|----------|-------------|
| MOV.A | moves the A-field of the source into the A-field of the destination |
| MOV.B | moves the B-field of the source into the B-field of the destination |
| MOV.AB | moves the A-field of the source into the B-field of the destination |
| MOV.BA | moves the B-field of the source into the A-field of the destination |
| MOV.F | moves both fields of the source into the same fields in the destination |
| MOV.X | moves both fields of the source into the opposite fields in the destination |
| MOV.I | moves the whole source instruction into the destination |

All instructions have a default modifier if none is supplied (which changes according to the addressing modes used).  Not all modifiers can be applied to all instructions.
