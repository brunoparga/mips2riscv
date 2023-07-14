# Calculate the N-th triangle number.

# Triangle( 1 ) = 1

# Triangle( N ) = N + Triangle( N-1 )

		.text
		.globl	triangle

triangle:
	# prolog
	sub	$sp, $sp, 4	#   1. Push return address
	sw	$ra, ($sp)
	sub	$sp, $sp, 4	#   2. Push caller's frame pointer
	sw	$fp, ($sp)
	sub	$sp, $sp, 4	#   3. Push S register
	sw	$s0, ($sp)
	sub	$fp, $sp, 4	#   4. $fp = $sp - space_for_variables
	move	$sp, $fp 	#   5. $sp = $fp

	# body
	sw	$a0, 0($fp)	# store argument N in variable
	lw	$s0, 0($fp)	# load variable
	nop
	bgt	$s0, 1, recurse
	nop			# if N <= 1, return 1
	j	epilog
	li	$v0, 1

recurse:
	lw	$s0, 0($fp)
	nop
	subu	$a0, $s0, 1	# argument for recursive call

	jal	triangle	# recurse
	nop

	addu	$v0, $v0, $s0	# triangle(N - 1) + N

epilog:
	# epilog
				#   1. Return value already set
	add	$sp, $fp, 4	#   2. $sp = $fp + space_for_variables
	lw	$s0, ($sp)	#   3. Pop S register
	add	$sp, $sp, 4
	lw	$fp, ($sp)	#   4. Pop $fp
	add	$sp, $sp, 4
	lw	$ra, ($sp)	#   5. Pop $ra
	add	$sp, $sp, 4
	jr	$ra     	# return to OS
	nop
