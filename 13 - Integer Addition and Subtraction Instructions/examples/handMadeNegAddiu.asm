## handMadeNeg.asm
##
## Program to demonstrate two's complement negative
##
## The program adds +146 to -82, leaving the result in $10

	.text
	.globl	main

main:
	ori	$7, $0,	146		# put +146 into $7
	addiu	$10, $7, -82		# (+146) + (-82)

## End of file
