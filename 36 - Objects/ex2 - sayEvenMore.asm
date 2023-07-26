# Add several more subroutines that print out various words to the Full, Impractical,
# Program of the chapter. Put each new entry point into the jump table. Write a
# loop in the main program so that the entry points in the jump table are invoked
# in order, one per loop iteration.

		.globl		main
		.text
main:
	la	$t1, sub1add
loop:
	lw	$t0, 0($t1)	# get first entry point
	nop
	beqz	$t0, endMain
	nop
	jalr	$t0		# pass control if not done
	nop
	j	loop
	addu	$t1, 4

endMain:
	li	$v0, 10		# return to OS
	syscall

		.data
sub1add:	.word		sub1			# Jump Table
sub2add:	.word		sub2
sub3add:	.word		sub3
sub4add:	.word		sub4
sub5add:	.word		sub5
sub6add:	.word		sub6
endJTab:	.word		0

		.text
sub1:
	li	$v0, 4
	la	$a0, mess1
	syscall
	jr	$ra
	nop

		.data
mess1:		.asciiz	"Hello "

		.text
sub2:
	li	$v0, 4
	la	$a0, mess2
	syscall
	jr	$ra
	nop
		.data
mess2:		.asciiz	"Wonderful "

		.text
sub3:
	li	$v0, 4
	la	$a0, mess3
	syscall
	jr	$ra
	nop
		.data
mess3:		.asciiz	"World\n"
		.text
sub4:
	li	$v0, 4
	la	$a0, mess4
	syscall
	jr	$ra
	nop

		.data
mess4:		.asciiz	"How "

		.text
sub5:
	li	$v0, 4
	la	$a0, mess5
	syscall
	jr	$ra
	nop
		.data
mess5:		.asciiz	"are you "

		.text
sub6:
	li	$v0, 4
	la	$a0, mess6
	syscall
	jr	$ra
	nop
		.data
mess6:		.asciiz	"doing today?\n"
