# Read a string, when given a prompt
#
# On entry
# $a0 -> prompt for user
# $a1 -> where to save the string
#
# On exit
# $v0 -> address of the string

		.text
		.globl	read
read:
	li	$v0, 4
	syscall

	li	$v0, 8
	move	$a0, $a1
	li	$a1, 200
	syscall

	move	$v0, $a0
	jr	$ra
	nop
