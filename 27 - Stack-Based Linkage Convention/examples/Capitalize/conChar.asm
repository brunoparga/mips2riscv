# conChar -- convert a character to a capital
#
# on entry:
#	$a0 -- character
#
# on exit:
#	$v0 -- converted character

		.text
		.globl	conChar
conChar:
	# body
	move	$v0, $a0		# assume ch will not change

	# is ch in 'a' .. 'z'?
	li	$t0, 'a'		# ch < 'a' ?
	blt	$a0, $t0, outc
	nop
	li	$t0, 'z'		# 'z' < ch ?
	blt	$t0, $a0, outc
	nop
	sub	$v0, $a0, 0x20		# convert ch to upper case

outc:
	# epilog
	jr	$ra			# return to caller
	nop
