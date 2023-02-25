# Declare an array of integers in the usual way:

	.data
size:	.word 8			# number of elements
	.word 1, 2, 3, 4, 5, 6, 9, 16

# Write a program that reverses the order of elements in the array. The result
# will be as if the array were declared:

# 	.data
# size: .word 7			# number of elements
# 	.word 7, 6, 5, 4, 3, 2, 1

# Test that the program works on arrays of several lengths, both even and
# odd lengths.

	.text
	.globl	main

# Register use
# $8  -> calculate displacement of backward pointer/flag for done
# $9  -> array length
# $11 -> forward pointer
# $12 -> backward pointer
# $13 -> first element
# $14 -> second element

main:
	# Initialize values
	lui	$11, 0x1000		# forward pointer
	lw	$9, 0($11)		# array length
	or	$12, $11, $0		# backward pointer = forward pointer
	addiu	$11, $11, 4		# point to first element of array
	sll	$8, $9, 2		# displacement for backward pointer
	addu	$12, $12, $8		# backwards pointer at correct position

loop:
	# Check if iteration is done; if the forward pointer has
	# reached or passed the backwards, we are (otherwise the
	# end result is the original array)
	slt	$8, $11, $12
	beq	$8, $0, done

	# Swap currently-pointed-at elements
	lw	$13, 0($11)
	lw	$14, 0($12)
	sw	$13, 0($12)
	sw	$14, 0($11)

	# Move pointers
	addiu	$11, $11, 4
	j	loop
	addiu	$12, $12, -4

done:
	sll	$0, $0, 0
