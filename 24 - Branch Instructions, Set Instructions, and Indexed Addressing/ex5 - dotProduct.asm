# Compute the dot product of two vectors. A vector is an array of integers. Both
# vectors are the same length. Ask the user for the length of the vectors. Then
# prompt for and read in the value of each element of each vector. Reserve space
# in memory for vectors of up to 10 elements, but allow vectors of any size one
# through 10.

		.data
vectorA:	.space		40    # space for 10 integers
vectorB:	.space		40    # space for 10 integers
askLength:	.asciiz		"Please enter the length of the vectors (<= 10): "
lineBreak:	.asciiz		"\n"
askElement:	.asciiz		"Please enter element "
ofVector:	.asciiz		" of vector "
a:		.asciiz		"A: "
bb:		.asciiz		"B: "
dotProduct:	.asciiz		"The dot product is "
period:		.asciiz		".\n"
testA:		.word		1, 2, 3, -5
testB:		.word		4, 5, 6, 7

# The dot product of two vectors is the sum of the product of the corresponding
# elements. For example, (1, 2, 3) dot (4, 5, 6) is 1*4 + 2*5 + 3*6.

# After computing it, write out the dot product to the monitor.

# Register use:
# $t0 -> vector length
# $t1 -> counter
# $t2 -> dot product
# $t3 -> vector A element
# $t4 -> vector B element
# $t5 -> current element product

	.text

main:
	li	$t1, 0
	li	$t2, 0

	li	$v0, 4
	la	$a0, askLength
	syscall

	li	$v0, 5
	syscall
	move	$t0, $v0	# $t0 holds the length of the vectors

	li	$v0, 4
	la	$a0, lineBreak
	syscall

getVectorA:
	beq	$t1, $t0, resetA

	# Get the $t1-th element of vectorA
	# Begin the sentence
	li	$v0, 4
	la	$a0, askElement
	syscall

	# print the number of the element we're at (starting at 1)
	li	$v0, 1
	addu	$a0, $t1, 1
	syscall

	# Complete the request sentence
	li	$v0, 4
	la	$a0, ofVector
	syscall

	li	$v0, 4
	la	$a0, a
	syscall

	# read the element
	li	$v0, 5
	syscall

	# store the element
	mul	$t1, $t1, 4
	sw	$v0, vectorA($t1)
	nop
	div	$t1, $t1, 4
	b	getVectorA
	addu	$t1, 1

resetA:
	li	$t1, 0
	li	$v0, 4
	la	$a0, lineBreak
	syscall

getVectorB:
	beq	$t1, $t0, resetB

	# Get the $t1-th element of vectorB
	# Begin the sentence
	li	$v0, 4
	la	$a0, askElement
	syscall

	# printe the number of the element we're at (starting at 1)
	li	$v0, 1
	addu	$a0, $t1, 1
	syscall

	# Complete the request sentence
	li	$v0, 4
	la	$a0, ofVector
	syscall

	li	$v0, 4
	la	$a0, bb
	syscall

	# read the element
	li	$v0, 5
	syscall

	# store the element
	mul	$t1, $t1, 4
	sw	$v0, vectorB($t1)
	nop
	div	$t1, $t1, 4
	b	getVectorB
	addu	$t1, 1

resetB:
	li	$t1, 0
	li	$v0, 4
	la	$a0, lineBreak
	syscall

calculateProduct:
	beq	$t1, $t0, done

	# pointer = sizeof(word) * counter
	mul	$t1, $t1, 4
	lw	$t3, vectorA($t1)
	lw	$t4, vectorB($t1)
	nop

	# Calculate this step of the dot product
	mul	$t5, $t3, $t4
	addu	$t2, $t2, $t5

	div	$t1, $t1, 4
	b	calculateProduct
	addu	$t1, 1

done:
	# TODO: print the vectors
	li	$v0, 4
	la	$a0, dotProduct
	syscall

	li	$v0, 1
	move	$a0, $t2
	syscall

	li	$v0, 4
	la	$a0, period
	syscall

	li	$v0, 10
	syscall
