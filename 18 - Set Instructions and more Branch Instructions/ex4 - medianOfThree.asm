# Write a program that computes the median of three values in memory. After it
# has been found, store the median in memory.

# 	.data
# A:	.word		23
# B:	.word		98
# C:	.word		17

# The median of three integers is greater than or equal to one integer and less
# than or equal to the other. With the above three integers the median is "23".
# Assume that the data changes from run to run. Here is some more possible data:

	.data
A:	.word		8
B:	.word		10
C:	.word		9

# Register use:
# $7  -> compare A and B
# $8  -> A < C
# $9  -> B < C
# $10 -> base register for memory loading
# $11 -> A, first of the three numbers
# $12 -> B, second of the three numbers
# $13 -> C, third of the three numbers
# $14 -> median
# $15 -> used to XOR two comparisons

	.text
	.globl	main

main:
	lui	$10, 0x1000
	lw	$11, 0($10)		# load A
	lw	$12, 4($10)		# load B
	lw	$13, 8($10)		# load C

	# Test which of the numbers are smaller than the others
	slt	$7, $11, $12		# $7 = A < B
	slt	$8, $11, $13		# $8 = A < C

	# test if A is the median.
	# That is the case iff A < B XOR A < C.
	xor	$15, $7, $8		# aIsTheMedian = A < B XOR A < C
	bne	$15, $0, save		# if aIsTheMedian then goto save
	or	$14, $11, $0		# median = A

	# Now test if B is the median.
	# That is the case iff B <= A XOR B < C.
	xori	$7, $7, 0x1		# flip the flag for A < B
	slt	$9, $12, $13		# $9 = B < C
	xor	$15, $7, $9		# bIsTheMedian = B <= A XOR B < C
	bne	$15, $0, save		# if bIsTheMedian then goto save
	or	$14, $12, $0		# median = B

	# If we reach this point, then C is the median
	or	$14, $13, $0		# median = C

save:
	# store median at memory address 0x1000000C
	sw	$14, 12($10)
