# Prompt the user for an integer. Read the string the user enters as a string
# (using trap handler service 8). Then, if the string forms a proper integer, it
# is converted to two's complement form and returned in register $v0.

# If the input was converted, set register $v1 to one. If the input was not
# converted, set register $v1 to zero, and set $v0 to zero. If the user enters
# "done", set register $v1 to two, and set $v0 to zero.

		.data
prompt:		.asciiz		"Please enter an integer: "
input:		.space		30

# Register use
# $t0 -> pointer into input string
# $t1 -> current character
# $t2 -> isNegative
# $t3 -> isLTEDigit9, isDigit
# $t4 -> temp
# $t5 -> isGTEDigit0
# $t6 -> number
# $t7 -> 10, to multiply each digit
# $t8 -> -1, to make the number negative if needed

		.text
		.globl	integerPrompt

integerPrompt:
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 8
	la	$a0, input
	li	$a1, 30
	syscall

	# Initialize string pointer and sign flag
	li	$t0, 0
	li	$t2, 0

	# Initialize constants
	li	$t7, 10
	li	$t8, -1

isDone:
	lb	$t1, input($t0)
	addu	$t0, 1
	bne	$t1, 0x64, checkNegative
	lb	$t1, input($t0)
	addu	$t0, 1
	bne	$t1, 0x6F, checkNegative
	lb	$t1, input($t0)
	addu	$t0, 1
	bne	$t1, 0x6E, checkNegative
	lb	$t1, input($t0)
	nop
	bne	$t1, 0x65, checkNegative
	nop
	li	$v0, 0
	jr	$ra
	li	$v1, 2

checkNegative:
	bne	$t1, 0x2D, checkFirstDigit
	subu	$t0, 1			# if positive, decrement pointer
	li	$t2, 1
	addu	$t0, 1			# if negative, advance pointer back

checkFirstDigit:
	lb	$t1, input($t0)
	li	$t4, 0x2F
	slti	$t3, $t1, 0x3A		# char is less than or equal to '9'
	slt	$t5, $t4, $t1		# char is greater than or equal to '0'
	and	$t3, $t3, $t5		# char is a digit
	beqz	$t3, notANumber
	subu	$t6, $t1, 0x30		# char is the correct integer

checkDigits:
	addu	$t0, 1
	lb	$t1, input($t0)
	li	$t4, 0x2F
	slti	$t3, $t1, 0x3A		# char is less than or equal to '9'
	slt	$t5, $t4, $t1		# char is greater than or equal to '0'
	and	$t3, $t3, $t5		# char is a digit
	beqz	$t3, negativize
	nop
	mul	$t6, $t6, $t7		# multiply current number by 10
	subu	$t1, $t1, 0x30		# char is the correct integer
	j	checkDigits
	add	$t6, $t6, $t1

negativize:
	beqz	$t2, returnNumber
	li	$t8, -1
	mul	$t6, $t6, $t8

returnNumber:
	move	$v0, $t6
	jr	$ra
	li	$v1, 1

notANumber:
	li	$v0, 0
	jr	$ra
	li	$v1, 0

