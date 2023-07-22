# Print a date structure in ISO 8601 format

		.data
date:		.asciiz		"Date: "

		.text
		.globl		printDate
printDate:
	# prolog
	subu	$sp, 4
	sw	$ra, ($sp)	# store the return address...

	subu	$sp, 4
	sw	$fp, ($sp)	# ... the stack frame...

	subu	$sp, 4
	sw	$s0, ($sp)	# ...and a saved register we need.
				# If there were local variables, we'd make up
				# space for them by moving the frame pointer
				# and then setting $sp = $fp.

	# body
	move	$s0, $a0	# store address of date argument

	li	$v0, 4
	la	$a0, date
	syscall

	lw	$a0, 8($s0)	# year
	li	$v0, 1		# print integer service
	syscall

	li	$v0, 11
	li	$a0, '-'
	syscall

	lw	$a0, 4($s0)	# month
	li	$v0, 1
	syscall

	li	$v0, 11
	li	$a0, '-'
	syscall

	lw	$a0, 0($s0)	# day
	li	$v0, 1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	# epilog
	lw	$s0, ($sp)
	addu	$sp, $sp, 4

	lw	$fp, ($sp)
	addu	$sp, $sp, 4

	lw	$ra, ($sp)
	addu	$sp, $sp, 4

	jr	$ra
	nop
