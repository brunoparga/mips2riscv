# Print a message stating whether two strings are equal.
#
# On entry
# $a0 -> 1 if strings are equal, 0 if not
#
# On exit
# No return value.

		.data
equal:		.asciiz		"The strings are equal!\n"
notEqual:	.asciiz		"The strings are not equal.\n"

		.text
		.globl	printResult

printResult:
	li	$v0, 4
	bnez	$a0, printEqual
	la	$a0, equal
	la	$a0, notEqual

printEqual:
	syscall

	jr	$ra
	nop
