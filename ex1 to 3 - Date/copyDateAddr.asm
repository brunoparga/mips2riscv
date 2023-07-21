# Prompt the user for one date, save it in memory

# On entry, $a0 holds the current iteration number, and $a1, the current
# date struct pointer's address.

		.data
dateNo:		.asciiz		"Date number "

		.text
		.globl		copyDate
copyDateAddr:
	# prolog
	subu	$sp, 4
	sw	$ra, ($sp)

	subu	$sp, 4
	sw	$fp, ($sp)

	subu	$sp, 4
	sw	$s0, ($sp)

	move	$t0, $a0

	# body
	li	$v0, 4
	la	$a0, dateNo
	syscall

	li	$v0, 1
	addu	$a0, $t0, 1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	li	$v0, 9
	li	$a0, 12
	syscall

	move	$s0, $v0
	sw	$s0, 0($a1)	# pointer points to beginning of struct
	move	$a0, $s0
	jal	getDate
	nop

	# epilog
	lw	$s0, ($sp)
	addu	$sp, $sp, 4

	lw	$fp, ($sp)
	addu	$sp, $sp, 4

	lw	$ra, ($sp)
	addu	$sp, $sp, 4

	jr	$ra
	nop