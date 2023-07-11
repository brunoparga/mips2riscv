# convert user input to capitals and discard punctuation

		.text
		.globl	main
main:
	# prolog
	sub	$sp, $sp, 4		# push the return address
	sw	$ra, ($sp)

	# body
	la	$a0, mainPr		# prompt the user
	li	$v0, 4			# service 4
	syscall

	jal	doLines			# process lines of input
	nop

	# epilog
	lw	$ra, ($sp)		# pop return address
	add	$sp, $sp, 4

	jr	$ra			# return to OS
	nop


		.data
mainPr:		.ascii	"Type each line of text followed by ENTER.\n"
		.asciiz "Type Q at the start of a line to finish.\n"
