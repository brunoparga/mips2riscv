# Declare an array of integers:

		.data
size:		.word		12
array:		.word		50, 12, 52, -78, 03, 12, 99, 32, 53, 77, 47, 00
askInt:		.asciiz		"Please enter the number to search for: "
failMsg:	.asciiz		"The number was not found in the array.\n"
succMsg:	.asciiz		"Found number "
atPos:		.asciiz		" at position "
inArray:	.asciiz		" in the array.\n"

# Write a program that repeatedly asks the user for an integer to search for.
# After the user enters the integer, the program scans through the array element
# by element looking for the integer. When it finds a match it writes a message
# and reports the index where the integer was found. If the integer is not in
# the array it writes a failure message.

# Register use:
# $t0 -> array size
# $t1 -> counter
# $t2 -> integer to look for (needle)
# $t3 -> array element

		.text

main:
	lw	$t0, size

mainLoop:
	# TODO: print the array
	li	$t1, 0		# counter
	li	$v0, 4
	la	$a0, askInt
	syscall

	li	$v0, 5
	syscall
	move	$t2, $v0

search:
	beq	$t1, $t0, failure

	mul	$t1, $t1, 4
	lw	$t3, array($t1)
	nop
	div	$t1, $t1, 4

	beq	$t3, $t2, success
	nop
	addu	$t1, $t1, 1
	b	search
	nop

failure:
	li	$v0, 4
	la	$a0, failMsg
	b	mainLoop
	syscall

success:
	li	$v0, 4
	la	$a0, succMsg
	syscall

	li	$v0, 1
	move	$a0, $t2
	syscall

	li	$v0, 4
	la	$a0, atPos
	syscall

	li	$v0, 1
	move	$a0, $t1
	syscall

	li	$v0, 4
	la	$a0, inArray
	b	mainLoop
	syscall
