# Declare an array of integers, something like:

        .data
size:   .word 10
array:  .word 2, 4, 7, 12, 34, 36, 42, 8, 57, 78

# Write a program that determines if the numbers form an increasing sequence
# where each integer is greater than the one to its left. If so, it sets a
# register to 1, otherwise it sets the register to 0.

# Of course, write the program to work with an array of any size, including 0.
# Arrays of size 0 and size 1 are considered to be ascending sequences. The array
# can contain elements that are positive, negative, or zero. Test the program
# on several sets of data.

	.text
	.globl	main

# Register use
# $8  -> base memory address
# $9  -> array length
# $10 -> counter
# $11 -> flag isAscending
# $12 -> flag isShort (length < 2)
# $13 -> current element
# $14 -> next element

main:
	# Initialize values
	lui	$8, 0x1000
	lw	$9, 0($8)
	ori	$10, $0, 0
	ori	$11, $0, 1		# by default, the array is ascending
	slti	$12, $9, 2		# isShort
	bne	$12, $0, done		# if (isShort) { goto done }

firstTwo:
	# If we get here, we know the length is at least 2.
	addiu	$8, $8, 4		# move the pointer
	lw	$13, 0($8)		# load the first element
	addiu	$8, $8, 4		# move the pointer
	lw	$14, 0($8)		# load the second element

loop:
	addiu	$10, $10, 1		# counter++
	beq	$10, $9, done
	addiu	$8, $8, 4		# move the pointer

	# If we reach this, we're not yet done
	slt	$11, $13, $14		# array[x] < array[x+1]

	# One element being <= the previous is enough for the whole thing to be false
	beq	$11, $0, done
	or	$13, $14, $0		# copy second element into first

	# We only need to do this if we're not yet done
	lw	$14, 0($8)		# load the next element
	j	loop			# jump to loop

done:
	sll	$0, $0, 0		# nop
