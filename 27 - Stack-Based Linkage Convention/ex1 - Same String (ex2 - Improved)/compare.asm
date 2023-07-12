# Compare two strings. Return 1 if they are character-by-character the same,
# return 0 otherwise. The strings must have the same length to be equal.
#
# On entry
# $a0 -> first string to compare
# $a1 -> second string to compare
#
# On exit
# $v0 -> 1 if strings are equal, 0 otherwise.
#
# Register use
# $t0 -> first string character
# $t1 -> second string character

		.text
		.globl	compare
compare:
	li	$v0, 1			# Strings are equal by default

loop:
	lb	$t0, 0($a0)
	lb	$t1, 0($a1)
	addu	$a0, 1
	addu	$a1, 1
	bne	$t0, $t1, notEqual
	nop
	beqz	$t0, return		# we know chars are equal
	nop				# so test only one for end of string
	j	loop
	nop

notEqual:
	li	$v0, 0

return:
	jr	$ra
	nop
