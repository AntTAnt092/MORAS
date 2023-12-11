// Calculate base^exponent and store the result in R2

// Store base in R0 (assumed to be a non-negative integer)
@base
D=M
@R0
M=D

// Store exponent in R1 (assumed to be a non-negative integer)
@exponent
D=M
@R1
M=D

// Handle special case: exponent = 0, result = 1
@R1
D=M
@result_done
D;JEQ

// Initialize result (R2) to 1
@R2
M=1

// Perform the exponentiation using a loop
(POW_LOOP)
    // Multiply the current result (R2) by the base (R0)
    @R2
    D=M
    @R0
    M=D*M

    // Decrement the exponent (R1)
    @R1
    MD=M-1

    // Check if the exponent is greater than 0
    @POW_LOOP
    D;JGT

// Result is in R2
@result_done

@END
0;JMP
