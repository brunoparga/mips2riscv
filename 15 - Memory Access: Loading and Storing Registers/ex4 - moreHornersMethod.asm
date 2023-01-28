##  Evaluate the following polynomial using Horner's method:

##  ax3 + bx2 + cx + d

##  Now the values for the coefficients a, b, c, d as well as for x come from the
##  .data section of memory:

	.data

x:		.word	1
a:		.word	-3
b:		.word	3
c:		.word	9
d:		.word   -24
result:		.word	0

##  Load a base register with the address of the first byte of the .data section.
##  Calculate (by hand) the displacement needed for each of the values in memory
##  and use it with a lw instruction to get values from memory. In a later chapter
##  you will find a much more convenient way to load and store values using
##  symbolic addresses. But don't do this now.

##  Register use:
##  $8  - result
##  $9  - x
##  $10 - base register
##  $11 - coefficients

	.text
	.globl	main

main:
	lui	$10, 0x1000
	lw	$9, 0($10)		##  $9  = x
	lw	$8, 4($10)		##  $8  = a (will accumulate result)
	lw	$11, 8($10)		##  $11 = b

	mult	$8, $9
	mflo	$8			##  $8  = ax
	addu	$8, $8, $11		##  $8  = ax + b
	lw	$11, 12($10)		##  $11 = c

	mult	$8, $9
	mflo	$8			##  $8  = ax2 + bx
	addu	$8, $8, $11		##  $8  = ax2 + bx + c
	lw	$11, 16($10)		##  $11 = d

	mult	$8, $9
	mflo	$8			##  $8  = ax3 + bx2 + cx
	addu	$8, $8, $11		##  $8  = ax3 + bx2 + cx + d

	sw	$8, 20($10)
