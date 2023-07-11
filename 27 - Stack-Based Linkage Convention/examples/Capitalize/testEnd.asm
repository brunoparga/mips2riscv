# testEnd -- check if a line is 'Q'
#
# on entry:
#	$a0 -- address of input buffer
#
# on exit:
#	$v0 -- 0 if line is equal to 'Q', 1 if not

		.text
		.globl	testEnd
testEnd:
	# body
	li	$v0, 1		# assume not equal

	lbu	$t0, 0($a0)	# get first char of line
	li	$t1, 'Q'	# get 'Q'
	bne	$t0, $t1, endT	# if not equal, end the test
	nop

	lbu	$t0, 1($a0)	# get second char of line
	li	$t1, '\n'	# it should be CR
	bne	$t0, $t1, endT	# if not equal, end the test
	nop

	li	$v0, 0		# 'Q' has been found

endT:
	# epilog
	jr	$ra		# return to caller
	nop
