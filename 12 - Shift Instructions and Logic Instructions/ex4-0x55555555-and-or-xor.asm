	.text
	.globl	main

main:
## Put the bit pattern 0x55555555 in register $1. (Do this with 3 instructions.)
	ori	$1, $0, 0x5555		# $1 = 0x5555
	sll	$2, $1, 16		# $2 = 0x55550000
	or	$1, $1, $2		# $1 = 0x55555555

## Now shift the pattern left 1 position into register $2 (leave $1 unchanged).
	sll	$2, $1, 1		# $2 = 0xAAAAAAAA

# Put the the bit-wise OR of $1 and $2 into register $3.
	or	$3, $1, $2		# $3 = 0xFFFFFFFF

# Put the the bit-wise AND of $1 and $2 into register $4.
	and	$4, $1, $2		# $4 = 0x00000000

# Put the the bit-wise XOR of $1 and $2 into # register $5.
	xor	$5, $1, $2		# $5 = 0xFFFFFFFF

# Examine the results.
# EOF
