# Given the address of a linked list of strings, print its contents.

		.text
		.globl		printStringList

printStringList:
	move	$t0, $a0
loop:
	beqz	$t0, done	# while not null
	nop

	la	$a0, 4($t0)	#	get the data
	li	$v0, 4		#	print it
	syscall

	lw	$t0, 0($t0)	#	get next
	b	loop
	nop

done:
	jr	$ra
	nop
