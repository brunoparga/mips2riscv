# Declare an array of integers, something like:

        .data
size:   .word 8
array:  .word 23, -12, 45, -32, 52, -72, 8, 13

# Write a program that determines the minimum and the maximum element in the
# array. Assume that the array has at least one element (in which case, that
# element will be both the minimum and maximum.) Leave the results in registers.

	.text
	.globl	main

# Register use
# $8  -> base memory address
# $9  -> array length
# $10 -> counter
# $11 -> minimum element
# $12 -> maximum element
# $13 -> current array element
# $14 -> flag: element < currentMinimum
# $15 -> flag: currentMaximum < element

main:
	# Initialize values
	lui	$8, 0x1000
	lw	$9, 0($8)
	ori	$10, $0, 0
	ori	$11, $0, 0
	ori	$12, $0, 0

loop:
	# Check loop
	beq	$10, $9, done		# if (counter == arrayLength) { goto done }

	# Read element
	addiu	$8, $8, 4		# point to the next element of the array
	lw	$13, 0($8)		# read element
	addiu	$10, $10, 1		# counter++

	# Test element for maximum and minimum
	slt	$14, $13, $11		# element < currentMinimum
	bne	$14, $0, setMinimum	# if (element < currentMinimum) { goto setMinimum }
	slt	$15, $12, $13		# currentMaximum < element
	bne	$15, $0, setMaximum	# if (element >= currentMaximum) { goto setMaximum }

	# No need to set either value
	j	loop
	sll	$0, $0, 0		# nop

setMinimum:
	j	loop
	or	$11, $13, $0		# minimum = element

setMaximum:
	j	loop
	or	$12, $13, $0		# maximum = element

done:
	sll	$0, $0, 0		# nop
