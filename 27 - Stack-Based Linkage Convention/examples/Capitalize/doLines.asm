# doLines -- read in and process each line of user input
#
# on exit:
#	no return values

		.text
		.globl	doLines
doLines:
	# prolog
	sub	$sp, $sp, 4	# push the return address
	sw	$ra, ($sp)

	# body
loop:
	# get a line
	la	$a0, line	# argument: address of buffer
	li	$a1, 132	# argument: length of buffer
	jal	getLine		# get line from user
	nop

	# if line is"Q", return to caller
	la	$a0, line
	jal	testEnd
	nop
	beqz	$v0, endloop
	nop

	# convert to capitals
	la	$a0, line	# argument: address of buffer
	la	$a1, 132	# argument: length of buffer
	jal	convert
	nop

	# print out the result and loop
	la	$a0, outline
	li	$v0, 4
	b	loop
	syscall

endloop:
	# epilog
	lw	$ra, ($sp)	# pop return address
	add	$sp, $sp, 4
	jr	$ra		# return to caller
	nop

		.data
outline:	.ascii	"  "	# padding so output lines up with input
line:		.space	132	# input buffer
