##  Evaluate the expression:

##  17xy - 12x - 6y + 12

##  Use symbolic addresses x, y, and answer. Assume that the values are small
##  enough so that all results fit into 32 bits. Since load delays are turned on
##  in SPIM be careful what instructions are placed in the load delay slot.

##  Verify that the program works by using several initial values for x and y.
##  Use x=0, y=1 and x=1, y=0 to start since this will make debugging easy. Then
##  try some other values. As an option, follow the precaution for multiplication,
##  as above.

## Register use:
##  $8		x
##  $9		y
##  $10		base register
##  $11, $13	tmp
##  $12		result

	.text
	.globl	main

main:
	lui	$10, 0x1000		# the beginning of the data section
	lw	$8, 0($10)		# $8 = x
	lw	$9, 4($10)		# $9 = y
	sll	$0, $0, 0		# nop

	mult	$8, $9
	mflo	$12			# result = xy
	addiu	$11, $0, 17		# load xy coefficient
	addiu	$13, $0, -6		# y coefficient helps with x's and +12
	mult	$11, $12
	mflo	$12			# result = 17xy
	sll	$11, $13, 1		# tmp = -12 = x's coeff
	subu	$12, $12, $11		# result = 17xy + 12
	mult	$11, $8
	mflo	$11			# tmp = -12x
	addu	$12, $11, $12		# result = 17xy - 12x + 12
	sll	$0, $0, 0		# nop
	mult	$9, $13
	mflo	$13			# tmp = -6y
	addu	$12, $12, $13		# result = 17xy - 12x - 6y + 12

	sw	$12, 8($10)		# store result

	.data

x:		.word	1
y:		.word	1
result:		.word	0
