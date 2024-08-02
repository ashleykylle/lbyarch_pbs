.data
half: .float 0.5
zer0: .float 0.0
one: .float 1.0
two: .float 2.0
invalid: .float -1.0

.macro NEWLINE
	li a0, 10
	li a7, 11
	ecall
	.end_macro
	
.macro PRINT_DEC(%x)
	mv a0, %x
	li a7, 1
	ecall
	.end_macro
	
.macro PRINT_STRING(%s)
	la a0, %s
	li a7, 4
	ecall
	.end_macro
	
.macro PRINT_FLOAT(%x)
	fmv.s fa0, %x
	li a7, 2
	ecall
	.end_macro
	
.macro GET_DEC(%x)
	li a7, 5
	ecall
	mv %x, a0
	.end_macro
	
.macro GET_HALF(%x)
	la t1, half #f4 houses 0.5
	flw f4, 0(t1)

	la t2, zer0 #f5 houses 0.0
	flw f5, 0(t2)
	
	feq.s t3, f5, %x
	bne t3, x0, addhalf4
	j multhalf4
	
	addhalf4: #if the pokemon1 is 0 it adds .5 instead of multiplying
		fadd.s %x, %x, f4
		j end
	
	multhalf4:#if the pokemon1 is not 0 it multiplies .5 by itself
		fmul.s %x, %x, f4
		j end
		
	end:
		
	.end_macro
	
.macro GET_ONE(%x) #check this one it might cause memory issues since t1 is reused
	la t1, one #f4 houses 1.0
	flw f4, 0(t1)

	la t2, zer0 #f5 houses 0.0
	flw f5, 0(t2)
	
	feq.s t3, f5, %x
	bne t3, x0, addone
	j multone
	
	addone: #if the pokemon1 is 0 it adds 1.0 instead of multiplying
		fadd.s %x, %x, f4
		j end
	
	multone:#if the pokemon1 is not 0 it multiplies 1.0 by itself
		fmul.s %x, %x, f4
		j end
		
	end:
		
	.end_macro
	
.macro GET_TWO(%x) #check this one it might cause memory issues since t1 is reused
	la t1, two #f4 houses 1.0
	flw f4, 0(t1)
	
	la t2, zer0 #f5 houses 0.0
	flw f5, 0(t2)
	
	feq.s t3, f5, %x
	bne t3, x0, addtwo
	j multtwo
	
	addtwo: #if the pokemon1 is 0 it adds 1.0 instead of multiplying
		fadd.s %x, %x, f4
		j end
	
	multtwo:#if the pokemon1 is not 0 it multiplies 1.0 by itself
		fmul.s %x, %x, f4
		j end
		
	end:
		
	.end_macro
	
.macro GET_ZERO(%x)
	la t2, zer0 #f5 houses 0.0
	flw f5, 0(t2)
	
	fmul.s %x, %x, f5
	
	.end_macro
	
.macro BATTLE(%strength, %type1, %type2)

	li t5, 0
	beq %type1, t5, normal
	li t5, 1
	beq %type1, t5, fighting
	li t5, 2
	beq %type1, t5, flying
	li t5, 3
	beq %type1, t5, poison
	li t5, 4
	beq %type1, t5, ground
	li t5, 5
	beq %type1, t5, rock
	li t5, 6
	beq %type1, t5, bug
	li t5, 7
	beq %type1, t5, ghost
	li t5, 8
	beq %type1, t5, steel
	li t5, 9
	beq %type1, t5, fire
	li t5, 10
	beq %type1, t5, water
	li t5, 11
	beq %type1, t5, grass
	li t5, 12
	beq %type1, t5, electric
	li t5, 13
	beq %type1, t5, psychic
	li t5, 14
	beq %type1, t5, ice
	li t5, 15
	beq %type1, t5, dragon
	li t5, 16
	beq %type1, t5, dark
	li t5, 17
	beq %type1, t5, fairy
	li t5, 99
	beq %type1, t5, none
	

	half:
		GET_HALF(%strength)
		j end
	zer0:
		GET_ZERO(%strength)
		j end
	one:
		GET_ONE(%strength)
		j end
		
	two:
		GET_TWO(%strength)
		j end
	
	normal: #truth table for normal type
		li t4, 5
		beq %type2, t4, half
		li t4, 7
		beq %type2, t4, zer0
		li t4, 8
		beq %type2, t4, half
		j one
		
	fighting: #truth table for fighting type
		li t4, 0
		beq %type2, t4, two
		li t4, 2
		beq %type2, t4, half
		li t4, 3
		beq %type2, t4, half
		li t4, 5
		beq %type2, t4, two
		li t4, 6
		beq %type2, t4, half
		li t4, 7
		beq %type2, t4, zer0
		li t4, 8
		beq %type2, t4, two
		li t4, 13
		beq %type2, t4, half
		li t4, 14
		beq %type2, t4, two
		li t4, 16
		beq %type2, t4, two
		li t4, 17
		beq %type2, t4, half
		j one
		
	flying: #truth table for flying type
		li t4, 1
		beq %type2, t4, two
		li t4, 5
		beq %type2, t4, half
		li t4, 6
		beq %type2, t4, two
		li t4, 8
		beq %type2, t4, half
		li t4, 11
		beq %type2, t4, two
		li t4, 12
		beq %type2, t4, half
		j one
		
	poison: #truth table for poison type
		li t4, 3
		beq %type2, t4, half
		li t4, 4
		beq %type2, t4, half
		li t4, 5
		beq %type2, t5, half
		li t4, 7
		beq %type2, t4, half
		li t4, 8
		beq %type2, t4, zer0
		li t4, 11
		beq %type2, t4, two
		li t4, 17
		beq %type2, t4, two
		j one	
		
	ground: #truth table for ground type
		li t4, 2
		beq %type2, t4, zer0
		li t4, 3
		beq %type2, t4, two
		li t4, 5
		beq %type2, t4, two	
		li t4, 6
		beq %type2, t4, half
		li t4, 8
		beq %type2, t4, two
		li t4, 9
		beq %type2, t4, two
		li t4, 11
		beq %type2, t4, half
		li t4, 12
		beq %type2, t4, two
		j one
		
	rock: #truth table for rock type
		li t4, 1
		beq %type2, t4, half
		li t4, 2
		beq %type2, t4, two
		li t4, 4
		beq %type2, t4, half
		li t4, 6
		beq %type2, t4, two
		li t4, 8
		beq %type2, t4, half
		li t4, 9
		beq %type2, t4, two
		li t4, 14
		beq %type2, t4, two
		j one
		
	bug: #truth table for bug type
		li t4, 1
		beq %type2, t4, half
		li t4, 2
		beq %type2, t4, half
		li t4, 3
		beq %type2, t4, half
		li t4, 7
		beq %type2, t4, half
		li t4, 8
		beq %type2, t4, half
		li t4, 9
		beq %type2, t4, half
		li t4, 11
		beq %type2, t4, two
		li t4, 13
		beq %type2, t4, two
		li t4, 16
		beq %type2, t4, two
		li t4, 17
		beq %type2, t4, half
		j one
		
	ghost: #truth table for ghost type
		li t4, 0
		beq %type2, t4, zer0
		li t4, 7
		beq %type2, t4, two
		li t4, 13
		beq %type2, t4, two
		li t4, 16
		beq %type2, t4, half
		j one
		
	steel: #truth table for steel type
		li t4, 5
		beq %type2, t4, two
		li t4, 8
		beq %type2, t4, half
		li t4, 9
		beq %type2, t4, half
		li t4, 10
		beq %type2, t4, half
		li t4, 12
		beq %type2, t4, half
		li t4, 14
		beq %type2, t4, two
		li t4, 17
		beq %type2, t4, two
		j one
		
	fire: #truth table for fire type
		li t4, 5
		beq %type2, t4, half
		li t4, 6
		beq %type2, t4, two
		li t4, 8
		beq %type2, t4, two
		li t4, 9
		beq %type2, t4, half
		li t4, 10
		beq %type2, t4, half
		li t4, 11
		beq %type2, t4, two
		li t4, 14
		beq %type2, t4, two
		li t4, 15
		beq %type2, t4, half
		j one
		
	water: #truth table for water type
		li t4, 4
		beq %type2, t4, two
		li t4, 5
		beq %type2, t4, two
		li t4, 9
		beq %type2, t4, two
		li t4, 10
		beq %type2, t4, half
		li t4, 11
		beq %type2, t4, half
		li t4, 15
		beq %type2, t4, half
		j one
		
	grass: #truth table for grass type
		li t4, 2
		beq %type2, t4, half
		li t4, 3
		beq %type2, t4, half
		li t4, 4
		beq %type2, t4, two
		li t4, 5
		beq %type2, t4, two
		li t4, 6
		beq %type2, t4, half
		li t4, 8
		beq %type2, t4, half
		li t4, 9
		beq %type2, t4, half
		li t4, 10
		beq %type2, t4, two
		li t4, 11
		beq %type2, t4, half
		li t4, 15
		beq %type2, t4, half
		j one
		
	electric: #truth table for electric type
		li t4, 2
		beq %type2, t4, two
		li t4, 4
		beq %type2, t4, zer0
		li t4, 10
		beq %type2, t4, two
		li t4, 11
		beq %type2, t4, half
		li t4, 12
		beq %type2, t4, half
		li t4, 15
		beq %type2, t4, half
		j one
		
	psychic: #truth table for psychic type
		li t4, 1
		beq %type2, t4, two
		li t4, 3
		beq %type2, t4, two
		li t4, 8
		beq %type2, t4, half
		li t4, 13
		beq %type2, t4, half
		li t4, 16
		beq %type2, t4, zer0
		j one
		
	ice: #truth table for ice type
		li t4, 2
		beq %type2, t4, two
		li t4, 4
		beq %type2, t4, two
		li t4, 8
		beq %type2, t4, half
		li t4, 9
		beq %type2, t4, half
		li t4, 10
		beq %type2, t4, half
		li t4, 11
		beq %type2, t4, two
		li t4, 14
		beq %type2, t4, half
		li t4, 15
		beq %type2, t4, two
		j one
		
	dragon: #truth table for dragon type
		li t4, 8
		beq %type2, t4, half
		li t4, 15
		beq %type2, t4, two
		li t4, 17
		beq %type2, t4, zer0
		j one
		
	dark: #truth table for dark type
		li t4, 1
		beq %type2, t4, half
		li t4, 7
		beq %type2, t4, two
		li t4, 13
		beq %type2, t4, two
		li t4, 16
		beq %type2, t4, half
		li t4, 17
		beq %type2, t4, half
		j one
		
	fairy: #truth table for fairy type
		li t4, 1
		beq %type2, t4, two
		li t4, 3
		beq %type2, t4, half
		li t4, 8
		beq %type2, t4, half
		li t4, 9
		beq %type2, t4, half
		li t4, 15
		beq %type2, t4, two
		li t4, 16
		beq %type2, t4, two
		j one
		
	none:
		la t1, invalid
		flw %strength, 0(t1) #replaces the value in strength to -1.0 indicating there is no type
	
	end:
	
	.end_macro
	
.macro COMPUTE(%strength1, %strength2)

	la t1, invalid
	flw, f4, 0(t1)
	
	la t2, two
	flw f5, 0(t2)
	
	feq.s t3, f4, %strength2
	beq t3, x0, avg
	j end
	
	avg:
		fadd.s %strength1, %strength1, %strength2
		fdiv.s %strength1, %strength1, f5
		j end
		
		
	end:
	
	.end_macro
		
	
	
		
	
