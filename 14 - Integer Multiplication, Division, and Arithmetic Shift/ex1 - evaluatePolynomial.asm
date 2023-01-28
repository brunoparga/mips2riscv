## Write a program to evaluate a polynomial, similar to newMult.asm from the
## chapter. Evaluate the polynomial:

## 3x2 + 5x - 12

## Pick a register to contain x and initialize it to an integer value (positive
## or negative) at the beginning of the program. Assume that x is small enough
## so that all results remain in the lo result register. Evaluate the polynomial
## and leave its value in a register.

## Verify that the program works by using several initial values for x. Use x = 0
## and x = 1 to start since this will make debugging easy.

## Optional: write the program following the hardware rule that two or more
## instructions must follow a mflo instruction before another mult instruction.
## Try to put useful instructions in the two slots that follow the mflo.
## Otherwise put no-op instructions, sll $0,$0,0, in the two slots.

## Register use:
##  $8		result
##  $9		x
##  $10		tmp


	.text
	.globl	main

main:
	addiu	$8, $0, 3		# Horner's method - first coefficient
	addiu	$9, $0, -10		# $9 = x = 1
	mult	$8, $9			# hi, lo = 3x
	mflo	$8			# $8 = 3x
	addiu	$8, $8, 5		# $8 = 3x + 5 (second coefficient)
	addiu	$10, $0, -12		# $10 = third coefficient
	mult	$8, $9			# hi, lo = 3x2 + 5x
	mflo	$8			# $8 = 3x2 + 5x
	addu	$8, $8, $10		# $8 = 3x2 + 5x - 12
