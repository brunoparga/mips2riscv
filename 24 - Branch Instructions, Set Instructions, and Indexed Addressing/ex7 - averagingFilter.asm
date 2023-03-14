# Write a program that processes an array by applying an averaging filter to it.
# An averaging filter works like this: create a new array where each element at
# index J is the average of the three elements from the old array at indexes
# J-1, J, and J+1.

		.data
size:		.word		12
array:		.word		50, 53, 52, 49, 48, 51, 99, 45, 53, 47, 47, 50
result:		.word		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
arrayLabel:	.asciiz		"Original array: ["
comma:		.asciiz		", "
newline:	.asciiz		"]\n"
resultLabel:	.asciiz		"Filtered array: ["

# In the above, the second element of the result is the average of 50, 53, and 52.
# The first and last elements of the new array are copies of the corresponding
# first and last elements of the old array.

# After processing, write the old and new arrays to the monitor.

# Register use
# $t0 -> array size - 1
# $t1 -> counter
# $t2 -> nth element
# $t3 -> n+1th element
# $t4 -> n+2th element
# $t5 -> accumulator for average

		.text

main:
	lw	$t0, size
	li	$t1, 0
	beq	$t0, $zero, done

	# copy the first element
	lw	$t2, array($t1)
	sw	$t2, result($t1)	# multiple basic instructions means no load delay
	addu	$t1, 1			# to give the first element a different treatment
	sub	$t0, $t0, 1		# to give the last element a different treatment

loop:
	beq	$t1, $t0, lastElement
	li	$t5, 0			# zero the accumulator

	# Load the three elements
	sub	$t1, $t1, 1		# pick the element before the current one
	mul	$t1, $t1, 4
	lw	$t2, array($t1)
	add	$t1, $t1, 8		# pick the element after the current one
	lw	$t3, array($t1)
	sub	$t1, $t1, 4		# right position to read and write
	lw	$t4, array($t1)		# this is the current one

	# average them
	add	$t5, $t5, $t2
	add	$t5, $t5, $t3
	add	$t5, $t5, $t4
	div	$t5, $t5, 3
	sw	$t5, result($t1)
	div	$t1, $t1, 4		# multiple basic instructions means no div delay
	b	loop
	add	$t1, $t1, 1


lastElement:
	mul	$t1, $t1, 4
	lw	$t2, array($t1)
	nop
	sw	$t2, result($t1)
	# div	$t1, $t1, 4		# not needed - will reset counter anyway

printArrayLabel:
	li	$v0, 4
	la	$a0, arrayLabel
	syscall
	li	$t1, 0

printArray:
	beq	$t1, $t0, printLastArray
	nop

	mul	$t1, $t1, 4
	lw	$a0, array($t1)
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, comma
	syscall

	div	$t1, $t1, 4
	b	printArray
	addu	$t1, $t1, 1

printLastArray:
	mul	$t1, $t1, 4
	lw	$a0, array($t1)
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, newline
	syscall

printResultLabel:
	li	$v0, 4
	la	$a0, resultLabel
	syscall
	li	$t1, 0

printResult:
	beq	$t1, $t0, printLastResult
	nop

	mul	$t1, $t1, 4
	lw	$a0, result($t1)
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, comma
	syscall

	div	$t1, $t1, 4
	b	printResult
	addu	$t1, $t1, 1

printLastResult:
	mul	$t1, $t1, 4
	lw	$a0, result($t1)
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, newline
	syscall

done:
	li	$v0, 10
	syscall
