# Copy the final program of the chapter, linked.asm. Modify it so that instead
# of printing the elements of the linked list it adds them all together. Upon
# reaching the end of the list it prints out the sum.

		.data
head:
elmnt01:	.word		2
		.word		elmnt02

elmnt02:	.word		3
		.word		elmnt03

elmnt03:	.word		5
		.word		elmnt04

elmnt04:	.word		7
		.word		elmnt05

elmnt05:	.word		11
		.word		elmnt06

elmnt06:	.word		13
		.word		elmnt07

elmnt07:	.word		17
		.word		elmnt08

elmnt08:	.word		19
		.word		0

sumIs:		.asciiz 	"The sum is: "

		.text
		.globl		main

main:
	la	$s0, head	# get pointer to head
	li	$t0, 0		# initialize sum

loop:
	beqz	$s0, done	# while not null
	nop

	lw	$t1, 0($s0)	#	get the data
	nop
	add	$t0, $t0, $t1

	lw	$s0, 4($s0)	#	get next
	b	loop
	nop

done:
	li	$v0, 4
	la	$a0, sumIs
	syscall

	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	li	$v0, 10	 	# return to OS
	syscall
