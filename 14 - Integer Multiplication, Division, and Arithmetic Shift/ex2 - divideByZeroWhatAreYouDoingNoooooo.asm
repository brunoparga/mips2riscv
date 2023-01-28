## Write a program similar to divEg.asm from the chapter to evaluate a rational
## function:

## (3x+7)/(2x+8)

## Verify that the program works by using several initial values for x. Use
## x = 0 and x = 1 to start since this will make debugging easy. Try some other
## values, then check what happens when x = -4.

## Register use:
##  $8		result
##  $9		x
##  $10		tmp

	.text
	.globl	main

main:
	addiu	$9, $0, -4		# $9 = x
	addiu	$8, $0, 3
	mult	$8, $9			# hilo = 3x
	mflo	$8			# result = 3x
	addiu	$8, $8, 7		# result = 3x + 7
	addiu	$10, $0, 2
	mult	$9, $10			# hilo = 2x
	mflo	$10			# tmp = 2x
	addiu	$10, $10, 8		# tmp = 2x + 8
	sll	$0, $0, 0		# nop
	div	$8, $10			# hi = (3x + 7) rem (2x + 8)
					# lo = (3x + 7) div (2x + 8)
	mflo	$8			# result = (3x + 7) div (2x + 8)
