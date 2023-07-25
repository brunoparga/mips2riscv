		.text
		.globl		compareStrings
		.globl		copyString

epilog:
	jr	$ra
	nop

# Compare two strings. Return 1 if they are of the same length and character-by-
# -character equal, 0 otherwise.
compareStrings:
compareLoop:
	lb	$t0, 0($a0)
	lb	$t1, 0($a1)
	nop
	bne	$t0, $t1, notEqual
	nop
	beqz	$t0, equal
	addu	$a0, 1
	j	compareLoop
	addu	$a1, 1

equal:
	j	epilog
	li	$v0, 1

notEqual:
	j	epilog
	li	$v0, 0

# Copy string from $a0 to $a1. Return the length of the string.
copyString:
	li	$v0, 0		# return the length of the string

copyLoop:
	lb	$t0, 0($a0)
	addu	$a0, 1		# advance the load pointer
	beqz	$t0, epilog
	sb	$t0, 0($a1)
	addu	$a1, 1		# and the store pointer
	j	copyLoop
	addu	$v0, 1		# increment string length
