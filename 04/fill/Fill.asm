// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(INIT)
@current
M=0

(LISTEN)
@KBD
D=M // Set D to keyboard input value
@SETBLACK
D;JNE // Set back if keyboard input
@SETWHITE
D;JEQ // Set white if keyboard input = 0

(SETBLACK)
@current
M=0
(LOOP)
@SCREEN
D=A // Set D=16384 
@current 
A=D+M // Set A to point to RAM[16384 + current]
M=-1
@current
M=M+1 // Increment current count here
D=M
@8192 // Last register index
D=D-A // D = (current - 8192)
@INIT
D;JEQ // If finish blackening screen, jump to INIT (reset current count) -> start listening to keyboard inputs again
@LOOP
0;JMP

(SETWHITE)
@current
D=M // Set D to current word index
@SCREEN
A=A+D // Set A to point to RAM[16384 + current]
M=0 // Set current RAM to 000000..
@INCR
0;JMP

(INCR)
@current 
M=M+1
D=M
@8192 // Last register index
D=D-A // D = (current - 8192)
@INIT
D;JEQ // If current # == 8192 (last register), jump to INIT (reset current count)
@LISTEN
0;JMP

