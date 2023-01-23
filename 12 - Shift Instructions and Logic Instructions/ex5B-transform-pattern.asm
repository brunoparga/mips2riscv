# Put the bit pattern 0x0000FACE into register $1. This is just an example
# pattern; assume that $1 can start out with any pattern at all in the low 16
# bits (but assume that the high 16 bits are all zero).

# Now, using only register-to-register logic and shift instructions, rearrange
# the bit pattern so that register $2 gets the bit pattern 0x0000CAFE.

# Write this program so that after the low 16 bits of $1 have been set up with
# any bit pattern, no matter what bit pattern it is, the nibbles in $2 are the
# same rearrangement of the nibbles of $1 shown with the example pattern. For
# example, if $1 starts out with 0x00003210 it will end up with the pattern
# 0x00001230

# B. Somewhat Harder program: Use only and, or, and rotate instructions.

	.text
	.globl	main

main:
	ori	$1, $0, 0xFACE		# load a bit pattern

	ori	$2, $0, 0x00F0		# mask for 2nd-least significant nibble
	ori	$3, $0, 0x0F0F		# mask to clear up nibbles 2 and 4 in $1
	ori	$4, $0, 0xF000		# mask for 4th-least significant nibble

	and	$2, $1, $2		# $2 holds 2nd nibble
	sll	$2, $2, 8		# $2 holds 2nd nibble in 4th position
	and	$4, $1, $4		# $4 holds 4th nibble
	srl	$4, $4, 8		# $4 holds 4th nibble in 2nd position

	and	$1, $1, $3		# $1 = 0x0A0E	(clear up)
	or	$1, $1, $2		# $1 = 0xCA0E	(nibble 2 -> 4)
	or	$1, $1, $4		# $1 = 0xCAFE	(nibble 4 -> 2)

# EOF
