##  Evaluate the polynomial:

##  6x3 - 3x2 + 7x + 2

##  Get the value for x from symbolic addresses x. Store the result at symbolic
##  address poly. Assume that the values are small enough so that all results fit
##  into 32 bits. Since load delays are turned on in SPIM be careful what
##  instructions are placed in the load delay slot.

##  Evaluate the polynomial by using Horner's Method. This is a way of building up
##  values until the final value is reached. First, pick a register, say $7, to
##  act as an accumulator. The accumulator will hold the value at each step. Use
##  other registers to help build up the value at each step.

##  Verify that the program works by using several initial values for x. Use x=1
##  and x=-1 to start since this will make debugging easy. Then try some other
##  values. As an option, follow the precaution for multiplication.

##  Register use:
##  $8  - accumulator/result
##  $9  - x
##  $10 - base register
##  $11 - tmp


	.text
	.globl	main

main:
	lui	$10, 0x1000
	lw	$9, 0($10)		##  $9 = x
	ori	$8, $0, 6		##  result = 6

	mult	$8, $9
	mflo	$8			##  result = 6x
	addiu	$8, $8, -3		##  result = 6x - 3
	ori	$11, $0, 2		##  tmp = 2 (isolated coefficient)

	mult	$8, $9
	mflo	$8			##  result = 6x2 - 3x
	addiu	$8, $8, 7		##  result = 6x2 - 3x + 7
	sll	$0, $0, 0		##  nop

	mult	$8, $9
	mflo	$8			##  result = 6x3 - 3x2 + 7x
	addu	$8, $8, $11		##  result = 6x3 - 3x2 + 7x + 2

	sw	$8, 4($10)


	.data

x:	.word	-1
poly:	.word	0			##  should be fffffff2
