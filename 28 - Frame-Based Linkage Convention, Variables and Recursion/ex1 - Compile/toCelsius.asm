# int toCelsius( int x )
# {
#   int v;		// 0($fp)
#   v =  x - 32;
#   v =  5*v
#   v =  v/9;
#   return v;
# }

		.text
		.globl	toCelsius	# int toCelsius( int x ) // just the function name

toCelsius:	# {
	# Prolog instructions without C correspondence
	subu	$sp, 4
	sw	$ra, ($sp)		# push return address

	subu	$sp, 4
	sw	$fp, ($sp)		# push the caller frame pointer

	subu	$fp, $sp, 4		# make space for one int variable
	move	$sp, $fp		# stack pointer = frame pointer

	# body
					#   int v;		// 0($fp)
	subu	$t0, $a0, 32		# calculate x - 32
	sw	$t0, 0($fp)		#   v = x - 32;

	lw	$t1, 0($fp)
	li	$t0, 5
	mul	$t1, $t0, $t1		# calculate 5*v
	sw	$t1, 0($fp)		#   v = 5*v;

	lw	$t2, 0($fp)
	li	$t0, 9
	div	$t2, $t0		# calculate v/9
	mflo	$t2
	sw	$t2, 0($fp)		#   v = v/9;


	# epilog - undo what the prolog did
	lw	$v0, 0($fp)		# return v;
	addu	$sp, $fp, 4		# erase this frame from the stack
	lw	$fp, ($sp)		# restore the frame pointer
	addu	$sp, 4
	lw	$ra, ($sp)		# pop the return address
	addu	$sp, 4

	jr	$ra
	nop				# }
