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
| ADD | Add | Adds source value(s) to destination, leaving result in destination | Source | Destination |
| SUB | Subtract | Subtracts source value(s) from destination, leaving result in destination | Source | Destination |
| MUL | Multiply | Multiplies source value(s) with destination, leaving result in destination | Source | Destination |
| DIV | Divide | Divides source value(s) by destination, leaving result in destination | Source | Destination |
| MOD | Modulo | Divides source value(s) by destination, leaving remainder in destination | Source | Destination |
| JMP | Jump | Continues execution from another address | Location to continue | Not used |
| JMZ | Jump if Zero | Jumps to an address if a number is 0 | Location to continue | Number to test |
| JMN | Jump if Not Zero | Tests a number and jumps if it isn't 0 | Location to continue | Number to test |
| DJN | Decrement and Jump if Not Zero | Decrements a number by one, and jumps unless the result is 0 | Location to continue | Number to test |
| SPL | Split | Starts a second process at another address | Location to start new process | Not used |
| SEQ | Skip if Equal | Ccompares two instructions, and skips the next instruction if they are equal | Location to compare  | Location to compare |
| CMP | Compare | Same as SEQ | Same as SEQ | Same as SEQ |
| SNE | Skip if Not Equal | Compares two instructions, and skips the next instruction if they aren't equal  | Location to compare | Location to compare |
| SLT | Skip if Lower Than | Compares two values, and skips the next instruction if the first is lower than the second | Location to compare | Location to compare |
| LDP | Load from P-space | Loads a number from private storage space | Locatio to load from | Location to write to |
| STP | Save to P-space | Saves a number to private storage space | Value to store | Location to store it in |
| NOP | No Operation | Does nothing (executing does not kill bot) | Not used | Not used |
