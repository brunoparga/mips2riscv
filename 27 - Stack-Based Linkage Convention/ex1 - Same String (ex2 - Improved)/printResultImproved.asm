# Print a message stating whether two strings are equal.
#
# On entry
# $a0 -> first string
# $a1 -> second string
#
# On exit
# No return value.

		.data
output:		.space	200

		.text
		.globl	printResultImproved

printResultImproved:
	la	$t3, output

loop:
	lb	$t0, 0($a0)
	lb	$t1, 0($a1)
	beqz	$t0, print
	nop
	beqz	$t1, print
	nop
	beq	$t0, $t1, equal
	nop
	bne	$t0, $t1, notEqual

continue:
	addu	$a0, 1
	addu	$a1, 1
	sb	$t2, 0($t3)
	j	loop
	addu	$t3, 1

equal:
	j	continue
	li	$t2, ' '

notEqual:
	j	continue
	li	$t2, '*'

print:
	li	$v0, 4
	la	$a0, output
	syscall

return:
	jr	$ra
	nop
