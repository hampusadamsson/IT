############################################################
############################################################
##
## DESCRIPTION:	Dark vt06 -- Ass #1
##
## AUTHOR(S):	... write your name(s) and e-mail(s) here ...
## 
## DATE:	February 13, 2006
## VERSION:	1.1
##
## CHANGE LOGG:	1.0 - initial release
##              1.1 - bug in the data segment was fixed
##
############################################################
############################################################

############################################################
## Data Segment
############################################################
	.data
buffer:	.space 80 # the place for the input-string
MSG1:	.asciiz "\nGe en addition:\n"
MSG2:	.asciiz "Summan är: "
MSG3:	.asciiz "Vill du göra en addition till? (j/n) "

### ... reserve your additional data here ...


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

	## The s0-register should contain the total sum
	addi	$s0, $zero, 0	# $s0 = the total sum = 0


	### ... write your code here ...


exit:	lw	$ra, 0($sp)	# restore return address
	addi	$sp, $sp, 4	# pop sp
	jr	$ra		# return to caller
#-----------------------------------------------------------
# Main End
#-----------------------------------------------------------


#-----------------------------------------------------------
# PROCEDURE:	check_string
#
# DESCRIPTION:	This procedure checks if the string contains
#		integers separated with a plus-signs, e.g,
#
#		   int+int+int+...+int
#
# INPUT: 	$a0 - the address of the string
#		$a1 - the length of the string
#
# OUTPUT:	$v0 = 1 if the string is invalid
#		$v0 = 0 if the string is valid
#-----------------------------------------------------------
check_string:

	### ... write your code here ...

	jr	$ra		# return to caller


#-----------------------------------------------------------
# PROCEDURE:	int_to_string
#
# DESCRIPTION:	This procedure converts an integer to a
#		string. It assumes that the string is large
#		enough for the number, and that the number
#		is smaller than 2147483648. The end-of-string
#		should be marked with a null-byte. The
#		maximum string length should though be 11
#		bytes.
#
# INPUT: 	$a0 - the number to be converted 
#		$a1 - the address of the string
#
# OUTPUT:	None.
#-----------------------------------------------------------
int_to_string:

	### ... write your code here ...

	jr	$ra		# return to caller