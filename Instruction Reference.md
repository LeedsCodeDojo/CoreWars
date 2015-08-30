Instruction Reference
=====================

A quick reference to the instruction set from redcode-94.

### Instruction Layout

The anatomy of an instruction is as follows:

    MOV 0 1
    {Instruction} {A Field} {B Field}
    
If the A and/or B fields are not used by the instruction, they can be left blank and will be set to 0 by the compiler.  You can also use such unused fields to store data.

### Instructions

| Instruction | Name | Description | A Field | B Field |
|-------------|------|-------------|---------|---------|
| DAT | Data |Just holds data - if executed, kills bot | Some data | More data |
| MOV | Move |Copies an instruction from one location to another | Source location | Destination location |
| ADD | Add | Adds one number to another |  |  |
| SUB | Subtract |Subtracts one number from another |  |  |
| MUL | Multiply | Multiplies one number with another |  |  |
| DIV | Divide | Divides one number by another |  |  |
| MOD | Modulo | Divides one number by another and gives the remainder |  |  |
| JMP | Jump | Continues execution from another address |  |  |
| JMZ | Jump if Zero | Tests a number and jumps to an address if it's 0 |  |  |
| JMN | Jump if Not Zero | Tests a number and jumps if it isn't 0 |  |  |
| DJN | Decrement and Jump if Not Zero | Decrements a number by one, and jumps unless the result is 0 |  |  |
| SPL | Split | Starts a second process at another address |  |  |
| SEQ | Skip if Equal | Ccompares two instructions, and skips the next instruction if they are equal |  |  |
| CMP | Compare | Same as SEQ |  |  |
| SNE | Skip if Not Equal | Compares two instructions, and skips the next instruction if they aren't equal  |  |  |
| SLT | Skip if Lower Than | Compares two values, and skips the next instruction if the first is lower than the second |  |  |
| LDP | Load from P-space | Loads a number from private storage space |  |  |
| STP | Save to P-space | Saves a number to private storage space |  |  |
| NOP | No Operation | Does nothing (executing does not kill bot) |  |  |
