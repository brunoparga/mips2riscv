# convert -- convert a line to all capitals
#
# on entry:
#	$a0 -- address of input buffer
#	$a1 -- length of input buffer
#
# register use:
#	$s0 -- pointer into character buffer
#
# on exit:
#	no return values

		.text
		.globl	convert
convert:
	# prolog
	sub	$sp, $sp, 4	# push the return address
	sw	$ra, ($sp)
	sub	$sp, $sp, 4	# push $s0
	sw	$s0, ($sp)

	# body

	# for (p = buffer; *p!=0; p++)
	move	$s0, $a0	# p = buffer

loop:
	lbu	$a0, ($s0)	# get a char from the string
	nop
	beqz	$a0, endC	# exit if null byte
	nop

	# argument a0: char to convert
	jal	conChar		# convert character
	nop
	sb	$v0, ($s0)	# put converted char into string
	b	loop
	addu	$s0, $s0, 1	# p++

endC:
	# epilog
	lw	$s0, ($sp)	# pop $s0
	add	$sp, $sp, 4
	lw	$ra, ($sp)	# pop return address
	add	$sp, $sp, 4
	jr	$ra		# return to caller
	nop
