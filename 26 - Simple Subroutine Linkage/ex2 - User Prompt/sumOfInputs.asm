# Computes the sum of a list of integers that the user enters. The user signals
# the end of input by typing "done".

		.data
prompt:		.asciiz		"Enter integers to know their sum. Hit 'done' to finish.\n"
invalid:	.asciiz		"Invalid number. Try again.\n"
sumIs:		.asciiz		"The sum is: "

# Register use:
# $s0 -> accumulates the sum

		.text
		.globl	main

main:
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$s0, 0

loop:
	jal	integerPrompt
	nop

	move	$t1, $v1
	beqz	$t1, handleError
	beq	$t1, 2, done		# got the word "done"
	nop
	j	loop
	add	$s0, $s0, $v0

handleError:
	li	$v0, 4
	la	$a0, invalid
	j	loop
	syscall

done:
	li	$v0, 4
	la	$a0, sumIs
	syscall

	move	$a0, $s0
	li	$v0, 1
	syscall

	li	$v0, 10
	syscall
