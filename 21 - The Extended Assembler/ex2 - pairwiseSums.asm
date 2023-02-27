# Declare three arrays, each of the same size:

	.data
size:	.word	7
array1:	.word	-30, -23, 56, -43, 72, -18, 71
array2:	.word	45,  23, 21, -23, -82,  0, 69
result:	.word	0,   0,  0,   0,   0,  0,  0

# Initialize a base register for each array (use the la instruction.) Now
# implement a loop that adds corresponding elements in the first two arrays and
# stores the result in the corresponding element of the result array. Do this
# by moving each of the three base registers to its next array element after
# each addition.

	.text
	.globl		main

# Register use:
# $t0 -> array length
# $t1 -> pointer to array1
# $t2 -> pointer to array2
# $t3 -> pointer to result
# $t4 -> counter
# $t5 -> element 1
# $t6 -> element 2
# $t7 -> sum

main:
	# Initialize length, counter, pointers
	lw	$t0, size
	la	$t1, array1
	la	$t2, array2
	la	$t3, result
	li	$t4, 0

loop:
	beq	$t4, $t0, done		# Done if array traversed

	# Load integers
	lw	$t5, 0($t1)
	lw	$t6, 0($t2)

	addiu	$t4, $t4, 1		# counter++ in load delay slot
	addu	$t7, $t5, $t6		# add integers

	# Move pointers; store sum before moving its pointer
	addiu	$t1, $t1, 4
	addiu	$t2, $t2, 4
	sw	$t7, 0($t3)
	j	loop
	addiu	$t3, $t3, 4

done:
	nop