# As in Exercise 1, write a program that repeatedly prompts the user for the
# number of miles traveled and the gallons of gasoline consumed, and then prints
# out the miles per gallon. Exit when the user enters 0 for the number of miles.

# Use fixed-point arithmetic for this. Multiply input value of miles by 100.
# Divide miles by gallons to get miles per gallon. The answer will 100 times too
# large. So divide it by 100 to get whole miles per gallon in lo and hundredths
# in hi. Print out lo followed by "." followed by hi to get an output that
# looks like: "32.45 mpg".


		.text
		.globl	main

main:
	# Prompt for miles
	li	$v0, 4
	la	$a0, prompt1
	syscall

	# Get miles
	li	$v0, 5
	syscall

	beq	$v0, $zero, done
	li	$t2, 1000
	mult	$t2, $v0
	mflo	$t0		# $t0 = millimiles driven

	# Prompt for gallons
	li	$v0, 4
	la	$a0, prompt2
	syscall

	# Get gallons
	li	$v0, 5
	syscall
	move	$t1, $v0

	# Calculate mpg
	divu	$t0, $t1
	mflo	$t0
	nop
	nop
	divu	$t0, $t2	# mpg with high precision
	mfhi	$t1
	mflo	$t0

	# Print out result
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 4
	la	$a0, dot
	syscall

	li	$v0, 1
	move	$a0, $t1
	syscall

	li	$v0, 4
	la	$a0, mpg
	j	main
	syscall

done:
	li	$v0, 4
	la	$a0, goodbye
	syscall
	li	$v0, 10
	syscall

		.data
prompt1:	.asciiz		"Please enter the number of miles driven: "
prompt2:	.asciiz		"Please enter the number of gallons consumed: "
result:		.asciiz		"The consumption was "
dot:		.asciiz		"."
mpg:		.asciiz		" miles per gallon.\n\n"
goodbye:	.asciiz		"\nThank you for using this even greater program!"
