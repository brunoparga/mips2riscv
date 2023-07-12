# Draw a square of stars. The size is given by the argument.
#
# On entry:
# $a0 -> the size of the square
#
# On exit:
# No return value.
#
# Register use:
# $s0 -> width of the square
# $s1 -> height of the square (lines left to draw)

		.text
		.globl	drawSquare
drawSquare:
	subu	$sp, 4
	sw	$ra, 0($sp)

	subu	$sp, 4
	sw	$s0, 0($sp)

	subu	$sp, 4
	sw	$s1, 0($sp)

	move	$s0, $a0
	move	$s1, $a0

loop:
	beqz	$s1, return
	nop

	move	$a0, $s0
	jal	starLine
	nop

	subu	$s1, 1
	j	loop
	nop

return:
	lw	$s1, ($sp)
	addu	$sp, 4

	lw	$s0, ($sp)
	addu	$sp, 4

	lw	$ra, ($sp)
	addu	$sp, 4

	jr	$ra
	nop
