## Modify exercise 1 of the previous chapter so that the value x is in memory.
## Store the value of the polynomial back to memory. The program will be similar
## to poly.asm from this chapter. Evaluate the polynomial:

## 3x2 + 5x - 12

## Use symbolic addresses x and poly. Assume that the value in x is small enough
## so that all results fit into 32 bits. Since load delays are turned on in SPIM
## be careful what instructions are placed in the load delay slot.

## Verify that the program works by using several initial values for x. Use
## x = 0 and x = 1 to start since this will make debugging easy. Then try some
## other values, such as x = 10 and x = -1.

## Optional: write the program following the hardware rule that two or more
## instructions must follow a mflo instruction before another mult instruction.
## Try to put useful instructions in the two slots that follow the mflo.

## Register use:
##  $8		result
##  $9		x
##  $10		base register
##  $11		tmp

	.text
	.globl	main

main:
	lui	$10, 0x1000		# the beginning of the data section
	lw	$9, 0($10)		# $9 = x

	addiu	$8, $0, 3		# First coefficient
	mult	$8, $9			# hi, lo = 3x
	mflo	$8			# $8 = 3x

	addiu	$8, $8, 5		# $8 = 3x + 5 (second coefficient)
	addiu	$11, $0, -12		# $11 = third coefficient
	mult	$8, $9			# hi, lo = 3x2 + 5x
	mflo	$8			# $8 = 3x2 + 5x
	addu	$8, $8, $11		# $8 = 3x2 + 5x - 12

	sw	$8, 4($10)		# store result in `poly`

	.data

x:	.word	2
poly:	.word	0
