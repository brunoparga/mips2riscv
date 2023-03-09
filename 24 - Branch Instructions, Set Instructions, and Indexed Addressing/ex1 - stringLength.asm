# Write a program that repeatedly asks the user for a string and then calculates
# and prints out the string length. Stop the program when the string is empty
# (when the user hits "enter" without anything else on the line.)

# Be sure to reserve enough memory in the .data for the string. Use indexed
# addressing to scan through the string. Strings read in with the trap handler
# service include a '\n' character at the end, followed by the null termination.
# Don't count the '\n' or the null as part of the string length.

main:
	# Ask for text
	li	$v0, 4
	la	$a0, prompt
	syscall

	# Get user input
	li	$v0, 8
	la	$a0, string
	la	$a1, 2000
	syscall

	# Calculate string length
	la	$t0, string
	li	$t1, 0		# pointer

findLength:
	lb	$t2, string($t1)
	addu	$t1, 1
	bnez	$t2, findLength

printLength:
	# Print beginning of answer
	li	$v0, 4
	la	$a0, beginAnswer
	syscall

	# Print the character count
	subu	$a0, $t1, 2
	li	$v0, 1
	syscall

	# Print the rest of the message
	li	$v0, 4
	la	$a0, endAnswer

	bgt	$t1, 2,	main
	syscall

	li	$v0, 10
	syscall

		.data
prompt:		.asciiz		"Please enter text: "
string:		.space		2000
beginAnswer:	.asciiz		"Text length: "
endAnswer:	.asciiz		" characters.\n"
