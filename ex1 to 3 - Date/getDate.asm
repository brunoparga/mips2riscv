# Store a user-provided day, month and year into the address of a struct,
# received as an argument

		.data
day:		.asciiz		"Please enter the day: "
month:		.asciiz		"Now enter the month: "
year:		.asciiz		"Finally, the year: "

		.text
		.globl		getDate
getDate:
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
	move	$s0, $a0	# save the address received as an argument

	li	$v0, 4
	la	$a0, day
	syscall

	li	$v0, 5
	syscall
	sw	$v0, 0($s0)	# save the day

	li	$v0, 4
	la	$a0, month
	syscall

	li	$v0, 5
	syscall
	sw	$v0, 4($s0)	# save the month

	li	$v0, 4
	la	$a0, year
	syscall

	li	$v0, 5
	syscall
	sw	$v0, 8($s0)	# save the year

	# epilog
	move	$v0, $s0	# return the same address as the argument
	lw	$s0, ($sp)
	addu	$sp, $sp, 4

	lw	$fp, ($sp)
	addu	$sp, $sp, 4

	lw	$ra, ($sp)
	addu	$sp, $sp, 4

	jr	$ra
	nop
