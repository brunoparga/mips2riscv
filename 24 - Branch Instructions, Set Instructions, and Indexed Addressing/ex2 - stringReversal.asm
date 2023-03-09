# Write a program that asks the user for a string. After reading the string into
# a buffer, copy it in reversed order to a second buffer. Write out the reversed
# string. End the program when the first string entered is empty (when it
# consists only of the end of line character.)

main:
	li	$t0, 0		# initialize traversal counter
	li	$t1, 0		# initialize reversal counter

	# Ask for text
	li	$v0, 4
	la	$a0, prompt
	syscall

	# Get user input
	li	$v0, 8
	la	$a0, string
	la	$a1, 2000
	syscall

	# Check if the input is empty
	lb	$t2, string($t0)
	nop
	beq	$t2, 0xa, done

traverse:
	# We move the pointer to the end of the string
	addu	$t0, $t0, 1
	lb	$t2, string($t0)
	nop
	bne	$t2, 0xa, traverse
	nop

reverse:
	# We move backwards along the string, reversing it as we go
	subu	$t0, $t0, 1
	lb	$t2, string($t0)
	nop
	sb	$t2, gnirts($t1)
	addu	$t1, $t1, 1
	bnez	$t2, reverse
	nop

printReversed:
	li	$v0, 4
	la	$a0, reversed
	syscall

	li	$v0, 4
	la	$a0, gnirts	# the word "string", reversed
	b	main
	syscall

done:
	li	$v0, 10
	syscall

		.data
prompt:		.asciiz		"\nPlease enter text: "
string:		.space		2000
gnirts:		.space		2000
reversed:	.asciiz		"Reversed string: "
