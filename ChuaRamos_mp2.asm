.include "macro.asm"

.data
filename1:   .asciz "pokemon_type1.bin"       # File name of the input file
filename2:   .asciz "pokemon_type2.bin"       # File name of the input file
type1: .space 4096 #this buffer holds the type1 in the file
type2: .space 4096 #this buffer holds the type2 in the file
pokemon1: .float 0.0 #this holds the strength value of pokemon1
pokemon2: .float 0.0 #this holds the strength value of pokemon2
temppokemon1: .float 0.0 #this holds the temp strength value of pokemon1
temppokemon2: .float 0.0 #this holds the temp strength value of pokemon2
msg0: .asciz "pokemon_type1.bin file status: "
msg1: .asciz "pokemon_type2.bin file status: "
msg2: .asciz "Pokemon1 type 1 and 2: "
msg3: .asciz "Pokemon2 type 1 and 2: "
msg4: .asciz " "
msg5: .asciz "Winner: "
msg6: .asciz "Pokemon1: "
msg7: .asciz "Pokemon2: "

#600 max index
# 0 is starting pokemon

.text
.globl main

main:

la a0, filename1           # Load address of the filename
li a1, 0                  # Read-only mode (O_RDONLY)          
li a7, 1024               # Syscall number for open
ecall
mv s0, a0                 # Store file descriptor in s0

mv a0, s0
la a1, type1		#type1 now stores the file pointer reader of the file
li a2, 4096
li a7, 63
ecall
mv s1, a0                 #store the bytes read to S1

la a0, filename2           
li a1, 0                          
li a7, 1024               
ecall
mv s2, a0                 

mv a0, s2
la a1, type2
li a2, 4096
li a7, 63
ecall
mv s3, a0                 #store the bytes read to S3

PRINT_STRING(msg0)
PRINT_DEC(s0)
NEWLINE
PRINT_STRING(msg1)
PRINT_DEC(s2)
NEWLINE
NEWLINE

####################################################################################################

li s7, 4 # s7 contains 4

GET_DEC(s4)
GET_DEC(s5)

mv x3, s4
mv x4, s5

addi s4, s4, -1 # adjust the index since starting is 0 in the binary files
addi s5, s5, -1 

mul s4, s4, s7 #s4 contains the index for type1

la s6, type1 #s6 contains the starting address of type1
add s8, s6, s4 #we offset the address of type1 by s4 placed in temporary address register s8
lb s9, 0(s8) # s9 now holds the type1 of pokemon 1

la s6, type2 #s6 contains the starting address of type1
add s8, s6, s4 #we offset the address of type1 by s4 placed in temporary address register s8
lb s10, 0(s8) # s10 now holds the type2 of pokemon 1

mul s5, s5, s7

la s6, type1 #s6 contains the starting address of type1
add s8, s6, s5 #we offset the address of type1 by s4 placed in temporary address register s8
lb s11, 0(s8) # s11 now holds the type1 of pokemon 2

la s6, type2 #s6 contains the starting address of type1
add s8, s6, s5 #we offset the address of type1 by s4 placed in temporary address register s8
lb s6, 0(s8) # s6 now holds the type2 of pokemon 2

la t0, pokemon1 #f0 houses the strength of pokemon 1
flw f0, 0(t0)

la t1, pokemon2 #f1 houses the strength of pokemon 2
flw f1, 0(t1)

la t2, temppokemon1 #f2 houses the strength of temp pokemon 1
flw f2, 0(t2)

la t3, temppokemon2 #f3 houses the strength of temp pokemon 2
flw f3, 0(t3)


BATTLE(f0, s9, s11)
BATTLE(f0, s9, s6)

BATTLE(f2, s10, s11)
BATTLE(f2, s10, s6)

BATTLE(f1, s11, s9)
BATTLE(f1, s11, s10)

BATTLE(f3, s6, s9)
BATTLE(f3, s6, s10)

# This prints the type1 and 2 of pokemon1 and type1 and 2 of pokemon2 respectively 
NEWLINE
PRINT_STRING(msg2)
PRINT_FLOAT(f0)
PRINT_STRING(msg4)
PRINT_FLOAT(f2)

NEWLINE
PRINT_STRING(msg3)
PRINT_FLOAT(f1)
PRINT_STRING(msg4)
PRINT_FLOAT(f3)

COMPUTE(f0, f2)
COMPUTE(f1, f3)

#this prints the average values of pokemon1 and pokemon2 respectively
NEWLINE
NEWLINE
PRINT_STRING(msg6)
PRINT_FLOAT(f0)
NEWLINE
PRINT_STRING(msg7)
PRINT_FLOAT(f1)

NEWLINE
NEWLINE

feq.s t0, f0, f1
bne t0, x0, draw
flt.s t0, f1, f0
beq t0, x0, pokemon2win
j pokemon1win

#prints the result
draw:
	li t0, -1
	PRINT_STRING(msg5)
	PRINT_DEC(t0)
	j end
	
pokemon1win:
	PRINT_STRING(msg5)
	PRINT_DEC(x3)
	j end
	
pokemon2win:
	PRINT_STRING(msg5)
	PRINT_DEC(x4)
	j end
	
end:
	mv a0, s0 #close the file
	li a7, 57
	ecall
	
	mv a0, s2 #close the file
	li a7, 57
	ecall
	
	li a7, 10
	ecall
	
