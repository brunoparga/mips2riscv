# Write a program that repeatedly asks the user for two strings. The strings are
# placed in separate buffers in memory. Now, in a third buffer, create a string
# that is the concatenation of the two strings. Print out the new string.

# The input strings will be terminated with "\n\0". Don't include these
# characters in the middle of the concatenated string.

main:
	# Initialize constants
	li	$t1, 0		# first and concat string pointer
	li	$t2, 0		# second string pointer

	# Ask for first string
	li	$v0, 4
	la	$a0, prompt1
	syscall

	# Get user input
	li	$v0, 8
	la	$a0, string1
	la	$a1, 100
	syscall

	# Ask for second string
	li	$v0, 4
	la	$a0, prompt2
	syscall

	# Get user input
	li	$v0, 8
	la	$a0, string2
	la	$a1, 100
	syscall

copyFirst:
	lb	$t0, string1($t1)
	nop
	beq	$t0, 0xa, copySecond
	nop
	sb	$t0, concat($t1)
	b	copyFirst
	addu	$t1, 1

copySecond:
	lb	$t0, string2($t2)
	nop
	beq	$t0, 0xa, done
	nop
	sb	$t0, concat($t1)
	addu	$t1, 1
	b	copySecond
	addu	$t2, 1

done:
	li	$v0, 4
	la	$a0, concat
	syscall

	li	$v0, 4
	la	$a0, newline
	b	main
	syscall

		.data
prompt1:	.asciiz		"Please enter the first string: "
prompt2:	.asciiz		"Please enter the second string: "
string1:	.space		100
string2:	.space		100
concat:		.space		200
newline:	.asciiz		"\n"
