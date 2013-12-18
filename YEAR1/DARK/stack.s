############################################################
############################################################
##
## DESCRIPTION:	Computer Architecture 1 (DARK)
##		Assignment 1: Stack and Subroutines.
##
##
## AUTHOR(S):	Philip Åkerfeldt	philip.akerfeldt@gmail.com
##              Mikael Sernheim		mikael.sernheim@gmail.com
## 		Oliver Campeau		Olivercampeau93@gmail.com
##		
## HISTORY:	Arpil 29, 2013
##
############################################################
############################################################

############################################################
## Data Segment
############################################################
	.data
length:	.word 10
vector:	.word 1,2,3,4,5,6,7,8,9,10
NL:	.ascii "\n"

############################################################
## Text Segment
############################################################
	.text
	.globl main
#-----------------------------------------------------------
# Main Start
#-----------------------------------------------------------
main:	
	add	$s0,$sp,$zero
	lw	$t0,length	# loads the amount of numbers
	la	$t5,vector	# load the adress of the vector to t5
	add	$t4,$zero,$zero	# Create a counter	
	loop:	
		lw	$t1,($t5)	# Puts next number from the vector to t1.
		subi	$sp,$sp,4	# Create space in the stack
		sw	$t1,0($sp)	# Put t1 on the stack
		addi	$t5,$t5,4	# Increase the adress by 4 to next word.
		addi	$t4,$t4,1	# Increase the counter
		beq	$t0,$t4,end	# counter==amount of numbers Goto end
		j	loop
	
	end:
	subi	$sp,$sp,4	# Create space in the stack
	sw	$t0,0($sp)	# Put t0 on the stack
	
	jal	sum_1		# call sum_1
	add	$sp,$s0,$zero	# restore the stack
	add	$a0, $v1, $zero	# integer to print, the total sum
	li	$v0, 1 		# system call code for print_int
	syscall			# print the integer

	## print new-line
	li	$v0, 4		# system call for print_str
	la	$a0, NL		# address of string to print
	syscall			# print the string
 
	lw	$a0,length	# Put the amount of numbers in argument 0
	la	$a1,vector	# Put the adress of the first number in argument 1

	jal	sum_2		# call sum_2
	add	$a0, $v1, $zero	# integer to print, the total sum
	li	$v0, 1 		# system call code for print_int
	syscall			# print the integer

#-----------------------------------------------------------
# Main End
#-----------------------------------------------------------


#-----------------------------------------------------------
# PROCEDURE:	sum_1
#
# DESCRIPTION:	This procedure returns the total sum for
#		given numbers. All numbers are passed to this
#		subroutine via the stack.
#
# INPUT: 	All numbers are placed on the stack. The top
#		of the stack contains the amount of numbers
#		to sum.
#
# OUTPUT:	$v1 - the total sum
#-----------------------------------------------------------
sum_1:	addi	$v1, $zero, 0	# $v1 = sum = 0
	
	addi	$t5,$zero,1	# Counter
	lw	$t0,($sp) 	# Amount of numbers 
	
	addi	$sp,$sp,4	# Pop stack
	lw	$t1,($sp)	# put the first number in t1
	addi	$sp,$sp,4	# Pop stack

	loop1:
		beq	$t5,$t0,end1	# counter==amount of numbers Goto end	
		lw	$t2,($sp)		# put next number in t2
		addi	$sp,$sp,4	# Pop stack
		add	$t1,$t1,$t2	# add the new number to the sum
		
		
		addi	$t5,$t5,1	# increase counter
		j 	loop1		# continue loop
	
	
	end1:	add	$v1,$t1,$zero
		jr	$ra		# return to caller


#-----------------------------------------------------------
# PROCEDURE:	sum_2
#
# DESCRIPTION:	This procedure returns the total sum for
#		given numbers. All numbers are passed to the
#		subroutine via a special/standard MIPS-
#		registers for parameter passing.
#
# INPUT: 	$a0 - the amount of numbers to sum
#		$a1 - the start address of given numbers
#
# OUTPUT:	$v1 - the total sum
#-----------------------------------------------------------
sum_2:	addi	$v1, $zero, 0	# $v1 = sum = 0
	add	$t5,$a1,$zero	# puts the adress of the first number in t5
	add	$t4,$zero,$zero	# Create a counter	
	add	$t1,$zero,$zero	# resets t1
	loop2:	
		lw	$t2,($t5)	# Puts next number in t2
		add	$t1,$t1,$t2	# Adds t2 to the sum
		addi	$t5,$t5,4	# increase the pointer
		addi	$t4,$t4,1	# increase counter
		beq	$t4,$a0,end2	# counter==amount of numbers Goto end2
		j	loop2		# continue the loop

	end2:
	add	$v1,$t1,$zero		# put the sum in v1
	jr	$ra		# return to caller

#-----------------------------------------------------------
# PROCEDURE:	fibon
#
# DESCRIPTION:	This procedure returns the nth number
#		of fibonacci sequence
#
# INPUT: 	$a0 - the order (n)
#
# OUTPUT:	$v1 - the number
#-----------------------------------------------------------

fibon:	
	### ... write your code here ...

	jr	$ra		# return to caller


############################################################
############################################################
## 
## ANSWERS:	
##	
## 2: The stack before the sum_1 call top -> bottom is:
##		5 (length)
##		5
##		4
##		3
##		2
##		1
##		$ra
##			
## 4:	Because the caller expects the registers s0-s7 and ra to be unchanged.
##	To provide space for future local variables.
##
##
## 5:	$ra from beginning = 0x0000 0000
##
##
##
##
##
##
##
##
##
##
##
##
##
############################################################
############################################################
