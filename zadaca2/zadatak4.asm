@256
D=A
@SP
M=D

@BLACK
D=M
@R0
M=D

@128
D=A
@R1
M=D

@R1
D=M
@HORIZONTAL
D;JLT
@R0
A=M
M=D
@R0
D=M
@1
A=A+D
M=D

@R1
D=M
@VERTICAL
D;JLT
@R0
A=M
M=D
@R0
D=M
@256
A=A+D
M=D

@LOOP
0;JMP

(BLACK)
@0
D=A

(HORIZONTAL)
@128
D;JGT

(VERTICAL)
@256
D;JGT