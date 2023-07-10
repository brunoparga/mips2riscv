# Combine the previous two programs:

# Write a program that evaluate the following for various values of u and v:

# 5u^2 - 12uv + 6v^2

# The values for u and v are prompted for in a loop. The user enters the values
# and the value of the expression is printed out. If illegal characters are entered
# for either u or v, print out an error message and continue.

# End the loop when the user enters "done" for the value of u.

		.data
prompt:		.asciiz		"Please enter two integers, or 'done' to compute."
promptX:	.asciiz		"\n\nFirst let's get X. "
promptY:	.asciiz		"Now please give me Y. "
invalid:	.asciiz		"Invalid number. Try again.\n"
expression:	.asciiz		"The value of 5x^2 - 12xy + 6y^2 is "
thanks:		.asciiz		"\nThank you for using this program.\n"

# Register use:
# $s0 -> Value of the expression
# $s1 -> U
# $s2 -> V

		.text
		.globl	main

main:
	li	$v0, 4
	la	$a0, prompt
	syscall

loop:
	li	$v0, 4
	la	$a0, promptX
	syscall

	jal	integerPrompt
	nop

	move	$t1, $v1
	beqz	$t1, handleErrorX
	beq	$t1, 2, done		# got the word "done"
	nop
	move	$s1, $v0

loopY:
	li	$v0, 4
	la	$a0, promptY
	syscall

	jal	integerPrompt
	nop

	move	$t1, $v1
	bne	$t1, 1, handleErrorY
	nop
	move	$s2, $v0

compute:
	# Calculate 5x^2
	li	$a0, 5
	move	$a1, $s1
	move	$a2, $s1

	jal	multiplyThree
	nop
	move	$s0, $v0

	# Calculate -12xy
	li	$a0, -12
	move	$a1, $s1
	move	$a2, $s2

	jal	multiplyThree
	nop
	add	$s0, $s0, $v0

	# Calculate 6y^2
	li	$a0, 6
	move	$a1, $s2
	move	$a2, $s2

	jal	multiplyThree
	nop
	add	$s0, $s0, $v0

	li	$v0, 4
	la	$a0, expression
	syscall

	li	$v0, 1
	move	$a0, $s0
	j	loop
	syscall

handleErrorX:
	li	$v0, 4
	la	$a0, invalid
	j	loop
	syscall

handleErrorY:
	li	$v0, 4
	la	$a0, invalid
	j	loopY
	syscall

done:
	li	$v0, 4
	la	$a0, thanks
	syscall

	li	$v0, 10
	syscall
