##  Your program has a data section declared as follows:

      .data
      .byte   12
      .byte   97
      .byte  133
      .byte   82
      .byte  236

##  Write a program that adds the values up, computes the average, and stores the
##  result in a memory location. Is the average correct?
##  Hint: there are two easily-made errors in this program.

##  Register use
##  $8  - accumulator, average
##  $9  - integer load register
##  $10 - base register
##  $11 - count


	.text
	.globl	main

main:
	lui	$10, 0x1000		##  Set base register

	lbu	$9, 0($10)		##  Load zero-padded byte 0
	addiu	$11, $0, 1		##  count++
	addu	$8, $8, $9		##  $8 = a0

	lbu	$9, 1($10)		##  Load zero-padded byte 1
	addiu	$11, $11, 1		##  count++
	addu	$8, $8, $9		##  $8 = a0 + a1

	lbu	$9, 2($10)		##  Load zero-padded byte 2
	addiu	$11, $11, 1		##  count++
	addu	$8, $8, $9		##  $8 = a0 + a1 + a2

	lbu	$9, 3($10)		##  Load zero-padded byte 3
	addiu	$11, $11, 1		##  count++
	addu	$8, $8, $9		##  $8 = a0 + a1 + a2 + a3

	lbu	$9, 4($10)		##  Load zero-padded byte 4
	addiu	$11, $11, 1		##  count++
	addu	$8, $8, $9		##  $8 = a0 + a1 + a2 + a3 + a4

	divu	$8, $11			##  lo = integers // count
	mflo	$8			##  $8 = average
	sb	$8, 5($10)		##  store the average
