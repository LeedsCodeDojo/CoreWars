Simple Bot Guide
================

A guide to building a simple bot for Core Wars using the Redcode assembly language.


# Quick Overview

The environment the programs run in consists of a number of memory locations each of which hold a single instruction (with data).  By default there are 8000 locations, and the memory wraps round so appears infinite to the bots.

For illustrative purposes, we will show a section of memory in stunning ASCII art!

You bot is executed one instruction at a time until there are no instructions to execute, at which point it dies:

         |
         v
    +---------+-----------+-------+
    | MOV 0 5 | SEQ -1 -2 |       |
    +---------+-----------+-------+

                    |
                    v
    +---------+-----------+-------+
    | MOV 0 5 | SEQ -1 -2 |       |
    +---------+-----------+-------+

                             XXX
                              v
    +---------+-----------+-------+
    | MOV 0 5 | SEQ -1 -2 |       |
    +---------+-----------+-------+

One thing to note is that the memory is never actually empty - it's filled with blank data (DAT 0 0).  You your program actually dies when it hits a DAT instruction:

                              XXX
                               v
    +---------+-----------+---------+
    | MOV 0 5 | SEQ -1 -2 | DAT 0 0 |
    +---------+-----------+---------+

This is the key to victory - your main goal is to kill another bot by making it execute a DAT instruction, using methods which will be described shortly.  There are other ways to win, but this is the main one.

For example:

Your bot executes it's first instruction:

         |
         v
    +---------+-----------+--------+----
    | MOV 0 5 | SEQ -1 -2 | JMP -2 | ..
    +---------+-----------+--------+----

And it's second:

                    |
                    v
    +---------+-----------+--------+----
    | MOV 0 5 | SEQ -1 -2 | JMP -2 | ..
    +---------+-----------+--------+----

An enemy bot replaces your JMP with a DAT:

                    |
                    v
    +---------+-----------+---------+----
    | MOV 0 5 | SEQ -1 -2 | DAT 0 0 | ..
    +---------+-----------+---------+----
                               ^

Your bot executes the DAT and dies.  Boom!

                              XXX
                               v
    +---------+-----------+---------+----
    | MOV 0 5 | SEQ -1 -2 | DAT 0 0 | .. 
    +---------+-----------+---------+----

# Making a bot

A bot is simple a list of instructions in a text file like this:

    MOV  0,  5
    SEQ -1, -2
    JMP -2
    ...
    
Each instruction is a three-letter acronym, and may have zero, one or two numeric data fields associated with it.

When loaded into the environment, the bot is compiled and these instructions loaded into a random place in memory, ready to start executing.

## Example Bot - The Imp

The simplest bot is a one-liner known as an Imp:

    MOV 0 1

When loaded, somewhere in memory there will be your instruction, with execution of your bot set to start there:

                        |
                        v
    ----+---------+---------+---------+---------+----
     .. | DAT 0 0 | MOV 0 1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+----

The MOV instruction copies the contents of one address to another address.  In this case, it copies the contents of location 0 (the current location) to location + 1:

                        |
                        v
    ----+---------+---------+---------+---------+----
     .. | DAT 0 0 | MOV 0 1 | MOV 0 1 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+----
                        |________^

Then execution moves to the next address:

                                 |
                                 v
    ----+---------+---------+---------+---------+----
     .. | DAT 0 0 | MOV 0 1 | MOV 0 1 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+----

That instruction gets executed:

                                 |
                                 v
    ----+---------+---------+---------+---------+----
     .. | DAT 0 0 | MOV 0 1 | MOV 0 1 | MOV 0 1 | .. 
    ----+---------+---------+---------+---------+----
                                  |_________^

And so on, repeatedly copying it's single instruction until the game ends (typically after 8000 cycles) or another bot kills it.

One thing to point out at this stage is the addressing used:

## Relative Addressing

All locations are relative to the current position, there are no absolute locations as far as each bot is concerned.

                         |
                         v
     ----+---------+---------+---------+---------+----
      .. | DAT 0 0 | MOV 0 1 | DAT 0 0 | DAT 0 0 | .. 
     ----+---------+---------+---------+---------+----
    Address:  -1        0         1         2      ..

## Example Bot - Imp Trap

Here is another simple bot, with a single purpose in life - killing Imps:

            ORG loop

            DAT  9,  9 ; number 9 not important - just for illustrative purposes
    loop:   MOV -1, -2
            JMP -1

This file includes a couple of things in addition to the instructions:

  * ORG - tells the compiler which instruction to start on
  * ; - a comment
  * loop - a label
        
When loaded into memory, it will look like:

                                                      |
                                                      v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | DAT 0 0 | DAT 0 0 | DAT 0 0 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----

The first instruction copies the DAT 9 9 from location -1 to location -2 (one place back)

                                                      |
                                                      v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | DAT 0 0 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
                                 ^__________|

The next instrution executed is a JMP, which causes execution to jump to another location - in this case back one place, causing a loop

                                                                 |
                                                                 v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | DAT 0 0 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----

                                                      |----------
                                                      v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | DAT 0 0 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----

And this will keep going until the game ends, copying the DAT instruction to location -2.

But look what happens when an Imp comes along (each bot takes one instruction at a time):

## Imp vs Imp Trap

The Imp copies his MOV forward

    imp
     v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | MOV 0 1 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
    _________^

The Imp Trap continues copying his DAT backwards

                                                   imp trap
                                                      v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | MOV 0 1 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
                                 ^_________|

            imp
             v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | MOV 0 1 | MOV 0 1 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
             |_________^
             
                                                              imp trap
                                                                 v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | DAT 0 0 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----

The Imp copies his MOV forward... right into the trap!

                       imp
                        v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | MOV 0 1 | MOV 0 1 | MOV 0 1 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
                       |_________^

The Imp Trap copies his killer DAT over the imp's MOV

                                                   imp trap
                                                      v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | MOV 0 1 | MOV 0 1 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
                                 ^__________|

Oh noes!  The Imp executes the DAT and dies.

                            XXX imp XXX
                                 v
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----
     .. | MOV 0 1 | MOV 0 1 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
    ----+---------+---------+---------+---------+-----------+--------+---------+---------+----

### Further Instructions

For a full set of instructions, see the [Instruction Reference](Instruction Reference.md).

That gives you all you need to implement a basic bot.  For the more adventurous, read on..

# Additional Functionality

### Addressing modes

One thing that you'll need to be aware of to make a more complex bot is the addressing modes.  When you use a number, such as the -2 in 

    ADD -2, -1

It can refer to different things.  The main two addressing modes are immediate, where the number is a value, and direct, where the number represents an address.

Direct - adds fields at location 1 to fields at location 2:

    +---------+---------+-----------+
    | ADD 1 2 | DAT 1 2 | DAT 10 20 |
    +---------+---------+-----------+
    
      +---------+---------+-----------+
    = | ADD 1 2 | DAT 1 2 | DAT 11 22 |
      +---------+---------+-----------+
    
Immediate - adds the number 33 to the B field at location 2:

    +-----------+---------+-----------+
    | ADD #33 2 | DAT 1 2 | DAT 10 20 |
    +-----------+---------+-----------+
    
      +-----------+---------+-----------+
    = | ADD #33 2 | DAT 1 2 | DAT 10 53 |
      +-----------+---------+-----------+
      
If there's only a single value to work with, it defaults to operating on field B.  You can control this - see Instruction Modifiers, below.

Direct is the default addressing mode.  To make a value immediate, put a # in front of it in your source file:  

    ADD #33, 2

The next most important mode is Indirect, which gets an address from a different instruction, as indicated by the @ symbol in front of a number.  For example, in this ADD instruction:

    +---------+-----------+---------+-----------+
    | DAT 0 2 | ADD @-1 2 | DAT 1 2 | DAT 10 20 |
    +---------+-----------+---------+-----------+
    
The @-1 means 'take the address from the instruction at location -1':

    +---------+-----------+---------+-----------+
    | DAT 0 2 | ADD @-1 2 | DAT 1 2 | DAT 10 20 |
    +---------+-----------+---------+-----------+
            ^--------`
            
Therefore, the fields at location 2 (relative to the DAT instruction) get added to the fields at location 2 (relative to the ADD instruction):
    
      +---------+-----------+---------+-----------+
    = | DAT 0 2 | ADD @-1 2 | DAT 1 2 | DAT 11 22 |
      +---------+-----------+---------+-----------+

The other addressing modes are mainly variants on the Indirect mode - see [The beginner's guide to redcode](http://vyznev.net/corewar/guide.html) for details.

### Instruction Modifiers

By default, instructions work on both fields, if it makes sense for that instruction.  For example, adding two addresses adds both the A and B fields together:

    +---------+---------+-----------+
    | ADD 1 2 | DAT 1 2 | DAT 10 20 |
    +---------+---------+-----------+
    
      +---------+---------+-----------+
    = | ADD 1 2 | DAT 1 2 | DAT 11 22 |
      +---------+---------+-----------+
      
If you want, you can control the fields affected with instruction modifiers, e.g. just add the A fields together:

    +-----------+---------+-----------+
    | ADD.A 1 2 | DAT 1 2 | DAT 10 20 |
    +-----------+---------+-----------+
    
      +-----------+---------+-----------+
    = | ADD 1.A 2 | DAT 1 2 | DAT 11 20 |
      +-----------+---------+-----------+
      
To use an instruction modifier just use a full stop after the instruction:  

    ADD.A 1, 2
    
For a full set of instruction modifiers, see [The beginner's guide to redcode](http://vyznev.net/corewar/guide.html).
