# Multiply three numbers. Assume the product fits within 32 bits.

# On entry:
#	$ra -> return address
#	$a0 -> first  number to multiply
#	$a1 -> second number to multiply
#	$a2 -> third  number to multiply

# On exit:
#	$v0 -> product of the three numbers

	.text
	.globl	multiplyThree

multiplyThree:
	mul	$t0, $a0, $a1
	jr	$ra
	mul	$v0, $t0, $a2
