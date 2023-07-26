# Add a third subroutine that prints "Wonderful" to the Full, Impractical,
# Program of the chapter (ass36_6.html). Add an entry to the jump table and a
# call to the new subroutine to the main routine of the program.

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

	lw	$t0, sub3add	# get second entry point
	nop
	jalr	$t0		# pass control
	nop

	li	$v0, 10		# return to OS
	syscall

		.data
sub1add:	.word		sub1			# Jump Table
sub2add:	.word		sub2
sub3add:	.word		sub3

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
	la	$a0, messF
	syscall
	jr	$ra
	nop
		.data
messF:		.asciiz	"Wonderful "

		.text
sub3:
	li	$v0, 4
	la	$a0, messW
	syscall
	jr	$ra
	nop
		.data
messW:		.asciiz	"World\n"
