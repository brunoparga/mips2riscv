# In this program data comes in pairs, say height and weight:

	.data

pairs:	.word 5			# number of pairs
	.word 60, 90		# first pair: height, weight
	.word 65, 105
	.word 72, 256
	.word 68, 270
	.word 62, 115

# Write a program that computes the average height and average weight. Leave the
# results in two registers.

	.text
	.globl	main

# Register use
# $8  -> base memory address
# $9  -> array length
# $10 -> counter
# $11 -> height accumulator
# $12 -> weight accumulator
# $13 -> current/average height
# $14 -> current/average weight

main:
	# Initialize values
	lui	$8, 0x1000
	lw	$9, 0($8)
	ori	$8, $8, 4
	ori	$10, $0, 0
	ori	$11, $0, 0
	ori	$12, $0, 0

loop:
	# Check if iteration is done
	beq	$10, $9, done
	addiu	$10, $10, 1

	# Load current height and weight
	lw	$13, 0($8)
	lw	$14, 4($8)

	# Add them to accumulators
	addu	$11, $11, $13
	addu	$12, $12, $14

	# Move pointer and iterate
	j	loop
	addiu	$8, $8, 8	# move pointer by two words

done:
	div	$11, $9
	mflo	$13
	sll	$0, $0, 0	# nop
	sll	$0, $0, 0	# nop
	div	$12, $9
	mflo	$14
