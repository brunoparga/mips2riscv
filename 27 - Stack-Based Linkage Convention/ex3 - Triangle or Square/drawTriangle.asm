# Draw a triangle of stars. The height is given by the argument.
#
# On entry:
# $a0 -> the size of the triangle
#
# On exit:
# No return value.
#
# Register use:
# $s0 -> line width
# $s1 -> height (lines left to draw)

		.text
		.globl	drawTriangle
drawTriangle:
	subu	$sp, 4
	sw	$ra, 0($sp)

	subu	$sp, 4
	sw	$s0, 0($sp)

	subu	$sp, 4
	sw	$s1, 0($sp)

	li	$s0, 1
	move	$s1, $a0

loop:
	beqz	$s1, return
	nop

	move	$a0, $s0
	jal	starLine
	nop

	subu	$s1, 1
	addu	$s0, 1
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
