## Start out a program with the instruction that puts a single one-bit into
## register one:

## ori   $1,$0,0x01

## Now, by using only shift instructions and register to register logic
## instructions, put the pattern 0xFFFFFFFF into register $1. Don't use another
## ori after the first. You will need to use more registers than $1. See how
## few instructions you can do this in. My program has 11 instructions.

	.text
	.globl	main

main:
	ori	$1, $0, 0x1		# $1 = 0x1
	nor	$1, $0, $0		# $1 = 0xFFFFFFFF

# EOF
