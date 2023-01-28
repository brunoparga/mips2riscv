## Write a program that determines the value of the following expression:

## (x*y)/z

## Use x = 1600000 (=0x186A00), y = 80000 (=0x13880), and z = 400000 (=61A80).
## Initialize three registers to these values. Since the immediate operand of
## the ori instruction is only 16 bits wide, use shift instructions to move bits
## into the correct locations of the registers.

## Choose wisely the order of multiply and divide operations so that the
## significant bits always remain in the lo result register.

## Register use
##  $8		x, result
##  $9		y
##  $10		z

	.text
	.globl	main

main:
	ori	$9, $0, 0x1388
	sll	$9, $9, 4		# $9  = 0x00013880	(17 sb)
	sll	$10, $9, 2
	addu	$10, $9, $10		# $10 = 0x00061A80	(19 sb)
	sll	$8, $10, 2		# $8  = 0x00186A00	(21 sb)

	div	$8, $10			# hi, lo = x / z = 0, 4
	mflo	$8
	sll	$0, $0, 0		# nop
	sll	$0, $0, 0		# nop
	mult	$8, $9
	mflo	$8
