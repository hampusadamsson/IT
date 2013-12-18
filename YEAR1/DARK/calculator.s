############################################################
############################################################
##
## DESCRIPTION:	DarkDT vt08 -- Ass #2
##
## AUTHOR(S):	Mikael Sernheim mikael.sernheim@gmail.com
##		Josef Svensson josef.svensson@hotmail.com
##		Oliver Campeau olivercampeau93@gmail.com
##
## RUN:		xspim -mapped_io -file calculator.s                          
## 
##		or
##
##		spim -mapped_io -file calculator.s   
##
## DATE:	February 18, 2008
## VERSION:	1
##
## CHANGE LOGG:	1.0 - second release
##
############################################################
############################################################

############################################################
## Data Segment
############################################################
	.data

# Memory mapped I/0, i.e., each I/O device register appears as a
# special memory location. These addresses are to large to use
# as an immediate value so we store them as "constants" in memory.
	
RECEIVER_CONTROL:	.word 0xffff0000	
RECEIVER_DATA:		.word 0xffff0004	

TRANSMITTER_CONTROL:	.word 0xffff0008
TRANSMITTER_DATA:	.word 0xffff000c	


### ... reserve your data/variables here ...
buffer:		.space 80		
	

ExitMessage:		.asciiz "Good Bye!\n"

	
############################################################
## Text Segment
############################################################
	.text
	.globl main
#-----------------------------------------------------------
# Main Start
#-----------------------------------------------------------
main:	addi	$sp, $sp, -4	# make room for 1 item on stack
	sw	$ra, 0($sp)	# save return address
main3:	add	$s2,$s3,$zero
main2:	
#	addi 	$s6,$zero, 7
#	lw 	$s7 , RECEIVER_DATA
#	sw 	$s6 , ($s7)
#	addi 	$s6,$zero, 1
#	lw 	$s7 , RECEIVER_CONTROL
#	sw 	$s6 , ($s7)
	jal 	readCharacter

	addi	$t1, $zero, 1
	addi	$t2, $zero, 2
	addi	$t3, $zero, 3
	beq 	$v0, $zero, invalidInput
	beq	$v0, $t1, number
	beq	$v0, $t2, operand
	beq	$v0, $t3, command
	
number:	
	addi	$t0,$zero,10
	mult	$s0,$t0
	mflo	$s0
	add 	$s0,$s0,$v1
	j  	main2


operand:
	beq	$s2, $zero, operand2
	beq	$v1, $zero, doAdd
	beq	$v1, $t1, doSub
	beq	$v1, $t2, doMul
	j 	doDiv
	
operand2:
	add	$s1,$s0,$zero
	add	$s0,$zero,$zero
	add	$a0,$s1,$zero	
	beq	$v1, $zero, doAdd
	beq	$v1, $t1, doSub
	beq	$v1, $t2, doMul
	j 	doDiv
	
command:
	addi 	$t2, $zero, 45		# ascii for - 
	addi 	$t3, $zero, 43		# ascii for +
	addi 	$t4, $zero, 42		# ascii for *
	addi	$t1, $zero, 1
	addi	$t5, $zero, 2
	
	beq	$v1,$t1,reset
	beq	$v1,$t5,exit
	
	addi	$s4,$zero,1		
	beq	$s2,$t2, exSub
	beq	$s2,$t3, exAdd
	beq	$s2,$t4, exMul
	j	exDiv


ans:	addi	$t0,$zero,61
	subi	$sp, $sp, 4
	sw	$zero, ($sp)	#Null , så den  vet att ska sluta
	subi	$sp, $sp, 4
	sw	$t0, ($sp)	#Lägg in likamedtecken på stacken
	jal	printString
	add	$a0,$s1,$zero
	jal	int_to_string
	jal	printString	
	
reset:	add	$s0,$zero,$zero
	add	$s1,$zero,$zero
	add	$s2,$zero,$zero
	add	$s3,$zero,$zero
	add	$a0,$s1,$zero
	jal	int_to_string
	jal	printString		
	j	main2
doAdd:	
	addi 	$t2, $zero, 45		# ascii for - 
	addi 	$t3, $zero, 43		# ascii for +
	addi 	$t4, $zero, 42		# ascii for *
	addi	$t5, $zero, 10
	
	jal	int_to_string
	jal	printString
	addi 	$t0, $zero, 43	
	subi	$sp, $sp, 4	
	sw	$zero, ($sp)	#Null , så den  vet att ska sluta
	subi	$sp, $sp, 4
	sw	$t5, ($sp)	#Lägg in en radbrytning på stacken
	subi	$sp, $sp, 4
	sw	$t0, ($sp)	#Lägg in plustecknet på stacken
	jal	printString
	addi	$s3,$zero,43
	beq	$s2,$zero,main3
	beq	$s2,$t2, exSub
	beq	$s2,$t3, exAdd
	beq	$s2,$t4, exMul
	j	exDiv


exAdd:	add	$s1,$s1,$s0
	add	$s2,$zero,$s3
	beq	$s4,$zero,main2
	j	ans
		
	
	

doSub:	addi 	$t2, $zero, 45		# ascii for - 
	addi 	$t3, $zero, 43		# ascii for +
	addi 	$t4, $zero, 42		# ascii for *
	addi	$t5, $zero, 10
	
	jal	int_to_string
	addi 	$t0, $zero, 45
	subi	$sp, $sp, 4	
	sw	$zero, ($sp)	#Null , så den  vet att ska sluta
	subi	$sp, $sp, 4
	sw	$t5, ($sp)	#Lägg in en radbrytning på stacken
	subi	$sp, $sp, 4
	sw	$t0, ($sp)	#Lägg in plustecknet på stacken
	jal	printString
	addi	$s3,$zero,45
	beq	$s2,$zero,main3
	beq	$s2,$t2,exSub
	beq	$s2,$t3,exAdd
	beq	$s2,$t4,exMul
	j	exDiv

exSub: 	sub	$s1,$s1,$s0
	add	$s2,$zero,$s3
	beq	$s4,$zero,main2
	j	ans
	
doMul:	addi 	$t2, $zero, 45		# ascii for - 
	addi 	$t3, $zero, 43		# ascii for +
	addi 	$t4, $zero, 42		# ascii for *
	addi	$t5, $zero, 10
	
	jal	int_to_string
	addi 	$t0, $zero, 42
	subi	$sp, $sp, 4	
	sw	$zero, ($sp)	#Null , så den  vet att ska sluta
	subi	$sp, $sp, 4
	sw	$t5, ($sp)	#Lägg in en radbrytning på stacken
	subi	$sp, $sp, 4
	sw	$t0, ($sp)	#Lägg in plustecknet på stacken
	jal	printString
	addi	$s3,$zero,42
	beq	$s2,$zero,main3
	beq	$s2,$t2, exSub
	beq	$s2,$t3, exAdd
	beq	$s2,$t4, exMul
	j	exDiv

exMul:  mult	$s1,$s0
	mflo	$s1
	add	$s2,$zero,$s3
	beq	$s4,$zero,main2
	j	ans
	
doDiv:	addi 	$t2, $zero, 45		# ascii for - 
	addi 	$t3, $zero, 43		# ascii for +
	addi 	$t4, $zero, 42		# ascii for *
	addi	$t5, $zero, 10
	
	jal	int_to_string
	addi 	$t0, $zero, 47
	subi	$sp, $sp, 4	
	sw	$zero, ($sp)	#Null , så den  vet att ska sluta
	subi	$sp, $sp, 4
	sw	$t5, ($sp)	#Lägg in en radbrytning på stacken
	subi	$sp, $sp, 4
	sw	$t0, ($sp)	#Lägg in plustecknet på stacken
	jal	printString
	addi	$s3,$zero,47
	beq	$s2,$zero,main3
	beq	$s2,$t2, exSub
	beq	$s2,$t3, exAdd
	beq	$s2,$t4, exMul
	j	exDiv

exDiv:  div	$s1,$s0
	mflo	$s1
	add	$s2,$zero,$s3
	beq	$s4,$zero,main2
	j	ans


	
invalidInput:	


#-----------------------------------------------------------
# Main End
#-----------------------------------------------------------

#------------------------------------------------------------------------------
# PROCEDURE:	readCharacter
#
# DESCRIPTION:  Reads one character from the console using polled memory 
#		mapped I/O.
#
# INPUT:	None.
#
# OUTPUT:       $v0 - ASCII code of the character read from the console.
#------------------------------------------------------------------------------
readCharacter:
	
	# Check if the receiver is ready, if not,
	# simple spin and poll until ready.	
	
	lw	$t1, RECEIVER_CONTROL
	lw	$t0, ($t1)
	beq	$t0,$zero, readCharacter
	lw	$t0,RECEIVER_DATA
	lw 	$v0, ($t0)

	add 	$a0, $v0, $zero
	j 	parseCharacter
	
#------------------------------------------------------------------------------
# PROCEDURE:	printCharacter
#
# DESCRIPTION:  Print one character to the display using polled memory 
#		mapped I/O.
#
# INPUT:        $a0 - ASCII code to print
#
# OUTPUT:	None.
#------------------------------------------------------------------------------
printCharacter:

	# Check if the transmitter is ready, if not,
	# simple spin and poll until ready

	lw	$t1, TRANSMITTER_CONTROL
	lw	$t0, ($t1)
	beq	$t0,$zero, printCharacter
	lw	$t0,TRANSMITTER_DATA
	sw	$a0, ($t0)
	

	jr	$ra		# return to caller


#------------------------------------------------------------------------------
# PROCEDURE:	printString
#
# DESCRIPTION:  Print a null-terminated string to the display using polled memory 
#		the printCharacter subroutine.
#
# INPUT:        $a0 - Start address of the string to print.
#
# OUTPUT:	None.
#------------------------------------------------------------------------------
printString:

	# Since the subroutine calls another one, one needs to save 
	# the return address
	add	$t8,$ra,$zero
	
loop2:	
	lw 	$t1, ($sp)
	beq 	$t1,$zero end_printString
	add 	$a0, $zero, $t1
	jal 	printCharacter
	addi	$sp, $sp, 4
	j 	loop2 	

	
end_printString: 
	jr	$t8		# return to caller
	 

	
#------------------------------------------------------------------------------
# PROCEDURE:	parseCharacter
#
# DESCRIPTION:  Parses a given character and returns an appropriate value.
#
# INPUT:        $a0 - ASCII code of the character
#
# OUTPUT:	$v0 - Type of the character
#			- 0: Invalid
#			- 1: Number ($v1 will contain the value)
#			- 2: Operator ($v1 will contain the value)
#			- 3: Command ($v1 will contain the value)   
#		$v1 - Value of the character - Relevant in case $v0 = 1, 2 or 3
#			- $v0=1: The value of the number (not the ASCII code)
#			- $v0=2: - 0: <+>
#				 - 1: <->
#				 - 2: <*>
#				 - 3: </>
#			- $v0=3: - 0: <y> (Show result)
#				 - 1: <n> (Reset)
#				 - 2: <x> (Exit)					
#------------------------------------------------------------------------------
parseCharacter:
	
	# Check the content of the register a0
	# Take the appropriate action depending on a0 and according 
	# to the description above
	addi 	$t0, $zero, 57		# ascii for 9
	addi 	$t1, $zero, 48	 	# ascii for 0
	addi 	$t2, $zero, 45		# ascii for - 
	addi 	$t3, $zero, 43		# ascii for +
	addi 	$t4, $zero, 42		# ascii for *
	addi 	$t5, $zero, 47		# ascii for /
	addi 	$t6, $zero, 121		# ascii for y
	addi 	$t7, $zero, 110 	# ascii for n
	addi 	$t8, $zero, 120		# ascii for x
	
	beq  	$a0, $t3, op0
	beq  	$a0, $t2, op1
	beq  	$a0, $t4, op2
	beq  	$a0, $t5, op3
	beq  	$a0, $t6, co0
	beq  	$a0, $t7, co1
	beq  	$a0, $t8, co2
	bgt	$a0,$t0, invalid
	blt	$a0,$t1, invalid
	addi	$v0,$zero, 1
	subi	$v1,$a0,48
	jr	$ra
op0:	
	addi	$v0,$zero, 2	 
	addi	$v1,$zero, 0 
	jr	$ra		# return to caller
op1:	
	addi	$v0,$zero, 2	 
	addi	$v1,$zero, 1 
	jr	$ra		# return to caller
op2:	
	addi	$v0,$zero, 2	 
	addi	$v1,$zero, 2 
	jr	$ra		# return to caller
op3:	
	addi	$v0,$zero, 2	 
	addi	$v1,$zero, 3
	jr	$ra		# return to caller
co0:
	addi	$v0,$zero, 3	 
	addi	$v1,$zero, 0 
	jr	$ra		# return to caller
co1:
	addi	$v0,$zero, 3	 
	addi	$v1,$zero, 1 
	jr	$ra		# return to caller
co2:
	addi	$v0,$zero, 3	 
	addi	$v1,$zero, 2
	jr	$ra		# return to caller	
invalid:
	add	$v0,$zero,$zero
	jr	$ra	
	
#-----------------------------------------------------------
# PROCEDURE:	int_to_string
#
# DESCRIPTION:	This procedure converts an integer to a
#		string. It assumes that the string is large
#		enough for the number, and that the number
#		is smaller than 2147483648. The end-of-string
#		should be marked with a null-byte. The
#		maximum string length should though be 11
#		bytes (10 for digits + 1 for null-byte).
#
# INPUT: 	$a0 - the number to be converted 
#		$a1 - the address of the string
#
# OUTPUT:	None.
#-----------------------------------------------------------
int_to_string:

	addi	$t0,$zero,10
	subi	$sp,$sp,4
	sw	$zero,0($sp)	#puts a "NUL" on the stack
loop:		
	div 	$a0,$t0
	mflo	$t1
	addi 	$t1,$t1, 48
	subi	$sp,$sp,4
	sw	$t1,0($sp)
	mflo	$a0
	bne	$a0,$zero,loop

	j	printString




#-------------------------------------------------------------
exit:	