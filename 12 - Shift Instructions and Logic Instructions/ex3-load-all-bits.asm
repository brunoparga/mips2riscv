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
	ori	$1, $0, 0x1	# $1 = 0000 0000 0000 0000 0000 0000 0000 0001
	sll	$2, $1, 1	# $2 = 0000 0000 0000 0000 0000 0000 0000 0010
	or	$3, $2, $1	# $3 = 0000 0000 0000 0000 0000 0000 0000 0011
	sll	$2, $3, 2	# $2 = 0000 0000 0000 0000 0000 0000 0000 1100
	or	$3, $3, $2	# $3 = 0000 0000 0000 0000 0000 0000 0000 1111
	sll	$2, $3, 4	# $2 = 0000 0000 0000 0000 0000 0000 1111 0000
	or	$3, $3, $2	# $3 = 0000 0000 0000 0000 0000 0000 1111 1111
	sll	$2, $3, 8	# $2 = 0000 0000 0000 0000 1111 1111 0000 0000
	or	$3, $3, $2	# $3 = 0000 0000 0000 0000 1111 1111 1111 1111
	sll	$2, $3, 16	# $2 = 1111 1111 1111 1111 0000 0000 0000 0000
	or	$1, $3, $2	# $1 = 1111 1111 1111 1111 1111 1111 1111 1111

# EOF
