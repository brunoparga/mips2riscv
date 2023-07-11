# getLine -- read in a line of user input
#
# on entry:
#	$a0 -- address of input buffer
#	$a1 -- length of buffer
#
# on exit:
#	no return values

		.text
		.globl	getLine
getLine:
	# body
	move	$t0, $a0	# save buffer address
	la	$a0, prompt	# prompt the user
	li	$v0, 4		# service 4
	syscall

	move	$a0, $t0	# restore buffer address
	li	$v0, 8		# service 8
	syscall			# read in a line to the buffer

	# epilog
	jr	$ra		# return to caller
	nop


		.data
prompt:		.asciiz "> "
