## Put the following bit pattern into register $1:
## DEADBEEF
## Use just three instructions.
##

	.text
	.globl	main

main:
	ori	$1, $0, 0xDEAD		# load the most significant nibble
	sll	$1, $1, 16		# move it to the right position
	ori	$1, $1, 0xBEEF		# load the least significant nibble

# EOF
