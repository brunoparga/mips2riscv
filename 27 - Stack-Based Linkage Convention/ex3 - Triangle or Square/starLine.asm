# Draw a line of n stars, where n is the argument.
#
# On entry:
# $a0 -> the number of stars to draw.
#
# On exit:
# No return value.

		.data
star:		.asciiz		"*"
newLine:	.asciiz		"\n"

# Register use:
# $t0 -> counter

		.text
		.globl	starLine
starLine:
	subu	$sp, 4
	sw	$ra, 0($sp)

	move	$t0, $a0
	li	$v0, 4
	la	$a0, star

loop:
	beqz	$t0, return
	subu	$t0, 1
	j	loop
	syscall

return:
	la	$a0, newLine
	syscall

	lw	$ra, ($sp)
	addu	$sp, 4

	jr	$ra
	nop

