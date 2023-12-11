// Assume R0 contains the length of the field
@R0
D=M
@fieldLength
M=D

// Set the loop counter (i = fieldLength - 1)
@fieldLength
D=M
@i
M=D-1

(outerLoop)
    @i
    D=M
    @END
    D;JL     // If i < 0, exit the loop

    // Set the inner loop counter (j = 0)
    @j
    M=0

( innerLoop )
    @j
    D=M
    @fieldLength
    D=D-1
    @ENDINNER
    D;JG     // If j >= fieldLength, exit the inner loop

    // Load RAM[100 + j] into D
    @j
    D=M
    @100
    A=A+D
    D=M

    // Load RAM[100 + j + 1] into A
    @j
    D=M
    @1
    D=D+A
    @100
    A=A+D
    D=M

    // Compare current and next elements
    @R15
    M=D
    @R14
    M=M-1
    D=D-M
    @swap
    D;JGT    // If D > 0, go to swap

    // If not greater, continue to the next element
    @j
    M=M+1
    @innerLoop
    0;JMP

(swap)
    // Swap the elements
    @R15
    D=M
    @100
    A=A+D
    D=M
    @temp
    M=D     // temp = RAM[100 + j]

    @R14
    D=M
    @100
    A=A+D
    D=M
    @R15
    M=D     // RAM[100 + j] = RAM[100 + j + 1]

    @temp
    D=M
    @R14
    A=A+D
    M=D     // RAM[100 + j + 1] = temp

    // Move to the next element
    @j
    M=M+1

    // Go back to the inner loop
    @innerLoop
    0;JMP

(ENDINNER)
    // Move to the next iteration of the outer loop
    @i
    M=M-1
    @outerLoop
    0;JMP

(END)
    // End of the program
    @END
    0;JMP