		.globl		main
		.text
main:

	lw	$t0, sub1add	# get first entry point
	nop
	jalr	$t0		# pass control
	nop

	lw	$t0, sub2add	# get second entry point
	nop
	jalr	$t0		# pass control
	nop

	li	$v0, 10		# return to OS
	syscall

		.data
sub1add:	.word		sub1			# Jump Table
sub2add:	.word		sub2

		.text
sub1:
	li	$v0, 4
	la	$a0, messH
	syscall
	jr	$ra
	nop

		.data
messH:		.asciiz	"Hello "

		.text
sub2:
	li	$v0, 4
	la	$a0, messW
	syscall
	jr	$ra
	nop
		.data
messW:		.asciiz	"World\n"
