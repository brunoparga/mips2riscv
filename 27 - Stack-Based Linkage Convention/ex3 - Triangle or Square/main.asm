# Ask if the user wants a triangle or a square. Prompt for the size of the
# object (the number of lines it takes to draw it). Writes a triangle or a square
# of stars ("*") to the monitor.
#
# *******
# *******
# *******
# *******
# *******
# *******
# *******
#
# or
#
# *
# **
# ***
# ****
# *****
# ******
# *******
#
# Write a subroutine for each figure.
# In them, use a subroutine starLine that writes a line of a given number
# of stars.

		.data
prompt:		.asciiz		"Do you want a triangle or a square? "
size:		.asciiz		"How many lines do you want it to take? "
error:		.asciiz		"\nPlease type 'triangle' or 'square'.\n"
answer:		.space		20

# Register use
# $s0 -> size of the figure

		.text
		.globl	main
main:
	subu	$sp, 4
	sw	$ra, 0($sp)

loop:
	# get figure from user
	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 8
	la	$a0, answer
	li	$a1, 20
	syscall

	# get size
	li	$v0, 4
	la	$a0, size
	syscall

	li	$v0, 5
	syscall

	move	$s0, $v0

triangle:
	la	$a0, answer
	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 't', square

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'r', square

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'i', square

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'a', square

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'n', square

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'g', square

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'l', square

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'e', square
	nop

	# The user wants a triangle
	move	$a0, $s0
	jal	drawTriangle
	nop

	j	return
	nop

square:
	la	$a0, answer
	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 's', handleError

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'q', handleError

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'u', handleError

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'a', handleError

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'r', handleError

	lb	$t0, 0($a0)
	addu	$a0, 1
	bne	$t0, 'e', handleError
	nop

	# The user wants a square
	move	$a0, $s0
	jal	drawSquare
	nop

	j	return
	nop

handleError:
	li	$v0, 4
	la	$a0, error
	j	loop
	syscall

return:
	lw	$ra, ($sp)
	addu	$sp, 4

	jr	$ra
	nop
