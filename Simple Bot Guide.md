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

This is the key to victory - your main goal is to kill another bot by making it execute a DAT instruction, using methods which will be described shortly.  There are other ways to win, but t his is the main one.

         |
         v
    +---------+-----------+--------+----
    | MOV 0 5 | SEQ -1 -2 | JMP -2 | ..
    +---------+-----------+--------+----

                    |
                    v
    +---------+-----------+--------+----
    | MOV 0 5 | SEQ -1 -2 | JMP -2 | ..
    +---------+-----------+--------+----

                    |
                    v
    +---------+-----------+---------+----
    | MOV 0 5 | SEQ -1 -2 | DAT 0 0 | ..
    +---------+-----------+---------+----

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

And so on, repeatedly copying it's single instruction until the game ends (typically after 8000 cycles) or another bot kills it.

So certainly a simple bot, but not particularly good at killing other bots.  Which leads onto..

## Example Bot - Imp Trap

Here is another simple bot, with a single purpose in life - killing Imps:

            ORG loop

            DAT  9,  9 ; number 9 not important - just for illustrative purposes
    loop:   MOV -1, -2
            JMP -1

This file includes a couple of things in addition to the instructions:

  * ORG: tells the compiler which instruction to start on
  * ; a comment
  * loop: a label
        
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

The next instrution executed is a JMP, which causes execution to jump to another location - in this case back two places, causing a loop

                                                             |
                                                             v
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
 .. | DAT 0 0 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
----+---------+---------+---------+---------+-----------+--------+---------+---------+----

                                                  |
                                                  v
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
 .. | DAT 0 0 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
----+---------+---------+---------+---------+-----------+--------+---------+---------+----

And this will keep going until the game ends, copying the DAT instruction to location -2.

But look what happens when an Imp comes along (each bot takes one instruction at a time):

The Imp copies his MOV forward

imp
 v
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
 .. | MOV 0 1 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
----+---------+---------+---------+---------+-----------+--------+---------+---------+----

The Imp Trap continues copying his DAT backwards

                                                trap
                                                  v
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
 .. | MOV 0 1 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
----+---------+---------+---------+---------+-----------+--------+---------+---------+----

        imp
         v
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
 .. | MOV 0 1 | MOV 0 1 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
----+---------+---------+---------+---------+-----------+--------+---------+---------+----

                                                           trap
                                                             v
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
 .. | DAT 0 0 | DAT 0 0 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
----+---------+---------+---------+---------+-----------+--------+---------+---------+----

The Imp copies his MOV over the DAT... right into the trap!

                   imp
                    v
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
 .. | MOV 0 1 | MOV 0 1 | MOV 0 1 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
----+---------+---------+---------+---------+-----------+--------+---------+---------+----

The Imp Trap copies his killer DAT over the imp's MOV

                                                trap
                                                  v
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
 .. | MOV 0 1 | MOV 0 1 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
----+---------+---------+---------+---------+-----------+--------+---------+---------+----

Oh noes!  The Imp executes the DAT and dies.

                        XXX imp XXX
                             v
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
 .. | MOV 0 1 | MOV 0 1 | DAT 9 9 | DAT 9 9 | MOV -1 -2 | JMP -1 | DAT 0 0 | DAT 0 0 | .. 
----+---------+---------+---------+---------+-----------+--------+---------+---------+----
