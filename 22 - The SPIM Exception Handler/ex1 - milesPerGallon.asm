# Write a program that repeatedly prompts the user for the number of miles
# traveled and the gallons of gasoline consumed, and then prints out the miles per
# gallon. Use integer math. Exit when the user enters 0 for the number of miles.

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
	move	$t0, $v0

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

	# Print out result
	li	$v0, 4
	la	$a0, result
	syscall

	li	$v0, 1
	move	$a0, $t0
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
mpg:		.asciiz		" miles per gallon.\n\n"
goodbye:	.asciiz		"\nThank you for using this great program!"
