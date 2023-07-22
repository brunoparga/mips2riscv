# Prompt the user for one date, save it in memory

# On entry, $a0 holds the current iteration number, and $a1, the current
# date struct's address.

		.data
dateNo:		.asciiz		"Date number "

		.text
		.globl		copyDate
copyDate:
	# prolog
	subu	$sp, 4
	sw	$ra, ($sp)

	subu	$sp, 4
	sw	$fp, ($sp)

	subu	$sp, 4
	sw	$s0, ($sp)

	move	$t0, $a0
	move	$s0, $a1

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

	move	$a0, $s0
	jal	getDate
	nop

	lw	$t0, 0($v0)
	lw	$t1, 4($v0)
	sw	$t0, 0($s0)
	lw	$t2, 8($v0)
	sw	$t1, 4($s0)
	sw	$t2, 8($s0)	# Copy date to $t1

	# epilog
	lw	$s0, ($sp)
	addu	$sp, $sp, 4

	lw	$fp, ($sp)
	addu	$sp, $sp, 4

	lw	$ra, ($sp)
	addu	$sp, $sp, 4

	jr	$ra
	nop