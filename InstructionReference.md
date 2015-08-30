Instruction Reference
=====================

A quick reference to the instruction set from redcode-94.

### Instruction Layout

The anatomy of an instruction is as follows:

    MOV 0 1
    {Instruction} {A Field} {B Field}
    
If the A and/or B fields are not used by the instruction, they can be left blank and will be set to 0 by the compiler.  You can also use such unused fields to store data.

### Instructions

| Instruction | Description | A Field | B Field |
|-------------|-------------|---------|---------|
| DAT | Just holds data.  If executed, kills bot. | Some data | More data |
| MOV | Copies an instruction from one location to another. | Source location | Destination location |
| ADD | add (adds one number to another) |  |  |
| SUB | subtract (subtracts one number from another) |  |  |
| MUL | multiply (multiplies one number with another) |  |  |
| DIV | divide (divides one number with another) |  |  |
| MOD | modulus (divides one number with another and gives the remainder) |  |  |
| JMP | jump (continues execution from another address) |  |  |
| JMZ | jump if zero (tests a number and jumps to an address if it's 0) |  |  |
| JMN | jump if not zero (tests a number and jumps if it isn't 0) |  |  |
| DJN | decrement and jump if not zero (decrements a number by one, and jumps unless the result is 0) |  |  |
| SPL | split (starts a second process at another address) |  |  |
| CMP | compare (same as SEQ) |  |  |
| SEQ | skip if equal (compares two instructions, and skips the next instruction if they are equal) |  |  |
| SNE | skip if not equal (compares two instructions, and skips the next instruction if they aren't equal) |  |  |
| SLT | skip if lower than (compares two values, and skips the next instruction if the first is lower than the second) |  |  |
| LDP | load from p-space (loads a number from private storage space) |  |  |
| STP | save to p-space (saves a number to private storage space) |  |  |
| NOP | no operation (does nothing) |  |  |
