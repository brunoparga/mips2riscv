# Use the multiplyThree subroutine to evaluate the following for various values
# of x and y:

# 5x^2 - 12xy + 6y^2

# The main method, in a loop, prompts the user for values of x and y and prints
# out the result. End the loop when the user enters zero for both x and y.

		.data

zeros:		.asciiz		"Please enter two numbers.\nEntering both values as zero exits.\n"
promptX:	.asciiz		"First, enter the value of x: "
promptY:	.asciiz		"Now please enter the value of y: "
result:		.asciiz		"The product is "
period:		.asciiz		".\n\n"
thanks:		.asciiz		"Thank you for using this program.\n"

# Register use
# $s0 -> X
# $s1 -> Y
# $s2 -> product

		.text
		.globl	main

main:
	# Ask the user for x and y
	li	$v0, 4
	la	$a0, zeros
	syscall

	li	$v0, 4
	la	$a0, promptX
	syscall

	li	$v0, 5
	syscall
	move 	$s0, $v0		# $s0 = x

	li	$v0, 4
	la	$a0, promptY
	syscall

	li	$v0, 5
	syscall
	move 	$s1, $v0		# $s1 = y

	or	$t0, $s0, $s1
	beqz	$t0, done

	# Calculate 5x^2
	li	$a0, 5
	move	$a1, $s0
	move	$a2, $s0

	jal	multiplyThree
	nop
	move	$s2, $v0		# $s2 = 5x^2

	# Calculate -12xy
	li	$a0, -12
	move	$a1, $s0
	move	$a2, $s1

	jal	multiplyThree
	nop
	add	$s2, $s2, $v0

	# Calculate 6y^2
	li	$a0, 6
	move	$a1, $s1
	move	$a2, $s1

	jal	multiplyThree
	nop
	add	$s2, $s2, $v0

	# Print the product
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 1
	move	$a0, $s2
	syscall

	li	$v0, 4
	la	$a0, period
	syscall

	j	main
	nop

done:
	li	$v0, 4
	la	$a0, thanks
	syscall

	li	$v0, 10
	syscall
