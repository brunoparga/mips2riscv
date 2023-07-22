# Given the address of a linked list of integers, print its contents.

		.text
printList:
	subu	$sp, 4
	sw	$s0, ($sp)

	move	$s0, $a0
loop:
	beqz	$s0, done	# while not null
	nop

	lw	$a0, 0($s0)	#	get the data
	li	$v0, 1		#	print it
	syscall

	li	$a0, ' '
	li	$v0, 11
	syscall
	syscall			# print two spaces

	lw	$s0, 4($s0)	#	get next
	b	loop
	nop

done:
	li	$a0, '\n'
	li	$v0, 11
	syscall

	lw	$s0, ($sp)
	addu	$sp, 4

	move	$v0, $s0

	jr	$ra
	nop
